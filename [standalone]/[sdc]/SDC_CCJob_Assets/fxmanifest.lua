fx_version 'cerulean'
games { 'gta5' }

author 'HoboDevCo#3011'
description 'SDC | Car Crusher Job Assets'
version '1.0.0'

lua54 'yes'
this_is_a_map 'yes'


data_file 'DLC_ITYP_REQUEST' 'stream/custom_models/sdc_ccjmodels.ytyp'

files {
    'stream/vstruck/metas/*.meta'
}
data_file 'HANDLING_FILE' 'stream/vstruck/metas/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'stream/vstruck/metas/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'stream/vstruck/metas/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'stream/vstruck/metas/carvariations.meta'
dependency '/assetpacks'