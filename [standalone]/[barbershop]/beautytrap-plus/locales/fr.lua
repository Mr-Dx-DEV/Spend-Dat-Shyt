--[[
    ============================================
    FRENCH LOCALE - BEAUTYTRAP-PLUS
    COMPLETE VERSION - ALL FILES
    ============================================
]]--

Locales['fr'] = {
    -- ============================================
    -- GENERAL
    -- ============================================
    ['General.AccessDenied'] = "Accès Refusé",
    ['General.NoPermission'] = "Vous n'avez pas la permission d'accéder à ceci.",
    ['General.Error'] = "Erreur",
    ['General.Success'] = "Succès",
    ['General.Info'] = "Info",
    ['General.Cancel'] = "Annuler",
    ['General.Confirm'] = "Confirmer",
    ['General.Back'] = "Retour",
    ['General.Close'] = "Fermer",
    ['General.UnknownError'] = "Erreur inconnue",
    
    -- ============================================
    -- DUTY SYSTEM
    -- ============================================
    ['Duty.OnDuty'] = "En Service",
    ['Duty.OffDuty'] = "Hors Service",
    ['Duty.NowOnDuty'] = "Vous êtes maintenant en service en tant que %s",
    ['Duty.NowOffDuty'] = "Vous êtes maintenant hors service",
    ['Duty.ToggleDuty'] = "Changer le Service",
    ['Duty.NoPermission'] = "Vous n'avez pas la permission de changer le statut de service.",
    ['Duty.NoPermissionStation'] = "Vous n'avez pas la permission d'utiliser cette station de service.",
    
    -- ============================================
    -- BASKET / SHOPPING SYSTEM
    -- ============================================
    ['Basket.Title'] = "Panier",
    ['Basket.GrabbedBasket'] = "Vous avez pris un panier de courses!",
    ['Basket.GrabbedGunCase'] = "Vous avez pris une mallette d'armes!",
    ['Basket.GrabbedShoppingBag'] = "Vous avez pris un sac de courses!",
    ['Basket.AlreadyHaveBasket'] = "Vous avez déjà un panier!",
    ['Basket.NeedBasket'] = "Vous devez d'abord prendre un panier!",
    ['Basket.PutAway'] = "Vous avez rangé le panier.",
    ['Basket.NoBasketToPutAway'] = "Vous n'avez pas de panier à ranger!",
    ['Basket.NoLongerHaveBasket'] = "Vous n'avez plus de panier.",
    ['Basket.InvalidStoreData'] = "Données du magasin invalides!",
    ['Basket.StoreTypeNotExist'] = "Ce type de magasin n'existe pas!",
    ['Basket.ItemAdded'] = "%s ajouté à votre panier!",
    ['Basket.ItemRemoved'] = "%s retiré du panier",
    ['Basket.BasketFull'] = "Panier Plein",
    ['Basket.BasketLimit'] = "Votre panier ne peut contenir que %d articles.",
    ['Basket.BasketLimitFull'] = "Votre panier ne peut contenir que %d articles. Vous avez déjà %d articles.",
    ['Basket.Shoplifting'] = "Vous avez été pris en train de voler et avez lâché tous les articles!",
    
    -- ============================================
    -- SHOP / ITEM BROWSING
    -- ============================================
    ['Shop.SelectItems'] = "Sélectionner des Articles",
    ['Shop.SelectQuantity'] = "Sélectionner la Quantité",
    ['Shop.Quantity'] = "Quantité",
    ['Shop.Price'] = "Prix",
    ['Shop.InvalidQuantity'] = "Quantité invalide!",
    ['Shop.AddToBasket'] = "Ajouter au panier (Stock: %d)",
    ['Shop.HowManyAdd'] = "Combien voulez-vous ajouter? (Max: %d)",
    
    -- ============================================
    -- COOLDOWN SYSTEM
    -- ============================================
    ['Cooldown.Title'] = "Temps d'Attente",
    ['Cooldown.OnCooldown'] = "Vous devez attendre %s avant de faire des achats à nouveau.",
    ['Cooldown.LimitReached'] = "Limite d'Achat Atteinte",
    ['Cooldown.LimitReachedDesc'] = "Vous avez atteint votre limite d'achat de %d articles. Veuillez réessayer dans %d heures.",
    
    -- ============================================
    -- CHECKOUT / PAYMENT SYSTEM
    -- ============================================
    ['Checkout.Title'] = "Paiement",
    ['Checkout.PaymentProcessed'] = "Votre paiement a été traité et vous avez reçu vos articles!",
    ['Checkout.PaymentRequest'] = "Demande de Paiement",
    ['Checkout.PaymentRequestDesc'] = "Vous avez reçu une demande de paiement de %d$",
    ['Checkout.AcceptPayment'] = "Accepter et Payer",
    ['Checkout.AcceptPaymentDesc'] = "Compléter votre achat",
    ['Checkout.DeclinePayment'] = "Refuser le Paiement",
    ['Checkout.DeclinePaymentDesc'] = "Annuler la transaction",
    ['Checkout.ProcessPayment'] = "Traiter le Paiement",
    ['Checkout.UseRegister'] = "Veuillez utiliser la caisse pour traiter le paiement de %d$",
    ['Checkout.RequestedWait'] = "Vous avez demandé à payer. Veuillez attendre qu'un employé vous assiste.",
    ['Checkout.BasketEmpty'] = "Votre panier est vide!",
    ['Checkout.NoBasket'] = "Vous n'avez pas de panier!",
    ['Checkout.RequestAssistance'] = "%s demande de l'aide pour payer.",
    ['Checkout.SaleComplete'] = "Vente Terminée",
    ['Checkout.PurchaseComplete'] = "Achat Terminé",
    ['Checkout.YouPaid'] = "Vous avez payé %d$ pour vos articles.",
    ['Checkout.CustomerPaidBusiness'] = "Le client a payé %d$ sur le compte de l'entreprise.",
    ['Checkout.CustomerPaidDirect'] = "Le client vous a payé %d$ directement.",
    ['Checkout.PaymentFailed'] = "Paiement Échoué",
    ['Checkout.TransactionFailed'] = "La transaction n'a pas pu être complétée.",
    ['Checkout.CustomerPaymentFailed'] = "Le paiement du client a échoué.",
    ['Checkout.PurchaseCancelled'] = "Achat Annulé",
    ['Checkout.YouDeclined'] = "Vous avez refusé le paiement.",
    ['Checkout.CustomerDeclined'] = "Le client a refusé le paiement.",
    ['Checkout.PaymentMethod'] = "Méthode de Paiement",
    ['Checkout.Cash'] = "Espèces",
    ['Checkout.BankCard'] = "Carte Bancaire",
    ['Checkout.BankMoney'] = "argent sur votre compte bancaire",
    ['Checkout.Amount'] = "Montant",
    ['Checkout.From'] = "De",
    ['Checkout.AmountMismatch'] = "Montant Non Correspondant",
    ['Checkout.AmountMismatchDesc'] = "Le montant du paiement ne correspond pas au total du panier: %d$",
    ['Checkout.CustomerNotEnoughMoney'] = "Le client n'a pas assez de %s",
    ['Checkout.YouNotEnoughMoney'] = "Vous n'avez pas assez de %s",
    
    -- ============================================
    -- STOCK MANAGEMENT
    -- ============================================
    ['Stock.Management'] = "Gestion du Stock",
    ['Stock.ManageStock'] = "Gérer le stock de cette section",
    ['Stock.Location'] = "Emplacement",
    ['Stock.CurrentStock'] = "Stock Actuel",
    ['Stock.Stock'] = "Stock",
    ['Stock.AddStock'] = "Ajouter du Stock",
    ['Stock.RemoveStock'] = "Retirer du Stock",
    ['Stock.Restock'] = "Réapprovisionner",
    ['Stock.RestockDesc'] = "Combien voulez-vous ajouter au rayon?",
    ['Stock.OutOfStock'] = "Rupture de Stock",
    ['Stock.OutOfStockDesc'] = "Désolé, %s est en rupture de stock.",
    ['Stock.LowStock'] = "Stock Faible",
    ['Stock.NoPermission'] = "Vous n'avez pas la permission de gérer le stock.",
    ['Stock.Updated'] = "Stock Mis à Jour",
    ['Stock.AddedItems'] = "%d articles ajoutés. Nouveau stock: %d",
    ['Stock.RestockFailed'] = "Réapprovisionnement Échoué",
    ['Stock.NotEnoughInventory'] = "Vous n'avez pas assez de %s dans votre inventaire.",
    
    -- ============================================
    -- CUSTOMER BASKET (EMPLOYEE VIEW)
    -- ============================================
    ['CustomerBasket.Title'] = "Panier de %s",
    ['CustomerBasket.NoBasket'] = "Ce client n'a pas de panier.",
    ['CustomerBasket.Empty'] = "Le panier de ce client est vide.",
    ['CustomerBasket.Total'] = "Total",
    ['CustomerBasket.Each'] = "chacun",
    ['CustomerBasket.NoPermission'] = "Vous n'avez pas la permission de voir les paniers des clients.",
    
    -- ============================================
    -- REGISTER / CASH REGISTER
    -- ============================================
    ['Register.Title'] = "Caisse Enregistreuse",
    ['Register.NoPermission'] = "Vous n'avez pas la permission d'utiliser la caisse enregistreuse.",
    ['Register.NoItems'] = "Le client n'a pas d'articles à acheter.",
    ['Register.NoCustomers'] = "Pas de clients à proximité.",
    ['Register.SelectCustomer'] = "Sélectionner un Client",
    ['Register.InvalidAmount'] = "Montant invalide.",
    
    -- ============================================
    -- TARGET LABELS
    -- ============================================
    ['Target.GrabBasket'] = "Prendre un Panier",
    ['Target.PutAwayBasket'] = "Ranger le Panier",
    ['Target.ViewBasket'] = "Voir le Panier du Client",
    ['Target.Checkout'] = "Demander le Paiement",
    ['Target.CashRegister'] = "Utiliser la Caisse",
    ['Target.BossMenu'] = "Ouvrir le Menu du Patron",
    ['Target.ManageStock'] = "Gérer le Stock",
    ['Target.OpenStash'] = "Ouvrir %s",
    ['Target.OpenLocker'] = "Ouvrir le Vestiaire",
    ['Target.SitDown'] = "S'asseoir",
    ['Target.StandUp'] = "Se Lever",
    ['Target.Browse'] = "Parcourir %s",
    ['Target.UseAsClient'] = "Utiliser %s en tant que Client",
    ['Target.UseAsEmployee'] = "Utiliser %s en tant qu'Employé",
    
    -- ============================================
    -- STASH / STORAGE
    -- ============================================
    ['Stash.NoPermission'] = "Vous n'avez pas la permission d'accéder à ce stockage.",
    
    -- ============================================
    -- CLOTHING
    -- ============================================
    ['Clothing.Locker'] = "Vestiaire",
    ['Clothing.OpenMenu'] = "Ouvrir le Menu des Vêtements",
    
    -- ============================================
    -- JOB INFO
    -- ============================================
    ['Job.Title'] = "Info du Travail",
    ['Job.Status'] = "Statut du Travail",
    ['Job.Name'] = "Nom",
    ['Job.Grade'] = "Grade",
    ['Job.IsBoss'] = "Est Patron",
    ['Job.Duty'] = "Service",
    
    -- ============================================
    -- BOSS MENU
    -- ============================================
    ['Boss.Title'] = "Menu du Patron Beauté",
    ['Boss.SocietyBalance'] = "Solde de la Société",
    ['Boss.CurrentBalance'] = "Solde actuel: %s$",
    ['Boss.WithdrawMoney'] = "Retirer de l'Argent de la Société",
    ['Boss.DepositMoney'] = "Déposer de l'Argent",
    ['Boss.HireEmployee'] = "Embaucher un Employé",
    ['Boss.FireEmployee'] = "Licencier un Employé",
    ['Boss.EmployeeManagement'] = "Gestion des Employés",
    ['Boss.ViewBalance'] = "Voir le Solde de la Société",
    ['Boss.SetGrade'] = "Définir le Grade",
    ['Boss.HowMuchWithdraw'] = "Combien voulez-vous retirer?",
    ['Boss.HowMuchDeposit'] = "Combien voulez-vous déposer?",
    ['Boss.Amount'] = "Montant",
    ['Boss.NeedBeautyJob'] = "Vous devez travailler au salon de beauté pour utiliser cette commande.",
    ['Boss.NoPermission'] = "Vous n'avez pas la permission d'accéder au menu du patron beauté.",
    ['Boss.OnlyManagersHire'] = "Seuls les managers peuvent embaucher des employés",
    ['Boss.OnlyManagersFire'] = "Seuls les managers peuvent licencier des employés",
    ['Boss.OnlyManagersGrade'] = "Seuls les managers peuvent changer les grades des employés",
    ['Boss.NoPermissionWithdraw'] = "Vous n'avez pas la permission de retirer de l'argent.",
    ['Boss.NoPermissionDeposit'] = "Vous n'avez pas la permission de déposer de l'argent.",
    ['Boss.NoPermissionBalance'] = "Vous n'avez pas la permission de voir le solde de la société.",
    ['Boss.NoPermissionEmployees'] = "Vous n'avez pas la permission de voir la liste des employés.",
    ['Boss.Hired'] = "Embauché!",
    ['Boss.YouHaveBeenHired'] = "Vous avez été embauché au Salon de Beauté",
    ['Boss.EmployeeHiredSuccess'] = "Employé embauché avec succès",
    ['Boss.Fired'] = "Licencié",
    ['Boss.YouHaveBeenFired'] = "Vous avez été retiré du salon de beauté",
    ['Boss.EmployeeFiredSuccess'] = "L'employé a été licencié",
    ['Boss.GradeChanged'] = "Grade Modifié",
    ['Boss.YourGradeUpdated'] = "Votre grade a été mis à jour",
    ['Boss.GradeUpdatedTo'] = "Grade de l'employé mis à jour à %d",
    ['Boss.WithdrawalSuccessful'] = "Retrait Réussi",
    ['Boss.WithdrewAmount'] = "Vous avez retiré %s$ du compte de la société.",
    ['Boss.WithdrawalFailed'] = "Retrait Échoué",
    ['Boss.InsufficientFunds'] = "Fonds insuffisants dans le compte de la société.",
    ['Boss.DepositSuccessful'] = "Dépôt Réussi",
    ['Boss.DepositedAmount'] = "Vous avez déposé %s$ sur le compte de la société.",
    ['Boss.DepositFailed'] = "Dépôt Échoué",
    ['Boss.SocietyNotFound'] = "Compte de la société non trouvé.",
    ['Boss.NotEnoughMoney'] = "Vous n'avez pas assez d'argent.",
    
    -- ============================================
    -- HAIR STYLING
    -- ============================================
    ['Hair.Title'] = "Coiffure",
    ['Hair.StyledSuccess'] = "Cheveux coiffés avec succès!",
    ['Hair.StylistWorking'] = "Un coiffeur travaille sur vos cheveux",
    ['Hair.Cancelled'] = "Coiffure annulée",
    ['Hair.NoPermission'] = "Vous n'avez pas la permission de coiffer",
    ['Hair.AlreadyStyling'] = "Vous coiffez déjà quelqu'un",
    ['Hair.SitInChair'] = "S'asseoir sur la Chaise du Salon",
    ['Hair.StyleHair'] = "Coiffer les Cheveux",
    ['Hair.DoHair'] = "Faire les Cheveux",
    ['Hair.ClientLeft'] = "Le client a quitté le serveur",
    ['Hair.StylistLeft'] = "Le coiffeur a quitté le serveur",
    
    -- ============================================
    -- NAIL SERVICES
    -- ============================================
    ['Nails.Title'] = "Services d'Ongles",
    ['Nails.LashServices'] = "Services de Cils",
    ['Nails.ApplyStyles'] = "Appliquer les styles %s",
    ['Nails.ApplyingService'] = "Application du service...",
    ['Nails.GettingService'] = "Réception du service...",
    ['Nails.NailsComplete'] = "Vos ongles sont magnifiques!",
    ['Nails.NailServiceComplete'] = "Service d'ongles terminé!",
    ['Nails.LashesComplete'] = "Vos cils sont superbes!",
    ['Nails.LashServiceComplete'] = "Service de cils terminé!",
    ['Nails.TechWorking'] = "Une technicienne des ongles travaille sur vos ongles",
    ['Nails.LashExpertWorking'] = "Une experte en cils travaille sur vos cils",
    ['Nails.NoPermissionNails'] = "Vous devez être technicienne des ongles (Grade %d+) pour faire les ongles",
    ['Nails.NoPermissionLashes'] = "Vous devez être experte en cils (Grade %d+) pour faire les cils",
    ['Nails.SitInChair'] = "S'asseoir sur la Chaise de Manucure",
    ['Nails.DoNails'] = "Faire les Ongles",
    ['Nails.DoLashes'] = "Faire les Cils",
    ['Nails.ClientDisconnected'] = "Client déconnecté",
    ['Nails.TechDisconnected'] = "Technicien des ongles déconnecté",
    ['Nails.LashExpertDisconnected'] = "Expert en cils déconnecté",
    ['Nails.NailCancelledRestart'] = "Service de manucure annulé (redémarrage du serveur)",
    ['Nails.LashCancelledRestart'] = "Service de cils annulé (redémarrage du serveur)",
    ['Nails.NailCancelled'] = "Service de manucure annulé",
    ['Nails.LashCancelled'] = "Service de cils annulé",
    ['Nails.AppearanceSaved'] = "Apparence sauvegardée!",
    
    -- ============================================
    -- TRAP / STREET SELLING
    -- ============================================
    ['Trap.NotWoman'] = "Seules les femmes peuvent vendre des produits de beauté!",
    ['Trap.NoPolice'] = "Pas assez de policiers en ligne pour commencer à vendre.",
    ['Trap.NoProducts'] = "Vous n'avez pas de produits de beauté à vendre!",
    ['Trap.AlreadySelling'] = "Vous vendez déjà des produits!",
    ['Trap.WaitCustomer'] = "Recherche de clients... Restez à proximité!",
    ['Trap.CustomerApproaching'] = "Un client s'approche de vous!",
    ['Trap.CustomerWaiting'] = "Le client est prêt à acheter!",
    ['Trap.CustomerLeft'] = "Le client a perdu intérêt et est parti.",
    ['Trap.SellProduct'] = "Vendre un Produit de Beauté",
    ['Trap.SaleSuccess'] = "Vendu %dx %s pour %d$",
    ['Trap.SaleRejected'] = "Le client a refusé votre offre!",
    ['Trap.SaleFailed'] = "Vente échouée: %s",
    ['Trap.TooFar'] = "Vous vous êtes trop éloigné du client!",
    ['Trap.Robbed'] = "Le client a essayé de vous voler!",
    ['Trap.RobberyFailed'] = "Vous avez repoussé le voleur!",
    ['Trap.RobberGotAway'] = "Le voleur s'est échappé!",
    ['Trap.StoppedSelling'] = "Arrêt de la vente de produits de beauté.",
    ['Trap.InVehicle'] = "Vous ne pouvez pas vendre en étant dans un véhicule!",
    ['Trap.NotBeautyJob'] = "Vous devez travailler au salon de beauté pour vendre des produits!",
    ['Trap.Disabled'] = "Le système de vente de rue est actuellement désactivé",
    ['Trap.WaitingProductData'] = "En attente des données du produit...",
    ['Trap.NoItemAnymore'] = "Vous n'avez plus cet article!",
    
    -- ============================================
    -- NOTIFICATIONS (GENERAL)
    -- ============================================
    ['Notify.CheckoutRequest'] = "Demande de Paiement",
    ['Notify.CustomerNeedsAssistance'] = "Un client a besoin d'aide pour payer à %s!",
    
    -- ============================================
    -- TABLET SYSTEM
    -- ============================================
    ['Tablet.NoJob'] = "Vous devez être employé du salon de beauté pour utiliser ceci.",
    ['Tablet.Opened'] = "Tablette ouverte.",
    ['Tablet.Closed'] = "Tablette fermée.",
    
    -- Passing tablet
    ['Tablet.SelectCustomer'] = "Sélectionnez un client pour lui passer la tablette.",
    ['Tablet.NoNearbyPlayers'] = "Pas de clients à proximité.",
    ['Tablet.NoCustomerNearby'] = "Pas de client à proximité.",
    ['Tablet.PassTablet'] = "Passer la Tablette",
    ['Tablet.PassingTablet'] = "Passage de la tablette au client...",
    ['Tablet.TabletPassed'] = "Tablette passée. En attente de la réponse du client.",
    
    -- Customer prompts
    ['Tablet.OfferTitle'] = "Paiement du Salon de Beauté",
    ['Tablet.OfferDesc'] = "%s veut vous donner la tablette de paiement.",
    ['Tablet.Accept'] = "Accepter",
    ['Tablet.Decline'] = "Refuser",
    ['Tablet.DeclineReasonTitle'] = "Raison du Refus",
    ['Tablet.DeclineReasonDesc'] = "Pourquoi refusez-vous? (optionnel)",
    
    -- Customer received
    ['Tablet.Received'] = "Vérifiez vos services et complétez le paiement.",
    
    -- Decline handling
    ['Tablet.Declined'] = "Le client a refusé la tablette.",
    ['Tablet.DeclinedWithReason'] = "Le client a refusé: %s",
    ['Tablet.YouDeclined'] = "Vous avez refusé la tablette.",
    
    -- Payment
    ['Tablet.PaymentSuccessEmployee'] = "Paiement de %s$ reçu! (Pourboire: %s$)",
    ['Tablet.PaymentSuccessCustomer'] = "Vous avez payé %s$. Merci de votre visite au Salon de Beauté!",
    ['Tablet.NoMoneyCash'] = "Vous n'avez pas assez d'espèces.",
    ['Tablet.NoMoneyBank'] = "Vous n'avez pas assez sur votre compte bancaire.",
    ['Tablet.PaymentFailed'] = "Paiement échoué.",
    ['Tablet.TransactionExpired'] = "Transaction expirée.",
    
    -- Availability
    ['Tablet.AvailabilityTitle'] = "Définir la Disponibilité",
    ['Tablet.SetAvailable'] = "Se Rendre Disponible",
    ['Tablet.SetUnavailable'] = "Se Rendre Indisponible",
    ['Tablet.NowAvailable'] = "Vous êtes maintenant disponible pour les rendez-vous.",
    ['Tablet.NowUnavailable'] = "Vous êtes maintenant indisponible.",
    
    -- Management
    ['Tablet.PriceUpdated'] = "Prix de %s mis à jour à %s$.",
    ['Tablet.ShelfPriceUpdated'] = "Prix du rayon mis à jour à %s$.",
    ['Tablet.LimitUpdated'] = "Limite de facturation personnalisée définie à %s$.",
    ['Tablet.ChargeLimitUpdated'] = "Limite de facturation définie à %s$.",
    ['Tablet.NoPermission'] = "Vous n'avez pas la permission de faire cela.",
    
    -- Stats
    ['Tablet.StatsToday'] = "Ventes du Jour: %s$ (%d clients)",
    ['Tablet.StatsWeek'] = "Cette Semaine: %s$ (%d clients)",
    
    -- Finances
    ['Tablet.DepositSuccess'] = "Déposé %s$ à la société.",
    ['Tablet.WithdrawSuccess'] = "Retiré %s$ de la société.",
    ['Tablet.DepositFailed'] = "Échec du dépôt à la société.",
    ['Tablet.WithdrawFailed'] = "Fonds insuffisants dans le compte de la société.",
    ['Tablet.NotEnoughCash'] = "Vous n'avez pas assez d'espèces.",
    
    -- Employee Management
    ['Tablet.EmployeeHired'] = "%s embauché au Grade %d.",
    ['Tablet.YouWereHired'] = "Vous avez été embauché au Salon de Beauté!",
    ['Tablet.EmployeeFired'] = "Employé licencié.",
    ['Tablet.YouWereFired'] = "Vous avez été licencié du Salon de Beauté.",
    ['Tablet.GradeUpdated'] = "Grade de l'employé mis à jour.",
    ['Tablet.YourGradeUpdated'] = "Votre poste a été mis à jour!",
    ['Tablet.PlayerNotFound'] = "Joueur non trouvé.",
    
    -- Disconnection
    ['Tablet.EmployeeDisconnected'] = "L'employé s'est déconnecté.",
    ['Tablet.CustomerDisconnected'] = "Le client s'est déconnecté.",
    
    -- Customer accepted/declined
    ['Tablet.CustomerAccepted'] = "Le client a accepté la tablette.",

    -- Appointments (Full Booking System)
    ['Tablet.AvailabilitySaved'] = "Votre disponibilité a été enregistrée.",
    ['Tablet.NewAppointment'] = "Nouveau Rendez-vous",
    ['Tablet.AppointmentCancelledRefund'] = "Rendez-vous annulé - acompte remboursé.",
    ['Tablet.AppointmentCancelledNoRefund'] = "Rendez-vous annulé - pas de remboursement (trop tard).",
    ['Tablet.AppointmentReminder'] = "Rappel de Rendez-vous",
    ['Tablet.ReminderCustomer'] = "Rappel: Vous avez un rendez-vous dans %s minutes!",
    ['Tablet.ReminderEmployee'] = "%s a un rendez-vous dans %s minutes.",
    ['Tablet.NotEnoughForDeposit'] = "Pas assez d'argent pour l'acompte ($%s requis).",
    ['Tablet.BookingSuccess'] = "Rendez-vous réservé! Acompte de $%s payé.",
    ['Tablet.RefundGiven'] = "Votre acompte de $%s a été remboursé.",
    ['Tablet.BookAppointment'] = "Prendre Rendez-vous",
    ['Tablet.SelectEmployee'] = "Choisir un Styliste",
    ['Tablet.SelectDate'] = "Choisir une Date",
    ['Tablet.SelectTime'] = "Choisir une Heure",
    ['Tablet.ConfirmBooking'] = "Confirmer la Réservation",
    ['Tablet.DepositRequired'] = "Acompte: $%s",
    ['Tablet.NoEmployeesAvailable'] = "Aucun styliste disponible pour les réservations.",
    ['Tablet.NoDatesAvailable'] = "Aucune date disponible.",
    ['Tablet.NoTimesAvailable'] = "Aucun horaire disponible.",
    ['Tablet.MyBookings'] = "Mes Réservations",
    ['Tablet.ManageAvailability'] = "Gérer la Disponibilité",
}