Config.Crew = {
    maxSize = 2,
    inviteTimeout = 60,
    coopBonusPercent = 0.15,
}

Config.Payment = {
    basePay = {
        [JobType.AGGRESSIVE_ANIMAL] = 85,
        [JobType.STRAY_CAPTURE]     = 70,
        [JobType.WILDLIFE_REMOVAL]  = 110,
        [JobType.DECEASED_PICKUP]   = 55,
    },
    distanceBonusPerUnit = 0.30,
    speedBonusAmount = 25,
    vehicleDestroyFine = 200,
    streakBonusPerDay = 10,
    maxStreakDays = 7,
    gasFeePercent = 0.05,
    taxPercent = 0.10,
}

Config.Complaints = {
    maxComplaints = 3,
    timeoutMinutes = 30,
    animalEscapePenalty = 1,
    animalKillPenalty = 1,
    animalKillFine = 150,
    vehicleDestroyPenalty = 1,
    deathPenalty = 1,
    decayPerJob = 1,
}

Config.Timer = {
    baseTime = 90,
    timePerDistanceUnit = 0.20,
    expiredPenalty = 0.85,
}

Config.Calls = {
    minIntervalSeconds = 15,
    maxIntervalSeconds = 45,
    responseTimeSeconds = 30,
    maxMissedCalls = 3,
}
