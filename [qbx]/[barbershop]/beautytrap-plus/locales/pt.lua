--[[
    ============================================
    PORTUGUESE LOCALE - BEAUTYTRAP-PLUS
    COMPLETE VERSION - ALL FILES
    ============================================
]]--

Locales['pt'] = {
    -- ============================================
    -- GENERAL
    -- ============================================
    ['General.AccessDenied'] = "Acesso Negado",
    ['General.NoPermission'] = "Você não tem permissão para acessar isso.",
    ['General.Error'] = "Erro",
    ['General.Success'] = "Sucesso",
    ['General.Info'] = "Info",
    ['General.Cancel'] = "Cancelar",
    ['General.Confirm'] = "Confirmar",
    ['General.Back'] = "Voltar",
    ['General.Close'] = "Fechar",
    ['General.UnknownError'] = "Erro desconhecido",
    
    -- ============================================
    -- DUTY SYSTEM
    -- ============================================
    ['Duty.OnDuty'] = "Em Serviço",
    ['Duty.OffDuty'] = "Fora de Serviço",
    ['Duty.NowOnDuty'] = "Você está agora em serviço como %s",
    ['Duty.NowOffDuty'] = "Você está agora fora de serviço",
    ['Duty.ToggleDuty'] = "Alternar Serviço",
    ['Duty.NoPermission'] = "Você não tem permissão para alterar o status de serviço.",
    ['Duty.NoPermissionStation'] = "Você não tem permissão para usar esta estação de serviço.",
    
    -- ============================================
    -- BASKET / SHOPPING SYSTEM
    -- ============================================
    ['Basket.Title'] = "Cesta",
    ['Basket.GrabbedBasket'] = "Você pegou uma cesta de compras!",
    ['Basket.GrabbedGunCase'] = "Você pegou um estojo de armas!",
    ['Basket.GrabbedShoppingBag'] = "Você pegou uma sacola de compras!",
    ['Basket.AlreadyHaveBasket'] = "Você já tem uma cesta!",
    ['Basket.NeedBasket'] = "Você precisa pegar uma cesta primeiro!",
    ['Basket.PutAway'] = "Você guardou a cesta.",
    ['Basket.NoBasketToPutAway'] = "Você não tem uma cesta para guardar!",
    ['Basket.NoLongerHaveBasket'] = "Você não tem mais uma cesta.",
    ['Basket.InvalidStoreData'] = "Dados da loja inválidos!",
    ['Basket.StoreTypeNotExist'] = "Este tipo de loja não existe!",
    ['Basket.ItemAdded'] = "%s adicionado à sua cesta!",
    ['Basket.ItemRemoved'] = "%s removido da cesta",
    ['Basket.BasketFull'] = "Cesta Cheia",
    ['Basket.BasketLimit'] = "Sua cesta só pode conter %d itens.",
    ['Basket.BasketLimitFull'] = "Sua cesta só pode conter %d itens. Você já tem %d itens.",
    ['Basket.Shoplifting'] = "Você foi pego roubando e derrubou todos os itens!",
    
    -- ============================================
    -- SHOP / ITEM BROWSING
    -- ============================================
    ['Shop.SelectItems'] = "Selecionar Itens",
    ['Shop.SelectQuantity'] = "Selecionar Quantidade",
    ['Shop.Quantity'] = "Quantidade",
    ['Shop.Price'] = "Preço",
    ['Shop.InvalidQuantity'] = "Quantidade inválida!",
    ['Shop.AddToBasket'] = "Adicionar à cesta (Estoque: %d)",
    ['Shop.HowManyAdd'] = "Quantos você quer adicionar? (Máx: %d)",
    
    -- ============================================
    -- COOLDOWN SYSTEM
    -- ============================================
    ['Cooldown.Title'] = "Tempo de Espera",
    ['Cooldown.OnCooldown'] = "Você deve esperar %s antes de comprar novamente.",
    ['Cooldown.LimitReached'] = "Limite de Compra Atingido",
    ['Cooldown.LimitReachedDesc'] = "Você atingiu seu limite de compra de %d itens. Por favor tente novamente em %d horas.",
    
    -- ============================================
    -- CHECKOUT / PAYMENT SYSTEM
    -- ============================================
    ['Checkout.Title'] = "Pagamento",
    ['Checkout.PaymentProcessed'] = "Seu pagamento foi processado e você recebeu seus itens!",
    ['Checkout.PaymentRequest'] = "Solicitação de Pagamento",
    ['Checkout.PaymentRequestDesc'] = "Você recebeu uma solicitação de pagamento de $%d",
    ['Checkout.AcceptPayment'] = "Aceitar e Pagar",
    ['Checkout.AcceptPaymentDesc'] = "Completar sua compra",
    ['Checkout.DeclinePayment'] = "Recusar Pagamento",
    ['Checkout.DeclinePaymentDesc'] = "Cancelar a transação",
    ['Checkout.ProcessPayment'] = "Processar Pagamento",
    ['Checkout.UseRegister'] = "Por favor use a caixa registradora para processar o pagamento de $%d",
    ['Checkout.RequestedWait'] = "Você solicitou pagar. Por favor espere um funcionário te ajudar.",
    ['Checkout.BasketEmpty'] = "Sua cesta está vazia!",
    ['Checkout.NoBasket'] = "Você não tem uma cesta!",
    ['Checkout.RequestAssistance'] = "%s está solicitando ajuda para pagar.",
    ['Checkout.SaleComplete'] = "Venda Completa",
    ['Checkout.PurchaseComplete'] = "Compra Completa",
    ['Checkout.YouPaid'] = "Você pagou $%d pelos seus itens.",
    ['Checkout.CustomerPaidBusiness'] = "O cliente pagou $%d para a conta do negócio.",
    ['Checkout.CustomerPaidDirect'] = "O cliente te pagou $%d diretamente.",
    ['Checkout.PaymentFailed'] = "Pagamento Falhou",
    ['Checkout.TransactionFailed'] = "A transação não pôde ser completada.",
    ['Checkout.CustomerPaymentFailed'] = "O pagamento do cliente falhou.",
    ['Checkout.PurchaseCancelled'] = "Compra Cancelada",
    ['Checkout.YouDeclined'] = "Você recusou o pagamento.",
    ['Checkout.CustomerDeclined'] = "O cliente recusou o pagamento.",
    ['Checkout.PaymentMethod'] = "Método de Pagamento",
    ['Checkout.Cash'] = "Dinheiro",
    ['Checkout.BankCard'] = "Cartão Bancário",
    ['Checkout.BankMoney'] = "dinheiro na sua conta bancária",
    ['Checkout.Amount'] = "Valor",
    ['Checkout.From'] = "De",
    ['Checkout.AmountMismatch'] = "Valor Não Corresponde",
    ['Checkout.AmountMismatchDesc'] = "O valor do pagamento não corresponde ao total da cesta: $%d",
    ['Checkout.CustomerNotEnoughMoney'] = "O cliente não tem %s suficiente",
    ['Checkout.YouNotEnoughMoney'] = "Você não tem %s suficiente",
    
    -- ============================================
    -- STOCK MANAGEMENT
    -- ============================================
    ['Stock.Management'] = "Gestão de Estoque",
    ['Stock.ManageStock'] = "Gerenciar estoque desta seção",
    ['Stock.Location'] = "Localização",
    ['Stock.CurrentStock'] = "Estoque Atual",
    ['Stock.Stock'] = "Estoque",
    ['Stock.AddStock'] = "Adicionar Estoque",
    ['Stock.RemoveStock'] = "Remover Estoque",
    ['Stock.Restock'] = "Reabastecer",
    ['Stock.RestockDesc'] = "Quantos você quer adicionar à prateleira?",
    ['Stock.OutOfStock'] = "Esgotado",
    ['Stock.OutOfStockDesc'] = "Desculpe, %s está esgotado.",
    ['Stock.LowStock'] = "Estoque Baixo",
    ['Stock.NoPermission'] = "Você não tem permissão para gerenciar o estoque.",
    ['Stock.Updated'] = "Estoque Atualizado",
    ['Stock.AddedItems'] = "%d itens adicionados. Novo estoque: %d",
    ['Stock.RestockFailed'] = "Reabastecimento Falhou",
    ['Stock.NotEnoughInventory'] = "Você não tem %s suficiente no seu inventário.",
    
    -- ============================================
    -- CUSTOMER BASKET (EMPLOYEE VIEW)
    -- ============================================
    ['CustomerBasket.Title'] = "Cesta de %s",
    ['CustomerBasket.NoBasket'] = "Este cliente não tem uma cesta.",
    ['CustomerBasket.Empty'] = "A cesta deste cliente está vazia.",
    ['CustomerBasket.Total'] = "Total",
    ['CustomerBasket.Each'] = "cada",
    ['CustomerBasket.NoPermission'] = "Você não tem permissão para ver cestas de clientes.",
    
    -- ============================================
    -- REGISTER / CASH REGISTER
    -- ============================================
    ['Register.Title'] = "Caixa Registradora",
    ['Register.NoPermission'] = "Você não tem permissão para usar a caixa registradora.",
    ['Register.NoItems'] = "O cliente não tem itens para comprar.",
    ['Register.NoCustomers'] = "Nenhum cliente por perto.",
    ['Register.SelectCustomer'] = "Selecionar Cliente",
    ['Register.InvalidAmount'] = "Valor inválido.",
    
    -- ============================================
    -- TARGET LABELS
    -- ============================================
    ['Target.GrabBasket'] = "Pegar Cesta",
    ['Target.PutAwayBasket'] = "Guardar Cesta",
    ['Target.ViewBasket'] = "Ver Cesta do Cliente",
    ['Target.Checkout'] = "Solicitar Pagamento",
    ['Target.CashRegister'] = "Usar Caixa Registradora",
    ['Target.BossMenu'] = "Abrir Menu do Chefe",
    ['Target.ManageStock'] = "Gerenciar Estoque",
    ['Target.OpenStash'] = "Abrir %s",
    ['Target.OpenLocker'] = "Abrir Armário de Roupas",
    ['Target.SitDown'] = "Sentar",
    ['Target.StandUp'] = "Levantar",
    ['Target.Browse'] = "Explorar %s",
    ['Target.UseAsClient'] = "Usar %s como Cliente",
    ['Target.UseAsEmployee'] = "Usar %s como Funcionário",
    
    -- ============================================
    -- STASH / STORAGE
    -- ============================================
    ['Stash.NoPermission'] = "Você não tem permissão para acessar este armazém.",
    
    -- ============================================
    -- CLOTHING
    -- ============================================
    ['Clothing.Locker'] = "Armário de Roupas",
    ['Clothing.OpenMenu'] = "Abrir Menu de Roupas",
    
    -- ============================================
    -- JOB INFO
    -- ============================================
    ['Job.Title'] = "Info do Trabalho",
    ['Job.Status'] = "Status do Trabalho",
    ['Job.Name'] = "Nome",
    ['Job.Grade'] = "Grau",
    ['Job.IsBoss'] = "É Chefe",
    ['Job.Duty'] = "Serviço",
    
    -- ============================================
    -- BOSS MENU
    -- ============================================
    ['Boss.Title'] = "Menu do Chefe de Beleza",
    ['Boss.SocietyBalance'] = "Saldo da Sociedade",
    ['Boss.CurrentBalance'] = "Saldo atual: $%s",
    ['Boss.WithdrawMoney'] = "Sacar Dinheiro da Sociedade",
    ['Boss.DepositMoney'] = "Depositar Dinheiro",
    ['Boss.HireEmployee'] = "Contratar Funcionário",
    ['Boss.FireEmployee'] = "Demitir Funcionário",
    ['Boss.EmployeeManagement'] = "Gestão de Funcionários",
    ['Boss.ViewBalance'] = "Ver Saldo da Sociedade",
    ['Boss.SetGrade'] = "Definir Grau",
    ['Boss.HowMuchWithdraw'] = "Quanto você quer sacar?",
    ['Boss.HowMuchDeposit'] = "Quanto você quer depositar?",
    ['Boss.Amount'] = "Valor",
    ['Boss.NeedBeautyJob'] = "Você precisa trabalhar no salão de beleza para usar este comando.",
    ['Boss.NoPermission'] = "Você não tem permissão para acessar o menu do chefe de beleza.",
    ['Boss.OnlyManagersHire'] = "Apenas gerentes podem contratar funcionários",
    ['Boss.OnlyManagersFire'] = "Apenas gerentes podem demitir funcionários",
    ['Boss.OnlyManagersGrade'] = "Apenas gerentes podem alterar graus de funcionários",
    ['Boss.NoPermissionWithdraw'] = "Você não tem permissão para sacar dinheiro.",
    ['Boss.NoPermissionDeposit'] = "Você não tem permissão para depositar dinheiro.",
    ['Boss.NoPermissionBalance'] = "Você não tem permissão para ver o saldo da sociedade.",
    ['Boss.NoPermissionEmployees'] = "Você não tem permissão para ver a lista de funcionários.",
    ['Boss.Hired'] = "Contratado!",
    ['Boss.YouHaveBeenHired'] = "Você foi contratado no Salão de Beleza",
    ['Boss.EmployeeHiredSuccess'] = "Funcionário contratado com sucesso",
    ['Boss.Fired'] = "Demitido",
    ['Boss.YouHaveBeenFired'] = "Você foi removido do salão de beleza",
    ['Boss.EmployeeFiredSuccess'] = "O funcionário foi demitido",
    ['Boss.GradeChanged'] = "Grau Alterado",
    ['Boss.YourGradeUpdated'] = "Seu grau foi atualizado",
    ['Boss.GradeUpdatedTo'] = "Grau do funcionário atualizado para %d",
    ['Boss.WithdrawalSuccessful'] = "Saque Bem-sucedido",
    ['Boss.WithdrewAmount'] = "Você sacou $%s da conta da sociedade.",
    ['Boss.WithdrawalFailed'] = "Saque Falhou",
    ['Boss.InsufficientFunds'] = "Fundos insuficientes na conta da sociedade.",
    ['Boss.DepositSuccessful'] = "Depósito Bem-sucedido",
    ['Boss.DepositedAmount'] = "Você depositou $%s na conta da sociedade.",
    ['Boss.DepositFailed'] = "Depósito Falhou",
    ['Boss.SocietyNotFound'] = "Conta da sociedade não encontrada.",
    ['Boss.NotEnoughMoney'] = "Você não tem dinheiro suficiente.",
    
    -- ============================================
    -- HAIR STYLING
    -- ============================================
    ['Hair.Title'] = "Estilização de Cabelo",
    ['Hair.StyledSuccess'] = "Cabelo estilizado com sucesso!",
    ['Hair.StylistWorking'] = "Um estilista está trabalhando no seu cabelo",
    ['Hair.Cancelled'] = "Estilização de cabelo cancelada",
    ['Hair.NoPermission'] = "Você não tem permissão para estilizar cabelo",
    ['Hair.AlreadyStyling'] = "Você já está estilizando o cabelo de alguém",
    ['Hair.SitInChair'] = "Sentar na Cadeira do Salão",
    ['Hair.StyleHair'] = "Estilizar Cabelo",
    ['Hair.DoHair'] = "Fazer Cabelo",
    ['Hair.ClientLeft'] = "O cliente saiu do servidor",
    ['Hair.StylistLeft'] = "O estilista saiu do servidor",
    
    -- ============================================
    -- NAIL SERVICES
    -- ============================================
    ['Nails.Title'] = "Serviços de Unhas",
    ['Nails.LashServices'] = "Serviços de Cílios",
    ['Nails.ApplyStyles'] = "Aplicar estilos de %s",
    ['Nails.ApplyingService'] = "Aplicando serviço...",
    ['Nails.GettingService'] = "Recebendo serviço...",
    ['Nails.NailsComplete'] = "Suas unhas estão incríveis!",
    ['Nails.NailServiceComplete'] = "Serviço de unhas concluído!",
    ['Nails.LashesComplete'] = "Seus cílios estão lindos!",
    ['Nails.LashServiceComplete'] = "Serviço de cílios concluído!",
    ['Nails.TechWorking'] = "Uma técnica de unhas está trabalhando nas suas unhas",
    ['Nails.LashExpertWorking'] = "Uma especialista em cílios está trabalhando nos seus cílios",
    ['Nails.NoPermissionNails'] = "Você precisa ser técnica de unhas (Grau %d+) para fazer unhas",
    ['Nails.NoPermissionLashes'] = "Você precisa ser especialista em cílios (Grau %d+) para fazer cílios",
    ['Nails.SitInChair'] = "Sentar na Cadeira de Manicure",
    ['Nails.DoNails'] = "Fazer Unhas",
    ['Nails.DoLashes'] = "Fazer Cílios",
    ['Nails.ClientDisconnected'] = "Cliente desconectado",
    ['Nails.TechDisconnected'] = "Técnico de unhas desconectado",
    ['Nails.LashExpertDisconnected'] = "Especialista em cílios desconectado",
    ['Nails.NailCancelledRestart'] = "Serviço de unhas cancelado (reinício do servidor)",
    ['Nails.LashCancelledRestart'] = "Serviço de cílios cancelado (reinício do servidor)",
    ['Nails.NailCancelled'] = "Serviço de unhas cancelado",
    ['Nails.LashCancelled'] = "Serviço de cílios cancelado",
    ['Nails.AppearanceSaved'] = "Aparência salva!",
    
    -- ============================================
    -- TRAP / STREET SELLING
    -- ============================================
    ['Trap.NotWoman'] = "Apenas mulheres podem vender produtos de beleza!",
    ['Trap.NoPolice'] = "Não há policiais suficientes online para começar a vender.",
    ['Trap.NoProducts'] = "Você não tem produtos de beleza para vender!",
    ['Trap.AlreadySelling'] = "Você já está vendendo produtos!",
    ['Trap.WaitCustomer'] = "Procurando clientes... Fique por perto!",
    ['Trap.CustomerApproaching'] = "Um cliente está se aproximando!",
    ['Trap.CustomerWaiting'] = "O cliente está pronto para comprar!",
    ['Trap.CustomerLeft'] = "O cliente perdeu interesse e foi embora.",
    ['Trap.SellProduct'] = "Vender Produto de Beleza",
    ['Trap.SaleSuccess'] = "Vendeu %dx %s por $%d",
    ['Trap.SaleRejected'] = "O cliente rejeitou sua oferta!",
    ['Trap.SaleFailed'] = "Venda falhou: %s",
    ['Trap.TooFar'] = "Você se afastou demais do cliente!",
    ['Trap.Robbed'] = "O cliente tentou te roubar!",
    ['Trap.RobberyFailed'] = "Você se defendeu do ladrão!",
    ['Trap.RobberGotAway'] = "O ladrão fugiu!",
    ['Trap.StoppedSelling'] = "Parou de vender produtos de beleza.",
    ['Trap.InVehicle'] = "Você não pode vender dentro de um veículo!",
    ['Trap.NotBeautyJob'] = "Você precisa trabalhar no salão de beleza para vender produtos!",
    ['Trap.Disabled'] = "O sistema de venda de rua está desativado no momento",
    ['Trap.WaitingProductData'] = "Aguardando dados do produto...",
    ['Trap.NoItemAnymore'] = "Você não tem mais este item!",
    
    -- ============================================
    -- NOTIFICATIONS (GENERAL)
    -- ============================================
    ['Notify.CheckoutRequest'] = "Solicitação de Pagamento",
    ['Notify.CustomerNeedsAssistance'] = "Um cliente precisa de ajuda para pagar em %s!",
    
    -- ============================================
    -- TABLET SYSTEM
    -- ============================================
    ['Tablet.NoJob'] = "Você precisa ser funcionário do salão de beleza para usar isso.",
    ['Tablet.Opened'] = "Tablet aberto.",
    ['Tablet.Closed'] = "Tablet fechado.",
    
    -- Passing tablet
    ['Tablet.SelectCustomer'] = "Selecione um cliente para passar o tablet.",
    ['Tablet.NoNearbyPlayers'] = "Nenhum cliente por perto.",
    ['Tablet.NoCustomerNearby'] = "Nenhum cliente por perto.",
    ['Tablet.PassTablet'] = "Passar Tablet",
    ['Tablet.PassingTablet'] = "Passando tablet para o cliente...",
    ['Tablet.TabletPassed'] = "Tablet passado. Aguardando resposta do cliente.",
    
    -- Customer prompts
    ['Tablet.OfferTitle'] = "Pagamento do Salão de Beleza",
    ['Tablet.OfferDesc'] = "%s quer te dar o tablet de pagamento.",
    ['Tablet.Accept'] = "Aceitar",
    ['Tablet.Decline'] = "Recusar",
    ['Tablet.DeclineReasonTitle'] = "Motivo da Recusa",
    ['Tablet.DeclineReasonDesc'] = "Por que você está recusando? (opcional)",
    
    -- Customer received
    ['Tablet.Received'] = "Revise seus serviços e complete o pagamento.",
    
    -- Decline handling
    ['Tablet.Declined'] = "O cliente recusou o tablet.",
    ['Tablet.DeclinedWithReason'] = "Cliente recusou: %s",
    ['Tablet.YouDeclined'] = "Você recusou o tablet.",
    
    -- Payment
    ['Tablet.PaymentSuccessEmployee'] = "Pagamento de $%s recebido! (Gorjeta: $%s)",
    ['Tablet.PaymentSuccessCustomer'] = "Você pagou $%s. Obrigado por visitar o Salão de Beleza!",
    ['Tablet.NoMoneyCash'] = "Você não tem dinheiro suficiente.",
    ['Tablet.NoMoneyBank'] = "Você não tem saldo suficiente na sua conta bancária.",
    ['Tablet.PaymentFailed'] = "Pagamento falhou.",
    ['Tablet.TransactionExpired'] = "Transação expirada.",
    
    -- Availability
    ['Tablet.AvailabilityTitle'] = "Definir Disponibilidade",
    ['Tablet.SetAvailable'] = "Ficar Disponível",
    ['Tablet.SetUnavailable'] = "Ficar Indisponível",
    ['Tablet.NowAvailable'] = "Você está agora disponível para agendamentos.",
    ['Tablet.NowUnavailable'] = "Você está agora indisponível.",
    
    -- Management
    ['Tablet.PriceUpdated'] = "Preço de %s atualizado para $%s.",
    ['Tablet.ShelfPriceUpdated'] = "Preço da prateleira atualizado para $%s.",
    ['Tablet.LimitUpdated'] = "Limite de cobrança personalizado definido para $%s.",
    ['Tablet.ChargeLimitUpdated'] = "Limite de cobrança definido para $%s.",
    ['Tablet.NoPermission'] = "Você não tem permissão para fazer isso.",
    
    -- Stats
    ['Tablet.StatsToday'] = "Vendas de Hoje: $%s (%d clientes)",
    ['Tablet.StatsWeek'] = "Esta Semana: $%s (%d clientes)",
    
    -- Finances
    ['Tablet.DepositSuccess'] = "Depositado $%s para a sociedade.",
    ['Tablet.WithdrawSuccess'] = "Sacado $%s da sociedade.",
    ['Tablet.DepositFailed'] = "Falha ao depositar para a sociedade.",
    ['Tablet.WithdrawFailed'] = "Fundos insuficientes na conta da sociedade.",
    ['Tablet.NotEnoughCash'] = "Você não tem dinheiro suficiente.",
    
    -- Employee Management
    ['Tablet.EmployeeHired'] = "%s contratado como Grau %d.",
    ['Tablet.YouWereHired'] = "Você foi contratado no Salão de Beleza!",
    ['Tablet.EmployeeFired'] = "Funcionário demitido.",
    ['Tablet.YouWereFired'] = "Você foi demitido do Salão de Beleza.",
    ['Tablet.GradeUpdated'] = "Grau do funcionário atualizado.",
    ['Tablet.YourGradeUpdated'] = "Sua posição foi atualizada!",
    ['Tablet.PlayerNotFound'] = "Jogador não encontrado.",
    
    -- Disconnection
    ['Tablet.EmployeeDisconnected'] = "O funcionário desconectou.",
    ['Tablet.CustomerDisconnected'] = "O cliente desconectou.",
    
    -- Customer accepted/declined
    ['Tablet.CustomerAccepted'] = "O cliente aceitou o tablet.",

    -- Appointments (Full Booking System)
    ['Tablet.AvailabilitySaved'] = "Sua disponibilidade foi salva.",
    ['Tablet.NewAppointment'] = "Novo Agendamento",
    ['Tablet.AppointmentCancelledRefund'] = "Agendamento cancelado - depósito reembolsado.",
    ['Tablet.AppointmentCancelledNoRefund'] = "Agendamento cancelado - sem reembolso (tarde demais).",
    ['Tablet.AppointmentReminder'] = "Lembrete de Agendamento",
    ['Tablet.ReminderCustomer'] = "Lembrete: Você tem um agendamento em %s minutos!",
    ['Tablet.ReminderEmployee'] = "%s tem um agendamento em %s minutos.",
    ['Tablet.NotEnoughForDeposit'] = "Dinheiro insuficiente para o depósito ($%s necessário).",
    ['Tablet.BookingSuccess'] = "Agendamento confirmado! Depósito de $%s pago.",
    ['Tablet.RefundGiven'] = "Seu depósito de $%s foi reembolsado.",
    ['Tablet.BookAppointment'] = "Agendar",
    ['Tablet.SelectEmployee'] = "Selecionar Estilista",
    ['Tablet.SelectDate'] = "Selecionar Data",
    ['Tablet.SelectTime'] = "Selecionar Horário",
    ['Tablet.ConfirmBooking'] = "Confirmar Agendamento",
    ['Tablet.DepositRequired'] = "Depósito: $%s",
    ['Tablet.NoEmployeesAvailable'] = "Nenhum estilista disponível para agendamento.",
    ['Tablet.NoDatesAvailable'] = "Nenhuma data disponível.",
    ['Tablet.NoTimesAvailable'] = "Nenhum horário disponível.",
    ['Tablet.MyBookings'] = "Meus Agendamentos",
    ['Tablet.ManageAvailability'] = "Gerenciar Disponibilidade",
}