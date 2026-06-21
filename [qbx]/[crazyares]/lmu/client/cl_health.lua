-- -
--  CLIENT HEALTH  -  passive STD symptom display
-- -

RegisterNetEvent('grim_lovemenu:cl:stdSymptom', function(diseaseLabel)
    local symptoms = {
        'You feel a burning sensation.',
        'You have a persistent headache.',
        'You feel unusually fatigued.',
        'You notice unusual discharge.',
        'You feel feverish.',
    }
    local msg = symptoms[math.random(#symptoms)] .. ' (Possible: ' .. diseaseLabel .. ')'
    Bridge.Notify(msg, 'error')
end)
