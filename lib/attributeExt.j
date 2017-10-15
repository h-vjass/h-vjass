
library hAttrExt initializer init needs hEvent
	
	globals
		private hashtable hash = null
		private integer ATTR_FLAG_UP_EFFECT_UNIT = 1000
	    private integer ATTR_FLAG_UP_EFFECT_CD = 1001
	    //--
		private integer ATTR_FLAG_UP_LIFE_BACK = 1001
		private integer ATTR_FLAG_UP_LIFE_SOURCE = 1002
		private integer ATTR_FLAG_UP_LIFE_SOURCE_CURRENT = 1003
		private integer ATTR_FLAG_UP_MANA_BACK = 1004
		private integer ATTR_FLAG_UP_MANA_SOURCE = 1005
		private integer ATTR_FLAG_UP_MANA_SOURCE_CURRENT = 1006
		private integer ATTR_FLAG_UP_RESISTANCE = 1007
		private integer ATTR_FLAG_UP_TOUGHNESS = 1008
		private integer ATTR_FLAG_UP_AVOID = 1009
		private integer ATTR_FLAG_UP_AIM = 1010
		private integer ATTR_FLAG_UP_KNOCKING = 1011
		private integer ATTR_FLAG_UP_VIOLENCE = 1012
		private integer ATTR_FLAG_UP_MORTAL_OPPOSE = 1013
		private integer ATTR_FLAG_UP_PUNISH = 1014
		private integer ATTR_FLAG_UP_PUNISH_CURRENT = 1015
		private integer ATTR_FLAG_UP_MEDITATIVE = 1016
		private integer ATTR_FLAG_UP_HELP = 1017
		private integer ATTR_FLAG_UP_HEMOPHAGIA = 1018
		private integer ATTR_FLAG_UP_HEMOPHAGIA_SKILL = 1019
		private integer ATTR_FLAG_UP_SPLIT = 1020
		private integer ATTR_FLAG_UP_GOLD_RATIO = 1021
		private integer ATTR_FLAG_UP_LUMBER_RATIO = 1022
		private integer ATTR_FLAG_UP_EXP_RATIO = 1023
		private integer ATTR_FLAG_UP_SWIM_OPPOSE = 1024
		private integer ATTR_FLAG_UP_LUCK = 1025
		private integer ATTR_FLAG_UP_INVINCIBLE = 1026
		private integer ATTR_FLAG_UP_WEIGHT = 1027
		private integer ATTR_FLAG_UP_WEIGHT_CURRENT = 1028
		private integer ATTR_FLAG_UP_HUNT_AMPLITUDE = 1029
		private integer ATTR_FLAG_UP_HUNT_REBOUND = 1030
		private integer ATTR_FLAG_UP_CURE = 1031
	endglobals

	/* 设定属性(即时/计时) */
	private function setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local real currentVal = 0
		local real futureVal = 0
		local real tempPercent = 0
		if(diff != 0)then
			if( flag == ATTR_FLAG_UP_PUNISH ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash , uhid , flag , futureVal )
				if( currentVal > 0 ) then
					set tempPercent = futureVal / currentVal
					call SaveReal( hash , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , tempPercent*LoadReal( hash , uhid , ATTR_FLAG_UP_PUNISH_CURRENT ) )
				else
					call SaveReal( hash , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , futureVal )
				endif
			elseif( flag == ATTR_FLAG_UP_PUNISH_CURRENT ) then
				set currentVal = LoadReal( hash , uhid , flag )
				set futureVal = currentVal + diff
				if( futureVal > LoadReal( hash , uhid , ATTR_FLAG_UP_PUNISH ) ) then
					set futureVal = LoadReal( hash , uhid , ATTR_FLAG_UP_PUNISH )
				endif
				call SaveReal( hash , uhid , flag , futureVal )
			else
				call SaveReal( hash , uhid , flag , LoadReal( hash , uhid , flag ) + diff )
			endif
		endif
	endfunction

	/* 验证单位是否初始化过参数 */
	public function initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash , uhid , ATTR_FLAG_UP_EFFECT_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash , uhid , ATTR_FLAG_UP_EFFECT_UNIT , uhid )
			//
			call SaveReal( hash , uhid , ATTR_FLAG_UP_LIFE_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_LIFE_SOURCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_MANA_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_MANA_SOURCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_MANA_SOURCE_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_RESISTANCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_TOUGHNESS , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_AVOID , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_AIM , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_KNOCKING , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_VIOLENCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_MORTAL_OPPOSE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_PUNISH , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_MEDITATIVE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_HELP , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_HEMOPHAGIA , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_SPLIT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_GOLD_RATIO , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_LUMBER_RATIO , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_EXP_RATIO , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_SWIM_OPPOSE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_LUCK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_INVINCIBLE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_WEIGHT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_WEIGHT_CURRENT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_HUNT_REBOUND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_UP_CURE , 0 )
			//todo 设定默认值
			if( is.hero(whichUnit) ) then
				//白字
				set tempReal = I2R(GetHeroStr(whichUnit, false))
				call setAttrDo( ATTR_FLAG_UP_TOUGHNESS , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_FLAG_UP_KNOCKING , whichUnit , tempReal*5 )
				call setAttrDo( ATTR_FLAG_UP_PUNISH , whichUnit , tempReal*10 )
				call setAttrDo( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , tempReal*3 )
				set tempReal = I2R(GetHeroAgi(whichUnit, false))
				call setAttrDo( ATTR_FLAG_UP_KNOCKING , whichUnit , tempReal*3 )
				call setAttrDo( ATTR_FLAG_UP_AVOID , whichUnit , tempReal*5 )
				set tempReal = I2R(GetHeroInt(whichUnit, false))
				call setAttrDo( ATTR_FLAG_UP_MANA_BACK , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_FLAG_UP_VIOLENCE , whichUnit , tempReal*10 )
				call setAttrDo( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , tempReal*0.02 )
				//救助力
				call setAttrDo( ATTR_FLAG_UP_HELP , whichUnit , 100 + 2 * I2R(GetHeroLevel(whichUnit)-1) )
				//负重
				call setAttrDo( ATTR_FLAG_UP_WEIGHT , whichUnit , 10.00 + 0.25 * I2R(GetHeroLevel(whichUnit)-1) )
				//源
				call setAttrDo( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , 500 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , 500 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , 300 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
				call setAttrDo( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , 300 + 10 * I2R(GetHeroLevel(whichUnit)-1) )
			else
				call SaveReal( hash , uhid , ATTR_FLAG_UP_PUNISH , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)*1.5 )
				call SaveReal( hash , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)*1.5 )
			endif
			return true
		endif
		return false
	endfunction

	private function setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = time.getInteger(t,1)
		local unit whichUnit = time.getUnit(t,2)
		local real diff = time.getReal(t,3)
		call time.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
	endfunction

	private function setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr( whichUnit )
		call setAttrDo( flag , whichUnit , diff )
		if( during>0 ) then
			set t = time.setTimeout( during , function setAttrDuring )
			call time.setInteger(t,1,flag)
			call time.setUnit(t,2,whichUnit)
			call time.setReal(t,3, -diff )
		endif
	endfunction

	private function getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash , GetHandleId(whichUnit) , flag )
	endfunction



	//--------------------------------------------------------------------------------------------

	/* 高级属性[life_back] ------------------------------------------------------------ */
	public function getLifeBack takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit )
	endfunction
	public function addLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit , value , during )
	endfunction
	public function subLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit , -value , during )
	endfunction
	public function setLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
	endfunction
	/* 高级属性[life_source] ------------------------------------------------------------ */
	public function getLifeSource takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit )
	endfunction
	public function addLifeSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , value , during )
	endfunction
	public function subLifeSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , -value , during )
	endfunction
	public function setLifeSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , value - getLifeSource(whichUnit) , during )
	endfunction
	/* 高级属性[life_source_current] ------------------------------------------------------------ */
	public function getLifeSourceCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit )
	endfunction
	public function addLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , value , during )
	endfunction
	public function subLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , -value , during )
	endfunction
	public function setLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , value - getLifeSourceCurrent(whichUnit) , during )
	endfunction
	/* 高级属性[mana_back] ------------------------------------------------------------ */
	public function getManaBack takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit )
	endfunction
	public function addManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , value , during )
	endfunction
	public function subManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , -value , during )
	endfunction
	public function setManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
	endfunction
	/* 高级属性[mana_source] ------------------------------------------------------------ */
	public function getManaSource takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit )
	endfunction
	public function addManaSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , value , during )
	endfunction
	public function subManaSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , -value , during )
	endfunction
	public function setManaSource takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , value - getManaSource(whichUnit) , during )
	endfunction
	/* 高级属性[mana_source_current] ------------------------------------------------------------ */
	public function getManaSourceCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit )
	endfunction
	public function addManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , value , during )
	endfunction
	public function subManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , -value , during )
	endfunction
	public function setManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , value - getManaSourceCurrent(whichUnit) , during )
	endfunction
	/* 高级属性[resistance] ------------------------------------------------------------ */
	public function getResistance takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit )
	endfunction
	public function addResistance takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit , value , during )
	endfunction
	public function subResistance takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit , -value , during )
	endfunction
	public function setResistance takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit , value - getResistance(whichUnit) , during )
	endfunction
	/* 高级属性[toughness] ------------------------------------------------------------ */
	public function getToughness takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit )
	endfunction
	public function addToughness takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , value , during )
	endfunction
	public function subToughness takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , -value , during )
	endfunction
	public function setToughness takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , value - getToughness(whichUnit) , during )
	endfunction
	/* 高级属性[avoid] ------------------------------------------------------------ */
	public function getAvoid takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_AVOID , whichUnit )
	endfunction
	public function addAvoid takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , value , during )
	endfunction
	public function subAvoid takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , -value , during )
	endfunction
	public function setAvoid takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , value - getAvoid(whichUnit) , during )
	endfunction
	/* 高级属性[aim] ------------------------------------------------------------ */
	public function getAim takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_AIM , whichUnit )
	endfunction
	public function addAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_AIM , whichUnit , value , during )
	endfunction
	public function subAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_AIM , whichUnit , -value , during )
	endfunction
	public function setAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_AIM , whichUnit , value - getAim(whichUnit) , during )
	endfunction
	/* 高级属性[knocking] ------------------------------------------------------------ */
	public function getKnocking takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_KNOCKING , whichUnit )
	endfunction
	public function addKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , value , during )
	endfunction
	public function subKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , -value , during )
	endfunction
	public function setKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
	endfunction
	/* 高级属性[violence] ------------------------------------------------------------ */
	public function getViolence takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit )
	endfunction
	public function addViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , value , during )
	endfunction
	public function subViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , -value , during )
	endfunction
	public function setViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
	endfunction
	/* 高级属性[mortal_oppose] ------------------------------------------------------------ */
	public function getMortalOppose takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_MORTAL_OPPOSE , whichUnit )
	endfunction
	public function addMortalOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MORTAL_OPPOSE , whichUnit , value , during )
	endfunction
	public function subMortalOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MORTAL_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setMortalOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MORTAL_OPPOSE , whichUnit , value - getMortalOppose(whichUnit) , during )
	endfunction
	/* 高级属性[punish] ------------------------------------------------------------ */
	public function getPunish takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_PUNISH , whichUnit )
	endfunction
	public function addPunish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , value , during )
	endfunction
	public function subPunish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , -value , during )
	endfunction
	public function setPunish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , value - getPunish(whichUnit) , during )
	endfunction
	/* 高级属性[punish_current] ------------------------------------------------------------ */
	public function getPunishCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit )
	endfunction
	public function addPunishCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit , value , during )
	endfunction
	public function subPunishCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit , -value , during )
	endfunction
	public function setPunishCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit , value - getPunishCurrent(whichUnit) , during )
	endfunction
	/* 高级属性[meditative] ------------------------------------------------------------ */
	public function getMeditative takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit )
	endfunction
	public function addMeditative takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit , value , during )
	endfunction
	public function subMeditative takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit , -value , during )
	endfunction
	public function setMeditative takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit , value - getMeditative(whichUnit) , during )
	endfunction
	/* 高级属性[help] ------------------------------------------------------------ */
	public function getHelp takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_HELP , whichUnit )
	endfunction
	public function addHelp takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HELP , whichUnit , value , during )
	endfunction
	public function subHelp takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HELP , whichUnit , -value , during )
	endfunction
	public function setHelp takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HELP , whichUnit , value - getHelp(whichUnit) , during )
	endfunction
	/* 高级属性[hemophagia] ------------------------------------------------------------ */
	public function getHemophagia takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit )
	endfunction
	public function addHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit , value , during )
	endfunction
	public function subHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit , -value , during )
	endfunction
	public function setHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
	endfunction
	/* 高级属性[hemophagia_skill] ------------------------------------------------------------ */
	public function getHemophagiaSkill takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit )
	endfunction
	public function addHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , value , during )
	endfunction
	public function subHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , -value , during )
	endfunction
	public function setHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
	endfunction
	/* 高级属性[split] ------------------------------------------------------------ */
	public function getSplit takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_SPLIT , whichUnit )
	endfunction
	public function addSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_SPLIT , whichUnit , value , during )
	endfunction
	public function subSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_SPLIT , whichUnit , -value , during )
	endfunction
	public function setSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
	endfunction
	/* 高级属性[gold_ratio] ------------------------------------------------------------ */
	public function getGoldRatio takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_GOLD_RATIO , whichUnit )
	endfunction
	public function addGoldRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_GOLD_RATIO , whichUnit , value , during )
	endfunction
	public function subGoldRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_GOLD_RATIO , whichUnit , -value , during )
	endfunction
	public function setGoldRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_GOLD_RATIO , whichUnit , value - getGoldRatio(whichUnit) , during )
	endfunction
	/* 高级属性[lumber_ratio] ------------------------------------------------------------ */
	public function getLumberRatio takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_LUMBER_RATIO , whichUnit )
	endfunction
	public function addLumberRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LUMBER_RATIO , whichUnit , value , during )
	endfunction
	public function subLumberRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LUMBER_RATIO , whichUnit , -value , during )
	endfunction
	public function setLumberRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LUMBER_RATIO , whichUnit , value - getLumberRatio(whichUnit) , during )
	endfunction
	/* 高级属性[exp_ratio] ------------------------------------------------------------ */
	public function getExpRatio takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_EXP_RATIO , whichUnit )
	endfunction
	public function addExpRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_EXP_RATIO , whichUnit , value , during )
	endfunction
	public function subExpRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_EXP_RATIO , whichUnit , -value , during )
	endfunction
	public function setExpRatio takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_EXP_RATIO , whichUnit , value - getExpRatio(whichUnit) , during )
	endfunction
	/* 高级属性[swim_oppose] ------------------------------------------------------------ */
	public function getSwimOppose takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit )
	endfunction
	public function addSwimOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , value , during )
	endfunction
	public function subSwimOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , -value , during )
	endfunction
	public function setSwimOppose takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , value - getSwimOppose(whichUnit) , during )
	endfunction
	/* 高级属性[luck] ------------------------------------------------------------ */
	public function getLuck takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_LUCK , whichUnit )
	endfunction
	public function addLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LUCK , whichUnit , value , during )
	endfunction
	public function subLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LUCK , whichUnit , -value , during )
	endfunction
	public function setLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_LUCK , whichUnit , value - getLuck(whichUnit) , during )
	endfunction
	/* 高级属性[invincible] ------------------------------------------------------------ */
	public function getInvincible takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit )
	endfunction
	public function addInvincible takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit , value , during )
	endfunction
	public function subInvincible takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit , -value , during )
	endfunction
	public function setInvincible takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit , value - getInvincible(whichUnit) , during )
	endfunction
	/* 高级属性[weight] ------------------------------------------------------------ */
	public function getWeight takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_WEIGHT , whichUnit )
	endfunction
	public function addWeight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_WEIGHT , whichUnit , value , during )
	endfunction
	public function subWeight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_WEIGHT , whichUnit , -value , during )
	endfunction
	public function setWeight takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_WEIGHT , whichUnit , value - getWeight(whichUnit) , during )
	endfunction
	/* 高级属性[weight_current] ------------------------------------------------------------ */
	public function getWeightCurrent takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit )
	endfunction
	public function addWeightCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit , value , during )
	endfunction
	public function subWeightCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit , -value , during )
	endfunction
	public function setWeightCurrent takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit , value - getWeightCurrent(whichUnit) , during )
	endfunction
	/* 高级属性[hunt_amplitude] ------------------------------------------------------------ */
	public function getHuntAmplitude takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit )
	endfunction
	public function addHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit , value , during )
	endfunction
	public function subHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit , -value , during )
	endfunction
	public function setHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , during )
	endfunction
	/* 高级属性[hunt_rebound] ------------------------------------------------------------ */
	public function getHuntRebound takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit )
	endfunction
	public function addHuntRebound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit , value , during )
	endfunction
	public function subHuntRebound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit , -value , during )
	endfunction
	public function setHuntRebound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit , value - getHuntRebound(whichUnit) , during )
	endfunction
	/* 高级属性[cure] ------------------------------------------------------------ */
	public function getCure takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_UP_CURE , whichUnit )
	endfunction
	public function addCure takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_CURE , whichUnit , value , during )
	endfunction
	public function subCure takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_CURE , whichUnit , -value , during )
	endfunction
	public function setCure takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_UP_CURE , whichUnit , value - getCure(whichUnit) , during )
	endfunction

	/**
     * 打印某个单位的攻击特效到桌面
     */
    public function show takes unit whichUnit returns nothing
		call console.info("高级属性#life_back："+R2S(getLifeBack(whichUnit)))
		call console.info("高级属性#life_source："+R2S(getLifeSource(whichUnit)))
		call console.info("高级属性#life_source_current："+R2S(getLifeSourceCurrent(whichUnit)))
		call console.info("高级属性#mana_back："+R2S(getManaBack(whichUnit)))
		call console.info("高级属性#mana_source："+R2S(getManaSource(whichUnit)))
		call console.info("高级属性#mana_source_current："+R2S(getManaSourceCurrent(whichUnit)))
		call console.info("高级属性#resistance："+R2S(getResistance(whichUnit)))
		call console.info("高级属性#toughness："+R2S(getToughness(whichUnit)))
		call console.info("高级属性#avoid："+R2S(getAvoid(whichUnit)))
		call console.info("高级属性#aim："+R2S(getAim(whichUnit)))
		call console.info("高级属性#knocking："+R2S(getKnocking(whichUnit)))
		call console.info("高级属性#violence："+R2S(getViolence(whichUnit)))
		call console.info("高级属性#mortal_oppose："+R2S(getMortalOppose(whichUnit)))
		call console.info("高级属性#punish："+R2S(getPunish(whichUnit)))
		call console.info("高级属性#punish_current："+R2S(getPunishCurrent(whichUnit)))
		call console.info("高级属性#meditative："+R2S(getMeditative(whichUnit)))
		call console.info("高级属性#help："+R2S(getHelp(whichUnit)))
		call console.info("高级属性#hemophagia："+R2S(getHemophagia(whichUnit)))
		call console.info("高级属性#hemophagia_skill："+R2S(getHemophagiaSkill(whichUnit)))
		call console.info("高级属性#split："+R2S(getSplit(whichUnit)))
		call console.info("高级属性#gold_ratio："+R2S(getGoldRatio(whichUnit)))
		call console.info("高级属性#lumber_ratio："+R2S(getLumberRatio(whichUnit)))
		call console.info("高级属性#exp_ratio："+R2S(getExpRatio(whichUnit)))
		call console.info("高级属性#swim_oppose："+R2S(getSwimOppose(whichUnit)))
		call console.info("高级属性#luck："+R2S(getLuck(whichUnit)))
		call console.info("高级属性#invincible："+R2S(getInvincible(whichUnit)))
		call console.info("高级属性#weight："+R2S(getWeight(whichUnit)))
		call console.info("高级属性#weight_current："+R2S(getWeightCurrent(whichUnit)))
		call console.info("高级属性#hunt_amplitude："+R2S(getHuntAmplitude(whichUnit)))
		call console.info("高级属性#hunt_rebound："+R2S(getHuntRebound(whichUnit)))
		call console.info("高级属性#cure："+R2S(getCure(whichUnit)))
    endfunction

    private function init takes nothing returns nothing
    	set hash = InitHashtable()
    endfunction

endlibrary