--[[
    ============================================
    ENGLISH LOCALE - BEAUTYTRAP-PLUS
    COMPLETE VERSION - ALL FILES
    ============================================
]]--

Locales['en'] = {
    -- ============================================
    -- GENERAL
    -- ============================================
    ['General.AccessDenied'] = "Access Denied",
    ['General.NoPermission'] = "You don't have permission to access this.",
    ['General.Error'] = "Error",
    ['General.Success'] = "Success",
    ['General.Info'] = "Info",
    ['General.Cancel'] = "Cancel",
    ['General.Confirm'] = "Confirm",
    ['General.Back'] = "Back",
    ['General.Close'] = "Close",
    ['General.UnknownError'] = "Unknown error",
    
    -- ============================================
    -- DUTY SYSTEM
    -- ============================================
    ['Duty.OnDuty'] = "On Duty",
    ['Duty.OffDuty'] = "Off Duty",
    ['Duty.NowOnDuty'] = "You are now on duty as %s",
    ['Duty.NowOffDuty'] = "You are now off duty",
    ['Duty.ToggleDuty'] = "Toggle Duty",
    ['Duty.NoPermission'] = "You don't have permission to toggle duty status.",
    ['Duty.NoPermissionStation'] = "You don't have permission to use this duty station.",
    
    -- ============================================
    -- BASKET / SHOPPING SYSTEM
    -- ============================================
    ['Basket.Title'] = "Basket",
    ['Basket.GrabbedBasket'] = "You grabbed a shopping basket!",
    ['Basket.GrabbedGunCase'] = "You grabbed a gun case!",
    ['Basket.GrabbedShoppingBag'] = "You grabbed a shopping bag!",
    ['Basket.AlreadyHaveBasket'] = "You already have a basket!",
    ['Basket.NeedBasket'] = "You need to grab a basket first!",
    ['Basket.PutAway'] = "You put away the basket.",
    ['Basket.NoBasketToPutAway'] = "You don't have a basket to put away!",
    ['Basket.NoLongerHaveBasket'] = "You no longer have a basket.",
    ['Basket.InvalidStoreData'] = "Invalid store data!",
    ['Basket.StoreTypeNotExist'] = "This store type does not exist!",
    ['Basket.ItemAdded'] = "Added %s to your basket!",
    ['Basket.ItemRemoved'] = "Removed %s from basket",
    ['Basket.BasketFull'] = "Basket Full",
    ['Basket.BasketLimit'] = "Your basket can only hold %d items.",
    ['Basket.BasketLimitFull'] = "Your basket can only hold %d items. You already have %d items.",
    ['Basket.Shoplifting'] = "You got caught shoplifting and dropped all the items!",
    
    -- ============================================
    -- SHOP / ITEM BROWSING
    -- ============================================
    ['Shop.SelectItems'] = "Select Items",
    ['Shop.SelectQuantity'] = "Select Quantity",
    ['Shop.Quantity'] = "Quantity",
    ['Shop.Price'] = "Price",
    ['Shop.InvalidQuantity'] = "Invalid quantity!",
    ['Shop.AddToBasket'] = "Add to basket (Stock: %d)",
    ['Shop.HowManyAdd'] = "How many would you like to add? (Max: %d)",
    
    -- ============================================
    -- COOLDOWN SYSTEM
    -- ============================================
    ['Cooldown.Title'] = "Purchase Cooldown",
    ['Cooldown.OnCooldown'] = "You must wait %s before shopping again.",
    ['Cooldown.LimitReached'] = "Purchase Limit Reached",
    ['Cooldown.LimitReachedDesc'] = "You've reached your purchase limit of %d items. Please try again in %d hours.",
    
    -- ============================================
    -- CHECKOUT / PAYMENT SYSTEM
    -- ============================================
    ['Checkout.Title'] = "Checkout",
    ['Checkout.PaymentProcessed'] = "Your payment was processed and you've received your items!",
    ['Checkout.PaymentRequest'] = "Payment Request",
    ['Checkout.PaymentRequestDesc'] = "You have received a payment request for $%d",
    ['Checkout.AcceptPayment'] = "Accept and Pay",
    ['Checkout.AcceptPaymentDesc'] = "Complete your purchase",
    ['Checkout.DeclinePayment'] = "Decline Payment",
    ['Checkout.DeclinePaymentDesc'] = "Cancel the transaction",
    ['Checkout.ProcessPayment'] = "Process Payment",
    ['Checkout.UseRegister'] = "Please use the cash register to process payment of $%d",
    ['Checkout.RequestedWait'] = "You've requested checkout. Please wait for an employee to assist you.",
    ['Checkout.BasketEmpty'] = "Your basket is empty!",
    ['Checkout.NoBasket'] = "You don't have a basket!",
    ['Checkout.RequestAssistance'] = "%s is requesting checkout assistance.",
    ['Checkout.SaleComplete'] = "Sale Complete",
    ['Checkout.PurchaseComplete'] = "Purchase Complete",
    ['Checkout.YouPaid'] = "You paid $%d for your items.",
    ['Checkout.CustomerPaidBusiness'] = "Customer paid $%d to the business account.",
    ['Checkout.CustomerPaidDirect'] = "Customer paid $%d directly to you.",
    ['Checkout.PaymentFailed'] = "Payment Failed",
    ['Checkout.TransactionFailed'] = "Transaction could not be completed.",
    ['Checkout.CustomerPaymentFailed'] = "Customer payment failed.",
    ['Checkout.PurchaseCancelled'] = "Purchase Cancelled",
    ['Checkout.YouDeclined'] = "You declined the payment.",
    ['Checkout.CustomerDeclined'] = "Customer declined the payment.",
    ['Checkout.PaymentMethod'] = "Payment Method",
    ['Checkout.Cash'] = "Cash",
    ['Checkout.BankCard'] = "Bank Card",
    ['Checkout.BankMoney'] = "money in your bank account",
    ['Checkout.Amount'] = "Amount",
    ['Checkout.From'] = "From",
    ['Checkout.AmountMismatch'] = "Amount Mismatch",
    ['Checkout.AmountMismatchDesc'] = "Payment amount doesn't match basket total: $%d",
    ['Checkout.CustomerNotEnoughMoney'] = "Customer doesn't have enough %s",
    ['Checkout.YouNotEnoughMoney'] = "You don't have enough %s",
    
    -- ============================================
    -- STOCK MANAGEMENT
    -- ============================================
    ['Stock.Management'] = "Stock Management",
    ['Stock.ManageStock'] = "Manage stock for this section",
    ['Stock.Location'] = "Location",
    ['Stock.CurrentStock'] = "Current Stock",
    ['Stock.Stock'] = "Stock",
    ['Stock.AddStock'] = "Add Stock",
    ['Stock.RemoveStock'] = "Remove Stock",
    ['Stock.Restock'] = "Restock",
    ['Stock.RestockDesc'] = "How many would you like to add to the shelf?",
    ['Stock.OutOfStock'] = "Out of Stock",
    ['Stock.OutOfStockDesc'] = "Sorry, %s is now out of stock.",
    ['Stock.LowStock'] = "Low Stock",
    ['Stock.NoPermission'] = "You don't have permission to manage stock.",
    ['Stock.Updated'] = "Stock Updated",
    ['Stock.AddedItems'] = "Added %d items. New stock: %d",
    ['Stock.RestockFailed'] = "Restock Failed",
    ['Stock.NotEnoughInventory'] = "You don't have enough %s in your inventory.",
    
    -- ============================================
    -- CUSTOMER BASKET (EMPLOYEE VIEW)
    -- ============================================
    ['CustomerBasket.Title'] = "%s's Basket",
    ['CustomerBasket.NoBasket'] = "This customer doesn't have a basket.",
    ['CustomerBasket.Empty'] = "This customer's basket is empty.",
    ['CustomerBasket.Total'] = "Total",
    ['CustomerBasket.Each'] = "each",
    ['CustomerBasket.NoPermission'] = "You don't have permission to view customer baskets.",
    
    -- ============================================
    -- REGISTER / CASH REGISTER
    -- ============================================
    ['Register.Title'] = "Cash Register",
    ['Register.NoPermission'] = "You don't have permission to use the cash register.",
    ['Register.NoItems'] = "Customer doesn't have items to purchase.",
    ['Register.NoCustomers'] = "No customers nearby.",
    ['Register.SelectCustomer'] = "Select Customer",
    ['Register.InvalidAmount'] = "Invalid amount.",
    
    -- ============================================
    -- TARGET LABELS
    -- ============================================
    ['Target.GrabBasket'] = "Grab Basket",
    ['Target.PutAwayBasket'] = "Put Away Basket",
    ['Target.ViewBasket'] = "View Customer Basket",
    ['Target.Checkout'] = "Request Checkout",
    ['Target.CashRegister'] = "Use Cash Register",
    ['Target.BossMenu'] = "Open Boss Menu",
    ['Target.ManageStock'] = "Manage Stock",
    ['Target.OpenStash'] = "Open %s",
    ['Target.OpenLocker'] = "Open Clothing Locker",
    ['Target.SitDown'] = "Sit Down",
    ['Target.StandUp'] = "Stand Up",
    ['Target.Browse'] = "Browse %s",
    ['Target.UseAsClient'] = "Use %s as Client",
    ['Target.UseAsEmployee'] = "Use %s as Employee",
    
    -- ============================================
    -- STASH / STORAGE
    -- ============================================
    ['Stash.NoPermission'] = "You don't have permission to access this stash.",
    
    -- ============================================
    -- CLOTHING
    -- ============================================
    ['Clothing.Locker'] = "Clothing Locker",
    ['Clothing.OpenMenu'] = "Open Clothing Menu",
    
    -- ============================================
    -- JOB INFO
    -- ============================================
    ['Job.Title'] = "Job Info",
    ['Job.Status'] = "Job Status",
    ['Job.Name'] = "Name",
    ['Job.Grade'] = "Grade",
    ['Job.IsBoss'] = "Is Boss",
    ['Job.Duty'] = "Duty",
    
    -- ============================================
    -- BOSS MENU
    -- ============================================
    ['Boss.Title'] = "Beauty Boss Menu",
    ['Boss.SocietyBalance'] = "Society Balance",
    ['Boss.CurrentBalance'] = "Current balance: $%s",
    ['Boss.WithdrawMoney'] = "Withdraw Society Money",
    ['Boss.DepositMoney'] = "Deposit Money",
    ['Boss.HireEmployee'] = "Hire Employee",
    ['Boss.FireEmployee'] = "Fire Employee",
    ['Boss.EmployeeManagement'] = "Employee Management",
    ['Boss.ViewBalance'] = "View Society Balance",
    ['Boss.SetGrade'] = "Set Grade",
    ['Boss.HowMuchWithdraw'] = "How much do you want to withdraw?",
    ['Boss.HowMuchDeposit'] = "How much do you want to deposit?",
    ['Boss.Amount'] = "Amount",
    ['Boss.NeedBeautyJob'] = "You need to work at the beauty salon to use this command.",
    ['Boss.NoPermission'] = "You don't have permission to access the beauty boss menu.",
    ['Boss.OnlyManagersHire'] = "Only managers can hire employees",
    ['Boss.OnlyManagersFire'] = "Only managers can fire employees",
    ['Boss.OnlyManagersGrade'] = "Only managers can change employee grades",
    ['Boss.NoPermissionWithdraw'] = "You don't have permission to withdraw money.",
    ['Boss.NoPermissionDeposit'] = "You don't have permission to deposit money.",
    ['Boss.NoPermissionBalance'] = "You don't have permission to view society balance.",
    ['Boss.NoPermissionEmployees'] = "You don't have permission to view employee list.",
    ['Boss.Hired'] = "Hired!",
    ['Boss.YouHaveBeenHired'] = "You have been hired at the Beauty Salon",
    ['Boss.EmployeeHiredSuccess'] = "Employee hired successfully",
    ['Boss.Fired'] = "Fired",
    ['Boss.YouHaveBeenFired'] = "You have been removed from the beauty salon",
    ['Boss.EmployeeFiredSuccess'] = "Employee has been fired",
    ['Boss.GradeChanged'] = "Grade Changed",
    ['Boss.YourGradeUpdated'] = "Your grade has been updated",
    ['Boss.GradeUpdatedTo'] = "Employee grade updated to %d",
    ['Boss.WithdrawalSuccessful'] = "Withdrawal Successful",
    ['Boss.WithdrewAmount'] = "Withdrew $%s from society account.",
    ['Boss.WithdrawalFailed'] = "Withdrawal Failed",
    ['Boss.InsufficientFunds'] = "Insufficient funds in society account.",
    ['Boss.DepositSuccessful'] = "Deposit Successful",
    ['Boss.DepositedAmount'] = "Deposited $%s to society account.",
    ['Boss.DepositFailed'] = "Deposit Failed",
    ['Boss.SocietyNotFound'] = "Society account not found.",
    ['Boss.NotEnoughMoney'] = "You don't have enough money.",
    
    -- ============================================
    -- HAIR STYLING
    -- ============================================
    ['Hair.Title'] = "Hair Styling",
    ['Hair.StyledSuccess'] = "Hair styled successfully!",
    ['Hair.StylistWorking'] = "A stylist is working on your hair",
    ['Hair.Cancelled'] = "Hair styling cancelled",
    ['Hair.NoPermission'] = "You don't have permission to style hair",
    ['Hair.AlreadyStyling'] = "You are already styling someone's hair",
    ['Hair.SitInChair'] = "Sit in Salon Chair",
    ['Hair.StyleHair'] = "Style Hair",
    ['Hair.DoHair'] = "Do Hair",
    ['Hair.ClientLeft'] = "The client has left the server",
    ['Hair.StylistLeft'] = "The stylist has left the server",
    
    -- ============================================
    -- NAIL SERVICES
    -- ============================================
    ['Nails.Title'] = "Nail Services",
    ['Nails.LashServices'] = "Lash Services",
    ['Nails.ApplyStyles'] = "Apply %s styles",
    ['Nails.ApplyingService'] = "Applying service...",
    ['Nails.GettingService'] = "Getting service...",
    ['Nails.NailsComplete'] = "Your nails look amazing!",
    ['Nails.NailServiceComplete'] = "Nail service completed!",
    ['Nails.LashesComplete'] = "Your lashes look beautiful!",
    ['Nails.LashServiceComplete'] = "Lash service completed!",
    ['Nails.TechWorking'] = "A nail technician is working on your nails",
    ['Nails.LashExpertWorking'] = "A lash expert is working on your lashes",
    ['Nails.NoPermissionNails'] = "You must be a nail tech (Grade %d+) to do nails",
    ['Nails.NoPermissionLashes'] = "You must be a lash expert (Grade %d+) to do lashes",
    ['Nails.SitInChair'] = "Sit in Nail Chair",
    ['Nails.DoNails'] = "Do Nails",
    ['Nails.DoLashes'] = "Do Lashes",
    ['Nails.ClientDisconnected'] = "Client disconnected",
    ['Nails.TechDisconnected'] = "Nail technician disconnected",
    ['Nails.LashExpertDisconnected'] = "Lash expert disconnected",
    ['Nails.NailCancelledRestart'] = "Nail service cancelled (server restart)",
    ['Nails.LashCancelledRestart'] = "Lash service cancelled (server restart)",
    ['Nails.NailCancelled'] = "Nail service cancelled",
    ['Nails.LashCancelled'] = "Lash service cancelled",
    ['Nails.AppearanceSaved'] = "Appearance saved!",
    
    -- ============================================
    -- TRAP / STREET SELLING
    -- ============================================
    ['Trap.NotWoman'] = "Only women can sell beauty products!",
    ['Trap.NoPolice'] = "Not enough police online to start selling.",
    ['Trap.NoProducts'] = "You don't have any beauty products to sell!",
    ['Trap.AlreadySelling'] = "You're already selling products!",
    ['Trap.WaitCustomer'] = "Looking for customers... Stay nearby!",
    ['Trap.CustomerApproaching'] = "A customer is approaching you!",
    ['Trap.CustomerWaiting'] = "Customer is ready to buy!",
    ['Trap.CustomerLeft'] = "The customer lost interest and walked away.",
    ['Trap.SellProduct'] = "Sell Beauty Product",
    ['Trap.SaleSuccess'] = "Sold %dx %s for $%d",
    ['Trap.SaleRejected'] = "The customer rejected your offer!",
    ['Trap.SaleFailed'] = "Sale failed: %s",
    ['Trap.TooFar'] = "You moved too far away from the customer!",
    ['Trap.Robbed'] = "The customer tried to rob you!",
    ['Trap.RobberyFailed'] = "You fought off the robber!",
    ['Trap.RobberGotAway'] = "The robber got away!",
    ['Trap.StoppedSelling'] = "Stopped selling beauty products.",
    ['Trap.InVehicle'] = "You can't sell while in a vehicle!",
    ['Trap.NotBeautyJob'] = "You must work at the beauty salon to sell products!",
    ['Trap.Disabled'] = "Beauty trap system is currently disabled",
    ['Trap.WaitingProductData'] = "Waiting for product data...",
    ['Trap.NoItemAnymore'] = "You no longer have this item!",
    
    -- ============================================
    -- NOTIFICATIONS (GENERAL)
    -- ============================================
    ['Notify.CheckoutRequest'] = "Checkout Request",
    ['Notify.CustomerNeedsAssistance'] = "A customer needs checkout assistance at %s!",
    
-- ============================================
    -- TABLET SYSTEM
    -- ============================================
    ['Tablet.NoJob'] = "You must be a beauty salon employee to use this.",
    ['Tablet.Opened'] = "Tablet opened.",
    ['Tablet.Closed'] = "Tablet closed.",
    
    -- Passing tablet
    ['Tablet.SelectCustomer'] = "Select a customer to pass the tablet to.",
    ['Tablet.NoNearbyPlayers'] = "No customers nearby.",
    ['Tablet.NoCustomerNearby'] = "No customer nearby.",
    ['Tablet.PassTablet'] = "Pass Tablet",
    ['Tablet.PassingTablet'] = "Passing tablet to customer...",
    ['Tablet.TabletPassed'] = "Tablet passed. Waiting for customer response.",
    
    -- Customer prompts
    ['Tablet.OfferTitle'] = "Beauty Salon Payment",
    ['Tablet.OfferDesc'] = "%s wants to hand you the payment tablet.",
    ['Tablet.Accept'] = "Accept",
    ['Tablet.Decline'] = "Decline",
    ['Tablet.DeclineReasonTitle'] = "Decline Reason",
    ['Tablet.DeclineReasonDesc'] = "Why are you declining? (optional)",
    
    -- Customer received
    ['Tablet.Received'] = "Review your services and complete payment.",
    
    -- Decline handling
    ['Tablet.Declined'] = "Customer declined the tablet.",
    ['Tablet.DeclinedWithReason'] = "Customer declined: %s",
    ['Tablet.YouDeclined'] = "You declined the tablet.",
    
    -- Payment
    ['Tablet.PaymentSuccessEmployee'] = "Payment of $%s received! (Tip: $%s)",
    ['Tablet.PaymentSuccessCustomer'] = "You paid $%s. Thank you for visiting Beauty Salon!",
    ['Tablet.NoMoneyCash'] = "You don't have enough cash.",
    ['Tablet.NoMoneyBank'] = "You don't have enough in your bank account.",
    ['Tablet.PaymentFailed'] = "Payment failed.",
    ['Tablet.TransactionExpired'] = "Transaction expired.",
    
    -- Availability
    ['Tablet.AvailabilityTitle'] = "Set Availability",
    ['Tablet.SetAvailable'] = "Set Available",
    ['Tablet.SetUnavailable'] = "Set Unavailable",
    ['Tablet.NowAvailable'] = "You are now available for appointments.",
    ['Tablet.NowUnavailable'] = "You are now unavailable.",
    
    -- Management
    ['Tablet.PriceUpdated'] = "Price for %s updated to $%s.",
    ['Tablet.ShelfPriceUpdated'] = "Shelf price updated to $%s.",
    ['Tablet.LimitUpdated'] = "Custom charge limit set to $%s.",
    ['Tablet.ChargeLimitUpdated'] = "Charge limit set to $%s.",
    ['Tablet.NoPermission'] = "You don't have permission to do this.",
    
    -- Stats
    ['Tablet.StatsToday'] = "Today's Sales: $%s (%d customers)",
    ['Tablet.StatsWeek'] = "This Week: $%s (%d customers)",
    
    -- Finances
    ['Tablet.DepositSuccess'] = "Deposited $%s to society.",
    ['Tablet.WithdrawSuccess'] = "Withdrew $%s from society.",
    ['Tablet.DepositFailed'] = "Failed to deposit to society.",
    ['Tablet.WithdrawFailed'] = "Insufficient funds in society account.",
    ['Tablet.NotEnoughCash'] = "You don't have enough cash.",
    
    -- Employee Management
    ['Tablet.EmployeeHired'] = "Hired %s as Grade %d.",
    ['Tablet.YouWereHired'] = "You have been hired at Beauty Salon!",
    ['Tablet.EmployeeFired'] = "Employee has been fired.",
    ['Tablet.YouWereFired'] = "You have been fired from Beauty Salon.",
    ['Tablet.GradeUpdated'] = "Employee grade updated.",
    ['Tablet.YourGradeUpdated'] = "Your position has been updated!",
    ['Tablet.PlayerNotFound'] = "Player not found.",
    
    -- Disconnection
    ['Tablet.EmployeeDisconnected'] = "The employee disconnected.",
    ['Tablet.CustomerDisconnected'] = "The customer disconnected.",
    
    -- Customer accepted/declined
    ['Tablet.CustomerAccepted'] = "Customer accepted the tablet.",

    -- Appointments (Full Booking System)
    ['Tablet.AvailabilitySaved'] = "Your availability has been saved.",
    ['Tablet.NewAppointment'] = "New Appointment",
    ['Tablet.AppointmentCancelledRefund'] = "Appointment cancelled - deposit refunded.",
    ['Tablet.AppointmentCancelledNoRefund'] = "Appointment cancelled - no refund (too late).",
    ['Tablet.AppointmentReminder'] = "Appointment Reminder",
    ['Tablet.ReminderCustomer'] = "Reminder: You have an appointment in %s minutes!",
    ['Tablet.ReminderEmployee'] = "%s has an appointment in %s minutes.",
    ['Tablet.NotEnoughForDeposit'] = "Not enough money for deposit ($%s required).",
    ['Tablet.BookingSuccess'] = "Appointment booked! Deposit of $%s paid.",
    ['Tablet.RefundGiven'] = "Your deposit of $%s has been refunded.",
    ['Tablet.BookAppointment'] = "Book Appointment",
    ['Tablet.SelectEmployee'] = "Select Stylist",
    ['Tablet.SelectDate'] = "Select Date",
    ['Tablet.SelectTime'] = "Select Time",
    ['Tablet.ConfirmBooking'] = "Confirm Booking",
    ['Tablet.DepositRequired'] = "Deposit: $%s",
    ['Tablet.NoEmployeesAvailable'] = "No stylists available for booking.",
    ['Tablet.NoDatesAvailable'] = "No dates available.",
    ['Tablet.NoTimesAvailable'] = "No times available.",
    ['Tablet.MyBookings'] = "My Bookings",
    ['Tablet.ManageAvailability'] = "Manage Availability",
}