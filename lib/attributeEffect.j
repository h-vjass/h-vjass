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
library hAttrEffect initializer init needs hAttr

	globals
		private hashtable hash = null
		private integer ATTR_FLAG_EFFECT_UNIT = 1000
	    private integer ATTR_FLAG_EFFECT_CD = 1001
	    //--
		private integer ATTR_FLAG_EFFECT_LIFE_BACK = 2001
		private integer ATTR_FLAG_EFFECT_MANA_BACK = 2002
		private integer ATTR_FLAG_EFFECT_ATTACK_SPEED = 2003
		private integer ATTR_FLAG_EFFECT_ATTACK_PHYSICAL = 2004
		private integer ATTR_FLAG_EFFECT_ATTACK_MAGIC = 2005
		private integer ATTR_FLAG_EFFECT_MOVE = 2006
		private integer ATTR_FLAG_EFFECT_AIM = 2007
		private integer ATTR_FLAG_EFFECT_STR = 2008
		private integer ATTR_FLAG_EFFECT_AGI = 2009
		private integer ATTR_FLAG_EFFECT_INT = 2010
		private integer ATTR_FLAG_EFFECT_KNOCKING = 2011
		private integer ATTR_FLAG_EFFECT_VIOLENCE = 2012
		private integer ATTR_FLAG_EFFECT_HEMOPHAGIA = 2013
		private integer ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL = 2014
		private integer ATTR_FLAG_EFFECT_SPLIT = 2015
		private integer ATTR_FLAG_EFFECT_LUCK = 2016
		private integer ATTR_FLAG_EFFECT_HUNT_AMPLITUDE = 2017
		private integer ATTR_FLAG_EFFECT_POISON = 2018
		private integer ATTR_FLAG_EFFECT_DRY = 2019
		private integer ATTR_FLAG_EFFECT_FREEZE = 2020
		private integer ATTR_FLAG_EFFECT_COLD = 2021
		private integer ATTR_FLAG_EFFECT_BLUNT = 2022
		private integer ATTR_FLAG_EFFECT_CORROSION = 2023
		private integer ATTR_FLAG_EFFECT_CHAOS = 2024
		private integer ATTR_FLAG_EFFECT_TWINE = 2025
		private integer ATTR_FLAG_EFFECT_BLIND = 2026
		private integer ATTR_FLAG_EFFECT_TORTUA = 2027
		private integer ATTR_FLAG_EFFECT_WEAK = 2028
		private integer ATTR_FLAG_EFFECT_BOUND = 2029
		private integer ATTR_FLAG_EFFECT_FOOLISH = 2030
		private integer ATTR_FLAG_EFFECT_LAZY = 2031
		private integer ATTR_FLAG_EFFECT_SWIM = 2032
		private integer ATTR_FLAG_EFFECT_BREAK = 2033
		private integer ATTR_FLAG_EFFECT_HEAVY = 2034
		private integer ATTR_FLAG_EFFECT_UNLUCK = 2035

		private integer ATTR_FLAG_EFFECT_DURING_LIFE_BACK = 4001
		private integer ATTR_FLAG_EFFECT_DURING_MANA_BACK = 4002
		private integer ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED = 4003
		private integer ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL = 4004
		private integer ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC = 4005
		private integer ATTR_FLAG_EFFECT_DURING_MOVE = 4006
		private integer ATTR_FLAG_EFFECT_DURING_AIM = 4007
		private integer ATTR_FLAG_EFFECT_DURING_STR = 4008
		private integer ATTR_FLAG_EFFECT_DURING_AGI = 4009
		private integer ATTR_FLAG_EFFECT_DURING_INT = 4010
		private integer ATTR_FLAG_EFFECT_DURING_KNOCKING = 4011
		private integer ATTR_FLAG_EFFECT_DURING_VIOLENCE = 4012
		private integer ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA = 4013
		private integer ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL = 4014
		private integer ATTR_FLAG_EFFECT_DURING_SPLIT = 4015
		private integer ATTR_FLAG_EFFECT_DURING_LUCK = 4016
		private integer ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE = 4017
		private integer ATTR_FLAG_EFFECT_DURING_POISON = 4018
		private integer ATTR_FLAG_EFFECT_DURING_DRY = 4019
		private integer ATTR_FLAG_EFFECT_DURING_FREEZE = 4020
		private integer ATTR_FLAG_EFFECT_DURING_COLD = 4021
		private integer ATTR_FLAG_EFFECT_DURING_BLUNT = 4022
		private integer ATTR_FLAG_EFFECT_DURING_CORROSION = 4023
		private integer ATTR_FLAG_EFFECT_DURING_CHAOS = 4024
		private integer ATTR_FLAG_EFFECT_DURING_TWINE = 4025
		private integer ATTR_FLAG_EFFECT_DURING_BLIND = 4026
		private integer ATTR_FLAG_EFFECT_DURING_TORTUA = 4027
		private integer ATTR_FLAG_EFFECT_DURING_WEAK = 4028
		private integer ATTR_FLAG_EFFECT_DURING_BOUND = 4029
		private integer ATTR_FLAG_EFFECT_DURING_FOOLISH = 4030
		private integer ATTR_FLAG_EFFECT_DURING_LAZY = 4031
		private integer ATTR_FLAG_EFFECT_DURING_SWIM = 4032
		private integer ATTR_FLAG_EFFECT_DURING_BREAK = 4033
		private integer ATTR_FLAG_EFFECT_DURING_HEAVY = 4034
		private integer ATTR_FLAG_EFFECT_DURING_UNLUCK = 4035
	endglobals

	/* 验证单位是否初始化过参数 */
	public function initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash , uhid , ATTR_FLAG_EFFECT_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
			call SaveInteger( hash , uhid , ATTR_FLAG_EFFECT_UNIT , uhid )

			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_LIFE_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_LIFE_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_MANA_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_MANA_BACK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_ATTACK_SPEED , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_ATTACK_MAGIC , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_MOVE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_MOVE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_AIM , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_AIM , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_STR , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_STR , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_AGI , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_AGI , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_INT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_INT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_KNOCKING , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_KNOCKING , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_VIOLENCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_VIOLENCE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_SPLIT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_SPLIT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_LUCK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_LUCK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_POISON , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_POISON , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DRY , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_DRY , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_FREEZE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_FREEZE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_COLD , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_COLD , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_BLUNT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_BLUNT , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_CORROSION , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_CORROSION , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_CHAOS , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_CHAOS , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_TWINE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_TWINE , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_BLIND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_BLIND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_TORTUA , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_TORTUA , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_WEAK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_WEAK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_BOUND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_BOUND , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_FOOLISH , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_FOOLISH , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_LAZY , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_LAZY , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_SWIM , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_SWIM , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_BREAK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_BREAK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_HEAVY , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_HEAVY , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_UNLUCK , 0 )
			call SaveReal( hash , uhid , ATTR_FLAG_EFFECT_DURING_UNLUCK , 0 )
			return true
		endif
		return false
	endfunction

	/* 设定属性(即时/计时) */
	private function setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		if(diff != 0)then
			call SaveReal( hash , uhid , flag , LoadReal( hash , uhid , flag ) + diff )
		endif
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




	/* 攻击|伤害特效[life_back] ------------------------------------------------------------ */
	public function getLifeBack takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_LIFE_BACK , whichUnit )
	endfunction
	public function coverLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK , whichUnit , math.oddsAttrEffect(getLifeBack(whichUnit),value)-getLifeBack(whichUnit) , during )
	endfunction
	public function setLifeBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
	endfunction
	//持续
	public function getLifeBackDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_LIFE_BACK , whichUnit )
	endfunction
	public function coverLifeBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LIFE_BACK , whichUnit , math.oddsAttrEffect(getLifeBackDuring(whichUnit),value)-getLifeBackDuring(whichUnit) , during )
	endfunction
	public function setLifeBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[mana_back] ------------------------------------------------------------ */
	public function getManaBack takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_MANA_BACK , whichUnit )
	endfunction
	public function coverManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK , whichUnit , math.oddsAttrEffect(getManaBack(whichUnit),value)-getManaBack(whichUnit) , during )
	endfunction
	public function setManaBack takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
	endfunction
	//持续
	public function getManaBackDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_MANA_BACK , whichUnit )
	endfunction
	public function coverManaBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MANA_BACK , whichUnit , math.oddsAttrEffect(getManaBackDuring(whichUnit),value)-getManaBackDuring(whichUnit) , during )
	endfunction
	public function setManaBackDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[attack_speed] ------------------------------------------------------------ */
	public function getAttackSpeed takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED , whichUnit )
	endfunction
	public function coverAttackSpeed takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED , whichUnit , math.oddsAttrEffect(getAttackSpeed(whichUnit),value)-getAttackSpeed(whichUnit) , during )
	endfunction
	public function setAttackSpeed takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_SPEED , whichUnit , value - getAttackSpeed(whichUnit) , during )
	endfunction
	//持续
	public function getAttackSpeedDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , whichUnit )
	endfunction
	public function coverAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , whichUnit , math.oddsAttrEffect(getAttackSpeedDuring(whichUnit),value)-getAttackSpeedDuring(whichUnit) , during )
	endfunction
	public function setAttackSpeedDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_SPEED , whichUnit , value - getAttackSpeed(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[attack_physical] ------------------------------------------------------------ */
	public function getAttackPhysical takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , whichUnit )
	endfunction
	public function coverAttackPhysical takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , whichUnit , math.oddsAttrEffect(getAttackPhysical(whichUnit),value)-getAttackPhysical(whichUnit) , during )
	endfunction
	public function setAttackPhysical takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_PHYSICAL , whichUnit , value - getAttackPhysical(whichUnit) , during )
	endfunction
	//持续
	public function getAttackPhysicalDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , whichUnit )
	endfunction
	public function coverAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , whichUnit , math.oddsAttrEffect(getAttackPhysicalDuring(whichUnit),value)-getAttackPhysicalDuring(whichUnit) , during )
	endfunction
	public function setAttackPhysicalDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_PHYSICAL , whichUnit , value - getAttackPhysical(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[attack_magic] ------------------------------------------------------------ */
	public function getAttackMagic takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC , whichUnit )
	endfunction
	public function coverAttackMagic takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC , whichUnit , math.oddsAttrEffect(getAttackMagic(whichUnit),value)-getAttackMagic(whichUnit) , during )
	endfunction
	public function setAttackMagic takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_ATTACK_MAGIC , whichUnit , value - getAttackMagic(whichUnit) , during )
	endfunction
	//持续
	public function getAttackMagicDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , whichUnit )
	endfunction
	public function coverAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , whichUnit , math.oddsAttrEffect(getAttackMagicDuring(whichUnit),value)-getAttackMagicDuring(whichUnit) , during )
	endfunction
	public function setAttackMagicDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_ATTACK_MAGIC , whichUnit , value - getAttackMagic(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[move] ------------------------------------------------------------ */
	public function getMove takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_MOVE , whichUnit )
	endfunction
	public function coverMove takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MOVE , whichUnit , math.oddsAttrEffect(getMove(whichUnit),value)-getMove(whichUnit) , during )
	endfunction
	public function setMove takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_MOVE , whichUnit , value - getMove(whichUnit) , during )
	endfunction
	//持续
	public function getMoveDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_MOVE , whichUnit )
	endfunction
	public function coverMoveDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MOVE , whichUnit , math.oddsAttrEffect(getMoveDuring(whichUnit),value)-getMoveDuring(whichUnit) , during )
	endfunction
	public function setMoveDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_MOVE , whichUnit , value - getMove(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[aim] ------------------------------------------------------------ */
	public function getAim takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_AIM , whichUnit )
	endfunction
	public function coverAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AIM , whichUnit , math.oddsAttrEffect(getAim(whichUnit),value)-getAim(whichUnit) , during )
	endfunction
	public function setAim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AIM , whichUnit , value - getAim(whichUnit) , during )
	endfunction
	//持续
	public function getAimDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_AIM , whichUnit )
	endfunction
	public function coverAimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AIM , whichUnit , math.oddsAttrEffect(getAimDuring(whichUnit),value)-getAimDuring(whichUnit) , during )
	endfunction
	public function setAimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AIM , whichUnit , value - getAim(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[str] ------------------------------------------------------------ */
	public function getStr takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_STR , whichUnit )
	endfunction
	public function coverStr takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_STR , whichUnit , math.oddsAttrEffect(getStr(whichUnit),value)-getStr(whichUnit) , during )
	endfunction
	public function setStr takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_STR , whichUnit , value - getStr(whichUnit) , during )
	endfunction
	//持续
	public function getStrDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_STR , whichUnit )
	endfunction
	public function coverStrDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_STR , whichUnit , math.oddsAttrEffect(getStrDuring(whichUnit),value)-getStrDuring(whichUnit) , during )
	endfunction
	public function setStrDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_STR , whichUnit , value - getStr(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[agi] ------------------------------------------------------------ */
	public function getAgi takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_AGI , whichUnit )
	endfunction
	public function coverAgi takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AGI , whichUnit , math.oddsAttrEffect(getAgi(whichUnit),value)-getAgi(whichUnit) , during )
	endfunction
	public function setAgi takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_AGI , whichUnit , value - getAgi(whichUnit) , during )
	endfunction
	//持续
	public function getAgiDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_AGI , whichUnit )
	endfunction
	public function coverAgiDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AGI , whichUnit , math.oddsAttrEffect(getAgiDuring(whichUnit),value)-getAgiDuring(whichUnit) , during )
	endfunction
	public function setAgiDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_AGI , whichUnit , value - getAgi(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[int] ------------------------------------------------------------ */
	public function getInt takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_INT , whichUnit )
	endfunction
	public function coverInt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_INT , whichUnit , math.oddsAttrEffect(getInt(whichUnit),value)-getInt(whichUnit) , during )
	endfunction
	public function setInt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_INT , whichUnit , value - getInt(whichUnit) , during )
	endfunction
	//持续
	public function getIntDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_INT , whichUnit )
	endfunction
	public function coverIntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_INT , whichUnit , math.oddsAttrEffect(getIntDuring(whichUnit),value)-getIntDuring(whichUnit) , during )
	endfunction
	public function setIntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_INT , whichUnit , value - getInt(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[knocking] ------------------------------------------------------------ */
	public function getKnocking takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_KNOCKING , whichUnit )
	endfunction
	public function coverKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_KNOCKING , whichUnit , math.oddsAttrEffect(getKnocking(whichUnit),value)-getKnocking(whichUnit) , during )
	endfunction
	public function setKnocking takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
	endfunction
	//持续
	public function getKnockingDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_KNOCKING , whichUnit )
	endfunction
	public function coverKnockingDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_KNOCKING , whichUnit , math.oddsAttrEffect(getKnockingDuring(whichUnit),value)-getKnockingDuring(whichUnit) , during )
	endfunction
	public function setKnockingDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[violence] ------------------------------------------------------------ */
	public function getViolence takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_VIOLENCE , whichUnit )
	endfunction
	public function coverViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE , whichUnit , math.oddsAttrEffect(getViolence(whichUnit),value)-getViolence(whichUnit) , during )
	endfunction
	public function setViolence takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
	endfunction
	//持续
	public function getViolenceDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_VIOLENCE , whichUnit )
	endfunction
	public function coverViolenceDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_VIOLENCE , whichUnit , math.oddsAttrEffect(getViolenceDuring(whichUnit),value)-getViolenceDuring(whichUnit) , during )
	endfunction
	public function setViolenceDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[hemophagia] ------------------------------------------------------------ */
	public function getHemophagia takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA , whichUnit )
	endfunction
	public function coverHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA , whichUnit , math.oddsAttrEffect(getHemophagia(whichUnit),value)-getHemophagia(whichUnit) , during )
	endfunction
	public function setHemophagia takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
	endfunction
	//持续
	public function getHemophagiaDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , whichUnit )
	endfunction
	public function coverHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , whichUnit , math.oddsAttrEffect(getHemophagiaDuring(whichUnit),value)-getHemophagiaDuring(whichUnit) , during )
	endfunction
	public function setHemophagiaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[hemophagia_skill] ------------------------------------------------------------ */
	public function getHemophagiaSkill takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , whichUnit )
	endfunction
	public function coverHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , whichUnit , math.oddsAttrEffect(getHemophagiaSkill(whichUnit),value)-getHemophagiaSkill(whichUnit) , during )
	endfunction
	public function setHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
	endfunction
	//持续
	public function getHemophagiaSkillDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , whichUnit )
	endfunction
	public function coverHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , whichUnit , math.oddsAttrEffect(getHemophagiaSkillDuring(whichUnit),value)-getHemophagiaSkillDuring(whichUnit) , during )
	endfunction
	public function setHemophagiaSkillDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[split] ------------------------------------------------------------ */
	public function getSplit takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_SPLIT , whichUnit )
	endfunction
	public function coverSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SPLIT , whichUnit , math.oddsAttrEffect(getSplit(whichUnit),value)-getSplit(whichUnit) , during )
	endfunction
	public function setSplit takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
	endfunction
	//持续
	public function getSplitDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_SPLIT , whichUnit )
	endfunction
	public function coverSplitDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SPLIT , whichUnit , math.oddsAttrEffect(getSplitDuring(whichUnit),value)-getSplitDuring(whichUnit) , during )
	endfunction
	public function setSplitDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[luck] ------------------------------------------------------------ */
	public function getLuck takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_LUCK , whichUnit )
	endfunction
	public function coverLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LUCK , whichUnit , math.oddsAttrEffect(getLuck(whichUnit),value)-getLuck(whichUnit) , during )
	endfunction
	public function setLuck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LUCK , whichUnit , value - getLuck(whichUnit) , during )
	endfunction
	//持续
	public function getLuckDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_LUCK , whichUnit )
	endfunction
	public function coverLuckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LUCK , whichUnit , math.oddsAttrEffect(getLuckDuring(whichUnit),value)-getLuckDuring(whichUnit) , during )
	endfunction
	public function setLuckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LUCK , whichUnit , value - getLuck(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[hunt_amplitude] ------------------------------------------------------------ */
	public function getHuntAmplitude takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , whichUnit )
	endfunction
	public function coverHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , whichUnit , math.oddsAttrEffect(getHuntAmplitude(whichUnit),value)-getHuntAmplitude(whichUnit) , during )
	endfunction
	public function setHuntAmplitude takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , during )
	endfunction
	//持续
	public function getHuntAmplitudeDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , whichUnit )
	endfunction
	public function coverHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , whichUnit , math.oddsAttrEffect(getHuntAmplitudeDuring(whichUnit),value)-getHuntAmplitudeDuring(whichUnit) , during )
	endfunction
	public function setHuntAmplitudeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[poison] ------------------------------------------------------------ */
	public function getPoison takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_POISON , whichUnit )
	endfunction
	public function coverPoison takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_POISON , whichUnit , math.oddsAttrEffect(getPoison(whichUnit),value)-getPoison(whichUnit) , during )
	endfunction
	public function setPoison takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_POISON , whichUnit , value - getPoison(whichUnit) , during )
	endfunction
	//持续
	public function getPoisonDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_POISON , whichUnit )
	endfunction
	public function coverPoisonDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_POISON , whichUnit , math.oddsAttrEffect(getPoisonDuring(whichUnit),value)-getPoisonDuring(whichUnit) , during )
	endfunction
	public function setPoisonDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_POISON , whichUnit , value - getPoison(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[dry] ------------------------------------------------------------ */
	public function getDry takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DRY , whichUnit )
	endfunction
	public function coverDry takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DRY , whichUnit , math.oddsAttrEffect(getDry(whichUnit),value)-getDry(whichUnit) , during )
	endfunction
	public function setDry takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DRY , whichUnit , value - getDry(whichUnit) , during )
	endfunction
	//持续
	public function getDryDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_DRY , whichUnit )
	endfunction
	public function coverDryDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_DRY , whichUnit , math.oddsAttrEffect(getDryDuring(whichUnit),value)-getDryDuring(whichUnit) , during )
	endfunction
	public function setDryDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_DRY , whichUnit , value - getDry(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[freeze] ------------------------------------------------------------ */
	public function getFreeze takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_FREEZE , whichUnit )
	endfunction
	public function coverFreeze takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FREEZE , whichUnit , math.oddsAttrEffect(getFreeze(whichUnit),value)-getFreeze(whichUnit) , during )
	endfunction
	public function setFreeze takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FREEZE , whichUnit , value - getFreeze(whichUnit) , during )
	endfunction
	//持续
	public function getFreezeDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_FREEZE , whichUnit )
	endfunction
	public function coverFreezeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FREEZE , whichUnit , math.oddsAttrEffect(getFreezeDuring(whichUnit),value)-getFreezeDuring(whichUnit) , during )
	endfunction
	public function setFreezeDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FREEZE , whichUnit , value - getFreeze(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[cold] ------------------------------------------------------------ */
	public function getCold takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_COLD , whichUnit )
	endfunction
	public function coverCold takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_COLD , whichUnit , math.oddsAttrEffect(getCold(whichUnit),value)-getCold(whichUnit) , during )
	endfunction
	public function setCold takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_COLD , whichUnit , value - getCold(whichUnit) , during )
	endfunction
	//持续
	public function getColdDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_COLD , whichUnit )
	endfunction
	public function coverColdDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_COLD , whichUnit , math.oddsAttrEffect(getColdDuring(whichUnit),value)-getColdDuring(whichUnit) , during )
	endfunction
	public function setColdDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_COLD , whichUnit , value - getCold(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[blunt] ------------------------------------------------------------ */
	public function getBlunt takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BLUNT , whichUnit )
	endfunction
	public function coverBlunt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLUNT , whichUnit , math.oddsAttrEffect(getBlunt(whichUnit),value)-getBlunt(whichUnit) , during )
	endfunction
	public function setBlunt takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLUNT , whichUnit , value - getBlunt(whichUnit) , during )
	endfunction
	//持续
	public function getBluntDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BLUNT , whichUnit )
	endfunction
	public function coverBluntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLUNT , whichUnit , math.oddsAttrEffect(getBluntDuring(whichUnit),value)-getBluntDuring(whichUnit) , during )
	endfunction
	public function setBluntDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLUNT , whichUnit , value - getBlunt(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[corrosion] ------------------------------------------------------------ */
	public function getCorrosion takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_CORROSION , whichUnit )
	endfunction
	public function coverCorrosion takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CORROSION , whichUnit , math.oddsAttrEffect(getCorrosion(whichUnit),value)-getCorrosion(whichUnit) , during )
	endfunction
	public function setCorrosion takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CORROSION , whichUnit , value - getCorrosion(whichUnit) , during )
	endfunction
	//持续
	public function getCorrosionDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_CORROSION , whichUnit )
	endfunction
	public function coverCorrosionDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CORROSION , whichUnit , math.oddsAttrEffect(getCorrosionDuring(whichUnit),value)-getCorrosionDuring(whichUnit) , during )
	endfunction
	public function setCorrosionDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CORROSION , whichUnit , value - getCorrosion(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[chaos] ------------------------------------------------------------ */
	public function getChaos takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_CHAOS , whichUnit )
	endfunction
	public function coverChaos takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CHAOS , whichUnit , math.oddsAttrEffect(getChaos(whichUnit),value)-getChaos(whichUnit) , during )
	endfunction
	public function setChaos takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_CHAOS , whichUnit , value - getChaos(whichUnit) , during )
	endfunction
	//持续
	public function getChaosDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_CHAOS , whichUnit )
	endfunction
	public function coverChaosDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CHAOS , whichUnit , math.oddsAttrEffect(getChaosDuring(whichUnit),value)-getChaosDuring(whichUnit) , during )
	endfunction
	public function setChaosDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_CHAOS , whichUnit , value - getChaos(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[twine] ------------------------------------------------------------ */
	public function getTwine takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_TWINE , whichUnit )
	endfunction
	public function coverTwine takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TWINE , whichUnit , math.oddsAttrEffect(getTwine(whichUnit),value)-getTwine(whichUnit) , during )
	endfunction
	public function setTwine takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TWINE , whichUnit , value - getTwine(whichUnit) , during )
	endfunction
	//持续
	public function getTwineDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_TWINE , whichUnit )
	endfunction
	public function coverTwineDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TWINE , whichUnit , math.oddsAttrEffect(getTwineDuring(whichUnit),value)-getTwineDuring(whichUnit) , during )
	endfunction
	public function setTwineDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TWINE , whichUnit , value - getTwine(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[blind] ------------------------------------------------------------ */
	public function getBlind takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BLIND , whichUnit )
	endfunction
	public function coverBlind takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLIND , whichUnit , math.oddsAttrEffect(getBlind(whichUnit),value)-getBlind(whichUnit) , during )
	endfunction
	public function setBlind takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BLIND , whichUnit , value - getBlind(whichUnit) , during )
	endfunction
	//持续
	public function getBlindDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BLIND , whichUnit )
	endfunction
	public function coverBlindDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLIND , whichUnit , math.oddsAttrEffect(getBlindDuring(whichUnit),value)-getBlindDuring(whichUnit) , during )
	endfunction
	public function setBlindDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BLIND , whichUnit , value - getBlind(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[tortua] ------------------------------------------------------------ */
	public function getTortua takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_TORTUA , whichUnit )
	endfunction
	public function coverTortua takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TORTUA , whichUnit , math.oddsAttrEffect(getTortua(whichUnit),value)-getTortua(whichUnit) , during )
	endfunction
	public function setTortua takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_TORTUA , whichUnit , value - getTortua(whichUnit) , during )
	endfunction
	//持续
	public function getTortuaDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_TORTUA , whichUnit )
	endfunction
	public function coverTortuaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TORTUA , whichUnit , math.oddsAttrEffect(getTortuaDuring(whichUnit),value)-getTortuaDuring(whichUnit) , during )
	endfunction
	public function setTortuaDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_TORTUA , whichUnit , value - getTortua(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[weak] ------------------------------------------------------------ */
	public function getWeak takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_WEAK , whichUnit )
	endfunction
	public function coverWeak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_WEAK , whichUnit , math.oddsAttrEffect(getWeak(whichUnit),value)-getWeak(whichUnit) , during )
	endfunction
	public function setWeak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_WEAK , whichUnit , value - getWeak(whichUnit) , during )
	endfunction
	//持续
	public function getWeakDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_WEAK , whichUnit )
	endfunction
	public function coverWeakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_WEAK , whichUnit , math.oddsAttrEffect(getWeakDuring(whichUnit),value)-getWeakDuring(whichUnit) , during )
	endfunction
	public function setWeakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_WEAK , whichUnit , value - getWeak(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[bound] ------------------------------------------------------------ */
	public function getBound takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BOUND , whichUnit )
	endfunction
	public function coverBound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BOUND , whichUnit , math.oddsAttrEffect(getBound(whichUnit),value)-getBound(whichUnit) , during )
	endfunction
	public function setBound takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BOUND , whichUnit , value - getBound(whichUnit) , during )
	endfunction
	//持续
	public function getBoundDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BOUND , whichUnit )
	endfunction
	public function coverBoundDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BOUND , whichUnit , math.oddsAttrEffect(getBoundDuring(whichUnit),value)-getBoundDuring(whichUnit) , during )
	endfunction
	public function setBoundDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BOUND , whichUnit , value - getBound(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[foolish] ------------------------------------------------------------ */
	public function getFoolish takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_FOOLISH , whichUnit )
	endfunction
	public function coverFoolish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FOOLISH , whichUnit , math.oddsAttrEffect(getFoolish(whichUnit),value)-getFoolish(whichUnit) , during )
	endfunction
	public function setFoolish takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_FOOLISH , whichUnit , value - getFoolish(whichUnit) , during )
	endfunction
	//持续
	public function getFoolishDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_FOOLISH , whichUnit )
	endfunction
	public function coverFoolishDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FOOLISH , whichUnit , math.oddsAttrEffect(getFoolishDuring(whichUnit),value)-getFoolishDuring(whichUnit) , during )
	endfunction
	public function setFoolishDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_FOOLISH , whichUnit , value - getFoolish(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[lazy] ------------------------------------------------------------ */
	public function getLazy takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_LAZY , whichUnit )
	endfunction
	public function coverLazy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LAZY , whichUnit , math.oddsAttrEffect(getLazy(whichUnit),value)-getLazy(whichUnit) , during )
	endfunction
	public function setLazy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_LAZY , whichUnit , value - getLazy(whichUnit) , during )
	endfunction
	//持续
	public function getLazyDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_LAZY , whichUnit )
	endfunction
	public function coverLazyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LAZY , whichUnit , math.oddsAttrEffect(getLazyDuring(whichUnit),value)-getLazyDuring(whichUnit) , during )
	endfunction
	public function setLazyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_LAZY , whichUnit , value - getLazy(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[swim] ------------------------------------------------------------ */
	public function getSwim takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_SWIM , whichUnit )
	endfunction
	public function coverSwim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SWIM , whichUnit , math.oddsAttrEffect(getSwim(whichUnit),value)-getSwim(whichUnit) , during )
	endfunction
	public function setSwim takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_SWIM , whichUnit , value - getSwim(whichUnit) , during )
	endfunction
	//持续
	public function getSwimDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_SWIM , whichUnit )
	endfunction
	public function coverSwimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SWIM , whichUnit , math.oddsAttrEffect(getSwimDuring(whichUnit),value)-getSwimDuring(whichUnit) , during )
	endfunction
	public function setSwimDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_SWIM , whichUnit , value - getSwim(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[break] ------------------------------------------------------------ */
	public function getBreak takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_BREAK , whichUnit )
	endfunction
	public function coverBreak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BREAK , whichUnit , math.oddsAttrEffect(getBreak(whichUnit),value)-getBreak(whichUnit) , during )
	endfunction
	public function setBreak takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_BREAK , whichUnit , value - getBreak(whichUnit) , during )
	endfunction
	//持续
	public function getBreakDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_BREAK , whichUnit )
	endfunction
	public function coverBreakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BREAK , whichUnit , math.oddsAttrEffect(getBreakDuring(whichUnit),value)-getBreakDuring(whichUnit) , during )
	endfunction
	public function setBreakDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_BREAK , whichUnit , value - getBreak(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[heavy] ------------------------------------------------------------ */
	public function getHeavy takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_HEAVY , whichUnit )
	endfunction
	public function coverHeavy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEAVY , whichUnit , math.oddsAttrEffect(getHeavy(whichUnit),value)-getHeavy(whichUnit) , during )
	endfunction
	public function setHeavy takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_HEAVY , whichUnit , value - getHeavy(whichUnit) , during )
	endfunction
	//持续
	public function getHeavyDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_HEAVY , whichUnit )
	endfunction
	public function coverHeavyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEAVY , whichUnit , math.oddsAttrEffect(getHeavyDuring(whichUnit),value)-getHeavyDuring(whichUnit) , during )
	endfunction
	public function setHeavyDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_HEAVY , whichUnit , value - getHeavy(whichUnit) , during )
	endfunction
	/* 攻击|伤害特效[unluck] ------------------------------------------------------------ */
	public function getUnluck takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_UNLUCK , whichUnit )
	endfunction
	public function coverUnluck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_UNLUCK , whichUnit , math.oddsAttrEffect(getUnluck(whichUnit),value)-getUnluck(whichUnit) , during )
	endfunction
	public function setUnluck takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_UNLUCK , whichUnit , value - getUnluck(whichUnit) , during )
	endfunction
	//持续
	public function getUnluckDuring takes unit whichUnit returns real
	   return getAttr( ATTR_FLAG_EFFECT_DURING_UNLUCK , whichUnit )
	endfunction
	public function coverUnluckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_UNLUCK , whichUnit , math.oddsAttrEffect(getUnluckDuring(whichUnit),value)-getUnluckDuring(whichUnit) , during )
	endfunction
	public function setUnluckDuring takes unit whichUnit , real value , real during returns nothing
	   call setAttr( ATTR_FLAG_EFFECT_DURING_UNLUCK , whichUnit , value - getUnluck(whichUnit) , during )
	endfunction

	/**
     * 打印某个单位的攻击特效到桌面
     */
    public function showAttr takes unit whichUnit returns nothing
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
    endfunction

    private function init takes nothing returns nothing
    	set hash = InitHashtable()
    endfunction


endlibrary
