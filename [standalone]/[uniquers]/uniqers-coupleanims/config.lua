Config = {
  EnableQueue = true,
  OpenKey = 'F5',
  CoupleAnimsECommand = "e", -- /e animname
  CoupleAnimCancelCommand = "stopanim", -- stop anim
  CoupleAnimsCommand = "coupleanims", -- open menu
  UseCustomAnims = true,
  CancelKey = "X",
  QuickBindMod = 'LSHIFT',
  QuickBinds = {
    [1] = 'NUMPAD1',
    [2] = 'NUMPAD2',
    [3] = 'NUMPAD3',
    [4] = 'NUMPAD4',
    [5] = 'NUMPAD5',
    [6] = 'NUMPAD6',
    [7] = 'NUMPAD7',
    [8] = 'NUMPAD8',
    [9] = 'NUMPAD9',
  },
  AcceptKey = 246,
  DeclineKey = 244,
  PlacementControls = {
    moveUp = 241,
    moveDown = 242,
    moveLeft = 174,
    moveRight = 175,
    moveForward = 172,
    moveBackward = 173,
    turnLeft = 52,
    turnRight = 51,
    mouseFollowToggle = 47,
    confirmPlacement = 191,
    cancelPlacement = 73,
    ControlHelp = {
      {label = 'Right', key = 175},
      {label = 'Left', key = 174},
      {label = 'Backward', key = 173},
      {label = 'Forward', key = 172},
      {label = 'Rotate Right', key = 51},
      {label = 'Rotate Left', key = 52},
      {label = 'Up / Down', key = 348},
      {label = 'Enable/Disable Mouse Follow', key = 47},
      {label = 'Cancel', key = 73},
      {label = 'Done', key = 191},
    }
  },
}
Config.TimeChangeFunction = function(newHour, newMinute)
    -- DEFAULT (Standard FiveM Time)
    -- This only changes the time for the current player.
    NetworkOverrideClockTime(newHour, newMinute, 0)

    ----------------------------------------------------------------
    -- EXAMPLES (Customers can enable these based on their own scripts):
    ----------------------------------------------------------------

    -- For users of QB-WeatherSync / vSync (Client-side override)
    -- TriggerEvent('qb-weathersync:client:DisableSync') -- Stop synchronization first (if enabled)
    -- NetworkOverrideClockTime(newHour, newMinute, 0)
    
    -- For users of CD_EasyTime
    -- TriggerEvent('cd_easytime:PauseSync', true)
    -- NetworkOverrideClockTime(newHour, newMinute, 0)

    -- If they want to change the time for the entire server
    -- (Not recommended, but possible):
    -- TriggerServerEvent("weathersync:server:setTime", newHour, newMinute)
end


Config.Translation = {
-- NEWLY ADDED SLEEP TRANSLATIONS
['adz_filter'] = "A-Z Filter",
['sleep_confirm_title'] = "Sleep Mode",
['sleep_confirm_text'] = "Do you really want to sleep and advance time?",
['sleep_btn_yes'] = "Yes, Sleep",
['sleep_btn_no'] = "Just Lie Down",
['sleep_progress_title'] = "Sweet Dreams...",
['sleep_progress_added'] = "+%s Hours", -- %s will be replaced with the hour amount
    ['anim_menu_title'] = "Animation Menu",
    ['anim_positioning_title'] = "Animation Positioning",
    ['search_placeholder'] = "Search animation...",
    ['filter_all'] = "All",
    ['filter_male'] = "Male",
    ['filter_female'] = "Female",
    ['filter_favorites'] = "Favorites",
    ['shortcut_bar_info'] = "Drag and drop an animation to assign it a shortcut (%MODIFIER_KEY% + [Number])",
    ['tag_adult_text'] = "Adult content (+18)",
    ['tag_paired_text'] = "Paired Animation",
    ['tag_solo_text'] = "Solo Animation",
    ['action_favorite_text'] = "Favorite",
    ['action_invite_text'] = "Invite",
    ['action_set_position_text'] = "Set Position",
    ['quickbind_empty_slot'] = "Empty",
    ['quickbind_remove'] = "Remove Shortcut",
    ['quickbind_add_title'] = "✅ Shortcut Added",
    ['quickbind_add_desc'] = "Animation '%s' assigned to shortcut %s.",
    ['quickbind_rem_title'] = "🗑️ Shortcut Removed",
    ['quickbind_rem_desc'] = "Animation '%s' was removed from shortcuts.",
    ['invite_accept_text'] = "Accept",
    ['invite_decline_text'] = "Decline",
    ['notify_error'] = "Error",
    ['notify_no_player'] = "There is no player nearby.",
    ['notify_success'] = "Success",
    ['notify_invite_sent'] = "Invitation sent successfully.",
    ['notify_new_invite'] = "New Animation Invite",
    ['notify_invited_anim'] = "You have been invited to play the animation: %s",
    ['notify_invite_prompt'] = "Press [%s] to Accept or [%s] to Decline.",
    ['pos_confirm'] = "Done",
    ['pos_exit'] = "Cancel",
    ['pos_toggle_mouse'] = "Toggle Mouse Follow",
    ['pos_rotate_label'] = "Rotate",
    ['pos_move_vert'] = "Move Up/Down",
    ['pos_move_horiz'] = "Move Position",
	['filter_special'] = "Special Animation", -- YENİ
	['filter_expression'] = "Expression", -- YENİ
}

Config.ShowerOutfits = {
    Male = {
        -- Üst (Tshirt, Ceket vb. çıkart)
        { component = 3, drawable = 15, texture = 0 }, -- Torso (Gövde)
        { component = 4, drawable = 14, texture = 0 }, -- Bacak (Şort/Havlu/Don)
        { component = 6, drawable = 34, texture = 0 }, -- Ayakkabı (Çıplak ayak)
        { component = 8, drawable = 15, texture = 0 }, -- Atlet (Yok)
        { component = 11, drawable = 15, texture = 0 }, -- Ceket (Yok)
    },
    Female = {
        -- Üst
        { component = 3, drawable = 15, texture = 0 }, -- Torso
        { component = 4, drawable = 15, texture = 0 }, -- Bacak (Bikini altı/Havlu)
        { component = 6, drawable = 35, texture = 0 }, -- Ayakkabı
        { component = 8, drawable = 15, texture = 0 }, -- Atlet
        { component = 11, drawable = 15, texture = 0 }, -- Ceket (Bikini üstü)
    }
}

Config.RecorderOutfits = {
  Male = {
    Model = "mp_m_freemode_01",
    Components = {
      { component_id = 0, drawable = 0, texture = 0 },
      { component_id = 1, drawable = 0, texture = 0 },
      { component_id = 2, drawable = 0, texture = 0 },
      { component_id = 3, drawable = 0, texture = 0 },
      { component_id = 4, drawable = 0, texture = 0 },
      { component_id = 5, drawable = 0, texture = 0 },
      { component_id = 6, drawable = 0, texture = 0 },
      { component_id = 7, drawable = 0, texture = 0 },
      { component_id = 8, drawable = 0, texture = 0 },
      { component_id = 9, drawable = 0, texture = 0 },
      { component_id = 10, drawable = 0, texture = 0 },
      { component_id = 11, drawable = 0, texture = 0 }
    },
    Props = {
      { prop_id = 0, drawable = -1, texture = -1 },
      { prop_id = 1, drawable = -1, texture = -1 },
      { prop_id = 2, drawable = -1, texture = -1 },
      { prop_id = 6, drawable = -1, texture = -1 },
      { prop_id = 7, drawable = -1, texture = -1 }
    },
    Hair = {
      color = 0,
      highlight = 0,
      style = 0,
      texture = 0
    }
  },
  Female = {
    Model = "mp_f_freemode_01",
    Components = {
      { component_id = 0, drawable = 0, texture = 0 },
      { component_id = 1, drawable = 0, texture = 0 },
      { component_id = 2, drawable = 0, texture = 0 },
      { component_id = 3, drawable = 0, texture = 0 },
      { component_id = 4, drawable = 0, texture = 0 },
      { component_id = 5, drawable = 0, texture = 0 },
      { component_id = 6, drawable = 0, texture = 0 },
      { component_id = 7, drawable = 0, texture = 0 },
      { component_id = 8, drawable = 0, texture = 0 },
      { component_id = 9, drawable = 0, texture = 0 },
      { component_id = 10, drawable = 0, texture = 0 },
      { component_id = 11, drawable = 0, texture = 0 }
    },
    Props = {
      { prop_id = 0, drawable = -1, texture = -1 },
      { prop_id = 1, drawable = -1, texture = -1 },
      { prop_id = 2, drawable = -1, texture = -1 },
      { prop_id = 6, drawable = -1, texture = -1 },
      { prop_id = 7, drawable = -1, texture = -1 }
    },
    Hair = {
      color = 0,
      highlight = 0,
      style = 0,
      texture = 0
    }
  }
}


Config.AnimationList = {
{
        animnametext = "Happy",
        animationid = "mood_happy",
        coupleanim = "mood_happy",
        animimg = "happy.webp",
        animcoupletype = "Paired",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_happy_1",
            emojiType = "burst",
            emojiIcon = "fas fa-smile-beam",
            particleColors = {"#FFC107"},
			sound = "happy.mp3",
            duration = 1000
        }
    },
    {
        animnametext = "In Love",
        animationid = "mood_love",
        coupleanim = "mood_love",
        animimg = "love.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_happy_1",
            emojiType = "burst",
            emojiIcon = "fas fa-heart",
            particleColors = {"#FF0000", "#FF1493", "#FF69B4", "#C71585"},
			sound = "love.mp3",
        }
    },
    {
        animnametext = "Angry",
        animationid = "mood_angry",
        coupleanim = "mood_angry",
        animimg = "angry.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_angry_1", 
            emojiType = "burst",
            emojiIcon = "fas fa-angry",
            particleColors = {"#F44336"},
			sound = "agresif.mp3",
        }
    },
    {
        animnametext = "Sad",
        animationid = "mood_sad",
        coupleanim = "mood_sad",
        animimg = "sad.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_sad_1",
            emojiType = "burst",
            emojiIcon = "fas fa-sad-tear",
            particleColors = {"#808080"},
			sound = "sad.mp3",
        }
    },
    {
        animnametext = "Shocked",
        animationid = "mood_shocked",
        coupleanim = "mood_shocked",
        animimg = "shocked.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "shocked_1", 
            emojiType = "burst",
            emojiIcon = "fas fa-surprise",
            particleColors = {"#FFFFFF"},
			sound = "shock.mp3",
        }
    },
    {
        animnametext = "Stressed",
        animationid = "mood_stressed",
        coupleanim = "mood_stressed",
        animimg = "stressed.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_stressed_1",
            emojiType = "burst",
            emojiIcon = "fas fa-flushed",
            particleColors = {"#FF0000"},
			sound = "stres.mp3",
        }
    },
    {
        animnametext = "Smug",
        animationid = "mood_smug",
        coupleanim = "mood_smug",
        animimg = "smug.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_smug_1",
            emojiType = "burst",
            emojiIcon = "fas fa-laugh-wink",
            particleColors = {"#7CFC00"},
			sound = "stres.mp3",
        }
    },
    {
        animnametext = "Drunk",
        animationid = "mood_drunk",
        coupleanim = "mood_drunk",
        animimg = "drunk.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_drunk_1",
            emojiType = "burst",
            emojiIcon = "fas fa-beer",
            particleColors = {"#FFD700", "#DAA520", "#F0E68C", "#B8860B"},
			sound = "drunk.mp3",
        }
    },
    {
        animnametext = "Serious",
        animationid = "mood_serious",
        coupleanim = "mood_serious",
        animimg = "serious.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_aiming_1",
            emojiType = "burst",
            emojiIcon = "fas fa-meh",
            particleColors = {"#ffffff"},
			sound = "serius.mp3",
        }
    },
    {
        animnametext = "Injured",
        animationid = "mood_injured",
        coupleanim = "mood_injured",
        animimg = "injured.webp",
        animcoupletype = "Solo",
        isExpression = true,
        expressionData = {
            facialAnim = "mood_injured_1",
            emojiType = "burst",
            emojiIcon = "fas fa-dizzy",
            particleColors = {"#8B0000"},
			sound = "injured.mp3",
        }
    },
{
    animimg = "shower.webp", -- Buna uygun bir resim koyarsın
    animname = "male_shower_idle_d",
    animdictionary = "mp_safehouseshower@male@",
    animnametext = "Together Shower",
    animationid = "Showerm",
animmeta = {
    animxcoord = 0.0, -- Sağa sola kayma yok
    animycoord = 1.2, -- 0.9 yerine 1.2 yaparsan araları daha çok açılır
    animzcoord = 0.0,
    animxrotation = 0.0,
    animyrotation = 180.0, -- Yüz yüze bakması için 180.0 idealdir (seninkinde 500 yazıyordu, 180 yapmalısın)
    animzrotation = 0.0,
    animloop = true,
    animglue = false
},
    coupleanim = "Showerf",
    animgender = "male",
    animisadult = true, -- +18 ikonu çıksın istersen
    animcoupletype = "Paired",
    animspecial = true -- Özel işlev (Yıldız ikonu için)
  },
  {
    animimg = "shower.webp",
    animname = "male_shower_idle_d", -- Kadın için de aynısını veya uygun bir idle kullanabilirsin
    animdictionary = "mp_safehouseshower@male@",
    animnametext = "Shower Together",
    animationid = "Showerf",
animmeta = {
    animxcoord = 0.0, -- Sağa sola kayma yok
    animycoord = 1.2, -- 0.9 yerine 1.2 yaparsan araları daha çok açılır
    animzcoord = 0.0,
    animxrotation = 0.0,
    animyrotation = 180.0, -- Yüz yüze bakması için 180.0 idealdir (seninkinde 500 yazıyordu, 180 yapmalısın)
    animzrotation = 0.0,
    animloop = true,
    animglue = false
},
    coupleanim = "Showerm",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired",
    animspecial = true
  },
  {
    animimg = "sleep.webp",
    animname = "idle_b",
    animdictionary = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig3_sleep_p1",
    animnametext = "Sleep",
    animtype = "erp",
    animationid = "Sleepm",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "Sleepf",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired",
	animspecial = true
  },
  {
    animimg = "sleep.webp",
    animname = "idle_d",
    animdictionary = "anim@scripted@submarine@special_peds@pavel@hs4_pavel_ig3_sleep_p1",
    animnametext = "Receiving Sleep",
    animtype = "erp",
    animationid = "Sleepf",
animmeta = {
            animxcoord = -0.7,
            animycoord = 0.1,
            animzcoord = -0.1,
            animloop = true,
            animmovement = false,
            animboneindex = 0.0,
            animxrotation = 100.0,
            animyrotation = -710.0,
            animzrotation = 290.0,
            animglue = true
        },
    coupleanim = "Sleepm",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired",
	animspecial = true
  },  
  {
    animimg = "kissinglv2f.webp",
    animname = "couple54_clip",
    animdictionary = "chocoholic@couple54",
    animnametext = "Passionate Kiss",
    animtype = "erp",
    animationid = "kissinglv2m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kissinglv2f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm3.webp",
    animname = "doggystylem",
    animdictionary = "genesismods@erotica_doggystylem",
    animnametext = "From Behind Male",
    animtype = "erp",
    animationid = "sexm3",
    animmeta = {
      animxcoord = -0.35,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sexw3",
    recordHeadingOffset = 90,
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm3.webp",
    animname = "doggystylef",
    animdictionary = "genesismods@erotica_doggystylef",
    animnametext = "Receiving From Behind Female",
    animtype = "erp",
    animationid = "sexw3",
    animmeta = {
      animxcoord = 0.3,
      animycoord = 0.0,
      animzcoord = 0.1,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = false
    },
    coupleanim = "sexm3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couplewed2b.webp",
    animname = "wedding2a",
    animdictionary = "EnchantedBrwny@wedding2a",
    animnametext = "Wedding Vows",
    animtype = "erp",
    animationid = "couplewed2b",
    animmeta = {
      animxcoord = 0.01,
      animycoord = 0.25,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -88.9,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couplewed2a",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple28.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_3_m",
    animnametext = "Sweet Nothings",
    animtype = "erp",
    animationid = "couple27",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple28",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "followb.webp",
    animname = "follow_me_001",
    animdictionary = "dollie_mods@follow_me_001",
    animnametext = "Follow Me (Lead)",
    animtype = "erp",
    animationid = "followa",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "followb",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "holdmed.webp",
    animname = "mx_couple5_2_b_clip",
    animdictionary = "mx_couple5_2_b",
    animnametext = "Being Held Close",
    animtype = "erp",
    animationid = "holdmed",
    animmeta = {
      animxcoord = -0.12,
      animycoord = 0.36,
      animzcoord = -0.01,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -180,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "holdmec",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitloverockf.webp",
    animname = "couple45_clip",
    animdictionary = "chocoholic@couple45",
    animnametext = "Rocking Embrace",
    animtype = "erp",
    animationid = "sitloverockf",
    animmeta = {
      animxcoord = 0.17,
      animycoord = 0.35,
      animzcoord = 0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 30,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sitloverockm",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "footlovepose3f.webp",
    animname = "schoko3_clip",
    animdictionary = "schoko3@sharror",
    animnametext = "Tender Foot Kiss",
    animtype = "erp",
    animationid = "footlovepose3m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "footlovepose3f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose5_clip",
    animdictionary = "sexpose5@seimen",
    animnametext = "Seductive Stance",
    animtype = "erp",
    animationid = "newpose7",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose7.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "026anim.webp",
    animname = "feetplay009",
    animdictionary = "littlespoon@feetplay009",
    animnametext = "Playful Feet",
    animtype = "erp",
    animationid = "026anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "027anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko8_clip",
    animdictionary = "aiko8@seimen",
    animnametext = "Confident Pose",
    animtype = "erp",
    animationid = "newpose24",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose24.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "021anim.webp",
    animname = "feetplay004",
    animdictionary = "littlespoon@feetplay004",
    animnametext = "Admiring Feet",
    animtype = "erp",
    animationid = "021anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.9,
      animyrotation = 0.0,
      animxrotation = 0
    },
    coupleanim = "020anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitlovepose8f.webp",
    animname = "couplebench_m_clip",
    animdictionary = "couplebench_m@gengaranimation",
    animnametext = "Bench Cuddle",
    animtype = "erp",
    animationid = "sitlovepose8m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitlovepose8f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "liftme2.webp",
    animname = "couplepose1pack1anim2_clip",
    animdictionary = "couplepose1pack1anim2@animation",
    animnametext = "Uplifting Love",
    animtype = "erp",
    animationid = "liftme",
    animmeta = {
      animloop = true
    },
    coupleanim = "liftme2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss19.webp",
    animname = "kissmale10",
    animdictionary = "genesismods_kissme@kissmale10",
    animnametext = "Deep Kiss",
    animtype = "erp",
    animationid = "kiss19",
    animmeta = {
      animxcoord = 0.38,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kiss20",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple8.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@sea_love_together_female",
    animnametext = "Seaside Romance",
    animtype = "erp",
    animationid = "couple8",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.8,
      animzcoord = 0.73,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple7",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "carry3.webp",
    animname = "fin_c2_mcs_1_camman",
    animdictionary = "missfinale_c2mcs_1",
    animnametext = "Hero's Carry",
    animtype = "erp",
    animationid = "carry2",
    animmeta = {
      animmovement = true,
      animloop = true
    },
    coupleanim = "carry3",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "hugtip2.webp",
    animname = "friendship008",
    animdictionary = "littlespoon@friendship008",
    animnametext = "Tiptoe Hug",
    animtype = "erp",
    animationid = "hugtip2",
    animmeta = {
      animxcoord = 0.01,
      animycoord = 0.27,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 10,
      animyrotation = -180,
      animxrotation = -180,
      animglue = true
    },
    coupleanim = "hugtip",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose9f.webp",
    animname = "f_couple_04_clip",
    animdictionary = "anim@female_couple_04",
    animnametext = "Selfie Love",
    animtype = "erp",
    animationid = "lovepose9f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.26,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      PropPlacement = {
        0.1,
        0.03,
        0,
        70,
        20,
        -180
      },
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true,
      Propanimboneindex = 28422,
      Prop = "prop_phone_ing_03"
    },
    coupleanim = "lovepose9m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple6.webp",
    animname = "mx@couplephone_m_clip",
    animdictionary = "mx@couplephone_m",
    animnametext = "Phone Together",
    animtype = "erp",
    animationid = "couple5",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple6",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple56.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_with_hand_touch_female01",
    animnametext = "Hand-touch Kiss",
    animtype = "erp",
    animationid = "couple56",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.55,
      animzcoord = -0.05,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple55",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple40.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@courtyard_love_m",
    animnametext = "Courtyard Romance",
    animtype = "erp",
    animationid = "couple39",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple40",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm6.webp",
    animname = "spooningm",
    animdictionary = "genesismods@erotica_spooningm",
    animnametext = "Spooning Male",
    animtype = "erp",
    animationid = "sexm6",
    animmeta = {
      animxcoord = -0.09,
      animycoord = -0.2,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sexw6",
    recordHeadingOffset = 90,
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm6.webp",
    animname = "spooningf",
    animdictionary = "genesismods@erotica_spooningf",
    animnametext = "Being Spooned Female",
    animtype = "erp",
    animationid = "sexw6",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sexm6",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "sexm5.webp",
    animname = "cowgirlm",
    animdictionary = "genesismods@erotica_cowgirlm",
    animnametext = "Cowgirl Ride",
    animtype = "erp",
    animationid = "sexm5",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.05,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sexw5",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "carrymecute2.webp",
    animname = "amnilka_couple_mal_002",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Cute Carry",
    animtype = "erp",
    animationid = "carrymecute",
    animmeta = {
      animmovement = true,
      animloop = true
    },
    coupleanim = "carrymecute2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple16.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@coffee_togetherness_male",
    animnametext = "Coffee Together",
    animtype = "erp",
    animationid = "couple15",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple16",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "69m.webp",
    animname = "69m",
    animdictionary = "genesismods@oralfixation_69m",
    animnametext = "Sixty-Nine",
    animtype = "erp",
    animationid = "69m",
    animmeta = {
      animxcoord = 0.51,
      animycoord = -0.02,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "69f",
    recordHeadingOffset = -90,
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko4_clip",
    animdictionary = "aiko4@seimen",
    animnametext = "Elegant Pose",
    animtype = "erp",
    animationid = "newpose20",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose20.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "couple100.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_in_wet_element_male",
    animnametext = "Kiss in the Rain",
    animtype = "erp",
    animationid = "couple99",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple100",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple32.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@affectionate_kiss_f",
    animnametext = "Affectionate Kiss",
    animtype = "erp",
    animationid = "couple32",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.3,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 10,
      animyrotation = 0.0,
      animxrotation = -5,
      animglue = true
    },
    coupleanim = "couple31",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couplewed2b.webp",
    animname = "wedding2b",
    animdictionary = "EnchantedBrwny@wedding2b",
    animnametext = "Bridal Carry",
    animtype = "erp",
    animationid = "couplewed2a",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couplewed2b",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lanisha3.webp",
    animname = "dog4_clip",
    animdictionary = "doggy4@lanisha",
    animnametext = "Against the Wall Female",
    animtype = "erp",
    animationid = "056anim",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lanisha3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose6_clip",
    animdictionary = "sexpose6@seimen",
    animnametext = "Alluring Pose",
    animtype = "erp",
    animationid = "newpose8",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose8.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "sitchairlove3f.webp",
    animname = "couple48_v3_clip",
    animdictionary = "chocoholic@couple48_v3",
    animnametext = "Chair Embrace",
    animtype = "erp",
    animationid = "sitchairlove3f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.85,
      animzcoord = 0.3,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = -5,
      animglue = true
    },
    coupleanim = "sitchairlove3m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose10f.webp",
    animname = "f_couple_05_clip",
    animdictionary = "anim@female_couple_05",
    animnametext = "Relaxed Selfie",
    animtype = "erp",
    animationid = "lovepose10f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = -0.3,
      animloop = true,
      animmovement = false,
      PropPlacement = {
        0.08,
        0.019,
        0.03,
        30,
        98,
        -160
      },
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = -90,
      animglue = true,
      Propanimboneindex = 60309,
      Prop = "prop_phone_ing_03"
    },
    coupleanim = "lovepose10m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose4_clip",
    animdictionary = "sexpose4@seimen",
    animnametext = "Sensual Pose",
    animtype = "erp",
    animationid = "newpose6",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose6.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "walklove1f.webp",
    animname = "couple49_clip",
    animdictionary = "chocoholic@couple49",
    animnametext = "Lovers Stroll",
    animtype = "erp",
    animationid = "walklove1f",
    animmeta = {
      animxcoord = -0.34,
      animycoord = -0.19,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 5,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "walklove1m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "carry5.webp",
    animname = "base",
    animdictionary = "amb@code_human_in_car_idles@generic@ps@base",
    animnametext = "Carried Away",
    animtype = "erp",
    animationid = "carry5",
    animmeta = {
      animxcoord = 0.35,
      animycoord = 0.15,
      animzcoord = -0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 28252,
      animzrotation = 22.5,
      animyrotation = -22.5,
      animxrotation = -42.5,
      animglue = true
    },
    coupleanim = "carry4",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lanisha3.webp",
    animname = "arrestedstand_clip",
    animdictionary = "anim@arrestedstand",
    animnametext = "Against the Wall",
    animtype = "erp",
    animationid = "lanisha3",
    animmeta = {
      animxcoord = 0.0,
      animycoord = -0.3,
      animzcoord = 0.08,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "056anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple78.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@playful_duo_poses",
    animnametext = "Playful Duo",
    animtype = "erp",
    animationid = "couple77",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple78",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose4f.webp",
    animname = "m_couple_02_clip",
    animdictionary = "anim@male_couple_02",
    animnametext = "Intimate Gaze",
    animtype = "erp",
    animationid = "lovepose4m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose4f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "liftme6.webp",
    animname = "couplepose3pack1anim1_clip",
    animdictionary = "couplepose3pack1anim1@animation",
    animnametext = "Joyful Lift",
    animtype = "erp",
    animationid = "liftme6",
    animmeta = {
      animxcoord = -0.212,
      animycoord = -0.54,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "liftme5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "hotsitf2.webp",
    animname = "mx@couple2_b_clip",
    animdictionary = "mx@couple2_b",
    animnametext = "Hot Lap Sit",
    animtype = "erp",
    animationid = "hotsitf2",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.55,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "hotsitm2",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple6.webp",
    animname = "mx@couplephone_f_clip",
    animdictionary = "mx@couplephone_f",
    animnametext = "Sharing a Moment",
    animtype = "erp",
    animationid = "couple6",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.3,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple26.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_2_f",
    animnametext = "Back Hug",
    animtype = "erp",
    animationid = "couple26",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.37,
      animzcoord = 0.37,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = -5,
      animglue = true
    },
    coupleanim = "couple25",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "pback2.webp",
    animname = "mxanim_b",
    animdictionary = "mx@piggypack_b",
    animnametext = "Piggyback Ride",
    animtype = "erp",
    animationid = "pback2",
    animmeta = {
      animxcoord = 0.02,
      animycoord = -0.4399,
      animzcoord = 0.42,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "pback",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "abc5.webp",
    animname = "pronework_clip",
    animdictionary = "pronework@lanisha1",
    animnametext = "Prone Passion",
    animtype = "erp",
    animationid = "abc4",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "abc5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose15_clip",
    animdictionary = "sexpose15@seimen",
    animnametext = "Striking Pose",
    animtype = "erp",
    animationid = "newpose11",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose11.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "bffb.webp",
    animname = "m_couple_03_b_clip",
    animdictionary = "anim@male_couple_03_b",
    animnametext = "Best Friends Forever",
    animtype = "erp",
    animationid = "bff",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "bffb",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple88.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@golden_hour_of_love_f",
    animnametext = "Golden Hour Love",
    animtype = "erp",
    animationid = "couple88",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.5,
      animzcoord = 0.5,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple87",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "2lanisha3.webp",
    animname = "lanisha_clip",
    animdictionary = "lanisha@animation",
    animnametext = "Quickie",
    animtype = "erp",
    animationid = "lanisha5",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "2lanisha3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple90.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@hitchhiking_for_love_female",
    animnametext = "Hitchhiking for Love",
    animtype = "erp",
    animationid = "couple90",
    animmeta = {
      animxcoord = 0.0,
      animycoord = -0.1,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple89",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitlovepose7f.webp",
    animname = "couplem4_clip",
    animdictionary = "couplem4@spider",
    animnametext = "Spider Sit",
    animtype = "erp",
    animationid = "sitlovepose7m",
    animmeta = {
      animmovement = false,
      animboneindex = 0,
      animzcoord = -5,
      animloop = true
    },
    coupleanim = "sitlovepose7f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple60.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_12_f",
    animnametext = "Side by Side",
    animtype = "erp",
    animationid = "couple60",
    animmeta = {
      animxcoord = -0.4,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple59",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple59.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_12_m",
    animnametext = "Side by Side",
    animtype = "erp",
    animationid = "couple59",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple60",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animname = "trev_jerking_off_loop",
    animdictionary = "switch@trevor@jerking_off",
    animnametext = "Self Pleasure",
    animtype = "erp",
    animationid = "jerkf",
    animmeta = {
      Prop = "prop_cs_dildo_01",
      animmovement = true,
      animloop = true,
      Propanimboneindex = 28422,
      PropPlacement = {
        0.09,
        0.05,
        -0.03,
        90,
        80,
        30
      }
    },
    animimg = "jerkf.webp",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "couple76.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@friendships_that_last_forever_01",
    animnametext = "Lasting Friendship",
    animtype = "erp",
    animationid = "couple75",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple76",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple44.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@cuddly_kiss_m",
    animnametext = "Cuddly Kiss",
    animtype = "erp",
    animationid = "couple43",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple44",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "019anim.webp",
    animname = "feetplay002",
    animdictionary = "littlespoon@feetplay002",
    animnametext = "Feet Play",
    animtype = "erp",
    animationid = "019anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.9,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = false
    },
    coupleanim = "018anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "018anim.webp",
    animname = "feetplay001",
    animdictionary = "littlespoon@feetplay001",
    animnametext = "Foot Worship",
    animtype = "erp",
    animationid = "018anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.8,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "019anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko1_clip",
    animdictionary = "aiko1@seimen",
    animnametext = "Charming Pose",
    animtype = "erp",
    animationid = "newpose17",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose17.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "abc5.webp",
    animname = "pipe_clip",
    animdictionary = "pipedown@lanisha2",
    animnametext = "Laying Down",
    animtype = "erp",
    animationid = "abc5",
    animmeta = {
      animxcoord = 0.0,
      animycoord = -0.04,
      animzcoord = 1.21,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 1,
      animglue = true
    },
    coupleanim = "abc4",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple72.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@beach_female02",
    animnametext = "Beach Day",
    animtype = "erp",
    animationid = "couple72",
    animmeta = {
      animxcoord = 0.5,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple71",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "054anim.webp",
    animname = "intimacy013",
    animdictionary = "littlespoon@intimacy013",
    animnametext = "On Top Female",
    animtype = "erp",
    animationid = "054anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.2,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0
    },
    coupleanim = "055anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss6.webp",
    animname = "tigerle_couple_kissing1a",
    animdictionary = "tigerle@custom@couple@kissing1a",
    animnametext = "First Kiss",
    animtype = "erp",
    animationid = "kiss5",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kiss6",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple10.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@river_romance_female",
    animnametext = "River Romance",
    animtype = "erp",
    animationid = "couple10",
    animmeta = {
      animxcoord = 0.3,
      animycoord = 0.5,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 90,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple9",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko2_clip",
    animdictionary = "aiko2@seimen",
    animnametext = "Shy Pose",
    animtype = "erp",
    animationid = "newpose18",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose18.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "055anim.webp",
    animname = "intimacy012",
    animdictionary = "littlespoon@intimacy012",
    animnametext = "On Top",
    animtype = "erp",
    animationid = "055anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "054anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose23_clip",
    animdictionary = "sexpose23@seimen",
    animnametext = "Relaxed Pose",
    animtype = "erp",
    animationid = "newpose16",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose16.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "sitlovepose6f.webp",
    animname = "schoko8_clip",
    animdictionary = "schoko8@sharror",
    animnametext = "Sitting Close",
    animtype = "erp",
    animationid = "sitlovepose6f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.7,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = -7,
      animglue = true
    },
    coupleanim = "sitlovepose6m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko5_clip",
    animdictionary = "aiko5@seimen",
    animnametext = "Playful Pose",
    animtype = "erp",
    animationid = "newpose21",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose21.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "couple44.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@cuddly_kiss_f",
    animnametext = "Receiving Cuddly Kiss",
    animtype = "erp",
    animationid = "couple44",
    animmeta = {
      animxcoord = 0.05,
      animycoord = 0.1,
      animzcoord = -0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = -15,
      animglue = true
    },
    coupleanim = "couple43",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "oral5.webp",
    animname = "deepthroatf",
    animdictionary = "genesismods@oralfixation_deepthroatf",
    animnametext = "Penetrate Her Throat",
    animtype = "erp",
    animationid = "oral6",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "oral5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "oral5.webp",
    animname = "deepthroatm",
    animdictionary = "genesismods@oralfixation_deepthroatm",
    animnametext = "Deep Throat",
    animtype = "erp",
    animationid = "oral5",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.55,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "oral6",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko9_clip",
    animdictionary = "aiko9@seimen",
    animnametext = "Thinking Pose",
    animtype = "erp",
    animationid = "newpose25",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose25.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "oral7.webp",
    animname = "lickingm",
    animdictionary = "genesismods@oralfixation_lickingm",
    animnametext = "Pussy Licking",
    animtype = "erp",
    animationid = "oral7",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.8,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "oral8",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "050anim.webp",
    animname = "intimacy009",
    animdictionary = "littlespoon@intimacy009",
    animnametext = "Giving Oral BlowJob",
    animtype = "erp",
    animationid = "050anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0
    },
    coupleanim = "051anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },   
   {
    animimg = "oral3.webp",
    animname = "blowjobf",
    animdictionary = "genesismods@oralfixation_blowjobf",
    animnametext = "Blowjob 2",
    animtype = "erp",
    animationid = "oral4",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "oral3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "oral3.webp",
    animname = "blowjobm",
    animdictionary = "genesismods@oralfixation_blowjobm",
    animnametext = "Blowjob 2",
    animtype = "erp",
    animationid = "oral3",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.62,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "oral4",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },     
{
    animimg = "051anim.webp",
    animname = "intimacy008",
    animdictionary = "littlespoon@intimacy008",
    animnametext = "Receiving Oral BlowJob",
    animtype = "erp",
    animationid = "051anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.8,
      animzcoord = 0.05,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "050anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "footlovepose3f.webp",
    animname = "schoko4_clip",
    animdictionary = "schoko4@sharror",
    animnametext = "Foot Adoration",
    animtype = "erp",
    animationid = "footlovepose3f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.85,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "footlovepose3m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lspintimacy005.webp",
    animname = "intimacy005",
    animdictionary = "littlespoon@intimacy005",
    animnametext = "Toot That Up",
    animtype = "erp",
    animationid = "lspintimacy005",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.8,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lspintimacy003",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitwithmepose2.webp",
    animname = "amnilka_couple_mal_003",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Sit With Me",
    animtype = "erp",
    animationid = "sitwithmepose",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitwithmepose2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "049anim.webp",
    animname = "servethequeen010",
    animdictionary = "littlespoon@servethequeen010",
    animnametext = "Eat Me Out",
    animtype = "erp",
    animationid = "048anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 1.0,
      animzcoord = 0.1,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = false
    },
    coupleanim = "049anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "hugpose2.webp",
    animname = "amnilka_couple_fem_001",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Come Here Hug",
    animtype = "erp",
    animationid = "hugpose2",
    animmeta = {
      animxcoord = 0.14,
      animycoord = 0.25,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "hugpose",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple50.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@honest_kiss_female",
    animnametext = "Honest Kiss",
    animtype = "erp",
    animationid = "couple50",
    animmeta = {
      animxcoord = 0.1,
      animycoord = 0.33,
      animzcoord = -0.2,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple49",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko3_clip",
    animdictionary = "aiko3@seimen",
    animnametext = "Cute Pose",
    animtype = "erp",
    animationid = "newpose19",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose19.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "liftme4.webp",
    animname = "couplepose2pack1anim1_clip",
    animdictionary = "couplepose2pack1anim1@animation",
    animnametext = "Lift and Hold",
    animtype = "erp",
    animationid = "liftme4",
    animmeta = {
      animxcoord = 0.01,
      animycoord = 0.48,
      animzcoord = 0.53,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "liftme3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose18f.webp",
    animname = "mx@couple4.2_a_clip",
    animdictionary = "mx@couple4.2_a",
    animnametext = "Shoulder Lean",
    animtype = "erp",
    animationid = "lovepose18m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose18f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple14.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@carrying_woman_male",
    animnametext = "Carrying Her",
    animtype = "erp",
    animationid = "couple13",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple14",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose8f.webp",
    animname = "f_couple_03_b_clip",
    animdictionary = "anim@female_couple_03_b",
    animnametext = "Close Embrace",
    animtype = "erp",
    animationid = "lovepose8f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.13,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 95,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose8m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose8f.webp",
    animname = "m_couple_03_b_clip",
    animdictionary = "anim@male_couple_03_b",
    animnametext = "Love Pose 8 Male",
    animtype = "erp",
    animationid = "lovepose8m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose8f"
  },
{
    animimg = "couple86.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@field_kiss_romance_f",
    animnametext = "New Couple 86",
    animtype = "erp",
    animationid = "couple86",
    animmeta = {
      animxcoord = -0.4,
      animycoord = 0.1,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animxrotation = 0.0,
      animyrotation = 0.0,
      animzrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple85",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple86.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@field_kiss_romance_m",
    animnametext = "Field Kiss",
    animtype = "erp",
    animationid = "couple85",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple86",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kissinglvpose2f.webp",
    animname = "wand_pose_02_clip",
    animdictionary = "wand_pose_02@sharror",
    animnametext = "Wall Kiss",
    animtype = "erp",
    animationid = "kissinglvpose2f",
    animmeta = {
      animxcoord = -0.14,
      animycoord = -0.2,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kissinglvpose2m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose19_clip",
    animdictionary = "sexpose19@seimen",
    animnametext = "Tempting Pose",
    animtype = "erp",
    animationid = "newpose13",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose13.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
{
    animimg = "cutepicpose.webp",
    animname = "amnilka_couple_mal_004",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Cute Picture Male",
    animtype = "erp",
    animationid = "cutepicpose",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "cutepicpose2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "cutepicpose2.webp",
    animname = "amnilka_couple_fem_004",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Cute Picture",
    animtype = "erp",
    animationid = "cutepicpose2",
    animmeta = {
      animxcoord = 0.27,
      animycoord = 0.12,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "cutepicpose",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple102.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kisses_at_dusk_f",
    animnametext = "Dusk Kisses",
    animtype = "erp",
    animationid = "couple102",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.42,
      animzcoord = -0.52,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple101",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm7.webp",
    animname = "standingcowgirlf",
    animdictionary = "genesismods@erotica_standingcowgirlf",
    animnametext = "Standing Cowgirl Female",
    animtype = "erp",
    animationid = "sexw7",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sexm7",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple4.webp",
    animname = "mx@couple3_b_clip",
    animdictionary = "mx@couple3_b",
    animnametext = "Intimate Moment",
    animtype = "erp",
    animationid = "couple4",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.7,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple4.webp",
    animname = "mx@couple3_a_clip",
    animdictionary = "mx@couple3_a",
    animnametext = "New Couple 3",
    animtype = "erp",
    animationid = "couple3",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple4"
  },
  {
    animimg = "lovewalkpose3f.webp",
    animname = "couple58_clip",
    animdictionary = "chocoholic@couple58",
    animnametext = "Walking Together",
    animtype = "erp",
    animationid = "lovewalkpose3f",
    animmeta = {
      animxcoord = -0.98,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovewalkpose3m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose18_clip",
    animdictionary = "sexpose18@seimen",
    animnametext = "Confident Look",
    animtype = "erp",
    animationid = "newpose12",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose12.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "couple61.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_13_m",
    animnametext = "Leaning In",
    animtype = "erp",
    animationid = "couple61",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple62",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "holdmeb.webp",
    animname = "mx_couple5_1_a_clip",
    animdictionary = "mx_couple5_1_a",
    animnametext = "Hold Me Tight",
    animtype = "erp",
    animationid = "holdme",
    animmeta = {
      animloop = true
    },
    coupleanim = "holdmeb",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "bffb.webp",
    animname = "f_couple_03_b_clip",
    animdictionary = "anim@female_couple_03_b",
    animnametext = "Friends Embrace",
    animtype = "erp",
    animationid = "bffb",
    animmeta = {
      animxcoord = 0.01,
      animycoord = 0.13,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 76,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "bff",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose17f.webp",
    animname = "mx@pack4.1_b_clip",
    animdictionary = "mx@pack4.1_b",
    animnametext = "Warmth",
    animtype = "erp",
    animationid = "lovepose17f",
    animmeta = {
      animxcoord = 0.52,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose17m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple76.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@friendships_that_last_forever_02",
    animnametext = "Forever Friends",
    animtype = "erp",
    animationid = "couple76",
    animmeta = {
      animxcoord = -0.15,
      animycoord = 0.85,
      animzcoord = 0.45,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = -30,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple75",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "cuddleet6.webp",
    animname = "tigerle_couple_standcuddle_b",
    animdictionary = "tigerle@custom@couple@standcuddle_b",
    animnametext = "Standing Cuddle",
    animtype = "erp",
    animationid = "cuddleet6",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.35,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "cuddleet5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose9m.webp",
    animname = "m_couple_04_clip",
    animdictionary = "anim@male_couple_04",
    animnametext = "Holding Her",
    animtype = "erp",
    animationid = "lovepose9m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose9f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple30.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_5_f",
    animnametext = "Sweet Embrace",
    animtype = "erp",
    animationid = "couple30",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.23,
      animzcoord = -0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 5,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple29",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple30.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_5_m",
    animnametext = "New Couple 29",
    animtype = "erp",
    animationid = "couple29",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple30"
  },
  {
    animimg = "lovepose21f.webp",
    animname = "mx@couple4.5_b_clip",
    animdictionary = "mx@couple4.5_b",
    animnametext = "Resting Head",
    animtype = "erp",
    animationid = "lovepose21f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.3,
      animzcoord = 0.16,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose21m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple93.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@heart_warmth_m",
    animnametext = "Heartfelt Warmth Male",
    animtype = "erp",
    animationid = "couple93",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple94",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple94.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@heart_warmth_f",
    animnametext = "Heartfelt Warmth Female",
    animtype = "erp",
    animationid = "couple94",
    animmeta = {
      animxcoord = 0.3,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 60,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple93",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "3lanisha3.webp",
    animname = "friendship007",
    animdictionary = "littlespoon@friendship007",
    animnametext = "Booty Work",
    animtype = "erp",
    animationid = "3lanisha3",
    animmeta = {
      animxcoord = 0.0,
      SyncOffsetHeading = 0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true,
      animycoord = -0.28
    },
    coupleanim = "lanisha6",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple18.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@devoted_kiss_male",
    animnametext = "Devoted Kiss",
    animtype = "erp",
    animationid = "couple17",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple18",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple18.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@devoted_kiss_female",
    animnametext = "New Couple 18",
    animtype = "erp",
    animationid = "couple18",
    animmeta = {
      animxcoord = 0.05,
      animycoord = 0.35,
      animzcoord = -0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple17"
  },  
{
    animimg = "couple35.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@bench_idyll_for_two_m",
    animnametext = "Bench Idyll Male",
    animtype = "erp",
    animationid = "couple35",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple36",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple36.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@bench_idyll_for_two_f",
    animnametext = "Bench Idyll Female",
    animtype = "erp",
    animationid = "couple36",
    animmeta = {
      animxcoord = -0.6,
      animycoord = 0.75,
      animzcoord = -0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple35",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "2lanisha3.webp",
    animname = "friendship007",
    animdictionary = "littlespoon@friendship007",
    animnametext = "Lap Dance",
    animtype = "erp",
    animationid = "2lanisha3",
    animmeta = {
      animxcoord = 0.0,
      animycoord = -0.28,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lanisha5",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple24.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_1_f",
    animnametext = "Holding Tight",
    animtype = "erp",
    animationid = "couple24",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.3,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple23",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple12.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@romantic_rooftop_couple_male",
    animnametext = "Rooftop Romance Male",
    animtype = "erp",
    animationid = "couple11",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple12",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple12.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@romantic_rooftop_couple_female",
    animnametext = "Rooftop Romance",
    animtype = "erp",
    animationid = "couple12",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 1.1,
      animzcoord = -0.3,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple11",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "holdmeb.webp",
    animname = "mx_couple5_1_b_clip",
    animdictionary = "mx_couple5_1_b",
    animnametext = "Being Held",
    animtype = "erp",
    animationid = "holdmeb",
    animmeta = {
      animxcoord = -0.02,
      animycoord = 0.24,
      animzcoord = -0.01,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "holdme",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "liftme6.webp",
    animname = "couplepose3pack1anim2_clip",
    animdictionary = "couplepose3pack1anim2@animation",
    animnametext = "Lifting Her",
    animtype = "erp",
    animationid = "liftme5",
    animmeta = {
      animloop = true
    },
    coupleanim = "liftme6",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose13f.webp",
    animname = "fm_couple2_f_clip",
    animdictionary = "myu@fm_couple2_1",
    animnametext = "Romantic Lean",
    animtype = "erp",
    animationid = "lovepose13f",
    animmeta = {
      animxcoord = 0.56,
      animycoord = 0.1,
      animzcoord = -0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 95,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose13m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple99.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_in_wet_element_female",
    animnametext = "Wet Kiss",
    animtype = "erp",
    animationid = "couple100",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.37,
      animzcoord = -0.08,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple99",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "aiko6_clip",
    animdictionary = "aiko6@seimen",
    animnametext = "Graceful Pose",
    animtype = "erp",
    animationid = "newpose22",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose22.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "lovepose14f.webp",
    animname = "m_engagement_clip",
    animdictionary = "m_engagement@d3vilros3",
    animnametext = "Proposal",
    animtype = "erp",
    animationid = "lovepose14m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose14f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose14f.webp",
    animname = "f_engagement_clip",
    animdictionary = "f_engagement@d3vilros3",
    animnametext = "Love Pose 14 Female",
    animtype = "erp",
    animationid = "lovepose14f",
    animmeta = {
      animxcoord = -0.1,
      animycoord = 0.32,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 189.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose14m"
  },
  {
    animimg = "couple10.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@river_romance_male",
    animnametext = "By the River",
    animtype = "erp",
    animationid = "couple9",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple10",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple79.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@together_piggyback",
    animnametext = "Piggyback Fun Male",
    animtype = "erp",
    animationid = "couple79",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple80",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple80.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@together_piggyback01",
    animnametext = "Piggyback Fun",
    animtype = "erp",
    animationid = "couple80",
    animmeta = {
      animxcoord = 0.0,
      animycoord = -0.5,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 10,
      animglue = true
    },
    coupleanim = "couple79",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple95.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@intimate_breast_caress_m",
    animnametext = "Intimate Caress male",
    animtype = "erp",
    animationid = "couple95",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple96",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple96.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@intimate_breast_caress_f",
    animnametext = "Intimate Caress",
    animtype = "erp",
    animationid = "couple96",
    animmeta = {
      animxcoord = 0.25,
      animycoord = 0.4,
      animzcoord = -0.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 90,
      animglue = true
    },
    coupleanim = "couple95",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple102.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kisses_at_dusk_m",
    animnametext = "Kissing at Dusk",
    animtype = "erp",
    animationid = "couple101",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple102",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple22.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@gentle_lip_union_male",
    animnametext = "Gentle Lip Union",
    animtype = "erp",
    animationid = "couple21",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple22",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose21f.webp",
    animname = "mx@couple4.5_a_clip",
    animdictionary = "mx@couple4.5_a",
    animnametext = "Comforting Embrace",
    animtype = "erp",
    animationid = "lovepose21m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose21f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple73.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@casual_composure_female01",
    animnametext = "Casual Composure Male",
    animtype = "erp",
    animationid = "couple73",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple74",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple74.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@casual_composure_female02",
    animnametext = "Casual Composure",
    animtype = "erp",
    animationid = "couple74",
    animmeta = {
      animxcoord = -0.25,
      animycoord = 0.2,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple73",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple34.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@beach_lovers_kisses_f",
    animnametext = "Beach Lovers Kiss",
    animtype = "erp",
    animationid = "couple34",
    animmeta = {
      animxcoord = -0.05,
      animycoord = 0.35,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = -10,
      animglue = true
    },
    coupleanim = "couple33",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple64.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_14_m",
    animnametext = "Hold and Kiss",
    animtype = "erp",
    animationid = "couple63",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple64",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple64.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_14_f",
    animnametext = "New Couple 64",
    animtype = "erp",
    animationid = "couple64",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.5,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animxrotation = 0.0,
      animyrotation = 0.0,
      animzrotation = 180.0,
      animglue = true
    },
    coupleanim = "couple63",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "bfff2.webp",
    animname = "tigerle_pose_bff1b",
    animdictionary = "tigerle@custom@pose@bff1b",
    animnametext = "Friendship Hug",
    animtype = "erp",
    animationid = "bfff2",
    animmeta = {
      animxcoord = 0.7,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "bfff",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple20.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@devoted_lip_touch_male",
    animnametext = "Devoted Lip Touch",
    animtype = "erp",
    animationid = "couple19",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple20",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose10_clip",
    animdictionary = "sexpose10@seimen",
    animnametext = "Ready Pose",
    animtype = "erp",
    animationid = "newpose10",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose10.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "couple26.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_2_m",
    animnametext = "Gentle Hold",
    animtype = "erp",
    animationid = "couple25",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple26",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose13f.webp",
    animname = "fm_couple2_m_clip",
    animdictionary = "myu@fm_couple2_2",
    animnametext = "Head on Shoulder",
    animtype = "erp",
    animationid = "lovepose13m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose13f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss6.webp",
    animname = "tigerle_couple_kissing1b",
    animdictionary = "tigerle@custom@couple@kissing1b",
    animnametext = "Receiving Kiss 6",
    animtype = "erp",
    animationid = "kiss6",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kiss5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple20.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@devoted_lip_touch_female",
    animnametext = "Caressing Face",
    animtype = "erp",
    animationid = "couple20",
    animmeta = {
      animxcoord = 0.0,
      animycoord = -0.3,
      animzcoord = 0.73,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple19",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple22.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@gentle_lip_union_female",
    animnametext = "Gentle Kiss Reception",
    animtype = "erp",
    animationid = "couple22",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.8,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple21",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple66.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_15_m",
    animnametext = "Sweet Surrender",
    animtype = "erp",
    animationid = "couple65",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple66",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitlovepose6f.webp",
    animname = "schoko7_clip",
    animdictionary = "schoko7@sharror",
    animnametext = "Lap Sit",
    animtype = "erp",
    animationid = "sitlovepose6m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitlovepose6f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "car_fancy_clip",
    animdictionary = "anim@model_car_fancy",
    animnametext = "Car Model Pose",
    animtype = "erp",
    animationid = "newpose1",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose1.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "kisslovpose1f.webp",
    animname = "couple52_clip",
    animdictionary = "chocoholic@couple52",
    animnametext = "Loving Kiss",
    animtype = "erp",
    animationid = "kisslovpose1f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.3,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kisslovpose1m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "022anim.webp",
    animname = "feetplay005",
    animdictionary = "littlespoon@feetplay005",
    animnametext = "Foot Tease",
    animtype = "erp",
    animationid = "022anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "023anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "oral7.webp",
    animname = "lickingf",
    animdictionary = "genesismods@oralfixation_lickingf",
    animnametext = "Receiving Pleasure",
    animtype = "erp",
    animationid = "oral8",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "oral7",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple14.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@carrying_woman_female",
    animnametext = "Being Carried",
    animtype = "erp",
    animationid = "couple14",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.2,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple13",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple54.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_with_hand_touch_female",
    animnametext = "Hand on Cheek Kiss",
    animtype = "erp",
    animationid = "couple54",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.55,
      animzcoord = -0.05,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple53",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple70.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_17_f",
    animnametext = "New Couple 70",
    animtype = "erp",
    animationid = "couple70",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 1.0,
      animzcoord = 0.8,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animxrotation = 0.0,
      animyrotation = 0.0,
      animzrotation = 180.0,
      animglue = true
    },
    coupleanim = "couple69",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couple70.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_17_m",
    animnametext = "Whisper Kiss",
    animtype = "erp",
    animationid = "couple69",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple70",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "023anim.webp",
    animname = "feetplay006",
    animdictionary = "littlespoon@feetplay006",
    animnametext = "Foot Massage",
    animtype = "erp",
    animationid = "023anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.9,
      animyrotation = 0.0,
      animxrotation = 0
    },
    coupleanim = "022anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "carrycmg2.webp",
    animname = "couplepose1cmg_clip",
    animdictionary = "couplepose1cmg@animation",
    animnametext = "Strong Carry",
    animtype = "erp",
    animationid = "carrycmg",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "carrycmg2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple66.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_15_f",
    animnametext = "Sweet Reception",
    animtype = "erp",
    animationid = "couple66",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.5,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple65",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple72.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@beach_female01",
    animnametext = "Beach Relaxation",
    animtype = "erp",
    animationid = "couple71",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple72",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "sexpose9_clip",
    animdictionary = "sexpose9@seimen",
    animnametext = "Come Hither",
    animtype = "erp",
    animationid = "newpose9",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose9.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "kiss15.webp",
    animname = "kissfemale8",
    animdictionary = "genesismods_kissme@kissfemale8",
    animnametext = "Passionate Reception",
    animtype = "erp",
    animationid = "kiss16",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kiss15",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "bfff2.webp",
    animname = "tigerle_pose_bff1a",
    animdictionary = "tigerle@custom@pose@bff1a",
    animnametext = "Best Friends Pose",
    animtype = "erp",
    animationid = "bfff",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "bfff2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple98.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_in_sunset_f",
    animnametext = "Sunset Kiss",
    animtype = "erp",
    animationid = "couple98",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.23,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple97",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple88.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@golden_hour_of_love_m",
    animnametext = "Golden Hour Embrace",
    animtype = "erp",
    animationid = "couple87",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple88",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple83.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@chair_and_foot_placement_m",
    animnametext = "Chair and Foot Play",
    animtype = "erp",
    animationid = "couple83",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple84",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple62.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_13_f",
    animnametext = "Leaning On You",
    animtype = "erp",
    animationid = "couple62",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.65,
      animzcoord = 0.8,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple61",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple16.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@coffee_togetherness_female",
    animnametext = "Sharing Coffee",
    animtype = "erp",
    animationid = "couple16",
    animmeta = {
      animxcoord = -0.25,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -90,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple15",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "wallocepose2f.webp",
    animname = "couple_wall_01_clip",
    animdictionary = "couple_wall_01@sharror",
    animnametext = "Against the Wall Kiss",
    animtype = "erp",
    animationid = "wallocepose2m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "wallocepose2f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "liftme4.webp",
    animname = "couplepose2pack1anim2_clip",
    animdictionary = "couplepose2pack1anim2@animation",
    animnametext = "Lift Up",
    animtype = "erp",
    animationid = "liftme3",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "liftme4",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple92.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@hug_of_joy_m",
    animnametext = "Hug of Joy",
    animtype = "erp",
    animationid = "couple91",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple92",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple98.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_in_sunset_m",
    animnametext = "Giving Sunset Kiss",
    animtype = "erp",
    animationid = "couple97",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple98",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovecrryf.webp",
    animname = "mx@couple4_a_clip",
    animdictionary = "mx@couple4_a",
    animnametext = "Love Carry",
    animtype = "erp",
    animationid = "lovecrrym",
    animmeta = {
      animmovement = true,
      animloop = true
    },
    coupleanim = "lovecrryf",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple28.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_3_f",
    animnametext = "Receiving Sweet Nothings",
    animtype = "erp",
    animationid = "couple28",
    animmeta = {
      animxcoord = -0.03,
      animycoord = 0.25,
      animzcoord = 0.42,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = -10,
      animglue = true
    },
    coupleanim = "couple27",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose22f.webp",
    animname = "couplefemale_leancar_clip",
    animdictionary = "couplefemale_leancar@joker",
    animnametext = "Car Lean",
    animtype = "erp",
    animationid = "lovepose22f",
    animmeta = {
      animxcoord = -0.2,
      animycoord = 0.32,
      animzcoord = 0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose22m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "shaka_clip",
    animdictionary = "anim@shaka_sit",
    animnametext = "Shaka Sit",
    animtype = "erp",
    animationid = "newpose3",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose3.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "sitwithmepose2.webp",
    animname = "amnilka_couple_fem_003",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Please Sit With Me",
    animtype = "erp",
    animationid = "sitwithmepose2",
    animmeta = {
      animxcoord = 0.354,
      animycoord = 0.511,
      animzcoord = 0.831,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -2.8,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "carrymecute",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple58.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_11_f",
    animnametext = "Leaning Back",
    animtype = "erp",
    animationid = "couple58",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = 0.65,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 10,
      animglue = true
    },
    coupleanim = "couple57",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "hugpose.webp",
    animname = "amnilka_couple_mal_001",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "A Warm Hug",
    animtype = "erp",
    animationid = "hugpose",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "hugpose2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple54.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_with_hand_touch_male",
    animnametext = "Tender Kiss",
    animtype = "erp",
    animationid = "couple53",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple54",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose4f.webp",
    animname = "f_couple_02_clip",
    animdictionary = "anim@female_couple_02",
    animnametext = "Intimate Look",
    animtype = "erp",
    animationid = "lovepose4f",
    animmeta = {
      animxcoord = -0.5,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose4m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple84.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@chair_and_foot_placement_f",
    animnametext = "Relaxing on Chair",
    animtype = "erp",
    animationid = "couple84",
    animmeta = {
      animxcoord = -0.48,
      animycoord = 0.15,
      animzcoord = 0.25,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -90,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple83",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple42.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@cute_bench_kisses_f",
    animnametext = "Cute Bench Kiss",
    animtype = "erp",
    animationid = "couple42",
    animmeta = {
      animxcoord = -0.25,
      animycoord = 0.6,
      animzcoord = 0.35,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -30,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple41",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple42.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@cute_bench_kisses_m",
    animnametext = "New Couple 41",
    animtype = "erp",
    animationid = "couple41",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple42"
  },
  {
    animimg = "walklove4f.webp",
    animname = "couple59_clip",
    animdictionary = "chocoholic@couple59",
    animnametext = "Romantic Walk",
    animtype = "erp",
    animationid = "walklove4m",
    animmeta = {
      animmovement = true,
      animloop = true
    },
    coupleanim = "walklove4f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose20f.webp",
    animname = "mx@couple4.4_a_clip",
    animdictionary = "mx@couple4.4_a",
    animnametext = "Lifting High",
    animtype = "erp",
    animationid = "lovepose20m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose20f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitbikepf.webp",
    animname = "bikefistfemale_clip",
    animdictionary = "bikefistfemale@joker",
    animnametext = "Bike Pose",
    animtype = "erp",
    animationid = "sitbikepf",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 1.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = false
    },
    coupleanim = "sitbikepm",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose19f.webp",
    animname = "mx@couple4.3_a_clip",
    animdictionary = "mx@couple4.3_a",
    animnametext = "Tender Hold",
    animtype = "erp",
    animationid = "lovepose19m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose19f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose19f.webp",
    animname = "mx@couple4.3_b_clip",
    animdictionary = "mx@couple4.3_b",
    animnametext = "Love Pose 19 Male",
    animtype = "erp",
    animationid = "lovepose19f",
    animmeta = {
      animxcoord = 0.48,
      animycoord = 0.02,
      animzcoord = -0.02,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 152.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose19m"
  },
  {
    animimg = "couple78.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@playful_duo_poses01",
    animnametext = "Playful Lift",
    animtype = "erp",
    animationid = "couple78",
    animmeta = {
      animxcoord = 0.1,
      animycoord = 0.5,
      animzcoord = 1.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 70,
      animglue = true
    },
    coupleanim = "couple77",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose17f.webp",
    animname = "mx@pack4.1_a_clip",
    animdictionary = "mx@pack4.1_a",
    animnametext = "Back Embrace",
    animtype = "erp",
    animationid = "lovepose17m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose17f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lspintimacy005.webp",
    animname = "intimacy003",
    animdictionary = "littlespoon@intimacy003",
    animnametext = "Ready Position",
    animtype = "erp",
    animationid = "lspintimacy003",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0
    },
    coupleanim = "lspintimacy005",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose16f.webp",
    animname = "mx@couple6_3_b_clip",
    animdictionary = "mx@couple6_3_b",
    animnametext = "Passionate Hold",
    animtype = "erp",
    animationid = "lovepose16f",
    animmeta = {
      animxcoord = 0.52,
      animycoord = 0.25,
      animzcoord = 0.05,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 13.5,
      animglue = true
    },
    coupleanim = "lovepose16m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "standingg2.webp",
    animname = "tigerle_couple_standing_b",
    animdictionary = "tigerle@custom@couple@standing_b",
    animnametext = "Standing Kiss",
    animtype = "erp",
    animationid = "standingg2",
    animmeta = {
      animxcoord = 0.1,
      animycoord = 0.3,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "standingg",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "standingg2.webp",
    animname = "tigerle_couple_standing_a",
    animdictionary = "tigerle@custom@couple@standing_a",
    animnametext = "Kiss 7",
    animtype = "erp",
    animationid = "standingg",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "standingg2"
  },
  {
    animname = "aiko10_clip",
    animdictionary = "aiko10@seimen",
    animnametext = "Artistic Pose",
    animtype = "erp",
    animationid = "newpose26",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose26.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "couple68.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_16_m",
    animnametext = "Dip Kiss",
    animtype = "erp",
    animationid = "couple67",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple68",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple68.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_16_f",
    animnametext = "New Couple 68",
    animtype = "erp",
    animationid = "couple68",
    animmeta = {
      animxcoord = 0.05,
      animycoord = -0.35,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animxrotation = 10.0,
      animyrotation = 0.0,
      animzrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple67",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "couplewed2b.webp",
    animname = "wedding2b",
    animdictionary = "EnchantedBrwny@wedding2b",
    animnametext = "Groom's Pose",
    animtype = "erp",
    animationid = "couplewed2a",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couplewed2b",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "footlovepose3f.webp",
    animname = "schoko4_clip",
    animdictionary = "schoko4@sharror",
    animnametext = "Receiving Tender Foot Kiss",
    animtype = "erp",
    animationid = "footlovepose3f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.85,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "footlovepose3m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple8.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@sea_love_together_male",
    animnametext = "Initiating Seaside Romance",
    animtype = "erp",
    animationid = "couple7",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple8",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "carry3.webp",
    animname = "firemans_carry",
    animdictionary = "nm",
    animnametext = "Receiving Hero's Carry",
    animtype = "erp",
    animationid = "carry3",
    animmeta = {
      animxcoord = -0.14,
      animycoord = 0.15,
      animzcoord = 0.14,
      animloop = true,
      animmovement = false,
      animboneindex = 40269,
      animzrotation = -4.5,
      animyrotation = -59,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "carry2",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple56.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_with_hand_touch_male01",
    animnametext = "Initiating Hand-touch Kiss",
    animtype = "erp",
    animationid = "couple55",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple56",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "carrymecute2.webp",
    animname = "amnilka_couple_fem_002",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Being Carried Cute",
    animtype = "erp",
    animationid = "carrymecute2",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "carrymecute",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "69m.webp",
    animname = "69f",
    animdictionary = "genesismods@oralfixation_69f",
    animnametext = "Receiving Sixty-Nine",
    animtype = "erp",
    animationid = "69f",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "69m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple100.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_in_wet_element_female",
    animnametext = "Receiving Kiss in the Rain",
    animtype = "erp",
    animationid = "couple100",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.37,
      animzcoord = -0.08,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple99",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple32.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@affectionate_kiss_m",
    animnametext = "Giving Affectionate Kiss",
    animtype = "erp",
    animationid = "couple31",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple32",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitchairlove3f.webp",
    animname = "couple47_v3_clip",
    animdictionary = "chocoholic@couple47_v3",
    animnametext = "Initiating Chair Embrace",
    animtype = "erp",
    animationid = "sitchairlove3m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitchairlove3f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "carry5.webp",
    animname = "idle",
    animdictionary = "anim@heists@box_carry@",
    animnametext = "Initiating Carried Away",
    animtype = "erp",
    animationid = "carry4",
    animmeta = {
      animmovement = true,
      animloop = true
    },
    coupleanim = "carry5",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose4f.webp",
    animname = "f_couple_02_clip",
    animdictionary = "anim@female_couple_02",
    animnametext = "Receiving Intimate Gaze",
    animtype = "erp",
    animationid = "lovepose4f",
    animmeta = {
      animxcoord = -0.5,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose4m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "hotsitf2.webp",
    animname = "mx@couple2_a_clip",
    animdictionary = "mx@couple2_a",
    animnametext = "Initiating Hot Lap Sit",
    animtype = "erp",
    animationid = "hotsitm2",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "hotsitf2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "bffb.webp",
    animname = "f_couple_03_b_clip",
    animdictionary = "anim@female_couple_03_b",
    animnametext = "Receiving Friends Embrace",
    animtype = "erp",
    animationid = "bffb",
    animmeta = {
      animxcoord = 0.01,
      animycoord = 0.13,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 76,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "bff",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple88.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@golden_hour_of_love_m",
    animnametext = "Initiating Golden Hour Embrace",
    animtype = "erp",
    animationid = "couple87",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple88",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple62.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_13_f",
    animnametext = "Receiving Leaning In",
    animtype = "erp",
    animationid = "couple62",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.65,
      animzcoord = 0.8,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple61",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "wallocepose2f.webp",
    animname = "couple_wall_02_clip",
    animdictionary = "couple_wall_02@sharror",
    animnametext = "Receiving Against the Wall Kiss",
    animtype = "erp",
    animationid = "wallocepose2f",
    animmeta = {
      animxcoord = 0.82,
      animycoord = -0.21,
      animzcoord = 0.03,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "wallocepose2m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "liftme4.webp",
    animname = "couplepose2pack1anim1_clip",
    animdictionary = "couplepose2pack1anim1@animation",
    animnametext = "Receiving Lift and Hold",
    animtype = "erp",
    animationid = "liftme4",
    animmeta = {
      animxcoord = 0.01,
      animycoord = 0.48,
      animzcoord = 0.53,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "liftme3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple92.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@hug_of_joy_f",
    animnametext = "Receiving Hug of Joy",
    animtype = "erp",
    animationid = "couple92",
    animmeta = {
      animxcoord = -0.1,
      animycoord = 0.2,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 10,
      animglue = true
    },
    coupleanim = "couple91",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple98.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_in_sunset_f",
    animnametext = "Receiving Sunset Kiss",
    animtype = "erp",
    animationid = "couple98",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.23,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple97",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kisslovpose1f.webp",
    animname = "couple51_clip",
    animdictionary = "chocoholic@couple51",
    animnametext = "Giving Loving Kiss",
    animtype = "erp",
    animationid = "kisslovpose1m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kisslovpose1f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovecrryf.webp",
    animname = "mx@couple4_b_clip",
    animdictionary = "mx@couple4_b",
    animnametext = "Being Carried in Love",
    animtype = "erp",
    animationid = "lovecrryf",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovecrrym",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose22f.webp",
    animname = "couplemale_leancar_clip",
    animdictionary = "couplemale_leancar@joker",
    animnametext = "Initiating Car Lean",
    animtype = "erp",
    animationid = "lovepose22m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose22f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitwithmepose2.webp",
    animname = "amnilka_couple_fem_003",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Receiving Sit With Me",
    animtype = "erp",
    animationid = "sitwithmepose2",
    animmeta = {
      animxcoord = 0.354,
      animycoord = 0.511,
      animzcoord = 0.831,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -2.8,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "carrymecute",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple57.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_11_m",
    animnametext = "Initiating Leaning Back",
    animtype = "erp",
    animationid = "couple57",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple58",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "hugpose2.webp",
    animname = "amnilka_couple_mal_001",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Giving A Warm Hug",
    animtype = "erp",
    animationid = "hugpose",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "hugpose2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couplehhands2.webp",
    animname = "amnilka_couple_mal_005",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Couple Heart Hands",
    animtype = "erp",
    animationid = "couplehhands",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couplehhands2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitlovepose9f.webp",
    animname = "f_couple_01_clip",
    animdictionary = "anim@female_couple_01",
    animnametext = "Receiving Lap Sit",
    animtype = "erp",
    animationid = "sitlovepose9f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.47,
      animzcoord = 0.8,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = -15,
      animglue = true
    },
    coupleanim = "sitlovepose9m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitlovepose9f.webp",
    animname = "m_couple_01_clip",
    animdictionary = "anim@male_couple_01",
    animnametext = "Sit Love Pose 9 Female",
    animtype = "erp",
    animationid = "sitlovepose9m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitlovepose9f"
  },
  {
    animimg = "lovepose7f.webp",
    animname = "m_couple_03_clip",
    animdictionary = "anim@male_couple_03",
    animnametext = "Initiating Close Embrace",
    animtype = "erp",
    animationid = "lovepose7m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose7f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose7f.webp",
    animname = "f_couple_03_clip",
    animdictionary = "anim@female_couple_03",
    animnametext = "Love Pose 7 Female",
    animtype = "erp",
    animationid = "lovepose7f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.13,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 95.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose7m"
  },
  {
    animimg = "couplehhands2.webp",
    animname = "amnilka_couple_fem_005",
    animdictionary = "amnilka@photopose@couple@couplefirst",
    animnametext = "Receiving Heart Hands",
    animtype = "erp",
    animationid = "couplehhands2",
    animmeta = {
      animxcoord = -0.123,
      animycoord = 0.474,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 94,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couplehhands",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "bskball_dunk_clip",
    animdictionary = "anim@male_bskball_dunk",
    animnametext = "Basketball Dunk",
    animtype = "erp",
    animationid = "newpose5",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose5.webp",
    animisadult = false,
    animcoupletype = "Solo"
  },
  {
    animimg = "couple48.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@heart_shaped_hug_female",
    animnametext = "Receiving Heart Shaped Hug",
    animtype = "erp",
    animationid = "couple48",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.3,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple47",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple47.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@heart_shaped_hug_male",
    animnametext = "Heart Shaped Hug",
    animtype = "erp",
    animationid = "couple47",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple48",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "footloveposef.webp",
    animname = "couple64_clip",
    animdictionary = "chocoholic@couple64",
    animnametext = "On The Foot Love Pose 1 NEW",
    animtype = "erp",
    animationid = "footloveposef",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.09,
      animzcoord = 0.48,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "footloveposem"
  },
  {
    animimg = "sitlovepose5f.webp",
    animname = "couple61_clip",
    animdictionary = "chocoholic@couple61",
    animnametext = "Initiating Sitting Close",
    animtype = "erp",
    animationid = "sitlovepose5m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitlovepose5f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovewalkpose3f.webp",
    animname = "couple57_clip",
    animdictionary = "chocoholic@couple57",
    animnametext = "Initiating Walking Together",
    animtype = "erp",
    animationid = "lovewalkpose3m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovewalkpose3f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kissinglvpose4f.webp",
    animname = "couple56_clip",
    animdictionary = "chocoholic@couple56",
    animnametext = "Receiving Passionate Wall Kiss",
    animtype = "erp",
    animationid = "kissinglvpose4f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.32,
      animzcoord = -0.05,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kissinglvpose4m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kissinglvpose4f.webp",
    animname = "couple55_clip",
    animdictionary = "chocoholic@couple55",
    animnametext = "Initiating Passionate Wall Kiss",
    animtype = "erp",
    animationid = "kissinglvpose4m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kissinglvpose4f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple38.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@connected_couple_f",
    animnametext = "Receiving Connected Couple Pose",
    animtype = "erp",
    animationid = "couple38",
    animmeta = {
      animxcoord = -0.5,
      animycoord = 0.5,
      animzcoord = 0.8,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple37",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitloverockf.webp",
    animname = "couple46_clip",
    animdictionary = "chocoholic@couple46",
    animnametext = "Initiating Rocking Embrace",
    animtype = "erp",
    animationid = "sitloverockm",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitloverockf",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitbikepm.webp",
    animname = "bikefistmale_clip",
    animdictionary = "bikefistmale@joker",
    animnametext = "Initiating Bike Pose",
    animtype = "erp",
    animationid = "sitbikepm",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitbikepf",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitchrlv2f.webp",
    animname = "benchf_clip",
    animdictionary = "benchf@spider",
    animnametext = "Receiving Chair Love",
    animtype = "erp",
    animationid = "sitchrlv2f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.39,
      animzcoord = 0.36,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sitchrlv2m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "holdmef.webp",
    animname = "mx_couple5_3_b_clip",
    animdictionary = "mx_couple5_3_b",
    animnametext = "Receiving Tight Hold",
    animtype = "erp",
    animationid = "holdmef",
    animmeta = {
      animxcoord = 0.04,
      animycoord = 0.21,
      animzcoord = -0.03,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "holdmee",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "holdmef.webp",
    animname = "mx_couple5_3_a_clip",
    animdictionary = "mx_couple5_3_a",
    animnametext = "Initiating Tight Hold",
    animtype = "erp",
    animationid = "holdmee",
    animmeta = {
      animloop = true
    },
    coupleanim = "holdmef",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couplewed1b.webp",
    animname = "wedding1a",
    animdictionary = "EnchantedBrwny@wedding1a",
    animnametext = "Initiating Wedding Dance",
    animtype = "erp",
    animationid = "couplewed1a",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couplewed1b",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple38.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@connected_couple_m",
    animnametext = "Connected Couple Pose",
    animtype = "erp",
    animationid = "couple37",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple38",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "hugtip2.webp",
    animname = "friendship007",
    animdictionary = "littlespoon@friendship007",
    animnametext = "Initiating Tiptoe Hug",
    animtype = "erp",
    animationid = "hugtip",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "hugtip2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose15f.webp",
    animname = "mx@couple6_2_a_clip",
    animdictionary = "mx@couple6_2_a",
    animnametext = "Initiating Passionate Hold",
    animtype = "erp",
    animationid = "lovepose15m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose15f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose11f.webp",
    animname = "f_couple_06_clip",
    animdictionary = "anim@female_couple_06",
    animnametext = "Held from Behind Female",
    animtype = "erp",
    animationid = "lovepose11f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.62,
      animzcoord = -0.14,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = -50,
      animglue = true
    },
    coupleanim = "lovepose11m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "titanic2.webp",
    animname = "tigerle_pose_titanic1b",
    animdictionary = "tigerle@custom@pose@titanic1b",
    animnametext = "Receiving Titanic Pose",
    animtype = "erp",
    animationid = "titanic2",
    animmeta = {
      animxcoord = 0.1,
      animycoord = 0.3,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "titanic",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "titanic2.webp",
    animname = "tigerle_pose_titanic1a",
    animdictionary = "tigerle@custom@pose@titanic1a",
    animnametext = "Kiss 7",
    animtype = "erp",
    animationid = "titanic",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "titanic2"
  },
  {
    animimg = "carrycmg2.webp",
    animname = "couplepose2cmg_clip",
    animdictionary = "couplepose2cmg@animation",
    animnametext = "Being Carried Strongly",
    animtype = "erp",
    animationid = "carrycmg2",
    animmeta = {
      animxcoord = 0.01,
      animycoord = 0.344,
      animzcoord = -0.01,
      animloop = true,
      animboneindex = 0,
      animzrotation = -1.9999,
      animyrotation = 180,
      animxrotation = 180,
      animglue = true
    },
    coupleanim = "carrycmg",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitting2.webp",
    animname = "tigerle_couple_sittingonbench_no1b",
    animdictionary = "tigerle@custom@couple@sittingonbench@no1b",
    animnametext = "Receiving Bench Kiss",
    animtype = "erp",
    animationid = "sitting2",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sitting",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitting2.webp",
    animname = "tigerle_couple_sittingonbench_no1a",
    animdictionary = "tigerle@custom@couple@sittingonbench@no1a",
    animnametext = "Initiating Bench Kiss",
    animtype = "erp",
    animationid = "sitting",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitting2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "049anim.webp",
    animname = "servethequeen011",
    animdictionary = "littlespoon@servethequeen011",
    animnametext = "Giving Eat Me Out",
    animtype = "erp",
    animationid = "049anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "048anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "cuddleet4.webp",
    animname = "tigerle_couple_cuddleno2b",
    animdictionary = "tigerle@custom@couple@cuddle@no2b",
    animnametext = "Receiving Cuddle 4",
    animtype = "erp",
    animationid = "cuddleet4",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "cuddleet3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "cuddleet4.webp",
    animname = "tigerle_couple_cuddleno2a",
    animdictionary = "tigerle@custom@couple@cuddle@no2a",
    animnametext = "Initiating Cuddle",
    animtype = "erp",
    animationid = "cuddleet3",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "cuddleet4",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "cuddleet2.webp",
    animname = "tigerle_couple_cuddle1a",
    animdictionary = "tigerle@custom@couple@cuddle1a",
    animnametext = "Kiss 7",
    animtype = "erp",
    animationid = "cuddleet",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "cuddleet2"
  },
  {
    animimg = "kiss8.webp",
    animname = "tigerle_couple_kissing2b",
    animdictionary = "tigerle@custom@couple@kissing2b",
    animnametext = "Receiving Kiss 8",
    animtype = "erp",
    animationid = "kiss8",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kiss7",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss17.webp",
    animname = "kissfemale9",
    animdictionary = "genesismods_kissme@kissfemale9",
    animnametext = "Kiss 9(Female)",
    animtype = "erp",
    animationid = "kiss18",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kiss17"
  },
  {
    animimg = "sexm8.webp",
    animname = "standingm",
    animdictionary = "genesismods@erotica_standingm",
    animnametext = "Initiating Against Wall",
    animtype = "erp",
    animationid = "sexm8",
    animmeta = {
      animxcoord = -0.35,
      animycoord = 0.02,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sexw8",
    recordHeadingOffset = -90,
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm7.webp",
    animname = "standingcowgirlm",
    animdictionary = "genesismods@erotica_standingcowgirlm",
    animnametext = "Receiving Standing Cowgirl",
    animtype = "erp",
    animationid = "sexm7",
    animmeta = {
      animxcoord = -0.3,
      animycoord = 0.0,
      animzcoord = 0.05,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sexw7",
    recordHeadingOffset = -90,
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose12f.webp",
    animname = "f_couple_07_clip",
    animdictionary = "anim@female_couple_07",
    animnametext = "Love Pose 12 Female",
    animtype = "erp",
    animationid = "lovepose12f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.72,
      animzcoord = 0.1,
      animloop = true,
      animmovement = false,
      PropPlacement = {
        0.12,
        0.016,
        -0.034,
        0.0,
        90.0,
        -180.0
      },
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true,
      Propanimboneindex = 6286,
      Prop = "prop_phone_ing_03"
    },
    coupleanim = "lovepose12m"
  },
  {
    animimg = "lovepose22f.webp",
    animname = "couplemale_leancar_clip",
    animdictionary = "couplemale_leancar@joker",
    animnametext = "Leaning on Car",
    animtype = "erp",
    animationid = "lovepose22m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose22f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose20f.webp",
    animname = "mx@couple4.4_b_clip",
    animdictionary = "mx@couple4.4_b",
    animnametext = "High Embrace",
    animtype = "erp",
    animationid = "lovepose20f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 1.47,
      animzcoord = 0.7,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.5,
      animxrotation = 0.1,
      animglue = true
    },
    coupleanim = "lovepose20m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couplewed1b.webp",
    animname = "wedding1b",
    animdictionary = "EnchantedBrwny@wedding1b",
    animnametext = "Wedding Dance",
    animtype = "erp",
    animationid = "couplewed1b",
    animmeta = {
      animxcoord = 0.03,
      animycoord = 1.0,
      animzcoord = 0.02,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 130,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couplewed1a",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose19f.webp",
    animname = "mx@couple4.3_b_clip",
    animdictionary = "mx@couple4.3_b",
    animnametext = "Love Pose 19 Male",
    animtype = "erp",
    animationid = "lovepose19f",
    animmeta = {
      animxcoord = 0.48,
      animycoord = 0.02,
      animzcoord = -0.02,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 152.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose19m"
  },
  {
    animimg = "lovepose18f.webp",
    animname = "mx@couple4.2_b_clip",
    animdictionary = "mx@couple4.2_b",
    animnametext = "Resting on Shoulder",
    animtype = "erp",
    animationid = "lovepose18f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.31,
      animzcoord = -0.02,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose18m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm8.webp",
    animname = "standingf",
    animdictionary = "genesismods@erotica_standingf",
    animnametext = "Pressed Against Wall",
    animtype = "erp",
    animationid = "sexw8",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sexm8",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "025anim.webp",
    animname = "feetplay008",
    animdictionary = "littlespoon@feetplay008",
    animnametext = "Foot Caress male",
    animtype = "erp",
    animationid = "025anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.9,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = false
    },
    coupleanim = "024anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "024anim.webp",
    animname = "feetplay007",
    animdictionary = "littlespoon@feetplay007",
    animnametext = "Foot Caress",
    animtype = "erp",
    animationid = "024anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "025anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose16f.webp",
    animname = "mx@couple6_3_a_clip",
    animdictionary = "mx@couple6_3_a",
    animnametext = "Holding Passionately",
    animtype = "erp",
    animationid = "lovepose16m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose16f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "standingg2.webp",
    animname = "tigerle_couple_standing_a",
    animdictionary = "tigerle@custom@couple@standing_a",
    animnametext = "Kiss 7",
    animtype = "erp",
    animationid = "standingg",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "standingg2"
  },
  {
    animname = "aiko10_clip",
    animdictionary = "aiko10@seimen",
    animnametext = "Artistic Pose",
    animtype = "erp",
    animationid = "newpose26",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose26.webp",
    animisadult = true,
    animcoupletype = "Solo"
  },
  {
    animimg = "kissinglv2f.webp",
    animname = "couple53_clip",
    animdictionary = "chocoholic@couple53",
    animnametext = "Receiving Passionate Kiss",
    animtype = "erp",
    animationid = "kissinglv2f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.28,
      animzcoord = -0.08,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 50,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kissinglv2m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple28.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_3_f",
    animnametext = "Listening to Sweet Nothings",
    animtype = "erp",
    animationid = "couple28",
    animmeta = {
      animxcoord = -0.03,
      animycoord = 0.25,
      animzcoord = 0.42,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = -10,
      animglue = true
    },
    coupleanim = "couple27",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "followb.webp",
    animname = "follow_me_002",
    animdictionary = "dollie_mods@follow_me_002",
    animnametext = "Follow Me (Follower)",
    animtype = "erp",
    animationid = "followb",
    animmeta = {
      animxcoord = 0.078,
      animycoord = 0.018,
      animzcoord = 0.0,
      animloop = true,
      animxrotation = 0.0,
      animglue = true,
      animzrotation = 0.0,
      animyrotation = 0
    },
    coupleanim = "followa",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "holdmec.webp",
    animname = "mx_couple5_2_a_clip",
    animdictionary = "mx_couple5_2_a",
    animnametext = "Holding Close",
    animtype = "erp",
    animationid = "holdmec",
    animmeta = {
      animloop = true
    },
    coupleanim = "holdmed",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitloverockf.webp",
    animname = "couple46_clip",
    animdictionary = "chocoholic@couple46",
    animnametext = "Holding in Rocking Embrace",
    animtype = "erp",
    animationid = "sitloverockm",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitloverockf",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "026anim.webp",
    animname = "feetplay010",
    animdictionary = "littlespoon@feetplay010",
    animnametext = "Receiving Playful Feet",
    animtype = "erp",
    animationid = "027anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.9,
      animyrotation = 0.0,
      animxrotation = 0
    },
    coupleanim = "026anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "020anim.webp",
    animname = "feetplay003",
    animdictionary = "littlespoon@feetplay003",
    animnametext = "Receiving Admiring Feet",
    animtype = "erp",
    animationid = "020anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.9,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "021anim",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitlovepose8f.webp",
    animname = "couplebench_f_clip",
    animdictionary = "couplebench_f@gengaranimation",
    animnametext = "Receiving Bench Cuddle",
    animtype = "erp",
    animationid = "sitlovepose8f",
    animmeta = {
      animxcoord = -1.45,
      animycoord = 0.81,
      animzcoord = 0.35,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sitlovepose8m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "liftme2.webp",
    animname = "couplepose1pack1anim1_clip",
    animdictionary = "couplepose1pack1anim1@animation",
    animnametext = "Receiving Uplifting Love",
    animtype = "erp",
    animationid = "liftme2",
    animmeta = {
      animxcoord = 0.002,
      animycoord = 0.287,
      animzcoord = 0.25,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "liftme",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss19.webp",
    animname = "kissfemale10",
    animdictionary = "genesismods_kissme@kissfemale10",
    animnametext = "Receiving Deep Kiss",
    animtype = "erp",
    animationid = "kiss20",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kiss19",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose9f.webp",
    animname = "m_couple_04_clip",
    animdictionary = "anim@male_couple_04",
    animnametext = "Holding for Selfie",
    animtype = "erp",
    animationid = "lovepose9m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose9f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple6.webp",
    animname = "mx@couplephone_f_clip",
    animdictionary = "mx@couplephone_f",
    animnametext = "Receiving Phone Together",
    animtype = "erp",
    animationid = "couple6",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.3,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple40.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@courtyard_love_f",
    animnametext = "Receiving Courtyard Romance",
    animtype = "erp",
    animationid = "couple40",
    animmeta = {
      animxcoord = 0.05,
      animycoord = 0.4,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 160,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple39",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm5.webp",
    animname = "cowgirlf",
    animdictionary = "genesismods@erotica_cowgirlf",
    animnametext = "Riding Cowgirl",
    animtype = "erp",
    animationid = "sexw5",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sexm5",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple16.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@coffee_togetherness_female",
    animnametext = "Receiving Coffee Together",
    animtype = "erp",
    animationid = "couple16",
    animmeta = {
      animxcoord = -0.25,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = -90,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "couple15",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose10f.webp",
    animname = "m_couple_05_clip",
    animdictionary = "anim@male_couple_05",
    animnametext = "Initiating Relaxed Selfie",
    animtype = "erp",
    animationid = "lovepose10m",
    animmeta = {
      animloop = true,
      animmovement = false,
      Prop = "prop_phone_ing_03",
      Propanimboneindex = 60309,
      PropPlacement = {
        0.14,
        0.04,
        0.01,
        10,
        112,
        -180
      }
    },
    coupleanim = "lovepose10f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "walklove1f.webp",
    animname = "couple50_clip",
    animdictionary = "chocoholic@couple50",
    animnametext = "Initiating Lovers Stroll",
    animtype = "erp",
    animationid = "walklove1m",
    animmeta = {
      animmovement = true,
      animloop = true
    },
    coupleanim = "walklove1f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "013Anim.webp",
    animname = "cowgirl_clip",
    animdictionary = "cowgirl@sinkra",
    animnametext = "Receiving Slow Ride",
    animtype = "erp",
    animationid = "013Anim",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.2,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "passout3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "013anim.webp",
    animname = "body_search",
    animdictionary = "anim@gangops@morgue@table@",
    animnametext = "Slow Ride",
    animtype = "erp",
    animationid = "passout3",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.1,
      animzcoord = 0.4,
      animloop = true,
      animmovement = false,
      animzrotation = 0.5,
      animyrotation = 0.0,
      animxrotation = 0.0,
    },
    coupleanim = "013Anim",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple78.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@playful_duo_poses01",
    animnametext = "Receiving Playful Lift",
    animtype = "erp",
    animationid = "couple78",
    animmeta = {
      animxcoord = 0.1,
      animycoord = 0.5,
      animzcoord = 1.15,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 70,
      animglue = true
    },
    coupleanim = "couple77",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "liftme6.webp",
    animname = "couplepose3pack1anim2_clip",
    animdictionary = "couplepose3pack1anim2@animation",
    animnametext = "Initiating Joyful Lift",
    animtype = "erp",
    animationid = "liftme5",
    animmeta = {
      animloop = true
    },
    coupleanim = "liftme6",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple26.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_2_m",
    animnametext = "Initiating Back Hug",
    animtype = "erp",
    animationid = "couple25",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple26",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "pback2.webp",
    animname = "mxclip_a",
    animdictionary = "mx@piggypack_a",
    animnametext = "Offer Piggyback Ride",
    animtype = "erp",
    animationid = "pback",
    animmeta = {
      animmovement = true,
      animloop = true
    },
    coupleanim = "pback2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple84.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@chair_and_foot_placement_m",
    animnametext = "Initiating Chair and Foot Play",
    animtype = "erp",
    animationid = "couple83",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple84",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple54.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kiss_with_hand_touch_male",
    animnametext = "Giving Tender Kiss",
    animtype = "erp",
    animationid = "couple53",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple54",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitlovepose9f.webp",
    animname = "m_couple_01_clip",
    animdictionary = "anim@male_couple_01",
    animnametext = "Sit Love Pose 9 Female",
    animtype = "erp",
    animationid = "sitlovepose9m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitlovepose9f"
  },
  {
    animimg = "lovepose7f.webp",
    animname = "f_couple_03_clip",
    animdictionary = "anim@female_couple_03",
    animnametext = "Love Pose 7 Female",
    animtype = "erp",
    animationid = "lovepose7f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.13,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 95.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "lovepose7m"
  },
  {
    animimg = "kiss15.webp",
    animname = "kissmale8",
    animdictionary = "genesismods_kissme@kissmale8",
    animnametext = "Initiating Passionate Kiss",
    animtype = "erp",
    animationid = "kiss15",
    animmeta = {
      animxcoord = -0.56,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kiss16",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animname = "bskball_dunk_clip",
    animdictionary = "anim@male_bskball_dunk",
    animnametext = "Basketball Dunk",
    animtype = "erp",
    animationid = "newpose5",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    animimg = "newpose5.webp",
    animisadult = false,
    animcoupletype = "Solo"
  },
  {
    animimg = "sitlovepose7f.webp",
    animname = "couple4_clip",
    animdictionary = "couple4@spider",
    animnametext = "Receiving Spider Sit",
    animtype = "erp",
    animationid = "sitlovepose7f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.55,
      animzcoord = 0.38,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sitlovepose7m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "footloveposef.webp",
    animname = "couple63_clip",
    animdictionary = "chocoholic@couple63",
    animnametext = "Giving Foot Adoration",
    animtype = "erp",
    animationid = "footloveposem",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "footloveposef",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "footloveposef.webp",
    animname = "couple64_clip",
    animdictionary = "chocoholic@couple64",
    animnametext = "On The Foot Love Pose 1 NEW",
    animtype = "erp",
    animationid = "footloveposef",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.09,
      animzcoord = 0.48,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 180.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "footloveposem"
  },
  {
    animimg = "sitlovepose5f.webp",
    animname = "couple62_clip",
    animdictionary = "chocoholic@couple62",
    animnametext = "Receiving Sitting Close",
    animtype = "erp",
    animationid = "sitlovepose5f",
    animmeta = {
      animxcoord = -0.2,
      animycoord = 0.5,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 210,
      animyrotation = -215,
      animxrotation = 118,
      animglue = true
    },
    coupleanim = "sitlovepose5m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "walklove4f.webp",
    animname = "couple60_clip",
    animdictionary = "chocoholic@couple60",
    animnametext = "Receiving Romantic Walk",
    animtype = "erp",
    animationid = "walklove4f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.24,
      animzcoord = 1.2,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "walklove4m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple90.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@hitchhiking_for_love_male",
    animnametext = "Initiating Hitchhiking for Love",
    animtype = "erp",
    animationid = "couple89",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple90",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kissinglvpose2f.webp",
    animname = "wand_pose_01_clip",
    animdictionary = "wand_pose_01@sharror",
    animnametext = "Initiating Wall Kiss",
    animtype = "erp",
    animationid = "kissinglvpose2m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kissinglvpose2f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sitchrlv2f.webp",
    animname = "benchm_clip",
    animdictionary = "benchm@spider",
    animnametext = "Initiating Chair Love",
    animtype = "erp",
    animationid = "sitchrlv2m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sitchrlv2f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple24.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@couple_pose_1_m",
    animnametext = "Initiating Holding Tight",
    animtype = "erp",
    animationid = "couple23",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple24",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple38.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@connected_couple_m",
    animnametext = "Connected Couple Pose",
    animtype = "erp",
    animationid = "couple37",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple38",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple104.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kissing_at_ocean_beach_male",
    animnametext = "Ocean Kiss",
    animtype = "erp",
    animationid = "couple103",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple104",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "couple104.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@kissing_at_ocean_beach_female",
    animnametext = "New Couple 104",
    animtype = "erp",
    animationid = "couple104",
    animmeta = {
      animxcoord = 0.12,
      animycoord = 0.22,
      animzcoord = 0.17,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animxrotation = -45.0,
      animyrotation = 0.0,
      animzrotation = 160.0,
      animglue = true
    },
    coupleanim = "couple103",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "3lanisha3.webp",
    animname = "001443_01_trvs_28_idle_stripper",
    animdictionary = "switch@trevor@mocks_lapdance",
    animnametext = "Receiving Lap Dance",
    animtype = "erp",
    animationid = "lanisha6",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "3lanisha3",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "couple34.webp",
    animname = "mrwitt",
    animdictionary = "mrwitt@beach_lovers_kisses_m",
    animnametext = "Giving Beach Lovers Kiss",
    animtype = "erp",
    animationid = "couple33",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "couple34",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "sexm1.webp",
    animname = "missionarym",
    animdictionary = "genesismods@erotica_missionarym",
    animnametext = "Missionary 1 Man",
    animtype = "erp",
    animationid = "sexm1",
    animmeta = {
      animxcoord = 0.08,
      animycoord = 0.02,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sexw1",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  }, 
  {
    animimg = "sexm1.webp",
    animname = "missionaryf",
    animdictionary = "genesismods@erotica_missionaryf",
    animnametext = "Missionary 1 Female",
    animtype = "erp",
    animationid = "sexw1",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sexm1",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
    {
    animimg = "sexm2.webp",
    animname = "missionary2m",
    animdictionary = "genesismods@erotica_missionary2m",
    animnametext = "Missionary 2 Man",
    animtype = "erp",
    animationid = "sexm2",
    animmeta = {
      animxcoord = 0.09,
      animycoord = 0.02,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "sexw2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  }, 
  {
    animimg = "sexm2.webp",
    animname = "missionary2f",
    animdictionary = "genesismods@erotica_missionary2f",
    animnametext = "Missionary 2 Female",
    animtype = "erp",
    animationid = "sexw2",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "sexm2",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose11f.webp",
    animname = "m_couple_06_clip",
    animdictionary = "anim@male_couple_06",
    animnametext = "Holding from Behind Male",
    animtype = "erp",
    animationid = "lovepose11m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose11f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss.webp",
    animname = "cs_lestercrest_3_dual-20",
    animdictionary = "hs3_ext-20",
    animnametext = "Kiss",
    animtype = "erp",
    animationid = "kiss",
    animmeta = {
      animmovement = false,
      SyncOffsetFront = 0.08,
      EmoteDuration = 10000
    },
    coupleanim = "kiss2"
  },
  {
    animimg = "titanic2.webp",
    animname = "tigerle_pose_titanic1a",
    animdictionary = "tigerle@custom@pose@titanic1a",
    animnametext = "Kiss 7",
    animtype = "erp",
    animationid = "titanic",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "titanic2"
  },
  {
    animimg = "lovepose15f.webp",
    animname = "mx@couple6_2_b_clip",
    animdictionary = "mx@couple6_2_b",
    animnametext = "Receiving Passionate Hold",
    animtype = "erp",
    animationid = "lovepose15f",
    animmeta = {
      animxcoord = -0.12,
      animycoord = 0.3,
      animzcoord = -0.1,
      animloop = true,
      animmovement = false,
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 28,
      animglue = true
    },
    coupleanim = "lovepose15m",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "cuddleet6.webp",
    animname = "tigerle_couple_standcuddle_a",
    animdictionary = "tigerle@custom@couple@standcuddle_a",
    animnametext = "Initiating Standing Cuddle",
    animtype = "erp",
    animationid = "cuddleet5",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "cuddleet6",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
{
    animimg = "layying.webp",
    animname = "tigerle_couple_laying1a",
    animdictionary = "tigerle@custom@couple@laying1a",
    animnametext = "Receiving Laying Cuddle Male",
    animtype = "erp",
    animationid = "layying",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "layying2",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },  
  {
    animimg = "layying2.webp",
    animname = "tigerle_couple_laying1b",
    animdictionary = "tigerle@custom@couple@laying1b",
    animnametext = "Receiving Laying Cuddle",
    animtype = "erp",
    animationid = "layying2",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "layying",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "cuddleet2.webp",
    animname = "tigerle_couple_cuddle1b",
    animdictionary = "tigerle@custom@couple@cuddle1b",
    animnametext = "Receiving Cuddle 2",
    animtype = "erp",
    animationid = "cuddleet2",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "cuddleet",
    animgender = "female",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "cuddleet2.webp",
    animname = "tigerle_couple_cuddle1a",
    animdictionary = "tigerle@custom@couple@cuddle1a",
    animnametext = "Kiss 7",
    animtype = "erp",
    animationid = "cuddleet",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "cuddleet2"
  },
  {
    animimg = "kiss8.webp",
    animname = "tigerle_couple_kissing2a",
    animdictionary = "tigerle@custom@couple@kissing2a",
    animnametext = "Giving Kiss",
    animtype = "erp",
    animationid = "kiss7",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kiss8",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss17.webp",
    animname = "kissmale9",
    animdictionary = "genesismods_kissme@kissmale9",
    animnametext = "Giving Passionate Kiss",
    animtype = "erp",
    animationid = "kiss17",
    animmeta = {
      animxcoord = 0.35,
      animycoord = 0.0,
      animzcoord = 0.0,
      animloop = true,
      animmovement = false,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true
    },
    coupleanim = "kiss18",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "kiss17.webp",
    animname = "kissfemale9",
    animdictionary = "genesismods_kissme@kissfemale9",
    animnametext = "Kiss 9(Female)",
    animtype = "erp",
    animationid = "kiss18",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "kiss17"
  },
  {
    animimg = "lovepose12f.webp",
    animname = "m_couple_07_clip",
    animdictionary = "anim@male_couple_07",
    animnametext = "Initiating Selfie Love",
    animtype = "erp",
    animationid = "lovepose12m",
    animmeta = {
      animmovement = false,
      animloop = true
    },
    coupleanim = "lovepose12f",
    animgender = "male",
    animisadult = true,
    animcoupletype = "Paired"
  },
  {
    animimg = "lovepose12f.webp",
    animname = "f_couple_07_clip",
    animdictionary = "anim@female_couple_07",
    animnametext = "Love Pose 12 Female",
    animtype = "erp",
    animationid = "lovepose12f",
    animmeta = {
      animxcoord = 0.0,
      animycoord = 0.72,
      animzcoord = 0.1,
      animloop = true,
      animmovement = false,
      PropPlacement = {
        0.12,
        0.016,
        -0.034,
        0.0,
        90.0,
        -180.0
      },
      animboneindex = 0,
      animzrotation = 0.0,
      animyrotation = 0.0,
      animxrotation = 0.0,
      animglue = true,
      Propanimboneindex = 6286,
      Prop = "prop_phone_ing_03"
    },
    coupleanim = "lovepose12m"
  },
}
