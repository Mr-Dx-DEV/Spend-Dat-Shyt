const ICON = "img/noimage.webp";

function furnImagePath(item) {
   const code = ((item && (item.object || item.code || item.model || item.prop || item.id)) || "").toString();
   return (item && item.img) || (code ? `img/furnitures/${code}.webp` : ICON);
}

function furnPrice(item) {
   const code = ((item && (item.object || item.code || item.model || item.prop || item.id)) || "").toString();
   const fromItem = item && item.price;
   const fromMap  = code ? RTX_FURNITURE_PRICE_MAP[code] : undefined;
   const raw = (fromItem && fromItem > 0) ? fromItem : fromMap;
   const num = Number(raw);
   return Number.isFinite(num) && num > 0 ? num : 0;
}


const RTX_FURNITURE_PRICE_MAP = {"hei_heist_bed_double_08":946,"v_res_tt_bed":619,"apa_mp_h_yacht_bed_01":617,"v_res_mdbed":752,"xs_x18intmod_standard_bed":696,"apa_mp_h_yacht_bed_02":673,"xs_x18intmod_ind_bed":513,"v_res_tre_bed2":400,"v_res_msonbed":787,"h4_mp_h_yacht_bed_01":908,"gr_prop_bunker_bed_01":840,"tr_int1_campbed":814,"p_lestersbed_s":461,"v_med_mattress":865,"v_res_lestersbed":333,"v_res_mbbed_mess":713,"apa_mp_h_bed_double_09":914,"v_res_tre_bed1_messy":756,"v_res_tre_bed1":705,"p_mbbed_s":592,"v_res_d_bed":743,"m23_2_int4_m232_int_sub_bed":941,"apa_mp_h_bed_wide_05":653,"v_res_mbbed":728,"xs_x18intmod_high_end_bed":561,"v_res_msonbed_s":743,"ex_prop_exec_bed_01":995,"apa_mp_h_bed_with_table_02":739,"v_res_m_armoire":796,"v_res_m_armoirmove":775,"m23_2_int4_m232_wards":600,"v_res_tre_wardrobe":866,"prop_rub_cabinet03":786,"bkr_prop_biker_garage_locker_01":330,"rtx_djn_cabinet_2":780,"rtx_djn_cabinet_4":855,"rtx_djn_cabinet_6":390,"rtx_djn_cabinet_7_b":503,"rtx_djn_cabinet_7_g":506,"rtx_djn_cabinet_7_r":331,"rtx_djn_cabinet_7_y":309,"rtx_djn_cabinet_8_d":969,"rtx_djn_cabinet_8_l":975,"rtx_djn_cabinet_9_d":771,"rtx_djn_cabinet_9_l":709,"rtx_djn_cabinet_10_d":872,"rtx_djn_cabinet_10_l":911,"v_res_mdbedtable":636,"v_res_m_sidetable":861,"v_res_tre_bedsidetable":421,"prop_rub_cabinet01":991,"tr_int1_sideboard_style2_015":829,"apa_mp_h_str_sideboardl_13":938,"apa_mp_h_str_sideboardl_11":698,"hei_heist_bed_chestdrawer_04":941,"apa_mp_h_bed_chestdrawer_02":979,"tr_int1_sideboard_style2_02":609,"tr_int1_sideboard_style2_004":747,"tr_int1_sideboard_style2_01":696,"tr_int1_sideboard_style2_019":393,"tr_int1_sideboard_style2_013":854,"tr_int1_sideboard_style2_018":750,"tr_int1_sideboard_style2_012":791,"tr_int1_sideboard_style2_006":514,"tr_int1_sideboard_style2_010":927,"apa_mp_h_str_sideboardm_02":430,"mp_b_str_sideboardl_04":596,"apa_mp_h_str_sideboards_01":767,"mp_b_str_sideboardl_02":562,"hei_heist_str_sideboardl_03":774,"apa_mp_h_str_sideboardl_14":695,"apa_mp_h_str_sideboardl_06":461,"apa_mp_h_str_sideboardm_03":666,"v_med_p_sideboard":863,"mp_b_str_sideboardl_03":689,"apa_mp_h_str_sideboardl_09":724,"v_res_tre_storageunit":756,"v_res_tre_woodunit":391,"v_res_d_sideunit":476,"v_res_tre_wdunitscuz":711,"rtx_djn_cabinet_1":996,"rtx_djn_cabinet_3":808,"rtx_djn_cabinet_5":908,"v_club_cc_stool":341,"prop_bar_stool_01":933,"v_res_m_stool_replaced":924,"xm_lab_chairstool_12":930,"h4_prop_h4_barstool_01a":609,"v_res_fh_kitnstool":469,"v_ret_ta_stool":381,"v_res_tre_stool":554,"h4_prop_int_glam_stool":815,"v_ilev_tort_stool":736,"v_res_tre_stool_scuz":727,"h4_mp_h_yacht_stool_01":499,"prop_rub_stool":557,"sf_prop_sf_stool_01a":321,"prop_ven_market_stool":303,"apa_mp_h_din_stool_04":999,"ch_prop_casino_stool_02a":427,"v_res_j_stool":982,"h4_prop_h4_stool_01a":333,"apa_mp_h_yacht_barstool_01":380,"h4_prop_int_stool_low":802,"apa_mp_h_stn_foot_stool_01":638,"h4_prop_int_edgy_stool":837,"bkr_prop_biker_barstool_02":577,"v_corp_lngestool":894,"v_med_cor_medstool":938,"prop_stool_01":685,"sf_prop_sf_chair_stool_09a":469,"ex_mp_h_din_stool_04":683,"sf_prop_sf_chair_stool_08a":550,"v_res_tre_stool_leather":754,"apa_mp_h_stn_foot_stool_02":855,"prop_t_shirt_row_04":832,"prop_t_shirt_row_03":779,"v_club_shoerack":495,"prop_cap_row_02":337,"v_club_rack":948,"hei_heist_acc_rugwooll_01":694,"hei_heist_acc_rugwooll_03":417,"hei_heist_acc_rugwooll_02":663,"tr_prop_tr_folder_mc_01a":419,"hei_heist_acc_rughidel_01":759,"ex_mp_h_acc_rugwoolm_04":974,"m24_1_prop_m41_rug_01a":436,"apa_mp_h_acc_rugwoolm_02":338,"apa_mp_h_acc_rugwooll_04":847,"ch_chint02_rug_flat":489,"apa_mp_h_acc_rugwoolm_01":601,"apa_mp_h_acc_rugwoolm_03":933,"apa_mp_h_acc_rugwools_03":707,"prop_egg_clock_01":392,"prop_v_15_cars_clock":847,"sf_prop_sf_game_clock_01a":320,"prop_big_clock_01":865,"prop_game_clock_02":674,"prop_game_clock_01":625,"prop_v_5_bclock":967,"prop_hotel_clock_01":971,"prop_sports_clock_01":810,"prop_id2_20_clock":533,"v_res_fh_bedsideclock":398,"v_corp_facebeanbagd":837,"v_res_tre_cushnscuzd":412,"v_res_tre_cushiond":570,"v_res_tre_laundrybasket":895,"prop_dress_disp_02":360,"v_res_tre_cushionb":606,"prop_garden_dreamcatch_01":390,"prop_skid_sleepbag_1":652,"v_res_jcushionc":632,"h4_prop_h4_pillow_01a":812,"v_res_tissues":495,"v_hair_d_bcream":355,"v_corp_facebeanbag":308,"v_med_pillow":436,"h4_prop_h4_pillow_02a":392,"prop_iron_01":805,"v_ind_rc_hanger":919,"v_res_fh_aftershavebox":638,"v_res_tre_flatbasket":742,"prop_tint_towel":510,"h4_prop_h4_pillow_03a":652,"v_res_d_dressingtable":512,"v_res_tt_bedpillow":717,"v_res_tre_cushionc":790,"v_ret_ps_bag_02":730,"v_ret_ps_cologne_01":884,"v_res_tre_cuprack":325,"v_club_vu_bear":696,"v_serv_bs_comb":963,"sf_prop_sf_bed_dog_01b":662,"sf_prop_sf_bed_dog_01a":397,"v_ret_ps_cologne":401,"mp_b_acc_artgolddisc_04":363,"sf_int1_art1_stairs":416,"sf_int1_art3_stairs1":426,"sf_int1_art1_operations":989,"mp_b_acc_artwallm_01":966,"m23_2_int4_m232_lsp_jersey":889,"sf_int2_art_gf_option_1_f0":584,"sf_int1_art3_new1":936,"ex_office_swag_paintings01":300,"vw_prop_plaque_02b":989,"vw_prop_vw_wallart_58a":431,"vw_prop_vw_wallart_61a":750,"apa_p_h_acc_artwalll_03":371,"vw_prop_vw_wallart_86a":963,"vw_prop_vw_wallart_59a":771,"apa_p_h_acc_artwalll_01":756,"vw_prop_casino_art_sh_01a":748,"vw_prop_vw_wallart_97a":841,"vw_prop_vw_wallart_84a":821,"h4_int_05_wall_plate_12":604,"vw_prop_vw_wallart_77a":715,"vw_prop_casino_art_car_10a":609,"apa_p_h_acc_artwalll_02":927,"h4_mp_h_acc_artwallm_03":635,"vw_prop_vw_wallart_95a":973,"vw_prop_vw_wallart_82a":385,"sf_prop_sf_art_bobble_01a":389,"ex_p_h_acc_artwalll_03":401,"vw_prop_vw_wallart_173a":622,"vw_prop_vw_wallart_163a":421,"vw_prop_vw_wallart_153a":860,"vw_prop_vw_wallart_143a":594,"vw_prop_vw_wallart_133a":596,"vw_prop_vw_wallart_123a":484,"vw_prop_vw_wallart_113a":503,"vw_prop_vw_wallart_103a":666,"ba_prop_battle_poster_promo_03":437,"vw_prop_vw_wallart_75a":392,"h4_mp_h_acc_artwallm_02":607,"vw_prop_vw_wallart_93a":410,"vw_prop_vw_wallart_96a":678,"vw_prop_vw_wallart_83a":716,"v_res_r_figauth1":739,"ch_prop_vault_painting_01f":579,"sum_prop_ac_qub3d_poster_01a":618,"vw_prop_vw_wallart_76a":986,"h4_prop_battle_poster_promo_04":745,"vw_prop_casino_art_sculpture_01a":600,"ex_p_h_acc_artwalll_01":801,"vw_prop_vw_wallart_74a":716,"vw_prop_art_resin_balls_01a":507,"vw_prop_casino_art_skull_03a":789,"ch_prop_vault_painting_01d":406,"h4_prop_battle_poster_promo_02":708,"vw_prop_vw_wallart_92a":734,"sf_mp_h_acc_artwalll_01":765,"sf_p_h_acc_artwallm_04":901,"vw_prop_vw_wallart_72a":528,"vw_prop_vw_wallart_68a":662,"vw_prop_casino_art_car_12a":394,"vw_prop_casino_art_skull_01a":860,"m24_1_prop_m41_painting_01c":716,"vw_prop_vw_wallart_151f":698,"vw_prop_vw_wallart_80a":338,"ch_prop_vault_painting_01j":350,"m23_1_prop_m31_orn_bat_01a":984,"vw_prop_vw_wallart_73a":972,"vw_prop_vw_wallart_69a":479,"ex_mp_h_acc_dec_sculpt_01":556,"vw_prop_vw_wallart_71a":783,"vw_prop_art_mic_01a":555,"v_res_r_fighorsestnd":391,"vw_prop_vw_wallart_151b":355,"vw_prop_vw_wallart_151e":826,"xs_prop_trophy_cup_01a":705,"vw_prop_vw_wallart_151c":999,"vw_prop_vw_wallart_70a":587,"vw_prop_vw_colle_sasquatch":809,"vw_prop_vw_wallart_161a":788,"vw_prop_vw_wallart_141a":668,"vw_prop_vw_wallart_111a":840,"vw_prop_vw_wallart_101a":353,"sf_mp_h_acc_artwallm_02":313,"vw_prop_casino_art_egg_01a":637,"vw_prop_vw_wallart_17a":303,"vw_prop_vw_wallart_04a":768,"vw_prop_casino_art_concrete_01a":374,"v_med_wallpicture1":988,"vw_prop_vw_wallart_89a":669,"vw_prop_vw_wallart_02a":903,"vw_prop_casino_art_statue_01a":445,"v_res_r_figflamenco":983,"vw_prop_vw_wallart_16a":585,"vw_prop_vw_wallart_03a":620,"sf_prop_sf_art_pin_01a":444,"vw_prop_vw_wallart_98a":593,"vw_prop_vw_wallart_01a":686,"vw_prop_casino_art_car_09a":662,"vw_prop_casino_art_lollipop_01a":403,"vw_prop_art_wings_01a":874,"v_res_picture_frame":858,"vw_prop_vw_wallart_99a":488,"vw_prop_vw_wallart_134a":489,"vw_prop_vw_wallart_114a":535,"vw_prop_vw_wallart_104a":616,"apa_mp_h_acc_dec_sculpt_02":454,"h4_prop_h4_art_pant_01a":315,"sf_prop_sf_art_statue_02a":410,"vw_prop_casino_art_mod_03a_b":709,"vw_prop_casino_art_mod_03b_a":347,"vw_prop_casino_art_horse_01b":401,"prop_gnome2":410,"vw_prop_art_pug_02a":524,"vw_prop_vw_wallart_20a":502,"vw_prop_plaque_02a":347,"vw_prop_casino_art_mod_04b":544,"vw_prop_vw_wallart_142a":704,"vw_prop_vw_wallart_08a":602,"h4_prop_h4_painting_01e":758,"vw_prop_casino_art_gun_02a":593,"h4_mp_h_acc_dec_sculpt_03":655,"apa_mp_h_acc_dec_head_01":711,"sf_prop_sf_art_statue_tgr_01a":678,"apa_p_h_acc_artwalls_03":630,"apa_p_h_acc_artwalls_04":919,"vw_prop_casino_art_bowling_02a":708,"vw_prop_art_pug_01b":872,"prop_idol_01":696,"vw_prop_art_pug_01a":891,"vw_prop_casino_art_head_01b":301,"vw_prop_casino_art_concrete_02a":675,"vw_prop_casino_art_ego_01a":332,"v_ilev_ra_doorsafe":999,"vw_prop_casino_art_mod_03a_c":435,"vw_prop_casino_art_mod_01a":801,"vw_prop_casino_art_bird_01a":800,"sf_prop_sf_art_s_board_02a":491,"v_res_jewelbox":600,"xm3_prop_xm3_safe_01a":366,"sf_prop_v_43_safe_s_bk_01a":917,"p_v_43_safe_s":492,"sf_prop_v_43_safe_s_gd_01a":324,"prop_ld_int_safe_01":441,"h4_prop_h4_safe_01a":748,"v_res_d_sofa":582,"prop_yaught_sofa_01":667,"prop_couch_sm_06":452,"p_yacht_sofa_01_s":669,"v_club_officesofa":581,"hei_heist_stn_sofa2seat_02":778,"prop_couch_lg_06":484,"hei_heist_stn_sofa2seat_06":838,"prop_couch_lg_02":928,"prop_couch_sm1_07":392,"v_res_j_sofa":811,"hei_heist_stn_sofa3seat_02":578,"prop_couch_04":439,"hei_heist_stn_sofa3seat_06":444,"p_res_sofa_l_s":631,"bkr_prop_clubhouse_sofa_01a":332,"prop_couch_lg_05":733,"prop_couch_lg_07":300,"ba_sofa1":771,"sf_mp_h_yacht_sofa_02":698,"hei_heist_stn_sofa3seat_01":632,"prop_t_sofa":616,"xm_lab_sofa_02":932,"sum_mp_h_yacht_sofa_02":409,"v_tre_sofa_mess_b_s":468,"apa_mp_h_yacht_sofa_02":658,"ch_chint02_03_sofa":793,"mp_b_stn_sofacorn_05":996,"h4_prop_h4_couch_01a":343,"p_sofa_s":336,"prop_couch_lg_08":508,"v_res_tt_sofa":322,"m23_2_int4_m232_sofa_01":524,"apa_mp_h_stn_sofacorn_09":856,"h4_mp_h_yacht_sofa_01":493,"prop_ld_farm_couch01":606,"apa_mp_h_stn_sofacorn_07":449,"hei_heist_stn_sofacorn_05":869,"ba_sofa2":636,"apa_mp_h_stn_sofacorn_05":728,"v_res_r_sofa":729,"prop_rub_couch04":422,"apa_mp_h_stn_sofacorn_01":614,"v_res_m_h_sofa_sml":641,"xm_lab_sofa_01":513,"sum_mp_h_yacht_sofa_01":562,"v_ilev_m_sofa":740,"sf_prop_sf_sofa_studio_01a":350,"mp_b_stn_sofa2seat_03":848,"v_med_p_sofa":816,"ex_mp_h_off_sofa_02":316,"ex_mp_h_off_sofa_01":745,"mp_b_stn_sofa2seat_02":915,"prop_couch_03":689,"prop_couch_01":421,"v_res_tre_sofa":419,"sf_prop_sf_sofa_chefield_01a":826,"apa_mp_h_stn_sofacorn_08":326,"ex_mp_h_off_sofa_003":887,"mp_b_stn_sofa3seat_02":992,"apa_mp_h_stn_sofacorn_06":748,"ba_sofa3":905,"mp_b_stn_sofa3seat_06":723,"ch_chint02_flat_sofa":767,"v_res_fh_sofa":448,"apa_mp_h_stn_sofacorn_10":478,"vw_prop_vw_table_casino_tall_01":329,"ch_chint03_tablesplan2":835,"tr_int1_mod_table":771,"v_61_lng_mesh_coffeetable":992,"bkr_barcoffetable02":732,"bkr_barcoffetable01":633,"mp_b_tab_coffee_06":664,"tr_int1_smoking_table009x":546,"bkr_int_02_table":414,"m23_2_prop_m32_desk_01a":438,"h4_prop_h4_table_01a":410,"hei_heist_tab_sidelrg_02":977,"apa_mp_h_tab_coffee_07":389,"mp_b_tab_sidelrg_01":608,"ex_mp_h_yacht_coffee_table_01":300,"mp_b_str_sideboards_02":756,"ch_chint02_03_high_table":319,"prop_table_03b":699,"apa_mp_h_tab_coffee_05":474,"v_corp_cd_rectable":641,"ba_prop_int_edgy_table_02":370,"ex_mp_h_tab_coffee_08":537,"ba_vip_table1":446,"vw_vwint01_manager_ctable_02":672,"mp_b_tab_sidelrg_04":885,"apa_mp_h_yacht_coffee_table_02":308,"ba_prop_int_edgy_table_01":822,"v_res_m_dinetble":922,"v_res_msidetblemod":669,"ba_vip_table3":331,"sum_mp_h_yacht_side_table_01":567,"hei_prop_yah_table_03":833,"vw_prop_vw_table_casino_short_02":725,"v_res_m_console":328,"hei_prop_yah_table_01":836,"hei_prop_yah_table_02":760,"h4_mp_h_yacht_side_table_02":826,"prop_t_coffe_table_02":510,"prop_fbi3_coffee_table":860,"v_res_j_coffeetable":771,"gr_dlc_gr_yacht_props_table_01":477,"v_ind_rc_lowtable":918,"v_ret_csr_table":655,"m24_1_prop_m24_1_carrier_yah_table_01":736,"v_med_p_sidetable":342,"prop_table_03b_cs":954,"mp_b_tab_coffee_05":829,"mp_b_tab_coffee_07":817,"apa_mp_h_tab_sidelrg_07":520,"h4_prop_h4_table_01b":492,"hei_heist_tab_sidesml_02":822,"apa_mp_h_tab_sidelrg_01":795,"apa_mp_h_tab_sidelrg_02":993,"prop_table_05":408,"v_res_mbbedtable":348,"h4_prop_int_glam_table":964,"m23_2_int6_m232_table_1233":592,"v_med_hosptable":739,"v_res_fh_coftableb":737,"bkr_prop_fakeid_table":336,"vw_vwint01_manager_ctable_01":958,"m24_1_prop_m41_loungertable_01a":746,"v_res_fh_coftbldisp":353,"prop_yacht_table_01":883,"prop_table_03":894,"v_res_d_coffeetable":851,"v_res_d_roundtable":609,"v_club_roc_ctable":548,"hei_heist_tab_sidelrg_04":468,"v_med_p_coffeetable":740,"v_res_j_lowtable":924,"prop_ld_farm_table01":919,"prop_table_04":340,"prop_table_06":976,"v_res_mconsoletrad":773,"ch_prop_ch_coffe_table_02":988,"prop_couch_sm_02":445,"prop_couch_sm_07":901,"prop_couch_sm_05":473,"prop_rub_couch03":954,"prop_couch_sm2_07":444,"bkr_prop_clubhouse_armchair_01a":350,"p_yacht_chair_01_s":575,"tr_int1_mod_armchair_05":508,"v_58_soloff_gchair":761,"hei_heist_din_chair_09":961,"hei_heist_din_chair_05":752,"prop_yaught_chair_01":921,"prop_armchair_01":451,"hei_heist_stn_chairarm_04":862,"v_res_d_armchair":969,"sum_mp_h_yacht_armchair_04":905,"apa_mp_h_din_chair_09":722,"apa_mp_h_stn_chairstrip_07":670,"mp_b_stn_chairstrip_01":734,"sm_prop_smug_offchair_01a":676,"apa_mp_h_stn_chairstrip_05":337,"apa_mp_h_din_chair_08":932,"v_corp_bk_chair1":798,"apa_mp_h_stn_chairstrip_03":572,"v_ilev_m_dinechair":490,"hei_heist_din_chair_04":729,"apa_mp_h_din_chair_12":829,"v_club_officechair":405,"ex_mp_h_stn_chairstrip_011":815,"v_res_m_armchair":393,"v_corp_bk_chair3":469,"apa_mp_h_stn_chairstrip_01":924,"prop_skid_chair_01":795,"ba_prop_battle_club_chair_01":340,"ex_mp_h_din_chair_12":906,"v_res_study_chair":739,"sf_prop_sf_offchair_exec_01a":625,"bkr_prop_weed_chair_01a":332,"ba_prop_battle_club_chair_03":777,"sf_mp_h_yacht_strip_chair_01":945,"prop_off_chair_04b":452,"hei_heist_din_chair_02":845,"vw_prop_vw_offchair_01":561,"v_ret_ps_chair":367,"prop_cs_office_chair":794,"h4_mp_h_yacht_armchair_04":543,"v_res_fh_easychair":368,"v_corp_lazychair":736,"vw_prop_vw_offchair_03":565,"h4_prop_h4_chair_02a":777,"h4_prop_battle_club_chair_02":491,"h4_mp_h_yacht_armchair_01":768,"p_armchair_01_s":756,"prop_chair_04a":578,"h4_prop_h4_chair_03a":816,"prop_chair_10":421,"h4_mp_h_yacht_armchair_03":426,"ch_prop_casino_track_chair_01":536,"ch_prop_casino_chair_01b":865,"h4_prop_h4_chair_01a":727,"ex_mp_h_stn_chairarm_03":762,"v_club_vuarmchair":832,"prop_chateau_chair_01":422,"prop_clown_chair":746,"prop_direct_chair_01":309,"prop_chair_05":710,"v_med_p_easychair":449,"v_res_fh_barcchair":704,"prop_chair_01a":492,"xm_lab_chairarm_02":455,"apa_mp_h_stn_chairarm_24":752,"xm_lab_chairarm_12":744,"prop_off_chair_05":908,"apa_mp_h_stn_chairarm_26":935,"gr_prop_highendchair_gr_01a":595,"v_club_stagechair":536,"v_res_m_l_chair1":322,"v_res_tre_chair":358,"v_ind_ss_chair2":414,"prop_chair_07":923,"bkr_int_02_strip_chair":606,"ex_prop_offchair_exec_01":546,"apa_mp_h_stn_chairstrip_08":704,"v_ilev_p_easychair":910,"v_med_whickerchair1":616,"prop_chair_03":981,"vw_prop_casino_track_chair_01":346,"prop_chair_02":727,"xm_lab_chairarm_26":383,"apa_mp_h_stn_chairstrip_04":782,"xm3_prop_xm3_folding_chair_01a":361,"prop_chair_08":367,"v_med_fabricchair1":537,"mp_b_din_chair_03":645,"v_ret_chair_white":813,"mp_b_din_chair_02":724,"hei_prop_hei_skid_chair":620,"prop_chair_09":891,"v_med_p_deskchair":941,"hei_heist_din_chair_01":957,"v_corp_bk_chair2":478,"v_res_mp_stripchair":934,"v_ilev_chair02_ped":740,"hei_heist_din_chair_03":591,"ex_mp_h_stn_chairstrip_01":942,"hei_heist_stn_chairarm_06":529,"v_ret_gc_chair03":797,"bkr_prop_biker_chair_01":412,"prop_chair_04b":342,"v_res_mbchair":611,"apa_mp_h_stn_chairarm_09":487,"h4_prop_battle_club_chair_03":304,"vw_prop_vw_offchair_02":663,"p_dinechair_01_s":506,"ex_mp_h_off_chairstrip_01":483,"prop_chair_01b":935,"xm_lab_chairarm_11":451,"v_res_d_highchair":711,"xm_prop_x17_avengerchair_02":344,"xm_mp_h_stn_chairarm_13":726,"v_club_barchair":782,"apa_mp_h_stn_chairarm_25":903,"imp_prop_impexp_offchair_01a":951,"xm_lab_chairarm_25":333,"apa_mp_h_stn_chairarm_13":717,"ch_prop_ch_laundry_shelving_01a":650,"ch_prop_ch_laundry_shelving_02a":350,"prop_shelves_03":452,"xm3_prop_xm3_shelves_01a":785,"ch_chint02_office_shelving":440,"ch_chint02_flat_shelving":903,"prop_ff_shelves_01":518,"ch_prop_ch_laundry_shelving_01b":530,"v_corp_cabshelves01":751,"prop_shelves_02":829,"prop_shelves_01":726,"reh_prop_reh_shelves_01a":395,"ch_prop_ch_laundry_shelving_01c":400,"prop_tv_cabinet_04":312,"prop_tv_cabinet_03":777,"prop_tv_cabinet_05":346,"v_res_msoncabinet":980,"v_res_tre_tvstand_tall":569,"v_res_tre_tvstand":790,"bkr_int_02_avunit":418,"rtx_djn_tvunit_1":564,"rtx_djn_tvunit_2":437,"rtx_djn_tvunit_3":910,"rtx_djn_tvunit_4":371,"rtx_djn_tvunit_5":754,"rtx_djn_tvunit_6":755,"rtx_djn_tvunit_7":776,"rtx_djn_tvunit_8":376,"xm3_prop_xm3_toy_dog_01a":948,"v_39_curtain003":950,"v_39_curtain01":995,"v_med_curtainsnewcloth2":556,"v_39_curtain002":827,"v_med_curtainsnewcloth1":402,"v_62_curtain_aud":923,"reh_prop_reh_blinds_02a":769,"m24_1_prop_m41_blinds_closed_01a":498,"prop_cs_ilev_blind_01":320,"m24_1_prop_m41_blinds_open_01a":875,"apa_mp_stilts_a_kitchblind":665,"h4_prop_h4_win_blind_03a":883,"h4_prop_h4_win_blind_01a":838,"h4_prop_h4_win_blind_02a":403,"sf_prop_sf_win_blind_01a":574,"reh_prop_reh_blinds_01a":556,"prop_pot_plant_04a":715,"p_int_jewel_plant_02":948,"prop_peyote_lowland_02":654,"p_int_jewel_plant_01":412,"v_corp_potplant2":492,"vw_prop_casino_art_plant_01a":735,"ex_mp_h_acc_plant_palm_01":830,"v_med_p_planter":690,"h4_prop_int_plants_01a":677,"vw_prop_casino_art_plant_02a":374,"apa_mp_h_acc_vase_flowers_02":579,"h4_prop_int_plants_01c":963,"vw_prop_casino_art_plant_03a":898,"v_ret_j_flowerdisp":541,"vw_prop_casino_art_plant_05a":805,"prop_plant_int_03c":339,"prop_plant_interior_05a":450,"ch_prop_ch_planter_01":420,"vw_prop_casino_art_plant_09a":996,"prop_pot_plant_02a":452,"prop_pot_plant_01e":674,"prop_plant_int_02a":681,"vw_prop_casino_art_plant_08a":376,"v_res_rubberplant":738,"prop_plant_int_03a":893,"v_res_fa_plant01":546,"prop_pot_plant_01a":542,"prop_fbibombplant":484,"prop_plant_int_01a":642,"prop_pot_plant_01c":633,"v_res_m_palmstairs":357,"prop_pot_plant_04c":835,"prop_pot_plant_05a":630,"v_res_tre_plant":511,"ex_mp_h_acc_plant_tall_01":322,"prop_windowbox_b":502,"prop_pot_plant_05c":476,"prop_windowbox_small":764,"vw_prop_casino_art_plant_11a":481,"vw_prop_casino_art_plant_10a":998,"vw_prop_casino_art_plant_12a":324,"v_corp_potplant1":740,"v_ret_j_flowerdisp_white":528,"apa_mp_h_acc_vase_flowers_03":701,"v_res_rosevasedead":546,"h4_prop_int_plants_01b":741,"prop_pot_plant_bh1":906,"prop_pot_plant_6b":520,"hei_heist_acc_plant_tall_01":544,"v_res_tre_tree":753,"prop_pot_plant_02d":319,"prop_pot_plant_03b_cr2":313,"h4_prop_int_plants_04":572,"prop_pot_plant_6a":512,"prop_plant_int_01b":472,"prop_pot_plant_01d":773,"prop_plant_int_02b":587,"prop_pot_plant_05d":594,"h4_prop_int_plants_03":665,"v_res_ivy":964,"prop_plant_int_04b":715,"prop_plant_int_05b":413,"h4_prop_int_plants_02":545,"vw_prop_flowers_potted_03a":502,"prop_pot_plant_01b":315,"vw_prop_vw_plant_int_03a":953,"v_res_m_urn":982,"v_res_mplanttongue":755,"sf_mp_h_acc_vase_flowers_04":377,"prop_windowbox_a":753,"vw_prop_flowers_vase_02a":692,"m24_1_prop_m41_palmplant_01a":383,"vw_prop_vw_planter_01":758,"prop_pot_plant_04b":576,"vw_prop_flowers_vase_03a":515,"mp_b_acc_flowers_01":372,"mp_b_acc_plant_tall_01":724,"v_res_m_bananaplant":139,"v_res_fh_sofa2":844,"v_ilev_liconftable_sml":896,"prop_tablesmall_01":456,"rtx_djn_kitchen_unit_1_middle":591,"rtx_djn_kitchen_unit_1_wall":893,"rtx_djn_kitchen_unit_2":956,"rtx_djn_kitchen_unit_3_middle":982,"rtx_djn_kitchen_unit_3_wall":970,"rtx_djn_kitchen_unit_4_middle":863,"rtx_djn_kitchen_unit_4_wall":345,"rtx_djn_kitchen_unit_5_middle":896,"rtx_djn_kitchen_unit_5_wall":847,"rtx_djn_kitchen_unit_6_middle":810,"rtx_djn_kitchen_unit_6_wall":911,"rtx_djn_kitchen_unit_7_middle":584,"rtx_djn_kitchen_unit_7_wall":836,"rtx_djn_kitchen_unit_8_middle":365,"rtx_djn_kitchen_unit_8_wall":651,"rtx_djn_kitchen_unit_9":984,"rtx_djn_kitchen_unit_10":522,"rtx_djn_kitchen_unit_11":525,"rtx_djn_kitchen_unit_12":725,"rtx_djn_kitchen_unit_middle":827,"rtx_djn_sink_1":390,"rtx_djn_sink_2":359,"rtx_djn_sink_3":801,"prop_sink_05":351,"v_res_mbsink":639,"prop_sink_06":859,"prop_sink_02":735,"rtx_djn_kitchen_unit_3_middle_hood":585,"rtx_djn_kitchen_unit_hood":913,"v_res_fridgemoda":998,"ch_chint02_derelict_drink_fridge":99,"v_res_tre_fridge":421,"prop_fridge_03":464,"prop_fridge_01":728,"prop_trailr_fridge":562,"v_res_fridgemodsml":959,"rtx_djn_kitchen_fridge_1":736,"rtx_djn_kitchen_blender_1":462,"rtx_djn_kitchen_oven_1_base":701,"rtx_djn_kitchen_oven_2_base":620,"prop_micro_01":757,"prop_micro_02":455,"prop_micro_04":307,"prop_microwave_1":375,"prop_cs_toaster":614,"prop_cs_kettle_01":735,"ex_mp_h_acc_coffeemachine_01":868,"prop_toaster_01":526,"prop_cooker_03":952,"prop_toaster_02":566,"mp_b_kit_coffeemachine_01":809,"v_ilev_mm_faucet":949,"ch_chint02_bar_pump":752,"prop_bar_cooler_03":602,"ch_chint02_watercooler":929,"prop_griddle_02":964,"v_res_tre_mixer":873,"prop_tea_urn":485,"prop_bar_pump_07":770,"prop_kitch_juicer":164,"prop_foodprocess_01":74,"sf_prop_sf_esp_machine_01a":812,"v_ret_ml_scale":768,"prop_coffee_mac_02":411,"prop_bar_pump_10":438,"ex_mp_h_din_table_04":600,"ex_mp_h_din_table_06":983,"hei_heist_din_table_01":740,"hei_heist_din_table_07":480,"v_ret_fh_dinetable":506,"ex_mp_h_din_table_11":965,"ex_mp_h_din_table_01":465,"apa_mp_h_din_table_05":438,"v_res_m_dinetble_replace":982,"v_res_fh_diningtable":879,"bkr_bar_bar002":836,"bkr_bar_bar01":776,"bkr_int02_recareabar":518,"bkr_int_02_bar_wood":794,"hei_heist_din_chair_06":709,"apa_mp_h_din_chair_04":839,"v_res_fh_dineeamesa":645,"v_res_fh_dineeamesc":301,"v_res_fh_dineeamesb":377,"mp_b_din_chair_08":636,"v_res_m_dinechair":977,"bkr_prop_biker_barstool_03":803,"bkr_prop_biker_barstool_04":778,"vw_prop_casino_stool_02a":326,"v_ret_fh_pot01":625,"bkr_ware03_metalbowlbasic":853,"v_res_tt_bowlpile02":463,"v_res_tt_pot02":730,"v_res_tt_mug01":847,"v_ret_ta_paproll":172,"v_res_pestle":561,"v_res_mmug":592,"v_res_tt_pot03":446,"bkr_ware03_metalbowlbasic2":896,"prop_plate_01":721,"v_res_tt_mug2":819,"prop_plate_04":554,"hei_heist_acc_bowl_02":507,"prop_pot_01":906,"apa_mp_h_acc_fruitbowl_02":356,"v_res_mplatelrg":366,"prop_pot_02":614,"prop_pot_04":742,"prop_pot_03":842,"v_res_mkniferack":848,"xm3_prop_xm3_rack_vial_01b":886,"prop_pot_05":851,"v_res_foodjarc":157,"prop_bar_measrjug":942,"v_res_fa_potsug":636,"prop_whiskey_glasses":674,"prop_glass_stack_08":500,"v_ret_fh_plate2":643,"prop_food_cb_tray_01":54,"prop_pot_06":671,"prop_glass_stack_09":708,"prop_lime_jar":542,"sf_prop_sf_mug_01a":685,"v_res_m_pot1":841,"v_ret_fh_plate1":821,"prop_knife":394,"h4_prop_battle_decanter_02_s":724,"apa_mp_h_acc_bowl_ceramic_01":579,"v_res_mbowl":311,"v_res_r_milkjug":683,"v_res_mchopboard":991,"prop_plate_warmer":509,"ch_prop_ch_tray_01a":364,"prop_cs_silver_tray":649,"v_club_vu_coffeemug2":786,"sf_prop_sf_filter_handle_01a":707,"xm3_prop_xm3_lab_tray_01b":973,"v_res_mutensils":803,"prop_champ_flute":781,"prop_mug_06":636,"v_res_fa_sponge01":609,"prop_pint_glass_tall":851,"v_ret_gc_mug02":753,"prop_whisk":841,"v_res_r_sugarbowl":912,"prop_whiskey_01":607,"prop_bar_coastbarr":315,"prop_mug_03":962,"prop_mug_04":640,"prop_kitch_pot_lrg":847,"prop_brandy_glass":386,"h4_prop_h4_plate_wall_03a":881,"prop_bar_napkindisp":845,"prop_mug_02":760,"prop_pint_glass_01":702,"v_res_bowl_dec":645,"prop_kitch_pot_med":417,"prop_bar_caddy":367,"prop_sh_tall_glass":587,"prop_sh_shot_glass":942,"prop_mug_01":343,"v_res_fa_chopbrd":916,"h4_prop_h4_saltshaker_01a":121,"v_ret_gc_mugdisplay":635,"ch_chint02_bar_glasses":815,"v_ilev_m_pitcher":738,"v_serv_bs_looroll":187,"v_ret_fh_pot02":740,"prop_pitcher_02":997,"v_ind_cfknife":980,"prop_tall_glass":411,"prop_copper_pan":891,"v_res_plate_dec":559,"v_res_tt_pot01":864,"v_res_fa_potcof":514,"prop_kitch_pot_huge":683,"v_res_r_coffpot":868,"prop_pot_rack":634,"h4_prop_battle_ice_bucket":557,"prop_cs_fork":647,"v_res_r_teapot":498,"prop_kitch_pot_fry":478,"prop_wok":720,"prop_sh_wine_glass":512,"prop_breadbin_01":923,"v_res_fa_grater":986,"h4_prop_h4_tray_01a":947,"v_res_fa_pottea":936,"prop_food_napkin_01":174,"v_res_mbathpot":967,"v_ret_gc_mug01":866,"prop_food_napkin_02":135,"prop_food_ketchup":159,"v_res_mknifeblock":703,"v_serv_bs_mug":684,"v_ret_fh_fry02":395,"v_res_mplatesml":574,"prop_metalfoodjar_01":69,"prop_fish_slice_01":920,"prop_utensil":380,"prop_kitch_pot_sm":611,"prop_ladel":831,"prop_knife_stand":517,"v_ret_fh_pot05":661,"v_res_tt_platepile":521,"apa_mp_h_acc_drink_tray_02":140,"ch_prop_ch_room_trolly_01a":151,"v_med_cor_shelfrack":935,"apa_mp_h_str_shelfwallm_01":796,"v_ind_cf_shelf":322,"v_ind_cf_shelf2":510,"v_ret_ml_shelfrk":569,"v_ret_ml_liqshelfb":88,"v_ret_ml_liqshelfd":170,"v_ret_ml_liqshelfc":60,"v_ret_ml_liqshelfe":132,"v_ret_ml_liqshelfa":62,"xm3_prop_xm3_shelve_crt_01a":809,"bkr_ware03_bin":836,"prop_fbibombbin":509,"hei_heist_kit_bin_01":963,"prop_bin_10a":791,"v_med_cor_cembin":870,"prop_bin_11a":800,"ch_chint02_bin":478,"v_ret_gc_bin":433,"v_ret_csr_bin":942,"prop_recyclebin_02a":647,"v_serv_tc_bin3_":351,"prop_bin_10b":950,"prop_bin_11b":450,"ch_chint02_paper_bin":921,"v_ind_cfbin":421,"mp_b_kit_bin_01":981,"v_serv_metro_wallbin":667,"prop_ff_sink_01":622,"rtx_djn_bathroom_dual_sink_1":816,"rtx_djn_bathroom_dual_sink_2":822,"rtx_djn_bathroom_dual_sink_3":928,"rtx_djn_bathroom_dual_sink_4":802,"rtx_djn_bathroom_sink_1":976,"rtx_djn_bathroom_sink_2":605,"rtx_djn_bathroom_sink_4":318,"rtx_djn_bathroom_sink_frame_1":805,"rtx_djn_bathroom_sink_frame_2":867,"apa_mp_h_bathtub_01":594,"rtx_djn_bathroom_bathtub_1":697,"rtx_djn_bathroom_bathtub_2":889,"rtx_djn_bathroom_bathtub_3":566,"rtx_djn_bathroom_bathtub_4":470,"rtx_djn_housing_shower_1":582,"rtx_djn_housing_shower_2":392,"rtx_djn_housing_shower_3":633,"rtx_djn_housing_shower_4":833,"rtx_djn_housing_shower_5":651,"rtx_djn_housing_shower_6":435,"rtx_djn_housing_shower_7":831,"prop_toilet_01":622,"prop_toilet_02":350,"prop_ld_toilet_01":318,"ch_chint02_urinal_flat":952,"ch_chint02_urinal_beam":343,"rtx_djn_toilet_1":581,"rtx_djn_toilet_2":930,"rtx_djn_toilet_3":802,"rtx_djn_bathroom_carpet":854,"rtx_djn_bathroom_heater":932,"rtx_djn_bathroom_sanitation":362,"v_ret_ta_paproll2":57,"prop_soap_disp_01":668,"v_62_curt_dyn001":568,"prop_toilet_shamp_02":376,"prop_toothbrush_01":972,"prop_buck_spade_07":564,"prop_toothb_cup_01":942,"prop_toilet_soap_04":654,"p_cs_comb_01":904,"prop_toilet_soap_03":688,"v_club_vubrushpot":803,"prop_towel2_02":587,"prop_toilet_roll_01":80,"v_serv_bs_foam1":308,"v_ind_cs_spray":843,"v_res_tt_plunger":648,"v_res_mbtowelfld":915,"prop_toilet_roll_05":59,"h4_mp_h_acc_box_trinket_02":806,"prop_toilet_roll_02":197,"v_club_vuvanityboxop":827,"v_res_mbaccessory":988,"ch_chint02_flat_handdry":552,"prop_ftowel_08":535,"v_res_j_magrack":807,"v_res_tt_looroll":171,"v_res_r_cottonbuds":640,"v_ret_hd_prod2_":901,"prop_scourer_01":591,"prop_ftowel_10":643,"v_res_mbtowel":742,"v_med_soapdisp":759,"v_ret_ta_jelly":459,"prop_buck_spade_08":854,"v_res_r_perfume":355,"prop_towel_01":654,"prop_towel_rail_02":964,"v_ret_hd_prod4_":885,"prop_handtowels":368,"prop_towel2_01":907,"v_hair_d_gel":551,"prop_cs_nail_file":963,"prop_disp_razor_01":893,"v_serv_bs_shvbrush":443,"v_serv_bs_shampoo":407,"v_med_soapdispencer":694,"v_ret_hd_prod1_":345,"v_ret_washpow1":530,"prop_handdry_02":395,"prop_shower_rack_01":915,"p_shower_towel_s":401,"sf_prop_sf_spray_fresh_01a":363,"v_haird_mousse":335,"v_club_comb":499,"v_ret_247_pharmdeo":582,"v_club_vutongs":344,"prop_shower_towel":964,"v_ret_ps_toiletry_01":520,"v_ret_ps_toiletbag":354,"v_serv_bs_foamx3":492,"prop_cs_mopbucket_01":584,"v_hair_d_shave":497,"v_res_fh_towelstack":379,"m23_2_prop_m32_bucket_mop_01a":834,"v_ind_rc_towel":543,"prop_ftowel_01":417,"prop_beach_towel_01":613,"v_res_tre_washbasket":371,"v_serv_bs_cond":607,"prop_clothes_tub_01":623,"prop_toothpaste_01":346,"v_ret_hd_prod5_":981,"v_res_mlaundry":345,"v_serv_bs_cliipbit2":615,"prop_makeup_brush":400,"v_serv_bs_gelx3":770,"prop_towel_rail_01":508,"v_med_cor_papertowels":849,"v_club_brush":840,"prop_ftowel_07":726,"prop_toilet_soap_02":841,"v_serv_bs_gel":710,"prop_cs_beachtowel_01":627,"v_res_mbtaps":728,"ch_prop_ch_laundry_trolley_01a":83,"ch_prop_ch_trolly_01a":53,"v_ret_mirror":944,"ch_prop_ch_laundry_machine_01a":832,"v_ret_fh_washmach":523,"prop_washer_01":618,"prop_washer_03":887,"prop_washer_02":511,"djn_rtx_dryer_1_base":384,"djn_rtx_dryer_2_base":700,"rtx_djn_washer_1_base":982,"rtx_djn_washer_2_base":905,"rtx_djn_vacuuming_robot_1":685,"rtx_djn_vacuuming_robot_2":584,"rtx_djn_vacuuming_robot_dock_1":731,"rtx_djn_vacuuming_robot_dock_2":978,"v_res_vacuum":472,"v_ind_cf_broom":474,"bkr_prop_biker_tool_broom":884,"prop_tool_broom":429,"tr_prop_biker_tool_broom":371,"prop_tool_broom2":406,"ch_chint02_flat_desk":814,"v_corp_desksetb":504,"ba_dlc_ba_int2_secdesks02":310,"tr_prop_tr_desk_main_01a":493,"v_corp_deskseta":367,"v_corp_maindesk":854,"v_med_p_desk":854,"v_corp_officedesk_5":373,"v_corp_officedesk":385,"v_corp_officedesk003":368,"sf_prop_sf_desk_laptop_01a":674,"xm_base_cia_desk1":577,"v_corp_officedesk2":772,"v_res_mddesk":950,"gr_bunk_off_desk":933,"v_corp_lidesk01":395,"xm_prop_lab_desk_02":327,"sf_int3_desk_small_01":731,"reh_prop_reh_desk_comp_01a":362,"gr_bunk_off_desklamp_uprgd":658,"xm_prop_base_staff_desk_01":672,"m24_1_prop_m41_desktop_01a":932,"h4_prop_office_desk_01":357,"xm_prop_base_staff_desk_02":419,"v_ind_dc_desk02":708,"v_ind_dc_desk01":521,"ba_dlc_ba_int2_secdesks01":606,"tr_int1_plan_table01":742,"sf_prop_sf_table_studio_01a":771,"v_corp_conftable2":957,"bkr_prop_clubhouse_offchair_01a":323,"v_corp_offchairfd":588,"prop_off_chair_03":854,"apa_mp_h_stn_chairarm_12":813,"v_corp_cd_chair":922,"v_res_tre_officechair":700,"prop_mouse_01":958,"hei_prop_heist_roller_up":86,"p_planning_board_04":320,"prop_cs_marker_01":402,"prop_cs_business_card":853,"p_ld_id_card_002":972,"prop_cs_swipe_card":861,"hei_prop_heist_docs_01":463,"prop_cd_folder_pile3":514,"prop_cork_board":924,"prop_barry_table_detail":698,"prop_cs_binder_01":898,"prop_taxi_meter_2":775,"prop_cd_folder_pile1":769,"vw_prop_casino_magazine_01a":882,"h4_prop_h4_pile_letters_01a":530,"v_ret_gc_staple":924,"v_med_cor_photocopy":1000,"ch_prop_whiteboard_04":974,"xm3_prop_xm3_clipboard_jc":818,"p_amb_clipboard_01":313,"v_club_vu_ink_2":790,"hei_prop_hei_muster_01":997,"m23_2_prop_m32_mazebankcard_01b":369,"v_res_pctower":750,"p_planning_board_02":849,"prop_cs_documents_01":579,"bkr_prop_prtmachine_paperream":874,"tr_prop_tr_usb_drive_02a":784,"bkr_prop_fakeid_boxdriverl_01a":616,"v_corp_bk_rolladex":61,"ba_dlc_ba_int2_money_counter":347,"prop_a4_pile_01":616,"v_club_vu_ink_3":527,"m24_1_prop_m41_scrim_01a":734,"p_planning_board_03":880,"prop_b_board_blank":454,"sf_prop_sf_cds_pile_01a":747,"m23_2_prop_m32_folder_01b":357,"h4_prop_h4_bag_djlp_01a":438,"v_club_vu_ink_1":307,"xm3_prop_xm3_plan_board_01a":863,"p_planning_board_01":676,"ch_prop_whiteboard_03":521,"xm3_prop_xm3_plan_board_01c":658,"tr_prop_tr_usb_drive_01a":920,"xm3_prop_xm3_clipboard_pp":691,"prop_inout_tray_02":993,"prop_copier_01":377,"prop_muster_wboard_02":586,"v_med_cor_fileboxa":534,"xm3_prop_xm3_plan_board_01b":900,"v_ind_cs_paper":710,"p_cs_clipboard":520,"xm3_prop_xm3_plan_board_01d":636,"prop_watercooler":856,"m23_2_prop_m32_manifest_01a":696,"ex_office_swag_med4":336,"h4_prop_h4_board_01a":632,"prop_medstation_01":845,"v_res_mousemat":686,"v_ret_gc_calc":341,"v_corp_bk_flag":746,"v_24_postertubes":775,"prop_folder_02":885,"prop_shredder_01":323,"prop_cs_mouse_01":894,"xm3_prop_xm3_pola_m8_corkb":408,"bkr_prop_fakeid_ruler_02a":714,"v_med_cor_pinboard":588,"prop_broken_cboard_p1":396,"v_ret_gc_folder2":355,"ex_office_citymodel_01":509,"bkr_prop_fakeid_pen_02a":343,"tr_prop_tr_clipboard_sh_01a":725,"prop_beta_tape":395,"m24_1_prop_m41_notebook_01a":385,"prop_cd_folder_pile4":466,"tr_prop_tr_clipboard_ta_01a":588,"prop_printer_02":502,"v_corp_bk_lflts":417,"prop_printer_01":935,"prop_ld_headset_01":570,"v_ret_gc_print":554,"bkr_prop_fakeid_cd_01a":676,"prop_cd_folder_pile2":817,"xm3_prop_xm3_pouch_01a":658,"p_cs_pamphlet_01_s":739,"hei_prop_dlc_heist_board":370,"prop_fire_exting_2a":400,"v_res_fa_magtidy":348,"prop_cd_paper_pile1":972,"v_ret_gc_trays":681,"bkr_prop_fakeid_bundlepassports":410,"ng_proc_paper_news_rag":784,"prop_off_phone_01":950,"m23_2_prop_m32_clipboard_01a":515,"v_ret_gc_shred":780,"v_ilev_acet_projector":452,"prop_inout_tray_01":318,"v_res_sketchpad":450,"v_ret_gc_fan":534,"v_res_filebox01":433,"v_res_paperfolders":891,"m24_1_prop_m41_secret_folder_01a":775,"bkr_prop_fakeid_pen_01a":799,"xm3_prop_xm3_box_pspt_01a":510,"v_med_centrifuge2":492,"ch_prop_ch_usb_drive01x":987,"prop_inhaler_01":879,"ch_prop_ch_schedule_01a":303,"bkr_prop_fakeid_ruler_01a":753,"reh_prop_reh_folder_01b":443,"prop_cs_envolope_01":483,"v_ret_gc_fax":722,"ch_prop_marker_01a":809,"prop_ecg_01":773,"xm3_prop_xm3_clipboard_skd":951,"v_med_cor_whiteboard":866,"reh_prop_reh_folder_01a":777,"prop_ld_scrap":668,"xm_prop_x17_harddisk_01a":408,"v_club_vu_coffeemug1":856,"prop_medstation_04":334,"v_ilev_mm_screen":827,"prop_gaffer_tape":691,"v_ret_gc_mug03":535,"prop_fib_clipboard":825,"prop_paper_box_05":878,"v_res_cd":769,"bkr_prop_fakeid_boxpassport_01a":796,"prop_paper_box_03":976,"prop_paper_box_04":400,"xm3_prop_xm3_package_01a":420,"hei_prop_hst_usb_drive":525,"xm3_prop_xm3_clipboard_bl":359,"prop_paper_box_01":868,"bkr_prop_fakeid_penclipboard":913,"v_med_p_notebook":329,"xs_prop_arena_clipboard_01b":301,"v_corp_bank_pen":887,"v_ind_cs_oilbot03":889,"prop_fire_exting_3a":872,"prop_oiltub_03":996,"v_res_j_phone":395,"v_ilev_lest_bigscreen":989,"v_ind_cm_fan":727,"v_res_tre_bedsidetableb":449,"mp_b_tab_sidesml_01":524,"h4_mp_h_yacht_side_table_01":928,"hei_heist_str_sideboardl_05":836,"mp_b_tab_sidesml_02":322,"v_corp_sidetable":702,"hei_heist_tab_sidelrg_01":603,"v_res_d_smallsidetable":731,"apa_mp_h_str_sideboards_02":911,"tr_int1_mod_cabinet":537,"prop_cabinet_01":870,"prop_rub_cabinet02":778,"m23_2_prop_m32_sec_cabinet_01f":843,"ch_prop_ch_sec_cabinet_02a":633,"prop_rub_cabinet":629,"prop_cabinet_02b":639,"prop_cabinet_01b":401,"m23_2_prop_m32_cabinet_02a":619,"imp_prop_tool_cabinet_01a":884,"m23_2_prop_m32_cabinet_01a":304,"ch_chint02_filing_cabinet":619,"m23_2_prop_m32_tallcabinet_01a":669,"m23_2_prop_m32_shelve_crt_01a":955,"bkr_int_02_trophy_shelves":547,"apa_mp_h_str_shelffreel_01":348,"apa_mp_h_str_shelffloorm_02":513,"v_res_tre_smallbookshelf":826,"v_corp_offshelfclo":677,"v_corp_offshelf":589,"v_corp_offshelfdark":720,"tr_int1_smod_toolchest9":429,"h4_int_sub_subweaponsmod":301,"xs_x18intmod_beer_wpn":534,"m23_1_m231_1_osp_gun_mod_station":441,"tr_int1_smod_toolchest_02_001":760,"tr_int1_smod_toolchest_05_001":761,"xs_x18intmod_wpn_bench_01a":958,"xm_osp_gun_mod_station":407,"prop_freeweight_01":410,"prop_weight_15k":315,"prop_weight_5k":450,"prop_freeweight_02":682,"prop_weight_rack_02":871,"prop_weight_rack_01":561,"v_res_tre_weight":486,"prop_weight_10k":808,"prop_weight_20k":695,"prop_weight_squat":491,"prop_weight_bench_02":998,"prop_pris_bench_01":788,"prop_muscle_bench_01":580,"prop_muscle_bench_05":904,"prop_muscle_bench_02":870,"prop_muscle_bench_06":452,"prop_muscle_bench_04":790,"prop_barbell_60kg":539,"prop_curl_bar_01":776,"prop_barbell_10kg":625,"prop_barbell_80kg":518,"prop_barbell_40kg":979,"prop_barbell_20kg":808,"prop_beach_bars_01":989,"prop_barbell_01":607,"prop_barbell_02":326,"ba_dlc_ba_int2_welder_01a":559,"ba_dlc_ba_int2_bench005":731,"ba_dlc_ba_int2_bench004":1000,"ba_dlc_ba_int2_draw_01b":551,"xs_prop_x18_tool_box_02a":782,"ba_dlc_ba_int2_bench01":314,"ba_dlc_ba_int2_bench003":326,"ba_dlc_ba_int2_tool_cab":713,"ba_dlc_ba_int2_engine_hoist":699,"ba_dlc_ba_int2_strut":551,"ba_dlc_ba_int2_air_comp":839,"w_am_jerrycan_sf":791,"w_am_jerrycan":548,"ba_dlc_ba_int2_trans001":343,"ba_dlc_ba_int2_chest_01a":407,"ch_prop_ch_heist_drill":889,"prop_fire_hosereel":386,"xm3_prop_xm3_spool_copp_01a":458,"xm3_prop_xm3_lab_toulene":887,"tr_int1_smodd_cs_jerrycan01_001":661,"prop_toolchest_04":976,"prop_cs_gascutter_1":578,"prop_tool_screwdvr02":814,"imp_prop_impexp_differential_01a":864,"prop_wheel_06":517,"xm3_prop_xm3_tool_box_02a":816,"imp_prop_impexp_clamp_01":892,"w_me_wrench":593,"gr_prop_gr_sdriver_01":512,"v_ind_cs_oiltin":768,"v_ind_cs_oilbot01":927,"v_ind_cs_pliers":930,"prop_carjack":677,"prop_toolchest_05":317,"gr_prop_gr_pliers_02":392,"prop_ind_mech_01c":812,"ba_dlc_ba_int2_axel_stand_01a":433,"v_ind_cs_wrench":718,"prop_rub_wheel_02":947,"tr_int1_smod_oilcan_01a_001":655,"imp_prop_impexp_rack_02a":690,"gr_prop_gr_sdriver_02":431,"m23_2_prop_m32_bolt_cutter_01a":491,"v_ind_cs_oilbot04":647,"ba_dlc_ba_int2_wheel_bal_01a":451,"prop_rub_wheel_01":580,"h4_prop_h4_gascutter_01a":560,"m23_2_prop_m32_plasticcan_01a":738,"v_ret_gc_ear01":765,"prop_voltmeter_01":716,"tr_int1_smodd_cor_hose_001":362,"imp_prop_impexp_hub_rack_01a":555,"xm3_prop_xm3_sdriver_01":516,"prop_tool_spanner01":923,"ch_prop_toolbox_01b":998,"prop_toolchest_01":456,"prop_spray_jackleg":952,"xs_prop_x18_tool_box_01a":457,"gr_prop_gr_drill_01a":485,"prop_byard_gastank02":497,"gr_prop_gr_driver_01a":738,"tr_int1_smod_compressor_03":442,"prop_tool_consaw":825,"imp_prop_impexp_parts_rack_04a":889,"v_ind_cs_drill":427,"prop_loose_rag_01":569,"imp_prop_impexp_parts_rack_02a":476,"v_club_roc_gstand":635,"xm_prop_x17_tool_draw_01a":473,"sf_prop_tool_draw_01d":856,"xs_prop_x18_torque_wrench_01a":647,"imp_prop_impexp_parts_rack_05a":781,"prop_welding_mask_01":892,"prop_tool_mallet":488,"prop_pliers_01":704,"xs_prop_x18_speeddrill_01c":462,"ba_dlc_ba_int2_car_jack":468,"h4_prop_h4_tool_box_01b":325,"prop_compressor_02":484,"prop_tool_adjspanner":603,"xs_prop_x18_tool_draw_01e":868,"imp_prop_tool_draw_01d":641,"imp_prop_impexp_spanset_01":694,"prop_air_towbar_01":687,"v_ind_cm_crowbar":571,"imp_prop_tool_cabinet_01c":967,"gr_prop_gr_pliers_03":730,"m23_2_int4_m232_mechanic_upgrade":779,"v_serv_hndtrk_n2_aa_h":384,"m23_2_prop_m32_blowtorch_01a":407,"ba_dlc_ba_int2_scale_02":443,"v_med_cor_hose":983,"imp_prop_impexp_engine_part_01a":968,"tr_int1_smod_carjack_01":609,"imp_prop_impexp_brake_caliper_01a":990,"prop_cs_trolley_01":183,"prop_cs_creeper_01":908,"gr_prop_gr_rasp_02":300,"prop_car_battery_01":748,"w_me_hammer":383,"tr_int1_smod_carcreeper_001":335,"xm3_prop_xm3_grinder_01a":928,"prop_gas_rack01":493,"gr_prop_gr_lathe_01a":735,"prop_gascyl_04a":782,"prop_sacktruck_01":305,"prop_paint_stepl01":387,"prop_sacktruck_02a":597,"prop_etricmotor_01":435,"tr_prop_tr_car_lift_01a":554,"prop_picnictable_01":728,"prop_table_para_comb_04":597,"prop_yacht_table_03":913,"prop_table_02":362,"prop_chateau_table_01":497,"prop_table_para_comb_03":427,"prop_picnictable_02":607,"prop_parasol_05":374,"prop_parasol_03":893,"prop_parasol_01_down":803,"prop_parasol_03_b":861,"prop_old_wood_chair":346,"prop_skid_chair_03":584,"v_ret_gc_chair02":739,"prop_chair_pile_01":629,"prop_gazebo_02":390,"prop_gazebo_01":973,"prop_gazebo_03":428,"rtx_djn_swimmingpool_1":782,"rtx_djn_swimmingpool_2":813,"prop_yacht_lounger":827,"prop_patio_lounger1b":790,"prop_patio_lounger_3":917,"p_patio_lounger1_s":563,"prop_patio_lounger1":360,"prop_patio_lounger_2":780,"prop_beachbag_04":530,"prop_beachbag_06":898,"prop_boogbd_stack_02":583,"prop_beach_lotion_02":725,"prop_beach_sandcas_04":565,"prop_buck_spade_10":406,"prop_beach_sandcas_05":663,"prop_beachbag_02":685,"prop_beach_sandcas_03":647,"prop_beachbag_01":589,"prop_beachbag_03":673,"prop_beach_lotion_01":474,"prop_beachflag_02":343,"prop_beach_lg_float":759,"prop_beach_sculp_01":523,"prop_rolled_yoga_mat":138,"prop_beach_punchbag":445,"prop_beach_parasol_01":485,"prop_beach_lilo_02":518,"prop_beach_parasol_07":458,"prop_beach_parasol_05":408,"prop_boogieboard_08":437,"prop_venice_board_03":479,"prop_venice_board_01":907,"prop_beach_bars_02":958,"vw_prop_casino_art_basketball_01a":733,"prop_buck_spade_04":818,"prop_beachball_01":459,"prop_beach_sandcas_01":598,"prop_buck_spade_02":854,"prop_beach_bag_02":856,"prop_beach_bag_03":873,"prop_fnclog_01a":387,"prop_tree_cedar_03":319,"prop_tree_birch_03":705,"prop_tree_cedar_s_01":433,"prop_palm_sm_01e":820,"prop_tree_eng_oak_01":622,"prop_s_pine_dead_01":950,"prop_palm_fan_02_b":946,"prop_tree_birch_03b":329,"prop_palm_fan_03_d_graff":502,"prop_palm_sm_01a":423,"prop_tree_jacada_01":733,"test_tree_forest_trunk_04":460,"prop_palm_fan_04_b":359,"prop_tree_jacada_02":451,"prop_snow_tree_04_f":738,"prop_snow_tree_04_d":667,"prop_tree_fallen_01":307,"prop_w_r_cedar_01":893,"prop_palm_fan_04_d":323,"prop_palm_fan_03_c":308,"prop_tree_olive_creator":695,"prop_tree_cedar_s_04":671,"prop_tree_maple_03":558,"prop_tree_lficus_02":999,"prop_tree_cedar_s_06":673,"prop_palm_fan_02_a":564,"prop_tree_lficus_06":419,"prop_tree_birch_02":827,"h4_prop_tree_umbrella_sml_01":554,"prop_tree_eng_oak_creator":326,"prop_veg_crop_tr_02":902,"prop_joshua_tree_02d":881,"prop_cs_pebble":817,"prop_rock_4_big2":945,"csx_rvrbldr_medc_":999,"cs_x_rubweec":612,"cs_x_rubsmlb":465,"cs_x_rubweea":942,"prop_ld_rubble_02":335,"prop_rock_4_big":510,"h4_prop_rock_med_02":961,"csx_coastsmalrock_03_":615,"csx_rvrbldr_smla_":500,"cs_x_rubweee":654,"cs_x_rubsmld":715,"csx_rvrbldr_medb_":494,"rock_4_cl_2_1":696,"rock_4_cl_2_2":772,"csx_rvrbldr_medd_":466,"prop_rock_1_i":632,"csx_coastboulder_04_":886,"prop_rock_4_e":444,"prop_rock_1_h":677,"csx_coastsmalrock_04_":551,"prop_test_rocks04":413,"prop_test_rocks01":492,"prop_test_rocks02":549,"csx_rvrbldr_smle_":753,"cs_x_rubsmle":866,"prop_rock_2_f":866,"prop_rock_2_d":547,"h4_prop_rock_lrg_04":753,"h4_prop_h4_firepit_rocks_01a":933,"prop_rock_5_smash1":982,"prop_rock_2_c":562,"prop_tv_stand_01":936,"prop_tv_flat_02b":550,"prop_tv_flat_michael":986,"v_med_cor_flatscreentv":624,"prop_tv_flat_03b":540,"prop_tv_05":323,"prop_tv_03":736,"sm_prop_smug_tv_flat_01":974,"vw_prop_vw_cinema_tv_01":732,"prop_tv_01":971,"des_tvsmash_start":637,"xs_prop_arena_screen_tv_01":848,"prop_cs_tv_stand":796,"prop_tv_flat_03":720,"prop_tv_flat_02":968,"prop_tv_06":611,"prop_tv_04":486,"prop_trev_tv_01":804,"xm_prop_x17_tv_flat_01":577,"prop_tv_flat_01":330,"sf_prop_sf_tv_studio_01a":366,"ex_prop_ex_tv_flat_01":765,"gr_prop_gr_trailer_tv":351,"gr_prop_gr_trailer_tv_02":565,"hei_prop_server_piece_01":833,"bkr_ware05_laptop3":512,"gr_prop_gr_console_01":339,"prop_dyn_pc":562,"m24_1_prop_m41_server_01c":723,"bkr_prop_clubhouse_laptop_01a":809,"sf_int1_laptop_armoury":413,"prop_cs_power_cell":649,"xm_base_cia_serversml_01":563,"ba_prop_club_laptop_dj":649,"sf_prop_sf_laptop_01a":737,"gr_prop_gr_laptop_01a":819,"bkr_prop_clubhouse_laptop_01b":591,"sf_prop_sf_laptop_01b":940,"h4_prop_h4_jammer_01a":673,"xm_prop_x17_laptop_lester_01":989,"gr_prop_gr_laptop_01b":691,"h4_prop_club_laptop_dj":909,"xm_prop_x17_laptop_agent14_01":754,"reh_prop_reh_laptop_01a":888,"xm_prop_x17_res_pctower":506,"m23_1_prop_m31_mainframe_01a":908,"ba_prop_battle_club_computer_01":394,"p_laptop_02_s":731,"m23_2_prop_m32_laptoplscm_01a":579,"prop_laptop_jimmy":895,"ba_prop_battle_club_computer_02":520,"m24_1_prop_m41_monitor_02a":949,"bkr_ware05_pclatopbasic1":813,"bkr_ware05_pcupgrade2":815,"vw_prop_vw_trailer_monitor_01":752,"xm_base_cia_server_01":773,"xm_prop_x17_laptop_mrsr":367,"v_ind_ss_laptop":968,"hei_prop_mini_sever_03":335,"v_corp_servercln2":832,"sf_prop_sf_monitor_s_02a":444,"xm_base_cia_servermed_01":804,"tr_prop_tr_ser_storage_01a":979,"p_cs_laptop_02":605,"hei_prop_mini_sever_broken":565,"prop_pc_02a":383,"m23_1_prop_m31_laptop_01a":913,"prop_dyn_pc_02":446,"hei_prop_heist_pc_01":524,"prop_pc_01a":461,"v_res_lest_monitor":916,"prop_monitor_01d":456,"xm_int02_security_monitor":920,"v_res_monitor":354,"prop_monitor_03b":343,"prop_monitor_li":309,"prop_monitor_01b":848,"prop_monitor_w_large":593,"v_serv_ct_monitor07":418,"v_serv_ct_monitor06":512,"v_serv_ct_monitor04":396,"v_serv_ct_monitor03":805,"v_serv_ct_monitor02":489,"v_res_monitorwidelarge":689,"v_serv_ct_monitor01":319,"prop_monitor_01a":722,"prop_monitor_01c":382,"bkr_ware05_monitorbasic":913,"sf_prop_sf_monitor_01a":544,"ch_prop_ch_monitor_01a":829,"v_serv_ct_monitor05":753,"tr_prop_tr_monitor_01b":811,"sf_prop_sf_monitor_stu_01a":888,"tr_prop_tr_monitor_01a":580,"prop_monitor_04a":641,"v_res_pcspeaker":524,"ba_prop_battle_club_speaker_array":785,"v_club_roc_cab3":374,"ba_prop_battle_club_speaker_large":957,"prop_boombox_01":424,"v_res_fa_radioalrm":529,"h4_prop_battle_dj_mixer_01a":353,"h4_prop_battle_dj_box_03a":627,"v_club_roc_micstd":959,"sm_prop_smug_mic":709,"sf_prop_sf_speaker_l_01a":491,"ba_prop_battle_club_speaker_dj":446,"prop_mp3_dock":721,"sf_prop_sf_mic_rec_01b":460,"prop_table_mic_01":348,"prop_amp_01":726,"prop_50s_jukebox":674,"h4_prop_battle_dj_deck_01a_a":983,"h4_prop_battle_dj_t_box_03a":423,"prop_el_guitar_02":666,"prop_portable_hifi_01":786,"h4_prop_battle_dj_kit_mixer":561,"h4_prop_battle_dj_box_02a":471,"h4_prop_battle_dj_kit_speaker":352,"prop_cs_walkie_talkie":569,"prop_cctv_cont_05":611,"prop_el_guitar_01":806,"prop_speaker_06":982,"v_club_vu_deckcase":875,"vw_prop_vw_headset_01a":345,"sm_prop_smug_radio_01":718,"h4_prop_battle_mic":605,"h4_prop_battle_analoguemixer_01a":681,"prop_speaker_07":643,"prop_podium_mic":835,"xm3_prop_xm3_boombox_01a":704,"h4_prop_battle_dj_box_01a":933,"prop_speaker_01":403,"h4_prop_battle_club_speaker_array":631,"prop_speaker_03":785,"prop_hifi_01":986,"h4_prop_h4_tannoy_01a":449,"sf_prop_sf_amp_01a":574,"h4_prop_battle_dj_deck_01a":817,"v_club_roc_eq2":410,"prop_ear_defenders_01":545,"v_ret_ta_power":508,"sf_prop_sf_el_guitar_02a":510,"sf_prop_sf_amp_02a":975,"vw_prop_vw_ex_pe_01a":679,"prop_ghettoblast_02":573,"sf_prop_sf_blocker_studio_01a":627,"ba_prop_battle_dj_kit_speaker":674,"sf_prop_sf_mic_rec_01a":373,"prop_speaker_08":753,"sf_prop_sf_mic_01a":389,"sf_prop_sf_mic_rec_02a":389,"prop_el_tapeplayer_01":635,"h4_prop_battle_club_speaker_large":478,"v_club_roc_mixer1":554,"v_club_roc_mixer2":699,"sm_prop_smug_wall_radio_01":728,"sf_prop_sf_headphones_dj":832,"v_club_roc_monitor":803,"prop_v_bmike_01":557,"prop_dj_deck_02":543,"prop_out_door_speaker":950,"v_res_pcwoofer":567,"h4_prop_battle_rotarymixer_01a":973,"stt_prop_speakerstack_01a":737,"h4_prop_h4_mic_dj_01a":360,"sf_prop_sf_amp_head_01a":903,"ba_prop_battle_mic":645,"v_res_fh_speaker":626,"h4_prop_battle_club_speaker_small":579,"v_res_mm_audio":793,"p_ing_microphonel_01":875,"ba_prop_battle_dj_kit_mixer":926,"ba_prop_battle_dj_mixer_01e":628,"ba_prop_battle_dj_mixer_01d":613,"sm_prop_smug_speaker":838,"ba_prop_battle_dj_mixer_01b":673,"h4_prop_battle_dj_mixer_01f":349,"ba_prop_battle_dj_mixer_01c":691,"m24_1_prop_m41_radio_01a":307,"xm3_prop_xm3_spkr_wall_01a":463,"sf_prop_sf_ps_mixer_01a":644,"prop_radio_01":479,"prop_speaker_02":979,"prop_speaker_05":460,"sf_prop_sf_speaker_wall_01a":638,"ba_prop_battle_dj_stand":893,"prop_cctv_cont_03":367,"prop_cctv_cont_04":803,"ch_prop_fingerprint_scanner_01d":757,"ch_prop_casino_keypad_02":358,"prop_cctv_pole_01a":982,"m23_1_prop_m31_control_panel_01a":830,"prop_dest_cctv_03":679,"p_rail_controller_s":154,"prop_cctv_cam_04a":951,"hei_prop_bank_cctv_02":880,"prop_cctv_cam_04b":538,"hei_prop_hei_securitypanel":545,"prop_cctv_cam_04c":902,"v_res_cctv":548,"prop_gshotsensor_01":821,"prop_cctv_cam_05a":452,"p_cctv_s":913,"ch_prop_baggage_scanner_01a":617,"m24_1_prop_m24_1_carrier_bank_cctv_02":917,"prop_cctv_cont_06":865,"ch_prop_ch_cctv_cam_01a":499,"prop_cctv_cont_02":555,"m24_1_prop_m24_1_carrier_bank_cctv_01":846,"prop_cctv_unit_05":304,"prop_cctv_cont_01":775,"prop_cctv_unit_04":513,"v_res_tre_alarmbox":868,"prop_cctv_cam_02a":375,"v_corp_bk_secpanel":984,"prop_cctv_unit_01":694,"xm_int_lev_silo_keypad_01":629,"prop_cctv_pole_04":315,"prop_cctv_unit_02":480,"prop_cctv_cam_03a":628,"prop_turnstyle_01":832,"v_serv_lgtemg":817,"prop_spycam":540,"prop_cctv_cam_01a":445,"prop_cctv_cam_01b":830,"xm_prop_x17_screens_01a":847,"ba_prop_battle_security_pad":997,"prop_cctv_cam_06a":411,"prop_gatecom_01":632,"prop_cs_cctv":913,"h4_prop_h4_fingerkeypad_01b":987,"hei_prop_heist_transponder":397,"ba_prop_battle_cctv_cam_01b":597,"ba_prop_battle_cctv_cam_01a":340,"m23_2_prop_m32_greenlight_01a":143,"prop_cctv_pole_02":751,"ch_prop_ch_metal_detector_01a":345,"prop_cctv_pole_03":778,"prop_cctv_unit_03":973,"m23_1_prop_m31_jammer_01a":814,"m23_2_prop_m32_jammer_01a":439,"prop_solarpanel_02":451,"prop_solarpanel_03":626,"prop_solarpanel_01":555,"rtx_djn_solar_panel_1":693,"v_res_tt_tvremote":798,"v_res_tre_remote":816,"prop_controller_01":135,"xm_prop_x17_clicker_01":857,"prop_satdish_s_01":662,"m23_2_int6_m232_fan_base_1":406,"prop_fan_01":968,"prop_sewing_machine":398,"prop_aerial_01a":564,"prop_cs_dvd_player":541,"ex_prop_tv_settop_remote":457,"prop_satdish_s_04b":351,"prop_aerial_01d":924,"v_res_fa_fan":957,"v_res_fh_towerfan":512,"prop_ing_camera_01":351,"v_res_mountedprojector":528,"prop_vcr_01":669,"prop_cs_remote_01":988,"v_ind_ss_deskfan":564,"prop_satdish_2_a":951,"prop_satdish_3_d":776,"prop_satdish_2_g":822,"prop_elec_heater_01":561,"m24_1_prop_m24_1_carrier_phone_02":624,"v_ilev_fib_sprklr_off":440,"prop_vend_coffe_01":556,"rtx_djn_light_ceiling_1":559,"rtx_djn_light_ceiling_2":673,"rtx_djn_light_ceiling_3":666,"rtx_djn_light_ceiling_4":745,"rtx_djn_light_ceiling_5":465,"rtx_djn_light_ceiling_6":669,"rtx_djn_light_hanging_1":909,"rtx_djn_light_hanging_2":321,"rtx_djn_light_hanging_3_large":947,"rtx_djn_light_hanging_3_medium":359,"rtx_djn_light_hanging_3_small":575,"rtx_djn_light_hanging_4":618,"rtx_djn_light_hanging_5":327,"rtx_djn_light_hanging_6":660,"rtx_djn_light_hanging_7":548,"rtx_djn_light_hanging_8":459,"rtx_djn_light_hanging_9":843,"prop_fragtest_cnst_04":511,"xm_prop_lab_cyllight01":699,"v_ind_cflight02":824,"v_ind_cs_striplight":772,"prop_fragtest_cnst_08":418,"h4_prop_x17_sub_lampa_large_white":568,"xm_prop_x17_sub_lampa_small_yel":608,"h4_prop_x17_sub_lampa_small_blue":679,"h4_prop_x17_sub_lampa_large_blue":649,"xm_prop_x17_sub_lampa_small_white":424,"xm_prop_x17_sub_lampa_large_white":736,"h4_prop_x17_sub_lampa_small_yel":746,"h4_prop_x17_sub_lampa_large_yel":799,"xm_prop_x17_sub_lampa_large_blue":603,"h4_prop_x17_sub_lampa_small_white":346,"prop_wall_light_17b":689,"prop_wall_light_06a":551,"prop_fragtest_cnst_08c":910,"bkr_prop_grow_lamp_02a":688,"hei_heist_lit_lightpendant_02":365,"m23_1_m231_2_track_light_sign01":968,"v_club_roc_spot_w":837,"tr_prop_tr_light_ceiling_01a":660,"bkr_prop_biker_pendant_light":734,"m24_1_prop_m41_chandelier_01a":871,"xm_prop_lab_strip_lightb":667,"h4_prop_battle_lights_ceiling_l_b":594,"bkr_prop_coke_striplamp_long_01a":381,"ch_prop_ch_lamp_ceiling_g_01a":422,"v_res_tre_lightfan":735,"v_serv_ct_striplight":311,"xs_prop_arena_lights_ceiling_l_c":909,"h4_prop_battle_lights_ceiling_l_f":997,"xm_base_cia_lamp_ceiling_02a":658,"h4_prop_casinoclub_lights_domed":725,"prop_wall_light_12":763,"prop_spot_clamp_02":464,"imp_impexp_hanginglamp009":516,"imp_impexp_hanginglamp004":384,"imp_impexp_hanginglamp003":397,"imp_impexp_hanginglamp006":858,"imp_impexp_hanginglamp007":687,"imp_impexp_hanginglamp005":645,"hei_prop_bank_ornatelamp":769,"bkr_prop_biker_ceiling_fan_base":334,"m24_1_prop_m24_1_carrier_bank_ornatelamp":884,"imp_impexp_hanginglamp01":773,"xs_prop_arena_lights_tube_l_a":413,"v_serv_metro_tubelight2":456,"h4_prop_battle_lights_wall_l_a":744,"xm_prop_lab_wall_lampb":571,"xs_prop_arena_lights_wall_l_a":755,"xs_prop_arena_lights_wall_l_c":887,"ch_prop_ch_lamp_wall_01a":521,"h4_prop_battle_lights_wall_l_d":529,"xs_prop_x18_hangar_lamp_led_b":992,"h4_prop_battle_lights_wall_l_b":353,"v_ret_fh_walllighton":988,"v_serv_metro_tunnellight2":300,"v_serv_metro_tunnellight1":998,"xs_prop_x18_hangar_lamp_wall_b":863,"xm_prop_lab_wall_lampa":780,"xm_prop_lab_tube_lampa":916,"port_xr_lightspot":384,"v_serv_metro_walllightcage":948,"v_serv_ct_light":829,"prop_wall_light_18a":784,"prop_wall_light_08a":712,"prop_wall_light_14b":510,"prop_oldlight_01b":374,"xs_prop_x18_hangar_lamp_wall_a":498,"prop_wall_light_02a":463,"prop_ld_cont_light_01":997,"prop_wall_light_20a":800,"ch_prop_ch_utility_light_wall_01a":965,"prop_wall_light_19a":541,"prop_walllight_ld_01":766,"prop_wall_light_03b":575,"prop_wall_light_14a":609,"prop_wall_light_04a":512,"prop_wall_light_07a":932,"prop_wall_light_03a":647,"prop_wall_light_16d":872,"sm_hanger_office_moden_lamp1":594,"hei_heist_lit_floorlamp_01":994,"sm_hanger_office_tradlamp2":381,"mp_b_lit_lamptable_06":662,"h4_mp_h_yacht_floor_lamp_01":616,"sum_mp_h_yacht_table_lamp_02":652,"m24_1_prop_m41_kino_light_01a":554,"mp_b_lit_lamptable_02":860,"v_ret_gc_lamp":919,"mp_b_lit_lamptable_03":337,"mp_b_lit_floorlamp_01":761,"v_res_j_tablelamp2":549,"mp_b_lit_floorlamp_02":942,"ba_work_light_clutter001":690,"mp_b_lit_floorlamp_04":814,"sf_mp_h_yacht_table_lamp_01":497,"mp_b_lit_floorlamp_05":577,"vw_prop_casino_art_lampf_01a":301,"sf_mp_h_yacht_table_lamp_03":332,"prop_cd_lamp":529,"bkr_prop_fakeid_desklamp_01a":980,"v_res_fh_floorlamp":726,"apa_mp_h_lit_lamptable_04":534,"apa_mp_h_lit_lamptablenight_24":323,"vw_prop_vw_lamp_01":674,"h4_mp_h_acc_candles_06":580,"apa_mp_h_yacht_table_lamp_01":839,"v_med_p_lamp_on":449,"v_res_fh_lampa_on":884,"prop_kino_light_03":703,"v_res_d_lampa":346,"vw_prop_casino_art_lampm_01a":800,"v_res_j_tablelamp1":488,"m23_2_prop_m32_desk_lamp":422,"v_res_tre_talllamp":583,"prop_kino_light_02":620,"prop_studio_light_01":702,"apa_mp_h_lit_lamptable_09":666,"hei_prop_hei_bnk_lamp_02":996,"apa_mp_h_lit_floorlamp_17":834,"apa_mp_h_lit_lamptablenight_16":686,"v_club_vu_lamp":878,"apa_mp_h_lit_floorlamp_06":312,"apa_mp_h_lit_floorlamp_10":512,"apa_mp_h_lit_floorlamp_13":851,"xm_prop_base_tripod_lampa":359,"prop_kino_light_01":671,"prop_worklight_04d":619,"apa_mp_h_floorlamp_b":731,"apa_mp_h_lit_lamptable_17":509,"v_res_m_lampstand":610,"apa_mp_h_lit_floorlamp_01":591,"apa_mp_h_lit_floorlamp_03":819,"apa_mp_h_lit_floorlampnight_05":432,"apa_mp_h_lit_lamptable_14":690,"v_corp_bk_lamp2":797,"apa_mp_h_lit_lamptable_005":714,"apa_mp_h_floorlamp_c":539,"prop_worklight_01a":382,"v_med_examlight":341,"ch_prop_ch_tunnel_worklight":587,"xm_prop_base_tripod_lampb":603,"prop_worklight_04b":637,"apa_mp_h_lit_floorlamp_02":1000,"apa_mp_h_lit_floorlampnight_07":634,"prop_worklight_02a":498,"imp_impexp_hanginglamp002":945,"prop_worklight_03a":678,"tr_int1_mod_elec_01":470,"m24_1_prop_m41_circuitbox_open_01a":789,"p_v_ilev_chopshopswitch_s":439,"prop_pap_camera_01":658,"v_ind_cm_electricbox":666,"prop_byard_elecbox03":697,"v_ret_ta_camera":995,"xm_prop_x17_powerbox_01":853,"prop_aircon_s_02b":749,"m23_1_prop_m31_controlpanel_02a":420,"prop_v_cam_01":511,"prop_elecbox_02a":375,"prop_sub_trans_03a":845,"prop_elecbox_01a":800,"prop_sub_release":610,"prop_sub_trans_04a":580,"prop_aircon_m_10":490,"prop_fbibombcupbrd":497,"prop_elecbox_04a":552,"prop_office_alarm_01":484,"prop_elecbox_06a":679,"v_med_lab_elecbox1":703,"m23_1_prop_m31_electricbox_03a":412,"v_corp_bombhum":847,"prop_byard_elecbox02":484,"tr_prop_tr_elecbox_01a":572,"vw_prop_vw_elecbox_01a":413,"m23_1_prop_m31_electricbox_01a":966,"port_xr_elecbox_3":726,"prop_aircon_s_07a":845,"prop_elecbox_18":758,"prop_byard_elecbox04":686,"prop_elecbox_20":975,"h4_prop_h4_fuse_box_01a":609,"prop_elecbox_23":444,"prop_elecbox_10_cr":918,"h4_prop_h4_elecbox_01a":509,"v_ind_rc_fans":794,"ba_prop_club_dimmer":570,"m24_1_prop_m41_controlpanel_01a":552,"sf_prop_sf_el_box_01a":845,"rtx_djn_el_outlet":477,"rtx_djn_light_switcher_off_1":645,"rtx_djn_house_smart_central_control_1":410,"rtx_djn_house_smart_central_control_2":477,"rtx_djn_house_smart_central_control_3":917,"luxesofa_prop":691,"algusofa1_prop":336,"algusofa2_prop":458,"comfycouch1_prop":395,"comfycouch2_prop":912,"comfycouch3_prop":638,"comfycouch4_prop":670,"comfycouch5_prop":994,"comfycouch6_prop":601,"comfycouch7_prop":604,"comfycouch8_prop":941,"comfycouch9_prop":793,"comfycouch10_prop":334,"legacysofa1_prop":361,"legacysofa2_prop":589,"legacysofa3_prop":968,"legacysofa4_prop":890,"legacysofa5_prop":471,"luxevelvetsofa1_prop":345,"luxevelvetsofa2_prop":855,"luxevelvetsofa3_prop":302,"luxevelvetsofa4_prop":607,"luxevelvetsofa5_prop":980,"novasofa1_prop":552,"novasofa2_prop":959,"peanutcouch1_prop":995,"peanutcouch2_prop":496,"peanutcouch3_prop":508,"suedecouch1_prop":996,"suedecouch2_prop":723,"suedecouch3_prop":388,"suedecouch4_prop":833,"warrenbottomrest1_prop":931,"warrenbottomrest2_prop":641,"warrenbottomrest3_prop":883,"warrenheadrest1_prop":455,"warrenheadrest2_prop":774,"warrenheadrest3_prop":780,"warrenbottomone1_prop":476,"warrenbottomone2_prop":674,"warrenbottomone3_prop":644,"warenhead1_prop":780,"warenhead2_prop":984,"warenhead3_prop":689,"warenottomon1_prop":442,"warenottomon2_prop":810,"warenottomon3_prop":825,"cloudcouchbla_prop":567,"cloudcouchwhi_prop":845,"bismuthchair_prop":625,"kittycouchsingle1_prop":439,"kittycouchsingle2_prop":747,"kittycouchsingle3_prop":637,"kittycouchsingle4_prop":993,"kittycouchsofa1_prop":537,"kittycouchsofa2_prop":545,"kittycouchsofa3_prop":500,"kittycouchsofa4_prop":387,"thesingle1_prop":376,"thesingle2_prop":497,"thesingle3_prop":825,"thedouble1_prop":638,"thedouble2_prop":888,"thedouble3_prop":921,"cloudsingle1_prop":772,"cloudsingle2_prop":624,"cloudsingle3_prop":854,"cloudsingle4_prop":313,"cloudright1_prop":426,"cloudright2_prop":819,"cloudright3_prop":741,"cloudright4_prop":970,"cloudotto1_prop":437,"cloudotto2_prop":751,"cloudotto3_prop":536,"cloudotto4_prop":426,"cloudmiddle1_prop":873,"cloudmiddle2_prop":331,"cloudmiddle3_prop":992,"cloudmiddle4_prop":807,"cloudleft1_prop":903,"cloudleft2_prop":445,"cloudleft3_prop":523,"cloudleft4_prop":678,"farmsinglechair1_prop":881,"farmsinglechair2_prop":953,"farmsinglechair3_prop":324,"farmsinglechair4_prop":396,"farmthreeseat1_prop":733,"farmthreeseat2_prop":355,"farmthreeseat3_prop":411,"farmthreeseat4_prop":620,"farmtwoseat1_prop":957,"farmtwoseat2_prop":797,"farmtwoseat3_prop":553,"farmtwoseat4_prop":700,"loafsofa_prop":492,"loafsofa1_prop":961,"loafsofa2_prop":639,"loafsofa4_prop":989,"pufmidsofa_prop":420,"pufottoman_prop":312,"pufrightsofa_prop":817,"sofasof1_prop":440,"sofasof2_prop":733,"sofasof3_prop":668,"sofasof4_prop":795,"pressurecouch_prop":772,"ledcouchp_prop":948,"lashtechtabl_prop":545,"cuifcouch_prop":837,"buildysofa1_prop":602,"buildysofa2_prop":537,"buildysofa3_prop":397,"buildysofa4_prop":360,"buildysofa5_prop":847,"nanacouch1_prop":642,"nanacouch2_prop":615,"nanacouch12_prop":661,"nanacouch21_prop":407,"bumcouch1_prop":599,"bumcouch2_prop":510,"sumasofa1_prop":859,"sumasofa2_prop":752,"sumasofa3_prop":364,"sumasofa4_prop":945,"sumasofa5_prop":653,"sumasofa6_prop":601,"sumasofa7_prop":541,"sumasofato1_prop":483,"sumasofato3_prop":939,"sumasofato4_prop":743,"sumasofato5_prop":768,"sumasofato6_prop":716,"sumasofato7_prop":678,"sumasofatr1_prop":730,"sumasofatr2_prop":487,"sumasofatr3_prop":352,"sumasofatr4_prop":411,"sumasofatr5_prop":303,"sumasofatr6_prop":957,"sumasofatr7_prop":952,"famcouchwhi_prop":887,"famledlightcouch_prop":648,"militarycouch_prop":392,"comfychair1_prop":376,"comfychair2_prop":989,"comfychair3_prop":822,"comfychair4_prop":340,"comfychair5_prop":947,"comfychair6_prop":351,"comfychair7_prop":681,"comfychair8_prop":956,"comfychair9_prop":300,"comfychair10_prop":535,"comfypufchair1_prop":819,"comfypufchair2_prop":964,"comfypufchair3_prop":488,"comfypufchair4_prop":402,"comfypufchair5_prop":514,"knitbeanchair1_prop":977,"knitbeanchair2_prop":329,"luxechair1_prop":929,"luxechair2_prop":390,"luxechair3_prop":545,"luxechair4_prop":459,"poufpillowchair2_prop":582,"poufpillowchair1_prop":482,"poufpillowchair3_prop":402,"agchair1_prop":536,"agchair2_prop":356,"agchair3_prop":486,"agchair4_prop":308,"thchair1_prop":970,"thchair2_prop":311,"theoutchair1_prop":852,"theoutchair2_prop":399,"theoutchair3_prop":569,"simplechiar1_prop":994,"simplechiar2_prop":700,"simplechiar3_prop":748,"simplechiar4_prop":477,"simplechiar5_prop":466,"saxchair1_prop":317,"saxchair2_prop":486,"saxchair3_prop":741,"saxchair4_prop":954,"saxchair5_prop":413,"queenseat1_prop":979,"queenseat2_prop":970,"queenseat3_prop":759,"queenseat4_prop":300,"queenseat5_prop":527,"queenseat6_prop":981,"queenseat7_prop":586,"queenseat8_prop":870,"queenseat9_prop":932,"queenbar1_prop":770,"queenbar2_prop":383,"queenbar3_prop":367,"queenbar4_prop":371,"queenbar5_prop":846,"queenbar6_prop":822,"queenbar7_prop":784,"queenbar8_prop":406,"queenbar9_prop":524,"kaychair_prop":881,"lloungechair1_prop":315,"lloungechair2_prop":425,"lloungechair3_prop":473,"ferdinachair1_prop":637,"ferdinachair2_prop":683,"ferdinachair3_prop":444,"grandmachair1_prop":325,"grandmachair2_prop":800,"loafchair1_prop":417,"loafchair2_prop":313,"loafchair3_prop":654,"loafchair4_prop":308,"outdoorchair1_prop":615,"outdoorchair2_prop":596,"parvchair1_prop":812,"parvchair2_prop":389,"parvchair3_prop":779,"parvchair4_prop":514,"peanchair1_prop":979,"peanchair2_prop":716,"sexloungechair1_prop":969,"sexloungechair2_prop":671,"anguschair1_prop":658,"anguschair2_prop":550,"anguschair3_prop":451,"blacktufchair_prop":540,"umachair_prop":426,"titichair_prop":984,"glasscirclechair_prop":884,"glasscirclechair1_prop":618,"pumpumichair2_prop":682,"kimachair_prop":922,"nunchair_prop":348,"ouwchair_prop":448,"luxvanitychair1_prop":587,"luxvanitychair2_prop":355,"luxvanitychair3_prop":606,"luxvanitychair4_prop":978,"rhotto1_prop":446,"rhotto2_prop":937,"rhotto3_prop":459,"hermaottomon1_prop":330,"hermaottomon2_prop":987,"hermaottomon3_prop":547,"hermaottomon4_prop":701,"lilpuf1_prop":686,"lilpuf2_prop":833,"lilpuf3_prop":424,"thipouf1_prop":625,"thipouf2_prop":689,"thipouf3_prop":992,"tuftcircot1_prop":909,"tuftcircot2_prop":886,"tuftcircot3_prop":410,"bagottomon1_prop":907,"bagottomon2_prop":873,"bagottomon3_prop":612,"4rotto_prop":771,"tuftfinott_prop":499,"edottomon_prop":884,"cloudtableblack_prop":900,"poufpillowchair4_prop":882,"cloudtablewhi_prop":349,"kittycofetable1_prop":640,"kittycofetable2_prop":828,"kittycofetable3_prop":922,"kittycofetable4_prop":961,"kittycofetable5_prop":759,"marbletable1_prop":675,"marbletable2_prop":981,"marbletable3_prop":316,"marbletable4_prop":937,"marbletable5_prop":694,"marbletable6_prop":724,"marbletable7_prop":693,"kittyottomon1_prop":775,"kittyottomon2_prop":832,"kittyottomon3_prop":839,"kittyottomon4_prop":415,"kittyottomon5_prop":495,"kittyottomon6_prop":962,"kittyottomon7_prop":520,"kittyottomon8_prop":910,"nostyletable_prop":317,"rhcofetable_prop":808,"warrentable1_prop":620,"warrentable2_prop":801,"warrentable3_prop":719,"baretvstand_prop":667,"colorliving1_prop":558,"colorliving2_prop":326,"colorliving3_prop":471,"colorliving4_prop":511,"pillartvstand1_prop":701,"pillartvstand2_prop":565,"pillartvstand3_prop":890,"pillartvstand4_prop":346,"startvstand1_prop":396,"startvstand2_prop":897,"startvstand3_prop":627,"shoeshelf1_prop":870,"shoeshelf2_prop":766,"shoeshelf3_prop":758,"shoeshelf4_prop":856,"shoeshelf5_prop":510,"luxeshelf1_prop":697,"luxeshelf3_prop":798,"monicatvstand1_prop":534,"monicatvstand2_prop":932,"monicatvstand3_prop":379,"monicatvstand4_prop":910,"monicatvstand5_prop":864,"monicatvstand6_prop":724,"icecofeetable_prop":330,"lumcoffetable_prop":519,"pufsofatable1_prop":435,"pufsofatable2_prop":500,"sqcofeetab1_prop":534,"sqcofeetab2_prop":549,"sqcofeetab3_prop":387,"sqcofeetab4_prop":870,"sqcofeetab5_prop":559,"sqcofeetab6_prop":940,"sqcofeetab7_prop":984,"sqcofeetab8_prop":709,"sqcofeetab9_prop":942,"sqcofeetab10_prop":956,"sqcofeetab11_prop":721,"stonecofetab1_prop":865,"stonecofetab2_prop":865,"stonecofetab3_prop":906,"finewoodtable1_prop":575,"finewoodtable2_prop":724,"dianatable1_prop":895,"dianatable2_prop":686,"dianatable3_prop":624,"dianatable4_prop":381,"lumtable_prop":760,"concretedesk1_prop":953,"concretedesk2_prop":485,"concretedesk3_prop":851,"concretedesk4_prop":425,"concretecounterr1_prop":802,"concretecounterr2_prop":820,"concretecounterr3_prop":841,"concretecounterr4_prop":499,"concretecounterr5_prop":399,"concretecounterr6_prop":440,"circledining1_prop":585,"circledining2_prop":743,"circledining3_prop":433,"besidemitable1_prop":703,"besidemitable2_prop":789,"alidining1_prop":912,"alidining2_prop":769,"alidining3_prop":355,"abstractconsol1_prop":307,"abstractconsol2_prop":431,"abstractconsol3_prop":981,"abstractconsol4_prop":573,"abstractconsol5_prop":667,"wwardrisland1_prop":943,"wwardrisland2_prop":577,"wwardrisland3_prop":320,"wwardrisland4_prop":300,"wwardrisland5_prop":805,"whiwardrobe1_prop":464,"whiwardrobe2_prop":807,"whiwardrobe3_prop":739,"whiwardrobe4_prop":345,"whiwardrobe5_prop":694,"unentertable1_prop":408,"unentertable2_prop":431,"unentertable3_prop":981,"throundtable1_prop":854,"throundtable2_prop":683,"throundtable3_prop":376,"luxetalwa1_prop":323,"luxetalwa2_prop":827,"luxetalwa3_prop":314,"sundiningtab1_prop":942,"sundiningtab2_prop":384,"slidetvtable_prop":592,"ptvstand1_prop":499,"ptvstand2_prop":460,"ptvstand3_prop":651,"pietvstand1_prop":320,"pietvstand2_prop":927,"pietvstand3_prop":698,"pietvstand4_prop":660,"noricaisland1_prop":319,"noricaisland2_prop":549,"noricaisland3_prop":920,"noricaisland4_prop":959,"nashisland1_prop":794,"nashisland2_prop":432,"mirrorvanityy1_prop":939,"mirrorvanityy2_prop":481,"mirrorvanityy3_prop":670,"crushedsidetbl_prop":558,"mirroreddressr1_prop":827,"mirroreddressr2_prop":432,"crushedtable_prop":614,"miatvstand1_prop":368,"miatvstand2_prop":421,"miatvstand3_prop":389,"miatvstand4_prop":642,"miatvstand5_prop":685,"miatvstand6_prop":427,"miatvstand7_prop":448,"miatvstand8_prop":661,"masonmarble1_prop":916,"masonmarble2_prop":741,"masonmarble3_prop":815,"masonmarble4_prop":754,"luxemirrorcof1_prop":409,"luxemirrorcof2_prop":307,"luxemirrorcof3_prop":921,"luxemirrorcof4_prop":724,"luxeglassvanity1_prop":488,"luxeglassvanity2_prop":743,"luxeglassvanity3_prop":379,"luxeglassvanity4_prop":345,"luxeglassvanity5_prop":541,"ikeluxvanity_prop":688,"ikedresser1_prop":594,"ikedresser2_prop":694,"idaglasstable1_prop":940,"idaglasstable2_prop":420,"idaglasstable3_prop":913,"goobdresser1_prop":570,"goobdresser2_prop":422,"goobdresser3_prop":752,"goobdresser4_prop":482,"glassoffdesk_prop":735,"fuidesk_prop":992,"diandesk1_prop":351,"diandesk2_prop":796,"diandesk3_prop":535,"diandesk4_prop":668,"diandesk5_prop":517,"deluxdesk1_prop":533,"deluxdesk2_prop":667,"deluxisland1_prop":466,"deluxisland2_prop":503,"deluxclosetmi1_prop":797,"deluxclosetmi2_prop":443,"deluxcloset1_prop":660,"deluxcloset2_prop":619,"deluxcloset3_prop":387,"zesbookshelf1_prop":956,"zesbookshelf2_prop":806,"zesbookshelf3_prop":770,"cdwardrobe1_prop":864,"cdwardrobe2_prop":625,"cdwardrobe3_prop":467,"peoplewardrobe1_prop":519,"peoplewardrobe2_prop":733,"ugikeadres_prop":510,"barldressor_prop":311,"barlwardrobe_prop":511,"cddesk1_prop":918,"cddesk2_prop":650,"cddesk3_prop":330,"aiitvstand_prop":687,"pollytvstand_prop":777,"jahcoffeetable_prop":505,"novasidetable1_prop":932,"novasidetable2_prop":726,"novasidetable3_prop":342,"novasidetable4_prop":927,"novasidetable5_prop":504,"novasidetable6_prop":873,"novasidetable7_prop":448,"novasidetable8_prop":709,"cybrrug1_prop":603,"cybrrug21_prop":852,"cybrrug31_prop":883,"cybrrug41_prop":601,"cybrrug51_prop":849,"cybrrug61_prop":672,"cybrrug71_prop":344,"wetrug_prop":383,"cheetarug_prop":848,"stussyrug_prop":769,"acncrug_prop":469,"crossrug_prop":436,"diorrug_prop":803,"dogrug_prop":856,"mariorug_prop":909,"sheeprug_prop":573,"chrug_prop":814,"100rugb_prop":660,"100rugf_prop":709,"unorug1_prop":439,"unorug2_prop":829,"unorug3_prop":378,"unorug4_prop":466,"unorug5_prop":713,"unorug6_prop":367,"unorug7_prop":614,"unorug8_prop":879,"unorug9_prop":778,"unorug10_prop":445,"unorug11_prop":754,"tanrugsone1_prop":811,"tanrugsone2_prop":890,"tanrugsone3_prop":460,"tanrugsone4_prop":972,"tanrugsone5_prop":404,"tanrugsone6_prop":802,"tanrugsone7_prop":685,"tanrugsone8_prop":458,"tanrugsone9_prop":875,"tanrugsone10_prop":399,"tanrugsone11_prop":844,"tanrugsone12_prop":730,"tanrugsone13_prop":318,"tanrugsone14_prop":863,"tanrugsone15_prop":995,"tanrugsone16_prop":830,"tanrugsone17_prop":747,"blackrugone1_prop":405,"blackrugone2_prop":409,"blackrugone3_prop":371,"blackrugone4_prop":600,"blackrugone5_prop":906,"blackrugone6_prop":434,"blackrugone7_prop":395,"blackrugone8_prop":967,"smilerugsone1_prop":928,"smilerugsone2_prop":420,"smilerugsone3_prop":302,"smilerugsone4_prop":806,"smilerugsone5_prop":453,"smilerugsone6_prop":914,"smilerugsone7_prop":943,"smilerugsone8_prop":418,"smilerugsone9_prop":535,"smilerugsone10_prop":806,"luxemarbelrug1_prop":368,"luxemarbelrug2_prop":830,"luxemarbelrug3_prop":329,"luxemarbelrug4_prop":701,"cucustomrugs1_prop":667,"cucustomrugs2_prop":951,"cucustomrugs3_prop":309,"cucustomrugs4_prop":351,"cucustomrugs5_prop":472,"cucustomrugs6_prop":488,"cucustomrugs7_prop":524,"cucustomrugs8_prop":772,"cucustomrugs9_prop":514,"cucustomrugs10_prop":932,"cucustomrugs11_prop":761,"cucustomrugs12_prop":620,"cucustomrugs13_prop":659,"cucustomrugs14_prop":909,"cucustomrugs15_prop":846,"estaterug1_prop":609,"estaterug2_prop":740,"estaterug3_prop":770,"estaterug4_prop":431,"tavrionrug1_prop":388,"tavrionrug2_prop":575,"tavrionrug3_prop":579,"tavrionrug4_prop":726,"simplisticrug1_prop":844,"simplisticrug2_prop":460,"simplisticrug3_prop":416,"simplisticrug4_prop":342,"simplisticrug5_prop":937,"simplisticrug6_prop":371,"recolorrugs1_prop":788,"recolorrugs2_prop":756,"recolorrugs3_prop":664,"recolorrugs4_prop":750,"recolorrugs5_prop":665,"recolorrugs6_prop":778,"recolorrugs7_prop":497,"recolorrugs8_prop":311,"recolorrugs9_prop":744,"smallhomerug1_prop":358,"smallhomerug2_prop":382,"smallhomerug3_prop":300,"smallhomerug4_prop":413,"smallhomerug5_prop":996,"smallhomerug7_prop":320,"smallhomerug8_prop":434,"smallhomerug9_prop":668,"celestbedone_prop":845,"celestbedtwo_prop":969,"celestbedthree_prop":649,"celestbedfour_prop":863,"celestbedfive_prop":705,"goldfishbedbott_prop":649,"goldfishbed1_prop":343,"goldfishbed2_prop":396,"goldfishbed3_prop":362,"celestbedframeone_prop":336,"celestbedframetwo_prop":369,"celestbedframethree_prop":645,"celestbedframefour_prop":832,"celestbedframefive_prop":383,"vanillabed1_prop":547,"vanillabed2_prop":822,"vanillabed3_prop":929,"vanillabed21_prop":575,"vanillabed22_prop":833,"vanillabed23_prop":470,"vanillabed31_prop":333,"vanillabed32_prop":670,"vanillabed33_prop":544,"yftbedr1_prop":302,"yftbedr2_prop":479,"yftbedr3_prop":793,"yftbedr4_prop":892,"miyahbed_prop":981,"nenebed_prop":488,"babymomabed_prop":961,"francebed_prop":818,"harleybed_prop":586,"ticketbed_prop":775,"bunnabed_prop":427,"milegebed_prop":402,"bfloorbed_prop":668,"ninebed1_prop":922,"ninebed2_prop":862,"ninebed3_prop":978,"ninebed4_prop":434,"ninebed5_prop":860,"ninebed6_prop":920,"nestybed_prop":581,"nestybedframe1_prop":829,"nestybedframe2_prop":300,"nestybedframe3_prop":453,"nestybedframe4_prop":599,"newagebed1_prop":900,"newagebed2_prop":988,"newagebed3_prop":362,"newagebed4_prop":722,"newagebed5_prop":796,"newageframe1_prop":787,"newageframe2_prop":483,"newageframe3_prop":754,"newageframe4_prop":312,"newageframe5_prop":668,"kiobed1_prop":665,"kiobed2_prop":421,"kirabed1_prop":924,"kirabed2_prop":744,"kirabed3_prop":872,"kirahead1_prop":365,"kirahead2_prop":460,"kirahead3_prop":633,"caelumheadboard1_prop":872,"caelumheadboard2_prop":692,"caelumheadboard3_prop":827,"caelumheadboard4_prop":838,"caelummatr1_prop":571,"caelummatr2_prop":644,"caelummatr3_prop":743,"caelummatr4_prop":595,"caelummatr5_prop":613,"caelummatr6_prop":596,"caelummatr7_prop":892,"caelummatr8_prop":759,"caelummatr9_prop":695,"caelummatr10_prop":754,"caelummatr11_prop":418,"caelumhead_prop":971,"comfyairmatress1_prop":358,"comfyairmatress2_prop":569,"comfyairmatress3_prop":606,"comfyairmatress4_prop":976,"chesbed1_prop":746,"chesbed2_prop":467,"chesbed3_prop":338,"chesbed4_prop":602,"chesbed5_prop":577,"chesbed6_prop":370,"chesframe1_prop":412,"chesframe2_prop":318,"chesframe3_prop":898,"chesframe4_prop":472,"chesframe5_prop":876,"chesframe6_prop":961,"corbed_prop":379,"cozybed1_prop":462,"cozybed2_prop":736,"cozybed3_prop":503,"cozybed4_prop":519,"cozybed5_prop":425,"cozybed6_prop":342,"cozybed7_prop":552,"cozybed8_prop":808,"cozybed9_prop":477,"cozybed10_prop":613,"cozybed11_prop":934,"cozybed12_prop":982,"cushbed1_prop":413,"cushbed2_prop":927,"cushbed3_prop":996,"cushbed4_prop":568,"cushbed5_prop":569,"floorbed1_prop":318,"floorbed2_prop":321,"floorbed3_prop":685,"hangbed1_prop":455,"hangbed2_prop":861,"hangleaves_prop":867,"teenbed1_prop":765,"teenbed2_prop":652,"tuftbed1_prop":787,"tuftbed2_prop":726,"tuftbed3_prop":878,"tuftbed4_prop":791,"tuftbedframe1_prop":791,"tuftbedframe2_prop":640,"tuftbedframe3_prop":591,"tuftbedframe4_prop":465,"tuftbedframe5_prop":453,"lovebed1_prop":435,"lovebed2_prop":426,"lovebed3_prop":462,"lovebed4_prop":972,"sanriobed1_prop":551,"sanriobed2_prop":485,"sanriobed3_prop":861,"sanriobed4_prop":566,"sanriobed5_prop":805,"sanriobed6_prop":442,"sanriobed7_prop":564,"sanriobed8_prop":767,"sanriobed9_prop":492,"sanriobed10_prop":335,"sanriobed11_prop":798,"sanriobed12_prop":899,"bedcanopy1_prop":327,"bedcanopy2_prop":799,"bedcanopy3_prop":906,"bedcanopy4_prop":953,"bedcanopy5_prop":669,"bedcanopy6_prop":783,"bedcanopy7_prop":464,"bedroomcanopt1_prop":406,"bedroomcanopt2_prop":475,"bamboolight1_prop":492,"bamboolight2_prop":730,"bamboolight3_prop":753,"syboulight_prop":978,"khdlight_prop":415,"warzenlight1_prop":998,"warzenlight2_prop":413,"warzenlight3_prop":735,"ringlight1_prop":639,"ringlight2_prop":552,"ringlight3_prop":805,"globelight1_prop":893,"globelight2_prop":587,"globelight3_prop":382,"globelight4_prop":912,"estatelight1_prop":668,"estatelight2_prop":694,"estatelight3_prop":672,"estatelight4_prop":960,"britlamp1_prop":322,"britlamp2_prop":368,"britlamp3_prop":900,"belgiumlight1_prop":552,"belgiumlight2_prop":562,"belgiumlight3_prop":400,"uxemirrorlamp_prop":629,"shinolight_prop":491,"ruelight1_prop":770,"ruelight2_prop":378,"ruelight3_prop":321,"nashlight1_prop":778,"nashlight2_prop":522,"lenlight1_prop":378,"lenlight2_prop":779,"lenlight3_prop":647,"camlight1_prop":790,"camlight2_prop":356,"iglolight1_prop":942,"iglolight2_prop":531,"iglolight3_prop":341,"iglolight4_prop":865,"enfloorlamp_prop":355,"kiaceilinglamp_prop":636,"sanlight_prop":317,"spirallight_prop":833,"standingcandle1_prop":718,"standingcandle2_prop":932,"aueyfloorlamp1_prop":893,"aueyfloorlamp2_prop":719,"aueyfloorlamp3_prop":787,"beautychandelier_prop":382,"beautychandelier2_prop":807,"moneyledlight_prop":973,"cubansledlights1_prop":672,"cubansledlights2_prop":969,"cubansledlights3_prop":907,"cubansledlights4_prop":526,"cubansledlights5_prop":346,"cubansledlights6_prop":989,"cubansledlights7_prop":951,"cubansledlights8_prop":470,"cubansledlights9_prop":852,"vanillabedpillow1_prop":468,"vanillabedpillow2_prop":992,"chainpillow1_prop":966,"chainpillow2_prop":951,"chainpillow3_prop":820,"chainpillow4_prop":540,"chainpillow5_prop":307,"chainpillow6_prop":629,"chainpillow7_prop":869,"evergpillow1_prop":753,"evergpillow2_prop":494,"kkpillow1_prop":471,"kkpillow2_prop":364,"kkpillow3_prop":540,"kkpillow4_prop":769,"kkpillow5_prop":600,"kkpillow6_prop":301,"lavishpillow1_prop":940,"lavishpillow2_prop":980,"lavishpillow3_prop":324,"lavishpillow4_prop":666,"luxepillow1_prop":743,"luxepillow2_prop":654,"luxepillow3_prop":806,"luxepillow4_prop":430,"algulong_prop":894,"luxesofacushins1_prop":637,"luxesofacushins2_prop":831,"luxesofacushins3_prop":562,"luxesofacushins4_prop":784,"luxevelvetcoushins1_prop":924,"luxevelvetcoushins2_prop":841,"luxevelvetcoushins3_prop":406,"luxevelvetcoushins4_prop":971,"luxevelvetcoushins5_prop":615,"luxevelvetcoushins6_prop":535,"warrenpillow1_prop":909,"warrenpillow2_prop":440,"warrenpillow3_prop":497,"flowerpillowwhi_prop":323,"flowerpillowpurp_prop":745,"flowerpillowpin_prop":950,"flowerpillowgreen_prop":175,"flowerpillowbla_prop":490,"vanillablanket1_prop":620,"vanillablanket2_prop":932,"vanillablanket3_prop":449,"vanillablanket4_prop":733,"lilblanket1_prop":616,"lilblanket2_prop":780,"lilblanket3_prop":566,"caelumpillow1_prop":468,"caelumpillow2_prop":967,"caelumpillow3_prop":889,"caelumpillow4_prop":377,"caelumpillow5_prop":409,"caelumpillow6_prop":474,"caelumpillow7_prop":995,"caelumpillow8_prop":870,"caelumpillow9_prop":654,"caelumblanket1_prop":863,"caelumblanket2_prop":393,"caelumblanket3_prop":915,"caelumblanket4_prop":870,"caelumblanket5_prop":778,"caelumblanket6_prop":672,"caelumblanket7_prop":527,"tuftpillow1_prop":935,"tuftpillow2_prop":343,"tuftpillow3_prop":576,"tuftpillow4_prop":319,"tuftpillow5_prop":791,"tuftblanket1_prop":983,"tuftblanket2_prop":575,"tuftblanket3_prop":689,"tuftblanket4_prop":324,"tuftblanket5_prop":337,"chespillow1_prop":540,"chespillow2_prop":481,"chespillow3_prop":860,"chespillow4_prop":955,"chespillow5_prop":973,"chespillow6_prop":846,"chesblanket1_prop":698,"chesblanket2_prop":596,"chesblanket3_prop":323,"chesblanket4_prop":850,"chesblanket5_prop":315,"chesblanket6_prop":337,"cozyblanketone_prop":658,"cozyblankettwo1_prop":835,"cozyblankettwo2_prop":729,"cozyblankettwo3_prop":943,"cozyblankettwo4_prop":510,"cozyblankettwo5_prop":600,"cozyblankettwo6_prop":387,"cozyblankettwo7_prop":646,"cozyblankettwo8_prop":882,"cozyblankettwo9_prop":304,"cozyblankettwo10_prop":494,"cozyblankettwo11_prop":817,"cozyblankettwo12_prop":971,"hangblanket1_prop":398,"hangblanket2_prop":991,"hangblanket3_prop":515,"kiablanket1_prop":404,"kiablanket2_prop":510,"kiablanket3_prop":986,"kirablanket1_prop":851,"kirablanket2_prop":806,"kirablanket3_prop":793,"kirablanket4_prop":942,"kirablanket6_prop":640,"nestyblanket1_prop":811,"nestyblanket2_prop":595,"nestyblanket3_prop":690,"nestyblanket4_prop":303,"nestyblanket5_prop":339,"nestyblanket6_prop":504,"newageblanket1_prop":847,"newageblanket2_prop":913,"newageblanket3_prop":903,"newageblanket4_prop":550,"newageblanket5_prop":695,"cozypillows1_prop":781,"cozypillows2_prop":369,"cozypillows3_prop":855,"cozypillows4_prop":717,"cozypillows5_prop":896,"cushpillows1_prop":981,"cushpillows2_prop":512,"cushpillows3_prop":644,"cushpillows4_prop":468,"cushpillows5_prop":734,"hangpillows1_prop":555,"hangpillows2_prop":530,"hangpillows3_prop":426,"kirapillow1_prop":936,"kirapillow2_prop":653,"kirapillow3_prop":872,"kirapillow4_prop":947,"kirapillow5_prop":592,"randpillows1_prop":626,"randpillows2_prop":412,"randpillows3_prop":466,"randpillows4_prop":657,"randpillows5_prop":667,"randpillows6_prop":467,"sanripillow1_prop":883,"sanripillow2_prop":932,"sanripillow3_prop":522,"sanripillow4_prop":919,"sanripillow5_prop":887,"sanripillow6_prop":894,"sanripillow7_prop":852,"sanripillow8_prop":992,"sanripillow9_prop":627,"sanripillow10_prop":384,"sanripillow11_prop":557,"sanripillow12_prop":894,"sanripillow13_prop":883,"sanripillow14_prop":818,"sanripillow15_prop":616,"sanripillow16_prop":402,"sanriblanket1_prop":470,"sanriblanket2_prop":592,"sanriblanket3_prop":317,"sanriblanket4_prop":578,"sanriblanket5_prop":480,"sanriblanket6_prop":324,"sanriblanket7_prop":444,"sanriblanket8_prop":967,"sanriblanket9_prop":371,"floorblanket_prop":301,"bunnapillo_prop":728,"ticketpillow_prop":699,"yftuniversalbla_prop":84,"yftpillow1_prop":890,"yftpillow2_prop":848,"francepillow_prop":820,"harleypillow_prop":993,"harleyblank_prop":499,"heartpillow_prop":555,"glogangpillow_prop":981,"flowerpillow1_prop":747,"flowerpillow2_prop":516,"chromepillow1_prop":346,"chromepillow2_prop":987,"starpillow_prop":931,"squirttle_prop":503,"miyahpillow_prop":498,"floorflower_prop":732,"cuifpilo2_prop":557,"pressurepillows_prop":876,"cuifpillow2_prop":415,"chromesspillow1_prop":876,"chromesspillow2_prop":377,"chromesspillow3_prop":577,"chromesspillow4_prop":905,"chromesspillow5_prop":961,"chromesspillow6_prop":740,"chromesspillow7_prop":350,"bambooplant1_prop":317,"bambooplant2_prop":554,"bambooplant3_prop":881,"cactusplant1_prop":445,"cactusplant2_prop":501,"novasplant1_prop":733,"novasplant2_prop":341,"palmplant1_prop":883,"palmplant2_prop":993,"palmplant3_prop":836,"leaveplants1_prop":492,"leaveplants2_prop":542,"bamboo1_prop":638,"bamboo2_prop":434,"prettyglower1_prop":560,"prettyglower2_prop":751,"prettyglower3_prop":565,"prettyglower4_prop":801,"prettyglower5_prop":472,"miyaplant1_prop":862,"miyaplant2_prop":949,"miyaplant3_prop":954,"miyaplant4_prop":399,"miyaplant5_prop":650,"miyaplant6_prop":829,"lilliesplant1_prop":919,"lilliesplant2_prop":733,"hangingplant1_prop":365,"hangingplant2_prop":900,"hangingplant3_prop":742,"elasticaplant1_prop":858,"elasticaplant2_prop":771,"effleraplant_prop":412,"driedleaves1_prop":815,"driedleaves2_prop":643,"delilaplant_prop":821,"casterionplant1_prop":409,"casterionplant2_prop":864,"canevase1_prop":570,"canevase2_prop":909,"canevase3_prop":321,"candiplant1_prop":490,"candiplant2_prop":862,"candiplant3_prop":715,"candiplant4_prop":651,"biyaplant1_prop":796,"biyaplant2_prop":879,"biyaplant3_prop":428,"whitecallas1_prop":896,"whitecallas2_prop":779,"tulipplants1_prop":840,"tulipplants2_prop":412,"realisticcactus1_prop":684,"realisticcactus2_prop":722,"wallplants1_prop":753,"cheetaaplant1_prop":734,"cheetaaplant2_prop":365,"ficplant_prop":391,"fiplantt_prop":573,"kimhangplant_prop":585,"lconeplant_prop":728,"heirtree_prop":884,"cornerleaves_prop":456,"dusktblplant_prop":439,"verticlegarden1_prop":933,"verticlegarden2_prop":556,"verticlegarden3_prop":945,"verticlegarden4_prop":718,"cubansbananatree_prop":200,"baddieshedge_prop":813,"onepainting1_prop":739,"onepainting2_prop":794,"onepainting3_prop":441,"onepainting4_prop":351,"onepainting5_prop":963,"onepainting6_prop":781,"onepainting7_prop":483,"twopainting1_prop":433,"twopainting2_prop":695,"twopainting3_prop":588,"twopainting4_prop":923,"twopainting5_prop":478,"twopainting6_prop":884,"twopainting7_prop":466,"twopainting8_prop":354,"threepainting1_prop":337,"threepainting2_prop":555,"threepainting3_prop":808,"threepainting4_prop":624,"threepainting5_prop":741,"threepainting6_prop":985,"threepainting7_prop":565,"threepainting8_prop":521,"threepainting9_prop":828,"fourpainting1_prop":337,"fourpainting2_prop":747,"fourpainting3_prop":885,"fourpainting4_prop":479,"fourpainting5_prop":555,"fourpainting6_prop":552,"fourpainting7_prop":845,"fivepainting1_prop":875,"fivepainting2_prop":997,"fivepainting3_prop":388,"fivepainting4_prop":427,"fivepainting5_prop":696,"sixpainting1_prop":908,"sixpainting2_prop":637,"sixpainting3_prop":538,"sixpainting4_prop":879,"sixpainting5_prop":938,"sixpainting6_prop":710,"sixpainting7_prop":996,"sixpainting8_prop":638,"sevenpainting1_prop":871,"sevenpainting2_prop":653,"sevenpainting3_prop":860,"sevenpainting4_prop":833,"sevenpainting5_prop":978,"sevenpainting6_prop":636,"sevenpainting7_prop":706,"sevenpainting8_prop":921,"eightpainting1_prop":319,"eightpainting2_prop":438,"eightpainting3_prop":320,"eightpainting4_prop":445,"eightpainting5_prop":866,"eightpainting6_prop":764,"eightpainting7_prop":394,"eightpainting8_prop":583,"eightpainting9_prop":340,"eightpainting10_prop":581,"eightpainting11_prop":804,"eightpainting12_prop":891,"eightpainting13_prop":956,"eightpainting14_prop":610,"eightpainting15_prop":300,"ninepainting1_prop":409,"ninepainting2_prop":586,"ninepainting3_prop":1000,"ninepainting4_prop":374,"ninepainting5_prop":791,"ninepainting6_prop":915,"ninepainting7_prop":659,"ninepainting8_prop":334,"ninepainting9_prop":609,"ninepainting10_prop":521,"ninepainting11_prop":336,"ninepainting12_prop":920,"ninepainting13_prop":631,"ninepainting14_prop":538,"swishpaintone1_prop":493,"swishpaintone2_prop":642,"swishpaintone3_prop":464,"swishpaintone4_prop":667,"swishpaintone5_prop":940,"swishpaintone6_prop":331,"abstractpaintone1_prop":967,"abstractpaintone2_prop":527,"modernpaint1_prop":509,"modernpaint2_prop":305,"modernpaint3_prop":679,"modernpaint4_prop":957,"modernpaint5_prop":558,"modernpaint6_prop":413,"modernpaint7_prop":758,"modernpaint8_prop":618,"modernpaint9_prop":948,"contempaint1_prop":940,"contempaint2_prop":466,"contempaint3_prop":315,"contempaint4_prop":611,"contempaint5_prop":880,"contempaint6_prop":851,"100wallf_prop":561,"100wallb_prop":321,"cubewallart1_prop":905,"cubewallart2_prop":603,"cubewallart3_prop":514,"cubewallart4_prop":362,"cubewallart5_prop":675,"diningwallart1_prop":454,"diningwallart2_prop":610,"diningwallart3_prop":628,"simplwallart1_prop":908,"simplwallart2_prop":650,"simplwallart3_prop":770,"simplwallart4_prop":300,"cleanwallart1_prop":845,"cleanwallart2_prop":833,"cleanwallart3_prop":368,"cleanwallart4_prop":515,"cleanwallart5_prop":349,"cleanwallart6_prop":807,"luxefireplacetwo1_prop":557,"luxefireplacetwo2_prop":458,"luxefireplacetwo3_prop":480,"luxefireplacetwo4_prop":938,"luxefireplace1_prop":701,"luxefireplace2_prop":340,"luxefireplace3_prop":805,"luxefireplace4_prop":720,"luxefireplace5_prop":346,"pillarfireplace_prop":482,"vegasfirewood_prop":746,"vegasfireplace1_prop":332,"vegasfireplace2_prop":303,"jamiefireplace_prop":767,"niafireplace1_prop":460,"niafireplace2_prop":791,"niafireplace3_prop":993,"naikidafireplace1_prop":426,"naikidafireplace2_prop":628,"naikidafireplace3_prop":526,"naikidafireplace4_prop":730,"millianfireplace1_prop":784,"millianfireplace2_prop":722,"millianfireplace3_prop":536,"millianfireplace4_prop":563,"millianfireplace5_prop":834,"millianfireplace6_prop":461,"millianfireplace7_prop":616,"millianfireplace8_prop":456,"millianfireplace9_prop":469,"millianfireplace10_prop":710,"millianfireplace11_prop":580,"millianfireplace12_prop":514,"cypherfireplace1_prop":719,"cypherfireplace2_prop":755,"cypherfireplace3_prop":300,"cypherfireplace4_prop":900,"cypherfireplace5_prop":909,"tavafireplace1_prop":801,"tavafireplace2_prop":367,"tavafireplace3_prop":363,"tavafireplace4_prop":405,"oppollofireplace1_prop":349,"oppollofireplace2_prop":536,"oppollofireplace3_prop":575,"nashvillefireplace_prop":622,"minimalistfireplace1_prop":955,"minimalistfireplace2_prop":745,"minimalistfireplace3_prop":461,"minimalistfireplace4_prop":900,"oyefireplace1_prop":535,"oyefireplace2_prop":723,"oyefireplace3_prop":556,"baloondog1_prop":300,"baloondog2_prop":473,"baloondog3_prop":540,"baloondog4_prop":709,"baloondog5_prop":709,"baloondog6_prop":424,"channelbear1_prop":991,"channelbear2_prop":367,"channelbear3_prop":580,"bigklaws1_prop":576,"bigklaws2_prop":567,"bigklaws3_prop":997,"bigklaws4_prop":853,"bigklaws5_prop":796,"bigklaws6_prop":746,"bigklaws7_prop":313,"bigklaws8_prop":877,"bapestarshoes1_prop":784,"bapestarshoes2_prop":868,"bapestarshoes3_prop":755,"bapestarshoes4_prop":487,"bapestarshoes5_prop":664,"gloomybear1_prop":987,"gloomybear2_prop":700,"gloomybear3_prop":498,"gloomybear4_prop":977,"gloomybear5_prop":506,"ghostfaceplush_prop":515,"froggyplush_prop":878,"hellokittyplush_prop":777,"takashiwall_prop":599,"moneyspread1_prop":396,"moneyspread2_prop":562,"shoppingbag1_prop":790,"shoppingbag2_prop":436,"cheetabirkin1_prop":686,"cheetabirkin2_prop":896,"telferbag_prop":999,"packs_prop":362,"scamswipper_prop":575,"pncchecks_prop":598,"lilheadset1_prop":845,"lilheadset2_prop":970,"lilheadset3_prop":447,"macbookprofp1_prop":609,"macbookprofp2_prop":306,"macbookprofp3_prop":611,"macbookfour_prop":992,"macbookfive_prop":734,"macbooksix_prop":650,"iphonewhi_prop":922,"deskfan1_prop":562,"deskfan2_prop":645,"deskfan3_prop":476,"deskfan4_prop":848,"deskfan5_prop":840,"outlet_prop":514,"roku_prop":544,"ps4clut1_prop":544,"ps4clut2_prop":743,"ps4clut3_prop":978,"xbox_prop":527,"ps4box_prop":452,"xboxbox_prop":527,"spotifytv_prop":768,"spotifytvice_prop":918,"magazinclut1_prop":771,"magazinclut2_prop":720,"magazinclut3_prop":765,"magazinclut4_prop":660,"magazinclut5_prop":575,"magazinclut6_prop":434,"magazinclut7_prop":965,"magazinclut8_prop":697,"magazinclut9_prop":758,"magazinclut10_prop":797,"magazinclut11_prop":434,"magazinclut12_prop":979,"magazinclut13_prop":522,"magazinclut14_prop":463,"magazinclut15_prop":796,"magazinclut16_prop":668,"magazinclut17_prop":849,"magazinclut18_prop":659,"magazinclut19_prop":560,"magazinclut20_prop":711,"celbaloons1_prop":782,"celbaloons2_prop":879,"celbaloons3_prop":916,"celbaloons4_prop":786,"celbaloons5_prop":645,"celbaloons6_prop":438,"celbaloons7_prop":690,"celbaloons8_prop":761,"celbaloons9_prop":756,"celbaloons10_prop":979,"ballonheart_prop":624,"balencishoebag1_prop":392,"balencishoebag2_prop":764,"balencishoebag3_prop":928,"balencishoebag4_prop":857,"balencishoebag5_prop":689,"balencishoebag6_prop":850,"balencishoebag7_prop":641,"balencishoebag8_prop":745,"balencishoebag9_prop":728,"balencishoebag10_prop":883,"balencishoebag11_prop":319,"birknsbag1_prop":528,"birknsbag2_prop":321,"birknsbag3_prop":426,"birknsbag4_prop":434,"birknsbag5_prop":764,"birknsbag6_prop":630,"monivase1_prop":888,"monivase2_prop":474,"monivase3_prop":830,"monivase4_prop":783,"monivase5_prop":320,"cumanniuinheadd_prop":982,"cumanniuinheadd2_prop":793,"cumanniuinheadd3_prop":325,"cumanniuinheadd4_prop":455,"cumanniuinheadd5_prop":827,"cumanniuinheadd6_prop":1000,"stripperstipjar_prop":356,"dirtymoney20s_prop":528,"hunnidsinwand_prop":356,"bambamarp_prop":382,"bluedraco_prop":952,"rubberbandswitch_prop":403,"sharkgun_prop":814,"tansubgun_prop":610,"lilredbutton_prop":433,"glokianagun_prop":659,"greenlilbutton_prop":186,"crossneon_prop":554,"cubeschromecross2_prop":596,"cubeschromneon_prop":424,"purrneonsign_prop":956,"babygirlneon_prop":818,"bsneon_prop":861,"cutequoteneon_prop":964,"lilbaddieneonsign_prop":478,"miamorneon_prop":468,"beautyneon_prop":761,"maniquin1_prop":687,"maniquinn2_prop":479,"maniquinn3_prop":698,"maniquinn4_prop":838,"maniquinn5_prop":750,"manniquin6_prop":861,"manniquin7_prop":347,"manniquin8_prop":470,"manniquin9_prop":828,"manniquin10_prop":472,"manniquin11_prop":771,"manniquin12_prop":869,"hairdryer1_prop":898,"hairdryer2_prop":414,"hairstrai1_prop":468,"hairstrai2_prop":536,"hairstrai3_prop":794,"wigset_prop":932,"lashesdec_prop":452,"adultcandle1_prop":503,"adultcandle2_prop":313,"adultcandle3_prop":644,"adultcandle4_prop":979,"adultcandle5_prop":759,"ltallcandle1_prop":755,"ltallcandle2_prop":442,"ltallcandle3_prop":832,"lsmallcandle1_prop":777,"lsmallcandle2_prop":978,"lsmallcandle3_prop":775,"jocandles1_prop":905,"jocandles2_prop":306,"sentfuse1_prop":396,"sentfuse2_prop":998,"sentfuse3_prop":955,"geodtable_prop":628,"geodtabletwo_prop":940,"drawingesel1_prop":895,"drawingesel2_prop":688,"drawingesel3_prop":673,"drawingesel4_prop":588,"drawingesel5_prop":878,"glasseseal_prop":509,"hangingtap1_prop":349,"hangingtap2_prop":907,"hangingtap3_prop":901,"hangingtap4_prop":461,"hangingtap5_prop":811,"storagebox1_prop":820,"storagebox2_prop":882,"storagebox3_prop":728,"storagebox4_prop":523,"bigbooks_prop":378,"siabooks_prop":928,"longbooks_prop":434,"tableman_prop":303,"tableshell_prop":403,"thingabob_prop":601,"cufldjmixingtable_prop":886,"mixingtable1_prop":421,"mixingtable2_prop":884,"microphonest_prop":917,"cuflmonitor_prop":800,"chrisdiorbag_prop":675,"lockbag1_prop":347,"lockbag2_prop":602,"lockbag3_prop":598,"lockbag4_prop":731,"bowbag1_prop":836,"bowbag2_prop":429,"bowbag3_prop":621,"bowbag4_prop":363,"bowbag5_prop":448,"ylbag1_prop":931,"ylbag2_prop":868,"quinheels1_prop":802,"quinheels2_prop":689,"quinheels3_prop":357,"quinheels4_prop":583,"fluffyrobe1_prop":336,"fluffyrobe2_prop":568,"fluffyrobe3_prop":703,"fluffyrobe4_prop":525,"fluffyrobe5_prop":890,"fluffyrobe6_prop":381,"fluffyrobe7_prop":517,"cubabyoil1_prop":628,"moneycake_prop":127,"moneycircle_prop":621,"cumoneystacks_prop":939,"cashmachine_prop":354,"100sbrick_prop":814,"100stacked_prop":754,"moneywands_prop":462,"onestacks_prop":739,"moneycluster1_prop":613,"moneycutter_prop":881,"yohoemoney_prop":580,"stripperdollars_prop":342,"iphoneboxwa_prop":586,"cuhoverboard_prop":457,"boxgame_prop":776,"llegospider_prop":485,"lilbearbrick_prop":871,"lilmigo_prop":589,"iconkaws_prop":720,"legofinn_prop":313,"halddedkaws_prop":903,"deadlego_prop":490,"powerskaws_prop":430,"powersstat_prop001":516,"glasspannel1_prop":966,"glasspannel2_prop":906,"naturalvase1_prop":531,"naturalvase2_prop":426,"naturalvase3_prop":910,"naturalvase4_prop":326,"cutvases1_prop":678,"cutvases2_prop":647,"lavenderpot_prop":986,"decoringvases_prop":412,"largenicvase1_prop":924,"largenicvase2_prop":393,"largenicvase3_prop":383,"bootystatue_prop":413,"bigmanstatue1_prop":574,"bigmanstatue2_prop":906,"bigmanstatue3_prop":908,"mosaicstatue1_prop":597,"mosaicstatue2_prop":944,"mosaicstatue3_prop":477,"mosaicstatue4_prop":759,"mosaicstatue5_prop":522,"quinstatue1_prop":611,"quinstatue2_prop":319,"quinstatue3_prop":863,"nastybody_prop":486,"cufloresalter_prop":153,"cuweddinggarch_prop":462,"cuweddingpiano_prop":366,"wallcrosscu_prop":442,"cubanspiano1_prop":552,"cubanspiano2_prop":485,"cubanspooltable_prop":413,"grafitinet_prop":796,"glockbox1_prop":678,"glockbox2_prop":342,"culeancup_prop":1000,"cupocketpum":818,"cubanscocain_prop":332,"izer_prop":302,"jackwand_prop":471,"bunnywand_prop":397,"toadstoolwand_prop":391,"subgun_prop":986,"drumgun_prop":822,"reddraco_prop":937,"weedbaglargecub_prop":561,"weedbagop_prop":855,"weedbagsealed_prop":891,"weedbox_prop":655,"dogbonecu1_prop":471,"dogbonecu2_prop":469,"chowchow_prop":772,"puppiesinpod_prop":982,"sleepingdog_prop":529,"cubarstool1_prop":883,"cubarstool2_prop":481,"cubarstool3_prop":721,"cubarstool4_prop":381,"cubarstool5_prop":753,"cucab1_prop":632,"cucab2_prop":877,"cucab3_prop":514,"cucounter1_prop":429,"cucounter2_prop":423,"cucounter3_prop":820,"cucounter4_prop":550,"cucounter5_prop":964,"cucofemaker1_prop":636,"cucofemaker2_prop":461,"curicecooker_prop":363,"custovetop_prop":852,"cutoaster_prop":448,"cuknifeset1_prop":746,"cuknifeset2_prop":577,"cuknifeset3_prop":660,"cumicrowave1_prop":854,"cumicrowave2_prop":600,"cumicrowave3_prop":910,"cufridge1_prop":419,"cufridge2_prop":412,"cufridge3_prop":309,"cufridge4_prop":938,"cufridge5_prop":310,"cuisland1_prop":955,"cuisland2_prop":688,"cuisland3_prop":587,"cuisland4_prop":362,"cuisland5_prop":446,"cuisland6_prop":840,"cuisland7_prop":443,"cuisland8_prop":418,"cuisland9_prop":308,"cucassaroll_prop":109,"cumeatballs_prop":510,"cunachos_prop":767,"cupizza_prop":116,"cuquesa_prop":924,"custeak_prop":792,"cutali_prop":401,"cufridgek1_prop":497,"cufridgek2_prop":400,"cufridge31_prop":842,"cufridge32_prop":449,"cufridge33_prop":390,"cufridge34_prop":430,"toastercu1_prop":908,"toastercu2_prop":727,"toastercu3_prop":950,"toastercu4_prop":763,"trashbincu1_prop":561,"trashbincu2_prop":349,"trashbincu3_prop":305,"trashbincu4_prop":564,"trashbincu5_prop":526,"niccutboard1_prop":315,"niccutboard2_prop":620,"niccutboard3_prop":812,"woodnboard1_prop":876,"woodnboard2_prop":318,"woodnboard3_prop":717,"woodbow1_prop":333,"woodbow2_prop":778,"woodbow3_prop":345,"woodbow4_prop":496,"bigstewpot1_prop":847,"bigstewpot2_prop":994,"stackedpots_prop":956,"largeplates1_prop":623,"stackedbow_prop":376,"fryingpan1_prop":997,"fryingpan2_prop":792,"medpot1_prop":819,"medpot2_prop":301,"metalbaking1_tray":868,"metalbaking2_tray":578,"decortrash_prop":422,"currynaan_prop":50,"cookiecontai1_prop":182,"cookiecontai2_prop":119,"cookiecontai3_prop":64,"cookiecontai4_prop":141,"cunibu_prop":635,"chickensal_prop":119,"chickenpiz_prop":174,"casawhi_prop":478,"casajul_prop":529,"casagold_prop":318,"burgernfries_prop":58,"pankbreakfast_prop":135,"boneless_prop":80,"bigfatmeal_prop":163,"bannabasket_prop":171,"afbottle_prop":187,"wafflesnsex_prop":69,"shrimpplaterr_prop":138,"remyjo_prop":394,"chickenpizz_prop":54,"cupesto_prop":72,"oysterfet_prop":71,"cuorangejuice_prop":187,"lemonbasket_prop":123,"cuhenny_prop":115,"grandliq1_prop":135,"grandliq2_prop":132,"macoronitrayc_prop":169,"chickentrayc_prop":180,"yamstray_prop":105,"greenstray_prop":107,"cufoodrolltray_prop":111,"pinklovecake_prop":65,"bunnychair1_prop":933,"bunnychair2_prop":878,"bunnychair3_prop":585,"bunnychair4_prop":504,"bunnychair5_prop":689,"bunnychair6_prop":889,"bunnychair7_prop":677,"bunnychair8_prop":346,"bunnychair9_prop":993,"bunnychair10_prop":809,"cowchiar1_prop":819,"cowchiar2_prop":318,"cowchiar3_prop":540,"cowchiar4_prop":514,"cowchiar5_prop":996,"cowchiar6_prop":350,"dgamingdesk1_prop":682,"dgamingdesk2_prop":594,"dgamingdesk3_prop":632,"gamingpc1_prop":382,"gamingpc2_prop":565,"gamingpc3_prop":558,"gamingpc4_prop":652,"gamingdesk1_prop":322,"gamingdesk2_prop":792,"gamingdesk3_prop":328,"gamingdesk4_prop":474,"gamingdesk5_prop":333,"gamingdesk6_prop":888,"gamingmonitors1_prop":889,"gamingmonitors2_prop":798,"gamingmonitors3_prop":332,"airfresher_prop":693,"bleach_prop":590,"detergent_prop":907,"odercleaner_prop":811,"deepcleaner_prop":933,"dsoap_prop":669,"laundrysoft_prop":977,"stainremover_prop":785,"toiletpaper_prop":359,"cloxwipes_prop":465,"cuhamper1_prop":449,"cuhamper2_prop":684,"cuhamper3_prop":526,"cuhamper4_prop":793,"cuhamper5_prop":355,"cuwasher1_prop":737,"cuwasher2_prop":355,"cuwasher3_prop":841,"cudryer1_prop":933,"cudryer2_prop":879,"cudryer3_prop":677,"cuvacum1_prop":995,"cuvacum2_prop":557,"cuvacum3_prop":791,"cuvacum4_prop":785,"cushelf1_prop":633,"cushelf2_prop":535,"cushelf3_prop":649,"cushelf4_prop":396,"cufloor1_prop":345,"cufloor2_prop":347,"cufloor3_prop":309,"cufloor4_prop":375,"cufloor5_prop":601,"cufloor6_prop":701,"cufloor7_prop":487,"cufloor8_prop":311,"cufloor9_prop":497,"cufloor10_prop":607,"cufloor11_prop":993,"cuwall1_prop":702,"cuwall2_prop":568,"cuwall3_prop":564,"cuwall4_prop":622,"cuwall5_prop":699,"cuwall6_prop":515,"xxwall_prop":462,"cuironboard_prop":808,"cuvaccum_prop":653,"cuwashndry1_prop":577,"cuwashndry2_prop":486,"cuwashndry3_prop":766,"cuwashndry4_prop":551,"topdryer_prop":686,"topwasher_prop":715,"floorshirt1_prop":977,"floorshirt2_prop":584,"standingcurtv2_prop":992,"standingcurtv3_prop":662,"standingcurtv1_prop":869,"bigasscurtv_prop":908,"bigasstv_prop":596,"upiumtv1_prop":361,"upiumtv2_prop":656,"upiumtv3_prop":784,"smarttvstandin_prop":442,"smartmounttv_prop":683,"smallcurvedtv_prop":629,"musicsettv_prop":576,"hangingceiltv1_prop":695,"hangingceiltv2_prop":680,"freestandintv1_prop":353,"freestandintv2_prop":836,"freestandintv3_prop":921,"freemounttv_prop":988,"cubansbigthetv1_prop":940,"cubansbigthetv2_prop":402,"nikadematv_prop":781,"slantdesktop1_prop":740,"slantdesktop2_prop":833,"sonytvv1_prop":559,"sonytvv2_prop":560,"standmac_prop":647,"ultrabigtv_prop":758,"standingmac_prop":667,"pollytv_prop":385,"monicamounttv_prop":716,"monicastandingtv_prop":332,"projectortvcubans1_prop":320,"projectortvcubans2_prop":803,"tripodprojector1_prop":517,"tripodprojector2_prop":398,"ceilingprojector1_prop":568,"ceilingprojector2_prop":779,"cubanscablebox_prop":433,"curadiator_prop":382,"cuthermostat_prop":684,"lgstandingac_prop":899,"lgwallacunit1_prop":566,"lgwallacunit2_prop":595,"simplemac_prop":497,"apdesktop_prop":303,"soundboard1_prop":461,"soundboard2_prop":650,"wiwallspeaker_prop":870,"tallspeaker_prop":445,"tabletandpen1_prop":887,"tabletandpen2_prop":604,"wiremote_prop":613,"prodisplayapone1_prop":870,"prodisplayapone2_prop":520,"prodisplayapone3_prop":864,"prodisplayapone4_prop":717,"prodisplayapone5_prop":453,"prodisplayapone6_prop":353,"prodisplayaptwo1_prop":812,"prodisplayaptwo2_prop":564,"prodisplayaptwo3_prop":796,"prodisplayaptwo4_prop":834,"prodisplayaptwo5_prop":771,"prodisplayaptwo6_prop":541,"mastersbath1_prop":847,"mastersbath2_prop":981,"mastersbath3_prop":308,"masterssink1_prop":556,"masterssink2_prop":330,"masterssink3_prop":811,"largewalkin1_prop":897,"largewalkin2_prop":500,"glasstub1_prop":682,"glasstub2_prop":608,"ultrasink1_prop":774,"ultrasink2_prop":552,"relaxingtub1_prop":735,"relaxingtub2_prop":923,"cushowerhead1_prop":617,"cushowerhead2_prop":512,"cushowerhead3_prop":892,"firetoilet1_prop":748,"firetoilet2_prop":948,"firetoilet3_prop":654,"shorttoilet1_prop":466,"shorttoilet2_prop":799,"shorttoilet3_prop":845,"opaltoilet1_prop":966,"opaltoilet2_prop":932,"cutredmill1_prop":892,"cutredmill2_prop":866,"cutredmill3_prop":921,"cutredmill4_prop":972,"cutredmill5_prop":748,"cutredmill6_prop":909,"custairmaster_prop":794,"zenfloorball1_prop":656,"zenfloorball2_prop":730,"cuyogamatset1_prop":847,"cuyogamatset2_prop":690,"cuyogamatset3_prop":978,"cuyogamatset4_prop":902,"cuweighttrain_prop":407,"cuyogaball1_prop":712,"cuyogaball2_prop":903,"cuyogaball3_prop":592,"cuyogaball4_prop":682,"cuyogaball5_prop":967,"cuyogaball6_prop":358,"lulubottle1_prop":136,"lulubottle2_prop":111,"lulubottle3_prop":173,"cubanspunch1_prop":959,"cubanspunch2_prop":438,"cubanspunch3_prop":977,"cubanspunch4_prop":326,"darbellswo_prop":590,"luluset1_prop":304,"luluset2_prop":931,"hikidsbed1_prop":467,"hikidsbed2_prop":937,"hikidsbed3_prop":674,"hikidsbed4_prop":335,"hikidsbed5_prop":663,"hikidsblanket1_prop":999,"hikidsblanket2_prop":304,"hikidsblanket3_prop":784,"babyone_prop":860,"babytwo_prop":544,"babythree_prop":610,"babyfour_prop":594,"cubabycarier1_prop":403,"cubabycarier2_prop":684,"cubabycarier3_prop":673,"cubabycarier4_prop":549,"cubabybag1_prop":928,"cubabybag2_prop":672,"cubabybag3_prop":369,"ninchangingtable1_prop":495,"ninchangingtable2_prop":487,"cunurbed1_prop":958,"cunurbed2_prop":820,"cunurbed3_prop":784,"cunurbed4_prop":416,"cunurbed5_prop":971,"lubabychange1_prop":589,"lubabychange2_prop":326,"lubabychange3_prop":660,"lubabychange4_prop":301,"lubabychange5_prop":705,"lubabychange6_prop":448,"cubabyholder1_prop":745,"cubabyholder2_prop":480,"cubabyholder3_prop":499,"cubabybed_prop":334,"rosebbycano1_prop":663,"rosebbycano2_prop":967,"rosebbycano3_prop":983,"rosebbycano4_prop":374,"rosebbybed1_prop":829,"rosebbybed2_prop":710,"rosebbybed3_prop":724,"rosebbybed4_prop":386,"babybottle1_prop":135,"babybottle2_prop":196,"diapersclut1_prop":360,"diapersclut2_prop":672,"jacuzipollbl1_prop":463,"jacuzipollbl2_prop":359,"outdoorumb1_prop":431,"outdoorumb2_prop":641,"outdoorumb3_prop":898,"outdoorumb4_prop":514,"woodwallpanel1_prop":934,"woodwallpanel2_prop":630,"woodwallpanel3_prop":920,"floorwallcut1_prop":356,"floorwallcut2_prop":828,"floorwallcut3_prop":817,"cubansrpan1_prop":365,"cubansrpan2_prop":411,"cubansrpan3_prop":911,"cubansrpan4_prop":380,"cubanwallpaper000_prop":754,"cubanwallpaper001_prop":760,"cubanwallpaper002_prop":419,"cubanwallpaper003_prop":393,"cubanwallpaper004_prop":537,"cubanwallpaper005_prop":709,"cubanwallpaper006_prop":766,"cubanwallpaper007_prop":477,"cubanwallpaper008_prop":965,"cubanwallpaper009_prop":415,"cubanwallpaper010_prop":376,"cubanwallpaper011_prop":413,"cubanwallpaper012_prop":392,"cubanwallpaper013_prop":589,"cubanwallpaper014_prop":423,"cubanwallpaper1_prop":496,"cubanwallpaper2_prop":520,"cubanwallpaper3_prop":679,"cubanwallpaper4_prop":526,"cubanwallpaper5_prop":663,"cubanwallpaper6_prop":958,"cubanwallpaper7_prop":896,"cubanwallpaper8_prop":942,"cubanwallpaper9_prop":371,"cubanwallpaper10_prop":994,"cubanwallpaper11_prop":883,"cubanwallpaper12_prop":662,"cubanwallpaper13_prop":378,"cubanwallpaper14_prop":777,"cubanwallpaper15_prop":686,"cubanwallpaper16_prop":310,"cubanwallpaper17_prop":302,"cubanwallpaper18_prop":440,"cubanwallpaper19_prop":486,"cubanwallpaper20_prop":718,"cubanwallpaper21_prop":685,"cubanwallpaper22_prop":522,"cubanwallpaper23_prop":817,"cubanwallpaper24_prop":302,"cubanwallpaper25_prop":334,"cubanwallpaper26_prop":382,"cubanwallpaper27_prop":837,"cubanwallpaper28_prop":407,"cubanwallpaper29_prop":870,"cubanwallpaper30_prop":725,"cubanwallpaper31_prop":716,"cubanwallpaper32_prop":399,"cubanwallpaper33_prop":477,"cubanwallpaper34_prop":972,"cubanwallpaper35_prop":601,"cubanwallpaper36_prop":457,"cubanwallpaper37_prop":439,"cubanwallpaper38_prop":878,"cubanwallpaper39_prop":884,"cubanwallpaper40_prop":493,"cubanwallpaper41_prop":396,"cubanwallpaper42_prop":944,"cubanwallpaper43_prop":925,"cubanwallpaper44_prop":543,"cubanwallpaper45_prop":853,"cubanwallpaper46_prop":931,"cubanwallpaper47_prop":826,"cubanwallpaper48_prop":961,"cubanwallpaper49_prop":501,"cubanwallpaper50_prop":603,"cubanwallpaper51_prop":960,"cubanwallpaper52_prop":379,"cubanwallpaper53_prop":386,"cubanwallpaper54_prop":789,"cubanwallpaper55_prop":332,"cubanwallpaper56_prop":846,"cubanwallpaper57_prop":772,"cubanwallpaper58_prop":699,"cubanwallpaper59_prop":654,"cubanwallpaper60_prop":419,"cubanwallpaper61_prop":783,"cubanwallpaper62_prop":798,"cubanwallpaper63_prop":390,"cubanwallpaper64_prop":366,"cubanwallpaper65_prop":482,"cubanwallpaper66_prop":546,"cubanwallpaper67_prop":995,"cubanwallpaper68_prop":927,"cubanwallpaper69_prop":820,"cubanwallpaper70_prop":616,"cubanwallpaper71_prop":968,"cubanwallpaper72_prop":499,"cubanwallpaper73_prop":775,"cubanwallpaper74_prop":907,"cubanwallpaper75_prop":609,"cubanwallpaper76_prop":487,"cubanwallpaper77_prop":675,"cubanwallpaper78_prop":483,"cubanwallpaper79_prop":321,"cubanwallpaper80_prop":325,"cubanwallpaper81_prop":815,"cubanwallpaper82_prop":867,"cubanwallpaper83_prop":880,"cubanwallpaper84_prop":360,"cubanwallpaper85_prop":775,"cubanwallpaper86_prop":550,"cubanwallpaper87_prop":725,"cubanwallpaper88_prop":990,"cubanwallpaper89_prop":513,"cubanwallpaper90_prop":596,"cubanwallpaper91_prop":571,"cubanwallpaper92_prop":647,"cubanwallpaper93_prop":973,"cubanwallpaper94_prop":523,"cubanwallpaper95_prop":997,"cubanwallpaper96_prop":446,"cubanwallpaper97_prop":739,"cubanwallpaper98_prop":535,"cubanwallpaper99_prop":624,"cubanwallpaper100_prop":900,"cubanwallpaper101_prop":562,"cubanwallpaper102_prop":524,"cubanwallpaper103_prop":507,"cubanwallpaper104_prop":791,"cubanwallpaper105_prop":517,"cubanwallpaper106_prop":868,"cubanwallpaper107_prop":610,"cubanwallpaper108_prop":307,"cubanwallpaper109_prop":732,"cubanwallpaper110_prop":526,"cubanwallpaper111_prop":890,"cubanwallpaper112_prop":581,"cubanwallpaper113_prop":591,"cubanwallpaper114_prop":540,"cubanwallpaper115_prop":802,"cubanwallpaper116_prop":705,"cubanwallpaper117_prop":715,"cubanwallpaper118_prop":945,"cubanwallpaper119_prop":503,"cubanwallpaper120_prop":448,"cubanwallpaper121_prop":684,"cubanwallpaper122_prop":779,"cubanwallpaper123_prop":640,"cubanwallpaper124_prop":313,"cubanwallpaper125_prop":790,"cubanwallpaper126_prop":343,"cubanwallpaper127_prop":480,"cubanwallpaper128_prop":867,"cubanwallpaper129_prop":446,"cubanwallpaper130_prop":304,"cubanwallpaper131_prop":407,"cubanwallpaper132_prop":950,"cubanwallpaper133_prop":742,"cubanwallpaper134_prop":994,"cubanwallpaper135_prop":322,"cubanwallpaper136_prop":380,"cubanwallpaper137_prop":882,"cubanwallpaper138_prop":460,"cubanwallpaper139_prop":412,"cubanwallpaper140_prop":720,"cubanwallpaper141_prop":464,"cubanwallpaper142_prop":691,"cubanwallpaper143_prop":988,"cubanwallpaper144_prop":634,"cubanwallpaper145_prop":639,"cubanwallpaper146_prop":371,"cubanwallpaper147_prop":772,"cubanwallpaper148_prop":472,"cubanwallpaper149_prop":711,"cubanwallpaper150_prop":786,"cubanwallpaper151_prop":760,"cubanwallpaper152_prop":657,"cubanwallpaper153_prop":821,"cubanwallpaper154_prop":807,"cubanwallpaper155_prop":852,"cubanwallpaper156_prop":515,"cubanwallpaper157_prop":881,"cubanwallpaper158_prop":685,"cubanwallpaper159_prop":948,"cubanwallpaper160_prop":411,"cubanwallpaper161_prop":810,"cubanwallpaper162_prop":602,"cubanwallpaper163_prop":921,"cubanwallpaper164_prop":708,"cubanwallpaper165_prop":882,"cubanwallpaper166_prop":833,"cubanwallpaper167_prop":681,"cubanwallpaper168_prop":526,"cubanwallpaper169_prop":672,"cubanwallpaper170_prop":489,"cubanwallpaper171_prop":758,"cubanwallpaper172_prop":382,"cubanwallpaper173_prop":478,"cubanwallpaper174_prop":501,"cubanwallpaper175_prop":466,"cubanwallpaper176_prop":383,"cubanwallpaper177_prop":795,"cubanwallpaper178_prop":307,"cubanwallpaper179_prop":960,"cubanwallpaper180_prop":920,"cubanwallpaper181_prop":321,"cubanwallpaper182_prop":738,"cubanwallpaper183_prop":676,"cubanwallpaper184_prop":438,"cubanwallpaper185_prop":587,"cubanwallpaper186_prop":837,"cubanwallpaper188_prop":870,"cubanwallpaper189_prop":783,"cubanwallpaper190_prop":970,"cubanwallpaper191_prop":734,"cubanwallpaper192_prop":694,"cubanwallpaper193_prop":775,"cubanwallpaper194_prop":989,"cubanwallpaper195_prop":580,"cubanwallpaper196_prop":624,"cubanwallpaper197_prop":681,"cubanwallpaper198_prop":308,"cubanwallpaper199_prop":616,"cubanwallpaper200_prop":983,"cubanwallpaper201_prop":747,"cubanwallpaper202_prop":873,"cubanwallpaper203_prop":572,"cubanwallpaper204_prop":623,"cubanwallpaper205_prop":744,"cubanwallpaper206_prop":955,"cubanwallpaper207_prop":959,"cubanwallpaper208_prop":825,"cubanwallpaper209_prop":893,"cubanwallpaper210_prop":703,"cubanwallpaper211_prop":908,"cubanwallpaper212_prop":616,"cubanwallpaper213_prop":584,"cubanwallpaper214_prop":966,"cubanwallpaper215_prop":474,"cubanwallpaper216_prop":867,"cubanwallpaper217_prop":663,"cubanwallpaper218_prop":956,"cubanwallpaper219_prop":975,"cubanwallpaper220_prop":838,"cubanwallpaper221_prop":628,"cubanwallpaper222_prop":385,"cubanwallpaper223_prop":378,"cubanwallpaper224_prop":952,"cubanwallpaper225_prop":805,"cubanwallpaper226_prop":916,"cubansflooring1_prop":965,"cubansflooring2_prop":588,"cubansflooring3_prop":365,"cubansflooring4_prop":484,"cubansflooring5_prop":306,"cubansflooring6_prop":420,"cubansflooring7_prop":711,"cubansflooring8_prop":389,"cubansflooring9_prop":316,"cubansflooring10_prop":907,"cubansflooring11_prop":870,"cubansflooring12_prop":659,"cubansflooring13_prop":398,"cubansflooring14_prop":544,"cubansflooring15_prop":557,"cubansflooring16_prop":400,"cubansflooring17_prop":564,"cubansflooring18_prop":496,"cubansflooring19_prop":867,"cubansflooring20_prop":574,"cudurango_prop":689,"bmwforgarage_prop":816,"audiforgarage_prop":572,"rtforgarage_prop":396};
let FURNITURE_UI_OPEN = false;

const STATEFURNITURE = {
   mode: "krapea",
   lastNonCartMode: "shop",
   shopDisabled: false,
   viewAllEnabled: false,

   favorites: new Set(),
   query: "",
   sort: "name",
   filter: "all",


   incarts: [],
   houses: [],
   selectedHouseId: null,
   selectedPlacement: null,


   categories: [{
         key: "all",
         icon: "fa-layer-group",
         name: "View All",
         subs: []
      },

   ],


   presets: [{
         id: "default",
         name: "Default",
         items: [{
               id: 12,
               code: "apa_mp_h_stn_sofa2seat_02",
               name: "Two-Seat Sofa 02",
               img: "img/furnitures/apa_mp_h_stn_sofa2seat_02.webp",
               placed: false
            },
            {
               id: 25,
               code: "prop_couch_lg_02",
               name: "Large Fabric Couch",
               img: "img/furnitures/prop_couch_lg_02.webp",
               placed: true
            },
            {
               id: 31,
               code: "prop_tv_flat_02b",
               name: "Flat TV 02B",
               img: "img/furnitures/prop_tv_flat_02b.webp",
               placed: false
            },
         ]
      },
      {
         id: "p-main",
         name: "Main Home",
         items: [{
               id: 44,
               code: "prop_table_03",
               name: "Glass Coffee Table",
               img: "img/furnitures/prop_table_03.webp",
               placed: true
            },
            {
               id: 47,
               code: "apa_mp_h_din_table_06",
               name: "Wood Dining Table",
               img: "img/furnitures/apa_mp_h_din_table_06.webp",
               placed: true
            },
            {
               id: 58,
               code: "xm_prop_x17_tv_ceiling_01",
               name: "Ceiling-Mounted TV",
               img: "img/furnitures/xm_prop_x17_tv_ceiling_01.webp",
               placed: false
            },
            {
               id: 63,
               code: "prop_cs_tv_stand",
               name: "TV Stand Unit",
               img: "img/furnitures/prop_cs_tv_stand.webp",
               placed: true
            },
         ]
      }
   ],
   currentPresetId: "default",
   activePresetId: "default",
}


const $ui = {
   root: $('#furn-ui-root'),
   breadcrumb: $('#furn-breadcrumb'),
   modeSwitch: $('#furn-mode-switch'),
   search: $('#furn-search'),
   sort: $('#furn-sort'),
   filter: $('#furn-filter'),
   sections: $('#furn-sections'),
   categoryList: $('#furn-category-list'),
   toggleSidebar: $('#furn-toggle-sidebar'),

   presetBar: $('#furn-preset-bar'),
   presetSelect: $('#furn-preset-select'),
   presetNew: $('#furn-preset-new'),
   presetDelete: $('#furn-preset-delete'),
   presetSetActive: $('#furn-preset-set-active'),


   invModal: $('#furn-inventory-modal'),
   invTitle: $('#furn-inventory-title'),
   invBody: $('#furn-inventory-body'),
   invClose: $('#furn-inventory-close'),
   transferMini: $('#furn-transfer-mini'),
   transferPanel: $('#furn-transfer-panel'),
   transferTarget: $('#furn-transfer-target'),
   btnTransfer: $('#furn-transfer-confirm'),
   btnEdit: $('#furn-edit-item'),
   btnPlace: $('#furn-place-item'),
   btnRemove: $('#furn-remove-item'),


   buyModal: $('#furn-buy-modal'),
   buyTitle: $('#furn-buy-title'),
   buyBody: $('#furn-buy-body'),
   buyClose: $('#furn-buy-close'),
   buyCancel: $('#furn-buy-cancel'),
   buyConfirm: $('#furn-buy-confirm'),
   buyConfirmLabel: $('#furn-buy-confirm-label'),


   cartFooter: $('#furn-cart-footer'),
   cartTotal: $('#furn-cart-total'),
   cartPurchase: $('#furn-cart-purchase'),
   cartClear: $('#furn-cart-clear'),
   cartDestModal: $('#furn-cart-dest-modal'),
   cartDestClose: $('#furn-cart-dest-close'),
   cartDestCancel: $('#furn-cart-dest-cancel'),
   cartDestConfirm: $('#furn-cart-dest-confirm'),
   cartDestSummary: $('#furn-cart-dest-summary'),
   cartHouse: $('#furn-cart-house'),
   cartPlacementGroup: $('#furn-cart-placement-group'),
   cartPlacementInside: $('#furn-cart-placement-inside'),
   cartPlacementOutside: $('#furn-cart-placement-outside'),
   cartPlacementField: $('#furn-cart-placement-field'),
   cartPlacementSelect: $('#furn-cart-placement-select'),

   cartDestHint: $('#furn-cart-dest-hint'),

   presetModal: $('#furn-preset-modal'),
   presetName: $('#furn-preset-name'),
   presetCancel: $('#furn-preset-cancel'),
   presetCreate: $('#furn-preset-create'),
   presetClose: $('#furn-preset-close'),


   confirmModal: $('#furn-confirm-modal'),
   confirmTitle: $('#furn-confirm-title'),
   confirmText: $('#furn-confirm-text'),
   confirmCancel: $('#furn-confirm-cancel'),
   confirmOk: $('#furn-confirm-ok'),
   confirmClose: $('#furn-confirm-close'),
};

let CUR_CAT = null;
let modalCtx = null;
let confirmResolve = null;
let shopCtx = null;


var housingresourcename = "rtx_housing";

const moneyfurniture = n => "$" + Number(n).toLocaleString();


function sendNui(action, data) {
   try {
      if (!housingResourceName) {
         return;
      }
      const endpoint = "https://" + housingResourceName + "/" + action;
      const payload = JSON.stringify(data || {});


      $.post(endpoint, payload);
   } catch (e) {}
}


function buildCategoriesFromConfig(furnConfig) {
   const categories = [];
   const allItems = [];
   const includeViewAll = !!STATEFURNITURE.viewAllEnabled;

   if (!furnConfig) return categories;


   const catEntries = Object.entries(furnConfig).map(([key, def]) => ({
      key,
      def
   }));
   catEntries.sort((a, b) => {
      const idA = (typeof a.def.id === 'number') ? a.def.id : 9999;
      const idB = (typeof b.def.id === 'number') ? b.def.id : 9999;
      if (idA !== idB) return idA - idB;

      const nameA = (a.def.label || a.key || "").toString();
      const nameB = (b.def.label || b.key || "").toString();
      return nameA.localeCompare(nameB);
   });

   catEntries.forEach(({
      key: catKey,
      def: catDef
   }) => {
      const cat = {
         key: catKey,
         icon: (catDef.icon || "fa-couch").replace(/^fa[sbrl]\s+/, ""),
         name: catDef.label || catKey,
         subs: [],
      };

      const subs = catDef.subcategory || {};


      const subEntries = Object.entries(subs).map(([subKey, subDef]) => ({
         subKey,
         subDef
      }));
      subEntries.sort((a, b) => {
         const nameA = (a.subDef.label || a.subKey || "").toString();
         const nameB = (b.subDef.label || b.subKey || "").toString();
         return nameA.localeCompare(nameB);
      });

      subEntries.forEach(({
         subKey,
         subDef
      }) => {
         const sub = {
            key: subKey,
            name: subDef.label || subKey,
            items: [],
         };


         const objects = (subDef.objects || []).slice().sort((a, b) => {
            const nameA = (a.label || a.object || "").toString();
            const nameB = (b.label || b.object || "").toString();
            return nameA.localeCompare(nameB);
         });

         objects.forEach((obj) => {

            const imgPath = obj.img || `img/furnitures/${obj.object}.webp`;

            const item = {
               id: obj.object,
               object: obj.object,
               code: obj.object,
               name: obj.label || obj.object,
               price: (obj.price && obj.price > 0) ? Number(obj.price) : (RTX_FURNITURE_PRICE_MAP[obj.object] || 0),
               img: furnImagePath(obj),
               interactable: !!obj.interactable,
               interaction: obj.interactabletext || "",
            };
            sub.items.push(item);
            allItems.push(item);
         });

         cat.subs.push(sub);
      });

      categories.push(cat);
   });


   if (includeViewAll && allItems.length) {
      categories.unshift({
         key: "all",
         icon: "fa-layer-group",
         name: "View All",
         subs: [{
            key: "allitems",
            name: "All items",
            items: allItems,
         }],
      });
   }

   return categories;
}


function buildPresetsFromLua(luaPresets) {
   const presets = (luaPresets || []).map(p => ({
      id: p.id || p.presetId,
      name: p.label || p.name || p.id || p.presetId,
      items: (p.items || []).map(it => ({
         id: it.id,
         code: it.object || it.code,
         name: it.label || it.name || (it.object || ""),
         img: it.img || `img/furnitures/${(it.object || it.code || "").toString()}.webp`,
         placed: !!it.placed,
      })),
   }));
   return presets;
}


function setBreadcrumb(cat) {
   if (STATEFURNITURE.mode === 'inventory') {
      $ui.breadcrumb.html('<b>My Furniture</b>');
      return;
   }
   if (STATEFURNITURE.mode === 'cart') {
      $ui.breadcrumb.html('<b>Cart</b>');
      return;
   }
   $ui.breadcrumb.html(cat ? `<b>${cat.name}</b>` : 'Select a category');
}


function setSortOptions() {
   $ui.sort.empty();
   if (STATEFURNITURE.mode === "inventory") {
      $('<option>', {
         text: "Sort: Name",
         value: "name",
         selected: STATEFURNITURE.sort === "name"
      }).appendTo($ui.sort);
      $('<option>', {
         text: "Sort: ID",
         value: "id",
         selected: STATEFURNITURE.sort === "id"
      }).appendTo($ui.sort);
   } else if (STATEFURNITURE.mode === "cart") {
      $('<option>', {
         text: "Sort: Name",
         value: "name",
         selected: STATEFURNITURE.sort === "name"
      }).appendTo($ui.sort);
      $('<option>', {
         text: "Sort: Price",
         value: "price",
         selected: STATEFURNITURE.sort === "price"
      }).appendTo($ui.sort);
   } else {
      $('<option>', {
         text: "Sort: Name",
         value: "name",
         selected: STATEFURNITURE.sort === "name"
      }).appendTo($ui.sort);
      $('<option>', {
         text: "Sort: Price",
         value: "price",
         selected: STATEFURNITURE.sort === "price"
      }).appendTo($ui.sort);
   }
}

const bySortShop = (a, b) => STATEFURNITURE.sort === "price" ?
   (a.price ?? 0) - (b.price ?? 0) :
   a.name.localeCompare(b.name);


function renderCategories() {
   $ui.categoryList.empty();
   STATEFURNITURE.categories.forEach((c, i) => {
      const isActive = (!CUR_CAT && i === 0) || (CUR_CAT === c.key);
      const $item = $('<div>', {
         'class': 'furn-category-item' + (isActive ? ' furn-is-active' : ''),
         'data-key': c.key,
         html: `<i class="fa-solid ${c.icon}"></i><span>${c.name}</span>`
      });
      $item.on('click', () => selectCategory(c.key));
      $ui.categoryList.append($item);
   });
}

function renderFilterOptions(cat) {
   $ui.filter.empty();
   $('<option>', {
      text: 'All',
      value: 'all',
      selected: STATEFURNITURE.filter === 'all'
   }).appendTo($ui.filter);
   $('<option>', {
      text: 'Favorites',
      value: 'fav',
      selected: STATEFURNITURE.filter === 'fav'
   }).appendTo($ui.filter);
   cat.subs.forEach(sub => {
      $('<option>', {
         text: sub.name,
         value: sub.key,
         selected: STATEFURNITURE.filter === sub.key
      }).appendTo($ui.filter);
   });
}


const SHOP_BATCH_SIZE = 32;

function appendItemTile($grid, it) {
   const isFav = STATEFURNITURE.favorites.has(it.id);
   const $tile = $(`
    <div class="furn-item-tile">
      <img class="furn-item-thumb" src="${furnImagePath(it)}"
           alt="${it.name}"
           onerror="this.onerror=null;this.src='${ICON}'">
      <div class="furn-favorite-badge ${isFav ? '' : 'furn-is-off'}" data-furn-fav="${it.id}">
        <i class="fa-solid fa-star"></i>
      </div>
      <div class="furn-item-price">${moneyfurniture(furnPrice(it))}</div>
      <div class="furn-item-caption">${it.name}</div>
    </div>
  `);


   $tile.on('click', function (e) {
      const $favBtn = $(e.target).closest('[data-furn-fav]');
      if ($favBtn.length) {
         e.stopPropagation();
         const id = $favBtn.data('furn-fav');
         if (STATEFURNITURE.favorites.has(id)) {
            STATEFURNITURE.favorites.delete(id);
         } else {
            STATEFURNITURE.favorites.add(id);
         }
         $favBtn.toggleClass('furn-is-off', !STATEFURNITURE.favorites.has(id));
         return;
      }
      onPreview(it);
   });


   $tile.on('mouseenter', function () {

      if (STATEFURNITURE.mode === 'krapea' || STATEFURNITURE.mode === 'shop') {

         const objectName = it.object || it.model || it.prop || it.name;
         if (objectName) {
            sendNui("furniture_hover_preview", {
               object: objectName,
               id: it.id
            });
         }
      }
   });


   $tile.on('mouseleave', function () {
      if (STATEFURNITURE.mode === 'krapea' || STATEFURNITURE.mode === 'shop') {
         sendNui("furniture_hover_preview_clear", {
            id: it.id
         });
      }
   });

   $grid.append($tile);
}

function renderSectionChunk($section) {
   const items = $section.data('items');
   if (!items) return;
   let index = $section.data('renderIndex') || 0;
   if (index >= items.length) return;

   const $grid = $section.find('.furn-item-grid');
   const end = Math.min(index + SHOP_BATCH_SIZE, items.length);
   for (let i = index; i < end; i++) {
      appendItemTile($grid, items[i]);
   }
   $section.data('renderIndex', end);
}

function handleSectionsScrollLazy() {
   const viewportTop = $ui.sections.scrollTop();
   const viewportBottom = viewportTop + $ui.sections.innerHeight();
   const thresholdBottom = viewportBottom + 200;

   $ui.sections.children('.furn-section').each(function () {
      const $section = $(this);
      const items = $section.data('items');
      if (!items) return;
      const rendered = $section.data('renderIndex') || 0;
      if (rendered >= items.length) return;

      const offsetTop = $section.position().top;
      const height = $section.outerHeight();
      const sectionBottom = offsetTop + height;

      if (sectionBottom < thresholdBottom) {
         renderSectionChunk($section);
      }
   });
}

let CART_PENDING_TOTAL = 0;

function renderCartDestinationModal() {
   const houses = STATEFURNITURE.houses || [];
   const hasHouses = houses.length > 0;


   if (!hasHouses) {
      $ui.cartHouse.empty().append(
         $('<option>', {
            value: "",
            text: "You don't own any property"
         })
      );
      $ui.cartHouse.prop('disabled', true);
      $ui.cartPlacementGroup.hide();
      $ui.cartDestHint.text("You need to own a property before you can assign furniture.");
      $ui.cartDestConfirm.prop('disabled', true);
      $ui.cartDestSummary.text('');
      return;
   }


   $ui.cartHouse.empty();
   houses.forEach(h => {
      const label = `${h.label || ('House '+h.id)} — ${h.adress || 'No address'}`;
      $('<option>', {
         value: String(h.id),
         text: label
      }).appendTo($ui.cartHouse);
   });

   if (!STATEFURNITURE.selectedHouseId) {
      STATEFURNITURE.selectedHouseId = String(houses[0].id);
   }
   $ui.cartHouse.val(String(STATEFURNITURE.selectedHouseId));

   const current = houses.find(h => String(h.id) === String(STATEFURNITURE.selectedHouseId));
   if (!current) {
      $ui.cartPlacementGroup.hide();
      $ui.cartDestHint.text('');
      $ui.cartDestConfirm.prop('disabled', true);
      return;
   }

   let placement = STATEFURNITURE.selectedPlacement || null;


   if (current.ismlo) {
      $ui.cartPlacementGroup.hide();
      placement = null;
      STATEFURNITURE.selectedPlacement = placement;

      $ui.cartDestHint.text("MLO property – furniture will be delivered to this property.");
      $ui.cartDestConfirm.prop('disabled', false);

   } else {
      const canInside = !!current.inside;
      const canOutside = !!current.outside;

      const any = canInside || canOutside;
      const both = canInside && canOutside;


      if (!any) {
         $ui.cartPlacementGroup.hide();
         STATEFURNITURE.selectedPlacement = null;
         $ui.cartDestHint.text("This property does not accept furniture categories.");
         $ui.cartDestConfirm.prop('disabled', true);
         updateCartSummary();
         return;
      }


      if (both) {

         if (placement !== 'inside' && placement !== 'outside') {
            placement = 'inside';
         }
         $ui.cartPlacementGroup.show();
         $ui.cartPlacementInside
            .toggleClass('furn-is-active', placement === 'inside')
            .show();
         $ui.cartPlacementOutside
            .toggleClass('furn-is-active', placement === 'outside')
            .show();
      } else if (canInside && !canOutside) {

         placement = 'inside';
         $ui.cartPlacementGroup.hide();
      } else if (!canInside && canOutside) {

         placement = 'outside';
         $ui.cartPlacementGroup.hide();
      }


      STATEFURNITURE.selectedPlacement = placement;


      if (placement === 'inside') {
         $ui.cartDestHint.text("Furniture will be added to the interior (inside) of this property.");
         $ui.cartDestConfirm.prop('disabled', false);
      } else if (placement === 'outside') {
         $ui.cartDestHint.text("Furniture will be added to the outside of this property.");
         $ui.cartDestConfirm.prop('disabled', false);
      } else {

         $ui.cartDestHint.text("Select where to place furniture in this property.");
         $ui.cartDestConfirm.prop('disabled', true);
      }
   }

   updateCartSummary();
}

function updateCartSummary() {
   const count = STATEFURNITURE.incarts.length;
   const totalLabel = moneyfurniture(CART_PENDING_TOTAL || 0);
   $ui.cartDestSummary.text(`${count} item(s) – Total: ${totalLabel}`);
}


function openCartDestinationModal(total) {
   CART_PENDING_TOTAL = total || 0;
   $ui.cartDestModal.addClass('furn-is-open');
   renderCartDestinationModal();
}

function closeCartDestinationModal() {
   $ui.cartDestModal.removeClass('furn-is-open');
}

$ui.cartDestClose.on('click', closeCartDestinationModal);
$ui.cartDestCancel.on('click', closeCartDestinationModal);

$ui.cartHouse.on('change', function () {
   const val = $(this).val();
   STATEFURNITURE.selectedHouseId = val || null;

   STATEFURNITURE.selectedPlacement = null;

   renderCartDestinationModal();
});


$ui.cartPlacementInside.on('click', function () {
   STATEFURNITURE.selectedPlacement = 'inside';
   renderCartDestinationModal();
});
$ui.cartPlacementOutside.on('click', function () {
   STATEFURNITURE.selectedPlacement = 'outside';
   renderCartDestinationModal();
});


function renderContent(cat) {
   setBreadcrumb(cat);
   renderFilterOptions(cat);
   $ui.sections.empty();

   const q = STATEFURNITURE.query.toLowerCase();
   const onlyFav = STATEFURNITURE.filter === 'fav';
   const showSub = sub => STATEFURNITURE.filter === 'all' || STATEFURNITURE.filter === sub.key || onlyFav;

   cat.subs.forEach(sub => {
      if (!showSub(sub)) return;

      let items = sub.items
         .filter(i => !onlyFav || STATEFURNITURE.favorites.has(i.id))
         .filter(i => !q || i.name.toLowerCase().includes(q))
         .slice()
         .sort(bySortShop);

      if (!items.length) return;

      items = items.map(i => ({
         ...i,
         categoryKey: cat.key,
         subcategoryKey: sub.key,
      }));

      const $section = $(`
      <div class="furn-section">
        <div class="furn-section-header">
          <div class="furn-section-title">
            <span>${sub.name}</span>
            <span class="furn-section-count">${items.length}</span>
          </div>
          <button class="furn-collapse-button" title="Collapse">
            <i class="fa-solid fa-chevron-up"></i>
          </button>
        </div>
        <div class="furn-item-grid"></div>
      </div>
    `);

      $section.data('items', items);
      $section.data('renderIndex', 0);

      const $grid = $section.find('.furn-item-grid');
      renderSectionChunk($section);

      $section.find('.furn-collapse-button').on('click', function () {
         const $btn = $(this);
         const opened = $grid.css('display') !== 'none';
         $grid.css('display', opened ? 'none' : 'grid');
         $btn.html(`<i class="fa-solid fa-chevron-${opened ? 'down' : 'up'}"></i>`);
      });

      $ui.sections.append($section);
   });

   if ($ui.sections.children().length === 0) {
      $ui.sections.html('<div style="opacity:.75; padding:8px;">No items match your filters.</div>');
   }


   $ui.sections.off('scroll.lazy').on('scroll.lazy', handleSectionsScrollLazy);
}

function selectCategory(key) {
   if (key === CUR_CAT) {} else {
      STATEFURNITURE.filter = "all";
   }
   CUR_CAT = key;
   $ui.categoryList.children().each(function () {
      const $item = $(this);
      $item.toggleClass('furn-is-active', $item.data('key') === key);
   });
   const cat = STATEFURNITURE.categories.find(c => c.key === key);
   if (!cat) return;
   renderContent(cat);
}


function getCurrentPreset() {
   return STATEFURNITURE.presets.find(p => p.id === STATEFURNITURE.currentPresetId) || STATEFURNITURE.presets[0];
}

function renderPresetsBar() {
   if (!$ui.presetSelect.length) return;

   $ui.presetSelect.empty();
   STATEFURNITURE.presets.forEach(p => {
      const text = (p.id === STATEFURNITURE.activePresetId) ?
         `${p.name} (Active)` :
         p.name;

      $('<option>', {
         text,
         value: p.id,
         selected: p.id === STATEFURNITURE.currentPresetId
      }).appendTo($ui.presetSelect);
   });
   const current = getCurrentPreset();
   const cannotDelete = !current || current.id === 'default' || STATEFURNITURE.presets.length <= 1;
   $ui.presetDelete.prop('disabled', cannotDelete);

   if ($ui.presetSetActive && $ui.presetSetActive.length) {
      const canSet = !!current && current.id !== STATEFURNITURE.activePresetId;
      $ui.presetSetActive.prop('disabled', !canSet);
   }
}


function renderInventory() {
   $ui.breadcrumb.html('<b>My Furniture</b>');
   $ui.sections.empty();
   renderPresetsBar();

   const preset = getCurrentPreset();
   const q = STATEFURNITURE.query.toLowerCase();
   let items = (preset?.items || [])
      .filter(i => !q || i.name.toLowerCase().includes(q) || String(i.id).includes(q))
      .slice()
      .sort((a, b) => {
         if (STATEFURNITURE.sort === 'id') return Number(a.id) - Number(b.id);
         return a.name.localeCompare(b.name);
      });

   if (!items.length) {
      $ui.sections.html('<div style="opacity:.75; padding:8px;">This preset is empty.</div>');
      return;
   }

   const $section = $(`
    <div class="furn-section">
      <div class="furn-section-header">
        <div class="furn-section-title">
          <span>${preset.name}</span>
          <span class="furn-section-count">${items.length}</span>
        </div>
      </div>
      <div class="furn-item-grid"></div>
    </div>
  `);
   const $grid = $section.find('.furn-item-grid');

   items.forEach(item => {
      const $tile = $(`
      <div class="furn-item-tile">
        <img class="furn-item-thumb" src="${furnImagePath(item)}"
             alt="${item.name}"
             onerror="this.onerror=null;this.src='${ICON}'">
        ${item.placed ? '' : '<div class="furn-unplaced-badge"><i class="fa-solid fa-box-archive"></i></div>'}
        <div class="furn-id-badge">#${item.id}</div>
        <div class="furn-item-caption">${item.name}</div>
      </div>
    `);
      $tile.on('click', () => onPreview(item));
      $grid.append($tile);
   });

   $ui.sections.append($section);
}


function renderCartPage() {
   $ui.sections.empty();
   const q = STATEFURNITURE.query.toLowerCase();
   let items = STATEFURNITURE.incarts
      .filter(i => !q || i.name.toLowerCase().includes(q))
      .slice()
      .sort((a, b) => STATEFURNITURE.sort === 'price' ?
         (a.price || 0) - (b.price || 0) :
         a.name.localeCompare(b.name)
      );

   const $section = $(`
    <div class="furn-section">
      <div class="furn-section-header">
        <div class="furn-section-title">
          <span>Cart Items</span>
          <span class="furn-section-count">${items.length}</span>
        </div>
        ${items.length ? '<button class="furn-collapse-button" id="furn-cart-collapse"><i class="fa-solid fa-chevron-up"></i></button>' : ''}
      </div>
      <div class="furn-item-grid" id="furn-cart-grid"></div>
      ${!items.length ? '<div style="opacity:.75; padding:8px;">Your cart is empty.</div>' : ''}
    </div>
  `);
   $ui.sections.append($section);

   const $grid = $('#furn-cart-grid');
   items.forEach((it, idx) => {
      const $tile = $(`
      <div class="furn-item-tile" title="Click to remove from cart">
        <img class="furn-item-thumb" src="${furnImagePath(it)}"
             alt="${it.name}"
             onerror="this.onerror=null;this.src='${ICON}'">
        <div class="furn-item-price">${moneyfurniture(furnPrice(it))}</div>
        <div class="furn-item-caption">${it.name}</div>
      </div>
    `);
      $tile.on('click', () => {
         STATEFURNITURE.incarts.splice(idx, 1);
         sendNui("furniture_cart_update", {
            items: STATEFURNITURE.incarts
         });
         renderRoot();
      });
      $grid.append($tile);
   });

   const total = STATEFURNITURE.incarts.reduce((s, i) => s + (i.price || 0), 0);
   $ui.cartTotal.text(`Total: ${moneyfurniture(total)}`);
   $ui.cartFooter.show();
}


function updateModeUI() {
   const isInv = STATEFURNITURE.mode === "inventory";
   const isKrapea = STATEFURNITURE.mode === "krapea";
   const isCart = STATEFURNITURE.mode === "cart";

   $ui.root.toggleClass('furn-mode-cart', isCart);
   if (isCart) {
      $ui.cartFooter.show();
   } else {
      $ui.cartFooter.hide();
   }

   const $shopBtn = $ui.modeSwitch.find('.furn-mode-button-shop');
   const $invBtn = $ui.modeSwitch.find('.furn-mode-button-inventory');

   if (isKrapea) {
      $ui.modeSwitch.addClass('furn-is-hidden');
      $ui.root.removeClass('furn-mode-inventory').addClass('furn-mode-krapea');
   } else {
      $ui.root.removeClass('furn-mode-krapea');
      if (STATEFURNITURE.shopDisabled) {
         STATEFURNITURE.mode = "inventory";
         $ui.modeSwitch.addClass('furn-is-hidden');
      } else {
         $ui.modeSwitch.toggleClass('furn-is-hidden', isCart);
         $shopBtn.toggleClass('furn-is-active', !isInv && !isCart);
         $invBtn.toggleClass('furn-is-active', isInv);
      }
   }

   $ui.root.toggleClass('furn-mode-inventory', isInv);
   setSortOptions();
   if (isInv) renderPresetsBar();
}

function renderRoot() {
   updateModeUI();
   if (STATEFURNITURE.mode === "inventory") {
      renderInventory();
   } else if (STATEFURNITURE.mode === "cart") {
      setBreadcrumb();
      renderCartPage();
   } else {
      renderCategories();
      if (STATEFURNITURE.categories.length) {
         selectCategory(CUR_CAT || STATEFURNITURE.categories[0].key);
      } else {
         $ui.sections.html('<div style="opacity:.75; padding:8px;">No categories.</div>');
      }
      $ui.cartFooter.hide();
   }
}


function openConfirm({
   title = "Confirm",
   text = "Are you sure?",
   okLabel = "Delete"
}) {
   $ui.confirmTitle.text(title);
   $ui.confirmText.text(text);
   $ui.confirmOk.text(okLabel);
   $ui.confirmModal.addClass('furn-is-open');
   return new Promise(resolve => {
      confirmResolve = resolve;
   });
}

function closeConfirm(answer = false) {
   $ui.confirmModal.removeClass('furn-is-open');
   if (confirmResolve) {
      const r = confirmResolve;
      confirmResolve = null;
      r(answer);
   }
}
$ui.confirmCancel.on('click', () => closeConfirm(false));
$ui.confirmOk.on('click', () => closeConfirm(true));
$ui.confirmClose.on('click', () => closeConfirm(false));
$ui.confirmModal.on('click', e => {
   if (e.target === $ui.confirmModal[0]) closeConfirm(false);
});


function populateTransferTargets(excludeId) {
   $ui.transferTarget.empty();
   const list = STATEFURNITURE.presets.filter(p => p.id !== excludeId);
   list.forEach(p => {
      $('<option>', {
         text: p.name,
         value: p.id
      }).appendTo($ui.transferTarget);
   });
   $ui.btnTransfer.prop('disabled', list.length === 0);
}

function openInvModal(item) {
   const preset = getCurrentPreset();
   modalCtx = {
      item,
      presetId: preset?.id
   };
   $ui.invTitle.text(item.name);
   $ui.invBody.text(`ID: #${item.id} • Code: ${item.code}`);

   if (item.placed) {
      $ui.btnEdit.show();
      $ui.btnPlace.hide();
   } else {
      $ui.btnEdit.hide();
      $ui.btnPlace.show();
   }

   populateTransferTargets(modalCtx.presetId);
   $ui.transferPanel.removeClass('furn-is-open');
   $ui.invModal.addClass('furn-is-open');
}

function closeInvModal() {
   $ui.invModal.removeClass('furn-is-open');
   modalCtx = null;
}
$ui.invModal.on('click', e => {
   if (e.target === $ui.invModal[0]) closeInvModal();
});
$ui.invClose.on('click', closeInvModal);

$ui.transferMini.on('click', () => {
   $ui.transferPanel.toggleClass('furn-is-open');
});

$ui.btnEdit.on('click', () => {
   if (!modalCtx) return;
   sendNui("furniture_inv_edit", {
      presetId: modalCtx.presetId,
      itemId: modalCtx.item.id,
      object: modalCtx.item.code,
   });
   closeInvModal();
});
$ui.btnPlace.on('click', () => {
   if (!modalCtx) return;
   sendNui("furniture_inv_place", {
      presetId: modalCtx.presetId,
      itemId: modalCtx.item.id,
      object: modalCtx.item.code,
   });
   closeInvModal();
});
$ui.btnRemove.on('click', async () => {
   if (!modalCtx) return;
   const preset = STATEFURNITURE.presets.find(p => p.id === modalCtx.presetId);
   if (!preset) return;
   const yes = await openConfirm({
      title: "Remove item",
      text: `Remove "${modalCtx.item.name}" from preset "${preset.name}"?`,
      okLabel: "Remove"
   });
   if (!yes) return;
   preset.items = preset.items.filter(i => !(i.id === modalCtx.item.id && i.code === modalCtx.item.code));

   sendNui("furniture_inv_remove", {
      presetId: modalCtx.presetId,
      itemId: modalCtx.item.id,
      object: modalCtx.item.code,
   });

   closeInvModal();
   renderRoot();
});

$ui.btnTransfer.on('click', () => {
   if (!modalCtx) return;
   const targetId = $ui.transferTarget.val();
   const from = STATEFURNITURE.presets.find(p => p.id === modalCtx.presetId);
   const to = STATEFURNITURE.presets.find(p => p.id === targetId);
   if (!from || !to || !modalCtx.item) return;

   from.items = from.items.filter(i => !(i.id === modalCtx.item.id && i.code === modalCtx.item.code));
   to.items.push(modalCtx.item);

   sendNui("furniture_inv_transfer", {
      fromPresetId: from.id,
      toPresetId: to.id,
      itemId: modalCtx.item.id,
      object: modalCtx.item.code,
   });

   modalCtx.presetId = to.id;
   populateTransferTargets(modalCtx.presetId);
   renderRoot();
});


function openBuyModal(item) {
   shopCtx = {
      item
   };
   const isKrapea = STATEFURNITURE.mode === 'krapea';
   $ui.buyTitle.text(isKrapea ? 'Add to cart' : 'Purchase');
   $ui.buyConfirmLabel.text(isKrapea ? 'Add to cart' : 'Buy');

   const interact = item.interactable ? `
    <div class="furn-interaction">
      <div class="furn-label"><i class="fa-solid fa-bolt"></i>Interactable</div>
      ${item.interaction ? `<div class="furn-description">${item.interaction}</div>` : ``}
    </div>
  ` : ``;

   $ui.buyBody.html(isKrapea ?
      `Do you want to add <b>${item.name}</b> for <b>${moneyfurniture(furnPrice(item))}</b> to your cart?${interact}` :
      `Do you want to purchase <b>${item.name}</b> for <b>${moneyfurniture(furnPrice(item))}</b>?${interact}`
   );

   $ui.buyModal.addClass('furn-is-open');
}

function closeBuyModal() {
   $ui.buyModal.removeClass('furn-is-open');
   shopCtx = null;
}
$ui.buyClose.on('click', closeBuyModal);
$ui.buyCancel.on('click', closeBuyModal);
$ui.buyModal.on('click', e => {
   if (e.target === $ui.buyModal[0]) closeBuyModal();
});
$ui.buyConfirm.on('click', () => {
   if (!shopCtx) return;
   if (STATEFURNITURE.mode === 'krapea') {

      sendNui("furniture_add_to_cart", {
         object: shopCtx.item.id,
         name: shopCtx.item.name,
         price: shopCtx.item.price,
         categoryKey: shopCtx.item.categoryKey,
         subcategoryKey: shopCtx.item.subcategoryKey,
      });

   } else {
      sendNui("furniture_purchase", {
         object: shopCtx.item.id,
         name: shopCtx.item.name,
         price: shopCtx.item.price,
         categoryKey: shopCtx.item.categoryKey,
         subcategoryKey: shopCtx.item.subcategoryKey,
      });
   }
   closeBuyModal();
});

$ui.cartPurchase.on('click', () => {
   if (!STATEFURNITURE.incarts.length) return;

   const total = STATEFURNITURE.incarts.reduce((s, i) => s + (i.price || 0), 0);
   openCartDestinationModal(total);
});


$ui.cartClear.on('click', async () => {
   if (!STATEFURNITURE.incarts.length) return;
   const yes = await openConfirm({
      title: 'Clear cart',
      text: 'Remove all items from the cart?',
      okLabel: 'Clear'
   });
   if (!yes) return;
   STATEFURNITURE.incarts = [];

   sendNui("furniture_cart_clear", {});

   renderRoot();
});


function onPreview(item) {
   if (STATEFURNITURE.mode === "inventory") {
      openInvModal(item);
   } else {
      openBuyModal(item);
   }
}


$ui.modeSwitch.on('click', '.furn-mode-button', function () {
   if (STATEFURNITURE.shopDisabled) return;
   const mode = $(this).data('mode');
   if (mode && (mode === 'shop' || mode === 'inventory')) {
      STATEFURNITURE.lastNonCartMode = mode;
      STATEFURNITURE.mode = mode;
      renderRoot();
   }
});

$ui.search.on('input', function () {
   STATEFURNITURE.query = $(this).val() || '';
   renderRoot();
});
$ui.sort.on('change', function () {
   STATEFURNITURE.sort = $(this).val();
   renderRoot();
});
$ui.filter.on('change', function () {
   STATEFURNITURE.filter = $(this).val();
   renderRoot();
});
$ui.toggleSidebar.on('click', function () {
   $ui.root.toggleClass('furn-is-collapsed');
});


$ui.presetSelect.on('change', function () {
   STATEFURNITURE.currentPresetId = $(this).val();
   renderRoot();
});
$ui.presetNew.on('click', () => {
   $ui.presetName.val('');
   $ui.presetModal.addClass('furn-is-open');
   $ui.presetName.trigger('focus');
});
$ui.presetCreate.on('click', () => {
   const name = ($ui.presetName.val() || '').trim();
   if (!name) return;


   sendNui("furniture_preset_create", {
      name: name
   });

   $ui.presetModal.removeClass('furn-is-open');

});

$ui.presetDelete.on('click', async () => {
   const current = getCurrentPreset();
   if (!current || current.id === 'default') return;

   const yes = await openConfirm({
      title: "Delete preset",
      text: `Delete preset "${current.name}"?`,
      okLabel: "Delete"
   });
   if (!yes) return;


   sendNui("furniture_preset_delete", {
      presetId: current.id,
   });
});


if ($ui.presetSetActive && $ui.presetSetActive.length) {
   $ui.presetSetActive.on('click', async () => {
      const current = getCurrentPreset();
      if (!current) return;
      if (current.id === STATEFURNITURE.activePresetId) return;

      const yes = await openConfirm({
         title: "Set active preset",
         text: `Do you want to set preset "${current.name}" as active in your property?`,
         okLabel: "Set preset"
      });
      if (!yes) return;


      sendNui("furniture_set_active_preset", {
         presetId: current.id,
      });
   });
}

$ui.presetCancel.on('click', () => $ui.presetModal.removeClass('furn-is-open'));
$ui.presetClose.on('click', () => $ui.presetModal.removeClass('furn-is-open'));
$ui.presetModal.on('click', e => {
   if (e.target === $ui.presetModal[0]) $ui.presetModal.removeClass('furn-is-open');
});


$ui.cartDestConfirm.on('click', () => {
   const houses = STATEFURNITURE.houses || [];
   const houseId = STATEFURNITURE.selectedHouseId;
   const house = houses.find(h => String(h.id) === String(houseId));

   if (!house) {
      $ui.cartDestHint.text("Please select a property.");
      return;
   }
   if (!house.ismlo && !STATEFURNITURE.selectedPlacement) {
      $ui.cartDestHint.text("Please choose inside or outside for this property.");
      return;
   }

   const total = CART_PENDING_TOTAL || 0;

   sendNui("furniture_cart_purchase", {
      items: STATEFURNITURE.incarts,
      total: total,
      houseId: house.id,
      placement: house.ismlo ? null : STATEFURNITURE.selectedPlacement,
      houseLabel: house.label,
      houseAdress: house.adress,
      isMlo: !!house.ismlo,
   });

   STATEFURNITURE.incarts = [];
   closeCartDestinationModal();
   renderRoot();
});


$(function () {
   if (window.location.hash.toLowerCase() === '#krapea') STATEFURNITURE.mode = 'krapea';
   if (STATEFURNITURE.shopDisabled && STATEFURNITURE.mode !== 'krapea') STATEFURNITURE.mode = 'inventory';
   setSortOptions();
   renderRoot();
});

document.addEventListener("keydown", function (e) {
   if (e.key === "Escape") {
      if (!FURNITURE_UI_OPEN) return;


      closeAllModals();
      $("#furn-ui-main").hide();
      $('#furn-ui-root').hide();
      FURNITURE_UI_OPEN = false;


      sendNui("furniture_close", {
         mode: STATEFURNITURE.mode
      });
   }
});

const PlacementTransform = (() => {
  const $panel = $('#furn-transform-panel');

  const inputs = {
    pos: {
      x: $('#furn-pos-x'),
      y: $('#furn-pos-y'),
      z: $('#furn-pos-z')
    },
    rot: {
      x: $('#furn-rot-x'),
      y: $('#furn-rot-y'),
      z: $('#furn-rot-z')
    }
  };

  // tvoje UI
  const $copyPos  = $('#furn-copy-pos');
  const $pastePos = $('#furn-paste-pos');
  const $copyRot  = $('#furn-copy-rot');
  const $pasteRot = $('#furn-paste-rot');

  const $btnSnap  = $('#btn-snap');
  const $btnBring = $('#btn-freecam');

  const $btnCancel  = $('#btn-cancel');
  const $btnConfirm = $('#btn-confirm');

  let clipboard = { pos: null, rot: null };
  let ignore = false;

  // debounce timery pro pos/rot zvlášť
  let tPos = null;
  let tRot = null;

  function num(v) {
    const n = parseFloat(v);
    return Number.isFinite(n) ? n : 0;
  }

  function fmt(v) {
    const n = Number(v);
    return Number.isFinite(n) ? n.toFixed(3) : '0.000';
  }

  // === čtení aktuálních hodnot (safe) ===
  function snapshot() {
    return {
      position: {
        x: num(inputs.pos.x.val()),
        y: num(inputs.pos.y.val()),
        z: num(inputs.pos.z.val()),
      },
      rotation: {
        x: num(inputs.rot.x.val()),
        y: num(inputs.rot.y.val()),
        z: num(inputs.rot.z.val()),
      }
    };
  }

  function emitUpdate(source) {
    if (ignore) return;
    const data = snapshot();
    sendNui('placement_update_transform', {
      ...data,
      source
    });
  }

  // === debounce send (po dopsání) ===
  function scheduleEmit(kind, source, delay = 250) {
    if (ignore) return;

    if (kind === 'pos') {
      clearTimeout(tPos);
      tPos = setTimeout(() => emitUpdate(source), delay);
    } else {
      clearTimeout(tRot);
      tRot = setTimeout(() => emitUpdate(source), delay);
    }
  }

  function flushEmit(kind, source) {
    if (kind === 'pos') {
      clearTimeout(tPos); tPos = null;
    } else {
      clearTimeout(tRot); tRot = null;
    }
    emitUpdate(source);
  }

  function openPlacement() {
   $("#furn-transform-panel").show();
  }

  function closePlacement() {
    $("#furn-transform-panel").hide();
  }

  function updatePlacementPosition(x, y, z) {
    ignore = true;
    inputs.pos.x.val(fmt(x));
    inputs.pos.y.val(fmt(y));
    inputs.pos.z.val(fmt(z));
    ignore = false;
  }

  function updatePlacementRotation(x, y, z) {
    ignore = true;
    inputs.rot.x.val(fmt(x));
    inputs.rot.y.val(fmt(y));
    inputs.rot.z.val(fmt(z));
    ignore = false;
  }

  // === INPUTY: posílat až po dopsání, ale na blur/enter hned ===
  function bindInput($el, kind) {
    $el.on('input', function () {
      scheduleEmit(kind, 'manual_input');
    });

    $el.on('keydown', function (e) {
      if (e.key === 'Enter') {
        // zformátuj a pošli hned
        const v = num($(this).val());
        $(this).val(fmt(v));
        flushEmit(kind, 'manual_enter');
        $(this).blur();
      }
    });

    $el.on('blur', function () {
      // při opuštění pole zformátuj a pošli hned
      const v = num($(this).val());
      $(this).val(fmt(v));
      flushEmit(kind, 'manual_blur');
    });
  }

  bindInput(inputs.pos.x, 'pos');
  bindInput(inputs.pos.y, 'pos');
  bindInput(inputs.pos.z, 'pos');

  bindInput(inputs.rot.x, 'rot');
  bindInput(inputs.rot.y, 'rot');
  bindInput(inputs.rot.z, 'rot');

  // === +/- step tlačítka: okamžitě ===
  $('.furn-step-btn').on('click', function () {
    const type = $(this).data('type'); // pos/rot
    const axis = $(this).data('axis'); // x/y/z
    const dir  = $(this).data('dir');  // +/-

    const stepAttr = $(this).attr('data-step');
    const step = stepAttr ? parseFloat(stepAttr) : 0.01; // default

    const input = inputs[type][axis];
    let val = num(input.val());
    val += (dir === '+') ? step : -step;

    input.val(fmt(val));
    flushEmit(type, 'step_btn');
  });

  // === COPY / PASTE ===
  $copyPos.on('click', () => {
    clipboard.pos = {
      x: num(inputs.pos.x.val()),
      y: num(inputs.pos.y.val()),
      z: num(inputs.pos.z.val())
    };
    $pastePos.prop('disabled', false);
  });

  $pastePos.on('click', () => {
    if (!clipboard.pos) return;
    updatePlacementPosition(clipboard.pos.x, clipboard.pos.y, clipboard.pos.z);
    flushEmit('pos', 'paste_pos');
  });

  $copyRot.on('click', () => {
    clipboard.rot = {
      x: num(inputs.rot.x.val()),
      y: num(inputs.rot.y.val()),
      z: num(inputs.rot.z.val())
    };
    $pasteRot.prop('disabled', false);
  });

  $pasteRot.on('click', () => {
    if (!clipboard.rot) return;
    updatePlacementRotation(clipboard.rot.x, clipboard.rot.y, clipboard.rot.z);
    flushEmit('rot', 'paste_rot');
  });

  // === CONTROLS ===
  $btnBring.on('click', () => {
    sendNui('placement_bring_to_player');
  });

  $btnSnap.on('click', () => {
    sendNui('placement_snap_to_ground');
  });

  // === CONFIRM / CANCEL ===
  // (endpointy si případně přejmenuj podle Lua)
  $btnConfirm.on('click', () => {
    sendNui('placement_confirm');
    closePlacement();
  });

  $btnCancel.on('click', () => {
    sendNui('placement_cancel');
    closePlacement();
  });

  return {
    openPlacement,
    closePlacement,
    updatePlacementPosition,
    updatePlacementRotation
  };
})();

window.addEventListener("message", function (event) {
   const msg = event.data;
   if (!msg || !msg.message) return;

   if (msg.message === "FurnitureSetMeta") {
      STATEFURNITURE.shopDisabled = msg.shopDisabled;

      if (typeof msg.viewAll === 'boolean') {
         STATEFURNITURE.viewAllEnabled = msg.viewAll;
      }

      STATEFURNITURE.activePresetId = msg.activePresetId || STATEFURNITURE.activePresetId || STATEFURNITURE.currentPresetId;

      if (STATEFURNITURE.shopDisabled) {
         STATEFURNITURE.mode = "inventory";
      } else {
         const defaultMode = msg.defaultMode || STATEFURNITURE.mode;
         STATEFURNITURE.mode = defaultMode;
      }
      FURNITURE_UI_OPEN = true;
      $("#furn-ui-main").show();
      $('#furn-ui-root').show();
      renderRoot();
   }

   if (msg.message === "FurnitureEditMode") {
      FURNITURE_UI_OPEN = false;
   }


   if (msg.message === "FurnitureSetConfig") {
      STATEFURNITURE.categories = buildCategoriesFromConfig(msg.furnitures);
      CUR_CAT = null;
      $("#furn-ui-main").show();
      $('#furn-ui-root').show();
      STATEFURNITURE.filter = "all";
      renderRoot();
   }

   if (msg.message === "FurnitureAddCategory") {
      const cfg = {};
      cfg[msg.categoryKey] = msg.category;
      let newCats = buildCategoriesFromConfig(cfg).filter(c => c.key !== "all");

      if (msg.replaceExisting) {

         const allCat = STATEFURNITURE.categories.find(c => c.key === "all");
         STATEFURNITURE.categories = [];
         if (allCat) STATEFURNITURE.categories.push(allCat);
         STATEFURNITURE.categories = STATEFURNITURE.categories.concat(newCats);
      } else {
         const existingAll = STATEFURNITURE.categories.filter(c => c.key === "all");
         const others = STATEFURNITURE.categories.filter(c => c.key !== "all");
         const newKeys = newCats.map(c => c.key);
         const filteredOthers = others.filter(c => !newKeys.includes(c.key));
         STATEFURNITURE.categories = [...existingAll, ...filteredOthers, ...newCats];
      }
      $("#furn-ui-main").show();
      $('#furn-ui-root').show();
      renderRoot();
   }

   if (msg.message === "FurnitureResetCategories") {
      if (STATEFURNITURE.viewAllEnabled) {
         STATEFURNITURE.categories = [{
            key: "all",
            icon: "fa-layer-group",
            name: "View All",
            subs: []
         }];
      } else {
         STATEFURNITURE.categories = [];
      }
      CUR_CAT = null;
      renderRoot();
   }

   if (msg.message === "FurnitureResetPresets") {
      STATEFURNITURE.presets = [];
      STATEFURNITURE.currentPresetId = null;
      STATEFURNITURE.activePresetId = null;
      renderRoot();
   }

   if (msg.message === "FurnitureOpenShop") {
      if (msg.options && msg.options.furnitures) {
         STATEFURNITURE.categories = buildCategoriesFromConfig(msg.options.furnitures);
      }
      if (STATEFURNITURE.shopDisabled) {
         STATEFURNITURE.mode = "inventory";
      } else {
         STATEFURNITURE.mode = (msg.options && msg.options.mode) || "krapea";
      }
      FURNITURE_UI_OPEN = true;
      $("#furn-ui-main").show();
      $('#furn-ui-root').show();
      renderRoot();
   }

   if (msg.message === "FurnitureOpenInventory") {
      const opts = msg.options || {};
      const presets = buildPresetsFromLua(opts.presets || []);
      if (presets.length) {
         STATEFURNITURE.presets = presets;
         STATEFURNITURE.currentPresetId = opts.currentPresetId ||
            opts.activePresetId ||
            presets[0].id;
         STATEFURNITURE.activePresetId = opts.activePresetId || STATEFURNITURE.activePresetId || STATEFURNITURE.currentPresetId;
      }
      FURNITURE_UI_OPEN = true;
      $("#furn-ui-main").show();
      $('#furn-ui-root').show();
      STATEFURNITURE.mode = "inventory";
      renderRoot();
   }

   if (msg.message === "FurnitureLoadInventory") {
      const opts = msg.options || {};
      const presets = buildPresetsFromLua(opts.presets || []);
      if (presets.length) {
         STATEFURNITURE.presets = presets;
         STATEFURNITURE.currentPresetId = opts.currentPresetId ||
            opts.activePresetId ||
            presets[0].id;
         STATEFURNITURE.activePresetId = opts.activePresetId || STATEFURNITURE.activePresetId || STATEFURNITURE.currentPresetId;
      }
      renderRoot();
   }
   if (msg.message === "FurnitureOpenCart") {
      const opts = msg.options || {};

      STATEFURNITURE.houses = opts.houses || [];
      STATEFURNITURE.selectedHouseId = null;
      STATEFURNITURE.selectedPlacement = null;

      STATEFURNITURE.lastNonCartMode = STATEFURNITURE.mode;
      STATEFURNITURE.mode = "cart";

      FURNITURE_UI_OPEN = true;
      $("#furn-ui-main").show();
      $('#furn-ui-root').show();
      renderRoot();
   }


   if (msg.message === "FurnitureSetActivePreset") {
      STATEFURNITURE.activePresetId = msg.activePresetId;
      renderPresetsBar();
      renderRoot();
   }

   if (msg.message === "FurnitureHide") {
      $("#furn-ui-main").hide();
      $('#furn-ui-root').hide();
      $ui.invModal.removeClass('furn-is-open');
      $ui.buyModal.removeClass('furn-is-open');
      $ui.confirmModal.removeClass('furn-is-open');
      $ui.presetModal.removeClass('furn-is-open');
   }
   if (msg.message === "FurniturePresetAddItem") {
      const presetId = msg.presetId;
      const item = msg.item || {};


      let preset = STATEFURNITURE.presets.find(p => p.id === presetId);
      if (!preset) {

         preset = {
            id: presetId,
            name: presetId,
            items: []
         };
         STATEFURNITURE.presets.push(preset);
      }


      const imgPath = item.img || `img/furnitures/${(item.object || item.code || "").toString()}.webp`;

      const newItem = {
         id: item.id,
         code: item.object || item.code,
         name: item.label || item.name || (item.object || ""),
         img: imgPath,
         placed: !!item.placed,
      };

      preset.items.push(newItem);


      if (STATEFURNITURE.mode === "inventory") {
         if (!STATEFURNITURE.currentPresetId) {
            STATEFURNITURE.currentPresetId = preset.id;
         }
         renderRoot();
      }
   }
   if (msg.message === "FurnitureCartAddItem") {
      const it = msg.item || {};
      const imgPath = it.img || `img/furnitures/${(it.object || "").toString()}.webp`;

      const cartItem = {
         id: it.object,
         name: it.label || it.name || (it.object || ""),
         price: it.price || 0,
         img: imgPath,
      };

      STATEFURNITURE.incarts.push(cartItem);


      if (STATEFURNITURE.mode === "cart") {
         renderRoot();
      }
   }
   if (msg.message === "FurniturePresetCreate") {
      const p = msg.preset || {};
      if (!p.id) return;


      let existing = STATEFURNITURE.presets.find(x => x.id === p.id);
      if (!existing) {
         const preset = {
            id: p.id,
            name: p.name || p.label || p.id,
            items: (p.items || []).map(it => ({
               id: it.id,
               code: it.object || it.code,
               name: it.label || it.name || (it.object || ""),
               img: it.img || `img/furnitures/${(it.object || it.code || "").toString()}.webp`,
               placed: !!it.placed,
            })),
         };
         STATEFURNITURE.presets.push(preset);


         if (!STATEFURNITURE.currentPresetId) {
            STATEFURNITURE.currentPresetId = preset.id;
         }
      }

      renderRoot();
   }

   if (msg.message === "FurniturePresetDelete") {
      const presetId = msg.presetId;
      if (!presetId) return;

      const wasCurrent = (STATEFURNITURE.currentPresetId === presetId);
      const wasActive = (STATEFURNITURE.activePresetId === presetId);

      STATEFURNITURE.presets = STATEFURNITURE.presets.filter(p => p.id !== presetId);

      if (wasCurrent) {
         STATEFURNITURE.currentPresetId = STATEFURNITURE.presets[0]?.id || null;
      }
      if (wasActive) {
         STATEFURNITURE.activePresetId = STATEFURNITURE.presets[0]?.id || null;
      }

      renderRoot();
   }

   if (msg.message === "FurniturePresetRemoveItem") {
      const presetId = msg.presetId;
      const itemId = msg.itemId;
      if (!presetId || itemId == null) return;

      const preset = STATEFURNITURE.presets.find(p => p.id === presetId);
      if (!preset) return;

      preset.items = preset.items.filter(i => i.id !== itemId);

      if (STATEFURNITURE.mode === "inventory") {
         renderRoot();
      }
   }

   if (msg.message === "FurniturePresetUpdateItem") {
      const presetId = msg.presetId;
      const item = msg.item || {};
      if (!presetId || item.id == null) return;

      const preset = STATEFURNITURE.presets.find(p => p.id === presetId);
      if (!preset) return;

      const idx = preset.items.findIndex(i => i.id === item.id);
      if (idx === -1) return;

      const imgPath = item.img || `img/furnitures/${(item.object || item.code || "").toString()}.webp`;

      preset.items[idx] = {
         ...preset.items[idx],
         code: item.object || item.code || preset.items[idx].code,
         name: item.label || item.name || preset.items[idx].name,
         img: imgPath,
         placed: item.placed != null ? !!item.placed : preset.items[idx].placed,
      };

      if (STATEFURNITURE.mode === "inventory") {
         renderRoot();
      }
   }

   if (msg.message === "FurniturePresetTransferItem") {
      const fromId = msg.fromPresetId;
      const toId = msg.toPresetId;
      const it = msg.item || {};
      if (!fromId || !toId || it.id == null) return;

      const from = STATEFURNITURE.presets.find(p => p.id === fromId);
      const to = STATEFURNITURE.presets.find(p => p.id === toId);
      if (!from || !to) return;


      from.items = from.items.filter(i => i.id !== it.id);


      const imgPath = it.img || `img/furnitures/${(it.object || it.code || "").toString()}.webp`;
      const newItem = {
         id: it.id,
         code: it.object || it.code,
         name: it.label || it.name || (it.object || ""),
         img: imgPath,
         placed: !!it.placed,
      };

      const existingIdx = to.items.findIndex(i => i.id === it.id);
      if (existingIdx === -1) {
         to.items.push(newItem);
      } else {
         to.items[existingIdx] = newItem;
      }

      if (STATEFURNITURE.mode === "inventory") {
         renderRoot();
      }
   }
   if (msg.message === "openPlacement") {
	PlacementTransform.openPlacement();
   }
    if (msg.message === "closePlacement") {
	PlacementTransform.closePlacement();
   }  
    if (msg.message === "updatePlacementPosition") {
	PlacementTransform.updatePlacementPosition(msg.x, msg.y, msg.z);
   }    
    if (msg.message === "updatePlacementRotation") {
	PlacementTransform.updatePlacementRotation(msg.x, msg.y, msg.z);
   }        
});

