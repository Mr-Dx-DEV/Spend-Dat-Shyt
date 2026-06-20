function normalizeVrpCharId(charId) {
  const id = Number(charId);
  return Number.isFinite(id) ? id : null;
}

function vrpIdentityName(identity) {
  if (!identity) return '';
  return `${identity.firstname || ''} ${identity.name || ''}`.trim();
}

function vrpLicenseFromIdentifiers(identifiers) {
  return identifiers.find((identifier) => typeof identifier === 'string' && identifier.startsWith('license:')) || '';
}

async function getVrpCharacter(charId) {
  const id = normalizeVrpCharId(charId);
  if (id === null) return null;
  return await oxmysql.single('SELECT id, user_id FROM vrp_characters WHERE id = ? LIMIT 1', [id]);
}

async function getVrpIdentifiersByUserId(userId) {
  if (!userId) return [];
  const rows = await oxmysql.query('SELECT identifier FROM vrp_user_ids WHERE user_id = ?', [userId]);
  return rows.map((row) => row.identifier).filter((identifier) => typeof identifier === 'string');
}

async function getVrpIdentity(charId) {
  const id = normalizeVrpCharId(charId);
  if (id === null) return null;
  return await oxmysql.single('SELECT * FROM vrp_character_identities WHERE character_id = ? LIMIT 1', [id]);
}

module.exports = {
  // ---------------------------------------------------------------------------
  // Player
  // ---------------------------------------------------------------------------

  /**
   * Fetches a single player row by their charId.
   * @param {string} charId
   * @returns {Promise<any>}
   */
  async getPlayer(charId) {
    if (Framework.name === 'vrp') {
      return await getVrpCharacter(charId);
    }

    return await oxmysql.scalar('SELECT * FROM players WHERE charId = ?', [charId]);
  },

  /**
   * Returns raw retention timestamps for every player in the database.
   * ESX reads from the `users` table; QB/QBX reads from `luxu_stats_player_retention`.
   * @returns {Promise<{ timestamp: number }[]>}
   */
  async getPlayerRetention() {
    if (Framework.name === 'esx') {
      return /** @type {{ timestamp: number }[]} */ (await oxmysql.query('SELECT * FROM users'));
    }
    if (Framework.name === 'vrp') {
      return [];
    }
    return /** @type {{ timestamp: number }[]} */ (await oxmysql.query('SELECT * FROM luxu_stats_player_retention'));
  },

  /**
   * Retrieves the saved clothing/skin data for a player.
   * ESX reads `skin` from `users`; QB/QBX reads from `playerskins`.
   * @param {string} charId
   * @returns {Promise<Record<string, any>>}
   */
  async getPlayerClothing(charId) {
    const ESX_QUERY = `SELECT skin FROM users WHERE identifier = ?`;
    const QB_QUERY = `SELECT skin FROM playerskins WHERE citizenid = ? AND active = ?`;

    try {
      if (Framework.name === 'esx') {
        const result = await oxmysql.single(ESX_QUERY, [charId]);
        if (result) return JSON.parse(result.skin);
      }
      if (Framework.name === 'qb' || Framework.name === 'qbx') {
        const result = await oxmysql.single(QB_QUERY, [charId, 1]);
        if (result) return JSON.parse(result.skin);
      }
      if (Framework.name === 'vrp') {
        const details = await Luxu.vrp2.getOfflineCharacterDetails(charId);
        return details?.customization ?? {};
      }
      return {};
    } catch {
      return {};
    }
  },

  // ---------------------------------------------------------------------------
  // Vehicles
  // ---------------------------------------------------------------------------

  /**
   * Returns all vehicles of a given model hash, with their owner's charId.
   * ESX reads from `owned_vehicles`; QB/QBX reads from `player_vehicles`.
   * @param {number} modelHash
   * @returns {Promise<{ plate: string, char_id: string }[]>}
   */
  async getVehicleOwners(modelHash) {
    if (Framework.name === 'esx') {
      return await oxmysql.query(
        'SELECT plate, owner as char_id FROM owned_vehicles WHERE CAST(JSON_UNQUOTE(JSON_EXTRACT(vehicle, "$.model")) AS SIGNED) = ?',
        [modelHash]
      );
    }
    if (Framework.name === 'vrp') {
      const rows = await oxmysql.query('SELECT id FROM vrp_characters');
      const result = [];
      for (const row of rows) {
        const vehicles = await Luxu.garage.getOwnedVehicles(String(row.id));
        for (const vehicle of vehicles) {
          if (GetHashKey(String(vehicle.model)) === modelHash) {
            result.push({ plate: vehicle.plate, char_id: String(row.id) });
          }
        }
      }
      return result;
    }
    return await oxmysql.query(
      'SELECT pv.plate as plate, pv.citizenid as char_id FROM player_vehicles pv WHERE pv.hash = ?',
      [modelHash]
    );
  },

  /**
   * Returns the vehicle mod/properties data for a given plate.
   * ESX reads `vehicle` from `owned_vehicles`; QB/QBX reads `mods` from `player_vehicles`.
   * @param {string} plate
   * @returns {Promise<Record<string, any> | null>}
   */
  async getVehicleMods(plate) {
    if (Framework.name === 'esx') {
      const result = await oxmysql.prepare('SELECT vehicle FROM owned_vehicles WHERE plate = ?', [plate]);
      if (!result) return null;
      return JSON.parse(result);
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const result = await oxmysql.prepare('SELECT mods FROM player_vehicles WHERE plate = ?', [plate]);
      if (!result) return null;
      return JSON.parse(result);
    }
    return null;
  },

  // ---------------------------------------------------------------------------
  // Offline player operations  (all hit the framework player table)
  // ---------------------------------------------------------------------------

  /**
   * Fetches a full offline player profile by their charId.
   * Returns `null` when no matching record is found.
   * @param {string} charId
   * @returns {Promise<OfflinePlayer | null>}
   */
  async getOfflinePlayer(charId) {
    if (Framework.name === 'esx') {
      const sql = `
                SELECT
                    u.identifier,
                    u.accounts,
                    u.job,
                    u.job_grade,
                    u.firstname,
                    u.lastname,
                    u.phone_number,
                    CONCAT(u.firstname, ' ', u.lastname) as name,
                    UNIX_TIMESTAMP(u.last_seen) * 1000 as last_seen
                FROM users u
                WHERE u.identifier = ?
                LIMIT 1
            `;
      const result = /** @type {any} */ (await oxmysql.prepare(sql, [charId]));
      if (!result) return null;

      const uniqueId = result.identifier.split(':')[1] || '';
      const identifiers = Array.from(
        new Set([`license:${uniqueId}`, ...JSON.parse(GetResourceKvpString(`identifiers:${uniqueId}`) ?? '[]')])
      );

      /** @type {Record<string, number>} */
      let accounts = {};
      try {
        accounts = typeof result.accounts === 'string' ? JSON.parse(result.accounts) : result.accounts || {};
      } catch {}

      let job = { name: '', label: '', grade: 0 };
      try {
        job = {
          name: result.job || '',
          label: result.job || '',
          grade: typeof result.job_grade === 'number' ? result.job_grade : 0,
        };
      } catch {}

      return /** @type {OfflinePlayer} */ ({
        name: result.name || `${result.firstname || ''} ${result.lastname || ''}`.trim(),
        uniqueId,
        charId: result.identifier || '',
        identifiers,
        accounts,
        last_seen: result.last_seen || 0,
        job,
      });
    } else if (Framework.name === 'vrp') {
      const character = await getVrpCharacter(charId);
      if (!character) return null;

      const identity = await getVrpIdentity(charId);
      const identifiers = await getVrpIdentifiersByUserId(character.user_id);
      const license = vrpLicenseFromIdentifiers(identifiers);
      const details = await Luxu.vrp2.getOfflineCharacterDetails(charId);

      return /** @type {OfflinePlayer} */ ({
        name: vrpIdentityName(identity) || `Character ${charId}`,
        uniqueId: license.split(':')[1] || String(character.user_id || ''),
        charId: String(character.id),
        identifiers,
        accounts: details?.accounts || {},
        last_seen: 0,
        job: details?.job
          ? {
              name: details.job.name || '',
              label: details.job.label || details.job.name || '',
              grade: typeof details.job.grade === 'number' ? details.job.grade : 0,
            }
          : { name: '', label: '', grade: 0 },
        gang: details?.gang
          ? {
              name: details.gang.name || '',
              label: details.gang.label || details.gang.name || '',
              grade: typeof details.gang.grade === 'number' ? details.gang.grade : details.gang.grade?.level || 0,
            }
          : undefined,
      });
    } else {
      const sql = `
                SELECT
                    p.citizenid,
                    p.license,
                    p.money,
                    p.job,
                    p.gang,
                    p.charinfo,
                    CONCAT(JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.lastname'))) as name,
                    JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.phone')) as phone_number,
                    UNIX_TIMESTAMP(p.last_updated) * 1000 as last_seen
                FROM players p
                WHERE p.citizenid = ?
                LIMIT 1
            `;
      const result = /** @type {any} */ (await oxmysql.prepare(sql, [charId]));
      if (!result) return null;

      const uniqueId = result.license.split(':')[1] || '';
      const identifiers = Array.from(
        new Set([result.license, ...JSON.parse(GetResourceKvpString(`identifiers:${uniqueId}`) ?? '[]')])
      );

      /** @type {Record<string, number>} */
      let accounts = {};
      try {
        accounts = typeof result.money === 'string' ? JSON.parse(result.money) : result.money || {};
      } catch {}

      let job = { name: '', label: '', grade: 0 };
      try {
        const p = typeof result.job === 'string' ? JSON.parse(result.job) : result.job;
        if (p)
          job = {
            name: p.name || '',
            label: p.label || p.name || '',
            grade: typeof p.grade === 'number' ? p.grade : p.grade?.level || 0,
          };
      } catch {}

      let gang = { name: '', label: '', grade: 0 };
      try {
        const p = typeof result.gang === 'string' ? JSON.parse(result.gang) : result.gang;
        if (p)
          gang = {
            name: p.name || '',
            label: p.label || p.name || '',
            grade: typeof p.grade === 'number' ? p.grade : p.grade?.level || 0,
          };
      } catch {}

      return /** @type {OfflinePlayer} */ ({
        name: result.name || '',
        uniqueId: result.license.split(':')[1] || '',
        charId: result.citizenid || '',
        identifiers,
        accounts,
        last_seen: result.last_seen || 0,
        job,
        gang,
      });
    }
  },

  /**
   * Returns the last saved world position for an offline character.
   * Used by admin jail so the player can be returned after the sentence ends.
   * @param {string} charId
   * @returns {Promise<{ x: number, y: number, z: number } | null>}
   */
  async getOfflinePlayerLastCoords(charId) {
    let rawPosition = null;

    if (Framework.name === 'esx') {
      rawPosition = await oxmysql.scalar('SELECT position FROM users WHERE identifier = ?', [charId]);
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      rawPosition = await oxmysql.scalar('SELECT position FROM players WHERE citizenid = ?', [charId]);
    } else if (Framework.name === 'vrp') {
      const details = await Luxu.vrp2.getOfflineCharacterDetails(charId);
      rawPosition = details?.position ?? null;
    }

    if (!rawPosition) return null;

    try {
      const position = typeof rawPosition === 'string' ? JSON.parse(rawPosition) : rawPosition;
      const x = Number(position.x ?? position[0]);
      const y = Number(position.y ?? position[1]);
      const z = Number(position.z ?? position[2]);
      if ([x, y, z].some((value) => !Number.isFinite(value))) return null;
      return { x, y, z };
    } catch {
      return null;
    }
  },

  /**
   * Searches offline players by a search term (minimum 2 characters).
   *
   * Override this to customise the search behaviour for your database schema.
   * @param {string} term
   * @returns {Promise<Array<{ name: string, charId: string, identifiers: string[] }>>}
   */
  async searchOfflinePlayers(term) {
    if (!term || term.length < 2) return [];

    const rawTerm = term.trim();
    const searchTerm = `%${rawTerm}%`;

    if (Framework.name === 'esx') {
      const sql = `
                SELECT
                    u.identifier,
                    u.firstname,
                    u.lastname,
                    CONCAT(u.firstname, ' ', u.lastname) as name
                FROM users u
                WHERE (
                    u.identifier LIKE ? OR
                    u.phone_number LIKE ? OR
                    CONCAT(u.firstname, ' ', u.lastname) LIKE ?
                )
                LIMIT 10
            `;
      /** @type {{ identifier: string, firstname: string, lastname: string, name: string }[]} */
      const results = await oxmysql.query(sql, [searchTerm, searchTerm, searchTerm]);
      return results.map((row) => {
        /** @type {string[]} */
        const identifiers = [];
        if (row.identifier) identifiers.push(row.identifier);
        return {
          name: row.name || `${row.firstname || ''} ${row.lastname || ''}`.trim(),
          charId: row.identifier || '',
          identifiers,
        };
      });
    } else if (Framework.name === 'qb') {
      const sql = `
                SELECT
                    p.citizenid,
                    p.charinfo,
                    CONCAT(JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.lastname'))) as name
                FROM players p
                WHERE (
                    p.name LIKE ? OR
                    p.citizenid LIKE ? OR
                    p.license LIKE ? OR
                    p.phone_number LIKE ? OR
                    p.charinfo LIKE ?
                )
                LIMIT 10
            `;
      /** @type {{ citizenid: string, charinfo: string, name: string, identifier?: string }[]} */
      const results = await oxmysql.query(sql, [searchTerm, searchTerm, searchTerm, searchTerm, searchTerm]);
      return results.map((row) => {
        /** @type {string[]} */
        const identifiers = [];
        if (row.identifier) identifiers.push(row.identifier);
        return {
          name: row.name || '',
          charId: row.citizenid || '',
          identifiers,
        };
      });
    } else if (Framework.name === 'qbx') {
      const sql = `
             SELECT
                 p.citizenid,
                 p.charinfo,
                 CONCAT(JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.lastname'))) as name
             FROM players p
             LEFT JOIN users u ON p.userId = u.userId
             WHERE (
                 p.name LIKE ? OR
                 p.citizenid LIKE ? OR
                 p.license LIKE ? OR
                 p.phone_number LIKE ? OR
                 p.charinfo LIKE ? OR
                 u.license = ? OR
                 u.license2 = ? OR
                 u.fivem = ? OR
                 u.discord = ?
             )
             LIMIT 10
            `;
      /** @type {{ citizenid: string, charinfo: string, name: string, identifier?: string }[]} */
      const results = await oxmysql.query(sql, [
        searchTerm,
        searchTerm,
        searchTerm,
        searchTerm,
        searchTerm,
        rawTerm,
        rawTerm,
        rawTerm,
        rawTerm,
      ]);
      return results.map((row) => {
        /** @type {string[]} */
        const identifiers = [];
        if (row.identifier) identifiers.push(row.identifier);
        return {
          name: row.name || '',
          charId: row.citizenid || '',
          identifiers,
        };
      });
    } else if (Framework.name === 'vrp') {
      const sql = `
        SELECT
          c.id,
          c.user_id,
          i.firstname,
          i.name,
          i.phone,
          GROUP_CONCAT(uid.identifier SEPARATOR '\n') as identifiers
        FROM vrp_characters c
        LEFT JOIN vrp_character_identities i ON i.character_id = c.id
        LEFT JOIN vrp_user_ids uid ON uid.user_id = c.user_id
        WHERE (
          CAST(c.id AS CHAR) LIKE ? OR
          CAST(c.user_id AS CHAR) LIKE ? OR
          i.firstname LIKE ? OR
          i.name LIKE ? OR
          i.phone LIKE ? OR
          uid.identifier LIKE ?
        )
        GROUP BY c.id, c.user_id, i.firstname, i.name, i.phone
        LIMIT 10
      `;
      const results = await oxmysql.query(sql, [
        searchTerm,
        searchTerm,
        searchTerm,
        searchTerm,
        searchTerm,
        searchTerm,
      ]);
      return results.map((row) => ({
        name: `${row.firstname || ''} ${row.name || ''}`.trim() || `Character ${row.id}`,
        charId: String(row.id),
        identifiers: row.identifiers ? String(row.identifiers).split('\n').filter(Boolean) : [],
      }));
    }
  },

  /**
   * Permanently deletes a single player row from the framework table.
   * For a full character deletion that includes a transaction with additional
   * resource-specific cleanup queries, use `deleteCharacter` instead.
   * @param {string} charId
   * @returns {Promise<boolean>}
   */
  async deleteOfflinePlayer(charId) {
    if (Framework.name === 'esx') {
      return (await oxmysql.update('DELETE FROM users WHERE identifier = ?', [charId])) === 1;
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      return (await oxmysql.update('DELETE FROM players WHERE citizenid = ?', [charId])) === 1;
    } else if (Framework.name === 'vrp') {
      return (await oxmysql.update('DELETE FROM vrp_characters WHERE id = ?', [charId])) === 1;
    }
    return false;
  },

  /**
   * Deletes a player character inside a single database transaction.
   *
   * Add any extra cleanup queries here (e.g. removing owned vehicles, housing, etc.).
   * Each query receives the character identifier as its only parameter
   * (ESX = `identifier`, QB/QBX = `citizenid`).
   *
   * @param {string} charId
   * @returns {Promise<boolean>}
   */
  async deleteCharacter(charId) {
    /** @type {Array<{ query: string, values: any[] }>} */
    const queries = [];

    if (Framework.name === 'esx') {
      queries.push({ query: 'DELETE FROM luxu_admin_jail WHERE char_id = ?', values: [charId] });

      // Add extra ESX cleanup queries before the main delete:
      queries.push({ query: 'DELETE FROM owned_vehicles WHERE owner = ?', values: [charId] });

      queries.push({ query: 'DELETE FROM users WHERE identifier = ?', values: [charId] });
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      queries.push({ query: 'DELETE FROM luxu_admin_jail WHERE char_id = ?', values: [charId] });

      // Add extra QB/QBX cleanup queries before the main delete:
      queries.push({ query: 'DELETE FROM player_vehicles WHERE citizenid = ?', values: [charId] });

      queries.push({ query: 'DELETE FROM players WHERE citizenid = ?', values: [charId] });
    } else if (Framework.name === 'vrp') {
      queries.push({ query: 'DELETE FROM luxu_admin_jail WHERE char_id = ?', values: [charId] });
      queries.push({ query: 'DELETE FROM vrp_characters WHERE id = ?', values: [charId] });
    } else {
      return false;
    }

    try {
      return !!(await oxmysql.transaction(queries));
    } catch {
      return false;
    }
  },

  /**
   * Changes the first/last name of an offline player.
   * @param {string} charId
   * @param {string} newName - Full name as "Firstname Lastname".
   * @returns {Promise<boolean>}
   */
  async changeOfflinePlayerName(charId, newName) {
    const [firstname, lastname] = newName.split(' ');
    if (Framework.name === 'esx') {
      return (
        (await oxmysql.update('UPDATE users SET firstname = ?, lastname = ? WHERE identifier = ?', [
          firstname,
          lastname ?? '',
          charId,
        ])) === 1
      );
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      return (
        (await oxmysql.update(
          'UPDATE players SET charinfo = JSON_SET(charinfo, "$.firstname", ?, "$.lastname", ?) WHERE citizenid = ?',
          [firstname, lastname, charId]
        )) === 1
      );
    } else if (Framework.name === 'vrp') {
      return (
        (await oxmysql.update('UPDATE vrp_character_identities SET firstname = ?, name = ? WHERE character_id = ?', [
          firstname,
          lastname ?? '',
          charId,
        ])) === 1
      );
    }
    return false;
  },

  /**
   * Changes the job and grade of an offline player.
   * @param {string} charId
   * @param {string} job
   * @param {number} grade
   * @returns {Promise<boolean>}
   */
  async changeOfflinePlayerJob(charId, job, grade) {
    if (Framework.name === 'esx') {
      return (
        (await oxmysql.update('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', [job, grade, charId])) ===
        1
      );
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      return (
        (await oxmysql.update(
          'UPDATE players SET job = JSON_SET(job, "$.name", ?, "$.grade.level", ?) WHERE citizenid = ?',
          [job, grade, charId]
        )) === 1
      );
    } else if (Framework.name === 'vrp') {
      return await Luxu.vrp2.setOfflineGroupByType(charId, 'job', job);
    }
    return false;
  },

  /**
   * Changes the gang and grade of an offline player.
   * @param {string} charId
   * @param {string} gang
   * @param {number} grade
   * @returns {Promise<boolean>}
   */
  async changeOfflinePlayerGang(charId, gang, grade) {
    if (Framework.name === 'esx') {
      return (
        (await oxmysql.update('UPDATE users SET gang = ?, gang_grade = ? WHERE identifier = ?', [
          gang,
          grade,
          charId,
        ])) === 1
      );
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      return (
        (await oxmysql.update(
          'UPDATE players SET gang = JSON_SET(gang, "$.name", ?, "$.grade.level", ?) WHERE citizenid = ?',
          [gang, grade, charId]
        )) === 1
      );
    } else if (Framework.name === 'vrp') {
      return await Luxu.vrp2.setOfflineGroupByType(charId, 'gang', gang);
    }
    return false;
  },

  /**
   * Replaces all account balances for an offline player.
   * @param {string} charId
   * @param {Record<string, number>} accounts
   * @returns {Promise<boolean>}
   */
  async changeOfflinePlayerMoney(charId, accounts) {
    if (Framework.name === 'esx') {
      return (
        (await oxmysql.update('UPDATE users SET accounts = ? WHERE identifier = ?', [
          JSON.stringify(accounts),
          charId,
        ])) === 1
      );
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      return (
        (await oxmysql.update('UPDATE players SET money = ? WHERE citizenid = ?', [
          JSON.stringify(accounts),
          charId,
        ])) === 1
      );
    } else if (Framework.name === 'vrp') {
      return await Luxu.vrp2.setOfflineAccounts(charId, accounts);
    }
    return false;
  },

  /**
   * Sets the balance of a single account for an offline player.
   * Reads the current accounts JSON, patches the target key, and writes it back.
   * @param {string} charId
   * @param {string} account
   * @param {number} amount
   * @returns {Promise<boolean>}
   */
  async updateOfflinePlayerAccountMoney(charId, account, amount) {
    if (Framework.name === 'esx') {
      const row = await oxmysql.single('SELECT accounts FROM users WHERE identifier = ?', [charId]);
      if (!row) return false;
      const accounts = JSON.parse(row.accounts);
      accounts[account] = amount;
      return (
        (await oxmysql.update('UPDATE users SET accounts = ? WHERE identifier = ?', [
          JSON.stringify(accounts),
          charId,
        ])) === 1
      );
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const row = await oxmysql.single('SELECT money FROM players WHERE citizenid = ?', [charId]);
      if (!row) return false;
      const money = JSON.parse(row.money);
      money[account] = amount;
      return (
        (await oxmysql.update('UPDATE players SET money = ? WHERE citizenid = ?', [JSON.stringify(money), charId])) ===
        1
      );
    } else if (Framework.name === 'vrp') {
      return await Luxu.vrp2.setOfflineAccount(
        charId,
        account === 'cash' || account === 'money' ? 'wallet' : account,
        amount
      );
    }
    return false;
  },

  // ---------------------------------------------------------------------------
  // Inventory
  // ---------------------------------------------------------------------------

  /**
   * Reads the raw inventory JSON array for an offline player.
   *
   * Returns the parsed array straight from the framework's player row
   * (`users.inventory` for ESX, `players.inventory` for QB/QBX). Returns `null`
   * when the row doesn't exist, or `[]` when it exists but the column is empty
   * or malformed.
   *
   * Item shapes vary between frameworks and inventory scripts:
   *   - ESX-native / qb-inventory: `{ name, count | amount, slot?, info?, metadata? }`
   *   - ox_inventory:              `{ name, count, slot, metadata? }`
   * The TS layer normalises them before handing them to the UI.
   *
   * Override this method if your server stores items in a separate table
   * (e.g. `qs_inventory`, `codem_inventory`) rather than the framework column.
   *
   * @param {string} charId
   * @returns {Promise<any[] | null>}
   */
  async getOfflinePlayerInventory(charId) {
    if (Framework.name === 'esx') {
      const row = await oxmysql.single('SELECT inventory FROM users WHERE identifier = ?', [charId]);
      if (!row) return null;
      try {
        const parsed = typeof row.inventory === 'string' ? JSON.parse(row.inventory) : row.inventory;
        return Array.isArray(parsed) ? parsed : [];
      } catch {
        return [];
      }
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const row = await oxmysql.single('SELECT inventory FROM players WHERE citizenid = ?', [charId]);
      if (!row) return null;
      try {
        const parsed = typeof row.inventory === 'string' ? JSON.parse(row.inventory) : row.inventory;
        return Array.isArray(parsed) ? parsed : [];
      } catch {
        return [];
      }
    } else if (Framework.name === 'vrp') {
      return await Luxu.vrp2.getOfflineInventory(charId);
    }
    return null;
  },

  /**
   * Writes the full inventory JSON array for an offline player.
   *
   * The caller is responsible for producing the item shape. `offline_actions.ts`
   * dual-writes both `amount`/`count` and `metadata`/`info` so that any
   * framework or inventory script reader will pick up the correct field.
   *
   * Override this method if your server stores items in a separate table.
   *
   * @param {string} charId
   * @param {any[]} items
   * @returns {Promise<boolean>}
   */
  async setOfflinePlayerInventory(charId, items) {
    const json = JSON.stringify(Array.isArray(items) ? items : []);
    if (Framework.name === 'esx') {
      return (await oxmysql.update('UPDATE users SET inventory = ? WHERE identifier = ?', [json, charId])) === 1;
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      return (await oxmysql.update('UPDATE players SET inventory = ? WHERE citizenid = ?', [json, charId])) === 1;
    } else if (Framework.name === 'vrp') {
      return await Luxu.vrp2.setOfflineInventory(charId, items);
    }
    return false;
  },

  /**
   * Finds all players that possess a specific item.
   * Uses MariaDB `JSON_CONTAINS` for server-side filtering — significantly faster
   * than fetching every inventory row and filtering in memory.
   * @param {string} itemName
   * @returns {Promise<Array<{ charId: string, name: string, amount: number }>>}
   */
  async getPlayersWithItem(itemName) {
    if (Framework.name === 'esx') {
      const sql = `
                SELECT
                    u.identifier as charId,
                    CONCAT(u.firstname, ' ', u.lastname) as name,
                    u.inventory
                FROM users u
                WHERE JSON_CONTAINS(u.inventory, JSON_OBJECT('name', ?))
                LIMIT 5000
            `;
      try {
        const results = /** @type {any[]} */ (await oxmysql.query(sql, [itemName]));
        return results
          .map((row) => {
            try {
              const inventory = typeof row.inventory === 'string' ? JSON.parse(row.inventory) : row.inventory;
              if (!Array.isArray(inventory)) return null;
              let amount = 0;
              for (const item of inventory) {
                if (item && item.name === itemName) amount += item.count || item.amount || 0;
              }
              if (amount <= 0) return null;
              return { charId: row.charId, name: row.name, amount };
            } catch {
              return null;
            }
          })
          .filter(/** @param {any} item */ (item) => item !== null)
          .sort(/** @param {{ amount: number }} a @param {{ amount: number }} b */ (a, b) => b.amount - a.amount);
      } catch {
        return [];
      }
    } else if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const sql = `
                SELECT
                    p.citizenid as charId,
                    CONCAT(
                        JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.firstname')), ' ',
                        JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.lastname'))
                    ) as name,
                    p.inventory
                FROM players p
                WHERE JSON_CONTAINS(p.inventory, JSON_OBJECT('name', ?))
                LIMIT 5000
            `;
      try {
        const results = /** @type {any[]} */ (await oxmysql.query(sql, [itemName]));
        return results
          .map((row) => {
            try {
              const inventory = typeof row.inventory === 'string' ? JSON.parse(row.inventory) : row.inventory;
              if (!Array.isArray(inventory)) return null;
              let amount = 0;
              for (const item of inventory) {
                if (item && item.name === itemName) amount += item.amount || item.count || 0;
              }
              if (amount <= 0) return null;
              return { charId: row.charId, name: row.name, amount };
            } catch {
              return null;
            }
          })
          .filter(/** @param {any} item */ (item) => item !== null)
          .sort(/** @param {{ amount: number }} a @param {{ amount: number }} b */ (a, b) => b.amount - a.amount);
      } catch {
        return [];
      }
    } else if (Framework.name === 'vrp') {
      const rows = await oxmysql.query(`
        SELECT
          c.id,
          i.firstname,
          i.name
        FROM vrp_characters c
        LEFT JOIN vrp_character_identities i ON i.character_id = c.id
      `);

      const result = [];
      for (const row of rows) {
        const inventory = await Luxu.vrp2.getOfflineInventory(String(row.id));
        const amount = Array.isArray(inventory)
          ? inventory.reduce((total, item) => {
              if (!item || item.name !== itemName) return total;
              return total + (Number(item.amount ?? item.count) || 0);
            }, 0)
          : 0;

        if (amount > 0) {
          result.push({
            charId: String(row.id),
            name: vrpIdentityName(row) || `Character ${row.id}`,
            amount,
          });
        }
      }

      return result.sort(
        /** @param {{ amount: number }} a @param {{ amount: number }} b */ (a, b) => b.amount - a.amount
      );
    }
    return [];
  },

  // ---------------------------------------------------------------------------
  // Statistics  (framework tables)
  // ---------------------------------------------------------------------------

  /**
   * Returns the top 100 players ranked by total money (bank + cash).
   * @returns {Promise<Array<{ name: string, money: number, charId: string }>>}
   */
  async getRichList() {
    if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const rows = /** @type {{ money: string, charinfo: string, citizenid: string }[]} */ (
        await oxmysql.query(`
                    SELECT money, charinfo, citizenid
                    FROM players
                    WHERE money IS NOT NULL AND charinfo IS NOT NULL
                      AND JSON_EXTRACT(money, '$.bank') + JSON_EXTRACT(money, '$.cash') > 0
                    ORDER BY (JSON_EXTRACT(money, '$.bank') + JSON_EXTRACT(money, '$.cash')) DESC
                    LIMIT 100
                `)
      );
      return rows
        .map((r) => {
          try {
            const charinfo = JSON.parse(r.charinfo);
            const money = JSON.parse(r.money);
            return {
              name: `${charinfo.firstname} ${charinfo.lastname}`,
              money: (money.bank || 0) + (money.cash || 0),
              charId: r.citizenid,
            };
          } catch {
            return null;
          }
        })
        .filter(/** @param {any} r */ (r) => r !== null);
    } else if (Framework.name === 'esx') {
      const rows = /** @type {{ firstname: string, lastname: string, accounts: string, identifier: string }[]} */ (
        await oxmysql.query(`
                    SELECT firstname, lastname, accounts, identifier
                    FROM users
                    WHERE accounts IS NOT NULL
                      AND JSON_EXTRACT(accounts, '$.bank') + JSON_EXTRACT(accounts, '$.money') > 0
                    ORDER BY (JSON_EXTRACT(accounts, '$.bank') + JSON_EXTRACT(accounts, '$.money')) DESC
                    LIMIT 100
                `)
      );
      return rows
        .map((r) => {
          try {
            const accounts = JSON.parse(r.accounts);
            return {
              name: `${r.firstname} ${r.lastname}`,
              money: (accounts.bank || 0) + (accounts.money || 0),
              charId: r.identifier,
            };
          } catch {
            return null;
          }
        })
        .filter(/** @param {any} r */ (r) => r !== null);
    } else if (Framework.name === 'vrp') {
      const rows = await oxmysql.query(`
        SELECT
          c.id,
          i.firstname,
          i.name
        FROM vrp_characters c
        LEFT JOIN vrp_character_identities i ON i.character_id = c.id
      `);

      const result = [];
      for (const row of rows) {
        const accounts = await Luxu.vrp2.getOfflineAccounts(String(row.id));
        const money =
          (Number(accounts?.bank) || 0) + (Number(accounts?.wallet ?? accounts?.money ?? accounts?.cash) || 0);
        if (money > 0) {
          result.push({
            name: vrpIdentityName(row) || `Character ${row.id}`,
            money,
            charId: String(row.id),
          });
        }
      }

      return result
        .sort(/** @param {{ money: number }} a @param {{ money: number }} b */ (a, b) => b.money - a.money)
        .slice(0, 100);
    }
    return [];
  },

  /**
   * Returns a job-name → player-count mapping from the framework player table.
   * @returns {Promise<Record<string, number>>}
   */
  async getJobDistribution() {
    /** @type {Record<string, number>} */
    const distribution = {};
    if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const rows = /** @type {{ job_name: string, count: number }[]} */ (
        await oxmysql.query(`
                    SELECT JSON_EXTRACT(job, '$.name') as job_name, COUNT(*) as count
                    FROM players
                    WHERE job IS NOT NULL
                    GROUP BY JSON_EXTRACT(job, '$.name')
                `)
      );
      rows.forEach((row) => {
        if (!row.job_name) return;
        const jobName = JSON.parse(row.job_name);
        if (jobName) distribution[jobName] = row.count;
      });
    } else if (Framework.name === 'esx') {
      const rows = /** @type {{ job: string, count: number }[]} */ (
        await oxmysql.query('SELECT job, COUNT(*) as count FROM users GROUP BY job')
      );
      rows.forEach((row) => {
        distribution[row.job] = row.count;
      });
    } else if (Framework.name === 'vrp') {
      const rows = await oxmysql.query('SELECT id FROM vrp_characters');

      for (const row of rows) {
        const details = await Luxu.vrp2.getOfflineCharacterDetails(String(row.id));
        const jobName = details?.job?.name;
        if (jobName) distribution[jobName] = (distribution[jobName] || 0) + 1;
      }
    }
    return distribution;
  },

  /**
   * Returns the total number of distinct players (by license) ever registered.
   * @returns {Promise<number>}
   */
  async getTotalUniquePlayers() {
    if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const result = /** @type {{ count: number }[]} */ (
        await oxmysql.query('SELECT COUNT(DISTINCT license) as count FROM players')
      );
      return result[0]?.count ?? 0;
    } else if (Framework.name === 'esx') {
      const result = /** @type {{ count: number }[]} */ (
        await oxmysql.query(
          "SELECT COUNT(DISTINCT SUBSTRING_INDEX(identifier, ':', -1)) as count FROM users WHERE identifier LIKE '%:%'"
        )
      );
      return result[0]?.count ?? 0;
    } else if (Framework.name === 'vrp') {
      const result = /** @type {{ count: number }[]} */ (
        await oxmysql.query('SELECT COUNT(*) as count FROM vrp_users')
      );
      return result[0]?.count ?? 0;
    }
    return 0;
  },

  /**
   * Returns the total number of character rows (one per character/slot).
   * @returns {Promise<number>}
   */
  async getTotalCharacters() {
    if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const result = /** @type {{ count: number }[]} */ (await oxmysql.query('SELECT COUNT(*) as count FROM players'));
      return result[0]?.count ?? 0;
    } else if (Framework.name === 'esx') {
      const result = /** @type {{ count: number }[]} */ (await oxmysql.query('SELECT COUNT(*) as count FROM users'));
      return result[0]?.count ?? 0;
    } else if (Framework.name === 'vrp') {
      const result = /** @type {{ count: number }[]} */ (
        await oxmysql.query('SELECT COUNT(*) as count FROM vrp_characters')
      );
      return result[0]?.count ?? 0;
    }
    return 0;
  },

  /**
   * Returns the total bank balance across all players.
   * @returns {Promise<number>}
   */
  async getTotalBankMoney() {
    if (Framework.name === 'qb' || Framework.name === 'qbx') {
      const result = /** @type {{ total: number }[]} */ (
        await oxmysql.query('SELECT SUM(JSON_EXTRACT(money, "$.bank")) as total FROM players WHERE money IS NOT NULL')
      );
      return result[0]?.total ?? 0;
    } else if (Framework.name === 'esx') {
      const result = /** @type {{ total: number }[]} */ (
        await oxmysql.query(
          'SELECT SUM(JSON_EXTRACT(accounts, "$.bank")) as total FROM users WHERE accounts IS NOT NULL'
        )
      );
      return result[0]?.total ?? 0;
    } else if (Framework.name === 'vrp') {
      const rows = await oxmysql.query('SELECT id FROM vrp_characters');
      let total = 0;

      for (const row of rows) {
        const accounts = await Luxu.vrp2.getOfflineAccounts(String(row.id));
        total += Number(accounts?.bank) || 0;
      }

      return total;
    }
    return 0;
  },
};
