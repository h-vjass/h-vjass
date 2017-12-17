/*
	生命恢复效果：增加生命恢复
	魔法恢复效果：增加魔法恢复
	攻击速度效果：增加攻击速度
	移动力效果：增加移动力
	物理攻击力效果：增加物理攻击力
	魔法攻击力效果：增加魔法攻击力
	命中效果：增加命中
	力量效果：增加力量(绿字)
	敏捷效果：增加敏捷(绿字)
	智力效果：增加智力(绿字)
	物理暴击效果：增加物理暴击
	魔法暴击效果：增加魔法暴击
	吸血效果：增加吸血
	技能吸血效果：增加技能吸血
	分裂效果：增加分裂
	运气效果：增加运气
	伤害增幅效果：增加伤害增幅
	--*/
	/*--
	poison 		中毒[减少生命恢复]
	dry 		枯竭[减少魔法恢复]
	freeze 		冻结[减少攻击速度]
	cold 		寒冷[减少移动力]
	blunt		迟钝[减少物理和魔法攻击力]
	corrosion	腐蚀[减少护甲]
	chaos		混乱[减少魔抗]
	twine		缠绕[减少回避]
	blind		致盲[减少命中]
	tortua		剧痛[减少命中]
	weak		乏力[减少力量(绿字)]
	bound		束缚[减少敏捷(绿字)]
	foolish		愚蠢[减少智力(绿字)]
	lazy		懒惰[减少物理暴击和魔法暴击]
	swim 		眩晕[特定眩晕，直接眩晕，受抵抗]
	heavy 		沉重[加重硬直减少量]
	break 		打断[直接僵直]
	unluck 		倒霉[减少运气]
*/
globals
	hAttrEffect attrEffect = 0
	hashtable hash_attr_effect = InitHashtable()
	//
	integer ATTR_FLAG_EFFECT_UNIT = 1000
    integer ATTR_FLAG_EFFECT_CD = 1001
    //--
	integer ATTR_FLAG_EFFECT_LIFE_BACK = 2001
	integer ATTR_FLAG_EFFECT_MANA_BACK = 2002
	integer ATTR_FLAG_EFFECT_ATTACK_SPEED = 2003
	integer ATTR_FLAG_EFFECT_ATTACK_PHYSICAL = 2004
	integer ATTR_FLAG_EFFECT_ATTACK_MAGIC = 2005
	integer ATTR_FLAG_EFFECT_MOVE = 2006
	integer ATTR_FLAG_EFFECT_AIM = 2007
	integer ATTR_FLAG_EFFECT_STR = 2008
	integer ATTR_FLAG_EFFECT_AGI = 2009
	integer ATTR_FLAG_EFFECT_INT = 2010
	integer ATTR_FLAG_EFFECT_KNOCKING = 2011
	integer ATTR_FLAG_EFFECT_VIOLENCE = 2012
	integer ATTR_FLAG_EFFECT_HEMOPHAGIA = 2013
	integer ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL = 2014
	integer ATTR_FLAG_EFFECT_SPLIT = 2015
	integer ATTR_FLAG_EFFECT_LUCK = 2016
	integer ATTR_FLAG_EFFECT_HUNT_AMPLITUDE = 2017
	integer ATTR_FLAG_EFFECT_POISON = 2018
	integer ATTR_FLAG_EFFECT_DRY = 2019
	integer ATTR_FLAG_EFFECT_FREEZE = 2020
	integer ATTR_FLAG_EFFECT_COLD = 2021
	integer ATTR_FLAG_EFFECT_BLUNT = 2022
	integer ATTR_FLAG_EFFECT_CORROSION = 2023
	integer ATTR_FLAG_EFFECT_CHAOS = 2024
	integer ATTR_FLAG_EFFECT_TWINE = 2025
	integer ATTR_FLAG_EFFECT_BLIND = 2026
	integer ATTR_FLAG_EFFECT_TORTUA = 2027
	integer ATTR_FLAG_EFFECT_WEAK = 2028
	integer ATTR_FLAG_EFFECT_BOUND = 2029
	integer ATTR_FLAG_EFFECT_FOOLISH = 2030
	integer ATTR_FLAG_EFFECT_LAZY = 2031
	integer ATTR_FLAG_EFFECT_SWIM = 2032
	integer ATTR_FLAG_EFFECT_BREAK = 2033
	integer ATTR_FLAG_EFFECT_HEAVY = 2034
	integer ATTR_FLAG_EFFECT_UNLUCK = 2035

	integer ATTR_FLAG_EFFECT_DURING_LIFE_BACK = 4001
	integer ATTR_FLAG_EFFECT_DURING_MANA_BACK = 4002
	integer ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED = 4003
	integer ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL = 4004
	integer ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC = 4005
	integer ATTR_FLAG_EFFECT_DURING_MOVE = 4006
	integer ATTR_FLAG_EFFECT_DURING_AIM = 4007
	integer ATTR_FLAG_EFFECT_DURING_STR = 4008
	integer ATTR_FLAG_EFFECT_DURING_AGI = 4009
	integer ATTR_FLAG_EFFECT_DURING_INT = 4010
	integer ATTR_FLAG_EFFECT_DURING_KNOCKING = 4011
	integer ATTR_FLAG_EFFECT_DURING_VIOLENCE = 4012
	integer ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA = 4013
	integer ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL = 4014
	integer ATTR_FLAG_EFFECT_DURING_SPLIT = 4015
	integer ATTR_FLAG_EFFECT_DURING_LUCK = 4016
	integer ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE = 4017
	integer ATTR_FLAG_EFFECT_DURING_POISON = 4018
	integer ATTR_FLAG_EFFECT_DURING_DRY = 4019
	integer ATTR_FLAG_EFFECT_DURING_FREEZE = 4020
	integer ATTR_FLAG_EFFECT_DURING_COLD = 4021
	integer ATTR_FLAG_EFFECT_DURING_BLUNT = 4022
	integer ATTR_FLAG_EFFECT_DURING_CORROSION = 4023
	integer ATTR_FLAG_EFFECT_DURING_CHAOS = 4024
	integer ATTR_FLAG_EFFECT_DURING_TWINE = 4025
	integer ATTR_FLAG_EFFECT_DURING_BLIND = 4026
	integer ATTR_FLAG_EFFECT_DURING_TORTUA = 4027
	integer ATTR_FLAG_EFFECT_DURING_WEAK = 4028
	integer ATTR_FLAG_EFFECT_DURING_BOUND = 4029
	integer ATTR_FLAG_EFFECT_DURING_FOOLISH = 4030
	integer ATTR_FLAG_EFFECT_DURING_LAZY = 4031
	integer ATTR_FLAG_EFFECT_DURING_SWIM = 4032
	integer ATTR_FLAG_EFFECT_DURING_BREAK = 4033
	integer ATTR_FLAG_EFFECT_DURING_HEAVY = 4034
	integer ATTR_FLAG_EFFECT_DURING_UNLUCK = 4035
endglobals

struct hAttrEffect

	static method create takes nothing returns hAttrEffect
        local hAttrEffect x = 0
        set x = hAttrEffect.allocate()
        return x
    endmethod

	/* 验证单位是否初始化过参数 */
	public static method initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNIT , uhid )

			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LIFE_BACK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_LIFE_BACK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MANA_BACK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_MANA_BACK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_SPEED , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_ATTACK_MAGIC , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_MOVE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_MOVE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_AIM , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_AIM , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_STR , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_STR , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_AGI , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_AGI , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_INT , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_INT , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_KNOCKING , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_KNOCKING , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_VIOLENCE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_VIOLENCE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SPLIT , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_SPLIT , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LUCK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_LUCK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_POISON , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_POISON , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DRY , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_DRY , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FREEZE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_FREEZE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_COLD , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_COLD , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLUNT , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_BLUNT , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CORROSION , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_CORROSION , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_CHAOS , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_CHAOS , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TWINE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_TWINE , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BLIND , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_BLIND , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_TORTUA , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_TORTUA , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_WEAK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_WEAK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BOUND , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_BOUND , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_FOOLISH , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_FOOLISH , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_LAZY , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_LAZY , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_SWIM , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_SWIM , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_BREAK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_BREAK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_HEAVY , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_HEAVY , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_UNLUCK , 0 )
			call SaveReal( hash_attr_effect , uhid , ATTR_FLAG_EFFECT_DURING_UNLUCK , 0 )
			return true
		endif
		return false
	endmethod

	/* 设定属性(即时/计时) */
	private static method setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		if(diff != 0)then
			call SaveReal( hash_attr_effect , uhid , flag , LoadReal( hash_attr_effect , uhid , flag ) + diff )
		endif
	endmethod

	private static method setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = time.getInteger(t,1)
		local unit whichUnit = time.getUnit(t,2)
		local real diff = time.getReal(t,3)
		call time.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
	endmethod

	private static method setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr( whichUnit )
		call setAttrDo( flag , whichUnit , diff )
		if( during>0 ) then
			set t = time.setTimeout( during , function thistype.setAttrDuring )
			call time.setInteger(t,1,flag)
			call time.setUnit(t,2,whichUnit)
			call time.setReal(t,3, -diff )
		endif
	endmethod

	private static method getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash_attr_effect , GetHandleId(whichUnit) , flag )
	endmethod




	/* 攻击|伤害特效[life_back] ------------------------------------------------------------ */
	public static method getLifeBack takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_LIFE_BACK , whichUnit )
	endmethod
	public static method coverLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK , whichUnit , math.oddsAttrEffect(getLifeBack(whichUnit),value)-getLifeBack(whichUnit) , during )
	endmethod
	public static method setLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
	endmethod
	//持续
	public static method getLifeBackDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_LIFE_BACK , whichUnit )
	endmethod
	public static method coverLifeBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LIFE_BACK , whichUnit , math.oddsAttrEffect(getLifeBackDuring(whichUnit),value)-getLifeBackDuring(whichUnit) , during )
	endmethod
	public static method setLifeBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[mana_back] ------------------------------------------------------------ */
	public static method getManaBack takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_MANA_BACK , whichUnit )
	endmethod
	public static method coverManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK , whichUnit , math.oddsAttrEffect(getManaBack(whichUnit),value)-getManaBack(whichUnit) , during )
	endmethod
	public static method setManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
	endmethod
	//持续
	public static method getManaBackDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_MANA_BACK , whichUnit )
	endmethod
	public static method coverManaBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MANA_BACK , whichUnit , math.oddsAttrEffect(getManaBackDuring(whichUnit),value)-getManaBackDuring(whichUnit) , during )
	endmethod
	public static method setManaBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[attack_speed] ------------------------------------------------------------ */
	public static method getAttackSpeed takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED , whichUnit )
	endmethod
	public static method coverAttackSpeed takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED , whichUnit , math.oddsAttrEffect(getAttackSpeed(whichUnit),value)-getAttackSpeed(whichUnit) , during )
	endmethod
	public static method setAttackSpeed takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED , whichUnit , value - getAttackSpeed(whichUnit) , during )
	endmethod
	//持续
	public static method getAttackSpeedDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , whichUnit )
	endmethod
	public static method coverAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , whichUnit , math.oddsAttrEffect(getAttackSpeedDuring(whichUnit),value)-getAttackSpeedDuring(whichUnit) , during )
	endmethod
	public static method setAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , whichUnit , value - getAttackSpeed(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[attack_physical] ------------------------------------------------------------ */
	public static method getAttackPhysical takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , whichUnit )
	endmethod
	public static method coverAttackPhysical takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , whichUnit , math.oddsAttrEffect(getAttackPhysical(whichUnit),value)-getAttackPhysical(whichUnit) , during )
	endmethod
	public static method setAttackPhysical takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , whichUnit , value - getAttackPhysical(whichUnit) , during )
	endmethod
	//持续
	public static method getAttackPhysicalDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , whichUnit )
	endmethod
	public static method coverAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , whichUnit , math.oddsAttrEffect(getAttackPhysicalDuring(whichUnit),value)-getAttackPhysicalDuring(whichUnit) , during )
	endmethod
	public static method setAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , whichUnit , value - getAttackPhysical(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[attack_magic] ------------------------------------------------------------ */
	public static method getAttackMagic takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC , whichUnit )
	endmethod
	public static method coverAttackMagic takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC , whichUnit , math.oddsAttrEffect(getAttackMagic(whichUnit),value)-getAttackMagic(whichUnit) , during )
	endmethod
	public static method setAttackMagic takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC , whichUnit , value - getAttackMagic(whichUnit) , during )
	endmethod
	//持续
	public static method getAttackMagicDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , whichUnit )
	endmethod
	public static method coverAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , whichUnit , math.oddsAttrEffect(getAttackMagicDuring(whichUnit),value)-getAttackMagicDuring(whichUnit) , during )
	endmethod
	public static method setAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , whichUnit , value - getAttackMagic(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[move] ------------------------------------------------------------ */
	public static method getMove takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_MOVE , whichUnit )
	endmethod
	public static method coverMove takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MOVE , whichUnit , math.oddsAttrEffect(getMove(whichUnit),value)-getMove(whichUnit) , during )
	endmethod
	public static method setMove takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MOVE , whichUnit , value - getMove(whichUnit) , during )
	endmethod
	//持续
	public static method getMoveDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_MOVE , whichUnit )
	endmethod
	public static method coverMoveDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MOVE , whichUnit , math.oddsAttrEffect(getMoveDuring(whichUnit),value)-getMoveDuring(whichUnit) , during )
	endmethod
	public static method setMoveDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MOVE , whichUnit , value - getMove(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[aim] ------------------------------------------------------------ */
	public static method getAim takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_AIM , whichUnit )
	endmethod
	public static method coverAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AIM , whichUnit , math.oddsAttrEffect(getAim(whichUnit),value)-getAim(whichUnit) , during )
	endmethod
	public static method setAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AIM , whichUnit , value - getAim(whichUnit) , during )
	endmethod
	//持续
	public static method getAimDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_AIM , whichUnit )
	endmethod
	public static method coverAimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AIM , whichUnit , math.oddsAttrEffect(getAimDuring(whichUnit),value)-getAimDuring(whichUnit) , during )
	endmethod
	public static method setAimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AIM , whichUnit , value - getAim(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[str] ------------------------------------------------------------ */
	public static method getStr takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_STR , whichUnit )
	endmethod
	public static method coverStr takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_STR , whichUnit , math.oddsAttrEffect(getStr(whichUnit),value)-getStr(whichUnit) , during )
	endmethod
	public static method setStr takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_STR , whichUnit , value - getStr(whichUnit) , during )
	endmethod
	//持续
	public static method getStrDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_STR , whichUnit )
	endmethod
	public static method coverStrDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_STR , whichUnit , math.oddsAttrEffect(getStrDuring(whichUnit),value)-getStrDuring(whichUnit) , during )
	endmethod
	public static method setStrDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_STR , whichUnit , value - getStr(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[agi] ------------------------------------------------------------ */
	public static method getAgi takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_AGI , whichUnit )
	endmethod
	public static method coverAgi takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AGI , whichUnit , math.oddsAttrEffect(getAgi(whichUnit),value)-getAgi(whichUnit) , during )
	endmethod
	public static method setAgi takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AGI , whichUnit , value - getAgi(whichUnit) , during )
	endmethod
	//持续
	public static method getAgiDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_AGI , whichUnit )
	endmethod
	public static method coverAgiDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AGI , whichUnit , math.oddsAttrEffect(getAgiDuring(whichUnit),value)-getAgiDuring(whichUnit) , during )
	endmethod
	public static method setAgiDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AGI , whichUnit , value - getAgi(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[int] ------------------------------------------------------------ */
	public static method getInt takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_INT , whichUnit )
	endmethod
	public static method coverInt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_INT , whichUnit , math.oddsAttrEffect(getInt(whichUnit),value)-getInt(whichUnit) , during )
	endmethod
	public static method setInt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_INT , whichUnit , value - getInt(whichUnit) , during )
	endmethod
	//持续
	public static method getIntDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_INT , whichUnit )
	endmethod
	public static method coverIntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_INT , whichUnit , math.oddsAttrEffect(getIntDuring(whichUnit),value)-getIntDuring(whichUnit) , during )
	endmethod
	public static method setIntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_INT , whichUnit , value - getInt(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[knocking] ------------------------------------------------------------ */
	public static method getKnocking takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_KNOCKING , whichUnit )
	endmethod
	public static method coverKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_KNOCKING , whichUnit , math.oddsAttrEffect(getKnocking(whichUnit),value)-getKnocking(whichUnit) , during )
	endmethod
	public static method setKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
	endmethod
	//持续
	public static method getKnockingDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_KNOCKING , whichUnit )
	endmethod
	public static method coverKnockingDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_KNOCKING , whichUnit , math.oddsAttrEffect(getKnockingDuring(whichUnit),value)-getKnockingDuring(whichUnit) , during )
	endmethod
	public static method setKnockingDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[violence] ------------------------------------------------------------ */
	public static method getViolence takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_VIOLENCE , whichUnit )
	endmethod
	public static method coverViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE , whichUnit , math.oddsAttrEffect(getViolence(whichUnit),value)-getViolence(whichUnit) , during )
	endmethod
	public static method setViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
	endmethod
	//持续
	public static method getViolenceDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_VIOLENCE , whichUnit )
	endmethod
	public static method coverViolenceDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_VIOLENCE , whichUnit , math.oddsAttrEffect(getViolenceDuring(whichUnit),value)-getViolenceDuring(whichUnit) , during )
	endmethod
	public static method setViolenceDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[hemophagia] ------------------------------------------------------------ */
	public static method getHemophagia takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA , whichUnit )
	endmethod
	public static method coverHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA , whichUnit , math.oddsAttrEffect(getHemophagia(whichUnit),value)-getHemophagia(whichUnit) , during )
	endmethod
	public static method setHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
	endmethod
	//持续
	public static method getHemophagiaDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , whichUnit )
	endmethod
	public static method coverHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , whichUnit , math.oddsAttrEffect(getHemophagiaDuring(whichUnit),value)-getHemophagiaDuring(whichUnit) , during )
	endmethod
	public static method setHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[hemophagia_skill] ------------------------------------------------------------ */
	public static method getHemophagiaSkill takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , whichUnit )
	endmethod
	public static method coverHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , whichUnit , math.oddsAttrEffect(getHemophagiaSkill(whichUnit),value)-getHemophagiaSkill(whichUnit) , during )
	endmethod
	public static method setHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
	endmethod
	//持续
	public static method getHemophagiaSkillDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , whichUnit )
	endmethod
	public static method coverHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , whichUnit , math.oddsAttrEffect(getHemophagiaSkillDuring(whichUnit),value)-getHemophagiaSkillDuring(whichUnit) , during )
	endmethod
	public static method setHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[split] ------------------------------------------------------------ */
	public static method getSplit takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_SPLIT , whichUnit )
	endmethod
	public static method coverSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SPLIT , whichUnit , math.oddsAttrEffect(getSplit(whichUnit),value)-getSplit(whichUnit) , during )
	endmethod
	public static method setSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
	endmethod
	//持续
	public static method getSplitDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_SPLIT , whichUnit )
	endmethod
	public static method coverSplitDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SPLIT , whichUnit , math.oddsAttrEffect(getSplitDuring(whichUnit),value)-getSplitDuring(whichUnit) , during )
	endmethod
	public static method setSplitDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[luck] ------------------------------------------------------------ */
	public static method getLuck takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_LUCK , whichUnit )
	endmethod
	public static method coverLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LUCK , whichUnit , math.oddsAttrEffect(getLuck(whichUnit),value)-getLuck(whichUnit) , during )
	endmethod
	public static method setLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LUCK , whichUnit , value - getLuck(whichUnit) , during )
	endmethod
	//持续
	public static method getLuckDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_LUCK , whichUnit )
	endmethod
	public static method coverLuckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LUCK , whichUnit , math.oddsAttrEffect(getLuckDuring(whichUnit),value)-getLuckDuring(whichUnit) , during )
	endmethod
	public static method setLuckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LUCK , whichUnit , value - getLuck(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[hunt_amplitude] ------------------------------------------------------------ */
	public static method getHuntAmplitude takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , whichUnit )
	endmethod
	public static method coverHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , whichUnit , math.oddsAttrEffect(getHuntAmplitude(whichUnit),value)-getHuntAmplitude(whichUnit) , during )
	endmethod
	public static method setHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , during )
	endmethod
	//持续
	public static method getHuntAmplitudeDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , whichUnit )
	endmethod
	public static method coverHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , whichUnit , math.oddsAttrEffect(getHuntAmplitudeDuring(whichUnit),value)-getHuntAmplitudeDuring(whichUnit) , during )
	endmethod
	public static method setHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[poison] ------------------------------------------------------------ */
	public static method getPoison takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_POISON , whichUnit )
	endmethod
	public static method coverPoison takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_POISON , whichUnit , math.oddsAttrEffect(getPoison(whichUnit),value)-getPoison(whichUnit) , during )
	endmethod
	public static method setPoison takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_POISON , whichUnit , value - getPoison(whichUnit) , during )
	endmethod
	//持续
	public static method getPoisonDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_POISON , whichUnit )
	endmethod
	public static method coverPoisonDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_POISON , whichUnit , math.oddsAttrEffect(getPoisonDuring(whichUnit),value)-getPoisonDuring(whichUnit) , during )
	endmethod
	public static method setPoisonDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_POISON , whichUnit , value - getPoison(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[dry] ------------------------------------------------------------ */
	public static method getDry takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DRY , whichUnit )
	endmethod
	public static method coverDry takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DRY , whichUnit , math.oddsAttrEffect(getDry(whichUnit),value)-getDry(whichUnit) , during )
	endmethod
	public static method setDry takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DRY , whichUnit , value - getDry(whichUnit) , during )
	endmethod
	//持续
	public static method getDryDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_DRY , whichUnit )
	endmethod
	public static method coverDryDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_DRY , whichUnit , math.oddsAttrEffect(getDryDuring(whichUnit),value)-getDryDuring(whichUnit) , during )
	endmethod
	public static method setDryDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_DRY , whichUnit , value - getDry(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[freeze] ------------------------------------------------------------ */
	public static method getFreeze takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_FREEZE , whichUnit )
	endmethod
	public static method coverFreeze takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FREEZE , whichUnit , math.oddsAttrEffect(getFreeze(whichUnit),value)-getFreeze(whichUnit) , during )
	endmethod
	public static method setFreeze takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FREEZE , whichUnit , value - getFreeze(whichUnit) , during )
	endmethod
	//持续
	public static method getFreezeDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_FREEZE , whichUnit )
	endmethod
	public static method coverFreezeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FREEZE , whichUnit , math.oddsAttrEffect(getFreezeDuring(whichUnit),value)-getFreezeDuring(whichUnit) , during )
	endmethod
	public static method setFreezeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FREEZE , whichUnit , value - getFreeze(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[cold] ------------------------------------------------------------ */
	public static method getCold takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_COLD , whichUnit )
	endmethod
	public static method coverCold takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_COLD , whichUnit , math.oddsAttrEffect(getCold(whichUnit),value)-getCold(whichUnit) , during )
	endmethod
	public static method setCold takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_COLD , whichUnit , value - getCold(whichUnit) , during )
	endmethod
	//持续
	public static method getColdDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_COLD , whichUnit )
	endmethod
	public static method coverColdDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_COLD , whichUnit , math.oddsAttrEffect(getColdDuring(whichUnit),value)-getColdDuring(whichUnit) , during )
	endmethod
	public static method setColdDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_COLD , whichUnit , value - getCold(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[blunt] ------------------------------------------------------------ */
	public static method getBlunt takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BLUNT , whichUnit )
	endmethod
	public static method coverBlunt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLUNT , whichUnit , math.oddsAttrEffect(getBlunt(whichUnit),value)-getBlunt(whichUnit) , during )
	endmethod
	public static method setBlunt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLUNT , whichUnit , value - getBlunt(whichUnit) , during )
	endmethod
	//持续
	public static method getBluntDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BLUNT , whichUnit )
	endmethod
	public static method coverBluntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLUNT , whichUnit , math.oddsAttrEffect(getBluntDuring(whichUnit),value)-getBluntDuring(whichUnit) , during )
	endmethod
	public static method setBluntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLUNT , whichUnit , value - getBlunt(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[corrosion] ------------------------------------------------------------ */
	public static method getCorrosion takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_CORROSION , whichUnit )
	endmethod
	public static method coverCorrosion takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CORROSION , whichUnit , math.oddsAttrEffect(getCorrosion(whichUnit),value)-getCorrosion(whichUnit) , during )
	endmethod
	public static method setCorrosion takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CORROSION , whichUnit , value - getCorrosion(whichUnit) , during )
	endmethod
	//持续
	public static method getCorrosionDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_CORROSION , whichUnit )
	endmethod
	public static method coverCorrosionDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CORROSION , whichUnit , math.oddsAttrEffect(getCorrosionDuring(whichUnit),value)-getCorrosionDuring(whichUnit) , during )
	endmethod
	public static method setCorrosionDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CORROSION , whichUnit , value - getCorrosion(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[chaos] ------------------------------------------------------------ */
	public static method getChaos takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_CHAOS , whichUnit )
	endmethod
	public static method coverChaos takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CHAOS , whichUnit , math.oddsAttrEffect(getChaos(whichUnit),value)-getChaos(whichUnit) , during )
	endmethod
	public static method setChaos takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CHAOS , whichUnit , value - getChaos(whichUnit) , during )
	endmethod
	//持续
	public static method getChaosDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_CHAOS , whichUnit )
	endmethod
	public static method coverChaosDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CHAOS , whichUnit , math.oddsAttrEffect(getChaosDuring(whichUnit),value)-getChaosDuring(whichUnit) , during )
	endmethod
	public static method setChaosDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CHAOS , whichUnit , value - getChaos(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[twine] ------------------------------------------------------------ */
	public static method getTwine takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_TWINE , whichUnit )
	endmethod
	public static method coverTwine takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TWINE , whichUnit , math.oddsAttrEffect(getTwine(whichUnit),value)-getTwine(whichUnit) , during )
	endmethod
	public static method setTwine takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TWINE , whichUnit , value - getTwine(whichUnit) , during )
	endmethod
	//持续
	public static method getTwineDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_TWINE , whichUnit )
	endmethod
	public static method coverTwineDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TWINE , whichUnit , math.oddsAttrEffect(getTwineDuring(whichUnit),value)-getTwineDuring(whichUnit) , during )
	endmethod
	public static method setTwineDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TWINE , whichUnit , value - getTwine(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[blind] ------------------------------------------------------------ */
	public static method getBlind takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BLIND , whichUnit )
	endmethod
	public static method coverBlind takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLIND , whichUnit , math.oddsAttrEffect(getBlind(whichUnit),value)-getBlind(whichUnit) , during )
	endmethod
	public static method setBlind takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLIND , whichUnit , value - getBlind(whichUnit) , during )
	endmethod
	//持续
	public static method getBlindDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BLIND , whichUnit )
	endmethod
	public static method coverBlindDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLIND , whichUnit , math.oddsAttrEffect(getBlindDuring(whichUnit),value)-getBlindDuring(whichUnit) , during )
	endmethod
	public static method setBlindDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLIND , whichUnit , value - getBlind(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[tortua] ------------------------------------------------------------ */
	public static method getTortua takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_TORTUA , whichUnit )
	endmethod
	public static method coverTortua takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TORTUA , whichUnit , math.oddsAttrEffect(getTortua(whichUnit),value)-getTortua(whichUnit) , during )
	endmethod
	public static method setTortua takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TORTUA , whichUnit , value - getTortua(whichUnit) , during )
	endmethod
	//持续
	public static method getTortuaDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_TORTUA , whichUnit )
	endmethod
	public static method coverTortuaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TORTUA , whichUnit , math.oddsAttrEffect(getTortuaDuring(whichUnit),value)-getTortuaDuring(whichUnit) , during )
	endmethod
	public static method setTortuaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TORTUA , whichUnit , value - getTortua(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[weak] ------------------------------------------------------------ */
	public static method getWeak takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_WEAK , whichUnit )
	endmethod
	public static method coverWeak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_WEAK , whichUnit , math.oddsAttrEffect(getWeak(whichUnit),value)-getWeak(whichUnit) , during )
	endmethod
	public static method setWeak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_WEAK , whichUnit , value - getWeak(whichUnit) , during )
	endmethod
	//持续
	public static method getWeakDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_WEAK , whichUnit )
	endmethod
	public static method coverWeakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_WEAK , whichUnit , math.oddsAttrEffect(getWeakDuring(whichUnit),value)-getWeakDuring(whichUnit) , during )
	endmethod
	public static method setWeakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_WEAK , whichUnit , value - getWeak(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[bound] ------------------------------------------------------------ */
	public static method getBound takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BOUND , whichUnit )
	endmethod
	public static method coverBound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BOUND , whichUnit , math.oddsAttrEffect(getBound(whichUnit),value)-getBound(whichUnit) , during )
	endmethod
	public static method setBound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BOUND , whichUnit , value - getBound(whichUnit) , during )
	endmethod
	//持续
	public static method getBoundDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BOUND , whichUnit )
	endmethod
	public static method coverBoundDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BOUND , whichUnit , math.oddsAttrEffect(getBoundDuring(whichUnit),value)-getBoundDuring(whichUnit) , during )
	endmethod
	public static method setBoundDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BOUND , whichUnit , value - getBound(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[foolish] ------------------------------------------------------------ */
	public static method getFoolish takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_FOOLISH , whichUnit )
	endmethod
	public static method coverFoolish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FOOLISH , whichUnit , math.oddsAttrEffect(getFoolish(whichUnit),value)-getFoolish(whichUnit) , during )
	endmethod
	public static method setFoolish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FOOLISH , whichUnit , value - getFoolish(whichUnit) , during )
	endmethod
	//持续
	public static method getFoolishDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_FOOLISH , whichUnit )
	endmethod
	public static method coverFoolishDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FOOLISH , whichUnit , math.oddsAttrEffect(getFoolishDuring(whichUnit),value)-getFoolishDuring(whichUnit) , during )
	endmethod
	public static method setFoolishDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FOOLISH , whichUnit , value - getFoolish(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[lazy] ------------------------------------------------------------ */
	public static method getLazy takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_LAZY , whichUnit )
	endmethod
	public static method coverLazy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LAZY , whichUnit , math.oddsAttrEffect(getLazy(whichUnit),value)-getLazy(whichUnit) , during )
	endmethod
	public static method setLazy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LAZY , whichUnit , value - getLazy(whichUnit) , during )
	endmethod
	//持续
	public static method getLazyDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_LAZY , whichUnit )
	endmethod
	public static method coverLazyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LAZY , whichUnit , math.oddsAttrEffect(getLazyDuring(whichUnit),value)-getLazyDuring(whichUnit) , during )
	endmethod
	public static method setLazyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LAZY , whichUnit , value - getLazy(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[swim] ------------------------------------------------------------ */
	public static method getSwim takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_SWIM , whichUnit )
	endmethod
	public static method coverSwim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SWIM , whichUnit , math.oddsAttrEffect(getSwim(whichUnit),value)-getSwim(whichUnit) , during )
	endmethod
	public static method setSwim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SWIM , whichUnit , value - getSwim(whichUnit) , during )
	endmethod
	//持续
	public static method getSwimDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_SWIM , whichUnit )
	endmethod
	public static method coverSwimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SWIM , whichUnit , math.oddsAttrEffect(getSwimDuring(whichUnit),value)-getSwimDuring(whichUnit) , during )
	endmethod
	public static method setSwimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SWIM , whichUnit , value - getSwim(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[break] ------------------------------------------------------------ */
	public static method getBreak takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BREAK , whichUnit )
	endmethod
	public static method coverBreak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BREAK , whichUnit , math.oddsAttrEffect(getBreak(whichUnit),value)-getBreak(whichUnit) , during )
	endmethod
	public static method setBreak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BREAK , whichUnit , value - getBreak(whichUnit) , during )
	endmethod
	//持续
	public static method getBreakDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BREAK , whichUnit )
	endmethod
	public static method coverBreakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BREAK , whichUnit , math.oddsAttrEffect(getBreakDuring(whichUnit),value)-getBreakDuring(whichUnit) , during )
	endmethod
	public static method setBreakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BREAK , whichUnit , value - getBreak(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[heavy] ------------------------------------------------------------ */
	public static method getHeavy takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HEAVY , whichUnit )
	endmethod
	public static method coverHeavy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEAVY , whichUnit , math.oddsAttrEffect(getHeavy(whichUnit),value)-getHeavy(whichUnit) , during )
	endmethod
	public static method setHeavy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEAVY , whichUnit , value - getHeavy(whichUnit) , during )
	endmethod
	//持续
	public static method getHeavyDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HEAVY , whichUnit )
	endmethod
	public static method coverHeavyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEAVY , whichUnit , math.oddsAttrEffect(getHeavyDuring(whichUnit),value)-getHeavyDuring(whichUnit) , during )
	endmethod
	public static method setHeavyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEAVY , whichUnit , value - getHeavy(whichUnit) , during )
	endmethod
	/* 攻击|伤害特效[unluck] ------------------------------------------------------------ */
	public static method getUnluck takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_UNLUCK , whichUnit )
	endmethod
	public static method coverUnluck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_UNLUCK , whichUnit , math.oddsAttrEffect(getUnluck(whichUnit),value)-getUnluck(whichUnit) , during )
	endmethod
	public static method setUnluck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_UNLUCK , whichUnit , value - getUnluck(whichUnit) , during )
	endmethod
	//持续
	public static method getUnluckDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_UNLUCK , whichUnit )
	endmethod
	public static method coverUnluckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_UNLUCK , whichUnit , math.oddsAttrEffect(getUnluckDuring(whichUnit),value)-getUnluckDuring(whichUnit) , during )
	endmethod
	public static method setUnluckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_UNLUCK , whichUnit , value - getUnluck(whichUnit) , during )
	endmethod

	/**
     * 打印某个单位的攻击特效到桌面
     */
    public static method showAttr takes unit whichUnit returns nothing
		call console.info("攻击特效#life_back："+R2S(getLifeBack(whichUnit))+"("+R2S(getLifeBackDuring(whichUnit))+")")
		call console.info("攻击特效#mana_back："+R2S(getManaBack(whichUnit))+"("+R2S(getManaBackDuring(whichUnit))+")")
		call console.info("攻击特效#attack_speed："+R2S(getAttackSpeed(whichUnit))+"("+R2S(getAttackSpeedDuring(whichUnit))+")")
		call console.info("攻击特效#attack_physical："+R2S(getAttackPhysical(whichUnit))+"("+R2S(getAttackPhysicalDuring(whichUnit))+")")
		call console.info("攻击特效#attack_magic："+R2S(getAttackMagic(whichUnit))+"("+R2S(getAttackMagicDuring(whichUnit))+")")
		call console.info("攻击特效#move："+R2S(getMove(whichUnit))+"("+R2S(getMoveDuring(whichUnit))+")")
		call console.info("攻击特效#aim："+R2S(getAim(whichUnit))+"("+R2S(getAimDuring(whichUnit))+")")
		call console.info("攻击特效#str："+R2S(getStr(whichUnit))+"("+R2S(getStrDuring(whichUnit))+")")
		call console.info("攻击特效#agi："+R2S(getAgi(whichUnit))+"("+R2S(getAgiDuring(whichUnit))+")")
		call console.info("攻击特效#int："+R2S(getInt(whichUnit))+"("+R2S(getIntDuring(whichUnit))+")")
		call console.info("攻击特效#knocking："+R2S(getKnocking(whichUnit))+"("+R2S(getKnockingDuring(whichUnit))+")")
		call console.info("攻击特效#violence："+R2S(getViolence(whichUnit))+"("+R2S(getViolenceDuring(whichUnit))+")")
		call console.info("攻击特效#hemophagia："+R2S(getHemophagia(whichUnit))+"("+R2S(getHemophagiaDuring(whichUnit))+")")
		call console.info("攻击特效#hemophagia_skill："+R2S(getHemophagiaSkill(whichUnit))+"("+R2S(getHemophagiaSkillDuring(whichUnit))+")")
		call console.info("攻击特效#split："+R2S(getSplit(whichUnit))+"("+R2S(getSplitDuring(whichUnit))+")")
		call console.info("攻击特效#luck："+R2S(getLuck(whichUnit))+"("+R2S(getLuckDuring(whichUnit))+")")
		call console.info("攻击特效#hunt_amplitude："+R2S(getHuntAmplitude(whichUnit))+"("+R2S(getHuntAmplitudeDuring(whichUnit))+")")
		call console.info("攻击特效#poison："+R2S(getPoison(whichUnit))+"("+R2S(getPoisonDuring(whichUnit))+")")
		call console.info("攻击特效#dry："+R2S(getDry(whichUnit))+"("+R2S(getDryDuring(whichUnit))+")")
		call console.info("攻击特效#freeze："+R2S(getFreeze(whichUnit))+"("+R2S(getFreezeDuring(whichUnit))+")")
		call console.info("攻击特效#cold："+R2S(getCold(whichUnit))+"("+R2S(getColdDuring(whichUnit))+")")
		call console.info("攻击特效#blunt："+R2S(getBlunt(whichUnit))+"("+R2S(getBluntDuring(whichUnit))+")")
		call console.info("攻击特效#corrosion："+R2S(getCorrosion(whichUnit))+"("+R2S(getCorrosionDuring(whichUnit))+")")
		call console.info("攻击特效#chaos："+R2S(getChaos(whichUnit))+"("+R2S(getChaosDuring(whichUnit))+")")
		call console.info("攻击特效#twine："+R2S(getTwine(whichUnit))+"("+R2S(getTwineDuring(whichUnit))+")")
		call console.info("攻击特效#blind："+R2S(getBlind(whichUnit))+"("+R2S(getBlindDuring(whichUnit))+")")
		call console.info("攻击特效#tortua："+R2S(getTortua(whichUnit))+"("+R2S(getTortuaDuring(whichUnit))+")")
		call console.info("攻击特效#weak："+R2S(getWeak(whichUnit))+"("+R2S(getWeakDuring(whichUnit))+")")
		call console.info("攻击特效#bound："+R2S(getBound(whichUnit))+"("+R2S(getBoundDuring(whichUnit))+")")
		call console.info("攻击特效#foolish："+R2S(getFoolish(whichUnit))+"("+R2S(getFoolishDuring(whichUnit))+")")
		call console.info("攻击特效#lazy："+R2S(getLazy(whichUnit))+"("+R2S(getLazyDuring(whichUnit))+")")
		call console.info("攻击特效#swim："+R2S(getSwim(whichUnit))+"("+R2S(getSwimDuring(whichUnit))+")")
		call console.info("攻击特效#break："+R2S(getBreak(whichUnit))+"("+R2S(getBreakDuring(whichUnit))+")")
		call console.info("攻击特效#heavy："+R2S(getHeavy(whichUnit))+"("+R2S(getHeavyDuring(whichUnit))+")")
		call console.info("攻击特效#unluck："+R2S(getUnluck(whichUnit))+"("+R2S(getUnluckDuring(whichUnit))+")")
    endmethod

endstruct
