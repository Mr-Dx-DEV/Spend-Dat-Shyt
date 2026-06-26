-- ▀█▀ █▀▄ ▄▀▄ █▄ █ ▄▀▀ █   ▄▀▄ ▀█▀ ██▀
--  █  █▀▄ █▀█ █ ▀█ ▄██ █▄▄ █▀█  █  █▄▄
Config.Language = 'EN' -- 'EN' / 'DE' / 'FR' / 'ES' / 'PT' / 'PL' / 'IT' / 'CZ' / 'SV'

Config.Translate = {
    ['EN'] = {
        -- Boss Menu
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Boss Menu",
        ['3dtext.bossmenu'] = "[E] Boss Menu",
        ['textui.bossmenu'] = "Boss Menu",
        ['target.bossmenu'] = "Boss Menu",

        -- Gang Menu
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Gang Menu",
        ['3dtext.gangmenu'] = "[E] Gang Menu",
        ['textui.gangmenu'] = "Gang Menu",
        ['target.gangmenu'] = "Gang Menu",

        -- Dressing Room
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Dressing Room",
        ['3dtext.dressing_room'] = "[E] Dressing Room",
        ['textui.dressing_room'] = "Dressing Room",
        ['target.dressing_room'] = "Dressing Room",

        -- General
        ['notify.wait'] = "Try again in a while...",
        ['notify.you_are_not_allowed'] = "You are not allowed to do that!",
        ['notify.player_is_too_far_away'] = "The citizen is too far...",
        ['notify.you_do_not_have_enough_money'] = "You do not have enough money",

        -- Employees
        ['notify.employees:player_is_not_employed'] = "The citizen is not employed in this company.",
        ['notify.employees:player_is_not_member'] = "Citizen is not a member of your gang.",
        
        -- Employees - Hire
        ['notify.employees:must_be_unemployed'] = "A citizen cannot be employed anywhere..",
        ['notify.employees:player_is_already_employed'] = "Citizen is already employed in this company.",
        ['notify.employees:player_is_already_member'] = "Citizen is already a member of your gang.",
        ['notify.employees:you_hired_an_employee'] = "You have hired a new employee.",
        ['notify.employees:you_hired_an_member'] = "You have added a new gang member.",
        ['notify.employees:you_reached_employees_limit'] = "You have reached your employee limit.",
        ['notify.employees:you_reached_members_limit'] = "You have reached your gang members limit.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Employees - Fire
        ['notify.employees:you_fired_employee'] = "You fired an employee.",
        ['notify.employees:you_fired_member'] = "You kicked a member out of your gang.",
        
        -- Employees - Change Grade
        ['notify.employees:you_cant_change_the_grade_yourself'] = "You can't change the grade yourself.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "You can't change an employee's grade to a higher one than yours",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "You cannot change a gang member's grade to a higher grade than yours",
        ['notify.employees:you_changed_grade'] = "You have changed the grade of a citizen.",

        -- Employees - Bonus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "You awarded a bonus to an employee in the amount of $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "A gang member was awarded money in the amount of $%s",
        ['notify.employees:you_cant_fire_yourself'] = "You can't fire yourself.",


        -- Balance
        ['notify.safe:does_not_have_enough_money'] = "Company does not have enough money.",
        ['notify.safe:you_have_withdrawn'] = "You have withdrawn $%s from the company.",
        ['notify.safe:you_have_deposited'] = "You have deposited $%s into the company.",


        -- Transfers
        ['notify.transfers:amount_is_too_small'] = "The transfer amount given is too small.",
        ['notify.transfers:account_name_not_provided'] = "The name of the account receiving the transfer was not provided.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "The company with the account name given, does not exist.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "You can't make a transfer to your account",
        ['notify.transfers:you_made_transfer'] = "You made a transfer of $%s to %s.",
        
        -- Clothing
        ['notify.clothing:created_male'] = "Created outfit %s for mens.",
        ['notify.clothing:created_female'] = "Created outfit %s for womens.",
        ['notify.clothing:modified'] = "Modified outfit.",
        ['notify.clothing:removed'] = "Removed outfit.",
        
        -- Grade Manage:
        ['notify.grade_manage:grade_label_is_too_short'] = "Entered grade label is too short...",
        ['notify.grade_manage:grade_label_is_too_long'] = "Entered grade label is too long...",
        ['notify.grade_manage:successfully_changed_label'] = "Changed label to %s.",

        ['notify.grade_manage:salary_is_too_small'] = "Entered salary is too small...",
        ['notify.grade_manage:salary_is_too_high'] = "Entered salary is too high...",
        ['notify.grade_manage:successfully_changed_salary'] = "Changed salary for grade %s to $%s.",

        -- Grade Permissions
        ['notify.grade_permissions:you_set_new_permissions'] = "You set new permissions for grade",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "You took away any permissions for grade.",
        
        -- Transactions
        ['transaction.payout'] = "Payment to employee %s",
        ['transaction.transfer'] = "Transfer of funds",

        -- Announcements
        ['announcement.cityhall'] = "City Hall",
    },
    ['DE'] = {
        -- Boss Menu
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Boss-Menü",
        ['3dtext.bossmenu'] = "[E] Boss-Menü",
        ['textui.bossmenu'] = "Boss-Menü",
        ['target.bossmenu'] = "Boss-Menü",

        -- Gang Menu
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Banden-Menü",
        ['3dtext.gangmenu'] = "[E] Banden-Menü",
        ['textui.gangmenu'] = "Banden-Menü",
        ['target.gangmenu'] = "Banden-Menü",

        -- Umkleideraum
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Umkleideraum",
        ['3dtext.dressing_room'] = "[E] Umkleideraum",
        ['textui.dressing_room'] = "Umkleideraum",
        ['target.dressing_room'] = "Umkleideraum",

        -- Allgemein
        ['notify.wait'] = "Versuchen Sie es später erneut...",
        ['notify.you_are_not_allowed'] = "Sie dürfen das nicht tun!",
        ['notify.player_is_too_far_away'] = "Der Bürger ist zu weit entfernt...",
        ['notify.you_do_not_have_enough_money'] = "Sie haben nicht genug Geld",

        -- Mitarbeiter
        ['notify.employees:player_is_not_employed'] = "Der Bürger ist nicht bei diesem Unternehmen angestellt.",
        ['notify.employees:player_is_not_member'] = "Bürger ist kein Mitglied Ihrer Bande.",

        -- Mitarbeiter - Anstellen
        ['notify.employees:must_be_unemployed'] = "Ein Bürger kann nicht an anderer Stelle angestellt sein...",
        ['notify.employees:player_is_already_employed'] = "Bürger ist bereits in diesem Unternehmen angestellt.",
        ['notify.employees:player_is_already_member'] = "Bürger ist bereits Mitglied Ihrer Bande.",
        ['notify.employees:you_hired_an_employee'] = "Sie haben einen neuen Mitarbeiter eingestellt.",
        ['notify.employees:you_hired_an_member'] = "Sie haben ein neues Bandenmitglied hinzugefügt.",
        ['notify.employees:you_reached_employees_limit'] = "Sie haben Ihr Mitarbeiterlimit erreicht.",
        ['notify.employees:you_reached_members_limit'] = "Sie haben Ihr Mitgliederlimit erreicht.",

        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Mitarbeiter - Entlassen
        ['notify.employees:you_fired_employee'] = "Sie haben einen Mitarbeiter entlassen.",
        ['notify.employees:you_fired_member'] = "Sie haben ein Mitglied aus Ihrer Bande rausgeworfen.",

        -- Mitarbeiter - Rang ändern
        ['notify.employees:you_cant_change_the_grade_yourself'] = "Sie können den Rang nicht selbst ändern.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "Sie können den Rang eines Mitarbeiters nicht höher setzen als Ihren eigenen.",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "Sie können den Rang eines Bandenmitglieds nicht höher setzen als Ihren eigenen.",
        ['notify.employees:you_changed_grade'] = "Sie haben den Rang eines Bürgers geändert.",

        -- Mitarbeiter - Bonus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Sie haben einem Mitarbeiter einen Bonus in Höhe von $%s verliehen.",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "Ein Bandenmitglied wurde mit $%s belohnt.",
        ['notify.employees:you_cant_fire_yourself'] = "Sie können sich nicht selbst entlassen.",

        -- Safe
        ['notify.safe:does_not_have_enough_money'] = "Das Unternehmen hat nicht genug Geld.",
        ['notify.safe:you_have_withdrawn'] = "Sie haben $%s aus dem Unternehmen abgehoben.",
        ['notify.safe:you_have_deposited'] = "Sie haben $%s auf das Unternehmen eingezahlt.",

        -- Überweisungen
        ['notify.transfers:amount_is_too_small'] = "Der angegebene Überweisungsbetrag ist zu gering.",
        ['notify.transfers:account_name_not_provided'] = "Der Name des empfangenden Kontos wurde nicht angegeben.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "Das Unternehmen mit dem angegebenen Kontonamen existiert nicht.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "Sie können keine Überweisung auf Ihr Konto vornehmen",
        ['notify.transfers:you_made_transfer'] = "Sie haben $%s an %s überwiesen.",

        -- Kleidung
        ['notify.clothing:created_male'] = "Outfit %s für Herren erstellt.",
        ['notify.clothing:created_female'] = "Outfit %s für Damen erstellt.",
        ['notify.clothing:modified'] = "Outfit geändert.",
        ['notify.clothing:removed'] = "Outfit entfernt.",

        -- Rang verwalten
        ['notify.grade_manage:grade_label_is_too_short'] = "Eingegebenes Ranglabel ist zu kurz...",
        ['notify.grade_manage:grade_label_is_too_long'] = "Eingegebenes Ranglabel ist zu lang...",
        ['notify.grade_manage:successfully_changed_label'] = "Label zu %s geändert.",

        ['notify.grade_manage:salary_is_too_small'] = "Eingegebenes Gehalt ist zu niedrig...",
        ['notify.grade_manage:salary_is_too_high'] = "Eingegebenes Gehalt ist zu hoch...",
        ['notify.grade_manage:successfully_changed_salary'] = "Gehalt für Rang %s auf $%s geändert.",

        -- Rangberechtigungen
        ['notify.grade_permissions:you_set_new_permissions'] = "Sie haben neue Berechtigungen für den Rang festgelegt",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Sie haben alle Berechtigungen für den Rang entzogen.",

        -- Transaktionen
        ['transaction.payout'] = "Zahlung an Mitarbeiter %s",
        ['transaction.transfer'] = "Überweisung von Geldmitteln",

        -- Ankündigungen
        ['announcement.cityhall'] = "Rathaus",
    },
    ['FR'] = {
        -- Menu du patron
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Menu du patron",
        ['3dtext.bossmenu'] = "[E] Menu du patron",
        ['textui.bossmenu'] = "Menu du patron",
        ['target.bossmenu'] = "Menu du patron",

        -- Menu de gang
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Menu de gang",
        ['3dtext.gangmenu'] = "[E] Menu de gang",
        ['textui.gangmenu'] = "Menu de gang",
        ['target.gangmenu'] = "Menu de gang",

        -- Vestiaire
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Vestiaire",
        ['3dtext.dressing_room'] = "[E] Vestiaire",
        ['textui.dressing_room'] = "Vestiaire",
        ['target.dressing_room'] = "Vestiaire",

        -- Général
        ['notify.wait'] = "Réessayez plus tard...",
        ['notify.you_are_not_allowed'] = "Vous n'êtes pas autorisé à faire ça!",
        ['notify.player_is_too_far_away'] = "Le citoyen est trop loin...",
        ['notify.you_do_not_have_enough_money'] = "Vous n'avez pas assez d'argent",

        -- Employés
        ['notify.employees:player_is_not_employed'] = "Le citoyen n'est pas employé dans cette entreprise.",
        ['notify.employees:player_is_not_member'] = "Le citoyen n'est pas membre de votre gang.",
        
        -- Employés - Embauche
        ['notify.employees:must_be_unemployed'] = "Un citoyen ne peut pas être employé nulle part..",
        ['notify.employees:player_is_already_employed'] = "Le citoyen est déjà employé dans cette entreprise.",
        ['notify.employees:player_is_already_member'] = "Le citoyen est déjà membre de votre gang.",
        ['notify.employees:you_hired_an_employee'] = "Vous avez embauché un nouveau employé.",
        ['notify.employees:you_hired_an_member'] = "Vous avez ajouté un nouveau membre au gang.",
        ['notify.employees:you_reached_employees_limit'] = "Vous avez atteint votre limite d'employés.",
        ['notify.employees:you_reached_members_limit'] = "Vous avez atteint votre limite de membres de gang.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Employés - Licenciement
        ['notify.employees:you_fired_employee'] = "Vous avez licencié un employé.",
        ['notify.employees:you_fired_member'] = "Vous avez viré un membre de votre gang.",
        
        -- Employés - Changement de Grade
        ['notify.employees:you_cant_change_the_grade_yourself'] = "Vous ne pouvez pas changer de grade vous-même.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "Vous ne pouvez pas changer le grade d'un employé à un grade supérieur au vôtre",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "Vous ne pouvez pas changer le grade d'un membre de gang à un grade plus élevé que le vôtre",
        ['notify.employees:you_changed_grade'] = "Vous avez changé le grade d'un citoyen.",

        -- Employés - Bonus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Vous avez attribué un bonus à un employé d'un montant de $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "Un membre du gang a reçu de l'argent d'un montant de $%s",
        ['notify.employees:you_cant_fire_yourself'] = "Vous ne pouvez pas vous licencier.",

        -- Solde
        ['notify.safe:does_not_have_enough_money'] = "L'entreprise n'a pas assez d'argent.",
        ['notify.safe:you_have_withdrawn'] = "Vous avez retiré $%s de l'entreprise.",
        ['notify.safe:you_have_deposited'] = "Vous avez déposé $%s dans l'entreprise.",

        -- Transferts
        ['notify.transfers:amount_is_too_small'] = "Le montant du transfert donné est trop petit.",
        ['notify.transfers:account_name_not_provided'] = "Le nom du compte recevant le transfert n'a pas été fourni.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "L'entreprise avec le nom de compte donné n'existe pas.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "Vous ne pouvez pas faire de transfert vers votre compte",
        ['notify.transfers:you_made_transfer'] = "Vous avez effectué un transfert de $%s vers %s.",
        
        -- Vêtements
        ['notify.clothing:created_male'] = "Tenue %s créée pour hommes.",
        ['notify.clothing:created_female'] = "Tenue %s créée pour femmes.",
        ['notify.clothing:modified'] = "Tenue modifiée.",
        ['notify.clothing:removed'] = "Tenue supprimée.",
        
        -- Gestion des Grades
        ['notify.grade_manage:grade_label_is_too_short'] = "L'étiquette de grade saisie est trop courte...",
        ['notify.grade_manage:grade_label_is_too_long'] = "L'étiquette de grade saisie est trop longue...",
        ['notify.grade_manage:successfully_changed_label'] = "Etiquette changée en %s.",

        ['notify.grade_manage:salary_is_too_small'] = "Le salaire saisi est trop petit...",
        ['notify.grade_manage:salary_is_too_high'] = "Le salaire saisi est trop élevé...",
        ['notify.grade_manage:successfully_changed_salary'] = "Salaire changé pour le grade %s à $%s.",

        -- Autorisations de Grade
        ['notify.grade_permissions:you_set_new_permissions'] = "Vous avez défini de nouvelles autorisations pour le grade",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Vous avez retiré toutes les autorisations pour le grade.",
        
        -- Transactions
        ['transaction.payout'] = "Paiement à l'employé %s",
        ['transaction.transfer'] = "Transfert de fonds",

        -- Annonces
        ['announcement.cityhall'] = "Hôtel de ville",
    },
    ['ES'] = {
        -- Menú del jefe
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Menú del jefe",
        ['3dtext.bossmenu'] = "[E] Menú del jefe",
        ['textui.bossmenu'] = "Menú del jefe",
        ['target.bossmenu'] = "Menú del jefe",

        -- Menú de pandillas
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Menú de pandillas",
        ['3dtext.gangmenu'] = "[E] Menú de pandillas",
        ['textui.gangmenu'] = "Menú de pandillas",
        ['target.gangmenu'] = "Menú de pandillas",

        -- Vestuario
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Vestuario",
        ['3dtext.dressing_room'] = "[E] Vestuario",
        ['textui.dressing_room'] = "Vestuario",
        ['target.dressing_room'] = "Vestuario",

        -- General
        ['notify.wait'] = "Intenta de nuevo un poco más tarde...",
        ['notify.you_are_not_allowed'] = "No tienes permitido hacer eso.",
        ['notify.player_is_too_far_away'] = "El ciudadano está demasiado lejos...",
        ['notify.you_do_not_have_enough_money'] = "No tienes suficiente dinero",

        -- Empleados
        ['notify.employees:player_is_not_employed'] = "El ciudadano no está empleado en esta empresa.",
        ['notify.employees:player_is_not_member'] = "El ciudadano no es miembro de tu pandilla.",
        
        -- Empleados - Contratar
        ['notify.employees:must_be_unemployed'] = "Un ciudadano no puede estar empleado en ningún lugar...",
        ['notify.employees:player_is_already_employed'] = "El ciudadano ya está empleado en esta empresa.",
        ['notify.employees:player_is_already_member'] = "El ciudadano ya es miembro de tu pandilla.",
        ['notify.employees:you_hired_an_employee'] = "Has contratado un nuevo empleado.",
        ['notify.employees:you_hired_an_member'] = "Has añadido un nuevo miembro a la pandilla.",
        ['notify.employees:you_reached_employees_limit'] = "Has alcanzado el límite de empleados.",
        ['notify.employees:you_reached_members_limit'] = "Has alcanzado el límite de miembros en la pandilla.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Empleados - Despedir
        ['notify.employees:you_fired_employee'] = "Has despedido a un empleado.",
        ['notify.employees:you_fired_member'] = "Has expulsado a un miembro de tu pandilla.",
        
        -- Empleados - Cambiar Rango
        ['notify.employees:you_cant_change_the_grade_yourself'] = "No puedes cambiar el rango tú mismo.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "No puedes cambiar el rango de un empleado a uno superior al tuyo.",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "No puedes cambiar el rango de un miembro de la pandilla a uno superior al tuyo.",
        ['notify.employees:you_changed_grade'] = "Has cambiado el rango de un ciudadano.",

        -- Empleados - Bono
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Has otorgado un bono a un empleado por un monto de $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "Un miembro de la pandilla ha recibido dinero por un monto de $%s",
        ['notify.employees:you_cant_fire_yourself'] = "No puedes despedirte a ti mismo.",

        -- Balance
        ['notify.safe:does_not_have_enough_money'] = "La empresa no tiene suficiente dinero.",
        ['notify.safe:you_have_withdrawn'] = "Has retirado $%s de la empresa.",
        ['notify.safe:you_have_deposited'] = "Has depositado $%s en la empresa.",

        -- Transferencias
        ['notify.transfers:amount_is_too_small'] = "El monto de la transferencia es demasiado pequeño.",
        ['notify.transfers:account_name_not_provided'] = "No se proporcionó el nombre de la cuenta que recibe la transferencia.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "La empresa con el nombre de cuenta dado no existe.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "No puedes hacer una transferencia a tu cuenta",
        ['notify.transfers:you_made_transfer'] = "Has realizado una transferencia de $%s a %s.",
        
        -- Ropa
        ['notify.clothing:created_male'] = "Se creó el atuendo %s para hombres.",
        ['notify.clothing:created_female'] = "Se creó el atuendo %s para mujeres.",
        ['notify.clothing:modified'] = "Se modificó el atuendo.",
        ['notify.clothing:removed'] = "Se eliminó el atuendo.",
        
        -- Gestión de rangos
        ['notify.grade_manage:grade_label_is_too_short'] = "La etiqueta del rango ingresada es demasiado corta...",
        ['notify.grade_manage:grade_label_is_too_long'] = "La etiqueta del rango ingresada es demasiado larga...",
        ['notify.grade_manage:successfully_changed_label'] = "Se cambió la etiqueta a %s.",

        ['notify.grade_manage:salary_is_too_small'] = "El salario ingresado es demasiado pequeño...",
        ['notify.grade_manage:salary_is_too_high'] = "El salario ingresado es demasiado alto...",
        ['notify.grade_manage:successfully_changed_salary'] = "Se cambió el salario para el rango %s a $%s.",

        -- Permisos de rango
        ['notify.grade_permissions:you_set_new_permissions'] = "Estableciste nuevos permisos para el rango",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Quitaste cualquier permiso para el rango.",
        
        -- Transacciones
        ['transaction.payout'] = "Pago al empleado %s",
        ['transaction.transfer'] = "Transferencia de fondos",

        -- Anuncios
        ['announcement.cityhall'] = "Ayuntamiento",
    },
    ['PT'] = {
        -- Menu do Chefe
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Menu do Chefe",
        ['3dtext.bossmenu'] = "[E] Menu do Chefe",
        ['textui.bossmenu'] = "Menu do Chefe",
        ['target.bossmenu'] = "Menu do Chefe",

        -- Menu da Gangue
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Menu da Gangue",
        ['3dtext.gangmenu'] = "[E] Menu da Gangue",
        ['textui.gangmenu'] = "Menu da Gangue",
        ['target.gangmenu'] = "Menu da Gangue",

        -- Vestiário
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Vestiário",
        ['3dtext.dressing_room'] = "[E] Vestiário",
        ['textui.dressing_room'] = "Vestiário",
        ['target.dressing_room'] = "Vestiário",

        -- Geral
        ['notify.wait'] = "Tente novamente mais tarde...",
        ['notify.you_are_not_allowed'] = "Você não tem permissão para fazer isso!",
        ['notify.player_is_too_far_away'] = "O cidadão está muito longe...",
        ['notify.you_do_not_have_enough_money'] = "Você não tem dinheiro suficiente",

        -- Empregados
        ['notify.employees:player_is_not_employed'] = "O cidadão não está empregado nesta empresa.",
        ['notify.employees:player_is_not_member'] = "O cidadão não é membro da sua gangue.",
        
        -- Empregados - Contratar
        ['notify.employees:must_be_unemployed'] = "Um cidadão não pode estar empregado em nenhum lugar.",
        ['notify.employees:player_is_already_employed'] = "O cidadão já está empregado nesta empresa.",
        ['notify.employees:player_is_already_member'] = "O cidadão já é membro da sua gangue.",
        ['notify.employees:you_hired_an_employee'] = "Você contratou um novo empregado.",
        ['notify.employees:you_hired_an_member'] = "Você adicionou um novo membro à sua gangue.",
        ['notify.employees:you_reached_employees_limit'] = "Você atingiu o limite de empregados.",
        ['notify.employees:you_reached_members_limit'] = "Você atingiu o limite de membros da sua gangue.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Empregados - Demitir
        ['notify.employees:you_fired_employee'] = "Você demitiu um empregado.",
        ['notify.employees:you_fired_member'] = "Você expulsou um membro da sua gangue.",
        
        -- Empregados - Alterar Cargo
        ['notify.employees:you_cant_change_the_grade_yourself'] = "Você não pode alterar o cargo de si mesmo.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "Você não pode alterar o cargo de um empregado para um mais alto que o seu.",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "Você não pode alterar o cargo de um membro da gangue para um mais alto que o seu.",
        ['notify.employees:you_changed_grade'] = "Você alterou o cargo de um cidadão.",

        -- Empregados - Bônus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Você concedeu um bônus a um empregado no valor de $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "Um membro da gangue recebeu dinheiro no valor de $%s",
        ['notify.employees:you_cant_fire_yourself'] = "Você não pode se demitir.",


        -- Saldo
        ['notify.safe:does_not_have_enough_money'] = "A empresa não tem dinheiro suficiente.",
        ['notify.safe:you_have_withdrawn'] = "Você retirou $%s da empresa.",
        ['notify.safe:you_have_deposited'] = "Você depositou $%s na empresa.",


        -- Transferências
        ['notify.transfers:amount_is_too_small'] = "O valor da transferência fornecido é muito pequeno.",
        ['notify.transfers:account_name_not_provided'] = "O nome da conta que está recebendo a transferência não foi fornecido.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "A empresa com o nome da conta fornecido não existe.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "Você não pode fazer uma transferência para sua conta",
        ['notify.transfers:you_made_transfer'] = "Você fez uma transferência de $%s para %s.",
        
        -- Roupas
        ['notify.clothing:created_male'] = "Criado traje %s para homens.",
        ['notify.clothing:created_female'] = "Criado traje %s para mulheres.",
        ['notify.clothing:modified'] = "Traje modificado.",
        ['notify.clothing:removed'] = "Traje removido.",
        
        -- Gerenciar Cargo:
        ['notify.grade_manage:grade_label_is_too_short'] = "O rótulo do cargo inserido é muito curto...",
        ['notify.grade_manage:grade_label_is_too_long'] = "O rótulo do cargo inserido é muito longo...",
        ['notify.grade_manage:successfully_changed_label'] = "Alterado rótulo para %s.",

        ['notify.grade_manage:salary_is_too_small'] = "O salário inserido é muito pequeno...",
        ['notify.grade_manage:salary_is_too_high'] = "O salário inserido é muito alto...",
        ['notify.grade_manage:successfully_changed_salary'] = "Alterado salário para o cargo %s para $%s.",

        -- Permissões do Cargo
        ['notify.grade_permissions:you_set_new_permissions'] = "Você definiu novas permissões para o cargo",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Você retirou quaisquer permissões para o cargo.",
        
        -- Transações
        ['transaction.payout'] = "Pagamento para empregado %s",
        ['transaction.transfer'] = "Transferência de fundos",

        -- Anúncios
        ['announcement.cityhall'] = "Prefeitura",
    },
    ['PL'] = {
        -- Boss Menu
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Menu szefa",
        ['3dtext.bossmenu'] = "[E] Menu szefa",
        ['textui.bossmenu'] = "Menu szefa",
        ['target.bossmenu'] = "Menu szefa",

        -- Gang Menu
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Menu gangu",
        ['3dtext.gangmenu'] = "[E] Menu gangu",
        ['textui.gangmenu'] = "Menu gangu",
        ['target.gangmenu'] = "Menu gangu",

        -- Dressing Room
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Przymierzalnia",
        ['3dtext.dressing_room'] = "[E] Przymierzalnia",
        ['textui.dressing_room'] = "Przymierzalnia",
        ['target.dressing_room'] = "Przymierzalnia",

        -- General
        ['notify.wait'] = "Spróbuj ponownie za chwilę...",
        ['notify.you_are_not_allowed'] = "Nie masz uprawnień do tego!",
        ['notify.player_is_too_far_away'] = "Obywatel jest zbyt daleko...",
        ['notify.you_do_not_have_enough_money'] = "Nie masz wystarczająco pieniędzy",

        -- Employees
        ['notify.employees:player_is_not_employed'] = "Obywatel nie jest zatrudniony w tej firmie.",
        ['notify.employees:player_is_not_member'] = "Obywatel nie jest członkiem twojego gangu.",
        
        -- Employees - Hire
        ['notify.employees:must_be_unemployed'] = "Obywatel jest już gdzieś zatrudniony..",
        ['notify.employees:player_is_already_employed'] = "Obywatel jest już zatrudniony w tej firmie.",
        ['notify.employees:player_is_already_member'] = "Obywatel jest już członkiem twojego gangu.",
        ['notify.employees:you_hired_an_employee'] = "Zatrudniłeś nowego pracownika.",
        ['notify.employees:you_hired_an_member'] = "Dodałeś nowego członka gangu.",
        ['notify.employees:you_reached_employees_limit'] = "Osiągnąłeś limit pracowników.",
        ['notify.employees:you_reached_members_limit'] = "Osiągnąłeś limit członków gangu.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "Numer odznaki może składać się wyłącznie z cyfr.",
        ['notify.employees:badge_is_too_short'] = "Numer odznaki jest zbyt krótki, minimalna długość to %s znaków.",
        ['notify.employees:badge_is_too_long'] = "Numer odznaki jest zbyt długi, maksymalna długość to %s znaków.",
        ['notify.employees:badge_correctly_assigned'] = "Przypisałeś pracownikowi nowy numer odznaki.",

        -- Employees - Fire
        ['notify.employees:you_fired_employee'] = "Zwolniłeś pracownika.",
        ['notify.employees:you_fired_member'] = "Wyrzuciłeś członka z gangu.",
        
        -- Employees - Change Grade
        ['notify.employees:you_cant_change_the_grade_yourself'] = "Nie możesz zmieniać stopnia samemu sobie.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "Nie możesz zmienić stopnia pracownika na wyższy niż twój",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "Nie możesz zmienić stopnia członka gangu na wyższy niż twój",
        ['notify.employees:you_changed_grade'] = "Zmieniłeś stopień obywatelowi.",

        -- Employees - Bonus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Przyznałeś premię pracownikowi w wysokości $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "Członkowi gangu przyznano pieniądze w wysokości $%s",
        ['notify.employees:you_cant_fire_yourself'] = "Nie możesz zwolnić samego siebie.",

        -- Balance
        ['notify.safe:does_not_have_enough_money'] = "Firma nie ma wystarczająco pieniędzy",
        ['notify.safe:you_have_withdrawn'] = "Wypłaciłeś $%s z firmy.",
        ['notify.safe:you_have_deposited'] = "Zdeponowałeś $%s do firmy.",

        -- Transfers
        ['notify.transfers:amount_is_too_small'] = "Podana kwota przelewu jest za mała.",
        ['notify.transfers:account_name_not_provided'] = "Nie podano nazwy konta, do którego ma być dokonany transfer.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "Firma o podanej nazwie konta nie istnieje.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "Nie możesz dokonać transferu na swoje konto",
        ['notify.transfers:you_made_transfer'] = "Dokonałeś transferu $%s do %s.",

        -- Clothing
        ['notify.clothing:created_male'] = "Utworzono strój %s dla mężczyzn.",
        ['notify.clothing:created_female'] = "Utworzono strój %s dla kobiet.",
        ['notify.clothing:modified'] = "Zmodyfikowano strój.",
        ['notify.clothing:removed'] = "Usunięto strój.",

        -- Grade Manage:
        ['notify.grade_manage:grade_label_is_too_short'] = "Wprowadzona nazwa stopnia jest za krótka...",
        ['notify.grade_manage:grade_label_is_too_long'] = "Wprowadzona nazwa stopnia jest za długa...",
        ['notify.grade_manage:successfully_changed_label'] = "Zmieniono nazwę na %s.",

        ['notify.grade_manage:salary_is_too_small'] = "Wprowadzona pensja jest za niska...",
        ['notify.grade_manage:salary_is_too_high'] = "Wprowadzona pensja jest za wysoka...",
        ['notify.grade_manage:successfully_changed_salary'] = "Zmieniono pensję dla stopnia %s na $%s.",

        -- Grade Permissions
        ['notify.grade_permissions:you_set_new_permissions'] = "Ustawiłeś nowe uprawnienia dla stopnia",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Usunąłeś wszystkie uprawnienia dla stopnia.",

        -- Transactions
        ['transaction.payout'] = "Wypłata dla pracownika %s",
        ['transaction.transfer'] = "Transfer środków", 

        -- Announcements
        ['announcement.cityhall'] = "Urząd Skarbowy",
    },
    ['IT'] = {
        -- Boss Menu
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Menu Capo",
        ['3dtext.bossmenu'] = "[E] Menu Capo",
        ['textui.bossmenu'] = "Menu Capo",
        ['target.bossmenu'] = "Menu Capo",

        -- Gang Menu
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Menu Gang",
        ['3dtext.gangmenu'] = "[E] Menu Gang",
        ['textui.gangmenu'] = "Menu Gang",
        ['target.gangmenu'] = "Menu Gang",

        -- Dressing Room
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Stanza degli Abiti",
        ['3dtext.dressing_room'] = "[E] Stanza degli Abiti",
        ['textui.dressing_room'] = "Stanza degli Abiti",
        ['target.dressing_room'] = "Stanza degli Abiti",

        -- General
        ['notify.wait'] = "Riprova tra poco...",
        ['notify.you_are_not_allowed'] = "Non sei autorizzato a fare ciò!",
        ['notify.player_is_too_far_away'] = "Il cittadino è troppo lontano...",
        ['notify.you_do_not_have_enough_money'] = "Non hai abbastanza soldi",

        -- Employees
        ['notify.employees:player_is_not_employed'] = "Il cittadino non è impiegato in questa azienda.",
        ['notify.employees:player_is_not_member'] = "Il cittadino non è membro della tua gang.",
        
        -- Employees - Hire
        ['notify.employees:must_be_unemployed'] = "Un cittadino non può essere impiegato da nessuna parte..",
        ['notify.employees:player_is_already_employed'] = "Il cittadino è già impiegato in questa azienda.",
        ['notify.employees:player_is_already_member'] = "Il cittadino è già membro della tua gang.",
        ['notify.employees:you_hired_an_employee'] = "Hai assunto un nuovo dipendente.",
        ['notify.employees:you_hired_an_member'] = "Hai aggiunto un nuovo membro alla gang.",
        ['notify.employees:you_reached_employees_limit'] = "Hai raggiunto il limite dei dipendenti.",
        ['notify.employees:you_reached_members_limit'] = "Hai raggiunto il limite dei membri della gang.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Employees - Fire
        ['notify.employees:you_fired_employee'] = "Hai licenziato un dipendente.",
        ['notify.employees:you_fired_member'] = "Hai cacciato un membro dalla tua gang.",
        
        -- Employees - Change Grade
        ['notify.employees:you_cant_change_the_grade_yourself'] = "Non puoi cambiare il grado da solo.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "Non puoi cambiare il grado di un dipendente ad uno più alto del tuo",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "Non puoi cambiare il grado di un membro della gang ad uno più alto del tuo",
        ['notify.employees:you_changed_grade'] = "Hai cambiato il grado di un cittadino.",

        -- Employees - Bonus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Hai assegnato un bonus a un dipendente di $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "Un membro della gang è stato premiato con denaro per un importo di $%s",
        ['notify.employees:you_cant_fire_yourself'] = "Non puoi licenziare te stesso.",


        -- Balance
        ['notify.safe:does_not_have_enough_money'] = "Azienda non ha abbastanza soldi.",
        ['notify.safe:you_have_withdrawn'] = "Hai prelevato $%s dall'azienda.",
        ['notify.safe:you_have_deposited'] = "Hai depositato $%s nell'azienda.",


        -- Transfers
        ['notify.transfers:amount_is_too_small'] = "L'importo del trasferimento è troppo piccolo.",
        ['notify.transfers:account_name_not_provided'] = "Non è stato fornito il nome dell'account che riceve il trasferimento.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "L'azienda con il nome dell'account fornito non esiste.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "Non puoi fare un trasferimento sul tuo account",
        ['notify.transfers:you_made_transfer'] = "Hai effettuato un trasferimento di $%s a %s.",
        
        -- Clothing
        ['notify.clothing:created_male'] = "Creato outfit %s per uomo.",
        ['notify.clothing:created_female'] = "Creato outfit %s per donna.",
        ['notify.clothing:modified'] = "Outfit modificato.",
        ['notify.clothing:removed'] = "Outfit rimosso.",
        
        -- Grade Manage:
        ['notify.grade_manage:grade_label_is_too_short'] = "L'etichetta del grado inserita è troppo corta...",
        ['notify.grade_manage:grade_label_is_too_long'] = "L'etichetta del grado inserita è troppo lunga...",
        ['notify.grade_manage:successfully_changed_label'] = "Etichetta cambiata in %s.",

        ['notify.grade_manage:salary_is_too_small'] = "Lo stipendio inserito è troppo basso...",
        ['notify.grade_manage:salary_is_too_high'] = "Lo stipendio inserito è troppo alto...",
        ['notify.grade_manage:successfully_changed_salary'] = "Stipendio cambiato per il grado %s a $%s.",

        -- Grade Permissions
        ['notify.grade_permissions:you_set_new_permissions'] = "Hai impostato nuovi permessi per il grado",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Hai tolto tutti i permessi per il grado.",
        
        -- Transactions
        ['transaction.payout'] = "Pagamento all'impiegato %s",
        ['transaction.transfer'] = "Trasferimento di fondi",

        -- Announcements
        ['announcement.cityhall'] = "Municipio",
    },
    ['CZ'] = {
        -- Boss Menu
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Boss Menu",
        ['3dtext.bossmenu'] = "[E] Boss Menu",
        ['textui.bossmenu'] = "Boss Menu",
        ['target.bossmenu'] = "Boss Menu",

        -- Gang Menu
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Gang Menu",
        ['3dtext.gangmenu'] = "[E] Gang Menu",
        ['textui.gangmenu'] = "Gang Menu",
        ['target.gangmenu'] = "Gang Menu",

        -- Dressing Room
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Dressing Room",
        ['3dtext.dressing_room'] = "[E] Dressing Room",
        ['textui.dressing_room'] = "Dressing Room",
        ['target.dressing_room'] = "Dressing Room",

        -- General
        ['notify.wait'] = "Zkuste to znovu za chvíli...",
        ['notify.you_are_not_allowed'] = "Nemáte dovoleno to udělat!",
        ['notify.player_is_too_far_away'] = "Obyvatel je příliš daleko...",
        ['notify.you_do_not_have_enough_money'] = "Nemáte dost peněz",

        -- Employees
        ['notify.employees:player_is_not_employed'] = "Obyvatel není zaměstnán v této společnosti.",
        ['notify.employees:player_is_not_member'] = "Obyvatel není členem vaší bandy.",
        
        -- Employees - Hire
        ['notify.employees:must_be_unemployed'] = "Obyvatel nemůže být zaměstnán nikde jinde..",
        ['notify.employees:player_is_already_employed'] = "Obyvatel je již zaměstnán v této společnosti.",
        ['notify.employees:player_is_already_member'] = "Obyvatel je již členem vaší bandy.",
        ['notify.employees:you_hired_an_employee'] = "Přijali jste nového zaměstnance.",
        ['notify.employees:you_hired_an_member'] = "Přidali jste nového člena bandy.",
        ['notify.employees:you_reached_employees_limit'] = "Dosáhli jste svého limitu zaměstnanců.",
        ['notify.employees:you_reached_members_limit'] = "Dosáhli jste svého limitu členů bandy.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Employees - Fire
        ['notify.employees:you_fired_employee'] = "Propustili jste zaměstnance.",
        ['notify.employees:you_fired_member'] = "Vyhodili jste člena z vaší bandy.",
        
        -- Employees - Change Grade
        ['notify.employees:you_cant_change_the_grade_yourself'] = "Nemůžete si změnit hodnost sami.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "Nemůžete změnit hodnost zaměstnance na vyšší než tu svou",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "Nemůžete změnit hodnost člena bandy na vyšší než tu svou",
        ['notify.employees:you_changed_grade'] = "Změnili jste hodnost občana.",

        -- Employees - Bonus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Udělili jste zaměstnanci bonus ve výši $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "Člen bandy obdržel peníze ve výši $%s",
        ['notify.employees:you_cant_fire_yourself'] = "Nemůžete propustit sami sebe.",


        -- Balance
        ['notify.safe:does_not_have_enough_money'] = "Společnost nemá dost peněz.",
        ['notify.safe:you_have_withdrawn'] = "Vybrali jste $%s ze společnosti.",
        ['notify.safe:you_have_deposited'] = "Vložili jste $%s do společnosti.",


        -- Transfers
        ['notify.transfers:amount_is_too_small'] = "Zadaná částka pro převod je příliš malá.",
        ['notify.transfers:account_name_not_provided'] = "Nebylo uvedeno jméno účtu, na který se má provést převod.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "Společnost s uvedeným názvem účtu neexistuje.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "Nemůžete provést převod na svůj účet",
        ['notify.transfers:you_made_transfer'] = "Provedli jste převod ve výši $%s na %s.",
        
        -- Clothing
        ['notify.clothing:created_male'] = "Vytvořili jste outfit %s pro muže.",
        ['notify.clothing:created_female'] = "Vytvořili jste outfit %s pro ženy.",
        ['notify.clothing:modified'] = "Upraven outfit.",
        ['notify.clothing:removed'] = "Odstraněn outfit.",
        
        -- Grade Manage:
        ['notify.grade_manage:grade_label_is_too_short'] = "Zadaný popisek hodnosti je příliš krátký...",
        ['notify.grade_manage:grade_label_is_too_long'] = "Zadaný popisek hodnosti je příliš dlouhý...",
        ['notify.grade_manage:successfully_changed_label'] = "Změnili jste popisek na %s.",

        ['notify.grade_manage:salary_is_too_small'] = "Zadaná mzda je příliš malá...",
        ['notify.grade_manage:salary_is_too_high'] = "Zadaná mzda je příliš vysoká...",
        ['notify.grade_manage:successfully_changed_salary'] = "Změnili jste mzdu pro hodnost %s na $%s.",

        -- Grade Permissions
        ['notify.grade_permissions:you_set_new_permissions'] = "Nastavili jste nová oprávnění pro hodnost",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Odebrali jste všechna oprávnění pro hodnost.",
        
        -- Transactions
        ['transaction.payout'] = "Platba zaměstnanci %s",
        ['transaction.transfer'] = "Převod finančních prostředků",

        -- Announcements
        ['announcement.cityhall'] = "Radnice",
    },
    ['SV'] = {
        -- Boss meny
        ['help.bossmenu'] = "~INPUT_CONTEXT~ Boss Meny",
        ['3dtext.bossmenu'] = "[E] Boss Meny",
        ['textui.bossmenu'] = "Boss Meny",
        ['target.bossmenu'] = "Boss Meny",

        -- Gäng meny
        ['help.gangmenu'] = "~INPUT_CONTEXT~ Gäng Meny",
        ['3dtext.gangmenu'] = "[E] Gäng Meny",
        ['textui.gangmenu'] = "Gäng Meny",
        ['target.gangmenu'] = "Gäng Meny",

        -- Omklädningsrum
        ['help.dressing_room'] = "~INPUT_CONTEXT~ Omklädningsrum",
        ['3dtext.dressing_room'] = "[E] Omklädningsrum",
        ['textui.dressing_room'] = "Omklädningsrum",
        ['target.dressing_room'] = "Omklädningsrum",

        -- Allmänt
        ['notify.wait'] = "Försök igen om en stund...",
        ['notify.you_are_not_allowed'] = "Du har inte tillåtelse att göra det!",
        ['notify.player_is_too_far_away'] = "Medborgaren är för långt borta...",
        ['notify.you_do_not_have_enough_money'] = "Du har inte tillräckligt med pengar",

        -- Anställda
        ['notify.employees:player_is_not_employed'] = "Medborgaren är inte anställd i det här företaget.",
        ['notify.employees:player_is_not_member'] = "Medborgaren är inte medlem i ditt gäng.",
        
        -- Anställda - Anställning
        ['notify.employees:must_be_unemployed'] = "En medborgare kan inte vara anställd någonstans..",
        ['notify.employees:player_is_already_employed'] = "Medborgaren är redan anställd i det här företaget.",
        ['notify.employees:player_is_already_member'] = "Medborgaren är redan medlem i ditt gäng.",
        ['notify.employees:you_hired_an_employee'] = "Du har anställt en ny anställd.",
        ['notify.employees:you_hired_an_member'] = "Du har lagt till en ny gängmedlem.",
        ['notify.employees:you_reached_employees_limit'] = "Du har nått din anställdegräns.",
        ['notify.employees:you_reached_members_limit'] = "Du har nått din gängmedlemsgräns.",
        
        -- Employees - Badge
        ['notify.employees:badge_can_be_only_number'] = "The badge number can only consist of digits.",
        ['notify.employees:badge_is_too_short'] = "Badge number is too short, minimum length is %s characters.",
        ['notify.employees:badge_is_too_long'] = "Badge number is too long, maximum length is %s characters.",
        ['notify.employees:badge_correctly_assigned'] = "You have assigned a badge number to an employee.",

        -- Anställda - Avsked
        ['notify.employees:you_fired_employee'] = "Du avskedade en anställd.",
        ['notify.employees:you_fired_member'] = "Du sparkade ut en medlem från ditt gäng.",
        
        -- Anställda - Ändra Nivå
        ['notify.employees:you_cant_change_the_grade_yourself'] = "Du kan inte ändra nivån själv.",
        ['notify.employees:you_cant_change_employee_grade_to_higher'] = "Du kan inte ändra en anställds nivå till en högre än din",
        ['notify.employees:you_cant_change_member_grade_to_higher'] = "Du kan inte ändra en gängmedlems nivå till en högre nivå än din",
        ['notify.employees:you_changed_grade'] = "Du har ändrat nivån på en medborgare.",

        -- Anställda - Bonus
        ['notify.employees:you_awarded_bonus_to_an_employee'] = "Du tilldelade en bonus till en anställd på summan $%s",
        ['notify.employees:you_awarded_bonus_to_a_member'] = "En gängmedlem tilldelades pengar på summan $%s",
        ['notify.employees:you_cant_fire_yourself'] = "Du kan inte avskeda dig själv.",

        -- Balans
        ['notify.safe:does_not_have_enough_money'] = "Företaget har inte tillräckligt med pengar.",
        ['notify.safe:you_have_withdrawn'] = "Du har tagit ut $%s från företaget.",
        ['notify.safe:you_have_deposited'] = "Du har satt in $%s på företaget.",

        -- Överföringar
        ['notify.transfers:amount_is_too_small'] = "Den angivna överföringsbeloppet är för litet.",
        ['notify.transfers:account_name_not_provided'] = "Namnet på kontot som tar emot överföringen angavs inte.",
        ['notify.transfers:specified_account_name_does_not_exist'] = "Företaget med det angivna kontonamnet existerar inte.",
        ['notify.transfers:cant_make_transfer_to_your_account'] = "Du kan inte göra en överföring till ditt konto",
        ['notify.transfers:you_made_transfer'] = "Du gjorde en överföring av $%s till %s.",

        -- Kläder
        ['notify.clothing:created_male'] = "Skapade outfit %s för män.",
        ['notify.clothing:created_female'] = "Skapade outfit %s för kvinnor.",
        ['notify.clothing:modified'] = "Modifierade outfit.",
        ['notify.clothing:removed'] = "Tog bort outfit.",

        -- Nivåhantering
        ['notify.grade_manage:grade_label_is_too_short'] = "Det angivna nivåetiketten är för kort...",
        ['notify.grade_manage:grade_label_is_too_long'] = "Det angivna nivåetiketten är för lång...",
        ['notify.grade_manage:successfully_changed_label'] = "Ändrade etiketten till %s.",

        ['notify.grade_manage:salary_is_too_small'] = "Den angivna lönen är för liten...",
        ['notify.grade_manage:salary_is_too_high'] = "Den angivna lönen är för hög...",
        ['notify.grade_manage:successfully_changed_salary'] = "Ändrade lönen för nivå %s till $%s.",

        -- Nivåbehörigheter
        ['notify.grade_permissions:you_set_new_permissions'] = "Du ställde in nya behörigheter för nivån",
        ['notify.grade_permissions:you_taken_away_any_permissions'] = "Du tog bort alla behörigheter för nivån.",

        -- Transaktioner
        ['transaction.payout'] = "Betala till anställd %s",
        ['transaction.transfer'] = "Överföring av pengar",

        -- Meddelanden
        ['announcement.cityhall'] = "Stadshuset",
    },
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