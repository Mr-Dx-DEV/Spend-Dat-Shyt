let translation = {};

String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

var number = Intl.NumberFormat('en-US', {minimumFractionDigits: 0});

var isMenuOpened = false

let currentMenu = null;
let selectedOption = null;
let selectedHouseId = null;

let houses = {};
let informations = {};
let haveStartedRobbery = false;


let interiorSelected = 0;
let interiorSelectedName = null;
let interiorsList = {};
let interiorsListKeys = {};
let itemsList = {};

let pickedInterior = false;
let probablyLoots = [];

let selectedPed = null;
let selectedAnimation = null;
let selectedWeapon = null;
let pedsList = [];
let animationsList = [];
let weaponsList = [];

window.addEventListener("load", function() {
    $.post(`https://${GetParentResourceName()}/loaded`)
})

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.action == "loaded") {
        let lang = item.lang;
        $.ajax({
            url: '../config/translation.json',
            type: 'GET',
            dataType: 'json',
            success: function (code, statut) {
                if (!code[lang]) {
                    translation = code["EN"];
                    console.warning(`^7Selected language ^1"${lang}"^7 not found, changed to ^2"EN"^7, configure your language in translation.json.`);
                } else {
                    translation = code[lang];
                }

                // Planning Menu Translation:
                $('.planning-menu .header .title').html(translation.menu_title);

                // Configurator Menu Translation:
                $('.configuring-menu .header .title').html(translation.configurator_menu_title);
                
                $('.configuring-menu div[data-type="house-config"] > #enter-coords .title').html(translation.configurator.manage_enter_point_title);
                $('.configuring-menu div[data-type="house-config"] > #enter-coords .description').html(translation.configurator.manage_enter_point_description);
                $('.configuring-menu div[data-type="house-config"] > #interior .title').html(translation.configurator.manage_interior_title);
                $('.configuring-menu div[data-type="house-config"] > #interior .description').html(translation.configurator.manage_interior_description);
                $('.configuring-menu div[data-type="house-config"] > #interior > .data > .interior-select').html(translation.configurator.select_interior_button);
                $('.configuring-menu div[data-type="house-config"] > #loot .title').html(translation.configurator.manage_loot_title);
                $('.configuring-menu div[data-type="house-config"] > #loot .description').html(translation.configurator.manage_loot_description);
                $('.configuring-menu div[data-type="house-config"] > #tenants .title').html(translation.configurator.manage_tenants_title);
                $('.configuring-menu div[data-type="house-config"] > #tenants .description').html(translation.configurator.manage_tenants_description);

                $('.configuring-menu div[data-type="loot-config"] > .info > .title').html(translation.configurator.loot.loot_title);
                $('.configuring-menu div[data-type="loot-config"] > .copy-object').html(translation.configurator.loot.copy_button);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #cancel-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .first #cancel-control > div').html(translation.controls.first.cancel_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #cancel-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .first #cancel-control > span').html(translation.controls.first.cancel_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #rotate-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .first #rotate-control > div').html(translation.controls.first.rotate_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #rotate-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .first #rotate-control > span').html(translation.controls.first.rotate_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #accept-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .first #accept-control > div').html(translation.controls.first.accept_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #accept-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .first #accept-control > span').html(translation.controls.first.accept_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #focus-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .first #focus-control > div, .configuring-menu div[data-type="house-config"] > .controls > #focus-control > div').html(translation.controls.first.focus_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .first #focus-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .first #focus-control > span, .configuring-menu div[data-type="house-config"] > .controls > #focus-control > span').html(translation.controls.first.focus_label);

                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #forward-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #forward-control > div').html(translation.controls.second.forward_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #forward-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #forward-control > span').html(translation.controls.second.forward_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #back-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #back-control > div').html(translation.controls.second.back_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #back-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #back-control > span').html(translation.controls.second.back_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #left-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #left-control > div').html(translation.controls.second.left_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #left-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #left-control > span').html(translation.controls.second.left_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #right-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #right-control > div').html(translation.controls.second.right_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #right-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #right-control > span').html(translation.controls.second.right_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #rotate-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #rotate-control > div').html(translation.controls.second.rotate_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #rotate-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #rotate-control > span').html(translation.controls.second.rotate_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #slowdown-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #slowdown-control > div').html(translation.controls.second.slowdown_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #slowdown-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #slowdown-control > span').html(translation.controls.second.slowdown_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #up-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #up-control > div').html(translation.controls.second.up_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #up-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #up-control > span').html(translation.controls.second.up_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #down-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #down-control > div').html(translation.controls.second.down_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #down-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #down-control > span').html(translation.controls.second.down_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #accept-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #accept-control > div').html(translation.controls.second.accept_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #accept-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #accept-control > span').html(translation.controls.second.accept_label);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #focus-control > div, .configuring-menu div[data-type="tenants-config"] > .controls > .second #focus-control > div').html(translation.controls.second.focus_key);
                $('.configuring-menu div[data-type="loot-config"] > .controls > .second #focus-control > span, .configuring-menu div[data-type="tenants-config"] > .controls > .second #focus-control > span').html(translation.controls.second.focus_label);

                
                $('.configuring-menu div[data-type="tenants-config"] > .info.peds > .title').html(translation.configurator.tenants.peds_title);
                $('.configuring-menu div[data-type="tenants-config"] > .info.weapons > .title').html(translation.configurator.tenants.weapons_title);
                $('.configuring-menu div[data-type="tenants-config"] > .info.animations > .title').html(translation.configurator.tenants.animations_title);
                $('.configuring-menu div[data-type="tenants-config"] > .copy-data').html(translation.configurator.tenants.copy_button);


                

            }
        });
    } else if (item.action == "openPlanningMenu") {
        $(`div[data-type="houses-list"]`).hide();
        $(`div[data-type="house-data"]`).hide();
        selectedHouseId = null;
        allRobberies = item.allRobberies;
        houses = item.housesList;
        informations = item.informations;
        haveStartedRobbery = item.haveStartedRobbery;

        $('.planning-menu .stop-robbery').hide();
        if (haveStartedRobbery) {
            $('.planning-menu .stop-robbery').show();
            
            if (item.stopRobberyPrice) {
                $('.planning-menu .stop-robbery > span').text((translation.stop_robbery_for_btn).format(item.stopRobberyPrice))
            } else {
                $('.planning-menu .stop-robbery > span').text(translation.stop_robbery_btn)
            }
        }

        let housesData = loadHouses(houses)
        $('.planning-menu > .menu > .main > div[data-type="houses-list"] > div').html(housesData);

        updateMenu('houses-list');
        $('.planning-menu').fadeIn(120);
        $('body').fadeIn(150);
    } else if (item.action == "closePlanningMenu") {
        $('.planning-menu').fadeOut(120);
        selectedHouseId = null;
        isMenuOpened = false;
        currentMenu = null;     
    } else if (item.action == "updatePlanningMenu") {
        if (!currentMenu) return;
        haveStartedRobbery = item.haveStartedRobbery;
        
        if (item.informations) {
            informations = item.informations
            if (selectedHouseId) {
                loadHouseData(selectedHouseId)
            }
        }

        $('.planning-menu .stop-robbery').hide();
        if (haveStartedRobbery) {
            $('.planning-menu .stop-robbery').show();

            if (item.stopRobberyPrice) {
                $('.planning-menu .stop-robbery > span').text((translation.stop_robbery_for_btn).format(item.stopRobberyPrice))
            } else {
                $('.planning-menu .stop-robbery > span').text(translation.stop_robbery_btn)
            }
        }

    } else if (item.action == "openHouseRobbery") {
        $('.house-robbery').fadeIn(120);
        if (item.noiseLevel != undefined) {
            const noiseLevel = document.getElementById('noise-level');
            noiseLevel.style.width = item.noiseLevel + '%';
        }

    } else if (item.action == "closeHouseRobbery") {
        $('.house-robbery').fadeOut(120);
        
    } else if (item.action == "updateHouseRobbery") {
        if (item.noiseLevel != undefined) updateProgressBar(item.noiseLevel);
    } else if (item.action == "openConfigurator") {
        $('.configuring-menu').fadeIn(120);
        $('.configuring-menu>.menu>div[data-type="house-config"]>#loot, .configuring-menu>.menu>div[data-type="house-config"]>#tenants').addClass('interiorNotSelected');

        pickedInterior = false;
        interiorSelected = 0;
        interiorsList = item.interiorsList;
        interiorsListKeys = Object.keys(interiorsList);
        itemsList = item.itemsList;

        pedsList = item.pedsList;
        animationsList = item.animationsList;
        weaponsList = item.weaponsList;

        if (interiorsListKeys[interiorSelected] && interiorsList[interiorsListKeys[interiorSelected]]) {
            interiorSelectedName = interiorsListKeys[interiorSelected]
            $('.configuring-menu>.menu>div[data-type="house-config"]>#interior>.data>.interior-name').text(interiorSelectedName)
        }
        $('.configuring-menu>.menu>div[data-type="loot-config"], .configuring-menu>.menu>div[data-type="tenants-config"]').hide()

        updateMenu('house-config');
    } else if (item.action == "closeConfigurator") {
        $('.configuring-menu').fadeOut(120);
        currentMenu = null;
    } else if (item.action == "copyData") {
        if (item.data) {
            const textelement = document.createElement('textarea');
            textelement.value = item.data;
            document.body.appendChild(textelement);
            textelement.select();
            document.execCommand('copy');
            document.body.removeChild(textelement);
        }
    } else if (item.action == "updateConfigurator") {
        if (item.type == 'pickedInterior') {
            pickedInterior = true;
            $('.configuring-menu>.menu>div[data-type="house-config"]>#loot, .configuring-menu>.menu>div[data-type="house-config"]>#tenants').removeClass('interiorNotSelected');
        }
        if (item.type == 'focus') {
            $('.configuring-menu').css('opacity', '1.0');
        }
        if (item.type == 'firstControls') {
            $(`.configuring-menu > .menu > div[data-type='${currentMenu}'] > .controls > .first`).show();
            $(`.configuring-menu > .menu > div[data-type='${currentMenu}'] > .controls > .second`).hide();
        }
        if (item.type == 'secondControls') {
            $(`.configuring-menu > .menu > div[data-type='${currentMenu}'] > .controls > .first`).hide();
            $(`.configuring-menu > .menu > div[data-type='${currentMenu}'] > .controls > .second`).show();
        }
        if (item.probablyLoots) {
            probablyLoots = item.probablyLoots
            loadLootConfigurator();
        }
        if (item.type == 'updatedPed') {
            selectedPed = item.selected;
            loadTenantsConfigurator('peds');
        }
        if (item.type == 'updatedAnimation') {
            selectedAnimation = item.selected;
            loadTenantsConfigurator('animations');
        }
        if (item.type == 'updatedWeapon') {
            selectedWeapon = item.selected;
            loadTenantsConfigurator('weapons');
        }
    } else if (item.action == "openSellItems") {
        if (item.type == "pawnshop") {
            $('.sell-items .center .menu .header-name span').text(translation.sell_items.header_pawnshop)
        } else if (item.type == "fence") {
            $('.sell-items .center .menu .header-name span').text(translation.sell_items.header_fence)
        }

        loadItemsForSale(item.type, item.items)
        
        currentMenu = 'sell-items';
        $('.sell-items').fadeIn(120);
        $('body').fadeIn(150);
    } else if (item.action == "closeSellItems") {

        $('.sell-items').fadeOut(120);
        $('body').fadeOut(150);
        currentMenu = null;
    }
});

$(".back").click(function() {
    if (selectedHouseId) {
        updateMenu('houses-list');
        selectedHouseId = null;
    }
    if (pickedInterior) {
        updateMenu('house-config');
        probablyLoots = [];
        $.post(`https://${GetParentResourceName()}/back`);
    }
})

$(".stop-robbery").click(function() {
    $.post(`https://${GetParentResourceName()}/stopRobbery`);
})

$(".close").click(function() {
    $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({menu: currentMenu}));
    isMenuOpened = false;
    currentMenu = null;
})

function updateMenu(newMenu) {
    if (newMenu == currentMenu) return;    
    $(`div[data-type="${currentMenu}"]`).hide();
    currentMenu = newMenu
    $(`div[data-type="${currentMenu}"]`).show();
}

$(document).on('keydown', 'body', function(e) {
    if (e.which == 27) {
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({menu: currentMenu}));
        isMenuOpened = false;
    }
})


sellItem = (itemName) => {
    let count = $(`input[data-name="${itemName}"]`).val();
    if (Number(count) >= 1) {
        $.post(`https://${GetParentResourceName()}/sellItem`, JSON.stringify({item: itemName, count: count}));
    }
}

let canPressAgain = true
buyInformation = (houseId, infoId) => {
    if (canPressAgain) {
        canPressAgain = false;
        $.post(`https://${GetParentResourceName()}/buyInformation`, JSON.stringify({houseId: houseId, infoId: infoId}));
        setTimeout(() => {
            canPressAgain = true;
        }, 500);
    }
}

startRobbery = (houseId) => {
    if (canPressAgain) {
        canPressAgain = false;
        $.post(`https://${GetParentResourceName()}/startRobbery`, JSON.stringify({houseId: houseId}));
        setTimeout(() => {
            canPressAgain = true;
        }, 500);
    }
}

function updateProgressBar(percentage) {
    const noiseLevel = document.getElementById('noise-level');
    noiseLevel.style.width = percentage + '%';

    let red, green;

    if (percentage < 50) {
        green = 255;
        red = Math.floor(5.1 * percentage);
    } else {
        red = 255;
        green = Math.floor(255 - (5.1 * (percentage - 50)));
    }

    noiseLevel.style.backgroundColor = `rgb(${red}, ${green}, 0)`;
}





document.addEventListener("keydown", (event) => {
    if (event.keyCode === 81) { // Q
        $.post(`https://${GetParentResourceName()}/focusConfigurator`);
        $('.configuring-menu').css('opacity', '0.5');
    }
});

$(".configuring-menu>.menu>div[data-type='house-config']>#interior>.data>.interior-left").click(function() {
    if (pickedInterior) return;    
    interiorSelected = interiorSelected - 1
    if (interiorsListKeys[interiorSelected] && interiorsList[interiorsListKeys[interiorSelected]]) {
        interiorSelectedName = interiorsListKeys[interiorSelected]
        $('.configuring-menu>.menu>div[data-type="house-config"]>#interior>.data>.interior-name').text(interiorSelectedName)
    } else {
        interiorSelected = interiorsListKeys.length - 1
        interiorSelectedName = interiorsListKeys[interiorSelected]
        $('.configuring-menu>.menu>div[data-type="house-config"]>#interior>.data>.interior-name').text(interiorSelectedName)
    }
})

$(".configuring-menu>.menu>div[data-type='house-config']>#interior>.data>.interior-right").click(function() {
    if (pickedInterior) return;    
    interiorSelected = interiorSelected + 1
    if (interiorsListKeys[interiorSelected] && interiorsList[interiorsListKeys[interiorSelected]]) {
        interiorSelectedName = interiorsListKeys[interiorSelected]
        $('.configuring-menu>.menu>div[data-type="house-config"]>#interior>.data>.interior-name').text(interiorSelectedName)
    } else {
        interiorSelected = 0
        interiorSelectedName = interiorsListKeys[interiorSelected]
        $('.configuring-menu>.menu>div[data-type="house-config"]>#interior>.data>.interior-name').text(interiorSelectedName)
    }
})

$(".configuring-menu>.menu>div[data-type='house-config']>#interior>.data>.interior-select").click(function() {
    if (pickedInterior) return;    
    $.post(`https://${GetParentResourceName()}/pickedInterior`, JSON.stringify({interior: interiorSelectedName}));
})

$(".configuring-menu > .menu > div[data-type='house-config'] > #enter-coords > .info > .button").click(function() {
    $.post(`https://${GetParentResourceName()}/getEnterCoords`);
})

$(".configuring-menu > .menu > div[data-type='house-config'] > #loot > .info > .button").click(function() {
    if (!pickedInterior) return;
    updateMenu('loot-config');
    loadLootConfigurator();
    $(".configuring-menu > .menu > div[data-type='loot-config'] > .controls > .first").show();
    $(".configuring-menu > .menu > div[data-type='loot-config'] > .controls > .second").hide();
    $.post(`https://${GetParentResourceName()}/lootConfigurator`);
})

$(".configuring-menu > .menu > div[data-type='house-config'] > #tenants > .info > .button").click(function() {
    if (!pickedInterior) return;    
    updateMenu('tenants-config');
    loadTenantsConfigurator();
    $(".configuring-menu > .menu > div[data-type='tenants-config'] > .controls > .first").show();
    $(".configuring-menu > .menu > div[data-type='tenants-config'] > .controls > .second").hide();
    $.post(`https://${GetParentResourceName()}/tenantsConfigurator`);
})

addLoot = (lootId) => {
    if (!pickedInterior) return;    
    $.post(`https://${GetParentResourceName()}/addLoot`, JSON.stringify({lootId: lootId}));
}

removeLoot = (lootId) => {
    if (!pickedInterior) return;    
    $.post(`https://${GetParentResourceName()}/removeLoot`, JSON.stringify({lootId: lootId}));
}

viewLoot = (lootId) => {
    if (!pickedInterior) return;    
    $.post(`https://${GetParentResourceName()}/viewLoot`, JSON.stringify({lootId: lootId}));
}

$(".configuring-menu > .menu > div[data-type='loot-config'] > .copy-object").click(function() {
    if (!pickedInterior) return;    
    $.post(`https://${GetParentResourceName()}/copyLootData`);
})





viewPedModel = (id) => {
    if (!pickedInterior) return;
    $.post(`https://${GetParentResourceName()}/setPedModel`, JSON.stringify({id: id}));
}

viewPedAnimation = (id) => {
    if (!pickedInterior) return;
    $.post(`https://${GetParentResourceName()}/setPedAnimation`, JSON.stringify({id: id}));
}

viewPedWeapon = (id) => {
    if (!pickedInterior) return;
    $.post(`https://${GetParentResourceName()}/setPedWeapon`, JSON.stringify({id: id}));
}

$(".configuring-menu > .menu > div[data-type='tenants-config'] > .copy-data").click(function() {
    if (!pickedInterior) return;    
    $.post(`https://${GetParentResourceName()}/copyTenantData`);
})