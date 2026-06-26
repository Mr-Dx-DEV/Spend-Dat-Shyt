const loadTranslation = () => {
    // Select Clothing Gender Menu:
    $('.bossmenu .select-clothing-gender .name').text(translation.bossmenu.clothing.select_clothing_gender_title);
    $('.bossmenu>div>.menu>.select-clothing-gender>div>.menu > div[data-gender="0"]').text(translation.bossmenu.clothing.gender_m);
    $('.bossmenu>div>.menu>.select-clothing-gender>div>.menu > div[data-gender="1"]').text(translation.bossmenu.clothing.gender_f);

        
    // Side bar:
    if (useBuildInBalance) {
        $('.bossmenu > div> .menu > .side-bar > div[data-href="safe"] > .name > p.title').text(translation.bossmenu.side_bar.safe.title);
        $('.bossmenu > div> .menu > .side-bar > div[data-href="safe"] > .name > p.description').text(translation.bossmenu.side_bar.safe.description);
    };

    $('.bossmenu > div > .menu > .side-bar > div[data-href="employees"] > .name > p.title').text(translation.bossmenu.side_bar.employees.title);
    $('.bossmenu > div > .menu > .side-bar > div[data-href="employees"] > .name > p.description').text(translation.bossmenu.side_bar.employees.description);

    $('.bossmenu > div > .menu > .side-bar > div[data-href="grades"] > .name > p.title').text(translation.bossmenu.side_bar.grades.title);
    $('.bossmenu > div > .menu > .side-bar > div[data-href="grades"] > .name > p.description').text(translation.bossmenu.side_bar.grades.description);

    $('.bossmenu > div > .menu > .side-bar > div[data-href="clothing"] > .name > p.title').text(translation.bossmenu.side_bar.clothing.title);
    $('.bossmenu > div > .menu > .side-bar > div[data-href="clothing"] > .name > p.description').text(translation.bossmenu.side_bar.clothing.description);

    $('.bossmenu > div > .menu > .side-bar > div[data-href="stash"] > .name > p.title').text(translation.bossmenu.side_bar.stash.title);
    $('.bossmenu > div > .menu > .side-bar > div[data-href="stash"] > .name > p.description').text(translation.bossmenu.side_bar.stash.description);

    $('.bossmenu > div > .menu > .side-bar > div[data-href="announcements"] > .name > p.title').text(translation.bossmenu.side_bar.announcements.title);
    $('.bossmenu > div > .menu > .side-bar > div[data-href="announcements"] > .name > p.description').text(translation.bossmenu.side_bar.announcements.description);


    // Employees:
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="count"] .header').text(translation.bossmenu.employees.count.header);

    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="check-resumes"] .header').text(translation.bossmenu.employees.resumes.header);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="check-resumes"] .title').text(translation.bossmenu.employees.resumes.title);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="check-resumes"] .btn[data-option="resumes"] p').text(translation.bossmenu.employees.resumes.view_resumes_btn);

    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="list"] .header').text(translation.bossmenu.employees.list.header);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="list"]>.employees-list>#employees-table>thead>tr>th>span#badge').text(translation.bossmenu.employees.list.table.badge);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="list"]>.employees-list>#employees-table>thead>tr>th>span#employee').text(translation.bossmenu.employees.list.table.employee);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="list"]>.employees-list>#employees-table>thead>tr>th>span#grade').text(translation.bossmenu.employees.list.table.grade);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="list"]>.employees-list>#employees-table>thead>tr>th>span#option').text(translation.bossmenu.employees.list.table.option);
    
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] .header').text(translation.bossmenu.employees.manage.header);
    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] .btn[data-option="get_closest_players"] p').text(translation.bossmenu.employees.manage.search_closest_btn);
   
    
    // Grades:
    $('.bossmenu div[data-type="grades"] > div > .side-boxes > div[data-type="list"] > .header').text(translation.bossmenu.grades.header);
    $('.bossmenu div[data-type="grades"] > div > .side-boxes > div[data-type="list"] > .title').text(translation.bossmenu.grades.title);
    
    
    // Grades Manage:
    $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .header').text(translation.bossmenu.grades_manage.header);
    
    
    // Clothing:
    $('.bossmenu div[data-type="clothing"] > div > .side-boxes > div[data-type="list"] > .header').text(translation.bossmenu.clothing.header);
    $('.bossmenu div[data-type="clothing"] > div > .side-boxes > div[data-type="list"] > .title').text(translation.bossmenu.clothing.title);
    
    
    // Clothing Manage:
    $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="settings"] > .title').text(translation.bossmenu.clothing_manage.settings.title);
    $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="settings"] .btn[data-option="save_clothing"] p').text(translation.bossmenu.clothing_manage.settings.save_btn);
        

    // Safe:
    $('.bossmenu div[data-type="safe"]>div>.side-boxes>.box[data-type="balance"] .header').text(translation.bossmenu.safe.balance.header);
    $('.bossmenu div[data-type="safe"]>div>.side-boxes>.box[data-type="balance"] .buttons > .btn[data-option="safe-manage"').text(translation.bossmenu.safe.balance.make_transaction_btn);
    
    $('.bossmenu div[data-type="safe"]>div>.side-boxes>.box[data-type="balance-chart"] .header').text(translation.bossmenu.safe.balance_chart.header);
    $('.bossmenu div[data-type="safe"]>div>.side-boxes>.box[data-type="balance-chart"] .title').text(translation.bossmenu.safe.balance_chart.title);
    $('.bossmenu div[data-type="safe"]>div>.side-boxes>.box[data-type="balance-chart"] .buttons > .btn[data-option="safe-transactions"]').text(translation.bossmenu.safe.balance_chart.view_transactions_btn);
        
        
    // Safe Manage:
    if (useBuildInBalance) {
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance"] .header').text(translation.bossmenu.safe_manage.balance.header);
    
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-account-name"] .header').text(translation.bossmenu.safe_manage.account_name.header);
    
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-internal"] .header').text(translation.bossmenu.safe_manage.balance_internal.header);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-internal"] .title').text(translation.bossmenu.safe_manage.balance_internal.title);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-internal"] > label#balance-internal-amount').text(translation.bossmenu.safe_manage.balance_internal.label_amount);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-internal"] .buttons > .btn[data-option="withdraw"]').text(translation.bossmenu.safe_manage.balance_internal.withdraw_btn);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-internal"] .buttons > .btn[data-option="deposit"]').text(translation.bossmenu.safe_manage.balance_internal.deposit_btn);
    
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transactions"] .header').text(translation.bossmenu.safe_manage.balance_transactions.header);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transactions"] .title').text(translation.bossmenu.safe_manage.balance_transactions.title);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transactions"] .buttons > .btn[data-option="safe-transactions"]').text(translation.bossmenu.safe_manage.balance_transactions.view_transactions_btn);
    
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transfer"] .header').text(translation.bossmenu.safe_manage.balance_transfer.header);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transfer"] .title').text(translation.bossmenu.safe_manage.balance_transfer.title);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transfer"] > .data > label#balance-transfer-account').text(translation.bossmenu.safe_manage.balance_transfer.label_account);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transfer"] > .data > label#balance-transfer-title').text(translation.bossmenu.safe_manage.balance_transfer.label_title);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transfer"] > .data > label#balance-transfer-amount').text(translation.bossmenu.safe_manage.balance_transfer.label_amount);
        $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-transfer"] .buttons > .btn[data-option="transfer"]').text(translation.bossmenu.safe_manage.balance_transfer.transfer_btn);
    
    
        // Safe Transactions:
        $('.bossmenu div[data-type="safe-transactions"] .header').text(translation.bossmenu.safe_transactions.header);
        $('.bossmenu div[data-type="safe-transactions"] .title').text(translation.bossmenu.safe_transactions.title);
    
        $('.bossmenu div[data-type="safe-transactions"] .transactions-block > #transactions-table > thead > tr > th#id').html(translation.bossmenu.safe_transactions.table.id);
        $('.bossmenu div[data-type="safe-transactions"] .transactions-block > #transactions-table > thead > tr > th#executor').html(translation.bossmenu.safe_transactions.table.executor);
        $('.bossmenu div[data-type="safe-transactions"] .transactions-block > #transactions-table > thead > tr > th#type').html(translation.bossmenu.safe_transactions.table.type);
        $('.bossmenu div[data-type="safe-transactions"] .transactions-block > #transactions-table > thead > tr > th#amount').html(translation.bossmenu.safe_transactions.table.amount);
        $('.bossmenu div[data-type="safe-transactions"] .transactions-block > #transactions-table > thead > tr > th#title').html(translation.bossmenu.safe_transactions.table.title);
        $('.bossmenu div[data-type="safe-transactions"] .transactions-block > #transactions-table > thead > tr > th#date').html(translation.bossmenu.safe_transactions.table.date);
    };

        
    // Announcements:
    $('.bossmenu div[data-type="announcements"]>div>.side-boxes>.box[data-type="announcements"] .header').text(translation.bossmenu.announcements.header);
    $('.bossmenu div[data-type="announcements"]>div>.side-boxes>.box[data-type="announcements"] .title').text(translation.bossmenu.announcements.title);
        
        
    // Dressing Room:
    $('.dressing-room .header > .name').text(translation.dressing_room.menu_title);
    $('.dressing-room .header > .my-clothes').text(translation.dressing_room.my_clothes_btn);
}

const formatDate = (timestamp) => {
    const date = new Date((Number(timestamp) * 1000));
    let hour = date.getHours();
    let minute = date.getMinutes();
    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();
    if (hour < 10) hour = '0' + hour
    if (minute < 10) minute = '0' + minute
    if (day < 10) day = '0' + day
    if (month < 10) month = '0' + month

    return { date: day + '.' + month + '.' + year, time: hour + ':' + minute }
};

const BossMenu = {
    chartInstance: null,
    
    isResumesAllowed: false,
    resumes: null,
    isTaxesAllowed: false,
    taxes: null,
    clothingGradesAccess: null,
    
    type: null,
    company: [],
    transactions: [],
    employees: [],
    grades: [],
    gradesPermissions: [],
    clothing: [],

    useStash: false,
    useBadgesSystem: false,

    myPermissions: [],
    
    itemsPerPage: 10,
    currentPage: 1,

    loadingTransactions: false,
    requestCooldown: 200,
    lastTransactionRequest: 0,
    
    LoadRootCSS: function(css) {
        for (const [cssName, cssValue] of Object.entries(defaultCSS)) {
            $('html').get(0).style.setProperty(cssName, cssValue);
        }

        if (css['--main-color']) $('html').get(0).style.setProperty('--main-color', css['--main-color']);
        if (css['--main-color-hover']) $('html').get(0).style.setProperty('--main-color-hover', css['--main-color-hover']);
        if (css['--main-color-active']) $('html').get(0).style.setProperty('--main-color-active', css['--main-color-active']);
        if (css['--scrollbar-color']) $('html').get(0).style.setProperty('--scrollbar-color', css['--scrollbar-color']);
        if (css['--scrollbar-color-hover']) $('html').get(0).style.setProperty('--scrollbar-color-hover', css['--scrollbar-color-hover']);
        if (css['--scrollbar-background']) $('html').get(0).style.setProperty('--scrollbar-background', css['--scrollbar-background']);
        if (css['--menu-shadow-before-color']) $('html').get(0).style.setProperty('--menu-shadow-before-color', `radial-gradient(circle, ${css['--menu-shadow-before-color']} 0%, rgba(255, 255, 255, 0.0) 70%)`);
        if (css['--menu-shadow-after-color']) $('html').get(0).style.setProperty('--menu-shadow-after-color', `radial-gradient(circle, ${css['--menu-shadow-after-color']} 0%, rgba(255, 255, 255, 0.0) 70%)`);
        if (css['--menu-background']) $('html').get(0).style.setProperty('--menu-background', css['--menu-background']);
        if (css['--submenu-background']) $('html').get(0).style.setProperty('--submenu-background', css['--submenu-background']);
        if (css['--submenu-background-selected']) $('html').get(0).style.setProperty('--submenu-background-selected', css['--submenu-background-selected']);
    },

    GradeHavePermission: function(grade, action) {
        grade = Number(grade);
        if (this.gradesPermissions[grade]) {
            if (this.gradesPermissions[grade] == 'max') return 'max';
            if (this.gradesPermissions[grade] && this.gradesPermissions[grade][action]) return true;
        }

        return false;
    },

    HavePermission: function(action) {
        if ((action == 'resumesAccess' || action == 'taxesAccess') && this.type == 'gang') return false;
        if (action == 'safeTransfer' && !menuOptions[this.type]?.AllowAnyTransfers) return false;
        if (action == 'announcementsAccess' && !menuOptions[this.type]?.ShowAnnouncements) return false;
        
        if (this.myPermissions == 'max' || this.myPermissions[action]) return true;

        return false;
    },

    BuildChartData: function(totals) {

        const xValues = [];
        const yValues = [];

        const now = new Date();

        for (let i = 6; i >= 0; i--) {

            const d = new Date();
            d.setDate(now.getDate() - i);

            const dayStr = d.toISOString().split('T')[0];

            xValues.push(dayStr);
            yValues.push(totals[dayStr] || 0);

        }

        return { xValues, yValues };
    },

    LoadChart: function(totals) {
        const { xValues, yValues } = this.BuildChartData(totals);

        if (!BossMenu.chartInstance) {
            BossMenu.chartInstance = new Chart("myChart", {
                type: "bar",
                data: {
                    labels: xValues,
                    datasets: [{
                        backgroundColor: getComputedStyle($('html').get(0)).getPropertyValue('--main-color').trim(),
                        data: yValues
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    legend: {display: false}
                }
            });
        } else {
            BossMenu.chartInstance.data.labels = xValues;
            BossMenu.chartInstance.data.datasets[0].data = yValues;
            BossMenu.chartInstance.update();
        }
    },

    GetTransactionType: function(type) {
        if (type == "withdraw") {
            return `<span class="transaction-type-withdraw"><i class="fa-solid fa-money-bill-transfer"></i> ${translation.bossmenu.safe_transactions.types.withdraw}</span>`

        } else if (type == "deposit") {
            return `<span class="transaction-type-deposit"><i class="fa-solid fa-money-bill-transfer"></i> ${translation.bossmenu.safe_transactions.types.deposit}</span>`
            
        } else if (type == "transfer_outgoing") {
            return `<span class="transaction-type-transfer_outgoing"><i class="fa-solid fa-shuffle"></i> ${translation.bossmenu.safe_transactions.types.transfer_outgoing}</span>`
            
        } else if (type == "transfer_incoming") {
            return `<span class="transaction-type-transfer_incoming"><i class="fa-solid fa-shuffle"></i> ${translation.bossmenu.safe_transactions.types.transfer_incoming}</span>`
            
        } else if (type == "tax_payment") {
            return `<span class="transaction-type-tax_payment"><i class="fa-solid fa-percent"></i> ${translation.bossmenu.safe_transactions.types.tax_payment}</span>`

        } else if (type == "payout") {
            return `<span class="transaction-type-payout"><i class="fa-solid fa-hand-holding-dollar"></i> ${translation.bossmenu.safe_transactions.types.payout}</span>`

        }
    },

    renderPage: function(transactions) {
        if (!useBuildInBalance) return;
        if (!this.HavePermission('safeTransactions')) return;

        const tbody = $('.bossmenu div[data-type="safe-transactions"] .transactions-block > #transactions-table tbody');
        tbody.empty();

        transactions.forEach(item => {
            let {date, time} = formatDate(Number(item.date));

            tbody.append(`
                <tr>
                    <td>${item.id}</td>
                    <td>${item.executor}</td>
                    <td>${this.GetTransactionType(item.type)}</td>
                    <td>${translation.currency}${item.amount}</td>
                    <td>${item.title}</td>
                    <td>${date} ${time}</td>
                </tr>
            `);
        });
    },
    
    updatePagination: function() {
        $('#prev-page').prop('disabled', this.currentPage === 1);
        $('#next-page').prop('disabled', this.currentPage === this.totalPages);

        $('#page-info').text(
            translation.bossmenu.safe_transactions.page.format(this.currentPage, this.totalPages)
        );
    },

    CanRequestTransactions: function() {
        if (this.loadingTransactions)
            return false;
        
        const now = Date.now()

        if (now - this.lastTransactionRequest < this.requestCooldown)
            return false;

        this.lastTransactionRequest = now

        
        $('.bossmenu div[data-type="safe-transactions"] #prev-page, .bossmenu div[data-type="safe-transactions"] #next-page').prop('disabled', true)
        setTimeout(() => {
            $('.bossmenu div[data-type="safe-transactions"] #prev-page, .bossmenu div[data-type="safe-transactions"] #next-page').prop('disabled', false)
        }, 200)
        
        return true
    },

    RequestTransactions: function(page) {
        $.post(`https://${GetParentResourceName()}/getTransactionsPage`, JSON.stringify({
            page: page
        }));
    },

    RequestChart: function() {
        $.post(`https://${GetParentResourceName()}/getChart`, JSON.stringify({}));
    },

    LoadMenu: function() {
        let firstMenu = null;

        $('.bossmenu > div > .menu > .side-bar > div').hide();
        $('.bossmenu').removeClass(function(index, className) {
            return className.split(' ').filter(cls => cls !== 'bossmenu').join(' ');
        });

        if (useCityHall && useCityHallTaxes) {
            if (this.HavePermission('taxesAccess')) {
                firstMenu = 'taxes';
                $(`.bossmenu .menu > .side-bar > div[data-href="taxes"]`).show();
            }
        }
        if (useCityHall && useCityHallResumes) {
            if (this.HavePermission('resumesAccess')) {
                firstMenu = 'resumes';
                $(`.bossmenu .menu > .side-bar > div[data-href="resumes"]`).show();
            } else {
                $('.bossmenu').addClass('noResumesAccess');
            }
        }
        if (this.HavePermission('announcementsAccess')) {
            firstMenu = 'announcements';
            $(`.bossmenu .menu > .side-bar > div[data-href="announcements"]`).show();
        }

        if (this.HavePermission('stashAccess') && this.useStash) {
            firstMenu = 'stash';
            $(`.bossmenu .menu > .side-bar > div[data-href="stash"]`).show();
        }
        
        if (this.HavePermission('safeAccess') && useBuildInBalance) {
            firstMenu = 'safe';
            $(`.bossmenu .menu > .side-bar > div[data-href="safe"]`).show();

            if (!this.HavePermission('safeBalance')) $('.bossmenu').addClass('noSafeBalance');
            if (!this.HavePermission('safeWithdraw')) $('.bossmenu').addClass('noSafeWithdraw');
            if (!this.HavePermission('safeDeposit')) $('.bossmenu').addClass('noSafeDeposit');
            if (!this.HavePermission('safeTransfer')) $('.bossmenu').addClass('noSafeTransfer');
            if (!this.HavePermission('safeTransactions')) $('.bossmenu').addClass('noSafeTransactions');

        }
        if (this.HavePermission('clothingAccess')) {
            firstMenu = 'clothing';
            $(`.bossmenu .menu > .side-bar > div[data-href="clothing"]`).show();
        }
        if (this.myPermissions == 'max') {
            firstMenu = 'grades';
            $(`.bossmenu .menu > .side-bar > div[data-href="grades"]`).show();
        }
        if (this.HavePermission('employeesAccess')) {
            firstMenu = 'employees';
            $(`.bossmenu .menu > .side-bar > div[data-href="employees"]`).show();

            if (
                !this.HavePermission('employeesGrantBonus') &&
                !this.HavePermission('employeesChangeBadge') &&
                !this.HavePermission('employeesChangeGrade') &&
                !this.HavePermission('employeesFire') &&
                !this.HavePermission('employeesHire')
            ) $('.bossmenu').addClass('noEmployeesHireManage');

            if (!this.HavePermission('employeesHire')) $('.bossmenu').addClass('noEmployeesHire');
            
        }

        this.LoadMenusData();

        $('.bossmenu').css('display', 'flex');
        $('.bossmenu > div').fadeIn(120);

        updateBossMenu(firstMenu, `.bossmenu div[data-href="${firstMenu}"]`);        
    },

    LoadMenusData: function(vals) {
        if (this.HavePermission('safeBalance') && useBuildInBalance) {
            $('.bossmenu div[data-type="safe"]>div>.side-boxes>.box[data-type="balance"] .title').text(translation.currency + ' ' + number.format(this.company.balance));
            $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance"] .title').text(translation.currency + ' ' + number.format(this.company.balance));
        }

        if (this.company.accountName && useBuildInBalance) {
            $('.bossmenu div[data-type="safe-manage"]>div>.side-boxes>.box[data-type="balance-account-name"] .title').text(this.company.accountName);
        } else {
            $('.bossmenu').addClass('noAccouneName');
        }

        if (!vals || vals.employees) {
            if (this.HavePermission('employeesAccess') && this.employees) {
                let employeesData = ''
                $('.bossmenu div[data-type="employees"] > div > .side-boxes > .box[data-type="list"] > .employees-list > #employees-table th#table-badge-element').hide();
                if (this.useBadgesSystem) $('.bossmenu div[data-type="employees"] > div > .side-boxes > .box[data-type="list"] > .employees-list > #employees-table th#table-badge-element').show();

                let isHaveAccesToOptions = (this.HavePermission('employeesGrantBonus') || this.HavePermission('employeesChangeGrade') || this.HavePermission('employeesFire'))
                $('.bossmenu div[data-type="employees"] > div > .side-boxes > .box[data-type="list"] > .employees-list > #employees-table th.table-last').hide();
                if (isHaveAccesToOptions) $('.bossmenu div[data-type="employees"] > div > .side-boxes > .box[data-type="list"] > .employees-list > #employees-table th.table-last').show();

                for (const [k, v] of Object.entries(this.employees)) {
                    employeesData = employeesData + `
                        <tr>
                            <td class="table-first"><element class="${v.isOnline ? 'online' : 'offline'}" id="player-status"></element></td>
                            ${this.useBadgesSystem ? `<td>${v.badge || '-'}</td>` : ''}
                            <td>${v.name}</td>
                            <td>${v.job ? v.job.grade_label : '?'}</td>
                            ${isHaveAccesToOptions ? `<td class="table-last"><div onclick="BossMenu.ManageEmployee('${v.name}', '${v.identifier}', ${v.badge || null})">${translation.bossmenu.employees.list.manage_btn}</div></td>` : ''}
                        </tr>
                    `
                }
                $('.bossmenu div[data-type="employees"] > div > .side-boxes > .box[data-type="list"] > .employees-list > #employees-table tbody').html(employeesData);
                $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="count"] .title').html(this.employees.length + (this.maxEmployees ? `<span>/${this.maxEmployees}</span>` : ``));
            }
        }

        if (this.grades && this.myPermissions == 'max') {
            let gradesList = ''
            for (const [id, v] of Object.entries(this.grades)) {
                gradesList += `
                <div>
                    <div class="title"><span>#${id}</span> ${v.label || v.name}</div>
                    <div class="btn" id="btn" data-option="grade_manage" data-id="${id}">${translation.bossmenu.grades.manage_btn}</div>
                </div>
                `
            }
            $('.bossmenu div[data-type="grades"] > div > .side-boxes > div[data-type="list"] > .grades-list').html(gradesList)
        }

        if (this.clothing && this.HavePermission('clothingAccess')) {
            let clothingList = this.HavePermission('clothingCreate') ? `
                <div class="add-new" id="btn" data-option="clothing_create">
                    <div class="create-new">
                        <i class="fa-solid fa-plus"></i>
                    </div>
                </div>
            ` : ``

            for (const [id, v] of Object.entries(this.clothing)) {
                clothingList += `
                    <div>
                        <div class="title"><span class="${v.gender == 0 ? 'male' : 'female'}">${v.gender == 0 ? translation.bossmenu.clothing.gender_m : translation.bossmenu.clothing.gender_f}</span> ${v.name}</div>
                        ${this.HavePermission('clothingModify') ? `
                            <div id="btn" data-option="clothing_delete" data-id="${id}"><i class="fa-solid fa-trash-can"></i></div>
                            <div class="btn" id="btn" data-option="clothing_manage" data-id="${id}">${translation.bossmenu.clothing.manage_btn}</div>
                        ` : ``}
                    </div>
                `
            }
            $('.bossmenu div[data-type="clothing"] > div > .side-boxes > div[data-type="list"] > .clothing-list').html(clothingList)
        }
        
        if (this.HavePermission('resumesAccess')) {
            // CityHall Resume's - loader:
            if (this.isResumesAllowed != undefined) {
                if (this.isResumesAllowed) {
                    $('.bossmenu div[data-type="resumes"] div[data-type="manage"] > .description > span').addClass('active')
                } else {
                    $('.bossmenu div[data-type="resumes"] div[data-type="manage"] > .description > span').removeClass('active')
                }
                if (this.resumes) {
                    let resumesList = ``
                    let { CityHall_ResumesElement } = window.mySharedFunction();
                    for (const [_, data] of Object.entries(this.resumes)) {
                        let element = CityHall_ResumesElement;
                        let {date, time} = formatDate(data.date)
                        resumesList += element.format(data.sender_name, date + ' ' + time, data.sender)
                    }
                    $('div[data-type="resumes"] .side-boxes > div[data-type="list"] > .resumes-list > table > tbody').html(resumesList);
                }
                $('.bossmenu div[data-type="resumes"] div[data-type="manage"] > .description > span').html(this.isResumesAllowed ? translation.bossmenu.resumes.manage_description_active : translation.bossmenu.resumes.manage_description_not_active);
            }
        }

        if (this.HavePermission('taxesAccess')) {
            // CityHall Taxes - loader:
            if (this.isTaxesAllowed != undefined) {
                if (this.taxes) {
                    let { LoadTaxesMenu } = window.mySharedFunction();
                    $('div[data-type="taxes"] .side-boxes > div[data-type="list"] > .taxes-list').html(LoadTaxesMenu(this.taxes, 'vms_bossmenu'));
                }
            }
        }

        if (!vals || vals.announcements) {
            if (this.HavePermission('announcementsAccess')) {
                let announcementsData = ''
                for (const [k, v] of Object.entries(this.company.announcements)) {
                    if (v) {
                        announcementsData = announcementsData + `
                            <div id="${v.type}">
                                <div class="user">
                                    <div class="avatar"><i class="fa-solid fa-user"></i></div>
                                    <div class="name">${v.name}</div>
                                </div>
                                <div class="message">${v.message}</div>
                            </div>
                        `
                    }
                }
                $('.bossmenu div[data-type="announcements"] .announcements-messages').html(announcementsData);
                let announcementsChatElement = document.getElementById("announcements-chat");
                announcementsChatElement.scrollTop = announcementsChatElement.scrollHeight;
            }
        }
    },

    LoadGradesMenu: function(id) {
        let jobData = this.grades[(id).toString()] || this.grades[Number(id)];
        if (!jobData) {
            return;
        }
        
        $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"]').attr('data-id', id);
        $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .title').text(jobData.label || jobData.name);

        if (isESX) {
            $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data').html(`
                ${menuOptions[this.type]?.AllowManageGradeLabel ? `
                    <div id="label-settings">
                        <div class="title">${translation.bossmenu.grades_manage.grade_name_label}</div>
                        <div class="settings">
                            <input value="${jobData.label}" onpaste="return false" maxlength="${maxLengthGradeLabel}">
                            <div class="btn" id="btn" data-grade="${id}" data-option="update_label">${translation.bossmenu.grades_manage.grade_name_save_btn}</div>
                        </div>
                    </div>
                ` : ''}
    
                ${menuOptions[this.type]?.AllowManageGradeSalary ? `
                    <div id="salary-settings">
                        <div class="title">${translation.bossmenu.grades_manage.salary_label}</div>
                        <div class="description">${(translation.bossmenu.grades_manage.salary_range_label).format(minGradeSalary, maxGradeSalary)}</div>
        
                        <div class="settings">
                            <input value="${jobData.salary}" onkeypress="return isNumberKey(event)" onpaste="return false">
                            <div class="btn" id="btn" data-grade="${id}" data-option="update_salary">${translation.bossmenu.grades_manage.salary_save_btn}</div>
                        </div>
                    </div>
                ` : ''}
            `)

            if (!menuOptions[this.type]?.AllowManageGradeLabel && !menuOptions[this.type]?.AllowManageGradeSalary) {
                $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data').attr('style', 'display: none')
                $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data2').attr('style', 'left: 1em; width: 58em');
            } else {
                $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data').removeAttr('style')
                $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data2').removeAttr('style');
            }
        }

        let employeesAccess = this.GradeHavePermission(id, 'employeesAccess');
        let employeesGrantBonus = this.GradeHavePermission(id, 'employeesGrantBonus');
        let employeesChangeBadge = this.GradeHavePermission(id, 'employeesChangeBadge');
        let employeesChangeGrade = this.GradeHavePermission(id, 'employeesChangeGrade');
        let employeesFire = this.GradeHavePermission(id, 'employeesFire');
        let employeesHire = this.GradeHavePermission(id, 'employeesHire');
        let clothingAccess = this.GradeHavePermission(id, 'clothingAccess');
        let clothingCreate = this.GradeHavePermission(id, 'clothingCreate');
        let clothingModify = this.GradeHavePermission(id, 'clothingModify');
        let safeAccess = this.GradeHavePermission(id, 'safeAccess');
        let safeBalance = this.GradeHavePermission(id, 'safeBalance');
        let safeWithdraw = this.GradeHavePermission(id, 'safeWithdraw');
        let safeDeposit = this.GradeHavePermission(id, 'safeDeposit');
        let safeTransfer = this.GradeHavePermission(id, 'safeTransfer');
        let safeTransactions = this.GradeHavePermission(id, 'safeTransactions');
        let stashAccess = this.GradeHavePermission(id, 'stashAccess');
        let announcementsAccess = this.GradeHavePermission(id, 'announcementsAccess');
        let resumesAccess = this.GradeHavePermission(id, 'resumesAccess');
        let taxesAccess = this.GradeHavePermission(id, 'taxesAccess');

        $('.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"] > .data2').html(`
            <div id="permissions-settings">
                <div class="title">${translation.bossmenu.grades_manage.permissions_label}</div>
                <div class="settings">
                    <p>${translation.bossmenu.grades_manage.permissions_list.employees_label}</p>
                    <div>
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${employeesAccess ? `checked="checked"`: ''} ${employeesAccess == 'max' ? `disabled`: ''} data-permission="employees_access">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.employees_access}</p>
                        </div>
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${employeesGrantBonus ? `checked="checked"`: ''} ${employeesGrantBonus == 'max' ? `disabled`: ''} data-permission="employees_grant_bonus">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.employees_grant_bonus}</p>
                        </div>
                        ${this.useBadgesSystem ? `
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${employeesChangeBadge ? `checked="checked"`: ''} ${employeesChangeBadge == 'max' ? `disabled`: ''} data-permission="employees_change_badge">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.employees_change_badge}</p>
                            </div>
                        `: ''}
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${employeesChangeGrade ? `checked="checked"`: ''} ${employeesChangeGrade == 'max' ? `disabled`: ''} data-permission="employees_change_grade">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.employees_change_grade}</p>
                        </div>
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${employeesFire ? `checked="checked"`: ''} ${employeesFire == 'max' ? `disabled`: ''} data-permission="employees_fire">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.employees_fire}</p>
                        </div>
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${employeesHire ? `checked="checked"`: ''} ${employeesHire == 'max' ? `disabled`: ''} data-permission="employees_hire">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.employees_hire}</p>
                        </div>
                    </div>
                    <hr>

                    <p>${translation.bossmenu.grades_manage.permissions_list.clothing_label}</p>
                    <div>
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${clothingAccess ? `checked="checked"`: ''} ${clothingAccess == 'max' ? `disabled`: ''} data-permission="clothing_access">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.clothing_access}</p>
                        </div>
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${clothingCreate ? `checked="checked"`: ''} ${clothingCreate == 'max' ? `disabled`: ''} data-permission="clothing_create">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.clothing_create}</p>
                        </div>
                        <div>
                            <label class="custom-checkbox">
                                <input type="checkbox" ${clothingModify ? `checked="checked"`: ''} ${clothingModify == 'max' ? `disabled`: ''} data-permission="clothing_modify">
                                <div class="checkmark"></div>
                            </label>
                            <p>${translation.bossmenu.grades_manage.permissions_list.clothing_modify}</p>
                        </div>
                    </div>
                    <hr>
                    
                    ${useBuildInBalance ? `
                        <p>${translation.bossmenu.grades_manage.permissions_list.safe_label}</p>
                        <div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${safeAccess ? `checked="checked"`: ''} ${safeAccess == 'max' ? `disabled`: ''} data-permission="safe_access">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.safe_access}</p>
                            </div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${safeBalance ? `checked="checked"`: ''} ${safeBalance == 'max' ? `disabled`: ''} data-permission="safe_balance">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.safe_balance}</p>
                            </div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${safeWithdraw ? `checked="checked"`: ''} ${safeWithdraw == 'max' ? `disabled`: ''} data-permission="safe_withdraw">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.safe_withdraw}</p>
                            </div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${safeDeposit ? `checked="checked"`: ''} ${safeDeposit == 'max' ? `disabled`: ''} data-permission="safe_deposit">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.safe_deposit}</p>
                            </div>
                            ${menuOptions[this.type]?.AllowAnyTransfers ? `
                                <div>
                                    <label class="custom-checkbox">
                                        <input type="checkbox" ${safeTransfer ? `checked="checked"`: ''} ${safeTransfer == 'max' ? `disabled`: ''} data-permission="safe_transfer">
                                        <div class="checkmark"></div>
                                    </label>
                                    <p>${translation.bossmenu.grades_manage.permissions_list.safe_transfer}</p>
                                </div>
                            `: ''}
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${safeTransactions ? `checked="checked"`: ''} ${safeTransactions == 'max' ? `disabled`: ''} data-permission="safe_transactions">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.safe_transactions}</p>
                            </div>
                        </div>
                        <hr>
                    `: ``}

                    ${this.useStash ? `
                        <p>${translation.bossmenu.grades_manage.permissions_list.stash_label}</p>
                        <div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${stashAccess ? `checked="checked"`: ''} ${stashAccess == 'max' ? `disabled`: ''} data-permission="stash_access">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.stash_access}</p>
                            </div>
                        </div>
                        <hr>
                    ` : ''}

                    ${menuOptions[this.type]?.ShowAnnouncements ? `
                        <p>${translation.bossmenu.grades_manage.permissions_list.announcements_label}</p>
                        <div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${announcementsAccess ? `checked="checked"`: ''} ${announcementsAccess == 'max' ? `disabled`: ''} data-permission="announcements_access">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.announcements_access}</p>
                            </div>
                        </div>
                        <hr>
                    ` : ''}

                    ${useCityHall && useCityHallResumes && this.type == 'job' && `
                        <p>${translation.bossmenu.grades_manage.permissions_list.resumes_label}</p>
                        <div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${resumesAccess ? `checked="checked"`: ''} ${resumesAccess == 'max' ? `disabled`: ''} data-permission="resumes_access">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.resumes_access}</p>
                            </div>
                        </div>
                        <hr>
                    ` || ''}
                    
                    ${useCityHall && useCityHallTaxes && this.type == 'job' && `
                        <p>${translation.bossmenu.grades_manage.permissions_list.taxes_label}</p>
                        <div>
                            <div>
                                <label class="custom-checkbox">
                                    <input type="checkbox" ${taxesAccess ? `checked="checked"`: ''} ${taxesAccess == 'max' ? `disabled`: ''} data-permission="taxes_access">
                                    <div class="checkmark"></div>
                                </label>
                                <p>${translation.bossmenu.grades_manage.permissions_list.taxes_access}</p>
                            </div>
                        </div>
                    ` || ''}

                    <div class="btn" id="btn" data-option="update_permissions" data-grade="${id}">${translation.bossmenu.grades_manage.permissions_save_btn}</div>
                </div>
            </div>
            
        `)
    },

    LoadClothesMenu: function(id, data) {
        BossMenu.clothingGradesAccess = data.clothing ? data.clothing.grades : [];

        $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .title > input').removeClass('required');

        $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .title').html((translation.bossmenu.clothing_manage.clothes.title).format(data.clothing ? data.clothing.name : `<input type="text" maxlength="45">`));
        $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > div[data-type="clothes"] > .data').html(`
            <div data-type="helmet" ${data.values['helmet_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/helmet.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.helmet_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['helmet_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="helmet_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.helmet_1}</p>
                            <p id="max">${data.maxVals['helmet_1']}</p>
                        </div>
                        <div data-type="helmet_1">
                            <div id="left" onclick="changeArrow('helmet_1', 'helmet_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'helmet_1', 'helmet_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('helmet_1', 'helmet_2')" min="-1" value="${data.values['helmet_1'] || -1}" max="${data.maxVals['helmet_1']}" ${data.values['helmet_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('helmet_1', 'helmet_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="helmet_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.helmet_2}</p>
                            <p id="max">${data.maxVals['helmet_2']}</p>
                        </div>
                        <div data-type="helmet_2">
                            <div id="left" onclick="changeArrow('helmet_2', 'helmet_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'helmet_2', 'helmet_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('helmet_2', 'helmet_1')" min="0" value="${data.values['helmet_2'] || 0}" max="${data.maxVals['helmet_2']}" ${data.values['helmet_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('helmet_2', 'helmet_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="glasses" ${data.values['glasses_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/glasses.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.glasses_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['glasses_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="glasses_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.glasses_1}</p>
                            <p id="max">${data.maxVals['glasses_1']}</p>
                        </div>
                        <div data-type="glasses_1">
                            <div id="left" onclick="changeArrow('glasses_1', 'glasses_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'glasses_1', 'glasses_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('glasses_1', 'glasses_2')" min="0" value="${data.values['glasses_1'] || 0}" max="${data.maxVals['glasses_1']}" ${data.values['glasses_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('glasses_1', 'glasses_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="glasses_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.glasses_2}</p>
                            <p id="max">${data.maxVals['glasses_2']}</p>
                        </div>
                        <div data-type="glasses_2">
                            <div id="left" onclick="changeArrow('glasses_2', 'glasses_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'glasses_2', 'glasses_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('glasses_2', 'glasses_1')" min="0" value="${data.values['glasses_2'] || 0}" max="${data.maxVals['glasses_2']}" ${data.values['glasses_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('glasses_2', 'glasses_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="mask" ${data.values['mask_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/mask.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.mask_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['mask_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="mask_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.mask_1}</p>
                            <p id="max">${data.maxVals['mask_1']}</p>
                        </div>
                    
                        <div data-type="mask_1">
                            <div id="left" onclick="changeArrow('mask_1', 'mask_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'mask_1', 'mask_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('mask_1', 'mask_2')" min="0" value="${data.values['mask_1'] || 0}" max="${data.maxVals['mask_1']}" ${data.values['mask_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('mask_1', 'mask_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="mask_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.mask_2}</p>
                            <p id="max">${data.maxVals['mask_2']}</p>
                        </div>

                        <div data-type="mask_2">
                            <div id="left" onclick="changeArrow('mask_2', 'mask_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'mask_2', 'mask_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('mask_2', 'mask_1')" min="0" value="${data.values['mask_2'] || 0}" max="${data.maxVals['mask_2']}" ${data.values['mask_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('mask_2', 'mask_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="tshirt" ${data.values['tshirt_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/tshirt.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.tshirt_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['tshirt_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="tshirt_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.tshirt_1}</p>
                            <p id="max">${data.maxVals['tshirt_1']}</p>
                        </div>
                        <div data-type="tshirt_1">
                            <div id="left" onclick="changeArrow('tshirt_1', 'tshirt_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'tshirt_1', 'tshirt_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('tshirt_1', 'tshirt_2')" min="0" value="${data.values['tshirt_1'] || 0}" max="${data.maxVals['tshirt_1']}" ${data.values['tshirt_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('tshirt_1', 'tshirt_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="tshirt_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.tshirt_2}</p>
                            <p id="max">${data.maxVals['tshirt_2']}</p>
                        </div>
                        <div data-type="tshirt_2">
                            <div id="left" onclick="changeArrow('tshirt_2', 'tshirt_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'tshirt_2', 'tshirt_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('tshirt_2', 'tshirt_1')" min="0" value="${data.values['tshirt_2'] || 0}" max="${data.maxVals['tshirt_2']}" ${data.values['tshirt_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('tshirt_2', 'tshirt_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="torso" ${data.values['torso_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/torso.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.torso_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['torso_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="torso_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.torso_1}</p>
                            <p id="max">${data.maxVals['torso_1']}</p>
                        </div>
                        <div data-type="torso_1">
                            <div id="left" onclick="changeArrow('torso_1', 'torso_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'torso_1', 'torso_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('torso_1', 'torso_2')" min="0" value="${data.values['torso_1'] || 0}" max="${data.maxVals['torso_1']}" ${data.values['torso_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('torso_1', 'torso_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="torso_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.torso_2}</p>
                            <p id="max">${data.maxVals['torso_2']}</p>
                        </div>
                        <div data-type="torso_2">
                            <div id="left" onclick="changeArrow('torso_2', 'torso_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'torso_2', 'torso_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('torso_2', 'torso_1')" min="0" value="${data.values['torso_2'] || 0}" max="${data.maxVals['torso_2']}" ${data.values['torso_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('torso_2', 'torso_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="decals" ${data.values['decals_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/decals.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.decals_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['decals_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="decals_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.decals_1}</p>
                            <p id="max">${data.maxVals['decals_1']}</p>
                        </div>
                        <div data-type="decals_1">
                            <div id="left" onclick="changeArrow('decals_1', 'decals_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'decals_1', 'decals_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('decals_1', 'decals_2')" min="0" value="${data.values['decals_1'] || 0}" max="${data.maxVals['decals_1']}" ${data.values['decals_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('decals_1', 'decals_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="decals_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.decals_2}</p>
                            <p id="max">${data.maxVals['decals_2']}</p>
                        </div>
                        <div data-type="decals_2">
                            <div id="left" onclick="changeArrow('decals_2', 'decals_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'decals_2', 'decals_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('decals_2', 'decals_1')" min="0" value="${data.values['decals_2'] || 0}" max="${data.maxVals['decals_2']}" ${data.values['decals_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('decals_2', 'decals_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="arms" ${data.values['arms'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/arms.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.arms_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['arms'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="arms">
                            <p>${translation.bossmenu.clothing_manage.clothes.arms}</p>
                            <p id="max">${data.maxVals['arms']}</p>
                        </div>
                        <div data-type="arms">
                            <div id="left" onclick="changeArrow('arms', 'arms_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'arms', 'arms_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('arms', 'arms_2')" min="0" value="${data.values['arms'] || 0}" max="${data.maxVals['arms']}" ${data.values['arms'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('arms', 'arms_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="arms_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.arms_2}</p>
                            <p id="max">${data.maxVals['arms_2']}</p>
                        </div>
                        <div data-type="arms_2">
                            <div id="left" onclick="changeArrow('arms_2', 'arms', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'arms_2', 'arms')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('arms_2', 'arms')" min="0" value="${data.values['arms_2'] || 0}" max="${data.maxVals['arms_2']}" ${data.values['arms_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('arms_2', 'arms', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="pants" ${data.values['pants_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/pants.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.pants_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['pants_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="pants_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.pants_1}</p>
                            <p id="max">${data.maxVals['pants_1']}</p>
                        </div>
                        <div data-type="pants_1">
                            <div id="left" onclick="changeArrow('pants_1', 'pants_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'pants_1', 'pants_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('pants_1', 'pants_2')" min="0" value="${data.values['pants_1'] || 0}" max="${data.maxVals['pants_1']}" ${data.values['pants_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('pants_1', 'pants_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="pants_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.pants_2}</p>
                            <p id="max">${data.maxVals['pants_2']}</p>
                        </div>
                        <div data-type="pants_2">
                            <div id="left" onclick="changeArrow('pants_2', 'pants_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'pants_2', 'pants_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('pants_2', 'pants_1')" min="0" value="${data.values['pants_2'] || 0}" max="${data.maxVals['pants_2']}" ${data.values['pants_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('pants_2', 'pants_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="shoes" ${data.values['shoes_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/shoes.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.shoes_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['shoes_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="shoes_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.shoes_1}</p>
                            <p id="max">${data.maxVals['shoes_1']}</p>
                        </div>
                        <div data-type="shoes_1">
                            <div id="left" onclick="changeArrow('shoes_1', 'shoes_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'shoes_1', 'shoes_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('shoes_1', 'shoes_2')" min="0" value="${data.values['shoes_1'] || 0}" max="${data.maxVals['shoes_1']}" ${data.values['shoes_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('shoes_1', 'shoes_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="shoes_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.shoes_2}</p>
                            <p id="max">${data.maxVals['shoes_2']}</p>
                        </div>
                        <div data-type="shoes_2">
                            <div id="left" onclick="changeArrow('shoes_2', 'shoes_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'shoes_2', 'shoes_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('shoes_2', 'shoes_1')" min="0" value="${data.values['shoes_2'] || 0}" max="${data.maxVals['shoes_2']}" ${data.values['shoes_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('shoes_2', 'shoes_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div data-type="bproof" ${data.values['bproof_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/bproof.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.bproof_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['bproof_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="bproof_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.bproof_1}</p>
                            <p id="max">${data.maxVals['bproof_1']}</p>
                        </div>
                        <div data-type="bproof_1">
                            <div id="left" onclick="changeArrow('bproof_1', 'bproof_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'bproof_1', 'bproof_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('bproof_1', 'bproof_2')" min="0" value="${data.values['bproof_1'] || 0}" max="${data.maxVals['bproof_1']}" ${data.values['bproof_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('bproof_1', 'bproof_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="bproof_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.bproof_2}</p>
                            <p id="max">${data.maxVals['bproof_2']}</p>
                        </div>
                        <div data-type="bproof_2">
                            <div id="left" onclick="changeArrow('bproof_2', 'bproof_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'bproof_2', 'bproof_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('bproof_2', 'bproof_1')" min="0" value="${data.values['bproof_2'] || 0}" max="${data.maxVals['bproof_2']}" ${data.values['bproof_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('bproof_2', 'bproof_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div data-type="chain" ${data.values['chain_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/chain.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.chain_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['chain_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="chain_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.chain_1}</p>
                            <p id="max">${data.maxVals['chain_1']}</p>
                        </div>
                        <div data-type="chain_1">
                            <div id="left" onclick="changeArrow('chain_1', 'chain_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'chain_1', 'chain_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('chain_1', 'chain_2')" min="0" value="${data.values['chain_1'] || 0}" max="${data.maxVals['chain_1']}" ${data.values['chain_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('chain_1', 'chain_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="chain_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.chain_2}</p>
                            <p id="max">${data.maxVals['chain_2']}</p>
                        </div>
                        <div data-type="chain_2">
                            <div id="left" onclick="changeArrow('chain_2', 'chain_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'chain_2', 'chain_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('chain_2', 'chain_1')" min="0" value="${data.values['chain_2'] || 0}" max="${data.maxVals['chain_2']}" ${data.values['chain_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('chain_2', 'chain_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div data-type="watches" ${data.values['watches_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/watches.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.watches_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['watches_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="watches_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.watches_1}</p>
                            <p id="max">${data.maxVals['watches_1']}</p>
                        </div>
                        <div data-type="watches_1">
                            <div id="left" onclick="changeArrow('watches_1', 'watches_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'watches_1', 'watches_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('watches_1', 'watches_2')" min="-1" value="${data.values['watches_1'] || -1}" max="${data.maxVals['watches_1']}" ${data.values['watches_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('watches_1', 'watches_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="watches_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.watches_2}</p>
                            <p id="max">${data.maxVals['watches_2']}</p>
                        </div>
                        <div data-type="watches_2">
                            <div id="left" onclick="changeArrow('watches_2', 'watches_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'watches_2', 'watches_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('watches_2', 'watches_1')" min="0" value="${data.values['watches_2'] || 0}" max="${data.maxVals['watches_2']}" ${data.values['watches_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('watches_2', 'watches_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="bracelets" ${data.values['bracelets_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/bracelets.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.bracelets_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['bracelets_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="bracelets_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.bracelets_1}</p>
                            <p id="max">${data.maxVals['bracelets_1']}</p>
                        </div>
                        <div data-type="bracelets_1">
                            <div id="left" onclick="changeArrow('bracelets_1', 'bracelets_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'bracelets_1', 'bracelets_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('bracelets_1', 'bracelets_2')" min="-1" value="${data.values['bracelets_1'] || -1}" max="${data.maxVals['bracelets_1']}" ${data.values['bracelets_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('bracelets_1', 'bracelets_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="bracelets_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.bracelets_2}</p>
                            <p id="max">${data.maxVals['bracelets_2']}</p>
                        </div>
                        <div data-type="bracelets_2">
                            <div id="left" onclick="changeArrow('bracelets_2', 'bracelets_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'bracelets_2', 'bracelets_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('bracelets_2', 'bracelets_1')" min="0" value="${data.values['bracelets_2'] || 0}" max="${data.maxVals['bracelets_2']}" ${data.values['bracelets_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('bracelets_2', 'bracelets_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-type="bags" ${data.values['bags_1'] === undefined ? 'class="disabled"' : ''}>
                <img src="./images/clothes/bags.svg">
                <p>${translation.bossmenu.clothing_manage.clothes.bags_label}</p>
                <label class="custom-checkbox">
                    <input type="checkbox" ${data.values['bags_1'] != undefined ? 'checked="checked"': ''}>
                    <div class="checkmark"></div>
                </label>
                <div>
                    <div>
                        <div class="label" data-itemlabel="bags_1">
                            <p>${translation.bossmenu.clothing_manage.clothes.bags_1}</p>
                            <p id="max">${data.maxVals['bags_1']}</p>
                        </div>
                        <div data-type="bags_1">
                            <div id="left" onclick="changeArrow('bags_1', 'bags_2', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'bags_1', 'bags_2')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('bags_1', 'bags_2')" min="0" value="${data.values['bags_1'] || 0}" max="${data.maxVals['bags_1']}" ${data.values['bags_1'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('bags_1', 'bags_2', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                    <div>
                        <div class="label" data-itemlabel="bags_2">
                            <p>${translation.bossmenu.clothing_manage.clothes.bags_2}</p>
                            <p id="max">${data.maxVals['bags_2']}</p>
                        </div>
                        <div data-type="bags_2">
                            <div id="left" onclick="changeArrow('bags_2', 'bags_1', 'left')"><i class="fa-solid fa-caret-left"></i></div>
                            <input onkeydown="return changeKey(event, 'bags_2', 'bags_1')" onkeypress="return isNumberKey(event)" onpaste="return false" oninput="changeClothe('bags_2', 'bags_1')" min="0" value="${data.values['bags_2'] || 0}" max="${data.maxVals['bags_2']}" ${data.values['bags_2'] === undefined ? 'disabled' : ''}>
                            <div id="right" onclick="changeArrow('bags_2', 'bags_1', 'right')"><i class="fa-solid fa-caret-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        `);

        let settingsData = ''
        for (const [gradeId, grade] of Object.entries(BossMenu.grades)) {
            settingsData += `
                <div>
                    <label class="custom-checkbox">
                        <input data-id="${Number(gradeId)}" ${BossMenu.clothingGradesAccess.includes(Number(gradeId)) ? 'checked="checked"' : ''} type="checkbox">
                        <div class="checkmark"></div>
                    </label>
                    <div>${grade.label || grade.name}</div>
                </div>
            `
        };
        $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > .box[data-type="settings"] > .data').html(settingsData);

        if (typeof id !== 'undefined') {
            $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > .box[data-type="settings"] .btn').attr('data-id', id);
        } else {
            $('.bossmenu div[data-type="clothing-manage"] > div > .side-boxes > .box[data-type="settings"] .btn').removeAttr('data-id');
        }

        $('.bossmenu').addClass('inClothesManage');
        updateBossMenu('clothing-manage')
    },

    Open: function(data) {
        currentMenu = 'bossmenu';

        this.LoadRootCSS(data.customCSS)

        this.type = data.type;

        this.company = data.company;
        this.employees = data.employees != undefined ? data.employees : [];
        this.grades = data.grades != undefined ? data.grades : [];
        this.gradesPermissions = data.gradesPermissions;
        this.clothing = data.clothing != undefined ? data.clothing : [];
        
        this.useStash = data.useStash;
        this.useBadgesSystem = data.useBadgesSystem;

        this.myPermissions = data.myPermissions;

        this.maxEmployees = data.maxEmployees;

        this.isResumesAllowed = data.isResumesAllowed;
        this.resumes = data.resumes;

        this.isTaxesAllowed = data.isTaxesAllowed;
        this.taxes = data.taxes;

        this.currentPage = 1;

        $('.bossmenu').removeClass('inClothesManage');
        $.post(`https://${GetParentResourceName()}/clothingPed`, JSON.stringify({
            toggle: false
        }));

        $('.bossmenu > div > .header > .name').text((translation.bossmenu.menu_title).format(data.jobLabel));

        this.LoadMenu();
    },

    Close: function() {
        $(`.bossmenu, .bossmenu > div`).fadeOut(120)
        $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data').empty();
        currentMenu = null;
    },

    Update: function(data) {
        let updates = []
        
        if (this.HavePermission('employeesHire')) {
            updates.closestPlayers = data.closestPlayers ?? false;
            if (data.closestPlayers != undefined) {
                let players = data.closestPlayers
                if (players.length < 1) {
                    $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data').html(`<span class="hire-list">${translation.bossmenu.employees.manage.no_players}</span>`);
                    return;
                }
    
                let hireData = ''
                
                for (const [k, v] of Object.entries(players)) {
                    hireData += `
                        <div class="hire-player" data-playerid="${v}">
                            <span>${(translation.bossmenu.employees.manage.citizen).format(v)}</span>
                            <div class="btn" id="btn" onclick="BossMenu.HireEmployee(this, ${v})">${translation.bossmenu.employees.manage.hire_btn}</div>
                        </div>
                    `;
                };
    
                $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data').html(`
                    <div class="closest-players">
                        ${hireData}
                    </div>
                `);
                return;
            }
        }
        
        if (this.HavePermission('safeBalance') && useBuildInBalance) {
            updates.balance = data.balance ?? false;
            if (data.balance != undefined) this.company.balance = data.balance;
        }
        
        if (this.HavePermission('employeesAccess')) {
            updates.employees = data.employees ?? false;
            if (data.employees != undefined) this.employees = data.employees;
        }

        if (this.myPermissions == 'max') {
            updates.grades = data.grades ?? false;
            if (data['update-grades']) {
                this.grades = data.grades || []
                
                let element = `.bossmenu div[data-type="grades-manage"] > div > .side-boxes > div[data-type="grade"][data-id="${data['grades-id']}"]`
                if (data['grades-id'] != undefined && $(element).length > 0) {
                    let jobData = this.grades[(data['grades-id']).toString()] || this.grades[Number(data['grades-id'])];
                    if (jobData) {
                        $(element + ' > .title').html(jobData.label || jobData.name)
                    }
                }
            };
            
            updates.gradePermissions = data.gradePermissions ?? false;
            if (data['update-gradePermissions']) this.gradesPermissions = data.gradePermissions;
        }

        if (this.HavePermission('clothingAccess')) {
            updates.clothings = data.clothings ?? false;
            if (data['update-clothings']) this.clothing = data.clothings || [];
        }

        if (this.HavePermission('resumesAccess')) {
            if (data.isResumesAllowed != undefined) this.isResumesAllowed = data.isResumesAllowed;
        }

        if (this.HavePermission('taxesAccess')) {
            updates.taxes = data.taxes ?? false;
            if (data.taxes != undefined) this.taxes = data.taxes;
        }

        this.LoadMenusData(updates);
    },

    HireEmployee: function(_this, playerid) {
        if (!playerid) return;
        renderLoading(_this, translation.bossmenu.employees.manage.hire_btn)
        $.post(`https://${GetParentResourceName()}/hireEmployee`, JSON.stringify({playerId: playerid}));
    },

    BonusEmployee: function(name, identifier) {
        let bonusMoney = $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data > .employee-manage > #bonus > div > input').val();
        if (identifier && bonusMoney && bonusMoney >= 1) {
            $.post(`https://${GetParentResourceName()}/bonusEmployee`, JSON.stringify({
                identifier: identifier,
                bonusMoney: bonusMoney,
                playerName: name,
            }));
            $(".bossmenu #bonus-money").val('');
        }
    },

    ChangeBadgeEmployee: function(identifier) {
        let badge = $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data > .employee-manage > #badge > div > input').val();
        if (identifier) {
            $.post(`https://${GetParentResourceName()}/changeBadgeEmployee`, JSON.stringify({
                identifier: identifier,
                badge: String(badge),
            }));
            $(".bossmenu #badge").val('');
        }
    },

    ChangeGradeEmployee: function(identifier, grade) {
        if (identifier && grade != undefined) {
            $.post(`https://${GetParentResourceName()}/changeGradeEmployee`, JSON.stringify({identifier: identifier, grade: grade}));
        }
    },

    FireEmployee: function(identifier) {
        if (!identifier) return;
        $.post(`https://${GetParentResourceName()}/fireEmployee`, JSON.stringify({identifier: identifier}));
        $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data').empty();
    },

    ManageEmployee: function(name, identifier, currentBadge) {
        $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] .header').text(name);
        
        let gradesData = ``
        if (this.HavePermission('employeesChangeGrade')) {
            for (const [key, grade] of Object.entries(this.grades)) {
                if (grade) {
                    gradesData += `
                        <div class="changegrade" onclick='BossMenu.ChangeGradeEmployee("${identifier}", "${key}")'>${grade.label || grade.name}</div>
                    `
                }
            }
        }
        
        $('.bossmenu div[data-type="employees"]>div>.side-boxes>.box[data-type="manage"] div.data').html(`
            <div class="employee-manage">
                ${this.HavePermission('employeesGrantBonus') ? `
                    <div id="bonus">
                        <span>${translation.bossmenu.employees.manage.bonus_label}</span>
                        <div>
                            <input type="number" id="bonus-money">
                            <div class="bonus" onclick="BossMenu.BonusEmployee('${name}', '${identifier}')">${translation.bossmenu.employees.manage.bonus_btn}</div>
                        </div>
                    </div>
                    <hr>
                ` : ''}

                ${this.useBadgesSystem && this.HavePermission('employeesChangeBadge') && `
                    <div id="badge">
                        <span>${translation.bossmenu.employees.manage.badge_label}</span>
                        <div>
                            <input ${badgeOnlyNumbers ? `onkeypress="return isNumberKey(event)"` : ''} type="text" maxlength="${maxLengthBadge}" id="badge-id" value="${currentBadge ? String(currentBadge) : ''}">
                            <div class="badge-id" onclick="BossMenu.ChangeBadgeEmployee('${identifier}')">${translation.bossmenu.employees.manage.badge_btn}</div>
                        </div>
                    </div>
                    <hr>
                ` || ''}

                ${this.HavePermission('employeesChangeGrade') ? `
                    <div id="grades-list">
                        <span>${translation.bossmenu.employees.manage.setjob_label}</span>
                        <div>
                            ${gradesData}
                        </div>
                    </div>
                    <hr>
                ` : ''}

                ${this.HavePermission('employeesFire') ? `
                    <div id="fire">
                        <span>${translation.bossmenu.employees.manage.fire_label}</span>
                        <div>
                            <div class="fire" onclick="BossMenu.FireEmployee('${identifier}')">${translation.bossmenu.employees.manage.fire_btn}</div>
                        </div>
                    </div>
                ` : ''}
            </div>
        `);
    },
};

const DressingRoom = {
    LoadClothing: function(clothes) {
        let clothesData = ''

        for (const [k, v] of Object.entries(clothes)) {
            clothesData += `
                <div data-id="${v.id}">
                    <i class="fa-solid fa-shirt"></i>
                    <p>${v.name}</p>
                </div>
            `
        }

        $(`.dressing-room > div > .menu > div`).html(clothesData)
    },

    Open: function(data) {
        currentMenu = 'dressing_room';

        this.LoadClothing(data.clothingList);

        $('.dressing-room').css('display', 'flex');
        $('.dressing-room > div').fadeIn(120);
    },

    Close: function() {
        $(`.dressing-room, .dressing-room > div`).fadeOut(120)
        currentMenu = null;
    },
}