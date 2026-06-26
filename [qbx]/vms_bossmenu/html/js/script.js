let translation = {};

var number = Intl.NumberFormat('en-US', {minimumFractionDigits: 0});
String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

const defaultCSS = {
    ['--main-color']: getComputedStyle($('html').get(0)).getPropertyValue('--main-color').trim(),
    ['--main-color-hover']: getComputedStyle($('html').get(0)).getPropertyValue('--main-color-hover').trim(),
    ['--main-color-active']: getComputedStyle($('html').get(0)).getPropertyValue('--main-color-active').trim(),

    ['--scrollbar-color']: getComputedStyle($('html').get(0)).getPropertyValue('--scrollbar-color').trim(),
    ['--scrollbar-color-hover']: getComputedStyle($('html').get(0)).getPropertyValue('--scrollbar-color-hover').trim(),
    ['--scrollbar-background']: getComputedStyle($('html').get(0)).getPropertyValue('--scrollbar-background').trim(),

    ['--menu-shadow-before-color']: getComputedStyle($('html').get(0)).getPropertyValue('--menu-shadow-before-color').trim(),
    ['--menu-shadow-after-color']: getComputedStyle($('html').get(0)).getPropertyValue('--menu-shadow-after-color').trim(),

    ['--menu-background']: getComputedStyle($('html').get(0)).getPropertyValue('--menu-background').trim(),
    ['--submenu-background']: getComputedStyle($('html').get(0)).getPropertyValue('--submenu-background').trim(),
    ['--submenu-background-selected']: getComputedStyle($('html').get(0)).getPropertyValue('--submenu-background-selected').trim(),
}


function isNumberKey(evt) {
    var charCode = evt.which ? evt.which : evt.keyCode;
    if (
        charCode == 8 ||
        charCode == 46 ||
        charCode == 37 ||
        charCode == 39
    ) return true;
    
    if (
        charCode < 48 ||
        charCode > 57
    ) {
        evt.preventDefault();
        return false;
    }
    return true;
}

// UI Variables:
let canUseAgain = true;
let currentMenu = null;
let currentSubMenu = null;
let bossMenuSection = null;
let selectedOption = null;
let maxLengthGradeLabel = null;
let minGradeSalary = null;
let maxGradeSalary = null;
let menuOptions = [];
let isESX = null;

// Badges Variables:
let badgeOnlyNumbers = true;
let maxLengthBadge = 3;

// Balance Variables:
let useBuildInBalance = true;

// Cith Hall Variables:
let useCityHall = false;
let useCityHallResumes = false;
let useCityHallTaxes = false;
let taxBusinessAllowMakeDelayedDeclarations = false;
let taxBusinessPercentagePerMonthForDelay = false;

window.addEventListener("load", function() {
    $.post(`https://${GetParentResourceName()}/loaded`)
})

window.addEventListener('message', function(event) {
    var item = event.data;
    switch (item.action) {
		case 'loaded':
            let lang = item.lang;

            isESX = item.isESX;

            menuOptions = item.menuOptions;

            maxLengthGradeLabel = item.maxLengthGradeLabel;
            minGradeSalary = item.minGradeSalary;
            maxGradeSalary = item.maxGradeSalary;

            badgeOnlyNumbers = item.badgeOnlyNumbers;
            maxLengthBadge = item.maxLengthBadge;

            useBuildInBalance = item.useBuildInBalance;

            useCityHall = item.useCityHall;
            useCityHallResumes = item.useCityHallResumes;
            useCityHallTaxes = item.useCityHallTaxes;

            taxBusinessAllowMakeDelayedDeclarations = item.taxBusinessAllowMakeDelayedDeclarations;
            taxBusinessPercentagePerMonthForDelay = item.taxBusinessPercentagePerMonthForDelay;

            if (!isESX) {
                $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data').remove();
                $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data2').css({
                    left: "1em",
                    width: "58em",
                });
            }

            if (!useBuildInBalance) {
                $('.bossmenu > div> .menu > .side-bar > div[data-href="safe"]').remove();
            }

            $.ajax({
                url: '../config/translation.json',
                type: 'GET',
                dataType: 'json',
                success: function (code, statut) {
                    if (!code[lang]) {
                        translation = code["EN"];
                        console.warn(`^7Selected language ^1"${lang}"^7 not found, changed to ^2"EN"^7, configure your language in translation.json.`);
                    } else {
                        translation = code[lang];
                    }
                    
                    loadTranslation();
   
                    if (useCityHall) {
                        let { CityHall_SideBars, CityHall_Menus } = window.mySharedFunction();
                        
                        $('.bossmenu > div > .menu > .side-bar').append(`
                            ${useCityHallResumes ? (CityHall_SideBars.resumes).format(translation.bossmenu.side_bar.resumes.title, translation.bossmenu.side_bar.resumes.description) : ''}
                            ${useCityHallTaxes ? (CityHall_SideBars.taxes).format(translation.bossmenu.side_bar.taxes.title, translation.bossmenu.side_bar.taxes.description) : ''}
                        `)
        
                        $('.bossmenu > div > .menu > .main').append(`
                            ${useCityHallResumes ? (CityHall_Menus.resumes).format(
                                translation.bossmenu.resumes.list_header,
                                translation.bossmenu.resumes.list_title,
        
                                translation.bossmenu.resumes.table_citizen,
                                translation.bossmenu.resumes.table_date,
                                translation.bossmenu.resumes.table_option,
        
                                translation.bossmenu.resumes.manage_header,
                                translation.bossmenu.resumes.manage_title,
        
                                translation.bossmenu.resumes.manage_description,
                                translation.bossmenu.resumes.manage_toggle_btn,
                            ) : ''}
    
                            ${useCityHallTaxes ? (CityHall_Menus.taxes).format(
                                translation.bossmenu.taxes.taxes_header,
                                translation.bossmenu.taxes.taxes_title
                            ) : ''}
                        `)
                    } else {
                        $('.bossmenu').addClass('no_cityhall');

                        $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="count"]').css('width', '100%');
                        $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="check-resumes"]').remove();
                    }
                }
            });
            break

        case 'openBossMenu':
            BossMenu.Open(item);
            break

        case 'closeBossMenu':
            BossMenu.Close();
            break

        case 'updateBossMenu':
            if (item.actionName) {
                if (item.actionName == 'transactions') {
                    BossMenu.loadingTransactions = false;

                    BossMenu.currentPage = item.page
                    BossMenu.totalPages = Math.max(1, Math.ceil(item.total / BossMenu.itemsPerPage));

                    BossMenu.renderPage(item.transactions)
                    BossMenu.updatePagination()
                } else if (item.actionName == 'chart') {
                    BossMenu.LoadChart(item.totals)
                } 

                break;
            }
            BossMenu.Update(item);
            break

        case 'openDressingRoom':
            DressingRoom.Open(item);
            break;

        case 'closeDressingRoom':
            DressingRoom.Close();
            break;

        case 'successfulTransfer':
            $(`
                .bossmenu div[data-type="safe-manage"] input#balance-transfer-account,
                .bossmenu div[data-type="safe-manage"] input#balance-transfer-title,
                .bossmenu div[data-type="safe-manage"] input#balance-transfer-amount
            `).val('');
            break

        case 'successfulHired':
            if ($(`.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data > .closest-players > .hire-player[data-id=${item.hiredId}]`).length) {
                $(`.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data > .closest-players > .hire-player[data-id=${item.hiredId}]`).remove();
            }
            break

        case 'successfulCreationClothing':
            $('.bossmenu').removeClass('inClothesManage');
            updateBossMenu('clothing', '.bossmenu div[data-href="clothing"]');
            break

        case 'updatedClotheMax':
            $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data > div > div > div > .label[data-itemlabel="${item.item}"] > p#max`).text(item.value);
            $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data > div > div > div > div[data-type="${item.item}"] > input`).attr('max', item.value);
            break
    }
});

function closeKey(isESC) {
    if ($('.bossmenu > div > .menu > .select-clothing-gender').is(":visible")) {
        $('.bossmenu > div > .menu > .select-clothing-gender').fadeOut(150);
        if (isESC) return;
    }
    
    $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({menu: currentMenu}));
    currentMenu = null;
    currentSubMenu = null;
}

$(document).on('keydown', 'body', function(e) {
    if (e.which == 27) {
        closeKey(true)
    }
})

$(".close").click(() => {
    closeKey()
})

$(document).on('click', '.back-to-menu', function(e) {
    let backTo = $(this).data('backto');
    if (backTo == "clothing") {
        $('.bossmenu > div > .menu > .select-clothing-gender').fadeOut(150);
    }
})

$(document).on('click', '.bossmenu .side-bar .button', function(e) {
    let newMenu = $(this).data('href');
    if (newMenu == 'stash') {
        $.post(`https://${GetParentResourceName()}/openStash`);
        return;
    }
    
    updateBossMenu(newMenu, this);

    if ($('.bossmenu').hasClass('inClothesManage')) {
        $('.bossmenu').removeClass('inClothesManage');

        $.post(`https://${GetParentResourceName()}/clothingPed`, JSON.stringify({
            toggle: false
        }));
    }

})

function updateBossMenu(newMenu, _this) {
    if (newMenu == bossMenuSection) return;

    if (_this != selectedOption) {
        if (selectedOption) {
            $(selectedOption).removeClass("selected");
        }
        selectedOption = _this
        $(selectedOption).addClass("selected");
    }

    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] .header').text(translation.bossmenu.employees.manage.header);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data').empty();

    $(`div[data-type="${bossMenuSection}"]`).hide();
    bossMenuSection = newMenu
    $(`div[data-type="${bossMenuSection}"]`).show();

    if (bossMenuSection == 'safe') {
        BossMenu.RequestChart()
    } else if (bossMenuSection == 'safe-transactions') {
        BossMenu.RequestTransactions(BossMenu.currentPage)
    }
}

$(document).on('click', '.bossmenu #btn', function(e) {
    let option = $(this).attr('data-option');

    if (option == "withdraw") {
        if (!useBuildInBalance) return;
        
        renderLoading(this, translation.bossmenu.safe_manage.balance_internal.withdraw_btn)

        let amount = $('.bossmenu div[data-type="safe-manage"] input#balance-internal-amount').val();
        $.post(`https://${GetParentResourceName()}/withdraw`, JSON.stringify({
            amount: amount
        }));
        $('.bossmenu div[data-type="safe-manage"] input#balance-internal-amount').val('');

    } else if (option == "deposit") {
        if (!useBuildInBalance) return;
        
        renderLoading(this, translation.bossmenu.safe_manage.balance_internal.deposit_btn)

        let amount = $('.bossmenu div[data-type="safe-manage"] input#balance-internal-amount').val();
        $.post(`https://${GetParentResourceName()}/deposit`, JSON.stringify({
            amount: amount
        }));
        $('.bossmenu div[data-type="safe-manage"] input#balance-internal-amount').val('');

    } else if (option == "transfer") {
        if (!useBuildInBalance) return;
        
        renderLoading(this, translation.bossmenu.safe_manage.balance_transfer.transfer_btn);
        let account = $('.bossmenu div[data-type="safe-manage"] input#balance-transfer-account').val();
        let title = $('.bossmenu div[data-type="safe-manage"] input#balance-transfer-title').val();
        let amount = $('.bossmenu div[data-type="safe-manage"] input#balance-transfer-amount').val();
        $.post(`https://${GetParentResourceName()}/transfer`, JSON.stringify({
            account: account,
            title: title,
            amount: amount
        }));

    } else if (option == "get_closest_players") {
        $.post(`https://${GetParentResourceName()}/getClosestPlayers`);
        
    } else if (option == "grade_manage") {
        let id = $(this).attr('data-id');
        BossMenu.LoadGradesMenu(id)
        updateBossMenu('grades-manage')

    } else if (option == "update_label") {
        let grade = $(this).attr('data-grade');
        let gradeLabel = $('.bossmenu div[data-type="grades-manage"]>div>.side-boxes>div[data-type="grade"]>.data>#label-settings>.settings>input').val();
        $.post(`https://${GetParentResourceName()}/updateGradeLabel`, JSON.stringify({
            grade: grade,
            label: gradeLabel,
        }))

    } else if (option == "update_salary") {
        let grade = $(this).attr('data-grade');
        let gradeSalary = $('.bossmenu div[data-type="grades-manage"]>div>.side-boxes>div[data-type="grade"]>.data>#salary-settings>.settings>input').val();
        $.post(`https://${GetParentResourceName()}/updateGradeSalary`, JSON.stringify({
            grade: grade,
            salary: gradeSalary,
        }))

    } else if (option == "update_permissions") {
        let grade = $(this).attr('data-grade');

        let perm_employees_access = $('input[type="checkbox"][data-permission="employees_access"]').is(":checked");
        let perm_employees_grant_bonus = $('input[type="checkbox"][data-permission="employees_grant_bonus"]').is(":checked");
        let perm_employees_change_badge = $('input[type="checkbox"][data-permission="employees_change_badge"]').is(":checked");
        let perm_employees_change_grade = $('input[type="checkbox"][data-permission="employees_change_grade"]').is(":checked");
        let perm_employees_fire = $('input[type="checkbox"][data-permission="employees_fire"]').is(":checked");
        let perm_employees_hire = $('input[type="checkbox"][data-permission="employees_hire"]').is(":checked");
        let perm_clothing_access = $('input[type="checkbox"][data-permission="clothing_access"]').is(":checked");
        let perm_clothing_create = $('input[type="checkbox"][data-permission="clothing_create"]').is(":checked");
        let perm_clothing_modify = $('input[type="checkbox"][data-permission="clothing_modify"]').is(":checked");
        let perm_safe_access = $('input[type="checkbox"][data-permission="safe_access"]').is(":checked");
        let perm_safe_balance = $('input[type="checkbox"][data-permission="safe_balance"]').is(":checked");
        let perm_safe_withdraw = $('input[type="checkbox"][data-permission="safe_withdraw"]').is(":checked");
        let perm_safe_deposit = $('input[type="checkbox"][data-permission="safe_deposit"]').is(":checked");
        let perm_safe_transfer = $('input[type="checkbox"][data-permission="safe_transfer"]').is(":checked");
        let perm_safe_transactions = $('input[type="checkbox"][data-permission="safe_transactions"]').is(":checked");
        let perm_stash_access = $('input[type="checkbox"][data-permission="stash_access"]').is(":checked");
        let perm_announcements_access = $('input[type="checkbox"][data-permission="announcements_access"]').is(":checked");
        let perm_resumes_access = $('input[type="checkbox"][data-permission="resumes_access"]').is(":checked");
        let perm_taxes_access = $('input[type="checkbox"][data-permission="taxes_access"]').is(":checked");

        $.post(`https://${GetParentResourceName()}/updateGradePermissions`, JSON.stringify({
            grade: grade,

            perm_employees_access: perm_employees_access,
            perm_employees_grant_bonus: perm_employees_grant_bonus,
            perm_employees_change_badge: perm_employees_change_badge,
            perm_employees_change_grade: perm_employees_change_grade,
            perm_employees_fire: perm_employees_fire,
            perm_employees_hire: perm_employees_hire,
            perm_clothing_access: perm_clothing_access,
            perm_clothing_create: perm_clothing_create,
            perm_clothing_modify: perm_clothing_modify,
            perm_safe_access: perm_safe_access,
            perm_safe_balance: perm_safe_balance,
            perm_safe_withdraw: perm_safe_withdraw,
            perm_safe_deposit: perm_safe_deposit,
            perm_safe_transfer: perm_safe_transfer,
            perm_safe_transactions: perm_safe_transactions,
            perm_stash_access: perm_stash_access,
            perm_announcements_access: perm_announcements_access,
            perm_resumes_access: perm_resumes_access,
            perm_taxes_access: perm_taxes_access,
        }))

    } else if (option == "clothing_delete") {
        let id = $(this).attr('data-id');
        $.post(`https://${GetParentResourceName()}/clothingDelete`, JSON.stringify({
            id: id
        }))

    } else if (option == "clothing_manage") {
        let id = $(this).attr('data-id');

        $.post(`https://${GetParentResourceName()}/clothingPed`, JSON.stringify({
            toggle: true,
            id: id
        }), function(data) {
            if (data) {
                BossMenu.LoadClothesMenu(id, data)
            }
        })

    } else if (option == "clothing_create") {
        $('.bossmenu > div > .menu > .select-clothing-gender').css('display', 'flex');
        $('.bossmenu > div > .menu > .select-clothing-gender > div').show()
        
    } else if (option == "selected_clothing_gender") {
        let gender = $(this).attr('data-gender');

        $.post(`https://${GetParentResourceName()}/clothingPed`, JSON.stringify({
            toggle: true,
            gender: gender
        }), function(data) {
            $('.bossmenu > div > .menu > .select-clothing-gender').hide();
            $('.bossmenu > div > .menu > .select-clothing-gender > div').hide()
            if (data) {
                BossMenu.LoadClothesMenu(null, data)
            }
        })
        
    } else if (option == "save_clothing") {
        let id = $(this).attr('data-id');
        saveClothing(id);

    } else if (option == "employees") {
        updateBossMenu(option, '.bossmenu div[data-href="employees"]');

    } else if (option == "safe-transactions" || option == "safe-manage" || option == "resumes") {
        updateBossMenu(option)

    }
})

$('.bossmenu div[data-type="safe-transactions"] #prev-page').click(function() {
    if (!useBuildInBalance) return;
    if (!BossMenu.CanRequestTransactions()) return;

    if (BossMenu.currentPage > 1) {
        BossMenu.currentPage--;
        BossMenu.RequestTransactions(BossMenu.currentPage);
    }
});

$('.bossmenu div[data-type="safe-transactions"] #next-page').click(function() {
    if (!useBuildInBalance) return;
    if (!BossMenu.CanRequestTransactions()) return;

    if (BossMenu.currentPage < BossMenu.totalPages) {
        BossMenu.currentPage++;
        BossMenu.RequestTransactions(BossMenu.currentPage);
    }
});

$(document).on('change', '.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data input[type="checkbox"]', function(e) {
    const checkbox = $(this);
    const parentDiv = checkbox.closest('div[data-type]');
    
    if (checkbox.is(':checked')) {
        parentDiv.removeClass('disabled')
        parentDiv.find('input[oninput]').prop('disabled', false);
    } else {
        parentDiv.addClass('disabled')
        parentDiv.find('input[oninput]').prop('disabled', true);
    }
});


$(document).on('change', '.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data2 #permissions-settings input[type="checkbox"][data-permission]', function(e) {
    const checkbox = $(this);
    const permission = checkbox.attr('data-permission')

    if (checkbox.is(':checked')) {
        if ((permission == 'employees_grant_bonus' || permission == 'employees_change_badge' || permission == 'employees_change_grade' || permission == 'employees_fire' || permission == 'employees_hire') && !$('input[type="checkbox"][data-permission="employees_access"]').is(":checked")) {
            $(`input[type="checkbox"][data-permission="employees_access"]`).prop('checked', true);
            
        } else if ((permission == 'clothing_create' || permission == 'clothing_modify') && !$('input[type="checkbox"][data-permission="clothing_access"]').is(":checked")) {
            $(`input[type="checkbox"][data-permission="clothing_access"]`).prop('checked', true);

        } else if ((permission == 'safe_balance' || permission == 'safe_withdraw' || permission == 'safe_deposit' || permission == 'safe_transfer' || permission == 'safe_transactions')) {
            if ((permission == 'safe_withdraw' || permission == 'safe_deposit' || permission == 'safe_transfer') && !$('input[type="checkbox"][data-permission="safe_balance"]').is(":checked")) {
                $(`input[type="checkbox"][data-permission="safe_balance"]`).prop('checked', true);
            }
            if (!$('input[type="checkbox"][data-permission="safe_access"]').is(":checked")) {
                $(`input[type="checkbox"][data-permission="safe_access"]`).prop('checked', true);
            }
        }
    } else {
        if (permission == 'employees_access') {
            $(`
                input[type="checkbox"][data-permission="employees_grant_bonus"],
                input[type="checkbox"][data-permission="employees_change_badge"],
                input[type="checkbox"][data-permission="employees_change_grade"],
                input[type="checkbox"][data-permission="employees_fire"],
                input[type="checkbox"][data-permission="employees_hire"]
            `).prop('checked', false);

        } else if (permission == 'clothing_access') {
            $(`
                input[type="checkbox"][data-permission="clothing_create"],
                input[type="checkbox"][data-permission="clothing_modify"]
            `).prop('checked', false);
            
        } else if (permission == 'safe_access') {
            $(`
                input[type="checkbox"][data-permission="safe_balance"],
                input[type="checkbox"][data-permission="safe_withdraw"],
                input[type="checkbox"][data-permission="safe_deposit"],
                input[type="checkbox"][data-permission="safe_transfer"],
                input[type="checkbox"][data-permission="safe_transactions"]
            `).prop('checked', false);
            
        } else if (permission == 'safe_balance') {
            $(`
                input[type="checkbox"][data-permission="safe_withdraw"],
                input[type="checkbox"][data-permission="safe_deposit"],
                input[type="checkbox"][data-permission="safe_transfer"]
            `).prop('checked', false);
        }
    }
});


function renderLoading(_this, label) {
    $(_this).html(`
        <section class="dots-container">
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </section>
    `)
    setTimeout(() => {
        $(_this).html(label)
    }, 1200);
}

function changeClothe(item, item2) {
    let min = Number($(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item}"] > input`).attr('min'));
    let max = Number($(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item}"] > input`).attr('max'));

    let inputValue = $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item}"] > input`)
    if (item2.includes('_2')) $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item2}"] > input`).val(0);

    let inputValue2 = $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item2}"] > input`).val();

    if (min > inputValue.val()) inputValue.val(Number(min));
    if (max < inputValue.val()) inputValue.val(Number(max));

    $.post(`https://${GetParentResourceName()}/changeClothePed`, JSON.stringify({
        type: item,
        item: Number(inputValue.val()),
        texture: Number(inputValue2)
    }));
}

function removeSuffix(text) {
    if (text.endsWith('_1') || text.endsWith('_2')) {
        return text.slice(0, -2);
    }
    return text;
}

function getClotheGrades() {
    const inputs = document.querySelectorAll(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > .box[data-type="settings"] .data input[type="checkbox"]`);
    const checkedData = [];

    inputs.forEach(input => {
        if (input.checked) {
            const dataId = input.getAttribute('data-id');
            if (dataId) {
                checkedData.push(Number(dataId));
            }
        }
    });

    return checkedData;
}

function getCurrentClotheValue(elementName, item, texture) {
    const useItem = document.querySelector(`div[data-type="clothing-manage"] div[data-type="${elementName}"] .custom-checkbox > input[type="checkbox"]`).checked;
    if (!useItem) return {
        [item]: undefined,
        [texture]: undefined,
    }

    return {
        [item]: $(`div[data-type="clothing-manage"] [data-type="${elementName}"] div[data-type="${item}"] > input`).val(),
        [texture]: $(`div[data-type="clothing-manage"] [data-type="${elementName}"] div[data-type="${texture}"] > input`).val(),
    };
}

function saveClothing(id) {
    let label = null;

    $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .title > input').removeClass('required');

    if (!id) {
        label = $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .title > input').val();
        if (!label || label.length < 3) {
            return setTimeout(() => $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .title > input').addClass('required'), 10);
        }
    }
    
    let {helmet_1, helmet_2} = getCurrentClotheValue('helmet', 'helmet_1', 'helmet_2');
    let {glasses_1, glasses_2} = getCurrentClotheValue('glasses', 'glasses_1', 'glasses_2');
    let {mask_1, mask_2} = getCurrentClotheValue('mask', 'mask_1', 'mask_2');
    let {tshirt_1, tshirt_2} = getCurrentClotheValue('tshirt', 'tshirt_1', 'tshirt_2');
    let {torso_1, torso_2} = getCurrentClotheValue('torso', 'torso_1', 'torso_2');
    let {decals_1, decals_2} = getCurrentClotheValue('decals', 'decals_1', 'decals_2');
    let {arms, arms_2} = getCurrentClotheValue('arms', 'arms', 'arms_2');
    let {pants_1, pants_2} = getCurrentClotheValue('pants', 'pants_1', 'pants_2');
    let {shoes_1, shoes_2} = getCurrentClotheValue('shoes', 'shoes_1', 'shoes_2');
    let {bproof_1, bproof_2} = getCurrentClotheValue('bproof', 'bproof_1', 'bproof_2');
    let {chain_1, chain_2} = getCurrentClotheValue('chain', 'chain_1', 'chain_2');
    let {watches_1, watches_2} = getCurrentClotheValue('watches', 'watches_1', 'watches_2');
    let {bracelets_1, bracelets_2} = getCurrentClotheValue('bracelets', 'bracelets_1', 'bracelets_2');
    let {bags_1, bags_2} = getCurrentClotheValue('bags', 'bags_1', 'bags_2');

    $.post(`https://${GetParentResourceName()}/saveClothing`, JSON.stringify({
        label: label,
        id: id,
        grades: getClotheGrades(),
        helmet_1: helmet_1,
        helmet_2: helmet_2,
        glasses_1: glasses_1,
        glasses_2: glasses_2,
        mask_1: mask_1,
        mask_2: mask_2,
        tshirt_1: tshirt_1,
        tshirt_2: tshirt_2,
        torso_1: torso_1,
        torso_2: torso_2,
        decals_1: decals_1,
        decals_2: decals_2,
        arms: arms,
        arms_2: arms_2,
        pants_1: pants_1,
        pants_2: pants_2,
        shoes_1: shoes_1,
        shoes_2: shoes_2,
        bproof_1: bproof_1,
        bproof_2: bproof_2,
        chain_1: chain_1,
        chain_2: chain_2,
        watches_1: watches_1,
        watches_2: watches_2,
        bracelets_1: bracelets_1,
        bracelets_2: bracelets_2,
        bags_1: bags_1,
        bags_2: bags_2,
    }));
}

function changeArrow(item, item2, curDirection) {
    direction = curDirection;

    if ($(`div[data-type="${removeSuffix(item)}"]`).hasClass('disabled')) return;

    let min = Number($(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item}"] > input`).attr('min'));
    let max = Number($(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item}"] > input`).attr('max'));
    let inputValue = $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item}"] > input`)

    if (curDirection == 'left') {
        inputValue.val(Number(inputValue.val()) - 1)
    } else {
        inputValue.val(Number(inputValue.val()) + 1)
    }

    if (min > inputValue.val()) inputValue.val(Number(min));
    if (max < inputValue.val()) inputValue.val(Number(max));
    
    if (item2.includes('_2')) $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item2}"] > input`).val(0);
    let inputValue2 = $(`.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data div[data-type="${item2}"] > input`).val();
    
    $.post(`https://${GetParentResourceName()}/changeClothePed`, JSON.stringify({
        type: item,
        item: Number(inputValue.val()),
        texture: Number(inputValue2)
    }));
}

function changeKey(evt, item, texture) {
    var charCode = evt.which ? evt.which : evt.keyCode;
    if (charCode == 38) {
        changeArrow(item, texture, 'right')
        return false;
    } else if (charCode == 40) {
        changeArrow(item, texture, 'left')
        return false;
    }

    return true;
}

$(document).on('click', '.dressing-room > div > .header .my-clothes', function(e) {
    $.post(`https://${GetParentResourceName()}/wearClothes`, JSON.stringify({}));
})

$(document).on('click', '.dressing-room > div > .menu > div > div', function(e) {
    let id = $(this).data('id');
    $.post(`https://${GetParentResourceName()}/wearClothes`, JSON.stringify({
        id: id,
    }));
})