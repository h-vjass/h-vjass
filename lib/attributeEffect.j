/*
	life_back 	 	生命恢复效果：增加生命恢复
	mana_back 	 	魔法恢复效果：增加魔法恢复
	attack_speed 	攻击速度效果：增加攻击速度
	move 		 	移动力效果：增加移动力
	attack_physical 物理攻击力效果：增加物理攻击力
	attack_magic    魔法攻击力效果：增加魔法攻击力
	attack_range    攻击距离效果：增加攻击距离
	sight           视野效果：增加视野
	aim 			命中效果：增加命中
	str 			力量效果：增加力量(绿字)
	agi 			敏捷效果：增加敏捷(绿字)
	int 			智力效果：增加智力(绿字)
	knocking 		物理暴击效果：增加物理暴击
	violence 		魔法暴击效果：增加魔法暴击
	hemophagia 		吸血效果：增加吸血
	hemophagia_skill技能吸血效果：增加技能吸血
	split 			分裂效果：增加分裂
	luck 			运气效果：增加运气
	hunt_amplitude 	伤害增幅效果：增加伤害增幅
	
	toxic 			中毒[减少生命恢复]
	burn  			灼烧[减少生命恢复]
	dry 			枯竭[减少魔法恢复]
	freeze 			冻结[减少攻击速度]
	cold 			寒冷[减少移动力]
	blunt			迟钝[减少物理攻击力]
	muggle			麻瓜[减少魔法攻击力]
	myopia			短视[减少攻击距离]
   blind			致盲[减少视野]
	corrosion		腐蚀[减少护甲]
	chaos			混乱[减少魔抗]
	twine			缠绕[减少回避]
	drunk			致盲[减少命中]
	tortua			剧痛[减少韧性]
	weak			乏力[减少力量(绿字)]
	astrict			束缚[减少敏捷(绿字)]
	foolish			愚蠢[减少智力(绿字)]
	dull			粗钝[减少物理暴击]
	dirt			尘迹[减少魔法暴击]
	swim 			眩晕[特定眩晕，直接眩晕，受抵抗]
	heavy 			沉重[加重硬直减少量]
	break 			打断[直接僵直]
	unluck 			倒霉[减少运气]
	silent 			沉默[无法使用技能]
	unarm 			缴械[无法进行攻击]
	fetter			脚镣[无法进行移动]
   bomb			爆破[范围伤害]
   lightning_chain 闪电链[被动传递电击]
   crack_fly 		击飞[上天]
*/
globals
	hAttrEffect hattrEffect
	hashtable hash_attr_effect = null
endglobals

struct hAttrEffect

	private static integer ATTR_FLAG_EFFECT_UNIT = 1000
	//
private static integer ATTR_FLAG_EFFECT_LIFE_BACK_VAL = 2000
private static integer ATTR_FLAG_EFFECT_LIFE_BACK_DURING = 2001
private static integer ATTR_FLAG_EFFECT_MANA_BACK_VAL = 2010
private static integer ATTR_FLAG_EFFECT_MANA_BACK_DURING = 2011
private static integer ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL = 2020
private static integer ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING = 2021
private static integer ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL = 2030
private static integer ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING = 2031
private static integer ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL = 2040
private static integer ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING = 2041
private static integer ATTR_FLAG_EFFECT_ATTACK_RANGE_VAL = 2050
private static integer ATTR_FLAG_EFFECT_ATTACK_RANGE_DURING = 2051
private static integer ATTR_FLAG_EFFECT_SIGHT_VAL = 2060
private static integer ATTR_FLAG_EFFECT_SIGHT_DURING = 2061
private static integer ATTR_FLAG_EFFECT_MOVE_VAL = 2070
private static integer ATTR_FLAG_EFFECT_MOVE_DURING = 2071
private static integer ATTR_FLAG_EFFECT_AIM_VAL = 2080
private static integer ATTR_FLAG_EFFECT_AIM_DURING = 2081
private static integer ATTR_FLAG_EFFECT_STR_VAL = 2090
private static integer ATTR_FLAG_EFFECT_STR_DURING = 2091
private static integer ATTR_FLAG_EFFECT_AGI_VAL = 2100
private static integer ATTR_FLAG_EFFECT_AGI_DURING = 2101
private static integer ATTR_FLAG_EFFECT_INT_VAL = 2110
private static integer ATTR_FLAG_EFFECT_INT_DURING = 2111
private static integer ATTR_FLAG_EFFECT_KNOCKING_VAL = 2120
private static integer ATTR_FLAG_EFFECT_KNOCKING_DURING = 2121
private static integer ATTR_FLAG_EFFECT_VIOLENCE_VAL = 2130
private static integer ATTR_FLAG_EFFECT_VIOLENCE_DURING = 2131
private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL = 2140
private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING = 2141
private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL = 2150
private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING = 2151
private static integer ATTR_FLAG_EFFECT_SPLIT_VAL = 2160
private static integer ATTR_FLAG_EFFECT_SPLIT_DURING = 2161
private static integer ATTR_FLAG_EFFECT_LUCK_VAL = 2170
private static integer ATTR_FLAG_EFFECT_LUCK_DURING = 2171
private static integer ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL = 2180
private static integer ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING = 2181
private static integer ATTR_FLAG_EFFECT_FIRE_VAL = 2190
private static integer ATTR_FLAG_EFFECT_FIRE_DURING = 2191
private static integer ATTR_FLAG_EFFECT_SOIL_VAL = 2200
private static integer ATTR_FLAG_EFFECT_SOIL_DURING = 2201
private static integer ATTR_FLAG_EFFECT_WATER_VAL = 2210
private static integer ATTR_FLAG_EFFECT_WATER_DURING = 2211
private static integer ATTR_FLAG_EFFECT_ICE_VAL = 2220
private static integer ATTR_FLAG_EFFECT_ICE_DURING = 2221
private static integer ATTR_FLAG_EFFECT_WIND_VAL = 2230
private static integer ATTR_FLAG_EFFECT_WIND_DURING = 2231
private static integer ATTR_FLAG_EFFECT_LIGHT_VAL = 2240
private static integer ATTR_FLAG_EFFECT_LIGHT_DURING = 2241
private static integer ATTR_FLAG_EFFECT_DARK_VAL = 2250
private static integer ATTR_FLAG_EFFECT_DARK_DURING = 2251
private static integer ATTR_FLAG_EFFECT_WOOD_VAL = 2260
private static integer ATTR_FLAG_EFFECT_WOOD_DURING = 2261
private static integer ATTR_FLAG_EFFECT_THUNDER_VAL = 2270
private static integer ATTR_FLAG_EFFECT_THUNDER_DURING = 2271
private static integer ATTR_FLAG_EFFECT_POISON_VAL = 2280
private static integer ATTR_FLAG_EFFECT_POISON_DURING = 2281
private static integer ATTR_FLAG_EFFECT_GHOST_VAL = 2290
private static integer ATTR_FLAG_EFFECT_GHOST_DURING = 2291
private static integer ATTR_FLAG_EFFECT_METAL_VAL = 2300
private static integer ATTR_FLAG_EFFECT_METAL_DURING = 2301
private static integer ATTR_FLAG_EFFECT_DRAGON_VAL = 2310
private static integer ATTR_FLAG_EFFECT_DRAGON_DURING = 2311
private static integer ATTR_FLAG_EFFECT_FIRE_OPPOSE_VAL = 2320
private static integer ATTR_FLAG_EFFECT_FIRE_OPPOSE_DURING = 2321
private static integer ATTR_FLAG_EFFECT_SOIL_OPPOSE_VAL = 2330
private static integer ATTR_FLAG_EFFECT_SOIL_OPPOSE_DURING = 2331
private static integer ATTR_FLAG_EFFECT_WATER_OPPOSE_VAL = 2340
private static integer ATTR_FLAG_EFFECT_WATER_OPPOSE_DURING = 2341
private static integer ATTR_FLAG_EFFECT_ICE_OPPOSE_VAL = 2350
private static integer ATTR_FLAG_EFFECT_ICE_OPPOSE_DURING = 2351
private static integer ATTR_FLAG_EFFECT_WIND_OPPOSE_VAL = 2360
private static integer ATTR_FLAG_EFFECT_WIND_OPPOSE_DURING = 2361
private static integer ATTR_FLAG_EFFECT_LIGHT_OPPOSE_VAL = 2370
private static integer ATTR_FLAG_EFFECT_LIGHT_OPPOSE_DURING = 2371
private static integer ATTR_FLAG_EFFECT_DARK_OPPOSE_VAL = 2380
private static integer ATTR_FLAG_EFFECT_DARK_OPPOSE_DURING = 2381
private static integer ATTR_FLAG_EFFECT_WOOD_OPPOSE_VAL = 2390
private static integer ATTR_FLAG_EFFECT_WOOD_OPPOSE_DURING = 2391
private static integer ATTR_FLAG_EFFECT_THUNDER_OPPOSE_VAL = 2400
private static integer ATTR_FLAG_EFFECT_THUNDER_OPPOSE_DURING = 2401
private static integer ATTR_FLAG_EFFECT_POISON_OPPOSE_VAL = 2410
private static integer ATTR_FLAG_EFFECT_POISON_OPPOSE_DURING = 2411
private static integer ATTR_FLAG_EFFECT_GHOST_OPPOSE_VAL = 2420
private static integer ATTR_FLAG_EFFECT_GHOST_OPPOSE_DURING = 2421
private static integer ATTR_FLAG_EFFECT_METAL_OPPOSE_VAL = 2430
private static integer ATTR_FLAG_EFFECT_METAL_OPPOSE_DURING = 2431
private static integer ATTR_FLAG_EFFECT_DRAGON_OPPOSE_VAL = 2440
private static integer ATTR_FLAG_EFFECT_DRAGON_OPPOSE_DURING = 2441
private static integer ATTR_FLAG_EFFECT_TOXIC_VAL = 2450
private static integer ATTR_FLAG_EFFECT_TOXIC_DURING = 2451
private static integer ATTR_FLAG_EFFECT_BURN_VAL = 2460
private static integer ATTR_FLAG_EFFECT_BURN_DURING = 2461
private static integer ATTR_FLAG_EFFECT_DRY_VAL = 2470
private static integer ATTR_FLAG_EFFECT_DRY_DURING = 2471
private static integer ATTR_FLAG_EFFECT_FREEZE_VAL = 2480
private static integer ATTR_FLAG_EFFECT_FREEZE_DURING = 2481
private static integer ATTR_FLAG_EFFECT_COLD_VAL = 2490
private static integer ATTR_FLAG_EFFECT_COLD_DURING = 2491
private static integer ATTR_FLAG_EFFECT_BLUNT_VAL = 2500
private static integer ATTR_FLAG_EFFECT_BLUNT_DURING = 2501
private static integer ATTR_FLAG_EFFECT_MUGGLE_VAL = 2510
private static integer ATTR_FLAG_EFFECT_MUGGLE_DURING = 2511
private static integer ATTR_FLAG_EFFECT_MYOPIA_VAL = 2520
private static integer ATTR_FLAG_EFFECT_MYOPIA_DURING = 2521
private static integer ATTR_FLAG_EFFECT_BLIND_VAL = 2530
private static integer ATTR_FLAG_EFFECT_BLIND_DURING = 2531
private static integer ATTR_FLAG_EFFECT_CORROSION_VAL = 2540
private static integer ATTR_FLAG_EFFECT_CORROSION_DURING = 2541
private static integer ATTR_FLAG_EFFECT_CHAOS_VAL = 2550
private static integer ATTR_FLAG_EFFECT_CHAOS_DURING = 2551
private static integer ATTR_FLAG_EFFECT_TWINE_VAL = 2560
private static integer ATTR_FLAG_EFFECT_TWINE_DURING = 2561
private static integer ATTR_FLAG_EFFECT_DRUNK_VAL = 2570
private static integer ATTR_FLAG_EFFECT_DRUNK_DURING = 2571
private static integer ATTR_FLAG_EFFECT_TORTUA_VAL = 2580
private static integer ATTR_FLAG_EFFECT_TORTUA_DURING = 2581
private static integer ATTR_FLAG_EFFECT_WEAK_VAL = 2590
private static integer ATTR_FLAG_EFFECT_WEAK_DURING = 2591
private static integer ATTR_FLAG_EFFECT_ASTRICT_VAL = 2600
private static integer ATTR_FLAG_EFFECT_ASTRICT_DURING = 2601
private static integer ATTR_FLAG_EFFECT_FOOLISH_VAL = 2610
private static integer ATTR_FLAG_EFFECT_FOOLISH_DURING = 2611
private static integer ATTR_FLAG_EFFECT_DULL_VAL = 2620
private static integer ATTR_FLAG_EFFECT_DULL_DURING = 2621
private static integer ATTR_FLAG_EFFECT_DIRT_VAL = 2630
private static integer ATTR_FLAG_EFFECT_DIRT_DURING = 2631
private static integer ATTR_FLAG_EFFECT_SWIM_ODDS = 2640
private static integer ATTR_FLAG_EFFECT_SWIM_DURING = 2641
private static integer ATTR_FLAG_EFFECT_HEAVY_ODDS = 2650
private static integer ATTR_FLAG_EFFECT_HEAVY_VAL = 2651
private static integer ATTR_FLAG_EFFECT_BREAK_ODDS = 2660
private static integer ATTR_FLAG_EFFECT_BREAK_DURING = 2661
private static integer ATTR_FLAG_EFFECT_UNLUCK_VAL = 2670
private static integer ATTR_FLAG_EFFECT_UNLUCK_DURING = 2671
private static integer ATTR_FLAG_EFFECT_SILENT_ODDS = 2680
private static integer ATTR_FLAG_EFFECT_SILENT_DURING = 2681
private static integer ATTR_FLAG_EFFECT_UNARM_ODDS = 2690
private static integer ATTR_FLAG_EFFECT_UNARM_DURING = 2691
private static integer ATTR_FLAG_EFFECT_FETTER_ODDS = 2700
private static integer ATTR_FLAG_EFFECT_FETTER_DURING = 2701
private static integer ATTR_FLAG_EFFECT_BOMB_VAL = 2710
private static integer ATTR_FLAG_EFFECT_BOMB_ODDS = 2711
private static integer ATTR_FLAG_EFFECT_BOMB_RANGE = 2712
private static integer ATTR_FLAG_EFFECT_BOMB_MODEL = 2713
private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL = 2720
private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS = 2721
private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY = 2722
private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE = 2723
private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_MODEL = 2724
private static integer ATTR_FLAG_EFFECT_CRACK_FLY_VAL = 2730
private static integer ATTR_FLAG_EFFECT_CRACK_FLY_ODDS = 2731
private static integer ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE = 2732
private static integer ATTR_FLAG_EFFECT_CRACK_FLY_HIGH = 2733

	static method create takes nothing returns hAttrEffect
        local hAttrEffect x = 0
        set x = hAttrEffect.allocate()
        return x
    endmethod

	/**
	 * 验证单位是否初始化过参数
	 */
	public static method initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNIT , uhid )

call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIFE_BACK_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIFE_BACK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MANA_BACK_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MANA_BACK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_RANGE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_RANGE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SIGHT_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SIGHT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MOVE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MOVE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_AIM_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_AIM_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_STR_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_STR_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_AGI_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_AGI_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_INT_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_INT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_KNOCKING_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_KNOCKING_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_VIOLENCE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_VIOLENCE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SPLIT_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SPLIT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LUCK_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LUCK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FIRE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FIRE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SOIL_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SOIL_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WATER_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WATER_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ICE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ICE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WIND_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WIND_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHT_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DARK_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DARK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WOOD_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WOOD_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_THUNDER_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_THUNDER_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_POISON_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_POISON_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_GHOST_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_GHOST_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_METAL_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_METAL_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRAGON_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRAGON_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FIRE_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FIRE_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SOIL_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SOIL_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WATER_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WATER_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ICE_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ICE_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WIND_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WIND_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHT_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHT_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DARK_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DARK_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WOOD_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WOOD_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_THUNDER_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_THUNDER_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_POISON_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_POISON_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_GHOST_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_GHOST_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_METAL_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_METAL_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRAGON_OPPOSE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRAGON_OPPOSE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TOXIC_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TOXIC_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BURN_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BURN_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRY_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRY_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FREEZE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FREEZE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_COLD_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_COLD_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLUNT_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLUNT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MUGGLE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MUGGLE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MYOPIA_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MYOPIA_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLIND_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLIND_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CORROSION_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CORROSION_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CHAOS_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CHAOS_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TWINE_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TWINE_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRUNK_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRUNK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TORTUA_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TORTUA_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WEAK_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WEAK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ASTRICT_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ASTRICT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FOOLISH_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FOOLISH_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DULL_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DULL_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DIRT_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DIRT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SWIM_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SWIM_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEAVY_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEAVY_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BREAK_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BREAK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNLUCK_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNLUCK_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SILENT_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SILENT_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNARM_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNARM_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FETTER_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FETTER_DURING , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BOMB_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BOMB_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BOMB_RANGE , 0 )
 call SaveStr( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BOMB_MODEL , "" )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , 0 )
 call SaveStr( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_MODEL , "" )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CRACK_FLY_VAL , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , 0 )
 call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , 0 )
			
            return true
		endif
		return false
	endmethod

	/**
	 * 设定属性(即时/计时)
	 */
	private static method setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		if(diff != 0)then
			call SaveReal( hash_attr_effect , uhid , flag , LoadReal( hash_attr_effect , uhid , flag ) + diff )
		endif
	endmethod

	private static method setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = htime.getInteger(t,1)
		local unit whichUnit = htime.getUnit(t,2)
		local real diff = htime.getReal(t,3)
		call htime.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
      set t = null
      set whichUnit = null
	endmethod

	private static method setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr( whichUnit )
		call setAttrDo( flag , whichUnit , diff )
		if( during>0 ) then
			set t = htime.setTimeout( during , function thistype.setAttrDuring )
			call htime.setInteger(t,1,flag)
			call htime.setUnit(t,2,whichUnit)
			call htime.setReal(t,3, -diff )
		endif
      set t = null
	endmethod

	private static method getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash_attr_effect , GetHandleId(whichUnit) , flag )
	endmethod




// 攻击|伤害特效[life_back][val]
public static method getLifeBackVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIFE_BACK_VAL , whichUnit )
endmethod
public static method addLifeBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_VAL , whichUnit , value , during )
endmethod
public static method subLifeBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_VAL , whichUnit , -value, during )
endmethod
public static method coverLifeBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_VAL , whichUnit , hlogic.coverAttrEffectVal(getLifeBackVal(whichUnit),value)-getLifeBackVal(whichUnit) , during )
endmethod
public static method setLifeBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_VAL , whichUnit , value - getLifeBackVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[life_back][during]
public static method getLifeBackDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIFE_BACK_DURING , whichUnit )
endmethod
public static method addLifeBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_DURING , whichUnit , value , during )
endmethod
public static method subLifeBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_DURING , whichUnit , -value, during )
endmethod
public static method coverLifeBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_DURING , whichUnit , hlogic.coverAttrEffectVal(getLifeBackDuring(whichUnit),value)-getLifeBackDuring(whichUnit) , during )
endmethod
public static method setLifeBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_DURING , whichUnit , value - getLifeBackDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[mana_back][val]
public static method getManaBackVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MANA_BACK_VAL , whichUnit )
endmethod
public static method addManaBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_VAL , whichUnit , value , during )
endmethod
public static method subManaBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_VAL , whichUnit , -value, during )
endmethod
public static method coverManaBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_VAL , whichUnit , hlogic.coverAttrEffectVal(getManaBackVal(whichUnit),value)-getManaBackVal(whichUnit) , during )
endmethod
public static method setManaBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_VAL , whichUnit , value - getManaBackVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[mana_back][during]
public static method getManaBackDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MANA_BACK_DURING , whichUnit )
endmethod
public static method addManaBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_DURING , whichUnit , value , during )
endmethod
public static method subManaBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_DURING , whichUnit , -value, during )
endmethod
public static method coverManaBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_DURING , whichUnit , hlogic.coverAttrEffectVal(getManaBackDuring(whichUnit),value)-getManaBackDuring(whichUnit) , during )
endmethod
public static method setManaBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_DURING , whichUnit , value - getManaBackDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_speed][val]
public static method getAttackSpeedVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , whichUnit )
endmethod
public static method addAttackSpeedVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , whichUnit , value , during )
endmethod
public static method subAttackSpeedVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , whichUnit , -value, during )
endmethod
public static method coverAttackSpeedVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , whichUnit , hlogic.coverAttrEffectVal(getAttackSpeedVal(whichUnit),value)-getAttackSpeedVal(whichUnit) , during )
endmethod
public static method setAttackSpeedVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , whichUnit , value - getAttackSpeedVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_speed][during]
public static method getAttackSpeedDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , whichUnit )
endmethod
public static method addAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , whichUnit , value , during )
endmethod
public static method subAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , whichUnit , -value, during )
endmethod
public static method coverAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , whichUnit , hlogic.coverAttrEffectVal(getAttackSpeedDuring(whichUnit),value)-getAttackSpeedDuring(whichUnit) , during )
endmethod
public static method setAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , whichUnit , value - getAttackSpeedDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_physical][val]
public static method getAttackPhysicalVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , whichUnit )
endmethod
public static method addAttackPhysicalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , whichUnit , value , during )
endmethod
public static method subAttackPhysicalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , whichUnit , -value, during )
endmethod
public static method coverAttackPhysicalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , whichUnit , hlogic.coverAttrEffectVal(getAttackPhysicalVal(whichUnit),value)-getAttackPhysicalVal(whichUnit) , during )
endmethod
public static method setAttackPhysicalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , whichUnit , value - getAttackPhysicalVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_physical][during]
public static method getAttackPhysicalDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , whichUnit )
endmethod
public static method addAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , whichUnit , value , during )
endmethod
public static method subAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , whichUnit , -value, during )
endmethod
public static method coverAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , whichUnit , hlogic.coverAttrEffectVal(getAttackPhysicalDuring(whichUnit),value)-getAttackPhysicalDuring(whichUnit) , during )
endmethod
public static method setAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , whichUnit , value - getAttackPhysicalDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_magic][val]
public static method getAttackMagicVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , whichUnit )
endmethod
public static method addAttackMagicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , whichUnit , value , during )
endmethod
public static method subAttackMagicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , whichUnit , -value, during )
endmethod
public static method coverAttackMagicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , whichUnit , hlogic.coverAttrEffectVal(getAttackMagicVal(whichUnit),value)-getAttackMagicVal(whichUnit) , during )
endmethod
public static method setAttackMagicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , whichUnit , value - getAttackMagicVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_magic][during]
public static method getAttackMagicDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , whichUnit )
endmethod
public static method addAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , whichUnit , value , during )
endmethod
public static method subAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , whichUnit , -value, during )
endmethod
public static method coverAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , whichUnit , hlogic.coverAttrEffectVal(getAttackMagicDuring(whichUnit),value)-getAttackMagicDuring(whichUnit) , during )
endmethod
public static method setAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , whichUnit , value - getAttackMagicDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_range][val]
public static method getAttackRangeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_VAL , whichUnit )
endmethod
public static method addAttackRangeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_VAL , whichUnit , value , during )
endmethod
public static method subAttackRangeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_VAL , whichUnit , -value, during )
endmethod
public static method coverAttackRangeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_VAL , whichUnit , hlogic.coverAttrEffectVal(getAttackRangeVal(whichUnit),value)-getAttackRangeVal(whichUnit) , during )
endmethod
public static method setAttackRangeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_VAL , whichUnit , value - getAttackRangeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[attack_range][during]
public static method getAttackRangeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_DURING , whichUnit )
endmethod
public static method addAttackRangeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_DURING , whichUnit , value , during )
endmethod
public static method subAttackRangeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_DURING , whichUnit , -value, during )
endmethod
public static method coverAttackRangeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_DURING , whichUnit , hlogic.coverAttrEffectVal(getAttackRangeDuring(whichUnit),value)-getAttackRangeDuring(whichUnit) , during )
endmethod
public static method setAttackRangeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_RANGE_DURING , whichUnit , value - getAttackRangeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[sight][val]
public static method getSightVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SIGHT_VAL , whichUnit )
endmethod
public static method addSightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_VAL , whichUnit , value , during )
endmethod
public static method subSightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_VAL , whichUnit , -value, during )
endmethod
public static method coverSightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_VAL , whichUnit , hlogic.coverAttrEffectVal(getSightVal(whichUnit),value)-getSightVal(whichUnit) , during )
endmethod
public static method setSightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_VAL , whichUnit , value - getSightVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[sight][during]
public static method getSightDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SIGHT_DURING , whichUnit )
endmethod
public static method addSightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_DURING , whichUnit , value , during )
endmethod
public static method subSightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_DURING , whichUnit , -value, during )
endmethod
public static method coverSightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_DURING , whichUnit , hlogic.coverAttrEffectVal(getSightDuring(whichUnit),value)-getSightDuring(whichUnit) , during )
endmethod
public static method setSightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SIGHT_DURING , whichUnit , value - getSightDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[move][val]
public static method getMoveVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MOVE_VAL , whichUnit )
endmethod
public static method addMoveVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_VAL , whichUnit , value , during )
endmethod
public static method subMoveVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_VAL , whichUnit , -value, during )
endmethod
public static method coverMoveVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_VAL , whichUnit , hlogic.coverAttrEffectVal(getMoveVal(whichUnit),value)-getMoveVal(whichUnit) , during )
endmethod
public static method setMoveVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_VAL , whichUnit , value - getMoveVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[move][during]
public static method getMoveDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MOVE_DURING , whichUnit )
endmethod
public static method addMoveDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_DURING , whichUnit , value , during )
endmethod
public static method subMoveDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_DURING , whichUnit , -value, during )
endmethod
public static method coverMoveDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_DURING , whichUnit , hlogic.coverAttrEffectVal(getMoveDuring(whichUnit),value)-getMoveDuring(whichUnit) , during )
endmethod
public static method setMoveDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_DURING , whichUnit , value - getMoveDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[aim][val]
public static method getAimVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_AIM_VAL , whichUnit )
endmethod
public static method addAimVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_VAL , whichUnit , value , during )
endmethod
public static method subAimVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_VAL , whichUnit , -value, during )
endmethod
public static method coverAimVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_VAL , whichUnit , hlogic.coverAttrEffectVal(getAimVal(whichUnit),value)-getAimVal(whichUnit) , during )
endmethod
public static method setAimVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_VAL , whichUnit , value - getAimVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[aim][during]
public static method getAimDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_AIM_DURING , whichUnit )
endmethod
public static method addAimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_DURING , whichUnit , value , during )
endmethod
public static method subAimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_DURING , whichUnit , -value, during )
endmethod
public static method coverAimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_DURING , whichUnit , hlogic.coverAttrEffectVal(getAimDuring(whichUnit),value)-getAimDuring(whichUnit) , during )
endmethod
public static method setAimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_DURING , whichUnit , value - getAimDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[str][val]
public static method getStrVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_STR_VAL , whichUnit )
endmethod
public static method addStrVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_VAL , whichUnit , value , during )
endmethod
public static method subStrVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_VAL , whichUnit , -value, during )
endmethod
public static method coverStrVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_VAL , whichUnit , hlogic.coverAttrEffectVal(getStrVal(whichUnit),value)-getStrVal(whichUnit) , during )
endmethod
public static method setStrVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_VAL , whichUnit , value - getStrVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[str][during]
public static method getStrDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_STR_DURING , whichUnit )
endmethod
public static method addStrDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_DURING , whichUnit , value , during )
endmethod
public static method subStrDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_DURING , whichUnit , -value, during )
endmethod
public static method coverStrDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_DURING , whichUnit , hlogic.coverAttrEffectVal(getStrDuring(whichUnit),value)-getStrDuring(whichUnit) , during )
endmethod
public static method setStrDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_DURING , whichUnit , value - getStrDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[agi][val]
public static method getAgiVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_AGI_VAL , whichUnit )
endmethod
public static method addAgiVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_VAL , whichUnit , value , during )
endmethod
public static method subAgiVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_VAL , whichUnit , -value, during )
endmethod
public static method coverAgiVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_VAL , whichUnit , hlogic.coverAttrEffectVal(getAgiVal(whichUnit),value)-getAgiVal(whichUnit) , during )
endmethod
public static method setAgiVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_VAL , whichUnit , value - getAgiVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[agi][during]
public static method getAgiDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_AGI_DURING , whichUnit )
endmethod
public static method addAgiDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_DURING , whichUnit , value , during )
endmethod
public static method subAgiDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_DURING , whichUnit , -value, during )
endmethod
public static method coverAgiDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_DURING , whichUnit , hlogic.coverAttrEffectVal(getAgiDuring(whichUnit),value)-getAgiDuring(whichUnit) , during )
endmethod
public static method setAgiDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_DURING , whichUnit , value - getAgiDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[int][val]
public static method getIntVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_INT_VAL , whichUnit )
endmethod
public static method addIntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_VAL , whichUnit , value , during )
endmethod
public static method subIntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_VAL , whichUnit , -value, during )
endmethod
public static method coverIntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_VAL , whichUnit , hlogic.coverAttrEffectVal(getIntVal(whichUnit),value)-getIntVal(whichUnit) , during )
endmethod
public static method setIntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_VAL , whichUnit , value - getIntVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[int][during]
public static method getIntDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_INT_DURING , whichUnit )
endmethod
public static method addIntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_DURING , whichUnit , value , during )
endmethod
public static method subIntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_DURING , whichUnit , -value, during )
endmethod
public static method coverIntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_DURING , whichUnit , hlogic.coverAttrEffectVal(getIntDuring(whichUnit),value)-getIntDuring(whichUnit) , during )
endmethod
public static method setIntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_DURING , whichUnit , value - getIntDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[knocking][val]
public static method getKnockingVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_KNOCKING_VAL , whichUnit )
endmethod
public static method addKnockingVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_VAL , whichUnit , value , during )
endmethod
public static method subKnockingVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_VAL , whichUnit , -value, during )
endmethod
public static method coverKnockingVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_VAL , whichUnit , hlogic.coverAttrEffectVal(getKnockingVal(whichUnit),value)-getKnockingVal(whichUnit) , during )
endmethod
public static method setKnockingVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_VAL , whichUnit , value - getKnockingVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[knocking][during]
public static method getKnockingDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_KNOCKING_DURING , whichUnit )
endmethod
public static method addKnockingDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_DURING , whichUnit , value , during )
endmethod
public static method subKnockingDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_DURING , whichUnit , -value, during )
endmethod
public static method coverKnockingDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_DURING , whichUnit , hlogic.coverAttrEffectVal(getKnockingDuring(whichUnit),value)-getKnockingDuring(whichUnit) , during )
endmethod
public static method setKnockingDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_DURING , whichUnit , value - getKnockingDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[violence][val]
public static method getViolenceVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_VIOLENCE_VAL , whichUnit )
endmethod
public static method addViolenceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_VAL , whichUnit , value , during )
endmethod
public static method subViolenceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_VAL , whichUnit , -value, during )
endmethod
public static method coverViolenceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_VAL , whichUnit , hlogic.coverAttrEffectVal(getViolenceVal(whichUnit),value)-getViolenceVal(whichUnit) , during )
endmethod
public static method setViolenceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_VAL , whichUnit , value - getViolenceVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[violence][during]
public static method getViolenceDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_VIOLENCE_DURING , whichUnit )
endmethod
public static method addViolenceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_DURING , whichUnit , value , during )
endmethod
public static method subViolenceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_DURING , whichUnit , -value, during )
endmethod
public static method coverViolenceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_DURING , whichUnit , hlogic.coverAttrEffectVal(getViolenceDuring(whichUnit),value)-getViolenceDuring(whichUnit) , during )
endmethod
public static method setViolenceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_DURING , whichUnit , value - getViolenceDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[hemophagia][val]
public static method getHemophagiaVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , whichUnit )
endmethod
public static method addHemophagiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , whichUnit , value , during )
endmethod
public static method subHemophagiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , whichUnit , -value, during )
endmethod
public static method coverHemophagiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , whichUnit , hlogic.coverAttrEffectVal(getHemophagiaVal(whichUnit),value)-getHemophagiaVal(whichUnit) , during )
endmethod
public static method setHemophagiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , whichUnit , value - getHemophagiaVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[hemophagia][during]
public static method getHemophagiaDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , whichUnit )
endmethod
public static method addHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , whichUnit , value , during )
endmethod
public static method subHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , whichUnit , -value, during )
endmethod
public static method coverHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , whichUnit , hlogic.coverAttrEffectVal(getHemophagiaDuring(whichUnit),value)-getHemophagiaDuring(whichUnit) , during )
endmethod
public static method setHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , whichUnit , value - getHemophagiaDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[hemophagia_skill][val]
public static method getHemophagiaSkillVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , whichUnit )
endmethod
public static method addHemophagiaSkillVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , whichUnit , value , during )
endmethod
public static method subHemophagiaSkillVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , whichUnit , -value, during )
endmethod
public static method coverHemophagiaSkillVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , whichUnit , hlogic.coverAttrEffectVal(getHemophagiaSkillVal(whichUnit),value)-getHemophagiaSkillVal(whichUnit) , during )
endmethod
public static method setHemophagiaSkillVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , whichUnit , value - getHemophagiaSkillVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[hemophagia_skill][during]
public static method getHemophagiaSkillDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , whichUnit )
endmethod
public static method addHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , whichUnit , value , during )
endmethod
public static method subHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , whichUnit , -value, during )
endmethod
public static method coverHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , whichUnit , hlogic.coverAttrEffectVal(getHemophagiaSkillDuring(whichUnit),value)-getHemophagiaSkillDuring(whichUnit) , during )
endmethod
public static method setHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , whichUnit , value - getHemophagiaSkillDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[split][val]
public static method getSplitVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SPLIT_VAL , whichUnit )
endmethod
public static method addSplitVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_VAL , whichUnit , value , during )
endmethod
public static method subSplitVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_VAL , whichUnit , -value, during )
endmethod
public static method coverSplitVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_VAL , whichUnit , hlogic.coverAttrEffectVal(getSplitVal(whichUnit),value)-getSplitVal(whichUnit) , during )
endmethod
public static method setSplitVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_VAL , whichUnit , value - getSplitVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[split][during]
public static method getSplitDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SPLIT_DURING , whichUnit )
endmethod
public static method addSplitDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_DURING , whichUnit , value , during )
endmethod
public static method subSplitDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_DURING , whichUnit , -value, during )
endmethod
public static method coverSplitDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_DURING , whichUnit , hlogic.coverAttrEffectVal(getSplitDuring(whichUnit),value)-getSplitDuring(whichUnit) , during )
endmethod
public static method setSplitDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_DURING , whichUnit , value - getSplitDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[luck][val]
public static method getLuckVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LUCK_VAL , whichUnit )
endmethod
public static method addLuckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_VAL , whichUnit , value , during )
endmethod
public static method subLuckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_VAL , whichUnit , -value, during )
endmethod
public static method coverLuckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_VAL , whichUnit , hlogic.coverAttrEffectVal(getLuckVal(whichUnit),value)-getLuckVal(whichUnit) , during )
endmethod
public static method setLuckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_VAL , whichUnit , value - getLuckVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[luck][during]
public static method getLuckDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LUCK_DURING , whichUnit )
endmethod
public static method addLuckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_DURING , whichUnit , value , during )
endmethod
public static method subLuckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_DURING , whichUnit , -value, during )
endmethod
public static method coverLuckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_DURING , whichUnit , hlogic.coverAttrEffectVal(getLuckDuring(whichUnit),value)-getLuckDuring(whichUnit) , during )
endmethod
public static method setLuckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_DURING , whichUnit , value - getLuckDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[hunt_amplitude][val]
public static method getHuntAmplitudeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , whichUnit )
endmethod
public static method addHuntAmplitudeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , whichUnit , value , during )
endmethod
public static method subHuntAmplitudeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , whichUnit , -value, during )
endmethod
public static method coverHuntAmplitudeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , whichUnit , hlogic.coverAttrEffectVal(getHuntAmplitudeVal(whichUnit),value)-getHuntAmplitudeVal(whichUnit) , during )
endmethod
public static method setHuntAmplitudeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , whichUnit , value - getHuntAmplitudeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[hunt_amplitude][during]
public static method getHuntAmplitudeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , whichUnit )
endmethod
public static method addHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , whichUnit , value , during )
endmethod
public static method subHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , whichUnit , -value, during )
endmethod
public static method coverHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , whichUnit , hlogic.coverAttrEffectVal(getHuntAmplitudeDuring(whichUnit),value)-getHuntAmplitudeDuring(whichUnit) , during )
endmethod
public static method setHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , whichUnit , value - getHuntAmplitudeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[fire][val]
public static method getFireVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FIRE_VAL , whichUnit )
endmethod
public static method addFireVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_VAL , whichUnit , value , during )
endmethod
public static method subFireVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_VAL , whichUnit , -value, during )
endmethod
public static method coverFireVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_VAL , whichUnit , hlogic.coverAttrEffectVal(getFireVal(whichUnit),value)-getFireVal(whichUnit) , during )
endmethod
public static method setFireVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_VAL , whichUnit , value - getFireVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[fire][during]
public static method getFireDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FIRE_DURING , whichUnit )
endmethod
public static method addFireDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_DURING , whichUnit , value , during )
endmethod
public static method subFireDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_DURING , whichUnit , -value, during )
endmethod
public static method coverFireDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_DURING , whichUnit , hlogic.coverAttrEffectVal(getFireDuring(whichUnit),value)-getFireDuring(whichUnit) , during )
endmethod
public static method setFireDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_DURING , whichUnit , value - getFireDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[soil][val]
public static method getSoilVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SOIL_VAL , whichUnit )
endmethod
public static method addSoilVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_VAL , whichUnit , value , during )
endmethod
public static method subSoilVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_VAL , whichUnit , -value, during )
endmethod
public static method coverSoilVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_VAL , whichUnit , hlogic.coverAttrEffectVal(getSoilVal(whichUnit),value)-getSoilVal(whichUnit) , during )
endmethod
public static method setSoilVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_VAL , whichUnit , value - getSoilVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[soil][during]
public static method getSoilDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SOIL_DURING , whichUnit )
endmethod
public static method addSoilDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_DURING , whichUnit , value , during )
endmethod
public static method subSoilDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_DURING , whichUnit , -value, during )
endmethod
public static method coverSoilDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_DURING , whichUnit , hlogic.coverAttrEffectVal(getSoilDuring(whichUnit),value)-getSoilDuring(whichUnit) , during )
endmethod
public static method setSoilDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_DURING , whichUnit , value - getSoilDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[water][val]
public static method getWaterVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WATER_VAL , whichUnit )
endmethod
public static method addWaterVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_VAL , whichUnit , value , during )
endmethod
public static method subWaterVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_VAL , whichUnit , -value, during )
endmethod
public static method coverWaterVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_VAL , whichUnit , hlogic.coverAttrEffectVal(getWaterVal(whichUnit),value)-getWaterVal(whichUnit) , during )
endmethod
public static method setWaterVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_VAL , whichUnit , value - getWaterVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[water][during]
public static method getWaterDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WATER_DURING , whichUnit )
endmethod
public static method addWaterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_DURING , whichUnit , value , during )
endmethod
public static method subWaterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_DURING , whichUnit , -value, during )
endmethod
public static method coverWaterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_DURING , whichUnit , hlogic.coverAttrEffectVal(getWaterDuring(whichUnit),value)-getWaterDuring(whichUnit) , during )
endmethod
public static method setWaterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_DURING , whichUnit , value - getWaterDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ice][val]
public static method getIceVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ICE_VAL , whichUnit )
endmethod
public static method addIceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_VAL , whichUnit , value , during )
endmethod
public static method subIceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_VAL , whichUnit , -value, during )
endmethod
public static method coverIceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_VAL , whichUnit , hlogic.coverAttrEffectVal(getIceVal(whichUnit),value)-getIceVal(whichUnit) , during )
endmethod
public static method setIceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_VAL , whichUnit , value - getIceVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ice][during]
public static method getIceDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ICE_DURING , whichUnit )
endmethod
public static method addIceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_DURING , whichUnit , value , during )
endmethod
public static method subIceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_DURING , whichUnit , -value, during )
endmethod
public static method coverIceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_DURING , whichUnit , hlogic.coverAttrEffectVal(getIceDuring(whichUnit),value)-getIceDuring(whichUnit) , during )
endmethod
public static method setIceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_DURING , whichUnit , value - getIceDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wind][val]
public static method getWindVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WIND_VAL , whichUnit )
endmethod
public static method addWindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_VAL , whichUnit , value , during )
endmethod
public static method subWindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_VAL , whichUnit , -value, during )
endmethod
public static method coverWindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_VAL , whichUnit , hlogic.coverAttrEffectVal(getWindVal(whichUnit),value)-getWindVal(whichUnit) , during )
endmethod
public static method setWindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_VAL , whichUnit , value - getWindVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wind][during]
public static method getWindDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WIND_DURING , whichUnit )
endmethod
public static method addWindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_DURING , whichUnit , value , during )
endmethod
public static method subWindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_DURING , whichUnit , -value, during )
endmethod
public static method coverWindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_DURING , whichUnit , hlogic.coverAttrEffectVal(getWindDuring(whichUnit),value)-getWindDuring(whichUnit) , during )
endmethod
public static method setWindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_DURING , whichUnit , value - getWindDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[light][val]
public static method getLightVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHT_VAL , whichUnit )
endmethod
public static method addLightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_VAL , whichUnit , value , during )
endmethod
public static method subLightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_VAL , whichUnit , -value, during )
endmethod
public static method coverLightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_VAL , whichUnit , hlogic.coverAttrEffectVal(getLightVal(whichUnit),value)-getLightVal(whichUnit) , during )
endmethod
public static method setLightVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_VAL , whichUnit , value - getLightVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[light][during]
public static method getLightDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHT_DURING , whichUnit )
endmethod
public static method addLightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_DURING , whichUnit , value , during )
endmethod
public static method subLightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_DURING , whichUnit , -value, during )
endmethod
public static method coverLightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_DURING , whichUnit , hlogic.coverAttrEffectVal(getLightDuring(whichUnit),value)-getLightDuring(whichUnit) , during )
endmethod
public static method setLightDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_DURING , whichUnit , value - getLightDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dark][val]
public static method getDarkVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DARK_VAL , whichUnit )
endmethod
public static method addDarkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_VAL , whichUnit , value , during )
endmethod
public static method subDarkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_VAL , whichUnit , -value, during )
endmethod
public static method coverDarkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_VAL , whichUnit , hlogic.coverAttrEffectVal(getDarkVal(whichUnit),value)-getDarkVal(whichUnit) , during )
endmethod
public static method setDarkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_VAL , whichUnit , value - getDarkVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dark][during]
public static method getDarkDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DARK_DURING , whichUnit )
endmethod
public static method addDarkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_DURING , whichUnit , value , during )
endmethod
public static method subDarkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_DURING , whichUnit , -value, during )
endmethod
public static method coverDarkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_DURING , whichUnit , hlogic.coverAttrEffectVal(getDarkDuring(whichUnit),value)-getDarkDuring(whichUnit) , during )
endmethod
public static method setDarkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_DURING , whichUnit , value - getDarkDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wood][val]
public static method getWoodVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WOOD_VAL , whichUnit )
endmethod
public static method addWoodVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_VAL , whichUnit , value , during )
endmethod
public static method subWoodVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_VAL , whichUnit , -value, during )
endmethod
public static method coverWoodVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_VAL , whichUnit , hlogic.coverAttrEffectVal(getWoodVal(whichUnit),value)-getWoodVal(whichUnit) , during )
endmethod
public static method setWoodVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_VAL , whichUnit , value - getWoodVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wood][during]
public static method getWoodDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WOOD_DURING , whichUnit )
endmethod
public static method addWoodDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_DURING , whichUnit , value , during )
endmethod
public static method subWoodDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_DURING , whichUnit , -value, during )
endmethod
public static method coverWoodDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_DURING , whichUnit , hlogic.coverAttrEffectVal(getWoodDuring(whichUnit),value)-getWoodDuring(whichUnit) , during )
endmethod
public static method setWoodDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_DURING , whichUnit , value - getWoodDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[thunder][val]
public static method getThunderVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_THUNDER_VAL , whichUnit )
endmethod
public static method addThunderVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_VAL , whichUnit , value , during )
endmethod
public static method subThunderVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_VAL , whichUnit , -value, during )
endmethod
public static method coverThunderVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_VAL , whichUnit , hlogic.coverAttrEffectVal(getThunderVal(whichUnit),value)-getThunderVal(whichUnit) , during )
endmethod
public static method setThunderVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_VAL , whichUnit , value - getThunderVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[thunder][during]
public static method getThunderDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_THUNDER_DURING , whichUnit )
endmethod
public static method addThunderDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_DURING , whichUnit , value , during )
endmethod
public static method subThunderDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_DURING , whichUnit , -value, during )
endmethod
public static method coverThunderDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_DURING , whichUnit , hlogic.coverAttrEffectVal(getThunderDuring(whichUnit),value)-getThunderDuring(whichUnit) , during )
endmethod
public static method setThunderDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_DURING , whichUnit , value - getThunderDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[poison][val]
public static method getPoisonVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_POISON_VAL , whichUnit )
endmethod
public static method addPoisonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_VAL , whichUnit , value , during )
endmethod
public static method subPoisonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_VAL , whichUnit , -value, during )
endmethod
public static method coverPoisonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_VAL , whichUnit , hlogic.coverAttrEffectVal(getPoisonVal(whichUnit),value)-getPoisonVal(whichUnit) , during )
endmethod
public static method setPoisonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_VAL , whichUnit , value - getPoisonVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[poison][during]
public static method getPoisonDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_POISON_DURING , whichUnit )
endmethod
public static method addPoisonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_DURING , whichUnit , value , during )
endmethod
public static method subPoisonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_DURING , whichUnit , -value, during )
endmethod
public static method coverPoisonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_DURING , whichUnit , hlogic.coverAttrEffectVal(getPoisonDuring(whichUnit),value)-getPoisonDuring(whichUnit) , during )
endmethod
public static method setPoisonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_DURING , whichUnit , value - getPoisonDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ghost][val]
public static method getGhostVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_GHOST_VAL , whichUnit )
endmethod
public static method addGhostVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_VAL , whichUnit , value , during )
endmethod
public static method subGhostVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_VAL , whichUnit , -value, during )
endmethod
public static method coverGhostVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_VAL , whichUnit , hlogic.coverAttrEffectVal(getGhostVal(whichUnit),value)-getGhostVal(whichUnit) , during )
endmethod
public static method setGhostVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_VAL , whichUnit , value - getGhostVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ghost][during]
public static method getGhostDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_GHOST_DURING , whichUnit )
endmethod
public static method addGhostDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_DURING , whichUnit , value , during )
endmethod
public static method subGhostDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_DURING , whichUnit , -value, during )
endmethod
public static method coverGhostDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_DURING , whichUnit , hlogic.coverAttrEffectVal(getGhostDuring(whichUnit),value)-getGhostDuring(whichUnit) , during )
endmethod
public static method setGhostDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_DURING , whichUnit , value - getGhostDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[metal][val]
public static method getMetalVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_METAL_VAL , whichUnit )
endmethod
public static method addMetalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_VAL , whichUnit , value , during )
endmethod
public static method subMetalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_VAL , whichUnit , -value, during )
endmethod
public static method coverMetalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_VAL , whichUnit , hlogic.coverAttrEffectVal(getMetalVal(whichUnit),value)-getMetalVal(whichUnit) , during )
endmethod
public static method setMetalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_VAL , whichUnit , value - getMetalVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[metal][during]
public static method getMetalDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_METAL_DURING , whichUnit )
endmethod
public static method addMetalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_DURING , whichUnit , value , during )
endmethod
public static method subMetalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_DURING , whichUnit , -value, during )
endmethod
public static method coverMetalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_DURING , whichUnit , hlogic.coverAttrEffectVal(getMetalDuring(whichUnit),value)-getMetalDuring(whichUnit) , during )
endmethod
public static method setMetalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_DURING , whichUnit , value - getMetalDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dragon][val]
public static method getDragonVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRAGON_VAL , whichUnit )
endmethod
public static method addDragonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_VAL , whichUnit , value , during )
endmethod
public static method subDragonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_VAL , whichUnit , -value, during )
endmethod
public static method coverDragonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_VAL , whichUnit , hlogic.coverAttrEffectVal(getDragonVal(whichUnit),value)-getDragonVal(whichUnit) , during )
endmethod
public static method setDragonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_VAL , whichUnit , value - getDragonVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dragon][during]
public static method getDragonDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRAGON_DURING , whichUnit )
endmethod
public static method addDragonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_DURING , whichUnit , value , during )
endmethod
public static method subDragonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_DURING , whichUnit , -value, during )
endmethod
public static method coverDragonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_DURING , whichUnit , hlogic.coverAttrEffectVal(getDragonDuring(whichUnit),value)-getDragonDuring(whichUnit) , during )
endmethod
public static method setDragonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_DURING , whichUnit , value - getDragonDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[fire_oppose][val]
public static method getFireOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_VAL , whichUnit )
endmethod
public static method addFireOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subFireOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverFireOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getFireOpposeVal(whichUnit),value)-getFireOpposeVal(whichUnit) , during )
endmethod
public static method setFireOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_VAL , whichUnit , value - getFireOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[fire_oppose][during]
public static method getFireOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_DURING , whichUnit )
endmethod
public static method addFireOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subFireOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverFireOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getFireOpposeDuring(whichUnit),value)-getFireOpposeDuring(whichUnit) , during )
endmethod
public static method setFireOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_OPPOSE_DURING , whichUnit , value - getFireOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[soil_oppose][val]
public static method getSoilOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_VAL , whichUnit )
endmethod
public static method addSoilOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subSoilOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverSoilOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getSoilOpposeVal(whichUnit),value)-getSoilOpposeVal(whichUnit) , during )
endmethod
public static method setSoilOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_VAL , whichUnit , value - getSoilOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[soil_oppose][during]
public static method getSoilOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_DURING , whichUnit )
endmethod
public static method addSoilOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subSoilOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverSoilOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getSoilOpposeDuring(whichUnit),value)-getSoilOpposeDuring(whichUnit) , during )
endmethod
public static method setSoilOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SOIL_OPPOSE_DURING , whichUnit , value - getSoilOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[water_oppose][val]
public static method getWaterOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_VAL , whichUnit )
endmethod
public static method addWaterOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subWaterOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverWaterOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getWaterOpposeVal(whichUnit),value)-getWaterOpposeVal(whichUnit) , during )
endmethod
public static method setWaterOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_VAL , whichUnit , value - getWaterOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[water_oppose][during]
public static method getWaterOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_DURING , whichUnit )
endmethod
public static method addWaterOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subWaterOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverWaterOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getWaterOpposeDuring(whichUnit),value)-getWaterOpposeDuring(whichUnit) , during )
endmethod
public static method setWaterOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WATER_OPPOSE_DURING , whichUnit , value - getWaterOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ice_oppose][val]
public static method getIceOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_VAL , whichUnit )
endmethod
public static method addIceOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subIceOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverIceOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getIceOpposeVal(whichUnit),value)-getIceOpposeVal(whichUnit) , during )
endmethod
public static method setIceOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_VAL , whichUnit , value - getIceOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ice_oppose][during]
public static method getIceOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_DURING , whichUnit )
endmethod
public static method addIceOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subIceOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverIceOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getIceOpposeDuring(whichUnit),value)-getIceOpposeDuring(whichUnit) , during )
endmethod
public static method setIceOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ICE_OPPOSE_DURING , whichUnit , value - getIceOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wind_oppose][val]
public static method getWindOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_VAL , whichUnit )
endmethod
public static method addWindOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subWindOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverWindOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getWindOpposeVal(whichUnit),value)-getWindOpposeVal(whichUnit) , during )
endmethod
public static method setWindOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_VAL , whichUnit , value - getWindOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wind_oppose][during]
public static method getWindOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_DURING , whichUnit )
endmethod
public static method addWindOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subWindOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverWindOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getWindOpposeDuring(whichUnit),value)-getWindOpposeDuring(whichUnit) , during )
endmethod
public static method setWindOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WIND_OPPOSE_DURING , whichUnit , value - getWindOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[light_oppose][val]
public static method getLightOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_VAL , whichUnit )
endmethod
public static method addLightOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subLightOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverLightOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getLightOpposeVal(whichUnit),value)-getLightOpposeVal(whichUnit) , during )
endmethod
public static method setLightOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_VAL , whichUnit , value - getLightOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[light_oppose][during]
public static method getLightOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_DURING , whichUnit )
endmethod
public static method addLightOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subLightOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverLightOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getLightOpposeDuring(whichUnit),value)-getLightOpposeDuring(whichUnit) , during )
endmethod
public static method setLightOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHT_OPPOSE_DURING , whichUnit , value - getLightOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dark_oppose][val]
public static method getDarkOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_VAL , whichUnit )
endmethod
public static method addDarkOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subDarkOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverDarkOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getDarkOpposeVal(whichUnit),value)-getDarkOpposeVal(whichUnit) , during )
endmethod
public static method setDarkOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_VAL , whichUnit , value - getDarkOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dark_oppose][during]
public static method getDarkOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_DURING , whichUnit )
endmethod
public static method addDarkOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subDarkOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverDarkOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getDarkOpposeDuring(whichUnit),value)-getDarkOpposeDuring(whichUnit) , during )
endmethod
public static method setDarkOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DARK_OPPOSE_DURING , whichUnit , value - getDarkOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wood_oppose][val]
public static method getWoodOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_VAL , whichUnit )
endmethod
public static method addWoodOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subWoodOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverWoodOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getWoodOpposeVal(whichUnit),value)-getWoodOpposeVal(whichUnit) , during )
endmethod
public static method setWoodOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_VAL , whichUnit , value - getWoodOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[wood_oppose][during]
public static method getWoodOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_DURING , whichUnit )
endmethod
public static method addWoodOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subWoodOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverWoodOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getWoodOpposeDuring(whichUnit),value)-getWoodOpposeDuring(whichUnit) , during )
endmethod
public static method setWoodOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WOOD_OPPOSE_DURING , whichUnit , value - getWoodOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[thunder_oppose][val]
public static method getThunderOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_VAL , whichUnit )
endmethod
public static method addThunderOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subThunderOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverThunderOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getThunderOpposeVal(whichUnit),value)-getThunderOpposeVal(whichUnit) , during )
endmethod
public static method setThunderOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_VAL , whichUnit , value - getThunderOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[thunder_oppose][during]
public static method getThunderOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_DURING , whichUnit )
endmethod
public static method addThunderOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subThunderOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverThunderOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getThunderOpposeDuring(whichUnit),value)-getThunderOpposeDuring(whichUnit) , during )
endmethod
public static method setThunderOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_THUNDER_OPPOSE_DURING , whichUnit , value - getThunderOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[poison_oppose][val]
public static method getPoisonOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_VAL , whichUnit )
endmethod
public static method addPoisonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subPoisonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverPoisonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getPoisonOpposeVal(whichUnit),value)-getPoisonOpposeVal(whichUnit) , during )
endmethod
public static method setPoisonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_VAL , whichUnit , value - getPoisonOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[poison_oppose][during]
public static method getPoisonOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_DURING , whichUnit )
endmethod
public static method addPoisonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subPoisonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverPoisonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getPoisonOpposeDuring(whichUnit),value)-getPoisonOpposeDuring(whichUnit) , during )
endmethod
public static method setPoisonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_OPPOSE_DURING , whichUnit , value - getPoisonOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ghost_oppose][val]
public static method getGhostOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_VAL , whichUnit )
endmethod
public static method addGhostOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subGhostOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverGhostOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getGhostOpposeVal(whichUnit),value)-getGhostOpposeVal(whichUnit) , during )
endmethod
public static method setGhostOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_VAL , whichUnit , value - getGhostOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[ghost_oppose][during]
public static method getGhostOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_DURING , whichUnit )
endmethod
public static method addGhostOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subGhostOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverGhostOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getGhostOpposeDuring(whichUnit),value)-getGhostOpposeDuring(whichUnit) , during )
endmethod
public static method setGhostOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_GHOST_OPPOSE_DURING , whichUnit , value - getGhostOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[metal_oppose][val]
public static method getMetalOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_VAL , whichUnit )
endmethod
public static method addMetalOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subMetalOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverMetalOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getMetalOpposeVal(whichUnit),value)-getMetalOpposeVal(whichUnit) , during )
endmethod
public static method setMetalOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_VAL , whichUnit , value - getMetalOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[metal_oppose][during]
public static method getMetalOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_DURING , whichUnit )
endmethod
public static method addMetalOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subMetalOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverMetalOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getMetalOpposeDuring(whichUnit),value)-getMetalOpposeDuring(whichUnit) , during )
endmethod
public static method setMetalOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_METAL_OPPOSE_DURING , whichUnit , value - getMetalOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dragon_oppose][val]
public static method getDragonOpposeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_VAL , whichUnit )
endmethod
public static method addDragonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_VAL , whichUnit , value , during )
endmethod
public static method subDragonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_VAL , whichUnit , -value, during )
endmethod
public static method coverDragonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_VAL , whichUnit , hlogic.coverAttrEffectVal(getDragonOpposeVal(whichUnit),value)-getDragonOpposeVal(whichUnit) , during )
endmethod
public static method setDragonOpposeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_VAL , whichUnit , value - getDragonOpposeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dragon_oppose][during]
public static method getDragonOpposeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_DURING , whichUnit )
endmethod
public static method addDragonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_DURING , whichUnit , value , during )
endmethod
public static method subDragonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_DURING , whichUnit , -value, during )
endmethod
public static method coverDragonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_DURING , whichUnit , hlogic.coverAttrEffectVal(getDragonOpposeDuring(whichUnit),value)-getDragonOpposeDuring(whichUnit) , during )
endmethod
public static method setDragonOpposeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRAGON_OPPOSE_DURING , whichUnit , value - getDragonOpposeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[toxic][val]
public static method getToxicVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_TOXIC_VAL , whichUnit )
endmethod
public static method addToxicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_VAL , whichUnit , value , during )
endmethod
public static method subToxicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_VAL , whichUnit , -value, during )
endmethod
public static method coverToxicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_VAL , whichUnit , hlogic.coverAttrEffectVal(getToxicVal(whichUnit),value)-getToxicVal(whichUnit) , during )
endmethod
public static method setToxicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_VAL , whichUnit , value - getToxicVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[toxic][during]
public static method getToxicDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_TOXIC_DURING , whichUnit )
endmethod
public static method addToxicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_DURING , whichUnit , value , during )
endmethod
public static method subToxicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_DURING , whichUnit , -value, during )
endmethod
public static method coverToxicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_DURING , whichUnit , hlogic.coverAttrEffectVal(getToxicDuring(whichUnit),value)-getToxicDuring(whichUnit) , during )
endmethod
public static method setToxicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TOXIC_DURING , whichUnit , value - getToxicDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[burn][val]
public static method getBurnVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BURN_VAL , whichUnit )
endmethod
public static method addBurnVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_VAL , whichUnit , value , during )
endmethod
public static method subBurnVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_VAL , whichUnit , -value, during )
endmethod
public static method coverBurnVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_VAL , whichUnit , hlogic.coverAttrEffectVal(getBurnVal(whichUnit),value)-getBurnVal(whichUnit) , during )
endmethod
public static method setBurnVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_VAL , whichUnit , value - getBurnVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[burn][during]
public static method getBurnDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BURN_DURING , whichUnit )
endmethod
public static method addBurnDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_DURING , whichUnit , value , during )
endmethod
public static method subBurnDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_DURING , whichUnit , -value, during )
endmethod
public static method coverBurnDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_DURING , whichUnit , hlogic.coverAttrEffectVal(getBurnDuring(whichUnit),value)-getBurnDuring(whichUnit) , during )
endmethod
public static method setBurnDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BURN_DURING , whichUnit , value - getBurnDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dry][val]
public static method getDryVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRY_VAL , whichUnit )
endmethod
public static method addDryVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_VAL , whichUnit , value , during )
endmethod
public static method subDryVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_VAL , whichUnit , -value, during )
endmethod
public static method coverDryVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_VAL , whichUnit , hlogic.coverAttrEffectVal(getDryVal(whichUnit),value)-getDryVal(whichUnit) , during )
endmethod
public static method setDryVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_VAL , whichUnit , value - getDryVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dry][during]
public static method getDryDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRY_DURING , whichUnit )
endmethod
public static method addDryDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_DURING , whichUnit , value , during )
endmethod
public static method subDryDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_DURING , whichUnit , -value, during )
endmethod
public static method coverDryDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_DURING , whichUnit , hlogic.coverAttrEffectVal(getDryDuring(whichUnit),value)-getDryDuring(whichUnit) , during )
endmethod
public static method setDryDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_DURING , whichUnit , value - getDryDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[freeze][val]
public static method getFreezeVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FREEZE_VAL , whichUnit )
endmethod
public static method addFreezeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_VAL , whichUnit , value , during )
endmethod
public static method subFreezeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_VAL , whichUnit , -value, during )
endmethod
public static method coverFreezeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_VAL , whichUnit , hlogic.coverAttrEffectVal(getFreezeVal(whichUnit),value)-getFreezeVal(whichUnit) , during )
endmethod
public static method setFreezeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_VAL , whichUnit , value - getFreezeVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[freeze][during]
public static method getFreezeDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FREEZE_DURING , whichUnit )
endmethod
public static method addFreezeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_DURING , whichUnit , value , during )
endmethod
public static method subFreezeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_DURING , whichUnit , -value, during )
endmethod
public static method coverFreezeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_DURING , whichUnit , hlogic.coverAttrEffectVal(getFreezeDuring(whichUnit),value)-getFreezeDuring(whichUnit) , during )
endmethod
public static method setFreezeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_DURING , whichUnit , value - getFreezeDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[cold][val]
public static method getColdVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_COLD_VAL , whichUnit )
endmethod
public static method addColdVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_VAL , whichUnit , value , during )
endmethod
public static method subColdVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_VAL , whichUnit , -value, during )
endmethod
public static method coverColdVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_VAL , whichUnit , hlogic.coverAttrEffectVal(getColdVal(whichUnit),value)-getColdVal(whichUnit) , during )
endmethod
public static method setColdVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_VAL , whichUnit , value - getColdVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[cold][during]
public static method getColdDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_COLD_DURING , whichUnit )
endmethod
public static method addColdDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_DURING , whichUnit , value , during )
endmethod
public static method subColdDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_DURING , whichUnit , -value, during )
endmethod
public static method coverColdDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_DURING , whichUnit , hlogic.coverAttrEffectVal(getColdDuring(whichUnit),value)-getColdDuring(whichUnit) , during )
endmethod
public static method setColdDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_DURING , whichUnit , value - getColdDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[blunt][val]
public static method getBluntVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BLUNT_VAL , whichUnit )
endmethod
public static method addBluntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_VAL , whichUnit , value , during )
endmethod
public static method subBluntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_VAL , whichUnit , -value, during )
endmethod
public static method coverBluntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_VAL , whichUnit , hlogic.coverAttrEffectVal(getBluntVal(whichUnit),value)-getBluntVal(whichUnit) , during )
endmethod
public static method setBluntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_VAL , whichUnit , value - getBluntVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[blunt][during]
public static method getBluntDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BLUNT_DURING , whichUnit )
endmethod
public static method addBluntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_DURING , whichUnit , value , during )
endmethod
public static method subBluntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_DURING , whichUnit , -value, during )
endmethod
public static method coverBluntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_DURING , whichUnit , hlogic.coverAttrEffectVal(getBluntDuring(whichUnit),value)-getBluntDuring(whichUnit) , during )
endmethod
public static method setBluntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_DURING , whichUnit , value - getBluntDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[muggle][val]
public static method getMuggleVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MUGGLE_VAL , whichUnit )
endmethod
public static method addMuggleVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_VAL , whichUnit , value , during )
endmethod
public static method subMuggleVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_VAL , whichUnit , -value, during )
endmethod
public static method coverMuggleVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_VAL , whichUnit , hlogic.coverAttrEffectVal(getMuggleVal(whichUnit),value)-getMuggleVal(whichUnit) , during )
endmethod
public static method setMuggleVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_VAL , whichUnit , value - getMuggleVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[muggle][during]
public static method getMuggleDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MUGGLE_DURING , whichUnit )
endmethod
public static method addMuggleDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_DURING , whichUnit , value , during )
endmethod
public static method subMuggleDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_DURING , whichUnit , -value, during )
endmethod
public static method coverMuggleDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_DURING , whichUnit , hlogic.coverAttrEffectVal(getMuggleDuring(whichUnit),value)-getMuggleDuring(whichUnit) , during )
endmethod
public static method setMuggleDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_DURING , whichUnit , value - getMuggleDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[myopia][val]
public static method getMyopiaVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MYOPIA_VAL , whichUnit )
endmethod
public static method addMyopiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_VAL , whichUnit , value , during )
endmethod
public static method subMyopiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_VAL , whichUnit , -value, during )
endmethod
public static method coverMyopiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_VAL , whichUnit , hlogic.coverAttrEffectVal(getMyopiaVal(whichUnit),value)-getMyopiaVal(whichUnit) , during )
endmethod
public static method setMyopiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_VAL , whichUnit , value - getMyopiaVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[myopia][during]
public static method getMyopiaDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_MYOPIA_DURING , whichUnit )
endmethod
public static method addMyopiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_DURING , whichUnit , value , during )
endmethod
public static method subMyopiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_DURING , whichUnit , -value, during )
endmethod
public static method coverMyopiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_DURING , whichUnit , hlogic.coverAttrEffectVal(getMyopiaDuring(whichUnit),value)-getMyopiaDuring(whichUnit) , during )
endmethod
public static method setMyopiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MYOPIA_DURING , whichUnit , value - getMyopiaDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[blind][val]
public static method getBlindVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BLIND_VAL , whichUnit )
endmethod
public static method addBlindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_VAL , whichUnit , value , during )
endmethod
public static method subBlindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_VAL , whichUnit , -value, during )
endmethod
public static method coverBlindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_VAL , whichUnit , hlogic.coverAttrEffectVal(getBlindVal(whichUnit),value)-getBlindVal(whichUnit) , during )
endmethod
public static method setBlindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_VAL , whichUnit , value - getBlindVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[blind][during]
public static method getBlindDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BLIND_DURING , whichUnit )
endmethod
public static method addBlindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_DURING , whichUnit , value , during )
endmethod
public static method subBlindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_DURING , whichUnit , -value, during )
endmethod
public static method coverBlindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_DURING , whichUnit , hlogic.coverAttrEffectVal(getBlindDuring(whichUnit),value)-getBlindDuring(whichUnit) , during )
endmethod
public static method setBlindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_DURING , whichUnit , value - getBlindDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[corrosion][val]
public static method getCorrosionVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CORROSION_VAL , whichUnit )
endmethod
public static method addCorrosionVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_VAL , whichUnit , value , during )
endmethod
public static method subCorrosionVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_VAL , whichUnit , -value, during )
endmethod
public static method coverCorrosionVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_VAL , whichUnit , hlogic.coverAttrEffectVal(getCorrosionVal(whichUnit),value)-getCorrosionVal(whichUnit) , during )
endmethod
public static method setCorrosionVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_VAL , whichUnit , value - getCorrosionVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[corrosion][during]
public static method getCorrosionDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CORROSION_DURING , whichUnit )
endmethod
public static method addCorrosionDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_DURING , whichUnit , value , during )
endmethod
public static method subCorrosionDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_DURING , whichUnit , -value, during )
endmethod
public static method coverCorrosionDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_DURING , whichUnit , hlogic.coverAttrEffectVal(getCorrosionDuring(whichUnit),value)-getCorrosionDuring(whichUnit) , during )
endmethod
public static method setCorrosionDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_DURING , whichUnit , value - getCorrosionDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[chaos][val]
public static method getChaosVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CHAOS_VAL , whichUnit )
endmethod
public static method addChaosVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_VAL , whichUnit , value , during )
endmethod
public static method subChaosVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_VAL , whichUnit , -value, during )
endmethod
public static method coverChaosVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_VAL , whichUnit , hlogic.coverAttrEffectVal(getChaosVal(whichUnit),value)-getChaosVal(whichUnit) , during )
endmethod
public static method setChaosVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_VAL , whichUnit , value - getChaosVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[chaos][during]
public static method getChaosDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CHAOS_DURING , whichUnit )
endmethod
public static method addChaosDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_DURING , whichUnit , value , during )
endmethod
public static method subChaosDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_DURING , whichUnit , -value, during )
endmethod
public static method coverChaosDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_DURING , whichUnit , hlogic.coverAttrEffectVal(getChaosDuring(whichUnit),value)-getChaosDuring(whichUnit) , during )
endmethod
public static method setChaosDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_DURING , whichUnit , value - getChaosDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[twine][val]
public static method getTwineVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_TWINE_VAL , whichUnit )
endmethod
public static method addTwineVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_VAL , whichUnit , value , during )
endmethod
public static method subTwineVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_VAL , whichUnit , -value, during )
endmethod
public static method coverTwineVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_VAL , whichUnit , hlogic.coverAttrEffectVal(getTwineVal(whichUnit),value)-getTwineVal(whichUnit) , during )
endmethod
public static method setTwineVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_VAL , whichUnit , value - getTwineVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[twine][during]
public static method getTwineDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_TWINE_DURING , whichUnit )
endmethod
public static method addTwineDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_DURING , whichUnit , value , during )
endmethod
public static method subTwineDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_DURING , whichUnit , -value, during )
endmethod
public static method coverTwineDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_DURING , whichUnit , hlogic.coverAttrEffectVal(getTwineDuring(whichUnit),value)-getTwineDuring(whichUnit) , during )
endmethod
public static method setTwineDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_DURING , whichUnit , value - getTwineDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[drunk][val]
public static method getDrunkVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRUNK_VAL , whichUnit )
endmethod
public static method addDrunkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_VAL , whichUnit , value , during )
endmethod
public static method subDrunkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_VAL , whichUnit , -value, during )
endmethod
public static method coverDrunkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_VAL , whichUnit , hlogic.coverAttrEffectVal(getDrunkVal(whichUnit),value)-getDrunkVal(whichUnit) , during )
endmethod
public static method setDrunkVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_VAL , whichUnit , value - getDrunkVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[drunk][during]
public static method getDrunkDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DRUNK_DURING , whichUnit )
endmethod
public static method addDrunkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_DURING , whichUnit , value , during )
endmethod
public static method subDrunkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_DURING , whichUnit , -value, during )
endmethod
public static method coverDrunkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_DURING , whichUnit , hlogic.coverAttrEffectVal(getDrunkDuring(whichUnit),value)-getDrunkDuring(whichUnit) , during )
endmethod
public static method setDrunkDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRUNK_DURING , whichUnit , value - getDrunkDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[tortua][val]
public static method getTortuaVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_TORTUA_VAL , whichUnit )
endmethod
public static method addTortuaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_VAL , whichUnit , value , during )
endmethod
public static method subTortuaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_VAL , whichUnit , -value, during )
endmethod
public static method coverTortuaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_VAL , whichUnit , hlogic.coverAttrEffectVal(getTortuaVal(whichUnit),value)-getTortuaVal(whichUnit) , during )
endmethod
public static method setTortuaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_VAL , whichUnit , value - getTortuaVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[tortua][during]
public static method getTortuaDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_TORTUA_DURING , whichUnit )
endmethod
public static method addTortuaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_DURING , whichUnit , value , during )
endmethod
public static method subTortuaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_DURING , whichUnit , -value, during )
endmethod
public static method coverTortuaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_DURING , whichUnit , hlogic.coverAttrEffectVal(getTortuaDuring(whichUnit),value)-getTortuaDuring(whichUnit) , during )
endmethod
public static method setTortuaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_DURING , whichUnit , value - getTortuaDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[weak][val]
public static method getWeakVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WEAK_VAL , whichUnit )
endmethod
public static method addWeakVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_VAL , whichUnit , value , during )
endmethod
public static method subWeakVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_VAL , whichUnit , -value, during )
endmethod
public static method coverWeakVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_VAL , whichUnit , hlogic.coverAttrEffectVal(getWeakVal(whichUnit),value)-getWeakVal(whichUnit) , during )
endmethod
public static method setWeakVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_VAL , whichUnit , value - getWeakVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[weak][during]
public static method getWeakDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_WEAK_DURING , whichUnit )
endmethod
public static method addWeakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_DURING , whichUnit , value , during )
endmethod
public static method subWeakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_DURING , whichUnit , -value, during )
endmethod
public static method coverWeakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_DURING , whichUnit , hlogic.coverAttrEffectVal(getWeakDuring(whichUnit),value)-getWeakDuring(whichUnit) , during )
endmethod
public static method setWeakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_DURING , whichUnit , value - getWeakDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[astrict][val]
public static method getAstrictVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ASTRICT_VAL , whichUnit )
endmethod
public static method addAstrictVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_VAL , whichUnit , value , during )
endmethod
public static method subAstrictVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_VAL , whichUnit , -value, during )
endmethod
public static method coverAstrictVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_VAL , whichUnit , hlogic.coverAttrEffectVal(getAstrictVal(whichUnit),value)-getAstrictVal(whichUnit) , during )
endmethod
public static method setAstrictVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_VAL , whichUnit , value - getAstrictVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[astrict][during]
public static method getAstrictDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_ASTRICT_DURING , whichUnit )
endmethod
public static method addAstrictDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_DURING , whichUnit , value , during )
endmethod
public static method subAstrictDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_DURING , whichUnit , -value, during )
endmethod
public static method coverAstrictDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_DURING , whichUnit , hlogic.coverAttrEffectVal(getAstrictDuring(whichUnit),value)-getAstrictDuring(whichUnit) , during )
endmethod
public static method setAstrictDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_DURING , whichUnit , value - getAstrictDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[foolish][val]
public static method getFoolishVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FOOLISH_VAL , whichUnit )
endmethod
public static method addFoolishVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_VAL , whichUnit , value , during )
endmethod
public static method subFoolishVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_VAL , whichUnit , -value, during )
endmethod
public static method coverFoolishVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_VAL , whichUnit , hlogic.coverAttrEffectVal(getFoolishVal(whichUnit),value)-getFoolishVal(whichUnit) , during )
endmethod
public static method setFoolishVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_VAL , whichUnit , value - getFoolishVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[foolish][during]
public static method getFoolishDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FOOLISH_DURING , whichUnit )
endmethod
public static method addFoolishDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_DURING , whichUnit , value , during )
endmethod
public static method subFoolishDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_DURING , whichUnit , -value, during )
endmethod
public static method coverFoolishDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_DURING , whichUnit , hlogic.coverAttrEffectVal(getFoolishDuring(whichUnit),value)-getFoolishDuring(whichUnit) , during )
endmethod
public static method setFoolishDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_DURING , whichUnit , value - getFoolishDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dull][val]
public static method getDullVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DULL_VAL , whichUnit )
endmethod
public static method addDullVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_VAL , whichUnit , value , during )
endmethod
public static method subDullVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_VAL , whichUnit , -value, during )
endmethod
public static method coverDullVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_VAL , whichUnit , hlogic.coverAttrEffectVal(getDullVal(whichUnit),value)-getDullVal(whichUnit) , during )
endmethod
public static method setDullVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_VAL , whichUnit , value - getDullVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dull][during]
public static method getDullDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DULL_DURING , whichUnit )
endmethod
public static method addDullDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_DURING , whichUnit , value , during )
endmethod
public static method subDullDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_DURING , whichUnit , -value, during )
endmethod
public static method coverDullDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_DURING , whichUnit , hlogic.coverAttrEffectVal(getDullDuring(whichUnit),value)-getDullDuring(whichUnit) , during )
endmethod
public static method setDullDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_DURING , whichUnit , value - getDullDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dirt][val]
public static method getDirtVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DIRT_VAL , whichUnit )
endmethod
public static method addDirtVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_VAL , whichUnit , value , during )
endmethod
public static method subDirtVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_VAL , whichUnit , -value, during )
endmethod
public static method coverDirtVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_VAL , whichUnit , hlogic.coverAttrEffectVal(getDirtVal(whichUnit),value)-getDirtVal(whichUnit) , during )
endmethod
public static method setDirtVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_VAL , whichUnit , value - getDirtVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[dirt][during]
public static method getDirtDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_DIRT_DURING , whichUnit )
endmethod
public static method addDirtDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_DURING , whichUnit , value , during )
endmethod
public static method subDirtDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_DURING , whichUnit , -value, during )
endmethod
public static method coverDirtDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_DURING , whichUnit , hlogic.coverAttrEffectVal(getDirtDuring(whichUnit),value)-getDirtDuring(whichUnit) , during )
endmethod
public static method setDirtDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_DURING , whichUnit , value - getDirtDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[swim][odds]
public static method getSwimOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SWIM_ODDS , whichUnit )
endmethod
public static method addSwimOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_ODDS , whichUnit , value , during )
endmethod
public static method subSwimOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_ODDS , whichUnit , -value, during )
endmethod
public static method coverSwimOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_ODDS , whichUnit , hlogic.coverAttrEffectVal(getSwimOdds(whichUnit),value)-getSwimOdds(whichUnit) , during )
endmethod
public static method setSwimOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_ODDS , whichUnit , value - getSwimOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[swim][during]
public static method getSwimDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SWIM_DURING , whichUnit )
endmethod
public static method addSwimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_DURING , whichUnit , value , during )
endmethod
public static method subSwimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_DURING , whichUnit , -value, during )
endmethod
public static method coverSwimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_DURING , whichUnit , hlogic.coverAttrEffectVal(getSwimDuring(whichUnit),value)-getSwimDuring(whichUnit) , during )
endmethod
public static method setSwimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_DURING , whichUnit , value - getSwimDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[heavy][odds]
public static method getHeavyOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HEAVY_ODDS , whichUnit )
endmethod
public static method addHeavyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_ODDS , whichUnit , value , during )
endmethod
public static method subHeavyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_ODDS , whichUnit , -value, during )
endmethod
public static method coverHeavyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_ODDS , whichUnit , hlogic.coverAttrEffectVal(getHeavyOdds(whichUnit),value)-getHeavyOdds(whichUnit) , during )
endmethod
public static method setHeavyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_ODDS , whichUnit , value - getHeavyOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[heavy][val]
public static method getHeavyVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_HEAVY_VAL , whichUnit )
endmethod
public static method addHeavyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_VAL , whichUnit , value , during )
endmethod
public static method subHeavyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_VAL , whichUnit , -value, during )
endmethod
public static method coverHeavyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_VAL , whichUnit , hlogic.coverAttrEffectVal(getHeavyVal(whichUnit),value)-getHeavyVal(whichUnit) , during )
endmethod
public static method setHeavyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_VAL , whichUnit , value - getHeavyVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[break][odds]
public static method getBreakOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BREAK_ODDS , whichUnit )
endmethod
public static method addBreakOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_ODDS , whichUnit , value , during )
endmethod
public static method subBreakOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_ODDS , whichUnit , -value, during )
endmethod
public static method coverBreakOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_ODDS , whichUnit , hlogic.coverAttrEffectVal(getBreakOdds(whichUnit),value)-getBreakOdds(whichUnit) , during )
endmethod
public static method setBreakOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_ODDS , whichUnit , value - getBreakOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[break][during]
public static method getBreakDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BREAK_DURING , whichUnit )
endmethod
public static method addBreakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_DURING , whichUnit , value , during )
endmethod
public static method subBreakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_DURING , whichUnit , -value, during )
endmethod
public static method coverBreakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_DURING , whichUnit , hlogic.coverAttrEffectVal(getBreakDuring(whichUnit),value)-getBreakDuring(whichUnit) , during )
endmethod
public static method setBreakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_DURING , whichUnit , value - getBreakDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[unluck][val]
public static method getUnluckVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_UNLUCK_VAL , whichUnit )
endmethod
public static method addUnluckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_VAL , whichUnit , value , during )
endmethod
public static method subUnluckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_VAL , whichUnit , -value, during )
endmethod
public static method coverUnluckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_VAL , whichUnit , hlogic.coverAttrEffectVal(getUnluckVal(whichUnit),value)-getUnluckVal(whichUnit) , during )
endmethod
public static method setUnluckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_VAL , whichUnit , value - getUnluckVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[unluck][during]
public static method getUnluckDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_UNLUCK_DURING , whichUnit )
endmethod
public static method addUnluckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_DURING , whichUnit , value , during )
endmethod
public static method subUnluckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_DURING , whichUnit , -value, during )
endmethod
public static method coverUnluckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_DURING , whichUnit , hlogic.coverAttrEffectVal(getUnluckDuring(whichUnit),value)-getUnluckDuring(whichUnit) , during )
endmethod
public static method setUnluckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_DURING , whichUnit , value - getUnluckDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[silent][odds]
public static method getSilentOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SILENT_ODDS , whichUnit )
endmethod
public static method addSilentOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_ODDS , whichUnit , value , during )
endmethod
public static method subSilentOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_ODDS , whichUnit , -value, during )
endmethod
public static method coverSilentOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_ODDS , whichUnit , hlogic.coverAttrEffectVal(getSilentOdds(whichUnit),value)-getSilentOdds(whichUnit) , during )
endmethod
public static method setSilentOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_ODDS , whichUnit , value - getSilentOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[silent][during]
public static method getSilentDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_SILENT_DURING , whichUnit )
endmethod
public static method addSilentDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_DURING , whichUnit , value , during )
endmethod
public static method subSilentDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_DURING , whichUnit , -value, during )
endmethod
public static method coverSilentDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_DURING , whichUnit , hlogic.coverAttrEffectVal(getSilentDuring(whichUnit),value)-getSilentDuring(whichUnit) , during )
endmethod
public static method setSilentDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_DURING , whichUnit , value - getSilentDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[unarm][odds]
public static method getUnarmOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_UNARM_ODDS , whichUnit )
endmethod
public static method addUnarmOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_ODDS , whichUnit , value , during )
endmethod
public static method subUnarmOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_ODDS , whichUnit , -value, during )
endmethod
public static method coverUnarmOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_ODDS , whichUnit , hlogic.coverAttrEffectVal(getUnarmOdds(whichUnit),value)-getUnarmOdds(whichUnit) , during )
endmethod
public static method setUnarmOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_ODDS , whichUnit , value - getUnarmOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[unarm][during]
public static method getUnarmDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_UNARM_DURING , whichUnit )
endmethod
public static method addUnarmDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_DURING , whichUnit , value , during )
endmethod
public static method subUnarmDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_DURING , whichUnit , -value, during )
endmethod
public static method coverUnarmDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_DURING , whichUnit , hlogic.coverAttrEffectVal(getUnarmDuring(whichUnit),value)-getUnarmDuring(whichUnit) , during )
endmethod
public static method setUnarmDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_DURING , whichUnit , value - getUnarmDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[fetter][odds]
public static method getFetterOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FETTER_ODDS , whichUnit )
endmethod
public static method addFetterOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_ODDS , whichUnit , value , during )
endmethod
public static method subFetterOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_ODDS , whichUnit , -value, during )
endmethod
public static method coverFetterOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_ODDS , whichUnit , hlogic.coverAttrEffectVal(getFetterOdds(whichUnit),value)-getFetterOdds(whichUnit) , during )
endmethod
public static method setFetterOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_ODDS , whichUnit , value - getFetterOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[fetter][during]
public static method getFetterDuring takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_FETTER_DURING , whichUnit )
endmethod
public static method addFetterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_DURING , whichUnit , value , during )
endmethod
public static method subFetterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_DURING , whichUnit , -value, during )
endmethod
public static method coverFetterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_DURING , whichUnit , hlogic.coverAttrEffectVal(getFetterDuring(whichUnit),value)-getFetterDuring(whichUnit) , during )
endmethod
public static method setFetterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_DURING , whichUnit , value - getFetterDuring(whichUnit) , during )
endmethod
 // 攻击|伤害特效[bomb][val]
public static method getBombVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BOMB_VAL , whichUnit )
endmethod
public static method addBombVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_VAL , whichUnit , value , during )
endmethod
public static method subBombVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_VAL , whichUnit , -value, during )
endmethod
public static method coverBombVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_VAL , whichUnit , hlogic.coverAttrEffectVal(getBombVal(whichUnit),value)-getBombVal(whichUnit) , during )
endmethod
public static method setBombVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_VAL , whichUnit , value - getBombVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[bomb][odds]
public static method getBombOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BOMB_ODDS , whichUnit )
endmethod
public static method addBombOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_ODDS , whichUnit , value , during )
endmethod
public static method subBombOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_ODDS , whichUnit , -value, during )
endmethod
public static method coverBombOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_ODDS , whichUnit , hlogic.coverAttrEffectVal(getBombOdds(whichUnit),value)-getBombOdds(whichUnit) , during )
endmethod
public static method setBombOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_ODDS , whichUnit , value - getBombOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[bomb][range]
public static method getBombRange takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_BOMB_RANGE , whichUnit )
endmethod
public static method addBombRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_RANGE , whichUnit , value , during )
endmethod
public static method subBombRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_RANGE , whichUnit , -value, during )
endmethod
public static method coverBombRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_RANGE , whichUnit , hlogic.coverAttrEffectVal(getBombRange(whichUnit),value)-getBombRange(whichUnit) , during )
endmethod
public static method setBombRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_RANGE , whichUnit , value - getBombRange(whichUnit) , during )
endmethod
 // 攻击|伤害特效[bomb][model]
public static method getBombModel takes unit whichUnit returns string
   return LoadStr( hash_attr_effect , GetHandleId(whichUnit) , ATTR_FLAG_EFFECT_BOMB_MODEL )
endmethod
public static method setBombModel takes unit whichUnit , string value returns nothing
   call SaveStr( hash_attr_effect , GetHandleId(whichUnit) , ATTR_FLAG_EFFECT_BOMB_MODEL , value )
endmethod
 // 攻击|伤害特效[lightning_chain][val]
public static method getLightningChainVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , whichUnit )
endmethod
public static method addLightningChainVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , whichUnit , value , during )
endmethod
public static method subLightningChainVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , whichUnit , -value, during )
endmethod
public static method coverLightningChainVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , whichUnit , hlogic.coverAttrEffectVal(getLightningChainVal(whichUnit),value)-getLightningChainVal(whichUnit) , during )
endmethod
public static method setLightningChainVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , whichUnit , value - getLightningChainVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[lightning_chain][odds]
public static method getLightningChainOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , whichUnit )
endmethod
public static method addLightningChainOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , whichUnit , value , during )
endmethod
public static method subLightningChainOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , whichUnit , -value, during )
endmethod
public static method coverLightningChainOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , whichUnit , hlogic.coverAttrEffectVal(getLightningChainOdds(whichUnit),value)-getLightningChainOdds(whichUnit) , during )
endmethod
public static method setLightningChainOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , whichUnit , value - getLightningChainOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[lightning_chain][qty]
public static method getLightningChainQty takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , whichUnit )
endmethod
public static method addLightningChainQty takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , whichUnit , value , during )
endmethod
public static method subLightningChainQty takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , whichUnit , -value, during )
endmethod
public static method coverLightningChainQty takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , whichUnit , hlogic.coverAttrEffectVal(getLightningChainQty(whichUnit),value)-getLightningChainQty(whichUnit) , during )
endmethod
public static method setLightningChainQty takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , whichUnit , value - getLightningChainQty(whichUnit) , during )
endmethod
 // 攻击|伤害特效[lightning_chain][reduce]
public static method getLightningChainReduce takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , whichUnit )
endmethod
public static method addLightningChainReduce takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , whichUnit , value , during )
endmethod
public static method subLightningChainReduce takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , whichUnit , -value, during )
endmethod
public static method coverLightningChainReduce takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , whichUnit , hlogic.coverAttrEffectVal(getLightningChainReduce(whichUnit),value)-getLightningChainReduce(whichUnit) , during )
endmethod
public static method setLightningChainReduce takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , whichUnit , value - getLightningChainReduce(whichUnit) , during )
endmethod
 // 攻击|伤害特效[lightning_chain][model]
public static method getLightningChainModel takes unit whichUnit returns string
   return LoadStr( hash_attr_effect , GetHandleId(whichUnit) , ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_MODEL )
endmethod
public static method setLightningChainModel takes unit whichUnit , string value returns nothing
   call SaveStr( hash_attr_effect , GetHandleId(whichUnit) , ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_MODEL , value )
endmethod
 // 攻击|伤害特效[crack_fly][val]
public static method getCrackFlyVal takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CRACK_FLY_VAL , whichUnit )
endmethod
public static method addCrackFlyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_VAL , whichUnit , value , during )
endmethod
public static method subCrackFlyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_VAL , whichUnit , -value, during )
endmethod
public static method coverCrackFlyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_VAL , whichUnit , hlogic.coverAttrEffectVal(getCrackFlyVal(whichUnit),value)-getCrackFlyVal(whichUnit) , during )
endmethod
public static method setCrackFlyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_VAL , whichUnit , value - getCrackFlyVal(whichUnit) , during )
endmethod
 // 攻击|伤害特效[crack_fly][odds]
public static method getCrackFlyOdds takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , whichUnit )
endmethod
public static method addCrackFlyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , whichUnit , value , during )
endmethod
public static method subCrackFlyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , whichUnit , -value, during )
endmethod
public static method coverCrackFlyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , whichUnit , hlogic.coverAttrEffectVal(getCrackFlyOdds(whichUnit),value)-getCrackFlyOdds(whichUnit) , during )
endmethod
public static method setCrackFlyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , whichUnit , value - getCrackFlyOdds(whichUnit) , during )
endmethod
 // 攻击|伤害特效[crack_fly][distance]
public static method getCrackFlyDistance takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , whichUnit )
endmethod
public static method addCrackFlyDistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , whichUnit , value , during )
endmethod
public static method subCrackFlyDistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , whichUnit , -value, during )
endmethod
public static method coverCrackFlyDistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , whichUnit , hlogic.coverAttrEffectVal(getCrackFlyDistance(whichUnit),value)-getCrackFlyDistance(whichUnit) , during )
endmethod
public static method setCrackFlyDistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , whichUnit , value - getCrackFlyDistance(whichUnit) , during )
endmethod
 // 攻击|伤害特效[crack_fly][high]
public static method getCrackFlyHigh takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , whichUnit )
endmethod
public static method addCrackFlyHigh takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , whichUnit , value , during )
endmethod
public static method subCrackFlyHigh takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , whichUnit , -value, during )
endmethod
public static method coverCrackFlyHigh takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , whichUnit , hlogic.coverAttrEffectVal(getCrackFlyHigh(whichUnit),value)-getCrackFlyHigh(whichUnit) , during )
endmethod
public static method setCrackFlyHigh takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , whichUnit , value - getCrackFlyHigh(whichUnit) , during )
endmethod

endstruct
