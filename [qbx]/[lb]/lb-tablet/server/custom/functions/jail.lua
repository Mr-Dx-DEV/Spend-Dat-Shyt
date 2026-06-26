if not Config.MDT.Jail.Refresh then
    return
end

while not DatabaseCheckerFinished do
    debugprint("Waiting for database checker to finish...")
    Wait(1000)
end

local interval = (Config.MDT.Jail.Interval or 60) * 1000

Wait(2500)

if not GetRemainingPrisonSentence then
    debugprint("^1[ERROR]^7: GetRemainingPrisonSentence is not defined - can't refresh jail time")
    return
end

Interval:new(function()
    debugprint("Updating jail times...")

    local prisoners = MySQL.query.await("SELECT id, prisoner FROM lbtablet_mdt_jail WHERE remaining_time > 0") --[[@as { id: number, prisoner: string }[] ]]

    for i = 1, #prisoners do
        local prisoner = prisoners[i]
        local remainingTime = GetRemainingPrisonSentence(prisoner.prisoner) or 0

        MySQL.update.await(
            "UPDATE lbtablet_mdt_jail SET remaining_time = ? WHERE id = ?",
            { remainingTime, prisoner.id }
        )
    end

    debugprint("Updated " .. #prisoners .. " jail times")
end, interval)
