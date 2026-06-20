Hey! Thanks for purchasing my script. Remember:
   - You are not allowed to resell or release my scripts

Requirements:
   - none

Installing the script:
   1. Download the file and extract "tk_graffiti" into your resources folder
   2. Add "start tk_graffiti" into your server.cfg file
   3. Edit config.lua to your liking
   4. Restart your server

Items (ox_inventory):
	["spray_can"] = {
		label = "Spray Can",
		weight = 100,
		stack = true,
		close = true,
	},

	["spray_cloth"] = {
		label = "Spray Remover Cloth",
		weight = 50,
		stack = true,
		close = true,
	},

Items (qb-inventory):
	spray_can = {['name'] = 'spray_can', ['label'] = 'Spray Can', ['weight'] = 100, ['type'] = 'item', ['image'] = 'spray_can.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Spray Can'},
	spray_cloth = {['name'] = 'spray_cloth', ['label'] = 'Spray Remover Cloth', ['weight'] = 50, ['type'] = 'item', ['image'] = 'spray_cloth.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Spray Remover Cloth'},

Adding more fonts:
   - https://github.com/antond15/gfx-font-converter

More questions?
   - Join our Discord and open a ticket: https://discord.gg/YndnF9tkqu