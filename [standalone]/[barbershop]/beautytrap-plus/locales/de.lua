--[[
    ============================================
    GERMAN LOCALE - BEAUTYTRAP-PLUS
    COMPLETE VERSION - ALL FILES
    ============================================
]]--

Locales['de'] = {
    -- ============================================
    -- GENERAL
    -- ============================================
    ['General.AccessDenied'] = "Zugriff Verweigert",
    ['General.NoPermission'] = "Du hast keine Berechtigung, darauf zuzugreifen.",
    ['General.Error'] = "Fehler",
    ['General.Success'] = "Erfolg",
    ['General.Info'] = "Info",
    ['General.Cancel'] = "Abbrechen",
    ['General.Confirm'] = "Bestätigen",
    ['General.Back'] = "Zurück",
    ['General.Close'] = "Schließen",
    ['General.UnknownError'] = "Unbekannter Fehler",
    
    -- ============================================
    -- DUTY SYSTEM
    -- ============================================
    ['Duty.OnDuty'] = "Im Dienst",
    ['Duty.OffDuty'] = "Außer Dienst",
    ['Duty.NowOnDuty'] = "Du bist jetzt im Dienst als %s",
    ['Duty.NowOffDuty'] = "Du bist jetzt außer Dienst",
    ['Duty.ToggleDuty'] = "Dienst Wechseln",
    ['Duty.NoPermission'] = "Du hast keine Berechtigung, den Dienststatus zu ändern.",
    ['Duty.NoPermissionStation'] = "Du hast keine Berechtigung, diese Dienststation zu nutzen.",
    
    -- ============================================
    -- BASKET / SHOPPING SYSTEM
    -- ============================================
    ['Basket.Title'] = "Korb",
    ['Basket.GrabbedBasket'] = "Du hast einen Einkaufskorb genommen!",
    ['Basket.GrabbedGunCase'] = "Du hast einen Waffenkoffer genommen!",
    ['Basket.GrabbedShoppingBag'] = "Du hast eine Einkaufstasche genommen!",
    ['Basket.AlreadyHaveBasket'] = "Du hast bereits einen Korb!",
    ['Basket.NeedBasket'] = "Du musst zuerst einen Korb nehmen!",
    ['Basket.PutAway'] = "Du hast den Korb weggelegt.",
    ['Basket.NoBasketToPutAway'] = "Du hast keinen Korb zum Weglegen!",
    ['Basket.NoLongerHaveBasket'] = "Du hast keinen Korb mehr.",
    ['Basket.InvalidStoreData'] = "Ungültige Ladendaten!",
    ['Basket.StoreTypeNotExist'] = "Dieser Ladentyp existiert nicht!",
    ['Basket.ItemAdded'] = "%s zu deinem Korb hinzugefügt!",
    ['Basket.ItemRemoved'] = "%s aus dem Korb entfernt",
    ['Basket.BasketFull'] = "Korb Voll",
    ['Basket.BasketLimit'] = "Dein Korb kann nur %d Artikel aufnehmen.",
    ['Basket.BasketLimitFull'] = "Dein Korb kann nur %d Artikel aufnehmen. Du hast bereits %d Artikel.",
    ['Basket.Shoplifting'] = "Du wurdest beim Stehlen erwischt und hast alle Artikel fallen gelassen!",
    
    -- ============================================
    -- SHOP / ITEM BROWSING
    -- ============================================
    ['Shop.SelectItems'] = "Artikel Auswählen",
    ['Shop.SelectQuantity'] = "Menge Auswählen",
    ['Shop.Quantity'] = "Menge",
    ['Shop.Price'] = "Preis",
    ['Shop.InvalidQuantity'] = "Ungültige Menge!",
    ['Shop.AddToBasket'] = "Zum Korb hinzufügen (Bestand: %d)",
    ['Shop.HowManyAdd'] = "Wie viele möchtest du hinzufügen? (Max: %d)",
    
    -- ============================================
    -- COOLDOWN SYSTEM
    -- ============================================
    ['Cooldown.Title'] = "Wartezeit",
    ['Cooldown.OnCooldown'] = "Du musst %s warten, bevor du wieder einkaufen kannst.",
    ['Cooldown.LimitReached'] = "Kauflimit Erreicht",
    ['Cooldown.LimitReachedDesc'] = "Du hast dein Kauflimit von %d Artikeln erreicht. Bitte versuche es in %d Stunden erneut.",
    
    -- ============================================
    -- CHECKOUT / PAYMENT SYSTEM
    -- ============================================
    ['Checkout.Title'] = "Kasse",
    ['Checkout.PaymentProcessed'] = "Deine Zahlung wurde verarbeitet und du hast deine Artikel erhalten!",
    ['Checkout.PaymentRequest'] = "Zahlungsanfrage",
    ['Checkout.PaymentRequestDesc'] = "Du hast eine Zahlungsanfrage über %d$ erhalten",
    ['Checkout.AcceptPayment'] = "Akzeptieren und Bezahlen",
    ['Checkout.AcceptPaymentDesc'] = "Deinen Einkauf abschließen",
    ['Checkout.DeclinePayment'] = "Zahlung Ablehnen",
    ['Checkout.DeclinePaymentDesc'] = "Die Transaktion abbrechen",
    ['Checkout.ProcessPayment'] = "Zahlung Verarbeiten",
    ['Checkout.UseRegister'] = "Bitte benutze die Kasse, um die Zahlung von %d$ zu verarbeiten",
    ['Checkout.RequestedWait'] = "Du hast bezahlen angefragt. Bitte warte, bis ein Mitarbeiter dir hilft.",
    ['Checkout.BasketEmpty'] = "Dein Korb ist leer!",
    ['Checkout.NoBasket'] = "Du hast keinen Korb!",
    ['Checkout.RequestAssistance'] = "%s bittet um Hilfe beim Bezahlen.",
    ['Checkout.SaleComplete'] = "Verkauf Abgeschlossen",
    ['Checkout.PurchaseComplete'] = "Einkauf Abgeschlossen",
    ['Checkout.YouPaid'] = "Du hast %d$ für deine Artikel bezahlt.",
    ['Checkout.CustomerPaidBusiness'] = "Der Kunde hat %d$ auf das Geschäftskonto gezahlt.",
    ['Checkout.CustomerPaidDirect'] = "Der Kunde hat dir %d$ direkt gezahlt.",
    ['Checkout.PaymentFailed'] = "Zahlung Fehlgeschlagen",
    ['Checkout.TransactionFailed'] = "Die Transaktion konnte nicht abgeschlossen werden.",
    ['Checkout.CustomerPaymentFailed'] = "Die Zahlung des Kunden ist fehlgeschlagen.",
    ['Checkout.PurchaseCancelled'] = "Einkauf Abgebrochen",
    ['Checkout.YouDeclined'] = "Du hast die Zahlung abgelehnt.",
    ['Checkout.CustomerDeclined'] = "Der Kunde hat die Zahlung abgelehnt.",
    ['Checkout.PaymentMethod'] = "Zahlungsmethode",
    ['Checkout.Cash'] = "Bargeld",
    ['Checkout.BankCard'] = "Bankkarte",
    ['Checkout.BankMoney'] = "Geld auf deinem Bankkonto",
    ['Checkout.Amount'] = "Betrag",
    ['Checkout.From'] = "Von",
    ['Checkout.AmountMismatch'] = "Betrag Stimmt Nicht Überein",
    ['Checkout.AmountMismatchDesc'] = "Der Zahlungsbetrag stimmt nicht mit dem Korbgesamt überein: %d$",
    ['Checkout.CustomerNotEnoughMoney'] = "Der Kunde hat nicht genug %s",
    ['Checkout.YouNotEnoughMoney'] = "Du hast nicht genug %s",
    
    -- ============================================
    -- STOCK MANAGEMENT
    -- ============================================
    ['Stock.Management'] = "Bestandsverwaltung",
    ['Stock.ManageStock'] = "Bestand für diesen Bereich verwalten",
    ['Stock.Location'] = "Standort",
    ['Stock.CurrentStock'] = "Aktueller Bestand",
    ['Stock.Stock'] = "Bestand",
    ['Stock.AddStock'] = "Bestand Hinzufügen",
    ['Stock.RemoveStock'] = "Bestand Entfernen",
    ['Stock.Restock'] = "Nachfüllen",
    ['Stock.RestockDesc'] = "Wie viele möchtest du ins Regal hinzufügen?",
    ['Stock.OutOfStock'] = "Nicht Vorrätig",
    ['Stock.OutOfStockDesc'] = "Entschuldigung, %s ist nicht mehr vorrätig.",
    ['Stock.LowStock'] = "Niedriger Bestand",
    ['Stock.NoPermission'] = "Du hast keine Berechtigung, den Bestand zu verwalten.",
    ['Stock.Updated'] = "Bestand Aktualisiert",
    ['Stock.AddedItems'] = "%d Artikel hinzugefügt. Neuer Bestand: %d",
    ['Stock.RestockFailed'] = "Nachfüllen Fehlgeschlagen",
    ['Stock.NotEnoughInventory'] = "Du hast nicht genug %s in deinem Inventar.",
    
    -- ============================================
    -- CUSTOMER BASKET (EMPLOYEE VIEW)
    -- ============================================
    ['CustomerBasket.Title'] = "%s's Korb",
    ['CustomerBasket.NoBasket'] = "Dieser Kunde hat keinen Korb.",
    ['CustomerBasket.Empty'] = "Der Korb dieses Kunden ist leer.",
    ['CustomerBasket.Total'] = "Gesamt",
    ['CustomerBasket.Each'] = "pro Stück",
    ['CustomerBasket.NoPermission'] = "Du hast keine Berechtigung, Kundenkörbe anzusehen.",
    
    -- ============================================
    -- REGISTER / CASH REGISTER
    -- ============================================
    ['Register.Title'] = "Kasse",
    ['Register.NoPermission'] = "Du hast keine Berechtigung, die Kasse zu benutzen.",
    ['Register.NoItems'] = "Der Kunde hat keine Artikel zu kaufen.",
    ['Register.NoCustomers'] = "Keine Kunden in der Nähe.",
    ['Register.SelectCustomer'] = "Kunden Auswählen",
    ['Register.InvalidAmount'] = "Ungültiger Betrag.",
    
    -- ============================================
    -- TARGET LABELS
    -- ============================================
    ['Target.GrabBasket'] = "Korb Nehmen",
    ['Target.PutAwayBasket'] = "Korb Weglegen",
    ['Target.ViewBasket'] = "Kundenkorb Ansehen",
    ['Target.Checkout'] = "Bezahlen Anfragen",
    ['Target.CashRegister'] = "Kasse Benutzen",
    ['Target.BossMenu'] = "Chef-Menü Öffnen",
    ['Target.ManageStock'] = "Bestand Verwalten",
    ['Target.OpenStash'] = "%s Öffnen",
    ['Target.OpenLocker'] = "Kleiderspind Öffnen",
    ['Target.SitDown'] = "Hinsetzen",
    ['Target.StandUp'] = "Aufstehen",
    ['Target.Browse'] = "%s Durchsuchen",
    ['Target.UseAsClient'] = "%s als Kunde Nutzen",
    ['Target.UseAsEmployee'] = "%s als Mitarbeiter Nutzen",
    
    -- ============================================
    -- STASH / STORAGE
    -- ============================================
    ['Stash.NoPermission'] = "Du hast keine Berechtigung, auf dieses Lager zuzugreifen.",
    
    -- ============================================
    -- CLOTHING
    -- ============================================
    ['Clothing.Locker'] = "Kleiderspind",
    ['Clothing.OpenMenu'] = "Kleidungsmenü Öffnen",
    
    -- ============================================
    -- JOB INFO
    -- ============================================
    ['Job.Title'] = "Job-Info",
    ['Job.Status'] = "Job-Status",
    ['Job.Name'] = "Name",
    ['Job.Grade'] = "Stufe",
    ['Job.IsBoss'] = "Ist Chef",
    ['Job.Duty'] = "Dienst",
    
    -- ============================================
    -- BOSS MENU
    -- ============================================
    ['Boss.Title'] = "Beauty Chef-Menü",
    ['Boss.SocietyBalance'] = "Gesellschaftsguthaben",
    ['Boss.CurrentBalance'] = "Aktuelles Guthaben: %s$",
    ['Boss.WithdrawMoney'] = "Gesellschaftsgeld Abheben",
    ['Boss.DepositMoney'] = "Geld Einzahlen",
    ['Boss.HireEmployee'] = "Mitarbeiter Einstellen",
    ['Boss.FireEmployee'] = "Mitarbeiter Entlassen",
    ['Boss.EmployeeManagement'] = "Mitarbeiterverwaltung",
    ['Boss.ViewBalance'] = "Gesellschaftsguthaben Ansehen",
    ['Boss.SetGrade'] = "Stufe Festlegen",
    ['Boss.HowMuchWithdraw'] = "Wie viel möchtest du abheben?",
    ['Boss.HowMuchDeposit'] = "Wie viel möchtest du einzahlen?",
    ['Boss.Amount'] = "Betrag",
    ['Boss.NeedBeautyJob'] = "Du musst im Schönheitssalon arbeiten, um diesen Befehl zu verwenden.",
    ['Boss.NoPermission'] = "Du hast keine Berechtigung, auf das Beauty Chef-Menü zuzugreifen.",
    ['Boss.OnlyManagersHire'] = "Nur Manager können Mitarbeiter einstellen",
    ['Boss.OnlyManagersFire'] = "Nur Manager können Mitarbeiter entlassen",
    ['Boss.OnlyManagersGrade'] = "Nur Manager können Mitarbeiterstufen ändern",
    ['Boss.NoPermissionWithdraw'] = "Du hast keine Berechtigung, Geld abzuheben.",
    ['Boss.NoPermissionDeposit'] = "Du hast keine Berechtigung, Geld einzuzahlen.",
    ['Boss.NoPermissionBalance'] = "Du hast keine Berechtigung, das Gesellschaftsguthaben anzusehen.",
    ['Boss.NoPermissionEmployees'] = "Du hast keine Berechtigung, die Mitarbeiterliste anzusehen.",
    ['Boss.Hired'] = "Eingestellt!",
    ['Boss.YouHaveBeenHired'] = "Du wurdest im Schönheitssalon eingestellt",
    ['Boss.EmployeeHiredSuccess'] = "Mitarbeiter erfolgreich eingestellt",
    ['Boss.Fired'] = "Entlassen",
    ['Boss.YouHaveBeenFired'] = "Du wurdest aus dem Schönheitssalon entfernt",
    ['Boss.EmployeeFiredSuccess'] = "Der Mitarbeiter wurde entlassen",
    ['Boss.GradeChanged'] = "Stufe Geändert",
    ['Boss.YourGradeUpdated'] = "Deine Stufe wurde aktualisiert",
    ['Boss.GradeUpdatedTo'] = "Mitarbeiterstufe auf %d aktualisiert",
    ['Boss.WithdrawalSuccessful'] = "Abhebung Erfolgreich",
    ['Boss.WithdrewAmount'] = "Du hast %s$ vom Gesellschaftskonto abgehoben.",
    ['Boss.WithdrawalFailed'] = "Abhebung Fehlgeschlagen",
    ['Boss.InsufficientFunds'] = "Unzureichende Mittel auf dem Gesellschaftskonto.",
    ['Boss.DepositSuccessful'] = "Einzahlung Erfolgreich",
    ['Boss.DepositedAmount'] = "Du hast %s$ auf das Gesellschaftskonto eingezahlt.",
    ['Boss.DepositFailed'] = "Einzahlung Fehlgeschlagen",
    ['Boss.SocietyNotFound'] = "Gesellschaftskonto nicht gefunden.",
    ['Boss.NotEnoughMoney'] = "Du hast nicht genug Geld.",
    
    -- ============================================
    -- HAIR STYLING
    -- ============================================
    ['Hair.Title'] = "Frisur",
    ['Hair.StyledSuccess'] = "Haare erfolgreich gestylt!",
    ['Hair.StylistWorking'] = "Ein Friseur arbeitet an deinen Haaren",
    ['Hair.Cancelled'] = "Frisur abgebrochen",
    ['Hair.NoPermission'] = "Du hast keine Berechtigung, Haare zu stylen",
    ['Hair.AlreadyStyling'] = "Du stylst bereits jemandes Haare",
    ['Hair.SitInChair'] = "Auf Salonstuhl Setzen",
    ['Hair.StyleHair'] = "Haare Stylen",
    ['Hair.DoHair'] = "Haare Machen",
    ['Hair.ClientLeft'] = "Der Kunde hat den Server verlassen",
    ['Hair.StylistLeft'] = "Der Friseur hat den Server verlassen",
    
    -- ============================================
    -- NAIL SERVICES
    -- ============================================
    ['Nails.Title'] = "Nagelservice",
    ['Nails.LashServices'] = "Wimpernservice",
    ['Nails.ApplyStyles'] = "%s-Stile anwenden",
    ['Nails.ApplyingService'] = "Service wird angewendet...",
    ['Nails.GettingService'] = "Service wird durchgeführt...",
    ['Nails.NailsComplete'] = "Deine Nägel sehen fantastisch aus!",
    ['Nails.NailServiceComplete'] = "Nagelservice abgeschlossen!",
    ['Nails.LashesComplete'] = "Deine Wimpern sehen wunderschön aus!",
    ['Nails.LashServiceComplete'] = "Wimpernservice abgeschlossen!",
    ['Nails.TechWorking'] = "Eine Nageltechnikerin arbeitet an deinen Nägeln",
    ['Nails.LashExpertWorking'] = "Eine Wimpernexpertin arbeitet an deinen Wimpern",
    ['Nails.NoPermissionNails'] = "Du musst Nageltechnikerin (Stufe %d+) sein, um Nägel zu machen",
    ['Nails.NoPermissionLashes'] = "Du musst Wimpernexpertin (Stufe %d+) sein, um Wimpern zu machen",
    ['Nails.SitInChair'] = "Auf Nagelstuhl Setzen",
    ['Nails.DoNails'] = "Nägel Machen",
    ['Nails.DoLashes'] = "Wimpern Machen",
    ['Nails.ClientDisconnected'] = "Kunde getrennt",
    ['Nails.TechDisconnected'] = "Nageltechniker getrennt",
    ['Nails.LashExpertDisconnected'] = "Wimpernexperte getrennt",
    ['Nails.NailCancelledRestart'] = "Nagelservice abgebrochen (Server-Neustart)",
    ['Nails.LashCancelledRestart'] = "Wimpernservice abgebrochen (Server-Neustart)",
    ['Nails.NailCancelled'] = "Nagelservice abgebrochen",
    ['Nails.LashCancelled'] = "Wimpernservice abgebrochen",
    ['Nails.AppearanceSaved'] = "Aussehen gespeichert!",
    
    -- ============================================
    -- TRAP / STREET SELLING
    -- ============================================
    ['Trap.NotWoman'] = "Nur Frauen können Schönheitsprodukte verkaufen!",
    ['Trap.NoPolice'] = "Nicht genug Polizisten online, um mit dem Verkauf zu beginnen.",
    ['Trap.NoProducts'] = "Du hast keine Schönheitsprodukte zum Verkaufen!",
    ['Trap.AlreadySelling'] = "Du verkaufst bereits Produkte!",
    ['Trap.WaitCustomer'] = "Suche nach Kunden... Bleib in der Nähe!",
    ['Trap.CustomerApproaching'] = "Ein Kunde nähert sich dir!",
    ['Trap.CustomerWaiting'] = "Der Kunde ist bereit zu kaufen!",
    ['Trap.CustomerLeft'] = "Der Kunde hat das Interesse verloren und ist gegangen.",
    ['Trap.SellProduct'] = "Schönheitsprodukt Verkaufen",
    ['Trap.SaleSuccess'] = "%dx %s für %d$ verkauft",
    ['Trap.SaleRejected'] = "Der Kunde hat dein Angebot abgelehnt!",
    ['Trap.SaleFailed'] = "Verkauf fehlgeschlagen: %s",
    ['Trap.TooFar'] = "Du bist zu weit vom Kunden weggegangen!",
    ['Trap.Robbed'] = "Der Kunde hat versucht, dich auszurauben!",
    ['Trap.RobberyFailed'] = "Du hast den Räuber abgewehrt!",
    ['Trap.RobberGotAway'] = "Der Räuber ist entkommen!",
    ['Trap.StoppedSelling'] = "Verkauf von Schönheitsprodukten beendet.",
    ['Trap.InVehicle'] = "Du kannst nicht verkaufen, während du in einem Fahrzeug bist!",
    ['Trap.NotBeautyJob'] = "Du musst im Schönheitssalon arbeiten, um Produkte zu verkaufen!",
    ['Trap.Disabled'] = "Das Straßenverkaufssystem ist derzeit deaktiviert",
    ['Trap.WaitingProductData'] = "Warte auf Produktdaten...",
    ['Trap.NoItemAnymore'] = "Du hast diesen Artikel nicht mehr!",
    
    -- ============================================
    -- NOTIFICATIONS (GENERAL)
    -- ============================================
    ['Notify.CheckoutRequest'] = "Kassenanfrage",
    ['Notify.CustomerNeedsAssistance'] = "Ein Kunde braucht Hilfe beim Bezahlen bei %s!",
    
    -- ============================================
    -- TABLET SYSTEM
    -- ============================================
    ['Tablet.NoJob'] = "Du musst Mitarbeiter im Schönheitssalon sein, um das zu nutzen.",
    ['Tablet.Opened'] = "Tablet geöffnet.",
    ['Tablet.Closed'] = "Tablet geschlossen.",
    
    -- Passing tablet
    ['Tablet.SelectCustomer'] = "Wähle einen Kunden aus, dem du das Tablet geben möchtest.",
    ['Tablet.NoNearbyPlayers'] = "Keine Kunden in der Nähe.",
    ['Tablet.NoCustomerNearby'] = "Kein Kunde in der Nähe.",
    ['Tablet.PassTablet'] = "Tablet Übergeben",
    ['Tablet.PassingTablet'] = "Tablet wird an Kunden übergeben...",
    ['Tablet.TabletPassed'] = "Tablet übergeben. Warte auf Kundenantwort.",
    
    -- Customer prompts
    ['Tablet.OfferTitle'] = "Schönheitssalon Zahlung",
    ['Tablet.OfferDesc'] = "%s möchte dir das Zahlungs-Tablet geben.",
    ['Tablet.Accept'] = "Akzeptieren",
    ['Tablet.Decline'] = "Ablehnen",
    ['Tablet.DeclineReasonTitle'] = "Ablehnungsgrund",
    ['Tablet.DeclineReasonDesc'] = "Warum lehnst du ab? (optional)",
    
    -- Customer received
    ['Tablet.Received'] = "Überprüfe deine Dienstleistungen und schließe die Zahlung ab.",
    
    -- Decline handling
    ['Tablet.Declined'] = "Kunde hat das Tablet abgelehnt.",
    ['Tablet.DeclinedWithReason'] = "Kunde hat abgelehnt: %s",
    ['Tablet.YouDeclined'] = "Du hast das Tablet abgelehnt.",
    
    -- Payment
    ['Tablet.PaymentSuccessEmployee'] = "Zahlung von %s$ erhalten! (Trinkgeld: %s$)",
    ['Tablet.PaymentSuccessCustomer'] = "Du hast %s$ bezahlt. Danke für deinen Besuch im Schönheitssalon!",
    ['Tablet.NoMoneyCash'] = "Du hast nicht genug Bargeld.",
    ['Tablet.NoMoneyBank'] = "Du hast nicht genug auf deinem Bankkonto.",
    ['Tablet.PaymentFailed'] = "Zahlung fehlgeschlagen.",
    ['Tablet.TransactionExpired'] = "Transaktion abgelaufen.",
    
    -- Availability
    ['Tablet.AvailabilityTitle'] = "Verfügbarkeit Einstellen",
    ['Tablet.SetAvailable'] = "Verfügbar Setzen",
    ['Tablet.SetUnavailable'] = "Nicht Verfügbar Setzen",
    ['Tablet.NowAvailable'] = "Du bist jetzt für Termine verfügbar.",
    ['Tablet.NowUnavailable'] = "Du bist jetzt nicht verfügbar.",
    
    -- Management
    ['Tablet.PriceUpdated'] = "Preis für %s auf %s$ aktualisiert.",
    ['Tablet.ShelfPriceUpdated'] = "Regalpreis auf %s$ aktualisiert.",
    ['Tablet.LimitUpdated'] = "Benutzerdefiniertes Gebührenlimit auf %s$ gesetzt.",
    ['Tablet.ChargeLimitUpdated'] = "Gebührenlimit auf %s$ gesetzt.",
    ['Tablet.NoPermission'] = "Du hast keine Berechtigung dafür.",
    
    -- Stats
    ['Tablet.StatsToday'] = "Heutige Verkäufe: %s$ (%d Kunden)",
    ['Tablet.StatsWeek'] = "Diese Woche: %s$ (%d Kunden)",
    
    -- Finances
    ['Tablet.DepositSuccess'] = "%s$ zur Gesellschaft eingezahlt.",
    ['Tablet.WithdrawSuccess'] = "%s$ von der Gesellschaft abgehoben.",
    ['Tablet.DepositFailed'] = "Einzahlung zur Gesellschaft fehlgeschlagen.",
    ['Tablet.WithdrawFailed'] = "Unzureichende Mittel auf dem Gesellschaftskonto.",
    ['Tablet.NotEnoughCash'] = "Du hast nicht genug Bargeld.",
    
    -- Employee Management
    ['Tablet.EmployeeHired'] = "%s als Stufe %d eingestellt.",
    ['Tablet.YouWereHired'] = "Du wurdest im Schönheitssalon eingestellt!",
    ['Tablet.EmployeeFired'] = "Mitarbeiter wurde entlassen.",
    ['Tablet.YouWereFired'] = "Du wurdest aus dem Schönheitssalon entlassen.",
    ['Tablet.GradeUpdated'] = "Mitarbeiterstufe aktualisiert.",
    ['Tablet.YourGradeUpdated'] = "Deine Position wurde aktualisiert!",
    ['Tablet.PlayerNotFound'] = "Spieler nicht gefunden.",
    
    -- Disconnection
    ['Tablet.EmployeeDisconnected'] = "Der Mitarbeiter hat die Verbindung getrennt.",
    ['Tablet.CustomerDisconnected'] = "Der Kunde hat die Verbindung getrennt.",
    
    -- Customer accepted/declined
    ['Tablet.CustomerAccepted'] = "Kunde hat das Tablet akzeptiert.",

    -- Appointments (Full Booking System)
    ['Tablet.AvailabilitySaved'] = "Ihre Verfügbarkeit wurde gespeichert.",
    ['Tablet.NewAppointment'] = "Neuer Termin",
    ['Tablet.AppointmentCancelledRefund'] = "Termin storniert - Anzahlung erstattet.",
    ['Tablet.AppointmentCancelledNoRefund'] = "Termin storniert - keine Erstattung (zu spät).",
    ['Tablet.AppointmentReminder'] = "Terminerinnerung",
    ['Tablet.ReminderCustomer'] = "Erinnerung: Sie haben einen Termin in %s Minuten!",
    ['Tablet.ReminderEmployee'] = "%s hat einen Termin in %s Minuten.",
    ['Tablet.NotEnoughForDeposit'] = "Nicht genug Geld für die Anzahlung ($%s erforderlich).",
    ['Tablet.BookingSuccess'] = "Termin gebucht! Anzahlung von $%s bezahlt.",
    ['Tablet.RefundGiven'] = "Ihre Anzahlung von $%s wurde erstattet.",
    ['Tablet.BookAppointment'] = "Termin buchen",
    ['Tablet.SelectEmployee'] = "Stylist auswählen",
    ['Tablet.SelectDate'] = "Datum auswählen",
    ['Tablet.SelectTime'] = "Uhrzeit auswählen",
    ['Tablet.ConfirmBooking'] = "Buchung bestätigen",
    ['Tablet.DepositRequired'] = "Anzahlung: $%s",
    ['Tablet.NoEmployeesAvailable'] = "Keine Stylisten für Buchungen verfügbar.",
    ['Tablet.NoDatesAvailable'] = "Keine Termine verfügbar.",
    ['Tablet.NoTimesAvailable'] = "Keine Zeiten verfügbar.",
    ['Tablet.MyBookings'] = "Meine Buchungen",
    ['Tablet.ManageAvailability'] = "Verfügbarkeit verwalten",
}