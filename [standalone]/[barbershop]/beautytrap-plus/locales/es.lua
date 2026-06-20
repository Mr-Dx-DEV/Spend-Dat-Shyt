--[[
    ============================================
    SPANISH LOCALE - BEAUTYTRAP-PLUS
    COMPLETE VERSION - ALL FILES
    ============================================
]]--

Locales['es'] = {
    -- ============================================
    -- GENERAL
    -- ============================================
    ['General.AccessDenied'] = "Acceso Denegado",
    ['General.NoPermission'] = "No tienes permiso para acceder a esto.",
    ['General.Error'] = "Error",
    ['General.Success'] = "Éxito",
    ['General.Info'] = "Info",
    ['General.Cancel'] = "Cancelar",
    ['General.Confirm'] = "Confirmar",
    ['General.Back'] = "Volver",
    ['General.Close'] = "Cerrar",
    ['General.UnknownError'] = "Error desconocido",
    
    -- ============================================
    -- DUTY SYSTEM
    -- ============================================
    ['Duty.OnDuty'] = "En Servicio",
    ['Duty.OffDuty'] = "Fuera de Servicio",
    ['Duty.NowOnDuty'] = "Ahora estás en servicio como %s",
    ['Duty.NowOffDuty'] = "Ahora estás fuera de servicio",
    ['Duty.ToggleDuty'] = "Cambiar Servicio",
    ['Duty.NoPermission'] = "No tienes permiso para cambiar el estado de servicio.",
    ['Duty.NoPermissionStation'] = "No tienes permiso para usar esta estación de servicio.",
    
    -- ============================================
    -- BASKET / SHOPPING SYSTEM
    -- ============================================
    ['Basket.Title'] = "Canasta",
    ['Basket.GrabbedBasket'] = "¡Tomaste una canasta de compras!",
    ['Basket.GrabbedGunCase'] = "¡Tomaste un estuche de armas!",
    ['Basket.GrabbedShoppingBag'] = "¡Tomaste una bolsa de compras!",
    ['Basket.AlreadyHaveBasket'] = "¡Ya tienes una canasta!",
    ['Basket.NeedBasket'] = "¡Necesitas tomar una canasta primero!",
    ['Basket.PutAway'] = "Guardaste la canasta.",
    ['Basket.NoBasketToPutAway'] = "¡No tienes una canasta para guardar!",
    ['Basket.NoLongerHaveBasket'] = "Ya no tienes una canasta.",
    ['Basket.InvalidStoreData'] = "¡Datos de tienda inválidos!",
    ['Basket.StoreTypeNotExist'] = "¡Este tipo de tienda no existe!",
    ['Basket.ItemAdded'] = "¡Añadido %s a tu canasta!",
    ['Basket.ItemRemoved'] = "Eliminado %s de la canasta",
    ['Basket.BasketFull'] = "Canasta Llena",
    ['Basket.BasketLimit'] = "Tu canasta solo puede contener %d artículos.",
    ['Basket.BasketLimitFull'] = "Tu canasta solo puede contener %d artículos. Ya tienes %d artículos.",
    ['Basket.Shoplifting'] = "¡Te atraparon robando y soltaste todos los artículos!",
    
    -- ============================================
    -- SHOP / ITEM BROWSING
    -- ============================================
    ['Shop.SelectItems'] = "Seleccionar Artículos",
    ['Shop.SelectQuantity'] = "Seleccionar Cantidad",
    ['Shop.Quantity'] = "Cantidad",
    ['Shop.Price'] = "Precio",
    ['Shop.InvalidQuantity'] = "¡Cantidad inválida!",
    ['Shop.AddToBasket'] = "Añadir a la canasta (Stock: %d)",
    ['Shop.HowManyAdd'] = "¿Cuántos quieres añadir? (Máx: %d)",
    
    -- ============================================
    -- COOLDOWN SYSTEM
    -- ============================================
    ['Cooldown.Title'] = "Tiempo de Espera",
    ['Cooldown.OnCooldown'] = "Debes esperar %s antes de comprar de nuevo.",
    ['Cooldown.LimitReached'] = "Límite de Compra Alcanzado",
    ['Cooldown.LimitReachedDesc'] = "Has alcanzado tu límite de compra de %d artículos. Por favor intenta de nuevo en %d horas.",
    
    -- ============================================
    -- CHECKOUT / PAYMENT SYSTEM
    -- ============================================
    ['Checkout.Title'] = "Pagar",
    ['Checkout.PaymentProcessed'] = "¡Tu pago fue procesado y recibiste tus artículos!",
    ['Checkout.PaymentRequest'] = "Solicitud de Pago",
    ['Checkout.PaymentRequestDesc'] = "Has recibido una solicitud de pago por $%d",
    ['Checkout.AcceptPayment'] = "Aceptar y Pagar",
    ['Checkout.AcceptPaymentDesc'] = "Completar tu compra",
    ['Checkout.DeclinePayment'] = "Rechazar Pago",
    ['Checkout.DeclinePaymentDesc'] = "Cancelar la transacción",
    ['Checkout.ProcessPayment'] = "Procesar Pago",
    ['Checkout.UseRegister'] = "Por favor usa la caja registradora para procesar el pago de $%d",
    ['Checkout.RequestedWait'] = "Has solicitado pagar. Por favor espera a que un empleado te asista.",
    ['Checkout.BasketEmpty'] = "¡Tu canasta está vacía!",
    ['Checkout.NoBasket'] = "¡No tienes una canasta!",
    ['Checkout.RequestAssistance'] = "%s está solicitando asistencia para pagar.",
    ['Checkout.SaleComplete'] = "Venta Completa",
    ['Checkout.PurchaseComplete'] = "Compra Completa",
    ['Checkout.YouPaid'] = "Pagaste $%d por tus artículos.",
    ['Checkout.CustomerPaidBusiness'] = "El cliente pagó $%d a la cuenta del negocio.",
    ['Checkout.CustomerPaidDirect'] = "El cliente te pagó $%d directamente.",
    ['Checkout.PaymentFailed'] = "Pago Fallido",
    ['Checkout.TransactionFailed'] = "La transacción no pudo completarse.",
    ['Checkout.CustomerPaymentFailed'] = "El pago del cliente falló.",
    ['Checkout.PurchaseCancelled'] = "Compra Cancelada",
    ['Checkout.YouDeclined'] = "Rechazaste el pago.",
    ['Checkout.CustomerDeclined'] = "El cliente rechazó el pago.",
    ['Checkout.PaymentMethod'] = "Método de Pago",
    ['Checkout.Cash'] = "Efectivo",
    ['Checkout.BankCard'] = "Tarjeta Bancaria",
    ['Checkout.BankMoney'] = "dinero en tu cuenta bancaria",
    ['Checkout.Amount'] = "Cantidad",
    ['Checkout.From'] = "De",
    ['Checkout.AmountMismatch'] = "Cantidad No Coincide",
    ['Checkout.AmountMismatchDesc'] = "La cantidad del pago no coincide con el total de la canasta: $%d",
    ['Checkout.CustomerNotEnoughMoney'] = "El cliente no tiene suficiente %s",
    ['Checkout.YouNotEnoughMoney'] = "No tienes suficiente %s",
    
    -- ============================================
    -- STOCK MANAGEMENT
    -- ============================================
    ['Stock.Management'] = "Gestión de Inventario",
    ['Stock.ManageStock'] = "Gestionar inventario de esta sección",
    ['Stock.Location'] = "Ubicación",
    ['Stock.CurrentStock'] = "Stock Actual",
    ['Stock.Stock'] = "Stock",
    ['Stock.AddStock'] = "Añadir Stock",
    ['Stock.RemoveStock'] = "Quitar Stock",
    ['Stock.Restock'] = "Reabastecer",
    ['Stock.RestockDesc'] = "¿Cuántos quieres añadir al estante?",
    ['Stock.OutOfStock'] = "Agotado",
    ['Stock.OutOfStockDesc'] = "Lo siento, %s está agotado.",
    ['Stock.LowStock'] = "Bajo Stock",
    ['Stock.NoPermission'] = "No tienes permiso para gestionar el inventario.",
    ['Stock.Updated'] = "Stock Actualizado",
    ['Stock.AddedItems'] = "Añadidos %d artículos. Nuevo stock: %d",
    ['Stock.RestockFailed'] = "Reabastecimiento Fallido",
    ['Stock.NotEnoughInventory'] = "No tienes suficiente %s en tu inventario.",
    
    -- ============================================
    -- CUSTOMER BASKET (EMPLOYEE VIEW)
    -- ============================================
    ['CustomerBasket.Title'] = "Canasta de %s",
    ['CustomerBasket.NoBasket'] = "Este cliente no tiene una canasta.",
    ['CustomerBasket.Empty'] = "La canasta de este cliente está vacía.",
    ['CustomerBasket.Total'] = "Total",
    ['CustomerBasket.Each'] = "cada uno",
    ['CustomerBasket.NoPermission'] = "No tienes permiso para ver las canastas de clientes.",
    
    -- ============================================
    -- REGISTER / CASH REGISTER
    -- ============================================
    ['Register.Title'] = "Caja Registradora",
    ['Register.NoPermission'] = "No tienes permiso para usar la caja registradora.",
    ['Register.NoItems'] = "El cliente no tiene artículos para comprar.",
    ['Register.NoCustomers'] = "No hay clientes cerca.",
    ['Register.SelectCustomer'] = "Seleccionar Cliente",
    ['Register.InvalidAmount'] = "Cantidad inválida.",
    
    -- ============================================
    -- TARGET LABELS
    -- ============================================
    ['Target.GrabBasket'] = "Tomar Canasta",
    ['Target.PutAwayBasket'] = "Guardar Canasta",
    ['Target.ViewBasket'] = "Ver Canasta del Cliente",
    ['Target.Checkout'] = "Solicitar Pago",
    ['Target.CashRegister'] = "Usar Caja Registradora",
    ['Target.BossMenu'] = "Abrir Menú de Jefe",
    ['Target.ManageStock'] = "Gestionar Inventario",
    ['Target.OpenStash'] = "Abrir %s",
    ['Target.OpenLocker'] = "Abrir Armario de Ropa",
    ['Target.SitDown'] = "Sentarse",
    ['Target.StandUp'] = "Levantarse",
    ['Target.Browse'] = "Explorar %s",
    ['Target.UseAsClient'] = "Usar %s como Cliente",
    ['Target.UseAsEmployee'] = "Usar %s como Empleado",
    
    -- ============================================
    -- STASH / STORAGE
    -- ============================================
    ['Stash.NoPermission'] = "No tienes permiso para acceder a este almacén.",
    
    -- ============================================
    -- CLOTHING
    -- ============================================
    ['Clothing.Locker'] = "Armario de Ropa",
    ['Clothing.OpenMenu'] = "Abrir Menú de Ropa",
    
    -- ============================================
    -- JOB INFO
    -- ============================================
    ['Job.Title'] = "Info del Trabajo",
    ['Job.Status'] = "Estado del Trabajo",
    ['Job.Name'] = "Nombre",
    ['Job.Grade'] = "Grado",
    ['Job.IsBoss'] = "Es Jefe",
    ['Job.Duty'] = "Servicio",
    
    -- ============================================
    -- BOSS MENU
    -- ============================================
    ['Boss.Title'] = "Menú de Jefe de Belleza",
    ['Boss.SocietyBalance'] = "Balance de la Sociedad",
    ['Boss.CurrentBalance'] = "Balance actual: $%s",
    ['Boss.WithdrawMoney'] = "Retirar Dinero de la Sociedad",
    ['Boss.DepositMoney'] = "Depositar Dinero",
    ['Boss.HireEmployee'] = "Contratar Empleado",
    ['Boss.FireEmployee'] = "Despedir Empleado",
    ['Boss.EmployeeManagement'] = "Gestión de Empleados",
    ['Boss.ViewBalance'] = "Ver Balance de la Sociedad",
    ['Boss.SetGrade'] = "Establecer Grado",
    ['Boss.HowMuchWithdraw'] = "¿Cuánto quieres retirar?",
    ['Boss.HowMuchDeposit'] = "¿Cuánto quieres depositar?",
    ['Boss.Amount'] = "Cantidad",
    ['Boss.NeedBeautyJob'] = "Necesitas trabajar en el salón de belleza para usar este comando.",
    ['Boss.NoPermission'] = "No tienes permiso para acceder al menú de jefe de belleza.",
    ['Boss.OnlyManagersHire'] = "Solo los gerentes pueden contratar empleados",
    ['Boss.OnlyManagersFire'] = "Solo los gerentes pueden despedir empleados",
    ['Boss.OnlyManagersGrade'] = "Solo los gerentes pueden cambiar grados de empleados",
    ['Boss.NoPermissionWithdraw'] = "No tienes permiso para retirar dinero.",
    ['Boss.NoPermissionDeposit'] = "No tienes permiso para depositar dinero.",
    ['Boss.NoPermissionBalance'] = "No tienes permiso para ver el balance de la sociedad.",
    ['Boss.NoPermissionEmployees'] = "No tienes permiso para ver la lista de empleados.",
    ['Boss.Hired'] = "¡Contratado!",
    ['Boss.YouHaveBeenHired'] = "Has sido contratado en el Salón de Belleza",
    ['Boss.EmployeeHiredSuccess'] = "Empleado contratado exitosamente",
    ['Boss.Fired'] = "Despedido",
    ['Boss.YouHaveBeenFired'] = "Has sido removido del salón de belleza",
    ['Boss.EmployeeFiredSuccess'] = "El empleado ha sido despedido",
    ['Boss.GradeChanged'] = "Grado Cambiado",
    ['Boss.YourGradeUpdated'] = "Tu grado ha sido actualizado",
    ['Boss.GradeUpdatedTo'] = "Grado del empleado actualizado a %d",
    ['Boss.WithdrawalSuccessful'] = "Retiro Exitoso",
    ['Boss.WithdrewAmount'] = "Retiraste $%s de la cuenta de la sociedad.",
    ['Boss.WithdrawalFailed'] = "Retiro Fallido",
    ['Boss.InsufficientFunds'] = "Fondos insuficientes en la cuenta de la sociedad.",
    ['Boss.DepositSuccessful'] = "Depósito Exitoso",
    ['Boss.DepositedAmount'] = "Depositaste $%s a la cuenta de la sociedad.",
    ['Boss.DepositFailed'] = "Depósito Fallido",
    ['Boss.SocietyNotFound'] = "Cuenta de la sociedad no encontrada.",
    ['Boss.NotEnoughMoney'] = "No tienes suficiente dinero.",
    
    -- ============================================
    -- HAIR STYLING
    -- ============================================
    ['Hair.Title'] = "Estilismo de Cabello",
    ['Hair.StyledSuccess'] = "¡Cabello estilizado exitosamente!",
    ['Hair.StylistWorking'] = "Un estilista está trabajando en tu cabello",
    ['Hair.Cancelled'] = "Estilismo de cabello cancelado",
    ['Hair.NoPermission'] = "No tienes permiso para estilizar cabello",
    ['Hair.AlreadyStyling'] = "Ya estás estilizando el cabello de alguien",
    ['Hair.SitInChair'] = "Sentarse en Silla del Salón",
    ['Hair.StyleHair'] = "Estilizar Cabello",
    ['Hair.DoHair'] = "Hacer Cabello",
    ['Hair.ClientLeft'] = "El cliente ha abandonado el servidor",
    ['Hair.StylistLeft'] = "El estilista ha abandonado el servidor",
    
    -- ============================================
    -- NAIL SERVICES
    -- ============================================
    ['Nails.Title'] = "Servicios de Uñas",
    ['Nails.LashServices'] = "Servicios de Pestañas",
    ['Nails.ApplyStyles'] = "Aplicar estilos de %s",
    ['Nails.ApplyingService'] = "Aplicando servicio...",
    ['Nails.GettingService'] = "Recibiendo servicio...",
    ['Nails.NailsComplete'] = "¡Tus uñas lucen increíbles!",
    ['Nails.NailServiceComplete'] = "¡Servicio de uñas completado!",
    ['Nails.LashesComplete'] = "¡Tus pestañas lucen hermosas!",
    ['Nails.LashServiceComplete'] = "¡Servicio de pestañas completado!",
    ['Nails.TechWorking'] = "Una técnica de uñas está trabajando en tus uñas",
    ['Nails.LashExpertWorking'] = "Una experta en pestañas está trabajando en tus pestañas",
    ['Nails.NoPermissionNails'] = "Debes ser técnica de uñas (Grado %d+) para hacer uñas",
    ['Nails.NoPermissionLashes'] = "Debes ser experta en pestañas (Grado %d+) para hacer pestañas",
    ['Nails.SitInChair'] = "Sentarse en Silla de Uñas",
    ['Nails.DoNails'] = "Hacer Uñas",
    ['Nails.DoLashes'] = "Hacer Pestañas",
    ['Nails.ClientDisconnected'] = "Cliente desconectado",
    ['Nails.TechDisconnected'] = "Técnico de uñas desconectado",
    ['Nails.LashExpertDisconnected'] = "Experto en pestañas desconectado",
    ['Nails.NailCancelledRestart'] = "Servicio de uñas cancelado (reinicio del servidor)",
    ['Nails.LashCancelledRestart'] = "Servicio de pestañas cancelado (reinicio del servidor)",
    ['Nails.NailCancelled'] = "Servicio de uñas cancelado",
    ['Nails.LashCancelled'] = "Servicio de pestañas cancelado",
    ['Nails.AppearanceSaved'] = "¡Apariencia guardada!",
    
    -- ============================================
    -- TRAP / STREET SELLING
    -- ============================================
    ['Trap.NotWoman'] = "¡Solo las mujeres pueden vender productos de belleza!",
    ['Trap.NoPolice'] = "No hay suficientes policías en línea para empezar a vender.",
    ['Trap.NoProducts'] = "¡No tienes productos de belleza para vender!",
    ['Trap.AlreadySelling'] = "¡Ya estás vendiendo productos!",
    ['Trap.WaitCustomer'] = "Buscando clientes... ¡Quédate cerca!",
    ['Trap.CustomerApproaching'] = "¡Un cliente se está acercando!",
    ['Trap.CustomerWaiting'] = "¡El cliente está listo para comprar!",
    ['Trap.CustomerLeft'] = "El cliente perdió interés y se fue.",
    ['Trap.SellProduct'] = "Vender Producto de Belleza",
    ['Trap.SaleSuccess'] = "Vendiste %dx %s por $%d",
    ['Trap.SaleRejected'] = "¡El cliente rechazó tu oferta!",
    ['Trap.SaleFailed'] = "Venta fallida: %s",
    ['Trap.TooFar'] = "¡Te alejaste demasiado del cliente!",
    ['Trap.Robbed'] = "¡El cliente intentó robarte!",
    ['Trap.RobberyFailed'] = "¡Te defendiste del ladrón!",
    ['Trap.RobberGotAway'] = "¡El ladrón escapó!",
    ['Trap.StoppedSelling'] = "Dejaste de vender productos de belleza.",
    ['Trap.InVehicle'] = "¡No puedes vender mientras estás en un vehículo!",
    ['Trap.NotBeautyJob'] = "¡Debes trabajar en el salón de belleza para vender productos!",
    ['Trap.Disabled'] = "El sistema de venta callejera está deshabilitado",
    ['Trap.WaitingProductData'] = "Esperando datos del producto...",
    ['Trap.NoItemAnymore'] = "¡Ya no tienes este artículo!",
    
    -- ============================================
    -- NOTIFICATIONS (GENERAL)
    -- ============================================
    ['Notify.CheckoutRequest'] = "Solicitud de Pago",
    ['Notify.CustomerNeedsAssistance'] = "¡Un cliente necesita asistencia para pagar en %s!",
    
    -- ============================================
    -- TABLET SYSTEM
    -- ============================================
    ['Tablet.NoJob'] = "Debes ser empleado del salón de belleza para usar esto.",
    ['Tablet.Opened'] = "Tablet abierta.",
    ['Tablet.Closed'] = "Tablet cerrada.",
    
    -- Passing tablet
    ['Tablet.SelectCustomer'] = "Selecciona un cliente para pasarle la tablet.",
    ['Tablet.NoNearbyPlayers'] = "No hay clientes cerca.",
    ['Tablet.NoCustomerNearby'] = "No hay cliente cerca.",
    ['Tablet.PassTablet'] = "Pasar Tablet",
    ['Tablet.PassingTablet'] = "Pasando tablet al cliente...",
    ['Tablet.TabletPassed'] = "Tablet pasada. Esperando respuesta del cliente.",
    
    -- Customer prompts
    ['Tablet.OfferTitle'] = "Pago del Salón de Belleza",
    ['Tablet.OfferDesc'] = "%s quiere darte la tablet de pago.",
    ['Tablet.Accept'] = "Aceptar",
    ['Tablet.Decline'] = "Rechazar",
    ['Tablet.DeclineReasonTitle'] = "Razón del Rechazo",
    ['Tablet.DeclineReasonDesc'] = "¿Por qué rechazas? (opcional)",
    
    -- Customer received
    ['Tablet.Received'] = "Revisa tus servicios y completa el pago.",
    
    -- Decline handling
    ['Tablet.Declined'] = "El cliente rechazó la tablet.",
    ['Tablet.DeclinedWithReason'] = "Cliente rechazó: %s",
    ['Tablet.YouDeclined'] = "Rechazaste la tablet.",
    
    -- Payment
    ['Tablet.PaymentSuccessEmployee'] = "¡Pago de $%s recibido! (Propina: $%s)",
    ['Tablet.PaymentSuccessCustomer'] = "Pagaste $%s. ¡Gracias por visitar el Salón de Belleza!",
    ['Tablet.NoMoneyCash'] = "No tienes suficiente efectivo.",
    ['Tablet.NoMoneyBank'] = "No tienes suficiente en tu cuenta bancaria.",
    ['Tablet.PaymentFailed'] = "Pago fallido.",
    ['Tablet.TransactionExpired'] = "Transacción expirada.",
    
    -- Availability
    ['Tablet.AvailabilityTitle'] = "Establecer Disponibilidad",
    ['Tablet.SetAvailable'] = "Establecer Disponible",
    ['Tablet.SetUnavailable'] = "Establecer No Disponible",
    ['Tablet.NowAvailable'] = "Ahora estás disponible para citas.",
    ['Tablet.NowUnavailable'] = "Ahora no estás disponible.",
    
    -- Management
    ['Tablet.PriceUpdated'] = "Precio de %s actualizado a $%s.",
    ['Tablet.ShelfPriceUpdated'] = "Precio del estante actualizado a $%s.",
    ['Tablet.LimitUpdated'] = "Límite de cobro personalizado establecido en $%s.",
    ['Tablet.ChargeLimitUpdated'] = "Límite de cobro establecido en $%s.",
    ['Tablet.NoPermission'] = "No tienes permiso para hacer esto.",
    
    -- Stats
    ['Tablet.StatsToday'] = "Ventas de Hoy: $%s (%d clientes)",
    ['Tablet.StatsWeek'] = "Esta Semana: $%s (%d clientes)",
    
    -- Finances
    ['Tablet.DepositSuccess'] = "Depositado $%s a la sociedad.",
    ['Tablet.WithdrawSuccess'] = "Retirado $%s de la sociedad.",
    ['Tablet.DepositFailed'] = "Falló el depósito a la sociedad.",
    ['Tablet.WithdrawFailed'] = "Fondos insuficientes en la cuenta de la sociedad.",
    ['Tablet.NotEnoughCash'] = "No tienes suficiente efectivo.",
    
    -- Employee Management
    ['Tablet.EmployeeHired'] = "Contratado %s como Grado %d.",
    ['Tablet.YouWereHired'] = "¡Has sido contratado en el Salón de Belleza!",
    ['Tablet.EmployeeFired'] = "Empleado despedido.",
    ['Tablet.YouWereFired'] = "Has sido despedido del Salón de Belleza.",
    ['Tablet.GradeUpdated'] = "Grado del empleado actualizado.",
    ['Tablet.YourGradeUpdated'] = "¡Tu posición ha sido actualizada!",
    ['Tablet.PlayerNotFound'] = "Jugador no encontrado.",
    
    -- Disconnection
    ['Tablet.EmployeeDisconnected'] = "El empleado se desconectó.",
    ['Tablet.CustomerDisconnected'] = "El cliente se desconectó.",
    
    -- Customer accepted/declined
    ['Tablet.CustomerAccepted'] = "El cliente aceptó la tablet.",

    -- Appointments (Full Booking System)
    ['Tablet.AvailabilitySaved'] = "Tu disponibilidad ha sido guardada.",
    ['Tablet.NewAppointment'] = "Nueva Cita",
    ['Tablet.AppointmentCancelledRefund'] = "Cita cancelada - depósito reembolsado.",
    ['Tablet.AppointmentCancelledNoRefund'] = "Cita cancelada - sin reembolso (muy tarde).",
    ['Tablet.AppointmentReminder'] = "Recordatorio de Cita",
    ['Tablet.ReminderCustomer'] = "Recordatorio: ¡Tienes una cita en %s minutos!",
    ['Tablet.ReminderEmployee'] = "%s tiene una cita en %s minutos.",
    ['Tablet.NotEnoughForDeposit'] = "No tienes suficiente dinero para el depósito ($%s requerido).",
    ['Tablet.BookingSuccess'] = "¡Cita reservada! Depósito de $%s pagado.",
    ['Tablet.RefundGiven'] = "Tu depósito de $%s ha sido reembolsado.",
    ['Tablet.BookAppointment'] = "Reservar Cita",
    ['Tablet.SelectEmployee'] = "Seleccionar Estilista",
    ['Tablet.SelectDate'] = "Seleccionar Fecha",
    ['Tablet.SelectTime'] = "Seleccionar Hora",
    ['Tablet.ConfirmBooking'] = "Confirmar Reserva",
    ['Tablet.DepositRequired'] = "Depósito: $%s",
    ['Tablet.NoEmployeesAvailable'] = "No hay estilistas disponibles para reservar.",
    ['Tablet.NoDatesAvailable'] = "No hay fechas disponibles.",
    ['Tablet.NoTimesAvailable'] = "No hay horarios disponibles.",
    ['Tablet.MyBookings'] = "Mis Reservas",
    ['Tablet.ManageAvailability'] = "Gestionar Disponibilidad",
}