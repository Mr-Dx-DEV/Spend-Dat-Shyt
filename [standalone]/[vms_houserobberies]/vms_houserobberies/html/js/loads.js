loadRequirements = (data) => {
    let requirements = `
        <div class="title">${translation.house_data.requirements}</div>
        <div class="requirements">
    `
    if (data) {
        for (const [k, v] of Object.entries(data)) {
            requirements = requirements + `
                <div><i class="fa-solid fa-angle-right"></i> ${v}</div>
            `
        }
    }
    requirements = requirements + '</div>'
    return requirements
}

loadInformations = (houseId, data) => {
    let informationsData = ''
    for (const [k, v] of Object.entries(data)) {
        let infoId = Number(k) + 1
        informationsData = informationsData + `
            <div>
                <span>
                    ${v.icon ? `<i class="${v.icon}"></i>` : ``}
                    <div class="info">${informations[houseId] && informations[houseId][infoId] ? v.information : v.placeholder}</div>
                </span>
                ${informations[houseId] && informations[houseId][infoId] ? '' : `<div class="buy-info" onclick="buyInformation('${houseId}', ${infoId})">BUY FOR ${v.price}$</div>`}
            </div>
        `
    }
    return informationsData
}

loadHouseData = (houseId) => {
    selectedHouseId = houseId
    let selectedHouse = houses[houseId];
    let houseData = `
        <div>
            <div class="title">
                <div class="difficulty ${selectedHouse.difficultyLevel == 1 && "easy" || selectedHouse.difficultyLevel == 2 && "medium" || selectedHouse.difficultyLevel == 3 && "hard"}"
                >${selectedHouse.difficultyLevel == 1 && translation.difficulty_level_1 || selectedHouse.difficultyLevel == 2 && translation.difficulty_level_2 || selectedHouse.difficultyLevel == 3 && translation.difficulty_level_3}</div>
                <div class="address">${selectedHouse.address.zone} <span>${selectedHouse.address.street}</span></div>
            </div>
            <hr>
            <div class="first-bar">
                <img src="./houses-images/${selectedHouse.image}" draggable="false">
                <div>
                    ${loadRequirements(selectedHouse.requirements)}
                    ${allRobberies[houseId] ? `<div class="locked-robbery" onclick="startRobbery('${houseId}')"><i class="fa-solid fa-lock"></i></div>` : `<div class="start-robbery" onclick="startRobbery('${houseId}')">${translation.house_data.start_robbery}</div>`}
                </div>
            </div>
            <hr>
            <div class="second-bar">
                ${loadInformations(houseId, selectedHouse.informations)}
            </div>
        </div>
    `
    $('.planning-menu > .menu > .main > div[data-type="house-data"]').html(houseData);
    updateMenu('house-data');
}

loadHouses = (houses) => {
    let housesData = ''

    for (const [k, v] of Object.entries(houses)) {
        housesData = housesData + `
            <div class="house level-${v.difficultyLevel}">
            <div class="difficulty-ribbon level-${v.difficultyLevel}"><span>${v.difficultyLevel == 1 && translation.difficulty_level_1 || v.difficultyLevel == 2 && translation.difficulty_level_2 || v.difficultyLevel == 3 && translation.difficulty_level_3}</span></div>
                <div class="address">
                    <p class="zone">${v.address.zone}</p>
                    <p class="street">${v.address.street}</p>
                </div>
                <img src="./houses-images/${v.image}" draggable="false">
                <div class="show_more" onclick="loadHouseData('${k}')">
                    ${translation.houses_list.show_more}
                </div>
            </div>
        `
    }
    return housesData
}

loadItemsForSale = (shopType, itemsList) => {
    let itemsData = ''
    for (const [k, v] of Object.entries(itemsList)) {
        let price = shopType == 'pawnshop' ? v.prices['pawnshop'] : v.prices['fence'];
        if (price != undefined) {
            itemsData = itemsData + `
                <div class="product">
                    <div class="info">
                        <div class="label">${v.itemLabel}</div>
                        <div class="price">${price}${translation.currency}</div>
                    </div>
                    <div class="icon">
                        <img src="item-icons/${v.itemName}.png" draggable="false">
                    </div>
                    <div class="actions">
                        <input min="1" max="100" data-name="${v.itemName}" type="number" value="1" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : event.charCode >= 48 && event.charCode <= 57">
                        <div class="sell-item" onclick="sellItem('${v.itemName}')">${translation.sell_items.sell_it}</div>
                    </div>
                </div>
            `
        }
    }

    $('.sell-items .center .products-list').html(itemsData);
}

loadLootConfigurator = () => {
    let lootData = ''
    for (const [k, v] of Object.entries(itemsList)) {
        lootData += `
            <div>
                <div class="name">
                    ${k} <span>(${v.propModel})</span>
                </div>
                ${probablyLoots[k] ? 
                    `<div class="remove-loot" onclick="removeLoot('${k}')">
                    <i class="fa-solid fa-minus"></i>
                    </div>`
                    : 
                    `<div class="add-loot" onclick="addLoot('${k}')">
                        <i class="fa-solid fa-plus"></i>
                    </div>`
                }
                <div class="view-loot" onclick="viewLoot('${k}')">
                    <i class="fa-solid fa-eye"></i>
                </div>
            </div>
        `
    }
    
    $('.configuring-menu div[data-type="loot-config"] > .data').html(lootData);
}

loadTenantsConfigurator = (type) => {
    if (!type) {
        loadTenantsConfigurator('peds');
        loadTenantsConfigurator('animations');
        loadTenantsConfigurator('weapons');
    } else if (type == 'peds') {
        let pedsData = ''
        for (const [k, v] of Object.entries(pedsList)) {
            let pedId = Number(k) + 1
            pedsData += `
                <div>
                    <div class="name">${v}</div>
                    ${selectedPed && selectedPed == pedId ? '' : `
                        <div class="view" onclick="viewPedModel(${pedId})">
                            <i class="fa-solid fa-eye"></i>
                        </div>
                    `}
                </div>
            `
        }
        $('.configuring-menu div[data-type="tenants-config"] > .data.peds').html(pedsData);
    } else if (type == 'animations') {
        let animationsData = ''
        for (const [k, v] of Object.entries(animationsList)) {
            let animId = Number(k) + 1
            animationsData += `
                <div>
                    <div class="name">${v[0]} <span>${v[1]}</span></div>
                    ${selectedAnimation && selectedAnimation == animId ? '' : `
                        <div class="view" onclick="viewPedAnimation(${animId})">
                            <i class="fa-solid fa-eye"></i>
                        </div>
                    `}
                </div>
            `
        }
        $('.configuring-menu div[data-type="tenants-config"] > .data.animations').html(animationsData);
    } else if (type == 'weapons') {
        let weaponsData = ''
        for (const [k, v] of Object.entries(weaponsList)) {
            let weaponId = Number(k) + 1
            weaponsData += `
                <div>
                    <div class="name">${v}</div>
                    ${selectedWeapon && selectedWeapon == weaponId ? '' : `
                        <div class="view" onclick="viewPedWeapon(${weaponId})">
                            <i class="fa-solid fa-eye"></i>
                        </div>
                    `}
                </div>
            `
        }
        $('.configuring-menu div[data-type="tenants-config"] > .data.weapons').html(weaponsData);
    }
}