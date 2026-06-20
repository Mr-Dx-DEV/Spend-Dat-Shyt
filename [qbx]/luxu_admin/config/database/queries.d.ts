import type { OfflinePlayer } from '../../../../shared/types/database';

/**
 * `queries.js` is evaluated by the Node runtime with `oxmysql`, `Framework`,
 * `Luxu`, and `GetResourceKvpString` injected into scope.
 */
declare const queries: {
  // -------------------------------------------------------------------------
  // Player
  // -------------------------------------------------------------------------

  /** Fetches a single player row by their charId. */
  getPlayer(charId: string): Promise<any>;

  /**
   * Returns raw retention timestamps for every player in the database.
   * ESX reads from `users`; QB/QBX reads from `luxu_stats_player_retention`.
   */
  getPlayerRetention(): Promise<{ timestamp: number }[]>;

  /**
   * Retrieves the saved clothing/skin data for a player.
   * ESX reads `skin` from `users`; QB/QBX reads from `playerskins`.
   */
  getPlayerClothing(charId: string): Promise<Record<string, any>>;

  // -------------------------------------------------------------------------
  // Vehicles
  // -------------------------------------------------------------------------

  /** Returns all vehicles of a given model hash with their owner's charId. */
  getVehicleOwners(modelHash: number): Promise<{ plate: string; char_id: string }[]>;

  /**
   * Returns the vehicle mod/properties data for a given plate.
   * ESX reads `vehicle` from `owned_vehicles`; QB/QBX reads `mods` from `player_vehicles`.
   */
  getVehicleMods(plate: string): Promise<Record<string, any> | null>;

  // -------------------------------------------------------------------------
  // Offline player operations
  // -------------------------------------------------------------------------

  /**
   * Fetches a full offline player profile by their charId.
   * Returns `null` when no matching record is found.
   */
  getOfflinePlayer(charId: string): Promise<OfflinePlayer | null>;

  /**
   * Returns the last saved world position for an offline character.
   * Used by admin jail so the player can be returned after the sentence ends.
   */
  getOfflinePlayerLastCoords(charId: string): Promise<{ x: number; y: number; z: number } | null>;

  /**
   * Searches offline players by a search term (minimum 2 characters).
   * Override this to customise the search behaviour for your database schema.
   */
  searchOfflinePlayers(term: string): Promise<{ name: string; charId: string; identifiers: string[] }[]>;

  /**
   * Permanently deletes a single player row from the framework table.
   * For a full character deletion with cleanup transaction, use `deleteCharacter`.
   */
  deleteOfflinePlayer(charId: string): Promise<boolean>;

  /**
   * Deletes a player character inside a single database transaction.
   * Add extra cleanup queries (vehicles, housing, etc.) directly in this method in queries.js.
   * Each query receives the character identifier as its only parameter.
   */
  deleteCharacter(charId: string): Promise<boolean>;

  /** Changes the first/last name of an offline player. */
  changeOfflinePlayerName(charId: string, newName: string): Promise<boolean>;

  /** Changes the job and grade of an offline player. */
  changeOfflinePlayerJob(charId: string, job: string, grade: number): Promise<boolean>;

  /** Changes the gang and grade of an offline player. */
  changeOfflinePlayerGang(charId: string, gang: string, grade: number): Promise<boolean>;

  /** Replaces all account balances for an offline player. */
  changeOfflinePlayerMoney(charId: string, accounts: Record<string, number>): Promise<boolean>;

  /**
   * Sets the balance of a single account for an offline player.
   * Reads the current accounts JSON, patches the target key, and writes it back.
   */
  updateOfflinePlayerAccountMoney(charId: string, account: string, amount: number): Promise<boolean>;

  // -------------------------------------------------------------------------
  // Inventory
  // -------------------------------------------------------------------------

  /**
   * Reads the raw inventory JSON array for an offline player.
   * Returns `null` when the player row doesn't exist, or `[]` when the
   * column is empty/malformed.
   */
  getOfflinePlayerInventory(charId: string): Promise<any[] | null>;

  /**
   * Writes the full inventory JSON array for an offline player.
   * The caller is responsible for producing items in a shape the framework
   * (or inventory script) can read back.
   */
  setOfflinePlayerInventory(charId: string, items: any[]): Promise<boolean>;

  /**
   * Finds all players that possess a specific item.
   * Uses MariaDB `JSON_CONTAINS` for server-side filtering.
   */
  getPlayersWithItem(itemName: string): Promise<Array<{ charId: string; name: string; amount: number }>>;

  // -------------------------------------------------------------------------
  // Statistics  (framework tables only)
  // -------------------------------------------------------------------------

  /** Returns the top 100 players ranked by total money (bank + cash). */
  getRichList(): Promise<Array<{ name: string; money: number; charId: string }>>;

  /** Returns a job-name → player-count mapping from the framework player table. */
  getJobDistribution(): Promise<Record<string, number>>;

  /** Returns the total number of distinct players (by license) ever registered. */
  getTotalUniquePlayers(): Promise<number>;

  /** Returns the total number of character rows (one per character/slot). */
  getTotalCharacters(): Promise<number>;

  /** Returns the total bank balance across all players. */
  getTotalBankMoney(): Promise<number>;
};

export default queries;
export type DatabaseQueries = typeof queries;
