-- ox_inventory item definitions for grim_lovemenu
-- Merge these entries into ox_inventory/data/items.lua

local ItemNames = Config.Items or {}

local function ItemName(key, fallback)
    return ItemNames[key] or fallback
end

local function ItemEvent(itemKey)
    return ('grim_lovemenu:item:%s'):format(itemKey)
end

GrimItems = {
    [ItemName('LoveTablet', 'love_tablet')] = {
        label = 'Love Tablet',
        weight = 500,
        stack = false,
        close = true,
        description = 'A private tablet for relationships and encounters.',
        consumable = false,
        client = { image = 'love_tablet.png', event = ItemEvent(ItemName('LoveTablet', 'love_tablet')) }
    },
    [ItemName('DNAResult', 'dna_result')] = {
        label = 'DNA Test Result',
        weight = 50,
        stack = false,
        close = false,
        description = 'A printed DNA result sheet.',
        consumable = false,
        client = { image = 'dna_result.png', event = ItemEvent(ItemName('DNAResult', 'dna_result')) }
    },
    [ItemName('BirthCertBoy', 'birth_cert_boy')] = {
        label = 'Birth Certificate (Boy)',
        weight = 100,
        stack = false,
        close = false,
        description = 'An official birth certificate.',
        consumable = false,
        client = { image = 'birth_cert_boy.png', event = ItemEvent(ItemName('BirthCertBoy', 'birth_cert_boy')) }
    },
    [ItemName('BirthCertGirl', 'birth_cert_girl')] = {
        label = 'Birth Certificate (Girl)',
        weight = 100,
        stack = false,
        close = false,
        description = 'An official birth certificate.',
        consumable = false,
        client = { image = 'birth_cert_girl.png', event = ItemEvent(ItemName('BirthCertGirl', 'birth_cert_girl')) }
    },
    [ItemName('UltrasoundReport', 'ultrasound_report')] = {
        label = 'Ultrasound Report',
        weight = 50,
        stack = false,
        close = false,
        description = 'A printed ultrasound report.',
        consumable = false,
        client = { image = 'ultrasound_report.png', event = ItemEvent(ItemName('UltrasoundReport', 'ultrasound_report')) }
    },
    [ItemName('PregnancyTest', 'pregnancy_test')] = {
        label = 'Pregnancy Test',
        weight = 50,
        stack = true,
        close = true,
        description = 'Use to check for pregnancy.',
        consumable = true,
        client = { image = 'pregnancy_test.png', event = ItemEvent(ItemName('PregnancyTest', 'pregnancy_test')) }
    },
    [ItemName('Contraception', 'contraception')] = {
        label = 'Contraception (Pill)',
        weight = 50,
        stack = true,
        close = true,
        description = 'Helps reduce pregnancy risk.',
        consumable = true,
        client = { image = 'contraception.png', event = ItemEvent(ItemName('Contraception', 'contraception')) }
    },
    [ItemName('PrenatalVitamins', 'prenatal_vitamins')] = {
        label = 'Prenatal Vitamins',
        weight = 50,
        stack = true,
        close = true,
        description = 'Prenatal care vitamins.',
        consumable = true,
        client = { image = 'prenatal_vitamins.png', event = ItemEvent(ItemName('PrenatalVitamins', 'prenatal_vitamins')) }
    },
    [ItemName('STDTestKit', 'std_test_kit')] = {
        label = 'STD Test Kit (7 Panel)',
        weight = 100,
        stack = false,
        close = true,
        description = 'Run a 7-panel test.',
        consumable = true,
        client = { image = 'std_test_kit.png', event = ItemEvent(ItemName('STDTestKit', 'std_test_kit')) }
    },
    [ItemName('DNATest', 'dna_test')] = {
        label = 'DNA Test Kit',
        weight = 100,
        stack = false,
        close = true,
        description = 'Open the DNA page to test a nearby player.',
        consumable = false,
        client = { image = 'dna_test.png', event = ItemEvent(ItemName('DNATest', 'dna_test')) }
    },
    [ItemName('PrescriptionMeds', 'prescription_meds')] = {
        label = 'Prescription Medication',
        weight = 50,
        stack = true,
        close = true,
        description = 'Medication for treatable infections.',
        consumable = true,
        client = { image = 'prescription_meds.png', event = ItemEvent(ItemName('PrescriptionMeds', 'prescription_meds')) }
    },
    [ItemName('Condoms', 'condoms')] = {
        label = 'Condoms',
        weight = 50,
        stack = true,
        close = true,
        description = 'Single-use protection.',
        consumable = true,
        client = { image = 'condoms.png', event = ItemEvent(ItemName('Condoms', 'condoms')) }
    },
    [ItemName('PlanC', 'plan_c')] = {
        label = 'Plan C (Morning-After)',
        weight = 50,
        stack = false,
        close = true,
        description = 'Emergency contraception. Instantly terminates pregnancy.',
        consumable = true,
        client = { image = 'plan_c.png', event = ItemEvent(ItemName('PlanC', 'plan_c')) }
    },
    [ItemName('RhinoPill', 'rhino_pill')] = {
        label = 'Rhino Pill',
        weight = 50,
        stack = true,
        close = true,
        description = 'Performance supplement.',
        consumable = true,
        client = { image = 'rhino_pill.png', event = ItemEvent(ItemName('RhinoPill', 'rhino_pill')) }
    },
    [ItemName('Lubricant', 'lubricant')] = {
        label = 'Lubricant',
        weight = 30,
        stack = true,
        close = true,
        description = 'Personal use item.',
        consumable = true,
        client = { image = 'lubricant.png', event = ItemEvent(ItemName('Lubricant', 'lubricant')) }
    },
}
