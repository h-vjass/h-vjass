globals
	hAttrExt hattrExt = 0
	hashtable hash_attr_ext = InitHashtable()
	integer ATTR_EXT_FLAG_UP_EFFECT_UNIT = 10000
    integer ATTR_EXT_FLAG_UP_EFFECT_CD = 10010
    //--
	integer ATTR_EXT_FLAG_UP_LIFE_BACK = 1001
	integer ATTR_EXT_FLAG_UP_LIFE_SOURCE = 1002
	integer ATTR_EXT_FLAG_UP_LIFE_SOURCE_CURRENT = 1003
	integer ATTR_EXT_FLAG_UP_MANA_BACK = 1004
	integer ATTR_EXT_FLAG_UP_MANA_SOURCE = 1005
	integer ATTR_EXT_FLAG_UP_MANA_SOURCE_CURRENT = 1006
	integer ATTR_EXT_FLAG_UP_RESISTANCE = 1007
	integer ATTR_EXT_FLAG_UP_TOUGHNESS = 1008
	integer ATTR_EXT_FLAG_UP_AVOID = 1009
	integer ATTR_EXT_FLAG_UP_AIM = 1010
	integer ATTR_EXT_FLAG_UP_KNOCKING = 1011
	integer ATTR_EXT_FLAG_UP_VIOLENCE = 1012
	integer ATTR_EXT_FLAG_UP_MORTAL_OPPOSE = 1013
	integer ATTR_EXT_FLAG_UP_PUNISH = 1014
	integer ATTR_EXT_FLAG_UP_PUNISH_CURRENT = 1015
	integer ATTR_EXT_FLAG_UP_PUNISH_OPPOSE = 1016
	integer ATTR_EXT_FLAG_UP_MEDITATIVE = 1017
	integer ATTR_EXT_FLAG_UP_HELP = 1018
	integer ATTR_EXT_FLAG_UP_HEMOPHAGIA = 1019
	integer ATTR_EXT_FLAG_UP_HEMOPHAGIA_SKILL = 1020
	integer ATTR_EXT_FLAG_UP_SPLIT = 1021
	integer ATTR_EXT_FLAG_UP_GOLD_RATIO = 1022
	integer ATTR_EXT_FLAG_UP_LUMBER_RATIO = 1023
	integer ATTR_EXT_FLAG_UP_EXP_RATIO = 1024
	integer ATTR_EXT_FLAG_UP_SWIM_OPPOSE = 1025
	integer ATTR_EXT_FLAG_UP_LUCK = 1026
	integer ATTR_EXT_FLAG_UP_INVINCIBLE = 1027
	integer ATTR_EXT_FLAG_UP_WEIGHT = 1028
	integer ATTR_EXT_FLAG_UP_WEIGHT_CURRENT = 1029
	integer ATTR_EXT_FLAG_UP_HUNT_AMPLITUDE = 1030
	integer ATTR_EXT_FLAG_UP_HUNT_REBOUND = 1031
	integer ATTR_EXT_FLAG_UP_CURE = 1032
endglobals

struct hAttrExt

	static method create takes nothing returns hAttrExt
        local hAttrExt x = 0
        set x = hAttrExt.allocate()
        return x
    endmethod
	
	/* 设定属性(即时/计时) */
	private static method setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local real currentVal = 0
		local real futureVal = 0
		local real tempPercent = 0
		if(diff != 0)then
			if( flag == ATTR_EXT_FLAG_UP_PUNISH ) then
				set currentVal = LoadReal( hash_attr_ext , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr_ext , uhid , flag , futureVal )
				if( currentVal > 0 ) then
					set tempPercent = futureVal / currentVal
					call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH_CURRENT , tempPercent*LoadReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH_CURRENT ) )
				else
					call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH_CURRENT , futureVal )
				endif
			elseif( flag == ATTR_EXT_FLAG_UP_PUNISH_CURRENT ) then
				set currentVal = LoadReal( hash_attr_ext , uhid , flag )
				set futureVal = currentVal + diff
				if( futureVal > LoadReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH ) ) then
					set futureVal = LoadReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH )
				endif
				call SaveReal( hash_attr_ext , uhid , flag , futureVal )
			else
				call SaveReal( hash_attr_ext , uhid , flag , LoadReal( hash_attr_ext , uhid , flag ) + diff )
			endif
		endif
	endmethod

	/* 验证单位是否初始化过参数 */
	public static method initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_EFFECT_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_EFFECT_UNIT , uhid )
			//
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_LIFE_BACK , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_LIFE_SOURCE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_LIFE_SOURCE_CURRENT , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_MANA_BACK , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_MANA_SOURCE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_MANA_SOURCE_CURRENT , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_RESISTANCE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_TOUGHNESS , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_AVOID , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_AIM , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_KNOCKING , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_VIOLENCE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_MORTAL_OPPOSE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH_CURRENT , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH_OPPOSE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_MEDITATIVE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_HELP , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_HEMOPHAGIA , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_SPLIT , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_GOLD_RATIO , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_LUMBER_RATIO , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_EXP_RATIO , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_SWIM_OPPOSE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_LUCK , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_INVINCIBLE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_WEIGHT , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_WEIGHT_CURRENT , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_HUNT_REBOUND , 0 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_CURE , 0 )
			//todo 设定默认值
			if( his.hero(whichUnit) ) then
				//白字
				set tempReal = I2R(GetHeroStr(whichUnit, false))
				call setAttrDo( ATTR_EXT_FLAG_UP_TOUGHNESS , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_EXT_FLAG_UP_KNOCKING , whichUnit , tempReal*5 )
				call setAttrDo( ATTR_EXT_FLAG_UP_SWIM_OPPOSE , whichUnit , tempReal*0.03 )
				set tempReal = I2R(GetHeroAgi(whichUnit, false))
				call setAttrDo( ATTR_EXT_FLAG_UP_KNOCKING , whichUnit , tempReal*3 )
				call setAttrDo( ATTR_EXT_FLAG_UP_AVOID , whichUnit , tempReal*0.02 )
				set tempReal = I2R(GetHeroInt(whichUnit, false))
				call setAttrDo( ATTR_EXT_FLAG_UP_MANA_BACK , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_EXT_FLAG_UP_VIOLENCE , whichUnit , tempReal*10 )
				call setAttrDo( ATTR_EXT_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , tempReal*0.02 )
				//救助力
				call setAttrDo( ATTR_EXT_FLAG_UP_HELP , whichUnit , 100 + 2 * I2R(GetHeroLevel(whichUnit)-1) )
				//负重
				call setAttrDo( ATTR_EXT_FLAG_UP_WEIGHT , whichUnit , 10.00 + 0.25 * I2R(GetHeroLevel(whichUnit)-1) )
				//源
				call setAttrDo( ATTR_EXT_FLAG_UP_LIFE_SOURCE , whichUnit , 500 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_EXT_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , 500 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_EXT_FLAG_UP_MANA_SOURCE , whichUnit , 300 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_EXT_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , 300 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
			endif
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)/2 )
			call SaveReal( hash_attr_ext , uhid , ATTR_EXT_FLAG_UP_PUNISH_CURRENT , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)/2 )

			return true
		endif
		return false
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
		return LoadReal( hash_attr_ext , GetHandleId(whichUnit) , flag )
	endmethod



	//--------------------------------------------------------------------------------------------

	/* 高级属性[life_back] ------------------------------------------------------------ */
	public static method getLifeBack takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_LIFE_BACK , whichUnit )
	endmethod
	public static method addLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_BACK , whichUnit , value , during )
	endmethod
	public static method subLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_BACK , whichUnit , -value , during )
	endmethod
	public static method setLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
	endmethod
	/* 高级属性[life_source] ------------------------------------------------------------ */
	public static method getLifeSource takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE , whichUnit )
	endmethod
	public static method addLifeSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE , whichUnit , value , during )
	endmethod
	public static method subLifeSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE , whichUnit , -value , during )
	endmethod
	public static method setLifeSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE , whichUnit , value - getLifeSource(whichUnit) , during )
	endmethod
	/* 高级属性[life_source_current] ------------------------------------------------------------ */
	public static method getLifeSourceCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit )
	endmethod
	public static method addLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , value , during )
	endmethod
	public static method subLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , -value , during )
	endmethod
	public static method setLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , value - getLifeSourceCurrent(whichUnit) , during )
	endmethod
	/* 高级属性[mana_back] ------------------------------------------------------------ */
	public static method getManaBack takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_MANA_BACK , whichUnit )
	endmethod
	public static method addManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_BACK , whichUnit , value , during )
	endmethod
	public static method subManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_BACK , whichUnit , -value , during )
	endmethod
	public static method setManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
	endmethod
	/* 高级属性[mana_source] ------------------------------------------------------------ */
	public static method getManaSource takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE , whichUnit )
	endmethod
	public static method addManaSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE , whichUnit , value , during )
	endmethod
	public static method subManaSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE , whichUnit , -value , during )
	endmethod
	public static method setManaSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE , whichUnit , value - getManaSource(whichUnit) , during )
	endmethod
	/* 高级属性[mana_source_current] ------------------------------------------------------------ */
	public static method getManaSourceCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit )
	endmethod
	public static method addManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , value , during )
	endmethod
	public static method subManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , -value , during )
	endmethod
	public static method setManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , value - getManaSourceCurrent(whichUnit) , during )
	endmethod
	/* 高级属性[resistance] ------------------------------------------------------------ */
	public static method getResistance takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_RESISTANCE , whichUnit )
	endmethod
	public static method addResistance takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_RESISTANCE , whichUnit , value , during )
	endmethod
	public static method subResistance takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_RESISTANCE , whichUnit , -value , during )
	endmethod
	public static method setResistance takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_RESISTANCE , whichUnit , value - getResistance(whichUnit) , during )
	endmethod
	/* 高级属性[toughness] ------------------------------------------------------------ */
	public static method getToughness takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_TOUGHNESS , whichUnit )
	endmethod
	public static method addToughness takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_TOUGHNESS , whichUnit , value , during )
	endmethod
	public static method subToughness takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_TOUGHNESS , whichUnit , -value , during )
	endmethod
	public static method setToughness takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_TOUGHNESS , whichUnit , value - getToughness(whichUnit) , during )
	endmethod
	/* 高级属性[avoid] ------------------------------------------------------------ */
	public static method getAvoid takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_AVOID , whichUnit )
	endmethod
	public static method addAvoid takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_AVOID , whichUnit , value , during )
	endmethod
	public static method subAvoid takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_AVOID , whichUnit , -value , during )
	endmethod
	public static method setAvoid takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_AVOID , whichUnit , value - getAvoid(whichUnit) , during )
	endmethod
	/* 高级属性[aim] ------------------------------------------------------------ */
	public static method getAim takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_AIM , whichUnit )
	endmethod
	public static method addAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_AIM , whichUnit , value , during )
	endmethod
	public static method subAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_AIM , whichUnit , -value , during )
	endmethod
	public static method setAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_AIM , whichUnit , value - getAim(whichUnit) , during )
	endmethod
	/* 高级属性[knocking] ------------------------------------------------------------ */
	public static method getKnocking takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_KNOCKING , whichUnit )
	endmethod
	public static method addKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_KNOCKING , whichUnit , value , during )
	endmethod
	public static method subKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_KNOCKING , whichUnit , -value , during )
	endmethod
	public static method setKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
	endmethod
	/* 高级属性[violence] ------------------------------------------------------------ */
	public static method getViolence takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_VIOLENCE , whichUnit )
	endmethod
	public static method addViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_VIOLENCE , whichUnit , value , during )
	endmethod
	public static method subViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_VIOLENCE , whichUnit , -value , during )
	endmethod
	public static method setViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
	endmethod
	/* 高级属性[mortal_oppose] ------------------------------------------------------------ */
	public static method getMortalOppose takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_MORTAL_OPPOSE , whichUnit )
	endmethod
	public static method addMortalOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MORTAL_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subMortalOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MORTAL_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setMortalOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MORTAL_OPPOSE , whichUnit , value - getMortalOppose(whichUnit) , during )
	endmethod
	/* 高级属性[punish] ------------------------------------------------------------ */
	public static method getPunish takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_PUNISH , whichUnit )
	endmethod
	public static method addPunish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH , whichUnit , value , during )
	endmethod
	public static method subPunish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH , whichUnit , -value , during )
	endmethod
	public static method setPunish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH , whichUnit , value - getPunish(whichUnit) , during )
	endmethod
	/* 高级属性[punish_current] ------------------------------------------------------------ */
	public static method getPunishCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_PUNISH_CURRENT , whichUnit )
	endmethod
	public static method addPunishCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH_CURRENT , whichUnit , value , during )
	endmethod
	public static method subPunishCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH_CURRENT , whichUnit , -value , during )
	endmethod
	public static method setPunishCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH_CURRENT , whichUnit , value - getPunishCurrent(whichUnit) , during )
	endmethod
	/* 高级属性[punish_oppose] ------------------------------------------------------------ */
	public static method getPunishOppose takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_PUNISH_OPPOSE , whichUnit )
	endmethod
	public static method addPunishOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subPunishOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setPunishOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_PUNISH_OPPOSE , whichUnit , value - getPunishOppose(whichUnit) , during )
	endmethod
	/* 高级属性[meditative] ------------------------------------------------------------ */
	public static method getMeditative takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_MEDITATIVE , whichUnit )
	endmethod
	public static method addMeditative takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MEDITATIVE , whichUnit , value , during )
	endmethod
	public static method subMeditative takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MEDITATIVE , whichUnit , -value , during )
	endmethod
	public static method setMeditative takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_MEDITATIVE , whichUnit , value - getMeditative(whichUnit) , during )
	endmethod
	/* 高级属性[help] ------------------------------------------------------------ */
	public static method getHelp takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_HELP , whichUnit )
	endmethod
	public static method addHelp takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HELP , whichUnit , value , during )
	endmethod
	public static method subHelp takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HELP , whichUnit , -value , during )
	endmethod
	public static method setHelp takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HELP , whichUnit , value - getHelp(whichUnit) , during )
	endmethod
	/* 高级属性[hemophagia] ------------------------------------------------------------ */
	public static method getHemophagia takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA , whichUnit )
	endmethod
	public static method addHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA , whichUnit , value , during )
	endmethod
	public static method subHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA , whichUnit , -value , during )
	endmethod
	public static method setHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
	endmethod
	/* 高级属性[hemophagia_skill] ------------------------------------------------------------ */
	public static method getHemophagiaSkill takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit )
	endmethod
	public static method addHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , value , during )
	endmethod
	public static method subHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , -value , during )
	endmethod
	public static method setHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
	endmethod
	/* 高级属性[split] ------------------------------------------------------------ */
	public static method getSplit takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_SPLIT , whichUnit )
	endmethod
	public static method addSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_SPLIT , whichUnit , value , during )
	endmethod
	public static method subSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_SPLIT , whichUnit , -value , during )
	endmethod
	public static method setSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
	endmethod
	/* 高级属性[gold_ratio] ------------------------------------------------------------ */
	public static method getGoldRatio takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_GOLD_RATIO , whichUnit )
	endmethod
	public static method addGoldRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_GOLD_RATIO , whichUnit , value , during )
	endmethod
	public static method subGoldRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_GOLD_RATIO , whichUnit , -value , during )
	endmethod
	public static method setGoldRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_GOLD_RATIO , whichUnit , value - getGoldRatio(whichUnit) , during )
	endmethod
	/* 高级属性[lumber_ratio] ------------------------------------------------------------ */
	public static method getLumberRatio takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_LUMBER_RATIO , whichUnit )
	endmethod
	public static method addLumberRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LUMBER_RATIO , whichUnit , value , during )
	endmethod
	public static method subLumberRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LUMBER_RATIO , whichUnit , -value , during )
	endmethod
	public static method setLumberRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LUMBER_RATIO , whichUnit , value - getLumberRatio(whichUnit) , during )
	endmethod
	/* 高级属性[exp_ratio] ------------------------------------------------------------ */
	public static method getExpRatio takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_EXP_RATIO , whichUnit )
	endmethod
	public static method addExpRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_EXP_RATIO , whichUnit , value , during )
	endmethod
	public static method subExpRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_EXP_RATIO , whichUnit , -value , during )
	endmethod
	public static method setExpRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_EXP_RATIO , whichUnit , value - getExpRatio(whichUnit) , during )
	endmethod
	/* 高级属性[swim_oppose] ------------------------------------------------------------ */
	public static method getSwimOppose takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_SWIM_OPPOSE , whichUnit )
	endmethod
	public static method addSwimOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_SWIM_OPPOSE , whichUnit , value , during )
	endmethod
	public static method subSwimOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_SWIM_OPPOSE , whichUnit , -value , during )
	endmethod
	public static method setSwimOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_SWIM_OPPOSE , whichUnit , value - getSwimOppose(whichUnit) , during )
	endmethod
	/* 高级属性[luck] ------------------------------------------------------------ */
	public static method getLuck takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_LUCK , whichUnit )
	endmethod
	public static method addLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LUCK , whichUnit , value , during )
	endmethod
	public static method subLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LUCK , whichUnit , -value , during )
	endmethod
	public static method setLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_LUCK , whichUnit , value - getLuck(whichUnit) , during )
	endmethod
	/* 高级属性[invincible] ------------------------------------------------------------ */
	public static method getInvincible takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_INVINCIBLE , whichUnit )
	endmethod
	public static method addInvincible takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_INVINCIBLE , whichUnit , value , during )
	endmethod
	public static method subInvincible takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_INVINCIBLE , whichUnit , -value , during )
	endmethod
	public static method setInvincible takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_INVINCIBLE , whichUnit , value - getInvincible(whichUnit) , during )
	endmethod
	/* 高级属性[weight] ------------------------------------------------------------ */
	public static method getWeight takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_WEIGHT , whichUnit )
	endmethod
	public static method addWeight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_WEIGHT , whichUnit , value , during )
	endmethod
	public static method subWeight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_WEIGHT , whichUnit , -value , during )
	endmethod
	public static method setWeight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_WEIGHT , whichUnit , value - getWeight(whichUnit) , during )
	endmethod
	/* 高级属性[weight_current] ------------------------------------------------------------ */
	public static method getWeightCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_WEIGHT_CURRENT , whichUnit )
	endmethod
	public static method addWeightCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_WEIGHT_CURRENT , whichUnit , value , during )
	endmethod
	public static method subWeightCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_WEIGHT_CURRENT , whichUnit , -value , during )
	endmethod
	public static method setWeightCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_WEIGHT_CURRENT , whichUnit , value - getWeightCurrent(whichUnit) , during )
	endmethod
	/* 高级属性[hunt_amplitude] ------------------------------------------------------------ */
	public static method getHuntAmplitude takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_HUNT_AMPLITUDE , whichUnit )
	endmethod
	public static method addHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HUNT_AMPLITUDE , whichUnit , value , during )
	endmethod
	public static method subHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HUNT_AMPLITUDE , whichUnit , -value , during )
	endmethod
	public static method setHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , during )
	endmethod
	/* 高级属性[hunt_rebound] ------------------------------------------------------------ */
	public static method getHuntRebound takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_HUNT_REBOUND , whichUnit )
	endmethod
	public static method addHuntRebound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HUNT_REBOUND , whichUnit , value , during )
	endmethod
	public static method subHuntRebound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HUNT_REBOUND , whichUnit , -value , during )
	endmethod
	public static method setHuntRebound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_HUNT_REBOUND , whichUnit , value - getHuntRebound(whichUnit) , during )
	endmethod
	/* 高级属性[cure] ------------------------------------------------------------ */
	public static method getCure takes unit whichUnit returns real
	   return getAttr( ATTR_EXT_FLAG_UP_CURE , whichUnit )
	endmethod
	public static method addCure takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_CURE , whichUnit , value , during )
	endmethod
	public static method subCure takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_CURE , whichUnit , -value , during )
	endmethod
	public static method setCure takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_EXT_FLAG_UP_CURE , whichUnit , value - getCure(whichUnit) , during )
	endmethod

	/**
     * 打印某个单位的攻击特效到桌面
     */
    public static method show takes unit whichUnit returns nothing
		call hconsole.info("高级属性#life_back："+R2S(getLifeBack(whichUnit)))
		call hconsole.info("高级属性#life_source："+R2S(getLifeSource(whichUnit)))
		call hconsole.info("高级属性#life_source_current："+R2S(getLifeSourceCurrent(whichUnit)))
		call hconsole.info("高级属性#mana_back："+R2S(getManaBack(whichUnit)))
		call hconsole.info("高级属性#mana_source："+R2S(getManaSource(whichUnit)))
		call hconsole.info("高级属性#mana_source_current："+R2S(getManaSourceCurrent(whichUnit)))
		call hconsole.info("高级属性#resistance："+R2S(getResistance(whichUnit)))
		call hconsole.info("高级属性#toughness："+R2S(getToughness(whichUnit)))
		call hconsole.info("高级属性#avoid："+R2S(getAvoid(whichUnit)))
		call hconsole.info("高级属性#aim："+R2S(getAim(whichUnit)))
		call hconsole.info("高级属性#knocking："+R2S(getKnocking(whichUnit)))
		call hconsole.info("高级属性#violence："+R2S(getViolence(whichUnit)))
		call hconsole.info("高级属性#mortal_oppose："+R2S(getMortalOppose(whichUnit)))
		call hconsole.info("高级属性#punish："+R2S(getPunish(whichUnit)))
		call hconsole.info("高级属性#punish_current："+R2S(getPunishCurrent(whichUnit)))
		call hconsole.info("高级属性#punish_oppose："+R2S(getPunishOppose(whichUnit)))
		call hconsole.info("高级属性#meditative："+R2S(getMeditative(whichUnit)))
		call hconsole.info("高级属性#help："+R2S(getHelp(whichUnit)))
		call hconsole.info("高级属性#hemophagia："+R2S(getHemophagia(whichUnit)))
		call hconsole.info("高级属性#hemophagia_skill："+R2S(getHemophagiaSkill(whichUnit)))
		call hconsole.info("高级属性#split："+R2S(getSplit(whichUnit)))
		call hconsole.info("高级属性#gold_ratio："+R2S(getGoldRatio(whichUnit)))
		call hconsole.info("高级属性#lumber_ratio："+R2S(getLumberRatio(whichUnit)))
		call hconsole.info("高级属性#exp_ratio："+R2S(getExpRatio(whichUnit)))
		call hconsole.info("高级属性#swim_oppose："+R2S(getSwimOppose(whichUnit)))
		call hconsole.info("高级属性#luck："+R2S(getLuck(whichUnit)))
		call hconsole.info("高级属性#invincible："+R2S(getInvincible(whichUnit)))
		call hconsole.info("高级属性#weight："+R2S(getWeight(whichUnit)))
		call hconsole.info("高级属性#weight_current："+R2S(getWeightCurrent(whichUnit)))
		call hconsole.info("高级属性#hunt_amplitude："+R2S(getHuntAmplitude(whichUnit)))
		call hconsole.info("高级属性#hunt_rebound："+R2S(getHuntRebound(whichUnit)))
		call hconsole.info("高级属性#cure："+R2S(getCure(whichUnit)))
    endmethod

endstruct