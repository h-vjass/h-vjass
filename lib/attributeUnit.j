/* 属性 - 单位 */
library hAttrUnit initializer init needs hAttrHunt

	globals
		private boolean PUNISH_SWITCH = true 			//有的游戏不需要硬直条就把他关闭
		private boolean PUNISH_SWITCH_ONLYHERO = true 	//是否只有英雄有硬直条
		private real PUNISH_TEXTTAG_HEIGHT = 260.00		//硬直条漂浮字高度

		private trigger ATTR_TRIGGER_UNIT_BEHUNT = null
		private trigger ATTR_TRIGGER_HERO_LEVEL = null
		private trigger ATTR_TRIGGER_UNIT_DEATH = null

		private hashtable hash = null
		private group ATTR_GROUP = CreateGroup()

	endglobals

	/* 把单位赶出属性组 */
	private function groupOut takes unit whichUnit returns nothing
		if( IsUnitInGroup( whichUnit , ATTR_GROUP ) == true ) then
			call GroupRemoveUnit( ATTR_GROUP , whichUnit )
		endif
	endfunction

	/* 活力/魔法恢复 */
	private function lifemanaback takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local real period = TimerGetTimeout(t)
	    local group tempGroup = null
		local unit tempUnit = null
		if( ATTR_GROUP != null )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP , tempGroup )
			loop
	            exitwhen(IsUnitGroupEmptyBJ(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
	                //
	                if( IsUnitAliveBJ(tempUnit) )then
		                call SetUnitLifeBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_LIFE, tempUnit) + ( hAttr_getLifeBack(tempUnit) * period ) ) )
	            		call SetUnitManaBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_MANA, tempUnit) + ( hAttr_getManaBack(tempUnit) * period ) ) )
	                endif
	            	//
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
	endfunction

	/* 硬直恢复器(+100/5s) */
	private function punishback takes nothing returns nothing
	    local integer i
	    local integer addPunish = 0
	    local group tempGroup = null
		local unit tempUnit = null
		if( ATTR_GROUP != null )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP , tempGroup )
			loop
	            exitwhen(IsUnitGroupEmptyBJ(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
	                //
	                if( hIs_hero(tempUnit) )then
		                call hAttr_addPunishCurrent( tempUnit , 100 , 0 )
	                endif
	            	//
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
	endfunction

	/**
	 * 设置硬直漂浮字
	 */
    private function punishTtg takes unit whichUnit returns nothing
		local string ttgStr = ""
		local string font = "|"
		local real percent = 0
		local integer block = 0
		local integer blockMax = 25
		local real textSize = 5.00
		local real textZOffset = PUNISH_TEXTTAG_HEIGHT
		local real textOpacity = 0.10
		local integer i = 0
		local real punishNow = hAttr_getPunishCurrent(whichUnit)
		local real punishAll = hAttr_getPunish(whichUnit)
        //计算字符串
        if( punishAll > 0 ) then
            set percent = punishNow / punishAll
            set block = R2I(percent * I2R(blockMax))
            if( punishNow >= punishAll ) then
                set block = R2I(blockMax)
            endif
            set i = 1
            loop
                exitwhen i > blockMax
                    if( i <= block ) then
                        set ttgStr = ttgStr + "|cffffff80"+font+"|r"
                    else
                        set ttgStr = ttgStr + "|cff000000"+font+"|r"
                    endif
                set i = i + 1
            endloop
        endif
        call hMsg_ttgBindUnit(whichUnit,ttgStr,textSize,"",textOpacity,textZOffset)
	endfunction

	/* 单位收到伤害(因为所有的伤害有hunt方法接管，所以这里的伤害全部是攻击伤害) */
	private function triggerUnitbeHuntAction takes nothing returns nothing
		local unit fromUnit = GetEventDamageSource()
		local unit toUnit = GetTriggerUnit()
		local real damage = GetEventDamage()
		local real attackEffectDuringBuff = 5.00
		local real attackEffectDuringDebuff = 3.00

		//计算攻击特效
		local real fromUnitLifeBack = hAttrEffect_getLifeBack(fromUnit)
		local real fromUnitManaBack = hAttrEffect_getManaBack(fromUnit)
		local real fromUnitAttackSpeed = hAttrEffect_getAttackSpeed(fromUnit)
		local real fromUnitAttackPhysical = hAttrEffect_getAttackPhysical(fromUnit)
		local real fromUnitAttackMagic = hAttrEffect_getAttackMagic(fromUnit)
		local real fromUnitMove = hAttrEffect_getMove(fromUnit)
		local real fromUnitAim = hAttrEffect_getAim(fromUnit)
		local real fromUnitStr = hAttrEffect_getStr(fromUnit)
		local real fromUnitAgi = hAttrEffect_getAgi(fromUnit)
		local real fromUnitInt = hAttrEffect_getInt(fromUnit)
		local real fromUnitKnocking = hAttrEffect_getKnocking(fromUnit)
		local real fromUnitViolence = hAttrEffect_getViolence(fromUnit)
		local real fromUnitHemophagia = hAttrEffect_getHemophagia(fromUnit)
		local real fromUnitHemophagiaSkill = hAttrEffect_getHemophagiaSkill(fromUnit)
		local real fromUnitSplit = hAttrEffect_getSplit(fromUnit)
		local real fromUnitSwim = hAttrEffect_getSwim(fromUnit)
		local real fromUnitLuck = hAttrEffect_getLuck(fromUnit)
		local real fromUnitHuntAmplitude = hAttrEffect_getHuntAmplitude(fromUnit)
		local real fromUnitPoison = hAttrEffect_getPoison(fromUnit)
		local real fromUnitDry = hAttrEffect_getDry(fromUnit)
		local real fromUnitFreeze = hAttrEffect_getFreeze(fromUnit)
		local real fromUnitCold = hAttrEffect_getCold(fromUnit)
		local real fromUnitBlunt = hAttrEffect_getBlunt(fromUnit)
		local real fromUnitCorrosion = hAttrEffect_getCorrosion(fromUnit)
		local real fromUnitChaos = hAttrEffect_getChaos(fromUnit)
		local real fromUnitTwine = hAttrEffect_getTwine(fromUnit)
		local real fromUnitBlind = hAttrEffect_getBlind(fromUnit)
		local real fromUnitWeak = hAttrEffect_getWeak(fromUnit)
		local real fromUnitBound = hAttrEffect_getBound(fromUnit)
		local real fromUnitFoolish = hAttrEffect_getFoolish(fromUnit)
		local real fromUnitLazy = hAttrEffect_getLazy(fromUnit)
		local real fromUnitSwimp = hAttrEffect_getSwimp(fromUnit)
		local real fromUnitBreak = hAttrEffect_getBreak(fromUnit)
		local real fromUnitHeavy = hAttrEffect_getHeavy(fromUnit)
		local real fromUnitUnluck = hAttrEffect_getUnluck(fromUnit)

		local real fromUnitLifeBackDuring = hAttrEffect_getLifeBackDuring(fromUnit)
		local real fromUnitManaBackDuring = hAttrEffect_getManaBackDuring(fromUnit)
		local real fromUnitAttackSpeedDuring = hAttrEffect_getAttackSpeedDuring(fromUnit)
		local real fromUnitAttackPhysicalDuring = hAttrEffect_getAttackPhysicalDuring(fromUnit)
		local real fromUnitAttackMagicDuring = hAttrEffect_getAttackMagicDuring(fromUnit)
		local real fromUnitMoveDuring = hAttrEffect_getMoveDuring(fromUnit)
		local real fromUnitAimDuring = hAttrEffect_getAimDuring(fromUnit)
		local real fromUnitStrDuring = hAttrEffect_getStrDuring(fromUnit)
		local real fromUnitAgiDuring = hAttrEffect_getAgiDuring(fromUnit)
		local real fromUnitIntDuring = hAttrEffect_getIntDuring(fromUnit)
		local real fromUnitKnockingDuring = hAttrEffect_getKnockingDuring(fromUnit)
		local real fromUnitViolenceDuring = hAttrEffect_getViolenceDuring(fromUnit)
		local real fromUnitHemophagiaDuring = hAttrEffect_getHemophagiaDuring(fromUnit)
		local real fromUnitHemophagiaSkillDuring = hAttrEffect_getHemophagiaSkillDuring(fromUnit)
		local real fromUnitSplitDuring = hAttrEffect_getSplitDuring(fromUnit)
		local real fromUnitSwimDuring = hAttrEffect_getSwimDuring(fromUnit)
		local real fromUnitLuckDuring = hAttrEffect_getLuckDuring(fromUnit)
		local real fromUnitHuntAmplitudeDuring = hAttrEffect_getHuntAmplitudeDuring(fromUnit)
		local real fromUnitPoisonDuring = hAttrEffect_getPoisonDuring(fromUnit)
		local real fromUnitDryDuring = hAttrEffect_getDryDuring(fromUnit)
		local real fromUnitFreezeDuring = hAttrEffect_getFreezeDuring(fromUnit)
		local real fromUnitColdDuring = hAttrEffect_getColdDuring(fromUnit)
		local real fromUnitBluntDuring = hAttrEffect_getBluntDuring(fromUnit)
		local real fromUnitCorrosionDuring = hAttrEffect_getCorrosionDuring(fromUnit)
		local real fromUnitChaosDuring = hAttrEffect_getChaosDuring(fromUnit)
		local real fromUnitTwineDuring = hAttrEffect_getTwineDuring(fromUnit)
		local real fromUnitBlindDuring = hAttrEffect_getBlindDuring(fromUnit)
		local real fromUnitWeakDuring = hAttrEffect_getWeakDuring(fromUnit)
		local real fromUnitBoundDuring = hAttrEffect_getBoundDuring(fromUnit)
		local real fromUnitFoolishDuring = hAttrEffect_getFoolishDuring(fromUnit)
		local real fromUnitLazyDuring = hAttrEffect_getLazyDuring(fromUnit)
		local real fromUnitSwimpDuring = hAttrEffect_getSwimpDuring(fromUnit)
		local real fromUnitBreakDuring = hAttrEffect_getBreakDuring(fromUnit)
		local real fromUnitHeavyDuring = hAttrEffect_getHeavyDuring(fromUnit)
		local real fromUnitUnluckDuring = hAttrEffect_getUnluckDuring(fromUnit)

		if(damage>0.5)then
			call hAbility_avoid(toUnit) //抵消伤害
			call hAttrHunt_huntUnit( fromUnit,toUnit,null,damage,"attack","physical",false,false,"null",0,0 )
		endif
		//攻击特效
		if( fromUnitLifeBack != 0 and fromUnitLifeBackDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_life_back",fromUnitLifeBack,fromUnitLifeBackDuring )
		endif
		if( fromUnitManaBack != 0 and fromUnitManaBackDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_mana_back",fromUnitManaBack,fromUnitManaBackDuring )
		endif
		if( fromUnitAttackSpeed != 0 and fromUnitAttackSpeedDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_attack_speed",fromUnitAttackSpeed,fromUnitAttackSpeedDuring )
		endif
		if( fromUnitAttackPhysical != 0 and fromUnitAttackPhysicalDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_attack_physical",fromUnitAttackPhysical,fromUnitAttackPhysicalDuring )
		endif
		if( fromUnitAttackMagic != 0 and fromUnitAttackMagicDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_attack_magic",fromUnitAttackMagic,fromUnitAttackMagicDuring )
		endif
		if( fromUnitMove != 0 and fromUnitMoveDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_move",fromUnitMove,fromUnitMoveDuring )
		endif
		if( fromUnitAim != 0 and fromUnitAimDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_aim",fromUnitAim,fromUnitAimDuring )
		endif
		if( fromUnitStr != 0 and fromUnitStrDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_str",fromUnitStr,fromUnitStrDuring )
		endif
		if( fromUnitAgi != 0 and fromUnitAgiDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_agi",fromUnitAgi,fromUnitAgiDuring )
		endif
		if( fromUnitInt != 0 and fromUnitIntDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_int",fromUnitInt,fromUnitIntDuring )
		endif
		if( fromUnitKnocking != 0 and fromUnitKnockingDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_knocking",fromUnitKnocking,fromUnitKnockingDuring )
		endif
		if( fromUnitViolence != 0 and fromUnitViolenceDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_violence",fromUnitViolence,fromUnitViolenceDuring )
		endif
		if( fromUnitHemophagia != 0 and fromUnitHemophagiaDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_hemophagia",fromUnitHemophagia,fromUnitHemophagiaDuring )
		endif
		if( fromUnitHemophagiaSkill != 0 and fromUnitHemophagiaSkillDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_hemophagia_skill",fromUnitHemophagiaSkill,fromUnitHemophagiaSkillDuring )
		endif
		if( fromUnitSplit != 0 and fromUnitSplitDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_split",fromUnitSplit,fromUnitSplitDuring )
		endif
		if( fromUnitSwim != 0 and fromUnitSwimDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_swim",fromUnitSwim,fromUnitSwimDuring )
		endif
		if( fromUnitLuck != 0 and fromUnitLuckDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_luck",fromUnitLuck,fromUnitLuckDuring )
		endif
		if( fromUnitHuntAmplitude != 0 and fromUnitHuntAmplitudeDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_hunt_amplitude",fromUnitHuntAmplitude,fromUnitHuntAmplitudeDuring )
		endif
		if( fromUnitPoison != 0 and fromUnitPoisonDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_poison",fromUnitPoison,fromUnitPoisonDuring )
		endif
		if( fromUnitDry != 0 and fromUnitDryDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_dry",fromUnitDry,fromUnitDryDuring )
		endif
		if( fromUnitFreeze != 0 and fromUnitFreezeDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_freeze",fromUnitFreeze,fromUnitFreezeDuring )
		endif
		if( fromUnitCold != 0 and fromUnitColdDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_cold",fromUnitCold,fromUnitColdDuring )
		endif
		if( fromUnitBlunt != 0 and fromUnitBluntDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_blunt",fromUnitBlunt,fromUnitBluntDuring )
		endif
		if( fromUnitCorrosion != 0 and fromUnitCorrosionDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_corrosion",fromUnitCorrosion,fromUnitCorrosionDuring )
		endif
		if( fromUnitChaos != 0 and fromUnitChaosDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_chaos",fromUnitChaos,fromUnitChaosDuring )
		endif
		if( fromUnitTwine != 0 and fromUnitTwineDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_twine",fromUnitTwine,fromUnitTwineDuring )
		endif
		if( fromUnitBlind != 0 and fromUnitBlindDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_blind",fromUnitBlind,fromUnitBlindDuring )
		endif
		if( fromUnitWeak != 0 and fromUnitWeakDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_weak",fromUnitWeak,fromUnitWeakDuring )
		endif
		if( fromUnitBound != 0 and fromUnitBoundDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_bound",fromUnitBound,fromUnitBoundDuring )
		endif
		if( fromUnitFoolish != 0 and fromUnitFoolishDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_foolish",fromUnitFoolish,fromUnitFoolishDuring )
		endif
		if( fromUnitLazy != 0 and fromUnitLazyDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_lazy",fromUnitLazy,fromUnitLazyDuring )
		endif
		if( fromUnitSwimp != 0 and fromUnitSwimpDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_swimp",fromUnitSwimp,fromUnitSwimpDuring )
		endif
		if( fromUnitBreak != 0 and fromUnitBreakDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_break",fromUnitBreak,fromUnitBreakDuring )
		endif
		if( fromUnitHeavy != 0 and fromUnitHeavyDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_heavy",fromUnitHeavy,fromUnitHeavyDuring )
		endif
		if( fromUnitUnluck != 0 and fromUnitUnluckDuring > 0 ) then
		   call hAttrHunt_huntUnit( fromUnit,toUnit,null,0,"attack","physical",false,false,"effect_unluck",fromUnitUnluck,fromUnitUnluckDuring )
		endif
		set fromUnit = null
		set toUnit = null
	endfunction


	/* 英雄升级 - 计算白字 */
	private function triggerUnitHeroLevelAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		call hAttr_setStrWhite( u , GetHeroStr(u,false) , 0 )
		call hAttr_setAgiWhite( u , GetHeroAgi(u,false) , 0 )
		call hAttr_setIntWhite( u , GetHeroInt(u,false) , 0 )
		call hAttr_addHelp( u , 2 , 0 )
		call hAttr_addWeight( u , 0.25 )
		call hAttr_addLifeSource( u , 10 , 0 )
		call hAttr_addManaSource( u , 10 , 0 )
		set u = null
	endfunction

	/* 单位死亡（一般排除玩家的英雄） */
	private function triggerUnitDeathAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		if( hIs_hero(u)==false and IsUnitInGroup(u, ATTR_GROUP) ) then
			call groupOut(u)
		endif
		set u = null
	endfunction

	/* 注册单位 */
	private function triggerInAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		local integer uhid = GetHandleId(u)
		local boolean isBind = LoadBoolean( hash , uhid , 1 )
		//todo 注册事件
		if(isBind != true)then
			call hAttr_initAttr(u)
			call hAttrEffect_initAttr(u)
			call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_BEHUNT , u , EVENT_UNIT_DAMAGED )
			call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_DEATH , u , EVENT_UNIT_DEATH )
			if( hIs_hero(u) )then
				//英雄升级
				call TriggerRegisterUnitEvent( ATTR_TRIGGER_HERO_LEVEL , u , EVENT_UNIT_HERO_LEVEL )
	        endif
	        //硬直条
			if(PUNISH_SWITCH == true and (PUNISH_SWITCH_ONLYHERO==false or (PUNISH_SWITCH_ONLYHERO==true and hIs_hero(u))))then
				call punishTtg(u)
			endif
	        call SaveBoolean( hash , uhid , 1 , true )
		endif
        set u = null
	endfunction

	/* 设置硬直条 */
	public function setPunishTtg takes boolean status,boolean onlyHero returns nothing
		set PUNISH_SWITCH = status
		set PUNISH_SWITCH_ONLYHERO = onlyHero
	endfunction

	/* 初始化 */
	private function init takes nothing returns nothing

		local trigger triggerIn = CreateTrigger()
		//
		set hash = InitHashtable()
		//触发设定
		set ATTR_TRIGGER_UNIT_BEHUNT = CreateTrigger()
		set ATTR_TRIGGER_HERO_LEVEL = CreateTrigger()
		set ATTR_TRIGGER_UNIT_DEATH = CreateTrigger()
		call TriggerAddAction(ATTR_TRIGGER_UNIT_BEHUNT,function triggerUnitbeHuntAction)
		call TriggerAddAction(ATTR_TRIGGER_HERO_LEVEL, function triggerUnitHeroLevelAction)
		call TriggerAddAction(ATTR_TRIGGER_UNIT_DEATH, function triggerUnitDeathAction)

		//单位进入区域注册
		call TriggerRegisterEnterRectSimple( triggerIn , GetPlayableMapRect() )
		call TriggerAddAction( triggerIn , function triggerInAction)

		call hTimer_setInterval( 0.45 , function lifemanaback )
		call hTimer_setInterval(	5.00 , function punishback )

	endfunction

endlibrary
