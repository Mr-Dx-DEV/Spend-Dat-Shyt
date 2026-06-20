-- don't touch
local second = 1
local minute = 60 * second
local hour = 60 * minute
local day = 24 * hour
local week = 7 * day
local month = 4 * week

return {
    framework = 'qb', -- esx/qb/custom (check folder bridge | if you using qbox, insert qb!)

    notification = 'ox', -- esx/qb/ox/custom (check folder bridge | if you using qbox, insert qb/ox!)

    inventory = 'ox', -- esx/qb/ox/custom (check folder bridge | if you using qbox, insert ox!)

    target = 'ox_target', -- qtarget/qb-target/ox_target (check folder bridge | i highly recommend using target/interact because otherwise it performs poorly for finding beds! (target = false, if you still want to use it))

    debug = {
        enable = false, -- toggle debug
        tablesleep = 'printsleepanimation', -- command for tablesleep
        --tablesex = 'printsexanimation', -- command for tablesex | removed due tebex policy
    },

    command = {
        sleepanimation = 'sleepanimation', -- command for sleepanimation
        selectpartner = 'selectpartner', -- command for selectpartner
        cooldowntimer = 100000, -- cooldown for selectpartner
        --sexanimation = 'sexanimation', -- command for sexanimation | removed due tebex policy
        --tablesexanimation = 'tablesexanimation', -- command for tablesexanimation | removed due tebex policy
    },

    viagra = {
        enable = true, -- toggle viagra as item
        item = 'viagra', -- name viagra as item
        duration = 5000, -- duration sex more longer
        command = 'sexanywhere', --only available if enable = false
    },

    sos = {
        --sex
        -- blursex = true, -- permanent blur due fivem and tebex policy
        distancebed = 3.0, -- distance for getting bed as an object
        healthsex = false, -- toggle add health after sex
        healthamountsex = 200, -- amount health after sex
        armorsex = false, -- toggle add armor after sex
        armoramountsex = 100, -- amount armor after sex
        decreasehungerandthirstsex = false, -- toggle hunger and thirst decrease after sex
        hungervaluesex = 100, -- amount hunger decrease after sex
        thirstvaluesex = 100, -- amount thirst decrease after sex
        decreasestresssex = false, -- toggle stress decrease after sex
        stressvaluesex = 100, -- amount stress decrease after sex
        fadeinandoutduration = 5000, -- how long blackout duration
        --dictmaleanimationsexfixz = sexmaledict == 'xxx' or sexmaledict == 'xxx',  -- some example for fix animation needs z reduction (for addon sex animation?) | removed due tebex policy
        --dictfemaleanimationsexfixz = sexfemaledict == 'xxx' or sexfemaledict == 'xxx', -- some example for fix animation needs z reduction (for addon sex animation?) | removed due tebex policy
        sexduration = 15000, -- how long sex duration per scene
        bedkey = 38, -- key for bed https://docs.fivem.net/docs/game-references/controls/#controls
        acceptkey = 246, -- key for accept sex https://docs.fivem.net/docs/game-references/controls/#controls
        declinekey = 182, -- key for decline sex https://docs.fivem.net/docs/game-references/controls/#controls
        icontargetsex = 'fas fa car', -- sex icon for target
        --sleep
        healthsleep = false, -- toggle add health after sleep
        healthamountsleep = 200, -- amount health after sleep
        armorsleep = false, -- toggle add armor after sleep
        armoramountsleep = 100, -- amount armor after sleep
        decreasehungerandthirstsleep = false, -- toggle hunger and thirst decrease after sleep
        hungervaluesleep = 100, -- amount hunger decrease after sleep
        thirstvaluesleep = 100, -- amount thirst decrease after sleep
        decreasestresssleep = false, -- toggle stress decrease after sleep
        stressvaluesleep = 100, -- amount stress decrease after sleep
        sleeptime = 20000, -- how long sleep duration
        icontargetsleep = 'fas fa car', -- sleep icon for target
        --item
        dna = 'dnatest', -- item name for dna
        dnadict = 'missbigscore1switch_trevor_piss', -- dna dict animation
        dnaanim = 'piss_outro', -- dna anim animation
        dnaduration = 5000, -- value prevent will active
        condom = 'condom', -- item name for condom (prevent tools)
        condomdict = 'missbigscore1switch_trevor_piss', -- condom dict animation
        condomanim = 'piss_outro', -- condom anim animation
        condomduration = 10000, -- value prevent will active
        levonorgestrel = 'levonorgestrel', -- item name for levonorgestrel (prevent tools)
        levonorgestrelduration = 10000, -- value prevent will active
        testpack = 'testpack', -- item name for testpack
        testpackdict = 'missbigscore1switch_trevor_piss', -- testpack dict animation
        testpackanim = 'piss_outro', -- testpack anim animation
        testpackduration = 5000, -- value prevent will active
        mifepristone = 'mifepristone',  -- item name for mifepristone (abortion)
        mifepristoneduration = 5000, -- value prevent will active
        disease = 'diseasetest', -- item name for dna
        diseasedict = 'missbigscore1switch_trevor_piss', -- dna dict animation
        diseaseanim = 'piss_outro', -- dna anim animation
        diseaseduration = 5000, -- value prevent will active
    },

    pregnant = { 
        enable = true, -- toggle pregnant
        time = 1 * week, -- time pregnant until child birth
    },

    animationpregnant = {
        enable = true, -- toggle animation while pregnant
        dict = 'misscarsteal4@actor', -- dict animation pregnant
        anim = 'stumble', -- dict anim pregnant
        time = math.random(50000, 100000) -- time between for running animation
    },

    maleped = { -- male ped on your server
        `mp_m_freemode_01`,
    },

    femaleped = { -- female ped on your server
        `mp_f_freemode_01`,
    },

    appearance = {
        enable = true, -- toggle appearance
        script = 'custom', -- custom/skinchanger
        skinchanger = { -- this is function for change skinchanger appearance | for custom, check bridge!
            pajama = {
                male = {
                    tshirt_1 = 15,  tshirt_2 = 0,
                    torso_1 = 144,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 6,
                    pants_1 = 65,   pants_2 = 0,
                    shoes_1 = 34,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    glasses_1 = 0,     glasses_2 = 0
                },
            
                female = {
                    tshirt_1 = 6,  tshirt_2 = 0,
                    torso_1 = 142,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 6,
                    pants_1 = 67,   pants_2 = 0,
                    shoes_1 = 35,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    glasses_1 = 5,     glasses_2 = 0
                }
            },
            naked = {
                male = {
                    tshirt_1 = 15,  tshirt_2 = 0,
                    torso_1 = 144,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 6,
                    pants_1 = 65,   pants_2 = 0,
                    shoes_1 = 34,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    glasses_1 = 0,     glasses_2 = 0
                },
            
                female = {
                    tshirt_1 = 6,  tshirt_2 = 0,
                    torso_1 = 142,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 6,
                    pants_1 = 67,   pants_2 = 0,
                    shoes_1 = 35,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    glasses_1 = 5,     glasses_2 = 0
                }
            },
            pregnant = {         
                female = {
                    tshirt_1 = 6,  tshirt_2 = 0,
                    torso_1 = 142,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 6,
                    pants_1 = 67,   pants_2 = 0,
                    shoes_1 = 35,   shoes_2 = 0,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 0,    chain_2 = 0,
                    glasses_1 = 5,     glasses_2 = 0
                }
            }
            
        }, 
    },

    disease = {
        enable = true, -- toggle disease
        bodycount_hepatitis_min = 2, -- if bodycount hit min/max then there is a chance for hepatitis
        bodycount_hepatitis_max = 20,
        hepatitisitem = 'hepatitis_cured', -- item name medicine for hepatitis
        bodycount_hiv_min = 20, -- if bodycount hit min/max then there is a chance for hiv
        bodycount_hiv_max = 100,
        hivitem = 'hiv_cured', -- item name medicine for hiv
        monkeypoxitem = 'monkeypox_cured', -- item name medicine for monkeypox
    },

    childbirth = {
        dead = true, -- toggle dead while child birth
        location = vector4(973.8, -1028.65, 41.02, 270.23), -- location for child birth | CHANGE THIS!
        duration = 20000, -- duration for child birth
        key = 38, -- key for child birth https://docs.fivem.net/docs/game-references/controls/#controls
    },

    shower = {
        enable = true, -- toggle shower
        command = 'shower', -- command shower
        health = false, -- toggle add health after shower
        healthvalue = 200, -- health value after shower
        armor = false, -- toggle add health armor shower
        armorvalue = 100 -- armor value after shower
    },

    bed = { -- bed hash
        `v_res_msonbed_s`,
        `p_lestersbed_s`,
        `p_mbbed_s`,
        `p_v_res_tt_bed_s`,
        `v_res_msonbed_s`,
        `v_res_mbbed`,
        `v_res_d_bed`,
        `v_res_tre_bed1`,
        `v_res_tre_bed2`,
        `v_res_tt_bed`,
        `apa_mp_h_bed_double_09`,
        `apa_mp_h_yacht_bed_02`,
        `apa_mp_h_bed_double_08`,
        `apa_mp_h_bed_with_table_02`,
        -- new bed
        `v_16_bdr_mesh_bed`,
        `v_16_mid_bed_bed`,
        `v_24_bdr_mesh_bed`,
        `v_61_bd2_mesh_bed`,
        `v_8_bedrm4stuff`,
        `v_8_bed3stuff`,
        `apa_mp_h_bed_wide_05`,
        `apa_mp_h_yacht_bed_01`,
        `gr_prop_bunker_bed_01`,
        `hei_heist_bed_double_08`,
        `imp_prop_impexp_sofabed_01a`,
        `sum_mp_h_yacht_bed_01`,
        `sum_mp_h_yacht_bed_02`,
        `v_49_motelmp_bed`,
        `apa_mp_h_01_bed`,
        `mp_b_bed_double_08`,
        `apa_mpa2_bedwide_06`,
        `apa_mp_h_04_bed`,
        `apa_mp_h_05_bed`,
        `apa_mpa6_bedwide_06`,
        `apa_mp_h_08_bed`,
        `xs_x18intmod_high_end_bed`,
        `xs_x18intmod_ind_bed`,
        `xs_x18intmod_standard_bed`,
        `hei_int_heist_bdr_bed`,
        `h4_int_sub_bed`,
        `h4_mp_h_yacht_bed_01`,
        `h4_mp_h_yacht_bed_02`,
        `sf_int1_bdr_bed`,
        `sf_mp_h_yacht_bed_01`,
        `sf_mp_h_yacht_bed_02`,
        `sm_charlie_bed`,
        `sm_hanger_bed_modern_bed`,
        `sm_hanger_bedroom_tradbed`,
        `tr_int1_campbed`,
    },

    animationsleep = { -- sleep animation
        {
            label = 'Sleep 1',
            description = 'This is Decription',
            dict = 'timetable@tracy@sleep@',
            name = 'idle_c',
        },
        {
            label = 'Sleep 2',
            description = 'This is Decription',
            dict = 'anim@amb@nightclub@lazlow@lo_sofa@',
            name = 'lowsofa_base_laz',
        },
        {
            label = 'Sleep 3',
            description = 'This is Decription',
            dict = 'anim@amb@nightclub@lazlow@lo_sofa@',
            name = 'lowsofa_dlg_crying_laz',
        },
        {
            label = 'Sleep 4',
            description = 'This is Decription',
            dict = 'anim@amb@nightclub@lazlow@lo_sofa@',
            name = 'lowsofa_dlg_fuckedup_laz',
        },
        {
            label = 'Sleep 5',
            description = 'This is Decription',
            dict = 'anim@amb@nightclub@lazlow@lo_sofa@',
            name = 'lowsofa_dlg_notagain_laz',
        },
        {
            label = 'Sleep 6',
            description = 'This is Decription',
            dict = 'anim@amb@nightclub@lazlow@lo_sofa@',
            name = 'lowsofa_dlg_shit2strong_laz',
        },
    },

    --[[
    animationsex = { -- sex animation | removed due tebex policy
        {
            label = 'Sex 1',
            description = 'This is Decription',
            maledict = 'misscarsteal2pimpsex',
            malename = 'pimpsex_punter',
            femaledict = 'misscarsteal2pimpsex',
            femalename = 'pimpsex_hooker',
            bone = 9816,
            x = 0.0,
            y = 0.60,
            z = 0.0,
            xrot = 120.0,
            yrot = 0.0,
            zrot = 180.0,
        },
        {
            label = 'Sex 2',
            description = 'This is Decription',
            maledict = 'misscarsteal2pimpsex',
            malename = 'shagloop_pimp',
            femaledict = 'misscarsteal2pimpsex',
            femalename = 'shagloop_hooker',
            bone = 9816,
            x = 0.05,
            y = 0.35,
            z = 0.1,
            xrot = 120.0,
            yrot = 0.0,
            zrot = 180.0,
        },
        {
            label = 'Sex 3',
            description = 'This is Decription',
            maledict = 'rcmpaparazzo_2',
            malename = 'shag_loop_a',
            femaledict = 'rcmpaparazzo_2',
            femalename = 'shag_loop_poppy',
            bone = 9816,
            x = 0.015,
            y = -0.25,
            z = 0.0,
            xrot = 0.9,
            yrot = 0.3,
            zrot = 0.0,
        },
        {
            label = 'Sex 4',
            description = 'This is Decription',
            maledict = 'oddjobs@towing',
            malename = 'm_blow_job_loop',
            femaledict = 'oddjobs@towing',
            femalename = 'f_blow_job_loop',
            bone = 9816,
            x = -0.8,
            y = 0.1,
            z = 0.0,
            xrot = 0.0,
            yrot = 0.3,
            zrot = 0.0,
        },
        {
            label = 'Sex 5',
            description = 'This is Decription',
            maledict = 'mini@prostitutes@sexlow_veh',
            malename = 'low_car_sex_loop_player',
            femaledict = 'mini@prostitutes@sexlow_veh',
            femalename = 'low_car_sex_loop_female',
            bone = 9816,
            x = -0.8,
            y = 0.0,
            z = 0.0,
            xrot = 0.0,
            yrot = -0.3,
            zrot = 0.0,
        },
        {
            label = 'Sex 6',
            description = 'This is Decription',
            maledict = 'oddjobs@assassinate@vice@sex',
            malename = 'frontseat_carsex_loop_m',
            femaledict = 'oddjobs@assassinate@vice@sex',
            femalename = 'frontseat_carsex_loop_f',
            bone = 9816,
            x = -0.8,
            y = 0.1,
            z = 0.0,
            xrot = 0.0,
            yrot = 0.3,
            zrot = 0.0,
        },
        {
            label = 'Sex 7',
            description = 'This is Decription',
            maledict = 'random@drunk_driver_2',
            malename = 'cardrunksex_loop_m',
            femaledict = 'random@drunk_driver_2',
            femalename = 'cardrunksex_loop_f',
            bone = 9816,
            x = 0.7,
            y = 0.0,
            z = 0.01,
            xrot = 0.0,
            yrot = 0.3,
            zrot = 0.0,
        },
    },
    ]]
}