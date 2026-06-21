Lang = {
    en = {
        lobby_created     = "Lobby created",
        lobby_removed     = "Lobby closed",
        lobby_full        = "Lobby is full",
        lobby_not_found   = "Lobby not found",
        not_owner         = "Only the lobby owner can perform this action",
        wrong_password    = "Wrong password",

        match_starting    = "Match starting",
        already_in_match  = "You are already in a paintball match",
        leave_lobby_first = "Leave your lobby first",
        match_not_found   = "Match not found",

        nickname_saved    = "Nickname saved",

        not_enough_money  = "You don't have enough money",
    },
    fr = {
        lobby_created     = "Salon créé",
        lobby_removed     = "Salon fermé",
        lobby_full        = "Salon complet",
        lobby_not_found   = "Salon introuvable",
        not_owner         = "Seul le créateur du salon peut faire cela",
        wrong_password    = "Mot de passe incorrect",

        match_starting    = "La partie commence",
        already_in_match  = "Vous êtes déjà en match",
        leave_lobby_first = "Quittez votre salon d'abord",
        match_not_found   = "Match introuvable",

        nickname_saved    = "Pseudo enregistré",

        not_enough_money  = "Vous n'avez pas assez d'argent",
    }
}

function Lang.get(locale, key)
    local bucket = Lang[locale] or Lang.en
    return bucket[key] or Lang.en[key] or key
end

return Lang
