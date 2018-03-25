/*
	life_back 	 	生命恢复效果：增加生命恢复
	mana_back 	 	魔法恢复效果：增加魔法恢复
	attack_speed 	攻击速度效果：增加攻击速度
	move 		 	移动力效果：增加移动力
	attack_physical 物理攻击力效果：增加物理攻击力
	attack_magic    魔法攻击力效果：增加魔法攻击力
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
	
	poison 			中毒[减少生命恢复]
	fire  			灼烧[减少生命恢复]
	dry 			枯竭[减少魔法恢复]
	freeze 			冻结[减少攻击速度]
	cold 			寒冷[减少移动力]
	blunt			迟钝[减少物理攻击力]
	muggle			麻瓜[减少魔法攻击力]
	corrosion		腐蚀[减少护甲]
	chaos			混乱[减少魔抗]
	twine			缠绕[减少回避]
	blind			致盲[减少命中]
	tortua			剧痛[减少命中]
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
    lightning_chain 闪电链[被动传递点击]
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
	private static integer ATTR_FLAG_EFFECT_MOVE_VAL = 2050
	private static integer ATTR_FLAG_EFFECT_MOVE_DURING = 2051
	private static integer ATTR_FLAG_EFFECT_AIM_VAL = 2060
	private static integer ATTR_FLAG_EFFECT_AIM_DURING = 2061
	private static integer ATTR_FLAG_EFFECT_STR_VAL = 2070
	private static integer ATTR_FLAG_EFFECT_STR_DURING = 2071
	private static integer ATTR_FLAG_EFFECT_AGI_VAL = 2080
	private static integer ATTR_FLAG_EFFECT_AGI_DURING = 2081
	private static integer ATTR_FLAG_EFFECT_INT_VAL = 2090
	private static integer ATTR_FLAG_EFFECT_INT_DURING = 2091
	private static integer ATTR_FLAG_EFFECT_KNOCKING_VAL = 2100
	private static integer ATTR_FLAG_EFFECT_KNOCKING_DURING = 2101
	private static integer ATTR_FLAG_EFFECT_VIOLENCE_VAL = 2110
	private static integer ATTR_FLAG_EFFECT_VIOLENCE_DURING = 2111
	private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL = 2120
	private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING = 2121
	private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL = 2130
	private static integer ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING = 2131
	private static integer ATTR_FLAG_EFFECT_SPLIT_VAL = 2140
	private static integer ATTR_FLAG_EFFECT_SPLIT_DURING = 2141
	private static integer ATTR_FLAG_EFFECT_LUCK_VAL = 2150
	private static integer ATTR_FLAG_EFFECT_LUCK_DURING = 2151
	private static integer ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL = 2160
	private static integer ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING = 2161
	private static integer ATTR_FLAG_EFFECT_POISON_VAL = 2170
	private static integer ATTR_FLAG_EFFECT_POISON_DURING = 2171
	private static integer ATTR_FLAG_EFFECT_FIRE_VAL = 2180
	private static integer ATTR_FLAG_EFFECT_FIRE_DURING = 2181
	private static integer ATTR_FLAG_EFFECT_DRY_VAL = 2190
	private static integer ATTR_FLAG_EFFECT_DRY_DURING = 2191
	private static integer ATTR_FLAG_EFFECT_FREEZE_VAL = 2200
	private static integer ATTR_FLAG_EFFECT_FREEZE_DURING = 2201
	private static integer ATTR_FLAG_EFFECT_COLD_VAL = 2210
	private static integer ATTR_FLAG_EFFECT_COLD_DURING = 2211
	private static integer ATTR_FLAG_EFFECT_BLUNT_VAL = 2220
	private static integer ATTR_FLAG_EFFECT_BLUNT_DURING = 2221
	private static integer ATTR_FLAG_EFFECT_MUGGLE_VAL = 2230
	private static integer ATTR_FLAG_EFFECT_MUGGLE_DURING = 2231
	private static integer ATTR_FLAG_EFFECT_CORROSION_VAL = 2240
	private static integer ATTR_FLAG_EFFECT_CORROSION_DURING = 2241
	private static integer ATTR_FLAG_EFFECT_CHAOS_VAL = 2250
	private static integer ATTR_FLAG_EFFECT_CHAOS_DURING = 2251
	private static integer ATTR_FLAG_EFFECT_TWINE_VAL = 2260
	private static integer ATTR_FLAG_EFFECT_TWINE_DURING = 2261
	private static integer ATTR_FLAG_EFFECT_BLIND_VAL = 2270
	private static integer ATTR_FLAG_EFFECT_BLIND_DURING = 2271
	private static integer ATTR_FLAG_EFFECT_TORTUA_VAL = 2280
	private static integer ATTR_FLAG_EFFECT_TORTUA_DURING = 2281
	private static integer ATTR_FLAG_EFFECT_WEAK_VAL = 2290
	private static integer ATTR_FLAG_EFFECT_WEAK_DURING = 2291
	private static integer ATTR_FLAG_EFFECT_ASTRICT_VAL = 2300
	private static integer ATTR_FLAG_EFFECT_ASTRICT_DURING = 2301
	private static integer ATTR_FLAG_EFFECT_FOOLISH_VAL = 2310
	private static integer ATTR_FLAG_EFFECT_FOOLISH_DURING = 2311
	private static integer ATTR_FLAG_EFFECT_DULL_VAL = 2320
	private static integer ATTR_FLAG_EFFECT_DULL_DURING = 2321
	private static integer ATTR_FLAG_EFFECT_DIRT_VAL = 2330
	private static integer ATTR_FLAG_EFFECT_DIRT_DURING = 2331
	private static integer ATTR_FLAG_EFFECT_SWIM_ODDS = 2340
	private static integer ATTR_FLAG_EFFECT_SWIM_DURING = 2341
	private static integer ATTR_FLAG_EFFECT_HEAVY_ODDS = 2350
	private static integer ATTR_FLAG_EFFECT_HEAVY_VAL = 2351
	private static integer ATTR_FLAG_EFFECT_BREAK_ODDS = 2360
	private static integer ATTR_FLAG_EFFECT_BREAK_DURING = 2361
	private static integer ATTR_FLAG_EFFECT_UNLUCK_VAL = 2370
	private static integer ATTR_FLAG_EFFECT_UNLUCK_DURING = 2371
	private static integer ATTR_FLAG_EFFECT_SILENT_ODDS = 2380
	private static integer ATTR_FLAG_EFFECT_SILENT_DURING = 2381
	private static integer ATTR_FLAG_EFFECT_UNARM_ODDS = 2390
	private static integer ATTR_FLAG_EFFECT_UNARM_DURING = 2391
	private static integer ATTR_FLAG_EFFECT_FETTER_ODDS = 2400
	private static integer ATTR_FLAG_EFFECT_FETTER_DURING = 2401
	private static integer ATTR_FLAG_EFFECT_BOMB_VAL = 2410
	private static integer ATTR_FLAG_EFFECT_BOMB_RANGE = 2411
	private static integer ATTR_FLAG_EFFECT_BOMB_MODEL = 2412
	private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL = 2420
	private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS = 2421
	private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY = 2422
	private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE = 2423
	private static integer ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_MODEL = 2424
	private static integer ATTR_FLAG_EFFECT_CRACK_FLY_VAL = 2430
	private static integer ATTR_FLAG_EFFECT_CRACK_FLY_ODDS = 2431
	private static integer ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE = 2432
	private static integer ATTR_FLAG_EFFECT_CRACK_FLY_HIGH = 2433

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
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_POISON_VAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_POISON_DURING , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FIRE_VAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FIRE_DURING , 0 )
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
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CORROSION_VAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CORROSION_DURING , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CHAOS_VAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CHAOS_DURING , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TWINE_VAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TWINE_DURING , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLIND_VAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLIND_DURING , 0 )
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
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_VAL , whichUnit , hmath.coverAttrEffectVal(getLifeBackVal(whichUnit),value)-getLifeBackVal(whichUnit) , during )
endmethod
public static method setLifeBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_DURING , whichUnit , hmath.coverAttrEffectVal(getLifeBackDuring(whichUnit),value)-getLifeBackDuring(whichUnit) , during )
endmethod
public static method setLifeBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_VAL , whichUnit , hmath.coverAttrEffectVal(getManaBackVal(whichUnit),value)-getManaBackVal(whichUnit) , during )
endmethod
public static method setManaBackVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_DURING , whichUnit , hmath.coverAttrEffectVal(getManaBackDuring(whichUnit),value)-getManaBackDuring(whichUnit) , during )
endmethod
public static method setManaBackDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , whichUnit , hmath.coverAttrEffectVal(getAttackSpeedVal(whichUnit),value)-getAttackSpeedVal(whichUnit) , during )
endmethod
public static method setAttackSpeedVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , whichUnit , hmath.coverAttrEffectVal(getAttackSpeedDuring(whichUnit),value)-getAttackSpeedDuring(whichUnit) , during )
endmethod
public static method setAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , whichUnit , hmath.coverAttrEffectVal(getAttackPhysicalVal(whichUnit),value)-getAttackPhysicalVal(whichUnit) , during )
endmethod
public static method setAttackPhysicalVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , whichUnit , hmath.coverAttrEffectVal(getAttackPhysicalDuring(whichUnit),value)-getAttackPhysicalDuring(whichUnit) , during )
endmethod
public static method setAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , whichUnit , hmath.coverAttrEffectVal(getAttackMagicVal(whichUnit),value)-getAttackMagicVal(whichUnit) , during )
endmethod
public static method setAttackMagicVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , whichUnit , hmath.coverAttrEffectVal(getAttackMagicDuring(whichUnit),value)-getAttackMagicDuring(whichUnit) , during )
endmethod
public static method setAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_MOVE_VAL , whichUnit , hmath.coverAttrEffectVal(getMoveVal(whichUnit),value)-getMoveVal(whichUnit) , during )
endmethod
public static method setMoveVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_MOVE_DURING , whichUnit , hmath.coverAttrEffectVal(getMoveDuring(whichUnit),value)-getMoveDuring(whichUnit) , during )
endmethod
public static method setMoveDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MOVE_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_AIM_VAL , whichUnit , hmath.coverAttrEffectVal(getAimVal(whichUnit),value)-getAimVal(whichUnit) , during )
endmethod
public static method setAimVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_AIM_DURING , whichUnit , hmath.coverAttrEffectVal(getAimDuring(whichUnit),value)-getAimDuring(whichUnit) , during )
endmethod
public static method setAimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AIM_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_STR_VAL , whichUnit , hmath.coverAttrEffectVal(getStrVal(whichUnit),value)-getStrVal(whichUnit) , during )
endmethod
public static method setStrVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_STR_DURING , whichUnit , hmath.coverAttrEffectVal(getStrDuring(whichUnit),value)-getStrDuring(whichUnit) , during )
endmethod
public static method setStrDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_STR_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_AGI_VAL , whichUnit , hmath.coverAttrEffectVal(getAgiVal(whichUnit),value)-getAgiVal(whichUnit) , during )
endmethod
public static method setAgiVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_AGI_DURING , whichUnit , hmath.coverAttrEffectVal(getAgiDuring(whichUnit),value)-getAgiDuring(whichUnit) , during )
endmethod
public static method setAgiDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_AGI_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_INT_VAL , whichUnit , hmath.coverAttrEffectVal(getIntVal(whichUnit),value)-getIntVal(whichUnit) , during )
endmethod
public static method setIntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_INT_DURING , whichUnit , hmath.coverAttrEffectVal(getIntDuring(whichUnit),value)-getIntDuring(whichUnit) , during )
endmethod
public static method setIntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_INT_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_VAL , whichUnit , hmath.coverAttrEffectVal(getKnockingVal(whichUnit),value)-getKnockingVal(whichUnit) , during )
endmethod
public static method setKnockingVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_DURING , whichUnit , hmath.coverAttrEffectVal(getKnockingDuring(whichUnit),value)-getKnockingDuring(whichUnit) , during )
endmethod
public static method setKnockingDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_KNOCKING_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_VAL , whichUnit , hmath.coverAttrEffectVal(getViolenceVal(whichUnit),value)-getViolenceVal(whichUnit) , during )
endmethod
public static method setViolenceVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_DURING , whichUnit , hmath.coverAttrEffectVal(getViolenceDuring(whichUnit),value)-getViolenceDuring(whichUnit) , during )
endmethod
public static method setViolenceDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , whichUnit , hmath.coverAttrEffectVal(getHemophagiaVal(whichUnit),value)-getHemophagiaVal(whichUnit) , during )
endmethod
public static method setHemophagiaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , whichUnit , hmath.coverAttrEffectVal(getHemophagiaDuring(whichUnit),value)-getHemophagiaDuring(whichUnit) , during )
endmethod
public static method setHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , whichUnit , hmath.coverAttrEffectVal(getHemophagiaSkillVal(whichUnit),value)-getHemophagiaSkillVal(whichUnit) , during )
endmethod
public static method setHemophagiaSkillVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , whichUnit , hmath.coverAttrEffectVal(getHemophagiaSkillDuring(whichUnit),value)-getHemophagiaSkillDuring(whichUnit) , during )
endmethod
public static method setHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_VAL , whichUnit , hmath.coverAttrEffectVal(getSplitVal(whichUnit),value)-getSplitVal(whichUnit) , during )
endmethod
public static method setSplitVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_DURING , whichUnit , hmath.coverAttrEffectVal(getSplitDuring(whichUnit),value)-getSplitDuring(whichUnit) , during )
endmethod
public static method setSplitDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SPLIT_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_LUCK_VAL , whichUnit , hmath.coverAttrEffectVal(getLuckVal(whichUnit),value)-getLuckVal(whichUnit) , during )
endmethod
public static method setLuckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_LUCK_DURING , whichUnit , hmath.coverAttrEffectVal(getLuckDuring(whichUnit),value)-getLuckDuring(whichUnit) , during )
endmethod
public static method setLuckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LUCK_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , whichUnit , hmath.coverAttrEffectVal(getHuntAmplitudeVal(whichUnit),value)-getHuntAmplitudeVal(whichUnit) , during )
endmethod
public static method setHuntAmplitudeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , whichUnit , hmath.coverAttrEffectVal(getHuntAmplitudeDuring(whichUnit),value)-getHuntAmplitudeDuring(whichUnit) , during )
endmethod
public static method setHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_POISON_VAL , whichUnit , hmath.coverAttrEffectVal(getPoisonVal(whichUnit),value)-getPoisonVal(whichUnit) , during )
endmethod
public static method setPoisonVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_POISON_DURING , whichUnit , hmath.coverAttrEffectVal(getPoisonDuring(whichUnit),value)-getPoisonDuring(whichUnit) , during )
endmethod
public static method setPoisonDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_POISON_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FIRE_VAL , whichUnit , hmath.coverAttrEffectVal(getFireVal(whichUnit),value)-getFireVal(whichUnit) , during )
endmethod
public static method setFireVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FIRE_DURING , whichUnit , hmath.coverAttrEffectVal(getFireDuring(whichUnit),value)-getFireDuring(whichUnit) , during )
endmethod
public static method setFireDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FIRE_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_DRY_VAL , whichUnit , hmath.coverAttrEffectVal(getDryVal(whichUnit),value)-getDryVal(whichUnit) , during )
endmethod
public static method setDryVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_DRY_DURING , whichUnit , hmath.coverAttrEffectVal(getDryDuring(whichUnit),value)-getDryDuring(whichUnit) , during )
endmethod
public static method setDryDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DRY_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_VAL , whichUnit , hmath.coverAttrEffectVal(getFreezeVal(whichUnit),value)-getFreezeVal(whichUnit) , during )
endmethod
public static method setFreezeVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_DURING , whichUnit , hmath.coverAttrEffectVal(getFreezeDuring(whichUnit),value)-getFreezeDuring(whichUnit) , during )
endmethod
public static method setFreezeDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FREEZE_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_COLD_VAL , whichUnit , hmath.coverAttrEffectVal(getColdVal(whichUnit),value)-getColdVal(whichUnit) , during )
endmethod
public static method setColdVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_COLD_DURING , whichUnit , hmath.coverAttrEffectVal(getColdDuring(whichUnit),value)-getColdDuring(whichUnit) , during )
endmethod
public static method setColdDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_COLD_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_VAL , whichUnit , hmath.coverAttrEffectVal(getBluntVal(whichUnit),value)-getBluntVal(whichUnit) , during )
endmethod
public static method setBluntVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_DURING , whichUnit , hmath.coverAttrEffectVal(getBluntDuring(whichUnit),value)-getBluntDuring(whichUnit) , during )
endmethod
public static method setBluntDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLUNT_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_VAL , whichUnit , hmath.coverAttrEffectVal(getMuggleVal(whichUnit),value)-getMuggleVal(whichUnit) , during )
endmethod
public static method setMuggleVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_DURING , whichUnit , hmath.coverAttrEffectVal(getMuggleDuring(whichUnit),value)-getMuggleDuring(whichUnit) , during )
endmethod
public static method setMuggleDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_MUGGLE_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_VAL , whichUnit , hmath.coverAttrEffectVal(getCorrosionVal(whichUnit),value)-getCorrosionVal(whichUnit) , during )
endmethod
public static method setCorrosionVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_DURING , whichUnit , hmath.coverAttrEffectVal(getCorrosionDuring(whichUnit),value)-getCorrosionDuring(whichUnit) , during )
endmethod
public static method setCorrosionDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CORROSION_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_VAL , whichUnit , hmath.coverAttrEffectVal(getChaosVal(whichUnit),value)-getChaosVal(whichUnit) , during )
endmethod
public static method setChaosVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_DURING , whichUnit , hmath.coverAttrEffectVal(getChaosDuring(whichUnit),value)-getChaosDuring(whichUnit) , during )
endmethod
public static method setChaosDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CHAOS_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_TWINE_VAL , whichUnit , hmath.coverAttrEffectVal(getTwineVal(whichUnit),value)-getTwineVal(whichUnit) , during )
endmethod
public static method setTwineVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_TWINE_DURING , whichUnit , hmath.coverAttrEffectVal(getTwineDuring(whichUnit),value)-getTwineDuring(whichUnit) , during )
endmethod
public static method setTwineDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TWINE_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BLIND_VAL , whichUnit , hmath.coverAttrEffectVal(getBlindVal(whichUnit),value)-getBlindVal(whichUnit) , during )
endmethod
public static method setBlindVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BLIND_DURING , whichUnit , hmath.coverAttrEffectVal(getBlindDuring(whichUnit),value)-getBlindDuring(whichUnit) , during )
endmethod
public static method setBlindDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BLIND_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_VAL , whichUnit , hmath.coverAttrEffectVal(getTortuaVal(whichUnit),value)-getTortuaVal(whichUnit) , during )
endmethod
public static method setTortuaVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_DURING , whichUnit , hmath.coverAttrEffectVal(getTortuaDuring(whichUnit),value)-getTortuaDuring(whichUnit) , during )
endmethod
public static method setTortuaDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_TORTUA_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_WEAK_VAL , whichUnit , hmath.coverAttrEffectVal(getWeakVal(whichUnit),value)-getWeakVal(whichUnit) , during )
endmethod
public static method setWeakVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_WEAK_DURING , whichUnit , hmath.coverAttrEffectVal(getWeakDuring(whichUnit),value)-getWeakDuring(whichUnit) , during )
endmethod
public static method setWeakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_WEAK_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_VAL , whichUnit , hmath.coverAttrEffectVal(getAstrictVal(whichUnit),value)-getAstrictVal(whichUnit) , during )
endmethod
public static method setAstrictVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_DURING , whichUnit , hmath.coverAttrEffectVal(getAstrictDuring(whichUnit),value)-getAstrictDuring(whichUnit) , during )
endmethod
public static method setAstrictDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_ASTRICT_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_VAL , whichUnit , hmath.coverAttrEffectVal(getFoolishVal(whichUnit),value)-getFoolishVal(whichUnit) , during )
endmethod
public static method setFoolishVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_DURING , whichUnit , hmath.coverAttrEffectVal(getFoolishDuring(whichUnit),value)-getFoolishDuring(whichUnit) , during )
endmethod
public static method setFoolishDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FOOLISH_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_DULL_VAL , whichUnit , hmath.coverAttrEffectVal(getDullVal(whichUnit),value)-getDullVal(whichUnit) , during )
endmethod
public static method setDullVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_DULL_DURING , whichUnit , hmath.coverAttrEffectVal(getDullDuring(whichUnit),value)-getDullDuring(whichUnit) , during )
endmethod
public static method setDullDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DULL_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_DIRT_VAL , whichUnit , hmath.coverAttrEffectVal(getDirtVal(whichUnit),value)-getDirtVal(whichUnit) , during )
endmethod
public static method setDirtVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_DIRT_DURING , whichUnit , hmath.coverAttrEffectVal(getDirtDuring(whichUnit),value)-getDirtDuring(whichUnit) , during )
endmethod
public static method setDirtDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_DIRT_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_SWIM_ODDS , whichUnit , hmath.coverAttrEffectVal(getSwimOdds(whichUnit),value)-getSwimOdds(whichUnit) , during )
endmethod
public static method setSwimOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_SWIM_DURING , whichUnit , hmath.coverAttrEffectVal(getSwimDuring(whichUnit),value)-getSwimDuring(whichUnit) , during )
endmethod
public static method setSwimDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SWIM_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_ODDS , whichUnit , hmath.coverAttrEffectVal(getHeavyOdds(whichUnit),value)-getHeavyOdds(whichUnit) , during )
endmethod
public static method setHeavyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_VAL , whichUnit , hmath.coverAttrEffectVal(getHeavyVal(whichUnit),value)-getHeavyVal(whichUnit) , during )
endmethod
public static method setHeavyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_HEAVY_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BREAK_ODDS , whichUnit , hmath.coverAttrEffectVal(getBreakOdds(whichUnit),value)-getBreakOdds(whichUnit) , during )
endmethod
public static method setBreakOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BREAK_DURING , whichUnit , hmath.coverAttrEffectVal(getBreakDuring(whichUnit),value)-getBreakDuring(whichUnit) , during )
endmethod
public static method setBreakDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BREAK_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_VAL , whichUnit , hmath.coverAttrEffectVal(getUnluckVal(whichUnit),value)-getUnluckVal(whichUnit) , during )
endmethod
public static method setUnluckVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_DURING , whichUnit , hmath.coverAttrEffectVal(getUnluckDuring(whichUnit),value)-getUnluckDuring(whichUnit) , during )
endmethod
public static method setUnluckDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNLUCK_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_SILENT_ODDS , whichUnit , hmath.coverAttrEffectVal(getSilentOdds(whichUnit),value)-getSilentOdds(whichUnit) , during )
endmethod
public static method setSilentOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_SILENT_DURING , whichUnit , hmath.coverAttrEffectVal(getSilentDuring(whichUnit),value)-getSilentDuring(whichUnit) , during )
endmethod
public static method setSilentDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_SILENT_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_UNARM_ODDS , whichUnit , hmath.coverAttrEffectVal(getUnarmOdds(whichUnit),value)-getUnarmOdds(whichUnit) , during )
endmethod
public static method setUnarmOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_UNARM_DURING , whichUnit , hmath.coverAttrEffectVal(getUnarmDuring(whichUnit),value)-getUnarmDuring(whichUnit) , during )
endmethod
public static method setUnarmDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_UNARM_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FETTER_ODDS , whichUnit , hmath.coverAttrEffectVal(getFetterOdds(whichUnit),value)-getFetterOdds(whichUnit) , during )
endmethod
public static method setFetterOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_FETTER_DURING , whichUnit , hmath.coverAttrEffectVal(getFetterDuring(whichUnit),value)-getFetterDuring(whichUnit) , during )
endmethod
public static method setFetterDuring takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_FETTER_DURING , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BOMB_VAL , whichUnit , hmath.coverAttrEffectVal(getBombVal(whichUnit),value)-getBombVal(whichUnit) , during )
endmethod
public static method setBombVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_BOMB_RANGE , whichUnit , hmath.coverAttrEffectVal(getBombRange(whichUnit),value)-getBombRange(whichUnit) , during )
endmethod
public static method setBombRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_BOMB_RANGE , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , whichUnit , hmath.coverAttrEffectVal(getLightningChainVal(whichUnit),value)-getLightningChainVal(whichUnit) , during )
endmethod
public static method setLightningChainVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , whichUnit , hmath.coverAttrEffectVal(getLightningChainOdds(whichUnit),value)-getLightningChainOdds(whichUnit) , during )
endmethod
public static method setLightningChainOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , whichUnit , hmath.coverAttrEffectVal(getLightningChainQty(whichUnit),value)-getLightningChainQty(whichUnit) , during )
endmethod
public static method setLightningChainQty takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_QTY , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , whichUnit , hmath.coverAttrEffectVal(getLightningChainReduce(whichUnit),value)-getLightningChainReduce(whichUnit) , during )
endmethod
public static method setLightningChainReduce takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_LIGHTNING_CHAIN_REDUCE , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_VAL , whichUnit , hmath.coverAttrEffectVal(getCrackFlyVal(whichUnit),value)-getCrackFlyVal(whichUnit) , during )
endmethod
public static method setCrackFlyVal takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_VAL , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , whichUnit , hmath.coverAttrEffectVal(getCrackFlyOdds(whichUnit),value)-getCrackFlyOdds(whichUnit) , during )
endmethod
public static method setCrackFlyOdds takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_ODDS , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , whichUnit , hmath.coverAttrEffectVal(getCrackFlyDistance(whichUnit),value)-getCrackFlyDistance(whichUnit) , during )
endmethod
public static method setCrackFlyDistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_DISTANCE , whichUnit , value , during )
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
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , whichUnit , hmath.coverAttrEffectVal(getCrackFlyHigh(whichUnit),value)-getCrackFlyHigh(whichUnit) , during )
endmethod
public static method setCrackFlyHigh takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_EFFECT_CRACK_FLY_HIGH , whichUnit , value , during )
endmethod

endstruct
