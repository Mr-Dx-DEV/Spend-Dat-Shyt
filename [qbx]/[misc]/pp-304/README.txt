pp-304 install

1. Put the folder `pp-304` in your resources directory.
2. Add `ensure pp-304` to server.cfg after ox_lib, ox_inventory, and ox_target.
3. Add these items to your ox_inventory/data/items.lua:

['date_phone'] = {
    label = '304 Phone',
    weight = 20,
    stack = false,
    close = true,
    consume = 0,
    description = 'A private booking phone for social companion jobs.',
    client = {
        export = 'pp-304.useDatePhone'
    }
},

['pink_dirty_money'] = {
    label = 'Pink Dirty Money',
    weight = 0,
    stack = true,
    close = true,
    description = 'Unwashed cash in pink bills.'
},

