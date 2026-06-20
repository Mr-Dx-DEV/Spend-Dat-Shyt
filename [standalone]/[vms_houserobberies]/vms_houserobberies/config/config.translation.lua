-- ▀█▀ █▀▄ ▄▀▄ █▄ █ ▄▀▀ █   ▄▀▄ ▀█▀ ██▀
--  █  █▀▄ █▀█ █ ▀█ ▄██ █▄▄ █▀█  █  █▄▄
Config.Language = 'EN' -- 'EN' / 'CZ' / 'DE' / 'FR' / 'ES' / 'PT' / 'PL' / 'IT'

Config.Translate = {
    ['EN'] = {
        ['moneytype.cash'] = 'cash',
        ['moneytype.bank'] = 'bank',
        ['moneytype.black_money'] = 'dirty cash',

        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Talk with fence",
        ['3dtext.talk_with_fence'] = "[E] Talk with fence",
        ['target.talk_with_fence'] = "Talk with fence",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Pawnshop",
        ['3dtext.talk_with_pawnshop'] = "[E] Pawnshop",
        ['target.talk_with_pawnshop'] = "[E] Pawnshop",

        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Robbery Organiser",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Robbery Organiser",
        ['target.talk_with_robbery_organiser'] = "Robbery Organiser",

        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Turn off the electricity",
        ['3dtext.turn_off_the_electricity'] = "[E] Turn off the electricity",
        ['target.turn_off_the_electricity'] = "Turn off the electricity",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Enter to the house",
        ['3dtext.enter_house'] = "[E] Enter to the house",
        ['target.enter_house'] = "Enter to the house",

        ['help.exit_house'] = "~INPUT_CONTEXT~ Exit from the house",
        ['3dtext.exit_house'] = "[E] Exit from the house",
        ['target.exit_house'] = "Exit from the house",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Take %s",
        ['3dtext.take_loot'] = "[E] Take %s",
        ['target.take_loot'] = "Take %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Search",
        ['3dtext.search_cabinet'] = "[E] Search",
        ['target.search_cabinet'] = "Search",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Crack the safe",
        ['3dtext.open_safe'] = "[E] Crack the safe",
        ['target.open_safe'] = "Crack the safe",

        ['progressbar.searching_loot'] = "Searching...",
        ['progressbar.taking_loot'] = "Taking %s...",

        ['notify.stopped_robbery'] = "You have completed the robbery!",
        ['notify.stopped_robbery_paid'] = "You have completed the robbery for $%s!",

        ['notify.not_enough_police'] = "There are not enough police officers on duty.",
        ['notify.your_job_is_blacklisted'] = "You can't do illegal things in your profession!",
        ['notify.you_dont_have_money'] = "You don't have enough money!",

        ['notify.wait'] = "Try again in a while...",

        ['notify.turned_off_the_electricity'] = "You turned off the electricity at house.",

        ['notify.dont_have_lockpick'] = "You don't have the %s...",
        ['notify.you_failed_break_in'] = "You failed to break in...",
        ['notify.you_failed_turning_off_electricity'] = "You failed to turning off electricity...",

        ['notify.you_already_started_robbery'] = "You can't start another robbery, you've already started one.",
        ['notify.you_cannot_start_robbery'] = "You can't currently start this robbery, it will be available in %s minutes.",
        ['notify.started_robbery'] = 'A robbery has been started in %s district at %s address.',

        ['notify.you_stole_item'] = "You stole %s",
        ['notify.you_stole_money'] = "You stole %s %s$",
        ['notify.cabinet_was_empty'] = "The cabinet was empty!",
        ['notify.safe_was_empty'] = "The safe was empty!",

        ['notify.dont_have_item'] = "You do not have the item you are trying to sell...",
        ['notify.successful_sale'] = "You sold %s of %sx for %s$.",
        ['notify.failed_sale'] = "You failed to push the stolen %s in the amount of %sx in the pawn shop, the employee notified the police.",

        ['notify.configurator:detailed_configuration'] = "You have started a detailed position configuration...",
        ['notify.configurator:press_copy_data'] = "You have completed configuration, now press the button below to copy the configured values.",
        ['notify.configurator:copied_data'] = "Copied the data, use CTRL+V in the configuration file to place the configured option.",

        ['blip.dispatch:failed_sale'] = "Sales attempt",
        ['message.dispatch:failed_sale'] = "A thief tried to sell %s of %sx at a pawn shop, the items are stolen.",

        ['blip.dispatch:failed_lockpick'] = "Failed Burglary",
        ['message.dispatch:failed_lockpick'] = "Unsuccessful attempt to break into house at %s has been marked on the GPS.<br>Go there and stop the burglar!",

        ['blip.dispatch:thief_spotted'] = "Thief's spotted",
        ['message.dispatch:thief_spotted'] = "Tenant in his %s apartment spotted thieves, house was marked on GPS.<br>Go there quickly to thwart the crime!"
    },
    ['IT'] = {
        ['moneytype.cash'] = 'contanti',
        ['moneytype.bank'] = 'banca',
        ['moneytype.black_money'] = 'denaro sporco',

        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Parla con il ricettatore",
        ['3dtext.talk_with_fence'] = "[E] Parla con il ricettatore",
        ['target.talk_with_fence'] = "Parla con il ricettatore",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Banco dei Pegni",
        ['3dtext.talk_with_pawnshop'] = "[E] Banco dei Pegni",
        ['target.talk_with_pawnshop'] = "Banco dei Pegni",

        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Organizzatore di Rapine",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Organizzatore di Rapine",
        ['target.talk_with_robbery_organiser'] = "Organizzatore di Rapine",

        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Spegni l'elettricità",
        ['3dtext.turn_off_the_electricity'] = "[E] Spegni l'elettricità",
        ['target.turn_off_the_electricity'] = "Spegni l'elettricità",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Entra nella casa",
        ['3dtext.enter_house'] = "[E] Entra nella casa",
        ['target.enter_house'] = "Entra nella casa",

        ['help.exit_house'] = "~INPUT_CONTEXT~ Esci dalla casa",
        ['3dtext.exit_house'] = "[E] Esci dalla casa",
        ['target.exit_house'] = "Esci dalla casa",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Prendi %s",
        ['3dtext.take_loot'] = "[E] Prendi %s",
        ['target.take_loot'] = "Prendi %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Cerca",
        ['3dtext.search_cabinet'] = "[E] Cerca",
        ['target.search_cabinet'] = "Cerca",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Scassina la cassaforte",
        ['3dtext.open_safe'] = "[E] Scassina la cassaforte",
        ['target.open_safe'] = "Scassina la cassaforte",

        ['progressbar.searching_loot'] = "Cercando...",
        ['progressbar.taking_loot'] = "Prendendo %s...",

        ['notify.not_enough_police'] = "Non ci sono abbastanza agenti di polizia in servizio.",
        ['notify.your_job_is_blacklisted'] = "Non puoi fare cose illegali nella tua professione!",
        ['notify.you_dont_have_money'] = "Non hai abbastanza soldi!",

        ['notify.wait'] = "Try again in a while...",

        ['notify.turned_off_the_electricity'] = "Hai spento l'elettricità nella casa.",

        ['notify.dont_have_lockpick'] = "Non hai il %s...",
        ['notify.you_failed_break_in'] = "Hai fallito l'effrazione...",
        ['notify.you_failed_turning_off_electricity'] = "Hai fallito a spegnere l'elettricità...",

        ['notify.you_already_started_robbery'] = "Non puoi iniziare un'altra rapina, ne hai già iniziata una.",
        ['notify.you_cannot_start_robbery'] = "Non puoi iniziare questa rapina in questo momento, sarà disponibile tra %s minuti.",
        ['notify.started_robbery'] = 'Una rapina è stata iniziata nel distretto di %s all\'indirizzo %s.',

        ['notify.you_stole_item'] = "Hai rubato %s",
        ['notify.you_stole_money'] = "Hai rubato %s %s€",
        ['notify.cabinet_was_empty'] = "L'armadietto era vuoto!",
        ['notify.safe_was_empty'] = "La cassaforte era vuota!",

        ['notify.dont_have_item'] = "Non hai l'oggetto che stai cercando di vendere...",
        ['notify.successful_sale'] = "Hai venduto %s di %sx per %s€.",
        ['notify.failed_sale'] = "Non sei riuscito a vendere %s in quantità di %sx al banco dei pegni, il dipendente ha avvisato la polizia.",

        ['notify.configurator:detailed_configuration'] = "Hai iniziato una configurazione dettagliata della posizione...",
        ['notify.configurator:press_copy_data'] = "Hai completato la configurazione, ora premi il pulsante qui sotto per copiare i valori configurati.",
        ['notify.configurator:copied_data'] = "Dati copiati, usa CTRL+V nel file di configurazione per inserire l'opzione configurata.",

        ['blip.dispatch:failed_sale'] = "Tentativo di vendita",
        ['message.dispatch:failed_sale'] = "Un ladro ha tentato di vendere %s di %sx al banco dei pegni, gli oggetti sono rubati.",

        ['blip.dispatch:failed_lockpick'] = "Furto fallito",
        ['message.dispatch:failed_lockpick'] = "Tentativo di effrazione non riuscito nella casa a %s è stato segnato sul GPS.<br>Vai lì e ferma il ladro!",

        ['blip.dispatch:thief_spotted'] = "Ladro avvistato",
        ['message.dispatch:thief_spotted'] = "L'inquilino nel suo appartamento a %s ha avvistato dei ladri, la casa è stata segnata sul GPS.<br>Vai lì rapidamente per sventare il crimine!"
    },
    ['PT'] = {
        ['moneytype.cash'] = 'dinheiro',
        ['moneytype.bank'] = 'banco',
        ['moneytype.black_money'] = 'dinheiro sujo',

        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Falar com o receptador",
        ['3dtext.talk_with_fence'] = "[E] Falar com o receptador",
        ['target.talk_with_fence'] = "Falar com o receptador",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Loja de penhores",
        ['3dtext.talk_with_pawnshop'] = "[E] Loja de penhores",
        ['target.talk_with_pawnshop'] = "Loja de penhores",

        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Organizador de roubos",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Organizador de roubos",
        ['target.talk_with_robbery_organiser'] = "Organizador de roubos",

        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Desligar a eletricidade",
        ['3dtext.turn_off_the_electricity'] = "[E] Desligar a eletricidade",
        ['target.turn_off_the_electricity'] = "Desligar a eletricidade",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Entrar na casa",
        ['3dtext.enter_house'] = "[E] Entrar na casa",
        ['target.enter_house'] = "Entrar na casa",

        ['help.exit_house'] = "~INPUT_CONTEXT~ Sair da casa",
        ['3dtext.exit_house'] = "[E] Sair da casa",
        ['target.exit_house'] = "Sair da casa",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Pegar %s",
        ['3dtext.take_loot'] = "[E] Pegar %s",
        ['target.take_loot'] = "Pegar %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Procurar",
        ['3dtext.search_cabinet'] = "[E] Procurar",
        ['target.search_cabinet'] = "Procurar",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Arrombar o cofre",
        ['3dtext.open_safe'] = "[E] Arrombar o cofre",
        ['target.open_safe'] = "Arrombar o cofre",

        ['progressbar.searching_loot'] = "Procurando...",
        ['progressbar.taking_loot'] = "Pegando %s...",

        ['notify.not_enough_police'] = "Não há polícias suficientes de serviço.",
        ['notify.your_job_is_blacklisted'] = "Não podes fazer coisas ilegais na tua profissão!",
        ['notify.you_dont_have_money'] = "Não tens dinheiro suficiente!",

        ['notify.wait'] = "Try again in a while...",
        
        ['notify.turned_off_the_electricity'] = "Desligaste a eletricidade na casa.",

        ['notify.dont_have_lockpick'] = "Não tens o %s...",
        ['notify.you_failed_break_in'] = "Falhaste na tentativa de arrombar...",
        ['notify.you_failed_turning_off_electricity'] = "Falhaste em desligar a eletricidade...",

        ['notify.you_already_started_robbery'] = "Não podes começar outro roubo, já começaste um.",
        ['notify.you_cannot_start_robbery'] = "Não podes começar este roubo agora, estará disponível em %s minutos.",
        ['notify.started_robbery'] = "Um roubo foi iniciado no distrito %s no endereço %s.",

        ['notify.you_stole_item'] = "Roubaste %s",
        ['notify.you_stole_money'] = "Roubaste %s %s$",
        ['notify.cabinet_was_empty'] = "O armário estava vazio!",
        ['notify.safe_was_empty'] = "O cofre estava vazio!",

        ['notify.dont_have_item'] = "Não tens o item que estás a tentar vender...",
        ['notify.successful_sale'] = "Vendeste %s de %sx por %s$.",
        ['notify.failed_sale'] = "Falhaste em empurrar os roubados %s em quantidade de %sx na loja de penhores, o funcionário notificou a polícia.",

        ['notify.configurator:detailed_configuration'] = "Iniciaste uma configuração detalhada de posição...",
        ['notify.configurator:press_copy_data'] = "Completaste a configuração, agora pressiona o botão abaixo para copiar os valores configurados.",
        ['notify.configurator:copied_data'] = "Dados copiados, usa CTRL+V no ficheiro de configuração para colocar a opção configurada.",

        ['blip.dispatch:failed_sale'] = "Tentativa de venda",
        ['message.dispatch:failed_sale'] = "Um ladrão tentou vender %s de %sx numa loja de penhores, os itens são roubados.",

        ['blip.dispatch:failed_lockpick'] = "Tentativa de roubo falhada",
        ['message.dispatch:failed_lockpick'] = "Tentativa de arrombamento de casa falhada em %s foi marcada no GPS.<br>Vai lá e impede o ladrão!",

        ['blip.dispatch:thief_spotted'] = "Ladrão avistado",
        ['message.dispatch:thief_spotted'] = "Morador no seu apartamento %s avistou ladrões, a casa foi marcada no GPS.<br>Vai lá rapidamente para impedir o crime!"
    },
    ['CZ'] = {
        ['moneytype.cash'] = 'Hotovost',
        ['moneytype.bank'] = 'Karta',
        ['moneytype.black_money'] = 'Spinave Penize',

        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Mluvit s Fencem",
        ['3dtext.talk_with_fence'] = "[E] Mluvit s Fencem",
        ['target.talk_with_fence'] = "Mluvit s Fencem",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Zastavarna",
        ['3dtext.talk_with_pawnshop'] = "[E] Zastavarna",
        ['target.talk_with_pawnshop'] = "[E] Zastavarna",

        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Organizator Loupeze",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Organizator Loupeze",
        ['target.talk_with_robbery_organiser'] = "Organizator Loupeze",

        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Pro Vypnuti elektriky",
        ['3dtext.turn_off_the_electricity'] = "[E] Pro Vypnuti elektriky",
        ['target.turn_off_the_electricity'] = "Pro Vypnuti elektriky",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Vstoupit",
        ['3dtext.enter_house'] = "[E] Vstoupit",
        ['target.enter_house'] = "Vstoupit",

        ['help.exit_house'] = "~INPUT_CONTEXT~ Opustit",
        ['3dtext.exit_house'] = "[E] Opustit",
        ['target.exit_house'] = "Opustit",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Vzit %s",
        ['3dtext.take_loot'] = "[E] Vzit %s",
        ['target.take_loot'] = "Vzit %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Prohledat",
        ['3dtext.search_cabinet'] = "[E] Prohledat",
        ['target.search_cabinet'] = "Prohledat",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Rozlustit kod Trezoru",
        ['3dtext.open_safe'] = "[E] Rozlustit kod Trezoru",
        ['target.open_safe'] = "Rozlustit kod Trezoru",

        ['progressbar.searching_loot'] = "Prohledavani...",
        ['progressbar.taking_loot'] = "Beres %s...",

        ['notify.not_enough_police'] = "Není dostatek policistů na službě.",
        ['notify.your_job_is_blacklisted'] = "Nemuzes delat nelegalni veci ve tve profesi!",
        ['notify.you_dont_have_money'] = "Nemas dostatek penez!",

        ['notify.wait'] = "Try again in a while...",

        ['notify.turned_off_the_electricity'] = "Vypnul jsi elektriku v dome.",

        ['notify.dont_have_lockpick'] = "Nemas %s...",
        ['notify.you_failed_break_in'] = "Pokazil jsi vloupani...",
        ['notify.you_failed_turning_off_electricity'] = "Pokazil jsi vypnuti elektriky...",

        ['notify.you_already_started_robbery'] = "Nemuzes startnout dalsi vykradani, aktualni ti jedno bezi.",
        ['notify.you_cannot_start_robbery'] = "Nemuzes startnout dalsi vykradani, dalsi bude k dispozici za %s minut.",
        ['notify.started_robbery'] = 'Vykradani Baraku zacalo %s okres %s adresa.',

        ['notify.you_stole_item'] = "Ukradnul jsi %s",
        ['notify.you_stole_money'] = "Ukradnul jsi %s %s$",
        ['notify.cabinet_was_empty'] = "Skrinka byla prazda!",
        ['notify.safe_was_empty'] = "Safe byl prazdny!",

        ['notify.dont_have_item'] = "Nemate item ktery nemuzes se pokusit prodat...",
        ['notify.successful_sale'] = "Prodal jsi %s of %sx za %s$.",
        ['notify.failed_sale'] = "Posral jsi podtlacit ukradene %s v hodnote %sx v Zastavarne, zamestnanec zavolal policii!",

        ['notify.configurator:detailed_configuration'] = "Spustil jsi podrobnou konfiguraci...",
        ['notify.configurator:press_copy_data'] = "Dokoncil jsi konfiguraci, ted stistkni nize uvedene tlacitko pro zkopirovani nakonfigurovanych hodnot",
        ['notify.configurator:copied_data'] = "Zkoprirovat, pouzij CTRL+V pro konfiguraci souboru.",

        ['blip.dispatch:failed_sale'] = "Pokus o prodej",
        ['message.dispatch:failed_sale'] = "Zlodej se pokusil prodat %s o %sx v zastavarne, predmety jsou kradene.",

        ['blip.dispatch:failed_lockpick'] = "Neuspesne vloupani",
        ['message.dispatch:failed_lockpick'] = "Neuspesny pokus se o vloupani do domu v %s bylo ti to oznaceno na GPS.<br>Jed rychle a zastav vykradajiciho!",

        ['blip.dispatch:thief_spotted'] = "Zlodej Spatren",
        ['message.dispatch:thief_spotted'] = "Najemce v %s apartmanu spatril zlodeje, dum byl oznacen na GPS.<br>Jed rychle a zastav vykradajiciho!"
    },
    ['PL'] = {
        ['moneytype.cash'] = 'gotówki',
        ['moneytype.bank'] = 'bank',
        ['moneytype.black_money'] = 'brudnej gotówki',

        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Rozmawiaj z paserem",
        ['3dtext.talk_with_fence'] = "[E] Rozmawiaj z paserem",
        ['target.talk_with_fence'] = "Rozmawiaj z paserem",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Lombard",
        ['3dtext.talk_with_pawnshop'] = "[E] Lombard",
        ['target.talk_with_pawnshop'] = "Lombard",

        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Organizator rabunków",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Organizator rabunków",
        ['target.talk_with_robbery_organiser'] = "Organizator rabunków",

        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Wyłącz prąd",
        ['3dtext.turn_off_the_electricity'] = "[E] Wyłącz prąd",
        ['target.turn_off_the_electricity'] = "Wyłącz prąd",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Wejdź do domu",
        ['3dtext.enter_house'] = "[E] Wejdź do domu",
        ['target.enter_house'] = "Wejdź do domu",

        ['help.exit_house'] = "~INPUT_CONTEXT~ Wyjdź z domu",
        ['3dtext.exit_house'] = "[E] Wyjdź z domu",
        ['target.exit_house'] = "Wyjdź z domu",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Weź %s",
        ['3dtext.take_loot'] = "[E] Weź %s",
        ['target.take_loot'] = "Weź %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Przeszukaj",
        ['3dtext.search_cabinet'] = "[E] Przeszukaj",
        ['target.search_cabinet'] = "Przeszukaj",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Otwórz sejf",
        ['3dtext.open_safe'] = "[E] Otwórz sejf",
        ['target.open_safe'] = "Otwórz sejf",

        ['progressbar.searching_loot'] = "Przeszukiwanie...",
        ['progressbar.taking_loot'] = "Branie %s...",

        ['notify.not_enough_police'] = "Nie ma wystarczającej liczby policjantów na służbie.",
        ['notify.your_job_is_blacklisted'] = "Nie możesz robić nielegalnych rzeczy w swoim zawodzie!",
        ['notify.you_dont_have_money'] = "Nie masz wystarczająco pieniędzy!",

        ['notify.wait'] = "Try again in a while...",

        ['notify.turned_off_the_electricity'] = "Wyłączyłeś prąd w domu.",

        ['notify.dont_have_lockpick'] = "Nie posiadasz %s...",
        ['notify.you_failed_break_in'] = "Nie udało ci się włamać...",
        ['notify.you_failed_turning_off_electricity'] = "Nie udało ci się wyłączyć prądu...",

        ['notify.you_already_started_robbery'] = "Nie możesz rozpocząć kolejnego napadu, już go rozpocząłeś.",
        ['notify.you_cannot_start_robbery'] = "Obecnie nie możesz rozpocząć tego napadu, będzie on dostępny za %s minut.",
        ['notify.started_robbery'] = 'Rozpoczęto napad w dzielnicy %s pod adresem %s.',

        ['notify.you_stole_item'] = "Ukradłeś %s",
        ['notify.you_stole_money'] = "Ukradłeś %s %s$",
        ['notify.cabinet_was_empty'] = "Szafka była pusta!",
        ['notify.safe_was_empty'] = "Sejf był pusty!",

        ['notify.dont_have_item'] = "Nie posiadasz przedmiotu, który próbujesz sprzedać...",
        ['notify.successful_sale'] = "Sprzedałeś %s %sx za %s$.",
        ['notify.failed_sale'] = "Nie udało Ci się wepchnąć skradziego %s %sx do lombardu, pracownik powiadomił policję.",

        ['notify.configurator:detailed_configuration'] = "Rozpocząłeś szczegółową konfigurację pozycji...",
        ['notify.configurator:press_copy_data'] = "Konfiguracja została zakończona, teraz naciśnij poniższy przycisk, aby skopiować skonfigurowane wartości.",
        ['notify.configurator:copied_data'] = "Dane zostały skopiowane, użyj CTRL+V w pliku konfiguracyjnym, aby umieścić skonfigurowaną opcję.",

        ['blip.dispatch:failed_sale'] = "Próba sprzedaży",
        ['message.dispatch:failed_sale'] = "Złodziej próbował sprzedać %s %sx w lombardzie, przedmioty pochodzą z rabunku.",

        ['blip.dispatch:failed_lockpick'] = "Nieudane włamanie",
        ['message.dispatch:failed_lockpick'] = "Nieudana próba włamania do domu w %s została oznaczona na GPS.<br>Podejdź tam i powstrzymaj włamywacza!",

        ['blip.dispatch:thief_spotted'] = "Zauważono złodzieja",
        ['message.dispatch:thief_spotted'] = "Lokator w swoim domu na %s zauważył złodziei, dom został oznaczony na GPS.<br>Pojedź tam szybko, aby udaremnić przestępstwo!"
    },
    ['DE'] = {
        ['moneytype.cash'] = 'Bargeld',
        ['moneytype.bank'] = 'Bank',
        ['moneytype.black_money'] = 'Schwarzgeld',
        
        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Sprich mit Fence",
        ['3dtext.talk_with_fence'] = "[E] Sprich mit Fence",
        ['target.talk_with_fence'] = "Sprich mit Fence",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Pfandhaus",
        ['3dtext.talk_with_pawnshop'] = "[E] Pfandhaus",
        ['target.talk_with_pawnshop'] = "[E] Pfandhaus",
        
        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Raub Organisator",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Raub Organisator",
        ['target.talk_with_robbery_organiser'] = "Raub Organisator",
        
        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Schalte die Elektrizität ab",
        ['3dtext.turn_off_the_electricity'] = "[E] Schalte die Elektrizität ab",
        ['target.turn_off_the_electricity'] = "Schalte die Elektrizität ab",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Betrete das Haus",
        ['3dtext.enter_house'] = "[E] Betrete das Haus",
        ['target.enter_house'] = "Betrete das Haus",
        
        ['help.exit_house'] = "~INPUT_CONTEXT~ Verlasse das Haus",
        ['3dtext.exit_house'] = "[E] Verlasse das Haus",
        ['target.exit_house'] = "Verlasse das Haus",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Nimm %s",
        ['3dtext.take_loot'] = "[E] Nimm %s",
        ['target.take_loot'] = "Nimm %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Suche",
        ['3dtext.search_cabinet'] = "[E] Suche",
        ['target.search_cabinet'] = "Suche",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Knacke den Safe",
        ['3dtext.open_safe'] = "[E] Knacke den Safe",
        ['target.open_safe'] = "Knacke den Safe",

        ['progressbar.searching_loot'] = "Suchen...",
        ['progressbar.taking_loot'] = "Nehme %s...",

        ['notify.not_enough_police'] = "There are not enough police officers on duty.",
        ['notify.your_job_is_blacklisted'] = "Mit deinem Beruf darfst du keine illegalen Dinge tun!",
        ['notify.you_dont_have_money'] = "Du hast nicht genug Geld!",

        ['notify.wait'] = "Try again in a while...",

        ['notify.turned_off_the_electricity'] = "Du hast die Elektrizität im Haus abgeschaltet.",

        ['notify.dont_have_lockpick'] = "Du hast nicht die %s...",
        ['notify.you_failed_break_in'] = "Es ist dir nicht gelungen einzubrechen...",
        ['notify.you_failed_turning_off_electricity'] = "Du hast es nicht geschafft die Elektrizität abzuschalten...",

        ['notify.you_already_started_robbery'] = "Du kannst keinen anderen Raub starten, du hast bereits einen gestartet.",
        ['notify.you_cannot_start_robbery'] = "Diesen Raub kannst du aktuell nicht starten, er steht in %s Minuten wieder zur Verfügung.",    
        ['notify.started_robbery'] = 'Ein Raub wure gestartet im Bezirk %s an der Adresse %s.',

        ['notify.you_stole_item'] = "Du hast %s gestohlen",
        ['notify.you_stole_money'] = "Du hast %s %s$ gestohlen",
        ['notify.cabinet_was_empty'] = "Der Schrank war leer!",
        ['notify.safe_was_empty'] = "Der Safe war leer!",

        ['notify.dont_have_item'] = "Du besitzt das Item, welches du verkaufen möchtest nicht...",
        ['notify.successful_sale'] = "Du hast %s in der Menge von %sx für %s$ verkauft.",
        ['notify.failed_sale'] = "Du hast es nicht geschafft das gestohlene %s in einer Menge von %sx im Pfandhaus zu verkaufen, der Mitarbeiter hat ie Polizei benachrichtigt.",


        ['notify.configurator:detailed_configuration'] = "Du hast eine detaillierte Positionskonfiguration gestartet.........",
        ['notify.configurator:press_copy_data'] = "Du hast die Konfiguration abgeschlossen, drücke nun den untenstehenden Knopf, um die konfigurierten Werte zu kopieren.",
        ['notify.configurator:copied_data'] = "Daten kopiert, verwende STRG+V in der Konfigurationsdatei, um die konfigurierte Option einzufügen.",

        ['blip.dispatch:failed_sale'] = "Verkaufsversuch",
        ['message.dispatch:failed_sale'] = "Ein Dieb versucht, %s von %sx im Pfandhaus zu verkaufen, die Gegenstände sind gestohlen.",

        ['blip.dispatch:failed_lockpick'] = "Fehlgeschlagener Einbruch",
        ['message.dispatch:failed_lockpick'] = "Ein erfolgloser Einbruchsversuch in das Haus bei %s wurde im GPS markiert. <br>Gehe dorthin und stoppe den Einbrecher!",

        ['blip.dispatch:thief_spotted'] = "Dieb entdeckt",
        ['message.dispatch:thief_spotted'] = "Ein Mieter in %s Wohnung hat Diebe gesehen, das Haus wurde im GPS markiert. Gehe schnell dorthin, um das Verbrechen zu vereiteln!",
    },
    ['FR'] = {
        ['moneytype.cash'] = 'espèces',
        ['moneytype.bank'] = 'banque',
        ['moneytype.black_money'] = 'argent sale',
        
        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Parler avec le receleur",
        ['3dtext.talk_with_fence'] = "[E] Parler avec le receleur",
        ['target.talk_with_fence'] = "Parler avec le receleur",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Prêter sur gage",
        ['3dtext.talk_with_pawnshop'] = "[E] Prêter sur gage",
        ['target.talk_with_pawnshop'] = "[E] Prêter sur gage",
        
        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Organiser un cambriolage",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Organiser un cambriolage",
        ['target.talk_with_robbery_organiser'] = "Organiser un cambriolage",
        
        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Couper l'électricité",
        ['3dtext.turn_off_the_electricity'] = "[E] Couper l'électricité",
        ['target.turn_off_the_electricity'] = "Couper l'électricité",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Entrer dans la maison",
        ['3dtext.enter_house'] = "[E] Entrer dans la maison",
        ['target.enter_house'] = "Entrer dans la maison",
        
        ['help.exit_house'] = "~INPUT_CONTEXT~ Sortir de la maison",
        ['3dtext.exit_house'] = "[E] Sortir de la maison",
        ['target.exit_house'] = "Sortir de la maison",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Prendre %s",
        ['3dtext.take_loot'] = "[E] Prendre %s",
        ['target.take_loot'] = "Prendre %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Fouiller",
        ['3dtext.search_cabinet'] = "[E] Fouiller",
        ['target.search_cabinet'] = "Fouiller",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Forcer le coffre",
        ['3dtext.open_safe'] = "[E] Forcer le coffre",
        ['target.open_safe'] = "Forcer le coffre",

        ['progressbar.searching_loot'] = "Recherche...",
        ['progressbar.taking_loot'] = "Prise de %s...",

        ['notify.not_enough_police'] = "There are not enough police officers on duty.",
        ['notify.your_job_is_blacklisted'] = "Vous ne pouvez pas faire des choses illégales dans votre profession !",
        ['notify.you_dont_have_money'] = "Vous n'avez pas assez d'argent !",

        ['notify.wait'] = "Try again in a while...",

        ['notify.turned_off_the_electricity'] = "Vous avez coupé l'électricité de la maison.",

        ['notify.dont_have_lockpick'] = "Vous n'avez pas le %s...",
        ['notify.you_failed_break_in'] = "Vous avez échoué à entrer...",
        ['notify.you_failed_turning_off_electricity'] = "Vous avez échoué à couper l'électricité...",

        ['notify.you_already_started_robbery'] = "Vous ne pouvez pas commencer un autre cambriolage, vous en avez déjà commencé un.",
        ['notify.you_cannot_start_robbery'] = "Vous ne pouvez pas actuellement commencer ce cambriolage, il sera disponible dans %s minutes.",    
        ['notify.started_robbery'] = 'Un cambriolage a été commencé dans le district %s à l\'adresse %s.',

        ['notify.you_stole_item'] = "Vous avez volé %s",
        ['notify.you_stole_money'] = "Vous avez volé %s %s$",
        ['notify.cabinet_was_empty'] = "Le cabinet était vide !",
        ['notify.safe_was_empty'] = "Le coffre était vide !",

        ['notify.dont_have_item'] = "Vous n'avez pas l'objet que vous essayez de vendre...",
        ['notify.successful_sale'] = "Vous avez vendu %s de %sx pour %s$.",
        ['notify.failed_sale'] = "Vous avez échoué à vendre les %s volés en quantité de %sx au prêteur sur gages, l'employé a averti la police.",

        ['notify.configurator:detailed_configuration'] = "Vous avez commencé une configuration de position...",
        ['notify.configurator:press_copy_data'] = "Vous avez terminé la configuration, appuyez maintenant sur le bouton ci-dessous pour copier les valeurs configurées.",
        ['notify.configurator:copied_data'] = "Données copiées, utilisez CTRL+V dans le fichier de configuration pour placer l'option configurée.",

        ['blip.dispatch:failed_sale'] = "Tentative de vente",
        ['message.dispatch:failed_sale'] = "Un voleur a essayé de vendre %s de %sx dans un prêteur sur gages, les objets sont volés.",

        ['blip.dispatch:failed_lockpick'] = "Cambriolage échoué",
        ['message.dispatch:failed_lockpick'] = "Tentative infructueuse d'entrer dans la maison à %s a été marquée sur le GPS.<br>Allez-y et arrêtez le cambrioleur !",

        ['blip.dispatch:thief_spotted'] = "Voleur repéré",
        ['message.dispatch:thief_spotted'] = "Le locataire de son appartement %s a repéré des voleurs, la maison a été marquée sur le GPS.<br>Allez-y vite pour empêcher le crime !",
    },
    ['ES'] = {
        ['moneytype.cash'] = 'efectivo',
        ['moneytype.bank'] = 'banco',
        ['moneytype.black_money'] = 'dinero sucio',
        
        ['help.talk_with_fence'] = "~INPUT_CONTEXT~ Hablar con el receptor",
        ['3dtext.talk_with_fence'] = "[E] Hablar con el receptor",
        ['target.talk_with_fence'] = "Hablar con el receptor",

        ['help.talk_with_pawnshop'] = "~INPUT_CONTEXT~ Casa de empeños",
        ['3dtext.talk_with_pawnshop'] = "[E] Casa de empeños",
        ['target.talk_with_pawnshop'] = "Casa de empeños",
        
        ['help.talk_with_robbery_organiser'] = "~INPUT_CONTEXT~ Organizador de robos",
        ['3dtext.talk_with_robbery_organiser'] = "[E] Organizador de robos",
        ['target.talk_with_robbery_organiser'] = "Organizador de robos",
        
        ['help.turn_off_the_electricity'] = "~INPUT_CONTEXT~ Apagar la electricidad",
        ['3dtext.turn_off_the_electricity'] = "[E] Apagar la electricidad",
        ['target.turn_off_the_electricity'] = "Apagar la electricidad",

        ['help.enter_house'] = "~INPUT_CONTEXT~ Entrar a la casa",
        ['3dtext.enter_house'] = "[E] Entrar a la casa",
        ['target.enter_house'] = "Entrar a la casa",
        
        ['help.exit_house'] = "~INPUT_CONTEXT~ Salir de la casa",
        ['3dtext.exit_house'] = "[E] Salir de la casa",
        ['target.exit_house'] = "Salir de la casa",

        ['help.take_loot'] = "~INPUT_CONTEXT~ Tomar %s",
        ['3dtext.take_loot'] = "[E] Tomar %s",
        ['target.take_loot'] = "Tomar %s",

        ['help.search_cabinet'] = "~INPUT_CONTEXT~ Buscar",
        ['3dtext.search_cabinet'] = "[E] Buscar",
        ['target.search_cabinet'] = "Buscar",

        ['help.open_safe'] = "~INPUT_CONTEXT~ Abrir la caja fuerte",
        ['3dtext.open_safe'] = "[E] Abrir la caja fuerte",
        ['target.open_safe'] = "Abrir la caja fuerte",

        ['progressbar.searching_loot'] = "Buscando...",
        ['progressbar.taking_loot'] = "Tomando %s...",

        ['notify.not_enough_police'] = "There are not enough police officers on duty.",
        ['notify.your_job_is_blacklisted'] = "No puedes hacer cosas ilegales en tu profesion!",
        ['notify.you_dont_have_money'] = "No tienes suficiente dinero!",

        ['notify.wait'] = "Try again in a while...",

        ['notify.turned_off_the_electricity'] = "Has apagado la electricidad en la casa.",

        ['notify.dont_have_lockpick'] = "No tienes el %s...",
        ['notify.you_failed_break_in'] = "Has fallado al intentar entrar...",
        ['notify.you_failed_turning_off_electricity'] = "Has fallado al intentar apagar la electricidad...",

        ['notify.you_already_started_robbery'] = "No puedes iniciar otro robo, ya has iniciado uno.",
        ['notify.you_cannot_start_robbery'] = "No puedes iniciar este robo ahora, estara disponible en %s minutos.",
        ['notify.started_robbery'] = "Se ha iniciado un robo en el distrito %s en la direccion %s.",

        ['notify.you_stole_item'] = "Has robado %s",
        ['notify.you_stole_money'] = "Has robado %s %s$",
        ['notify.cabinet_was_empty'] = "El armario estaba vacio!",
        ['notify.safe_was_empty'] = "La caja fuerte estaba vacia!",

        ['notify.dont_have_item'] = "No tienes el articulo que intentas vender...",
        ['notify.successful_sale'] = "Has vendido %s de %sx por %s$.",
        ['notify.failed_sale'] = "Has fallado al intentar vender %s de %sx en la casa de empeños, el empleado notifico a la policia.",

        ['notify.configurator:detailed_configuration'] = "Has iniciado una configuracion detallada de posicion...",
        ['notify.configurator:press_copy_data'] = "Has completado la configuracion, ahora presiona el boton de abajo para copiar los valores configurados.",
        ['notify.configurator:copied_data'] = "Datos copiados, usa CTRL+V en el archivo de configuracion para colocar la opcion configurada.",

        ['blip.dispatch:failed_sale'] = "Intento de venta",
        ['message.dispatch:failed_sale'] = "Un ladron intento vender %s de %sx en una casa de empeños, los articulos son robados.",

        ['blip.dispatch:failed_lockpick'] = "Intento de robo fallido",
        ['message.dispatch:failed_lockpick'] = "Un intento fallido de entrar en la casa en %s ha sido marcado en el GPS.<br>Ve alli y deten al ladron!",

        ['blip.dispatch:thief_spotted'] = "Ladron avistado",
        ['message.dispatch:thief_spotted'] = "Un inquilino en su apartamento en %s ha avistado a ladrones, la casa ha sido marcada en el GPS.<br>Ve alli rapidamente para frustrar el crimen!",
    }
}

TRANSLATE = function(name, ...)
    if Config.Translate[Config.Language] then
        if ... then
            return Config.Translate[Config.Language][name]:format(...)
        else
            return Config.Translate[Config.Language][name]
        end
    else
        if ... then
            return Config.Translate['EN'][name]:format(...)
        else
            return Config.Translate['EN'][name]
        end
    end
end
