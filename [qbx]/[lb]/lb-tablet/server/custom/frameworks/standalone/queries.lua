if Config.Framework ~= "standalone" then
    return
end

UsersCollate = ""
VehiclesCollate = ""

Queries = {}

Queries.Users = {}

Queries.Users = {}
Queries.Users.Table = "lbtablet_registration_characters"
Queries.Users.Select = {
    identifier = "user.character_id",
    name = "CONCAT(user.firstname, ' ', user.lastname)",
    dob = "user.dateofbirth",
    isMale = "user.is_male",
}

Queries.Users.Filter = {}
Queries.Users.Filter.Jobs = "user.job IN (?)"
Queries.Users.Filter.Gender = "user.is_male = ?"
Queries.Users.Filter.License = "EXISTS (SELECT 1 FROM lbtablet_registration_licenses license WHERE license.character_id = user.character_id AND license.license = ?)"
Queries.Users.Filter.ExcludeJailed = "user.jail = 0"

Queries.Users.FetchProfile = [[
    SELECT
        user.character_id AS id,
        profile.id AS profileId,
        profile.avatar,
        CONCAT(user.firstname, ' ', user.lastname) AS `name`,
        user.dateofbirth as dob,
        user.height,
        user.is_male AS isMale,
        user.job AS jobGrade,
        user.job

    FROM lbtablet_registration_characters user

    LEFT JOIN lbtablet_mdt_profiles profile ON
        profile.profile_id = user.character_id {USERS_COLLATE}
        AND profile.profile_type = 'player'
        AND profile.department = ?

    WHERE user.character_id = ?
]]

Queries.Vehicles = {}
Queries.Vehicles.Table = "lbtablet_registration_vehicles"
Queries.Vehicles.Select = {
    plate = "vehicle.plate",
    owner = "vehicle.character_id",
    model = "vehicle.model",
    color = "vehicle.color",
}

Queries.Vehicles.BasicFetch = "SELECT model, color FROM lbtablet_registration_vehicles WHERE plate = ?"
