--[[
    ============================================
    CHINESE SIMPLIFIED LOCALE - BEAUTYTRAP-PLUS
    简体中文语言包 - 完整版本
    ============================================
]]--

Locales['zh'] = {
    -- ============================================
    -- GENERAL / 通用
    -- ============================================
    ['General.AccessDenied'] = "访问被拒绝",
    ['General.NoPermission'] = "您没有权限访问此内容。",
    ['General.Error'] = "错误",
    ['General.Success'] = "成功",
    ['General.Info'] = "信息",
    ['General.Cancel'] = "取消",
    ['General.Confirm'] = "确认",
    ['General.Back'] = "返回",
    ['General.Close'] = "关闭",
    ['General.UnknownError'] = "未知错误",
    
    -- ============================================
    -- DUTY SYSTEM / 值班系统
    -- ============================================
    ['Duty.OnDuty'] = "上班",
    ['Duty.OffDuty'] = "下班",
    ['Duty.NowOnDuty'] = "您现在以%s身份上班",
    ['Duty.NowOffDuty'] = "您现在已下班",
    ['Duty.ToggleDuty'] = "切换值班",
    ['Duty.NoPermission'] = "您没有权限更改值班状态。",
    ['Duty.NoPermissionStation'] = "您没有权限使用此值班站。",
    
    -- ============================================
    -- BASKET / SHOPPING SYSTEM / 购物篮系统
    -- ============================================
    ['Basket.Title'] = "购物篮",
    ['Basket.GrabbedBasket'] = "您拿起了购物篮！",
    ['Basket.GrabbedGunCase'] = "您拿起了枪箱！",
    ['Basket.GrabbedShoppingBag'] = "您拿起了购物袋！",
    ['Basket.AlreadyHaveBasket'] = "您已经有购物篮了！",
    ['Basket.NeedBasket'] = "您需要先拿一个购物篮！",
    ['Basket.PutAway'] = "您放下了购物篮。",
    ['Basket.NoBasketToPutAway'] = "您没有购物篮可以放下！",
    ['Basket.NoLongerHaveBasket'] = "您已经没有购物篮了。",
    ['Basket.InvalidStoreData'] = "无效的商店数据！",
    ['Basket.StoreTypeNotExist'] = "此商店类型不存在！",
    ['Basket.ItemAdded'] = "已将%s添加到您的购物篮！",
    ['Basket.ItemRemoved'] = "已从购物篮移除%s",
    ['Basket.BasketFull'] = "购物篮已满",
    ['Basket.BasketLimit'] = "您的购物篮最多只能装%d件物品。",
    ['Basket.BasketLimitFull'] = "您的购物篮最多只能装%d件物品。您已有%d件物品。",
    ['Basket.Shoplifting'] = "您被抓到偷东西并丢掉了所有物品！",
    
    -- ============================================
    -- SHOP / ITEM BROWSING / 商店浏览
    -- ============================================
    ['Shop.SelectItems'] = "选择物品",
    ['Shop.SelectQuantity'] = "选择数量",
    ['Shop.Quantity'] = "数量",
    ['Shop.Price'] = "价格",
    ['Shop.InvalidQuantity'] = "无效的数量！",
    ['Shop.AddToBasket'] = "添加到购物篮 (库存: %d)",
    ['Shop.HowManyAdd'] = "您想添加多少？(最多: %d)",
    
    -- ============================================
    -- COOLDOWN SYSTEM / 冷却系统
    -- ============================================
    ['Cooldown.Title'] = "购买冷却",
    ['Cooldown.OnCooldown'] = "您必须等待%s才能再次购物。",
    ['Cooldown.LimitReached'] = "购买限制已达到",
    ['Cooldown.LimitReachedDesc'] = "您已达到%d件物品的购买限制。请在%d小时后重试。",
    
    -- ============================================
    -- CHECKOUT / PAYMENT SYSTEM / 结账系统
    -- ============================================
    ['Checkout.Title'] = "结账",
    ['Checkout.PaymentProcessed'] = "您的付款已处理，您已收到物品！",
    ['Checkout.PaymentRequest'] = "付款请求",
    ['Checkout.PaymentRequestDesc'] = "您收到了%d美元的付款请求",
    ['Checkout.AcceptPayment'] = "接受并付款",
    ['Checkout.AcceptPaymentDesc'] = "完成您的购买",
    ['Checkout.DeclinePayment'] = "拒绝付款",
    ['Checkout.DeclinePaymentDesc'] = "取消交易",
    ['Checkout.ProcessPayment'] = "处理付款",
    ['Checkout.UseRegister'] = "请使用收银机处理%d美元的付款",
    ['Checkout.RequestedWait'] = "您已请求结账。请等待员工为您服务。",
    ['Checkout.BasketEmpty'] = "您的购物篮是空的！",
    ['Checkout.NoBasket'] = "您没有购物篮！",
    ['Checkout.RequestAssistance'] = "%s正在请求结账帮助。",
    ['Checkout.SaleComplete'] = "销售完成",
    ['Checkout.PurchaseComplete'] = "购买完成",
    ['Checkout.YouPaid'] = "您为物品支付了%d美元。",
    ['Checkout.CustomerPaidBusiness'] = "顾客向商业账户支付了%d美元。",
    ['Checkout.CustomerPaidDirect'] = "顾客直接向您支付了%d美元。",
    ['Checkout.PaymentFailed'] = "付款失败",
    ['Checkout.TransactionFailed'] = "交易无法完成。",
    ['Checkout.CustomerPaymentFailed'] = "顾客付款失败。",
    ['Checkout.PurchaseCancelled'] = "购买已取消",
    ['Checkout.YouDeclined'] = "您拒绝了付款。",
    ['Checkout.CustomerDeclined'] = "顾客拒绝了付款。",
    ['Checkout.PaymentMethod'] = "付款方式",
    ['Checkout.Cash'] = "现金",
    ['Checkout.BankCard'] = "银行卡",
    ['Checkout.BankMoney'] = "您银行账户中的钱",
    ['Checkout.Amount'] = "金额",
    ['Checkout.From'] = "来自",
    ['Checkout.AmountMismatch'] = "金额不匹配",
    ['Checkout.AmountMismatchDesc'] = "付款金额与购物篮总额不符: %d美元",
    ['Checkout.CustomerNotEnoughMoney'] = "顾客没有足够的%s",
    ['Checkout.YouNotEnoughMoney'] = "您没有足够的%s",
    
    -- ============================================
    -- STOCK MANAGEMENT / 库存管理
    -- ============================================
    ['Stock.Management'] = "库存管理",
    ['Stock.ManageStock'] = "管理此区域的库存",
    ['Stock.Location'] = "位置",
    ['Stock.CurrentStock'] = "当前库存",
    ['Stock.Stock'] = "库存",
    ['Stock.AddStock'] = "添加库存",
    ['Stock.RemoveStock'] = "移除库存",
    ['Stock.Restock'] = "补货",
    ['Stock.RestockDesc'] = "您想添加多少到货架？",
    ['Stock.OutOfStock'] = "缺货",
    ['Stock.OutOfStockDesc'] = "抱歉，%s已缺货。",
    ['Stock.LowStock'] = "库存不足",
    ['Stock.NoPermission'] = "您没有权限管理库存。",
    ['Stock.Updated'] = "库存已更新",
    ['Stock.AddedItems'] = "已添加%d件物品。新库存: %d",
    ['Stock.RestockFailed'] = "补货失败",
    ['Stock.NotEnoughInventory'] = "您的库存中没有足够的%s。",
    
    -- ============================================
    -- CUSTOMER BASKET (EMPLOYEE VIEW) / 顾客购物篮
    -- ============================================
    ['CustomerBasket.Title'] = "%s的购物篮",
    ['CustomerBasket.NoBasket'] = "此顾客没有购物篮。",
    ['CustomerBasket.Empty'] = "此顾客的购物篮是空的。",
    ['CustomerBasket.Total'] = "总计",
    ['CustomerBasket.Each'] = "每件",
    ['CustomerBasket.NoPermission'] = "您没有权限查看顾客的购物篮。",
    
    -- ============================================
    -- REGISTER / CASH REGISTER / 收银机
    -- ============================================
    ['Register.Title'] = "收银机",
    ['Register.NoPermission'] = "您没有权限使用收银机。",
    ['Register.NoItems'] = "顾客没有要购买的物品。",
    ['Register.NoCustomers'] = "附近没有顾客。",
    ['Register.SelectCustomer'] = "选择顾客",
    ['Register.InvalidAmount'] = "无效的金额。",
    
    -- ============================================
    -- TARGET LABELS / 目标标签
    -- ============================================
    ['Target.GrabBasket'] = "拿购物篮",
    ['Target.PutAwayBasket'] = "放下购物篮",
    ['Target.ViewBasket'] = "查看顾客购物篮",
    ['Target.Checkout'] = "请求结账",
    ['Target.CashRegister'] = "使用收银机",
    ['Target.BossMenu'] = "打开老板菜单",
    ['Target.ManageStock'] = "管理库存",
    ['Target.OpenStash'] = "打开%s",
    ['Target.OpenLocker'] = "打开衣柜",
    ['Target.SitDown'] = "坐下",
    ['Target.StandUp'] = "站起",
    ['Target.Browse'] = "浏览%s",
    ['Target.UseAsClient'] = "作为客户使用%s",
    ['Target.UseAsEmployee'] = "作为员工使用%s",
    
    -- ============================================
    -- STASH / STORAGE / 存储
    -- ============================================
    ['Stash.NoPermission'] = "您没有权限访问此存储。",
    
    -- ============================================
    -- CLOTHING / 服装
    -- ============================================
    ['Clothing.Locker'] = "衣柜",
    ['Clothing.OpenMenu'] = "打开服装菜单",
    
    -- ============================================
    -- JOB INFO / 工作信息
    -- ============================================
    ['Job.Title'] = "工作信息",
    ['Job.Status'] = "工作状态",
    ['Job.Name'] = "名称",
    ['Job.Grade'] = "等级",
    ['Job.IsBoss'] = "是老板",
    ['Job.Duty'] = "值班",
    
    -- ============================================
    -- BOSS MENU / 老板菜单
    -- ============================================
    ['Boss.Title'] = "美容老板菜单",
    ['Boss.SocietyBalance'] = "公司余额",
    ['Boss.CurrentBalance'] = "当前余额: %s美元",
    ['Boss.WithdrawMoney'] = "从公司提取资金",
    ['Boss.DepositMoney'] = "存入资金",
    ['Boss.HireEmployee'] = "雇用员工",
    ['Boss.FireEmployee'] = "解雇员工",
    ['Boss.EmployeeManagement'] = "员工管理",
    ['Boss.ViewBalance'] = "查看公司余额",
    ['Boss.SetGrade'] = "设置等级",
    ['Boss.HowMuchWithdraw'] = "您想提取多少？",
    ['Boss.HowMuchDeposit'] = "您想存入多少？",
    ['Boss.Amount'] = "金额",
    ['Boss.NeedBeautyJob'] = "您需要在美容院工作才能使用此命令。",
    ['Boss.NoPermission'] = "您没有权限访问美容老板菜单。",
    ['Boss.OnlyManagersHire'] = "只有经理可以雇用员工",
    ['Boss.OnlyManagersFire'] = "只有经理可以解雇员工",
    ['Boss.OnlyManagersGrade'] = "只有经理可以更改员工等级",
    ['Boss.NoPermissionWithdraw'] = "您没有权限提取资金。",
    ['Boss.NoPermissionDeposit'] = "您没有权限存入资金。",
    ['Boss.NoPermissionBalance'] = "您没有权限查看公司余额。",
    ['Boss.NoPermissionEmployees'] = "您没有权限查看员工列表。",
    ['Boss.Hired'] = "已雇用！",
    ['Boss.YouHaveBeenHired'] = "您已被美容院雇用",
    ['Boss.EmployeeHiredSuccess'] = "员工雇用成功",
    ['Boss.Fired'] = "已解雇",
    ['Boss.YouHaveBeenFired'] = "您已被从美容院移除",
    ['Boss.EmployeeFiredSuccess'] = "员工已被解雇",
    ['Boss.GradeChanged'] = "等级已更改",
    ['Boss.YourGradeUpdated'] = "您的等级已更新",
    ['Boss.GradeUpdatedTo'] = "员工等级已更新为%d",
    ['Boss.WithdrawalSuccessful'] = "提取成功",
    ['Boss.WithdrewAmount'] = "您从公司账户提取了%s美元。",
    ['Boss.WithdrawalFailed'] = "提取失败",
    ['Boss.InsufficientFunds'] = "公司账户资金不足。",
    ['Boss.DepositSuccessful'] = "存入成功",
    ['Boss.DepositedAmount'] = "您向公司账户存入了%s美元。",
    ['Boss.DepositFailed'] = "存入失败",
    ['Boss.SocietyNotFound'] = "未找到公司账户。",
    ['Boss.NotEnoughMoney'] = "您没有足够的钱。",
    
    -- ============================================
    -- HAIR STYLING / 发型设计
    -- ============================================
    ['Hair.Title'] = "发型设计",
    ['Hair.StyledSuccess'] = "发型设计成功！",
    ['Hair.StylistWorking'] = "发型师正在为您做头发",
    ['Hair.Cancelled'] = "发型设计已取消",
    ['Hair.NoPermission'] = "您没有权限进行发型设计",
    ['Hair.AlreadyStyling'] = "您已经在为某人做发型了",
    ['Hair.SitInChair'] = "坐在沙龙椅上",
    ['Hair.StyleHair'] = "设计发型",
    ['Hair.DoHair'] = "做头发",
    ['Hair.ClientLeft'] = "客户已离开服务器",
    ['Hair.StylistLeft'] = "发型师已离开服务器",
    
    -- ============================================
    -- NAIL SERVICES / 美甲服务
    -- ============================================
    ['Nails.Title'] = "美甲服务",
    ['Nails.LashServices'] = "睫毛服务",
    ['Nails.ApplyStyles'] = "应用%s样式",
    ['Nails.ApplyingService'] = "正在应用服务...",
    ['Nails.GettingService'] = "正在接受服务...",
    ['Nails.NailsComplete'] = "您的指甲看起来棒极了！",
    ['Nails.NailServiceComplete'] = "美甲服务完成！",
    ['Nails.LashesComplete'] = "您的睫毛看起来很漂亮！",
    ['Nails.LashServiceComplete'] = "睫毛服务完成！",
    ['Nails.TechWorking'] = "美甲师正在为您做指甲",
    ['Nails.LashExpertWorking'] = "睫毛专家正在为您做睫毛",
    ['Nails.NoPermissionNails'] = "您必须是美甲师（等级%d+）才能做美甲",
    ['Nails.NoPermissionLashes'] = "您必须是睫毛专家（等级%d+）才能做睫毛",
    ['Nails.SitInChair'] = "坐在美甲椅上",
    ['Nails.DoNails'] = "做美甲",
    ['Nails.DoLashes'] = "做睫毛",
    ['Nails.ClientDisconnected'] = "客户已断开连接",
    ['Nails.TechDisconnected'] = "美甲师已断开连接",
    ['Nails.LashExpertDisconnected'] = "睫毛专家已断开连接",
    ['Nails.NailCancelledRestart'] = "美甲服务已取消（服务器重启）",
    ['Nails.LashCancelledRestart'] = "睫毛服务已取消（服务器重启）",
    ['Nails.NailCancelled'] = "美甲服务已取消",
    ['Nails.LashCancelled'] = "睫毛服务已取消",
    ['Nails.AppearanceSaved'] = "外观已保存！",
    
    -- ============================================
    -- TRAP / STREET SELLING / 街头销售
    -- ============================================
    ['Trap.NotWoman'] = "只有女性可以销售美容产品！",
    ['Trap.NoPolice'] = "在线警察不足，无法开始销售。",
    ['Trap.NoProducts'] = "您没有美容产品可以销售！",
    ['Trap.AlreadySelling'] = "您已经在销售产品了！",
    ['Trap.WaitCustomer'] = "正在寻找顾客...请留在附近！",
    ['Trap.CustomerApproaching'] = "一位顾客正在向您走来！",
    ['Trap.CustomerWaiting'] = "顾客已准备好购买！",
    ['Trap.CustomerLeft'] = "顾客失去兴趣离开了。",
    ['Trap.SellProduct'] = "出售美容产品",
    ['Trap.SaleSuccess'] = "售出%d件%s，获得%d美元",
    ['Trap.SaleRejected'] = "顾客拒绝了您的报价！",
    ['Trap.SaleFailed'] = "销售失败: %s",
    ['Trap.TooFar'] = "您离顾客太远了！",
    ['Trap.Robbed'] = "顾客试图抢劫您！",
    ['Trap.RobberyFailed'] = "您击退了抢劫者！",
    ['Trap.RobberGotAway'] = "抢劫者逃跑了！",
    ['Trap.StoppedSelling'] = "已停止销售美容产品。",
    ['Trap.InVehicle'] = "您不能在车内销售！",
    ['Trap.NotBeautyJob'] = "您必须在美容院工作才能销售产品！",
    ['Trap.Disabled'] = "街头销售系统目前已禁用",
    ['Trap.WaitingProductData'] = "正在等待产品数据...",
    ['Trap.NoItemAnymore'] = "您已经没有这件物品了！",
    
    -- ============================================
    -- NOTIFICATIONS (GENERAL) / 通知
    -- ============================================
    ['Notify.CheckoutRequest'] = "结账请求",
    ['Notify.CustomerNeedsAssistance'] = "一位顾客在%s需要结账帮助！",
    
    -- ============================================
    -- TABLET SYSTEM / 平板系统
    -- ============================================
    ['Tablet.NoJob'] = "您必须是美容院员工才能使用此功能。",
    ['Tablet.Opened'] = "平板已打开。",
    ['Tablet.Closed'] = "平板已关闭。",
    
    -- Passing tablet / 传递平板
    ['Tablet.SelectCustomer'] = "选择一位顾客将平板传递给他。",
    ['Tablet.NoNearbyPlayers'] = "附近没有顾客。",
    ['Tablet.NoCustomerNearby'] = "附近没有顾客。",
    ['Tablet.PassTablet'] = "传递平板",
    ['Tablet.PassingTablet'] = "正在将平板传递给顾客...",
    ['Tablet.TabletPassed'] = "平板已传递。等待顾客响应。",
    
    -- Customer prompts / 顾客提示
    ['Tablet.OfferTitle'] = "美容院付款",
    ['Tablet.OfferDesc'] = "%s想要将付款平板交给您。",
    ['Tablet.Accept'] = "接受",
    ['Tablet.Decline'] = "拒绝",
    ['Tablet.DeclineReasonTitle'] = "拒绝原因",
    ['Tablet.DeclineReasonDesc'] = "您为什么拒绝？（可选）",
    
    -- Customer received / 顾客收到
    ['Tablet.Received'] = "请查看您的服务并完成付款。",
    
    -- Decline handling / 拒绝处理
    ['Tablet.Declined'] = "顾客拒绝了平板。",
    ['Tablet.DeclinedWithReason'] = "顾客拒绝了: %s",
    ['Tablet.YouDeclined'] = "您拒绝了平板。",
    
    -- Payment / 付款
    ['Tablet.PaymentSuccessEmployee'] = "收到付款%s美元！（小费: %s美元）",
    ['Tablet.PaymentSuccessCustomer'] = "您支付了%s美元。感谢光临美容院！",
    ['Tablet.NoMoneyCash'] = "您没有足够的现金。",
    ['Tablet.NoMoneyBank'] = "您的银行账户余额不足。",
    ['Tablet.PaymentFailed'] = "付款失败。",
    ['Tablet.TransactionExpired'] = "交易已过期。",
    
    -- Availability / 可用性
    ['Tablet.AvailabilityTitle'] = "设置可用状态",
    ['Tablet.SetAvailable'] = "设为可用",
    ['Tablet.SetUnavailable'] = "设为不可用",
    ['Tablet.NowAvailable'] = "您现在可以接受预约了。",
    ['Tablet.NowUnavailable'] = "您现在不可用。",
    
    -- Management / 管理
    ['Tablet.PriceUpdated'] = "%s的价格已更新为%s美元。",
    ['Tablet.ShelfPriceUpdated'] = "货架价格已更新为%s美元。",
    ['Tablet.LimitUpdated'] = "自定义收费限额设置为%s美元。",
    ['Tablet.ChargeLimitUpdated'] = "收费限额设置为%s美元。",
    ['Tablet.NoPermission'] = "您没有权限执行此操作。",
    
    -- Stats / 统计
    ['Tablet.StatsToday'] = "今日销售: %s美元（%d位顾客）",
    ['Tablet.StatsWeek'] = "本周: %s美元（%d位顾客）",
    
    -- Finances / 财务
    ['Tablet.DepositSuccess'] = "已向公司存入%s美元。",
    ['Tablet.WithdrawSuccess'] = "已从公司提取%s美元。",
    ['Tablet.DepositFailed'] = "向公司存款失败。",
    ['Tablet.WithdrawFailed'] = "公司账户资金不足。",
    ['Tablet.NotEnoughCash'] = "您没有足够的现金。",
    
    -- Employee Management / 员工管理
    ['Tablet.EmployeeHired'] = "已雇用%s为等级%d。",
    ['Tablet.YouWereHired'] = "您已被美容院雇用！",
    ['Tablet.EmployeeFired'] = "员工已被解雇。",
    ['Tablet.YouWereFired'] = "您已被美容院解雇。",
    ['Tablet.GradeUpdated'] = "员工等级已更新。",
    ['Tablet.YourGradeUpdated'] = "您的职位已更新！",
    ['Tablet.PlayerNotFound'] = "未找到玩家。",
    
    -- Disconnection / 断开连接
    ['Tablet.EmployeeDisconnected'] = "员工已断开连接。",
    ['Tablet.CustomerDisconnected'] = "顾客已断开连接。",
    
    -- Customer accepted/declined / 顾客接受/拒绝
    ['Tablet.CustomerAccepted'] = "顾客接受了平板。",

    -- Appointments (Full Booking System)
    ['Tablet.AvailabilitySaved'] = "您的可用时间已保存。",
    ['Tablet.NewAppointment'] = "新预约",
    ['Tablet.AppointmentCancelledRefund'] = "预约已取消 - 押金已退还。",
    ['Tablet.AppointmentCancelledNoRefund'] = "预约已取消 - 无法退款（太晚了）。",
    ['Tablet.AppointmentReminder'] = "预约提醒",
    ['Tablet.ReminderCustomer'] = "提醒：您的预约将在%s分钟后开始！",
    ['Tablet.ReminderEmployee'] = "%s的预约将在%s分钟后开始。",
    ['Tablet.NotEnoughForDeposit'] = "押金不足（需要$%s）。",
    ['Tablet.BookingSuccess'] = "预约成功！已支付$%s押金。",
    ['Tablet.RefundGiven'] = "您的$%s押金已退还。",
    ['Tablet.BookAppointment'] = "预约",
    ['Tablet.SelectEmployee'] = "选择造型师",
    ['Tablet.SelectDate'] = "选择日期",
    ['Tablet.SelectTime'] = "选择时间",
    ['Tablet.ConfirmBooking'] = "确认预约",
    ['Tablet.DepositRequired'] = "押金：$%s",
    ['Tablet.NoEmployeesAvailable'] = "没有可预约的造型师。",
    ['Tablet.NoDatesAvailable'] = "没有可用日期。",
    ['Tablet.NoTimesAvailable'] = "没有可用时间。",
    ['Tablet.MyBookings'] = "我的预约",
    ['Tablet.ManageAvailability'] = "管理可用时间",
}