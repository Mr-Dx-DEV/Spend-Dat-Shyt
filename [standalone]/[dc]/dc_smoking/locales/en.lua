Locales['en'] = {

    -------------------------------------------------
    -- KEYBINDS (shown in FiveM settings menu)
    -------------------------------------------------
    ['keybind.inhale']              = 'Smoking: Inhale/Light',
    ['keybind.give_item']           = 'Smoking: Give Item',
    ['keybind.cancel']              = 'Smoking: Stop/Cancel',
    ['keybind.hand_to_mouth']       = 'Smoking: Hand to Mouth',
    ['keybind.pass_item']           = 'Smoking: Pass Item',
    ['keybind.ash_item']            = 'Smoking: Ash Item',
    ['keybind.bong_water']          = 'Smoking: Bong Water Menu',
    ['keybind.clip_cigar']          = 'Smoking: Clip Cigar',
    ['keybind.freak_item']          = 'Smoking: Freak Item',
    ['keybind.charge_vape']         = 'Smoking: Charge Vape',
    ['keybind.smoke_rings']         = 'Smoking: Toggle Smoke Rings',
    ['keybind.throw_away']          = 'Smoking: Throw Away',
    ['keybind.view_contents']       = 'Smoking: View Contents',

    -------------------------------------------------
    -- CONTROL LABELS (shown on the HUD overlay)
    -- %s = item label
    -------------------------------------------------
    ['control.light_item']          = 'Light',
    ['control.relight_item']        = 'Re-light',
    ['control.inhale_item']         = 'Hold To Inhale',
    ['control.load_item']           = 'Load %s',
    ['control.load_bong']           = 'Load Bong',
    ['control.refill_vape']         = 'Refill Vape',
    ['control.grab_one']            = 'Grab One',
    ['control.add_item']            = 'Add Item',

    -------------------------------------------------
    -- NOTIFICATIONS — SMOKING
    -------------------------------------------------
    ['notify.lit_up']               = 'Lit up.',
    ['notify.lighter_empty'] = 'Your lighter is out of fluid',
    ['notify.it_went_out']          = 'It went out.',
    ['notify.cherry_went_out']      = 'The cherry went out! Light it again.',
    ['notify.its_finished']         = "It's finished.",
    ['notify.its_empty_pack_first'] = "It's empty! You need to pack it first.",
    ['notify.tank_empty']           = 'Tank is empty.',
    -- %s = type label (Bong / Pipe)
    ['notify.device_empty']         = '%s is empty.',
    ['notify.relax']                = 'Relax...',
    ['notify.held_in_hand']         = 'Held in hand.',
    ['notify.held_in_mouth']        = 'Held in mouth.',
    ['notify.put_away']             = 'Put away.',
    ['notify.threw_it_away']        = 'Threw it away.',
    ['notify.cant_throw_away']      = "You can't throw this away.",
    ['notify.already_holding']      = 'You are already holding something!',
    ['notify.already_busy']         = 'You are already busy! (/smokefix to reset)',
    ['notify.cant_while_driving']   = "Can't do that while driving.",
    ['notify.smoke_state_reset']    = 'Smoke state fully reset.',
    -- %s = label suffix
    ['notify.label_freaked']        = ' (Freaked)',

    -------------------------------------------------
    -- NOTIFICATIONS — LIGHTER / WEATHER
    -------------------------------------------------
    ['notify.need_lighter']         = 'You need a lighter!',
    ['notify.lighter_selected']     = 'Lighter selected. Press inhale to light.',
    ['notify.hold_lighter_info']    = 'Hold this while lighting something.',

    -------------------------------------------------
    -- NOTIFICATIONS — CIGAR
    -------------------------------------------------
    ['notify.clip_cigar_first']     = 'You need to clip the cigar first!',
    ['notify.cigar_clipped']        = 'Cigar clipped — ready to light.',
    ['notify.no_clipping_needed']   = "This item doesn't need clipping.",
    ['notify.already_lit']          = 'Already lit!',
    ['notify.already_clipped']      = 'Already clipped.',
    ['notify.need_cigar_clipper']   = 'You need a cigar clipper!',

    -------------------------------------------------
    -- NOTIFICATIONS — FREAK
    -------------------------------------------------
    ['notify.cant_freak_lit']       = "Can't freak it while it's lit!",
    ['notify.already_freaked']      = 'Already freaked.',
    ['notify.freak_success']        = 'Removed the cancer paper — smoother hit incoming.',

    -------------------------------------------------
    -- NOTIFICATIONS — PASSING / GIVING
    -------------------------------------------------
    ['notify.no_one_nearby']        = 'No one nearby to pass to.',
    ['notify.offering_smoke']       = 'Offering smoke...',
    -- %d = sender player ID
    ['notify.pass_request']         = 'Player %d is passing you a smoke. [Y] Accept / [N] Deny',
    ['notify.pass_timed_out']       = 'Pass request timed out.',
    ['notify.you_took_the_hit']     = 'You took the hit.',
    ['notify.passed_item']          = 'Passed item.',
    ['notify.someone_passed_smoke'] = 'Someone passed you a smoke.',
    ['notify.nothing_to_do']        = 'Nothing to do right now.',
    ['notify.item_given']           = 'Item given.',
    ['notify.someone_gave_item']    = 'Someone gave you an item.',
    -- %s = pack name
    ['notify.received_pack']        = 'You received a %s',
    ['notify.they_declined_offer']  = 'They declined your offer.',
    ['notify.they_declined_pass']   = 'They declined your request to pass',
    ['notify.failed_give_item']     = 'Failed to give item.',
    ['notify.failed_give_pack']     = 'Failed to give pack.',
    ['notify.item_no_longer_avail'] = 'Item no longer available.',
    ['notify.failed_locate_receiver'] = 'Failed to locate item on receiver.',

    -------------------------------------------------
    -- NOTIFICATIONS — VAPE / BATTERY
    -------------------------------------------------
    ['notify.battery_dead']         = 'Battery is dead! Press your Charge key to charge.',
    ['notify.battery_died']         = 'Battery died!',
    ['notify.battery_already_full'] = 'Battery is already full.',
    ['notify.need_charger']         = 'You need a charger!',
    -- %d = charge duration in seconds
    ['notify.charging']             = 'Charging... ~%ds (press B to cancel)',
    ['notify.fully_charged']        = 'Fully charged!',
    -- %d = battery percent
    ['notify.stopped_charging']     = 'Stopped charging. Battery: %d%%',
    ['notify.cant_charge']          = "This device can't be charged.",
    ['notify.disposed_vape']        = 'Disposed of empty vape.',
    ['notify.keeping_dead_vape']    = "Keeping empty vape. It's dead.",

    -------------------------------------------------
    -- NOTIFICATIONS — BONG WATER
    -------------------------------------------------
    ['notify.must_hold_bong']       = 'You must be holding a bong.',
    ['notify.no_liquid_config']     = 'No liquid options configured.',
    ['notify.no_liquids']           = "You don't have any liquids to add.",
    ['notify.bong_water_emptied']   = 'Bong water emptied.',
    ['notify.invalid_liquid']       = 'Invalid liquid.',
    -- %s = liquid label
    ['notify.filled_bong']          = 'Filled bong with %s.',
    ['notify.bong_needs_water']     = 'Your bong needs water! Press your Bong Water key to fill.',

    -------------------------------------------------
    -- NOTIFICATIONS — GRINDER
    -------------------------------------------------
    ['notify.grinder_not_configured'] = 'Grinder not configured!',
    ['notify.cancelled']            = 'Cancelled.',

    -------------------------------------------------
    -- NOTIFICATIONS — SMOKE RINGS
    -------------------------------------------------
    ['notify.smoke_rings_on']       = 'Smoke rings enabled',
    ['notify.smoke_rings_off']      = 'Smoke rings disabled',

    -------------------------------------------------
    -- NOTIFICATIONS — KIEF
    -------------------------------------------------
    ['notify.kief_not_configured']  = 'Kief not configured!',

    -------------------------------------------------
    -- NOTIFICATIONS — REFILL / PACK (smoking.lua)
    -------------------------------------------------
    ['notify.no_refill_config']     = 'No refill config found.',
    ['notify.no_bag_slots']         = 'Could not read bag contents.',
    ['notify.nothing_to_pack']      = "You don't have anything to pack this with.",

    -------------------------------------------------
    -- NOTIFICATIONS — INVENTORY / VALIDATION (server)
    -------------------------------------------------
    ['notify.too_far_away']         = 'Too far away!',
    ['notify.player_busy']          = 'That player is busy!',
    ['notify.target_inv_full']      = 'Target inventory full.',
    ['notify.inventory_full']       = 'Inventory full!',
    ['notify.inv_full_cant_carry']  = 'Inventory full! Cannot carry result.',
    ['notify.inv_full_ground_weed'] = 'Inventory full! Cannot carry ground weed.',
    ['notify.your_inv_full']        = 'Your inventory is full.',
    ['notify.they_no_inv_space']    = "They don't have inventory space.",
    ['notify.player_not_found']     = 'Player not found.',
    ['notify.target_moved_too_far'] = 'Target moved too far',
    ['notify.pockets_full_dropped'] = 'Pockets full, Item dropped!',
    ['notify.could_not_add_item']   = 'Could not add item to inventory!',

    -------------------------------------------------
    -- NOTIFICATIONS — BAG
    -------------------------------------------------
    ['notify.bag_not_found']        = 'Bag not found!',
    ['notify.bag_too_full']         = 'Bag is too full!',
    -- %d = grams, %s = strain name
    ['notify.bag_added']            = 'Added %dg of %s',
    ['notify.bag_error_remove']     = 'Error removing item.',
    ['notify.bag_not_enough_weed']  = 'You do not have enough weed.',
    -- %s = strain, %d = current amount
    ['notify.bag_not_enough_strain'] = 'Not enough %s (Has: %dg)',
    -- %d = amount taken
    ['notify.bag_took_out']         = 'Took out %dg',
    ['notify.not_enough_to_roll']   = 'Not enough to roll with.',

    -------------------------------------------------
    -- NOTIFICATIONS — ROLLING
    -------------------------------------------------
    ['notify.invalid_amount']       = 'Invalid amount.',
    ['notify.invalid_amount_whole'] = 'Invalid amount. Whole numbers only.',
    -- %d = max grams
    ['notify.wrap_max_capacity']    = 'This wrap can only hold %dg!',
    -- %d = max grams (wrapper)
    ['notify.wrapper_max_capacity'] = 'Wrapper can only hold %dg!',
    -- %d = available grams
    ['notify.only_have_strain']     = 'You only have %dg of that strain.',
    -- %d = available grams
    ['notify.bag_only_has']         = 'Bag only has %dg of this!',
    ['notify.put_away_for_later']   = 'Put away for later',
    -- %s = ingredient label
    ['notify.need_ingredient']      = 'You need %s!',
    -- %d = min, %d = max
    ['notify.invalid_amount_range'] = 'Invalid amount. Use %d - %dg',

    -------------------------------------------------
    -- NOTIFICATIONS — SPLIFF / HASH SPLIFF
    -------------------------------------------------
    ['notify.spliff_not_configured']     = 'Spliff recipe not configured.',
    ['notify.spliff_not_configured_sv']  = 'Spliff recipe not configured!',
    ['notify.hash_spliff_not_configured'] = 'Hash spliff recipe not configured.',
    ['notify.hash_spliff_not_configured_sv'] = 'Hash spliff recipe not configured!',
    ['notify.not_enough_weed_bag_05']    = 'Not enough weed in bag! Need at least 0.5g',
    ['notify.need_tobacco_spliff']       = 'You need tobacco to roll a spliff!',
    ['notify.need_papers']               = 'You need rolling papers!',
    ['notify.need_hashish']              = 'You need hashish to roll a hash spliff!',
    ['notify.need_tobacco_hash']         = 'You need tobacco to roll a hash spliff!',

    -------------------------------------------------
    -- NOTIFICATIONS — SERVER ROLLING RESULTS
    -------------------------------------------------
    ['notify.not_enough_weed_bag']  = 'Not enough weed in bag!',
    ['notify.ground_weed_not_found'] = 'Ground weed not found!',
    ['notify.not_enough_ground']    = 'Not enough ground weed!',
    ['notify.failed_use_ground']    = 'Failed to use ground weed!',
    -- %s = strain
    ['notify.not_enough_grams']     = 'Not Enough %s grams',
    ['notify.invalid_wrapper']      = 'Invalid wrapper!',
    -- %s = type (joint/blunt/leaf)
    ['notify.need_wrapper_type']    = 'You need a %s wrapper!',
    ['notify.kief_empty']           = 'Your kief is empty!',
    ['notify.kief_not_found']       = 'Kief not found in inventory',
    ['notify.failed_add_rolled']    = 'Failed to add rolled item! Check inventory space.',
    -- %d = amount, %s = type
    ['notify.rolled_success']       = 'Rolled %dg %s',
    -- %d = bonus percent
    ['notify.rolled_kief_suffix']   = ' with kief (+%d%% potency)',
    -- %s = strain label
    ['notify.rolled_spliff']        = 'Rolled a %s spliff!',
    ['notify.rolled_hash_spliff']   = 'Rolled a hash spliff!',
    ['notify.failed_add_spliff']    = 'Failed to add spliff! Check inventory space.',
    ['notify.failed_add_hash_spliff'] = 'Failed to add hash spliff! Check inventory space.',

    -------------------------------------------------
    -- NOTIFICATIONS — SERVER PACKS
    -------------------------------------------------
    ['notify.pack_empty']           = 'Pack is empty!',
    ['notify.pack_full']            = 'Pack is full!',
    ['notify.cant_return_used']     = "Can't return used items!",
    ['notify.not_enough_items']     = 'You do not have enough items!',
    -- %d = amount
    ['notify.pack_took_out']        = 'Took out %d',
    -- %d = amount
    ['notify.pack_put_back']        = 'Put back %d',
    ['notify.invalid_pack']         = 'Invalid pack!',

    -------------------------------------------------
    -- NOTIFICATIONS — SERVER REFILL
    -------------------------------------------------
    ['notify.not_enough_weed']      = 'Not enough weed!',
    ['notify.not_enough_tobacco']   = 'Not enough tobacco!',
    ['notify.need_hashish_sv']      = 'You need hashish!',
    ['notify.need_tobacco_sv']      = 'You need tobacco!',
    ['notify.need_papers_sv']       = 'You need rolling papers!',
    ['notify.you_dont_have_item']   = 'You do not have that item',
    ['notify.failed_use_weed']      = 'Failed to use weed!',

    -------------------------------------------------
    -- NOTIFICATIONS — SERVER BONG LIQUID
    -------------------------------------------------
    ['notify.invalid_liquid_sv']    = 'Invalid liquid!',
    ['notify.no_liquid_item']       = 'You do not have that liquid!',
    ['notify.failed_use_liquid']    = 'Failed to use liquid!',

    -------------------------------------------------
    -- NOTIFICATIONS — SERVER GRINDER
    -------------------------------------------------
    ['notify.invalid_grinder']      = 'Invalid grinder!',
    ['notify.grinder_not_found']    = 'Grinder not found!',
    ['notify.not_enough_kief_collect'] = 'Not enough kief to collect!',

    -------------------------------------------------
    -- NOTIFICATIONS — SERVER KIEF
    -------------------------------------------------
    ['notify.kief_not_found_sv']    = 'Kief not found!',
    ['notify.not_enough_kief']      = 'Not enough kief!',
    ['notify.rolled_item_not_found'] = 'Rolled item not found!',

    -------------------------------------------------
    -- NOTIFICATIONS — SERVER MIXING
    -------------------------------------------------
    ['notify.invalid_component_amount'] = 'Invalid component amount!',
    ['notify.invalid_mix_components']   = 'Invalid mix components!',
    ['notify.invalid_mix']              = 'Invalid mix!',
    ['notify.cant_determine_output']    = 'Could not determine output item!',
    -- %s = component label
    ['notify.not_enough_component'] = 'Not enough %s!',
    -- %s = component label
    ['notify.missing_component']    = 'Missing %s!',
    -- %s = description
    ['notify.rolled_mix']           = 'Rolled: %s',

    -------------------------------------------------
    -- NOTIFICATIONS — WIZARD
    -------------------------------------------------
    ['notify.wizard_denied']        = 'You do not have permission to use the item wizard.',

    -------------------------------------------------
    -- MENU HEADERS
    -------------------------------------------------
    ['menu.select_strain']          = 'Select Strain',
    ['menu.select_lighter']         = 'Select Lighter',
    ['menu.actions']                = 'Actions',
    ['menu.bong_water']             = 'Bong Water',
    ['menu.add_weed']               = 'Add Weed',
    ['menu.take_weed_out']          = 'Take Weed Out',
    ['menu.add_fill']               = 'Add Fill',
    ['menu.additives']              = 'Additives (optional)',
    ['menu.enhancers']              = 'Enhancers (optional)',
    ['menu.confirm_roll']           = 'Confirm Roll',
    ['menu.choose_wrapper']         = 'Choose a Wrapper',
    ['menu.kief']                   = 'Kief',

    -------------------------------------------------
    -- MENU SUBTITLES
    -------------------------------------------------
    -- %s = wrapper label, %.1f = capacity
    ['menu.sub_wrapper_capacity']   = 'Wrapper: %s  |  Capacity: %.1fg',
    -- %.1f = remaining
    ['menu.sub_remaining_capacity'] = '%.1fg remaining capacity',
    ['menu.sub_add_kief_potency']   = 'Add kief for bonus potency',
    ['menu.sub_select_roll_with']   = 'Select what to roll with',
    ['menu.sub_select_strain_add']  = 'Select strain to add',
    ['menu.sub_select_strain_remove'] = 'Select strain to remove',
    -- %d = available grams, %s = strain label
    ['menu.sub_strain_available']   = '%dg of %s available',

    -------------------------------------------------
    -- MENU OPTION LABELS
    -------------------------------------------------
    -- %s = strain label
    ['menu_label.pack_ground']      = 'Pack Ground %s',
    -- %s = strain label
    ['menu_label.pack_ground_kief'] = 'Pack Ground %s + Kief',
    -- %s = display label
    ['menu_label.pack_item']        = 'Pack %s',
    -- %s = display label
    ['menu_label.pack_item_kief']   = 'Pack %s + Kief',
    ['menu_label.put_weed_in']      = 'Put Weed In',
    ['menu_label.take_weed_out']    = 'Take Weed Out',
    ['menu_label.bag_empty']        = 'Bag is Empty',
    ['menu_label.roll_from_bag']    = 'Roll From Bag',
    ['menu_desc.roll_from_bag']     = 'Roll up using weed from this bag',
    -- %s = strain label
    ['menu_label.add_strain']       = 'Add %s',
    ['menu_label.go_back']          = 'Go Back',
    ['menu_label.skip_this']        = 'Skip This',
    ['menu_label.continue']         = 'Continue',
    ['menu_label.cancel']           = 'Cancel',
    ['menu_label.none_available']   = 'None Available',
    ['menu_label.no_herb']          = 'No herb available',
    ['menu_label.confirm_and_roll'] = 'Confirm & Roll',
    ['menu_label.no_stat_effects']  = 'No stat effects',
    -- %d = player server ID
    ['menu_label.player_id']        = 'ID #%d',
    ['menu_label.empty_bong_water'] = 'Empty Bong Water',
    -- %s = liquid label
    ['menu_label.add_liquid']       = 'Add %s',
    -- %s = strain label
    ['menu_label.grind_strain']     = 'Grind %s',
    ['menu_label.no_weed_to_grind'] = 'No Weed to Grind',
    ['menu_label.collect_kief']     = 'Collect Kief',
    ['menu_label.sprinkle_kief']    = 'Sprinkle Kief',
    ['menu_label.press_to_hash']    = 'Press to Hash',
    -- %d = kief needed
    ['menu_label.press_hash_need']  = 'Press to Hash (Need %dg)',
    ['menu_label.put_away']         = 'Put Away',

    -------------------------------------------------
    -- MENU OPTION DESCRIPTIONS
    -------------------------------------------------
    -- %d = gram count
    ['menu_desc.ground_weed_bonus'] = 'Ground weed (%dg) - 10%% bonus',
    -- %d = bonus percent
    ['menu_desc.ground_kief_potency'] = 'Ground weed + kief (+%d%% potency)',
    -- %s = item label
    ['menu_desc.load_into']         = 'Load into %s',
    -- %d = bonus percent
    ['menu_desc.top_kief_potency']  = 'Top with kief (+%d%% potency) - Uses 0.5g kief',
    ['menu_desc.add_grams_pockets'] = 'Add grams from your pockets',
    ['menu_desc.to_inventory']      = 'To Inventory',
    ['menu_desc.bag_empty_desc']    = 'No weed in bag or in your pockets',
    -- %d = gram count
    ['menu_desc.you_have_grams']    = 'You have %dg',
    ['menu_desc.give_to_player']    = 'Give to this player',
    -- %s = liquid name
    ['menu_desc.dump_liquid']       = 'Dump out the %s',
    -- %s = taste text
    ['menu_desc.taste']             = 'Taste: %s',
    -- %s = liquid label
    ['menu_desc.fill_bong_with']    = 'Fill bong with %s',
    -- %d = count, %d = max per grind
    ['menu_desc.grind_available']   = 'Available: %dg (max %dg per grind)',
    ['menu_desc.need_loose_grams']  = 'You need loose grams in your inventory',
    -- %.2f = kief amount
    ['menu_desc.harvest_kief']      = 'Harvest %.2fg kief from catcher',
    ['menu_desc.close_menu']        = 'Close menu',
    -- %.1f = available, %.1f = capacity
    ['menu_desc.herb_fill_wrap']    = 'You need herb or ground weed to fill this wrap',
    -- %.1f = grams available
    ['menu_desc.grams_available']   = '%.1fg available',
    -- %d = grams available
    ['menu_desc.grams_available_d'] = '%dg available',
    -- %d = count, suffix "g available"
    ['menu_desc.count_g_available'] = '%sg available',
    ['menu_desc.adds_burn_stability'] = 'Adds burn stability, reduces high',
    -- %s = stats description (needs tobacco carrier)
    ['menu_desc.needs_tobacco']     = '%s (needs tobacco carrier)',
    ['menu_desc.no_additives']      = 'You have no additives on you',
    ['menu_desc.no_enhancers']      = 'You have no enhancers on you',
    -- %.0f = bonus percent, %.2f = available, %.1f = uses
    ['menu_desc.enhancer_potency']  = '+%.0f%% potency (%.2fg available, uses %.1fg)',
    -- %s = capacity, %s = have count
    ['menu_desc.capacity_have']     = 'Capacity: %sg  |  Have: %s',
    -- %s = label
    ['menu_desc.as_wrap_suffix']    = '%s (as wrap)',
    ['menu_desc.natural_wrap']      = 'Can be used as a natural wrap',
    ['menu_desc.no_wraps']          = 'No wraps available',
    ['menu_desc.no_wraps_on_you']   = 'You have no wraps on you',
    ['menu_desc.start_rolling']     = 'Start rolling this mix',
    ['menu_desc.return_prev_step']  = 'Return to previous step',
    -- %.2f = kief amount
    ['menu_desc.kief_amount']       = 'Amount: %.2fg',
    -- %d = kief per press
    ['menu_desc.compress_kief']     = 'Compress %dg kief into hashish',
    -- %.2f = current, %d = needed
    ['menu_desc.kief_have_need']    = 'You have %.2fg, need %dg',
    -- %d = grams, suffix "(+10% bonus)"
    ['menu_desc.ground_bonus_fmt']  = '%dg (+10%% bonus)',
    -- %s = strain label, suffix " (bag)"
    ['menu_desc.strain_bag']        = '%s (bag)',
    -- %s = label, suffix " (pocket)"
    ['menu_desc.strain_pocket']     = '%s (pocket)',
    -- %s = strain label + grind label
    ['menu_desc.ground_strain']     = 'Ground %s',
    -- %d = total grams, %d = slots
    ['menu_desc.ground_aggregated'] = '%dg available (%d slots)',
    ['menu_desc.tap_to_remove']     = 'Tap to remove',
    -- %d = grams
    ['menu_desc.queued_grams']      = '%dg queued',
    ['menu_desc.continue_additives'] = 'Proceed to additives',

    ['menu_label.confirm_herbs']    = 'Confirm & Continue',
    -- %s = strain, %d = grams
    ['menu_label.queued_entry']     = '%s (%dg)',

    -- %d = queued grams, %d = remaining capacity
    ['menu.sub_fill_status']        = '%dg queued  |  %dg remaining',

    ['notify.select_at_least_one']  = 'Select at least one herb first',

    ['label.mixed_strains']         = 'Mixed Strains',
    ['menu.contents_title']         = 'Contents',
    ['contents.wrapper']            = 'Wrapper',
    ['contents.tobacco']            = 'Tobacco',

    -------------------------------------------------
    -- MENU — MIXING STAT LABELS
    -------------------------------------------------
    -- %d = value
    ['menu_label.stat_high']        = 'High %s',
    ['menu_label.stat_stress']      = 'Stress %s',
    ['menu_label.stat_armor']       = 'Armor %s',
    -- %.0f = percent
    ['menu_label.harsh']            = 'Harsh: %.0f%%',
    -- %.0f = percent
    ['menu_label.cherry_out']       = 'Cherry-out: %.0f%%',
    -- %.1f = rate
    ['menu_desc.burn_rate']         = 'Burn rate: %.1f/s',

    -------------------------------------------------
    -- PROGRESS BAR LABELS
    -------------------------------------------------
    ['progress.packing']            = 'Packing...',
    ['progress.packing_kief']       = 'Packing with kief...',
    ['progress.refilling']          = 'Refilling...',
    ['progress.freaking']           = 'Freaking it...',
    -- %d = amount, %s = strain
    ['progress.rolling']            = 'Rolling %dg %s...',
    -- %d = amount, %s = strain
    ['progress.rolling_ground']     = 'Rolling %dg Ground %s...',
    -- %d = amount, %s = strain
    ['progress.rolling_kief']       = 'Rolling %dg %s with kief...',
    -- %d = amount
    ['progress.rolling_spliff']     = 'Rolling spliff with %dg weed...',
    ['progress.crumbling_hash']     = 'Crumbling hash and rolling...',
    ['progress.mixing_rolling']     = 'Mixing & Rolling...',
    ['progress.emptying']           = 'Emptying...',
    ['progress.filling_bong']       = 'Filling bong...',
    -- %d = amount
    ['progress.grinding']           = 'Grinding %dg...',
    ['progress.collecting_kief']    = 'Collecting kief...',
    ['progress.pressing_kief']      = 'Pressing kief into hash...',

    -------------------------------------------------
    -- INPUT DIALOG TITLES
    -------------------------------------------------
    ['input.select_amount']         = 'Select Amount',
    -- %d = max grams
    ['input.grams_max']             = 'Grams (1 - %d)',
    -- %s = strain label, %d = bag has, %d = max
    ['input.takeout_strain']        = '%s — Bag has: %dg | Max: %dg',
    -- %.1f = min, %.1f = max
    ['input.grams_weed_range']      = 'Grams of weed (%s - %s)',
    ['input.enter_amount']          = 'Enter Amount',
    ['input.grams_to_grind']        = 'Grams to Grind',
    ['input.how_much_roll']         = 'How much to roll?',
    -- %s = strain, %s = wrapper, %d = max
    ['input.roll_subtitle']         = '%s into %s (max %dg)',

    -------------------------------------------------
    -- METADATA DESCRIPTIONS (shown in inventory tooltips)
    -------------------------------------------------
    ['meta.empty']                  = 'Empty',
    -- %s = contents string
    ['meta.contains']               = 'Contains: %s',
    -- %d = amount, %d = capacity
    ['meta.contains_pack']          = 'Contains: %d / %d',
    -- %s = strain, %d = grams
    ['meta.strain_grams']           = '%s(%dg) ',
    -- %s = strain label, %d = amount
    ['meta.rolled_description']     = '%s (%sg)',
    -- %s = base desc, %.1f = kief used
    ['meta.rolled_kief_suffix']     = ' + %.1fg Kief',
    -- %s = strain label, %.1f = weed amount
    ['meta.spliff_description']     = '%s Spliff (%.1fg weed + tobacco)',
    ['meta.hash_spliff_description'] = 'Hash Spliff (hash + tobacco)',
    -- %.2f = amount
    ['meta.kief_description']       = '%.2fg Kief',

    -------------------------------------------------
    -- PACK TYPES (shown as subtitle on pack controls)
    -------------------------------------------------
    ['pack.type_pack']              = 'Pack',
    ['pack.type_wraps']             = 'Wraps',

    -------------------------------------------------
    -- GRINDER HEADER SUFFIX
    -------------------------------------------------
    -- %s = grinder label, %.2f = kief amount, %.1f = max kief
    ['grinder.title_with_kief']     = '%s  |  Kief: %.2fg / %.1fg',

    -------------------------------------------------
    -- BONG WATER DEFAULT
    -------------------------------------------------
    ['bong.water']                  = 'water',

    -------------------------------------------------
    -- MIXING CLIENT — NOT ENOUGH
    -------------------------------------------------
    ['notify.no_active_session']    = 'No active mix session!',
    ['notify.not_enough_capacity']  = 'Not enough capacity or material!',
    -- %d = max grams
    ['notify.invalid_amount_max']   = 'Invalid amount. Use 1 - %dg',
    ['notify.not_enough_additive']  = 'Not enough capacity for this additive!',
    ['notify.invalid_wrapper_cl']   = 'Invalid wrapper!',
    ['notify.not_enough_for_wrapper'] = 'Not enough weed for this wrapper.',

    -------------------------------------------------
    -- ROLLING — ADDITIONAL (bag manage, pack, give)
    -------------------------------------------------
    -- %d = player grams
    ['notify.only_have_grams']      = 'You only have %dg!',
    -- %.1f = space left
    ['notify.bag_not_enough_space'] = "Bag doesn't have enough space. Only %.1fg left.",
    ['notify.no_items_to_add']      = "You don't have any to add.",
    ['notify.thrown_away']          = 'Thrown away.',
    ['notify.offering_item']        = 'Offering item...',
    ['notify.offering_pack']        = 'Offering pack...',
    -- %d = sender player ID
    ['notify.give_request']         = 'Player %d wants to give you something. [Y] Accept / [N] Deny',
    ['notify.give_timed_out']       = 'Give request timed out.',
    ['notify.no_one_nearby_give']   = 'No one nearby to give to.',
    ['notify.pack_empty_cl']        = 'Pack is empty!',
    ['notify.pack_full_cl']         = 'Pack is full!',

    -------------------------------------------------
    -- ROLLING — ADDITIONAL MENU LABELS
    -------------------------------------------------
    -- %s = item label
    ['menu_label.add_item_label']   = 'Add %s',
    -- %d = available count
    ['menu_desc.count_available']   = '%d available',

    -------------------------------------------------
    -- ROLLING — ADDITIONAL MENU HEADERS
    -------------------------------------------------
    ['menu.add_item']               = 'Add Item',
    ['menu.give_pack']              = 'Give Pack',
    ['menu.give_bag']               = 'Give Bag',
    ['menu.give_wrapper']           = 'Give Wrapper',
    ['menu.give_grinder']           = 'Give Grinder',

    -------------------------------------------------
    -- ROLLING — CONTROL LABELS
    -------------------------------------------------
    ['control.open_bag']            = 'Open Bag',
    ['control.open_grinder']        = 'Open Grinder',
    ['control.roll_up']             = 'Roll Up',

    -------------------------------------------------
    -- SERVER — REFILL SUCCESS
    -------------------------------------------------
    ['notify.packed_ready']         = 'Packed & Ready',
    ['notify.packed_ground']        = 'Packed ground weed (+10%% potency)',
    ['notify.packed_kief']          = 'Packed with kief (+%d%% potency)',
    ['notify.packed_ground_kief']   = 'Packed ground weed + kief (stacked bonuses!)',

    -------------------------------------------------
    -- SERVER — GRINDER SUCCESS
    -------------------------------------------------
    -- %d = amount, %s = strain, %.1f = bonus%, %.2f = kief produced
    ['notify.ground_success']       = 'Ground %dg %s (+%.1f%% bonus). Kief: +%.2fg',
    -- %.2f = kief amount
    ['notify.collected_kief']       = 'Collected %.2fg kief!',

    -------------------------------------------------
    -- SERVER — KIEF / HASH
    -------------------------------------------------
    -- %d = kief needed, %.2f = kief have
    ['notify.need_kief_amount']     = 'Need %dg kief! You have %.2fg',
    -- %d = kief per press
    ['notify.pressed_kief']         = 'Pressed %dg kief into 1g hashish!',
    -- %.2f = kief used, %.0f = bonus percent
    ['notify.added_kief_rolled']    = 'Added %.2fg kief! (+%.0f%% potency)',

    -------------------------------------------------
    -- SERVER — METADATA DESCRIPTIONS
    -------------------------------------------------
    -- %s = grind label, %s = strain label, %.0f = total grams
    ['meta.ground_weed_desc']       = '%s %s (%.0fg)',
    -- %.2f = kief amount, %.1f = max kief
    ['meta.kief_grinder']           = 'Kief: %.2fg / %.1fg',
    -- %.1f = max kief
    ['meta.kief_grinder_empty']     = 'Kief: 0.00g / %.1fg',
    -- %s = hash label
    ['meta.hashish_desc']           = '%s (1g - pressed from kief)',
    ['meta.kief_added_suffix']      = ' [+Kief]',

    -------------------------------------------------
    -- SERVER — ROLLING SUCCESS (dynamic)
    -------------------------------------------------
    -- %d = amount, %s = type
    ['notify.rolled_success_sv']    = 'Rolled %dg %s',
    -- %d = bonus percent
    ['notify.rolled_kief_suffix_sv'] = ' with kief (+%d%% potency)',
}
