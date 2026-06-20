fx_version 'cerulean'
games { 'gta5' }

author 'HoboDevCo#3011'
description 'SDC | Tug Job Assets'
version '1.0.0'

lua54 'yes'
this_is_a_map 'yes'


data_file 'DLC_ITYP_REQUEST' 'stream/custom_models/tbridge.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/custom_models/vbridge.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/custom_models/barge.ytyp'
files {
    'stream/tugboat/metas/*.meta'
}
data_file 'HANDLING_FILE' 'stream/tugboat/metas/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'stream/tugboat/metas/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'stream/tugboat/metas/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'stream/tugboat/metas/carvariations.meta'
dependency '/assetpacks'