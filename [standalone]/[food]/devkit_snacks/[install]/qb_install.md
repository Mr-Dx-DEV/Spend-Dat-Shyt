1. Add images into qb-inventory > html > images.
2. Add items to qb-core > shared > items.lua 
3. ensure `[snacks]` in your resources.cfg
4. Config script to your server's liking under `config` folder.
5. Restart Server and boom!





--#Items for items.lua:
```lua


devkit_bluecrush = { name = 'devkit_bluecrush', label = 'Blue Rush', weight = 200, type = 'item', image = 'devkit_bluecrush.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_bluegatorade = { name = 'devkit_bluegatorade', label = 'Blue Charge', weight = 200, type = 'item', image = 'devkit_bluegatorade.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_cherrycoke = { name = 'devkit_cherrycoke', label = 'Cherry Cola', weight = 200, type = 'item', image = 'devkit_cherrycoke.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_coke = { name = 'devkit_coke', label = 'Cola', weight = 200, type = 'item', image = 'devkit_coke.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_dietdew = { name = 'devkit_dietdew', label = 'Diet Blast', weight = 200, type = 'item', image = 'devkit_dietdew.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_grapekoolaid = { name = 'devkit_grapekoolaid', label = 'Grape Aid', weight = 200, type = 'item', image = 'devkit_grapekoolaid.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_jarrito_grapefruit = { name = 'devkit_jarrito_grapefruit', label = 'Jarrita Grapefruit', weight = 200, type = 'item', image = 'devkit_jarrito_grapefruit.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_jarrito_lime = { name = 'devkit_jarrito_lime', label = 'Jarrita Lime', weight = 200, type = 'item', image = 'devkit_jarrito_lime.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_jarrito_mandarin = { name = 'devkit_jarrito_mandarin', label = 'Jarrita Mandarin', weight = 200, type = 'item', image = 'devkit_jarrito_mandarin.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_jarrito_strawberry = { name = 'devkit_jarrito_strawberry', label = 'Jarrita Strawberry', weight = 200, type = 'item', image = 'devkit_jarrito_strawberry.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_jarritos_mango = { name = 'devkit_jarritos_mango', label = 'Jarrita Mango', weight = 200, type = 'item', image = 'devkit_jarritos_mango.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_mmbluer = { name = 'devkit_mmbluer', label = 'MunchMix Blue Razz', weight = 200, type = 'item', image = 'devkit_mmbluer.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_mmkiwis = { name = 'devkit_mmkiwis', label = 'MunchMix Kiwi Chews', weight = 200, type = 'item', image = 'devkit_mmkiwis.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_mmwatermelon = { name = 'devkit_mmwatermelon', label = 'MunchMix Watermelon', weight = 200, type = 'item', image = 'devkit_mmwatermelon.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_orangegatorade = { name = 'devkit_orangegatorade', label = 'Orange Charge', weight = 200, type = 'item', image = 'devkit_orangegatorade.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prime_blueraspberry = { name = 'devkit_prime_blueraspberry', label = 'Primo Blue Raspberry', weight = 200, type = 'item', image = 'devkit_prime_blueraspberry.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prime_grape = { name = 'devkit_prime_grape', label = 'Primo Grape', weight = 200, type = 'item', image = 'devkit_prime_grape.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prime_icepop = { name = 'devkit_prime_icepop', label = 'Primo Ice Pop', weight = 200, type = 'item', image = 'devkit_prime_icepop.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prime_lemonlime = { name = 'devkit_prime_lemonlime', label = 'Primo Lemon Lime', weight = 200, type = 'item', image = 'devkit_prime_lemonlime.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prime_metamoon = { name = 'devkit_prime_metamoon', label = 'Primo MetaMoon', weight = 200, type = 'item', image = 'devkit_prime_metamoon.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prime_orange = { name = 'devkit_prime_orange', label = 'Primo Orange', weight = 200, type = 'item', image = 'devkit_prime_orange.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prime_tropicalpunch = { name = 'devkit_prime_tropicalpunch', label = 'Primo Tropical Punch', weight = 200, type = 'item', image = 'devkit_prime_tropicalpunch.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_redbull = { name = 'devkit_redbull', label = 'Red Ox', weight = 200, type = 'item', image = 'devkit_redbull.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_redbullsf = { name = 'devkit_redbullsf', label = 'Red Ox Zero', weight = 200, type = 'item', image = 'devkit_redbullsf.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_redgatorade = { name = 'devkit_redgatorade', label = 'Red Charge', weight = 200, type = 'item', image = 'devkit_redgatorade.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_rootbeer = { name = 'devkit_rootbeer', label = 'Root Beer', weight = 200, type = 'item', image = 'devkit_rootbeer.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },


devkit_chilicheesecheetos = { name = 'devkit_chilicheesecheetos', label = 'Chili Cheese Puffs', weight = 20, type = 'item', image = 'devkit_chilicheesecheetos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_cjcheetos = { name = 'devkit_cjcheetos', label = 'CJ Crunchers', weight = 20, type = 'item', image = 'devkit_cjcheetos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_coolranch = { name = 'devkit_coolranch', label = 'Cool Ranch Triangles', weight = 20, type = 'item', image = 'devkit_coolranch.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_doritos = { name = 'devkit_doritos', label = 'Nacho Triangles', weight = 20, type = 'item', image = 'devkit_doritos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_dots = { name = 'devkit_dots', label = 'Dots', weight = 20, type = 'item', image = 'devkit_dots.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_fhbobcheetos = { name = 'devkit_fhbobcheetos', label = 'Spicy Skeleton Puffs', weight = 20, type = 'item', image = 'devkit_fhbobcheetos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_fhccheetos = { name = 'devkit_fhccheetos', label = 'Spicy Crunch Cheetos', weight = 20, type = 'item', image = 'devkit_fhccheetos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_fhcheetos = { name = 'devkit_fhcheetos', label = 'Spicy Lime Cheetos', weight = 20, type = 'item', image = 'devkit_fhcheetos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_fhfcheetos = { name = 'devkit_fhfcheetos', label = 'Spicy Stix', weight = 20, type = 'item', image = 'devkit_fhfcheetos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_fritos = { name = 'devkit_fritos', label = 'Corn Ritos', weight = 20, type = 'item', image = 'devkit_fritos.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_fritos_twist = { name = 'devkit_fritos_twist', label = 'Corn Twistys', weight = 20, type = 'item', image = 'devkit_fritos_twist.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_gobstopper = { name = 'devkit_gobstopper', label = 'Gob Stoppa', weight = 20, type = 'item', image = 'devkit_gobstopper.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_hersheys = { name = 'devkit_hersheys', label = 'Hershays', weight = 20, type = 'item', image = 'devkit_hersheys.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_hottamales = { name = 'devkit_hottamales', label = 'Spicy Tamales', weight = 20, type = 'item', image = 'devkit_hottamales.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_lays = { name = 'devkit_lays', label = 'Wave Potato Chips', weight = 20, type = 'item', image = 'devkit_lays.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_lays_bbq = { name = 'devkit_lays_bbq', label = 'Wave BBQ Chips', weight = 20, type = 'item', image = 'devkit_lays_bbq.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_lays_sc = { name = 'devkit_lays_sc', label = 'Wave Sour Cream Chips', weight = 20, type = 'item', image = 'devkit_lays_sc.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_milkduds = { name = 'devkit_milkduds', label = 'Choco Duds', weight = 20, type = 'item', image = 'devkit_milkduds.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_nerdsgummy = { name = 'devkit_nerdsgummy', label = 'Geek Gummies', weight = 20, type = 'item', image = 'devkit_nerdsgummy.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_prignles = { name = 'devkit_prignles', label = 'Prongles', weight = 20, type = 'item', image = 'devkit_prignles.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_sun_cheddar = { name = 'devkit_sun_cheddar', label = 'Solar Chips Cheddar', weight = 20, type = 'item', image = 'devkit_sun_cheddar.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_sunchip = { name = 'devkit_sunchip', label = 'Solar Chips', weight = 20, type = 'item', image = 'devkit_sunchip.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_sweedishfish = { name = 'devkit_sweedishfish', label = 'Nordic Fish', weight = 20, type = 'item', image = 'devkit_sweedishfish.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_sweettarts = { name = 'devkit_sweettarts', label = 'Tangy Tarts', weight = 20, type = 'item', image = 'devkit_sweettarts.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_takis = { name = 'devkit_takis', label = 'Takiz', weight = 20, type = 'item', image = 'devkit_takis.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_trolli = { name = 'devkit_trolli', label = 'Trollies', weight = 20, type = 'item', image = 'devkit_trolli.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
devkit_whoppers = { name = 'devkit_whoppers', label = 'Poppers', weight = 20, type = 'item', image = 'devkit_whoppers.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
