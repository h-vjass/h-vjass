/* 属性 - 单位 */
library hAttrUnit initializer init needs hAttrHunt

	globals
		private boolean PUNISH_SWITCH = true 			//有的游戏不需要硬直条就把他关闭
		private boolean PUNISH_SWITCH_ONLYHERO = false 	//是否只有英雄有硬直条
		private real PUNISH_TEXTTAG_HEIGHT = 0

		private trigger ATTR_TRIGGER_UNIT_BEHUNT = null
		private trigger ATTR_TRIGGER_HERO_LEVEL = null
		private trigger ATTR_TRIGGER_UNIT_DEATH = null

		private hashtable hash = null
		private group ATTR_GROUP = CreateGroup()

	endglobals

	/* 设定硬直条是否显示 */
	public function punishTtgIsOpen takes boolean isOpen returns nothing
		set PUNISH_SWITCH = isOpen
	endfunction

	/* 设定硬直条是否只有英雄显示 */
	public function punishTtgIsOnlyHero takes boolean isOnlyhero returns nothing
		set PUNISH_SWITCH_ONLYHERO = isOnlyhero
	endfunction

	/* 设定硬直条高度 */
	public function punishTtgHeight takes real high returns nothing
		if(camera.model=="zoomin")then
			set PUNISH_TEXTTAG_HEIGHT = high*0.5
		else
			set PUNISH_TEXTTAG_HEIGHT = high
		endif
	endfunction

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
		                call SetUnitLifeBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_LIFE, tempUnit) + ( hAttrExt_getLifeBack(tempUnit) * period ) ) )
	            		call SetUnitManaBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_MANA, tempUnit) + ( hAttrExt_getManaBack(tempUnit) * period ) ) )
	                endif
	            	//
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
	endfunction

	public function createBlockText takes real current,real all,integer blockMax,string colorFt,string colorBg returns string
		local string str = ""
		local string font = "■"
		local real percent = 0
		local integer block = 0
		local integer i = 0
		if( all > 0 ) then
            set percent = current / all
            set block = R2I(percent * I2R(blockMax))
            if( current >= all ) then
                set block = R2I(blockMax)
            endif
            set i = 1
            loop
                exitwhen i > blockMax
                    if( i <= block ) then
                        set str = str + "|cff"+colorFt+font+"|r"
                    else
                        set str = str + "|cff"+colorBg+font+"|r"
                    endif
                set i = i + 1
            endloop
        endif
        return str
	endfunction

	/**
	 * 设置硬直漂浮字
	 */
    private function punishTtgCall takes nothing returns nothing
    	local timer t = GetExpiredTimer()
		local string ttgStr = ""
		local unit whichUnit = time.getUnit(t,1)
		local texttag ttg = time.getTexttag(t,2)
		local real zOffset = time.getReal(t,3)
		local real size = time.getReal(t,4)
		local real punishNow = hAttrExt_getPunishCurrent(whichUnit)
		local real punishAll = hAttrExt_getPunish(whichUnit)
		local integer blockMax = 14
		local real scale = 0.5
		if( ttg == null ) then
        	call time.delTimer(t)
        endif
        if(camera.model=="zoomin")then
        	set scale = 0.25
        elseif(camera.model=="zoomout")then
        	set scale = 1
        endif
        call SetTextTagPos( ttg , GetUnitX(whichUnit)-blockMax*size*scale , GetUnitY(whichUnit) , zOffset )
        if( is.alive(whichUnit)== false )then
        	call hmsg.setTtgMsg(ttg,"",size)
        	call SetTextTagVisibility( ttg , false )
        else
        	set ttgStr = createBlockText(punishNow,punishAll,blockMax,"f8f5ec","000000")
	        call hmsg.setTtgMsg(ttg,ttgStr,size)
	        call SetTextTagVisibility( ttg , true )
        endif
	endfunction

	//硬直条
	public function punishTtg takes unit whichUnit returns nothing
		local timer t = null
		local texttag = ttg = null
		local real size = 5
		if(PUNISH_SWITCH == true and (PUNISH_SWITCH_ONLYHERO==false or (PUNISH_SWITCH_ONLYHERO==true and is.hero(whichUnit))))then

			set ttg = hmsg.ttg2Unit(whichUnit,"",size,"",10,0,PUNISH_TEXTTAG_HEIGHT)
	        set t = time.setInterval( 0.03 , function punishTtgCall )
	        call time.setUnit( t , 1 , whichUnit )
	        call time.setTexttag( t , 2 , ttg )
	        call time.setReal( t , 3 , PUNISH_TEXTTAG_HEIGHT )
	        call time.setReal( t , 4 , size )
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
	                if( is.hero(tempUnit) )then
		                call hAttrExt_addPunishCurrent( tempUnit , 100 , 0 )
	                endif
	            	//
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
	endfunction

	/* 单位收到伤害(因为所有的伤害有hunt方法接管，所以这里的伤害全部是攻击伤害) */
	private function triggerUnitbeHuntAction takes nothing returns nothing
		local unit fromUnit = GetEventDamageSource()
		local unit toUnit = GetTriggerUnit()
		local real damage = GetEventDamage()
		local hAttrHuntBean bean = 0

		local integer i = 0
		local trigger tempTgr = null

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
		local real fromUnitTortua = hAttrEffect_getTortua(fromUnit)
		local real fromUnitWeak = hAttrEffect_getWeak(fromUnit)
		local real fromUnitBound = hAttrEffect_getBound(fromUnit)
		local real fromUnitFoolish = hAttrEffect_getFoolish(fromUnit)
		local real fromUnitLazy = hAttrEffect_getLazy(fromUnit)
		local real fromUnitSwim = hAttrEffect_getSwim(fromUnit)
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
		local real fromUnitTortuaDuring = hAttrEffect_getTortuaDuring(fromUnit)
		local real fromUnitWeakDuring = hAttrEffect_getWeakDuring(fromUnit)
		local real fromUnitBoundDuring = hAttrEffect_getBoundDuring(fromUnit)
		local real fromUnitFoolishDuring = hAttrEffect_getFoolishDuring(fromUnit)
		local real fromUnitLazyDuring = hAttrEffect_getLazyDuring(fromUnit)
		local real fromUnitSwimDuring = hAttrEffect_getSwimDuring(fromUnit)
		local real fromUnitBreakDuring = hAttrEffect_getBreakDuring(fromUnit)
		local real fromUnitHeavyDuring = hAttrEffect_getHeavyDuring(fromUnit)
		local real fromUnitUnluckDuring = hAttrEffect_getUnluckDuring(fromUnit)

		if(damage>0.5)then
			call console.info("basedamage"+R2S(damage))
			call hAbility_avoid(toUnit) //抵消伤害
			call bean.create()
			set bean.fromUnit = fromUnit
			set bean.toUnit = toUnit
			set bean.damage = damage
			set bean.huntKind = "attack"
			set bean.huntType = "physical"
			call hAttrHunt_huntUnit( bean )
			call bean.destroy()
		endif
		//攻击特效
		call bean.create()
		set bean.fromUnit = fromUnit
		set bean.toUnit = toUnit
		set bean.huntKind = "attack"
		set bean.huntType = "physical"
		if( fromUnitLifeBack != 0 and fromUnitLifeBackDuring > 0 ) then
		   set bean.special = "effect_life_back"
		   set bean.specialVal = fromUnitLifeBack
		   set bean.specialDuring = fromUnitLifeBackDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitManaBack != 0 and fromUnitManaBackDuring > 0 ) then
		   set bean.special = "effect_mana_back"
		   set bean.specialVal = fromUnitManaBack
		   set bean.specialDuring = fromUnitManaBackDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitAttackSpeed != 0 and fromUnitAttackSpeedDuring > 0 ) then
		   set bean.special = "effect_attack_speed"
		   set bean.specialVal = fromUnitAttackSpeed
		   set bean.specialDuring = fromUnitAttackSpeedDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitAttackPhysical != 0 and fromUnitAttackPhysicalDuring > 0 ) then
		   set bean.special = "effect_attack_physical"
		   set bean.specialVal = fromUnitAttackPhysical
		   set bean.specialDuring = fromUnitAttackPhysicalDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitAttackMagic != 0 and fromUnitAttackMagicDuring > 0 ) then
		   set bean.special = "effect_attack_magic"
		   set bean.specialVal = fromUnitAttackMagic
		   set bean.specialDuring = fromUnitAttackMagicDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitMove != 0 and fromUnitMoveDuring > 0 ) then
		   set bean.special = "effect_move"
		   set bean.specialVal = fromUnitMove
		   set bean.specialDuring = fromUnitMoveDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitAim != 0 and fromUnitAimDuring > 0 ) then
		   set bean.special = "effect_aim"
		   set bean.specialVal = fromUnitAim
		   set bean.specialDuring = fromUnitAimDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitStr != 0 and fromUnitStrDuring > 0 ) then
		   set bean.special = "effect_str"
		   set bean.specialVal = fromUnitStr
		   set bean.specialDuring = fromUnitStrDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitAgi != 0 and fromUnitAgiDuring > 0 ) then
		   set bean.special = "effect_agi"
		   set bean.specialVal = fromUnitAgi
		   set bean.specialDuring = fromUnitAgiDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitInt != 0 and fromUnitIntDuring > 0 ) then
		   set bean.special = "effect_int"
		   set bean.specialVal = fromUnitInt
		   set bean.specialDuring = fromUnitIntDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitKnocking != 0 and fromUnitKnockingDuring > 0 ) then
		   set bean.special = "effect_knocking"
		   set bean.specialVal = fromUnitKnocking
		   set bean.specialDuring = fromUnitKnockingDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitViolence != 0 and fromUnitViolenceDuring > 0 ) then
		   set bean.special = "effect_violence"
		   set bean.specialVal = fromUnitViolence
		   set bean.specialDuring = fromUnitViolenceDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitHemophagia != 0 and fromUnitHemophagiaDuring > 0 ) then
		   set bean.special = "effect_hemophagia"
		   set bean.specialVal = fromUnitHemophagia
		   set bean.specialDuring = fromUnitHemophagiaDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitHemophagiaSkill != 0 and fromUnitHemophagiaSkillDuring > 0 ) then
		   set bean.special = "effect_hemophagia_skill"
		   set bean.specialVal = fromUnitHemophagiaSkill
		   set bean.specialDuring = fromUnitHemophagiaSkillDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitSplit != 0 and fromUnitSplitDuring > 0 ) then
		   set bean.special = "effect_split"
		   set bean.specialVal = fromUnitSplit
		   set bean.specialDuring = fromUnitSplitDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitLuck != 0 and fromUnitLuckDuring > 0 ) then
		   set bean.special = "effect_luck"
		   set bean.specialVal = fromUnitLuck
		   set bean.specialDuring = fromUnitLuckDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitHuntAmplitude != 0 and fromUnitHuntAmplitudeDuring > 0 ) then
		   set bean.special = "effect_hunt_amplitude"
		   set bean.specialVal = fromUnitHuntAmplitude
		   set bean.specialDuring = fromUnitHuntAmplitudeDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitPoison != 0 and fromUnitPoisonDuring > 0 ) then
		   set bean.special = "effect_poison"
		   set bean.specialVal = fromUnitPoison
		   set bean.specialDuring = fromUnitPoisonDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitDry != 0 and fromUnitDryDuring > 0 ) then
		   set bean.special = "effect_dry"
		   set bean.specialVal = fromUnitDry
		   set bean.specialDuring = fromUnitDryDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitFreeze != 0 and fromUnitFreezeDuring > 0 ) then
		   set bean.special = "effect_freeze"
		   set bean.specialVal = fromUnitFreeze
		   set bean.specialDuring = fromUnitFreezeDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitCold != 0 and fromUnitColdDuring > 0 ) then
		   set bean.special = "effect_cold"
		   set bean.specialVal = fromUnitCold
		   set bean.specialDuring = fromUnitColdDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitBlunt != 0 and fromUnitBluntDuring > 0 ) then
		   set bean.special = "effect_blunt"
		   set bean.specialVal = fromUnitBlunt
		   set bean.specialDuring = fromUnitBluntDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitCorrosion != 0 and fromUnitCorrosionDuring > 0 ) then
		   set bean.special = "effect_corrosion"
		   set bean.specialVal = fromUnitCorrosion
		   set bean.specialDuring = fromUnitCorrosionDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitChaos != 0 and fromUnitChaosDuring > 0 ) then
		   set bean.special = "effect_chaos"
		   set bean.specialVal = fromUnitChaos
		   set bean.specialDuring = fromUnitChaosDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitTwine != 0 and fromUnitTwineDuring > 0 ) then
		   set bean.special = "effect_twine"
		   set bean.specialVal = fromUnitTwine
		   set bean.specialDuring = fromUnitTwineDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitBlind != 0 and fromUnitBlindDuring > 0 ) then
		   set bean.special = "effect_blind"
		   set bean.specialVal = fromUnitBlind
		   set bean.specialDuring = fromUnitBlindDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitTortua != 0 and fromUnitTortuaDuring > 0 ) then
		   set bean.special = "effect_tortua"
		   set bean.specialVal = fromUnitTortua
		   set bean.specialDuring = fromUnitTortuaDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitWeak != 0 and fromUnitWeakDuring > 0 ) then
		   set bean.special = "effect_weak"
		   set bean.specialVal = fromUnitWeak
		   set bean.specialDuring = fromUnitWeakDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitBound != 0 and fromUnitBoundDuring > 0 ) then
		   set bean.special = "effect_bound"
		   set bean.specialVal = fromUnitBound
		   set bean.specialDuring = fromUnitBoundDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitFoolish != 0 and fromUnitFoolishDuring > 0 ) then
		   set bean.special = "effect_foolish"
		   set bean.specialVal = fromUnitFoolish
		   set bean.specialDuring = fromUnitFoolishDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitLazy != 0 and fromUnitLazyDuring > 0 ) then
		   set bean.special = "effect_lazy"
		   set bean.specialVal = fromUnitLazy
		   set bean.specialDuring = fromUnitLazyDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitSwim != 0 and fromUnitSwimDuring > 0 ) then
		   set bean.special = "effect_swim"
		   set bean.specialVal = fromUnitSwim
		   set bean.specialDuring = fromUnitSwimDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitBreak != 0 and fromUnitBreakDuring > 0 ) then
		   set bean.special = "effect_break"
		   set bean.specialVal = fromUnitBreak
		   set bean.specialDuring = fromUnitBreakDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitHeavy != 0 and fromUnitHeavyDuring > 0 ) then
		   set bean.special = "effect_heavy"
		   set bean.specialVal = fromUnitHeavy
		   set bean.specialDuring = fromUnitHeavyDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		if( fromUnitUnluck != 0 and fromUnitUnluckDuring > 0 ) then
		   set bean.special = "effect_unluck"
		   set bean.specialVal = fromUnitUnluck
		   set bean.specialDuring = fromUnitUnluckDuring
		   call hAttrHunt_huntUnit(bean)
		endif
		call bean.destroy()
		//TODO 触发攻击事件
		if(hEvent_isRegisterAttack(fromUnit)==true)then
			set i = hEvent_getAttackInc(fromUnit)
			loop
				exitwhen i==0
				set tempTgr = hEvent_getAttackTrigger(fromUnit,i)
				call hEvent_setAttacker(tempTgr,fromUnit)
				call TriggerExecute(tempTgr)
				set tempTgr = null
				set i=i-1
			endloop
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
		call hAttrExt_addHelp( u , 2 , 0 )
		call hAttrExt_addWeight( u , 0.25 , 0 )
		call hAttrExt_addLifeSource( u , 10 , 0 )
		call hAttrExt_addManaSource( u , 10 , 0 )
		set u = null
	endfunction

	/* 单位死亡（一般排除玩家的英雄） */
	private function triggerUnitDeathAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		if( is.hero(u)==false and IsUnitInGroup(u, ATTR_GROUP) ) then
			call groupOut(u)
		endif
		if( PUNISH_SWITCH == true )then
			call SaveTextTagHandle(hash, GetHandleId(u), 7896 , null)
		endif
		set u = null
	endfunction

	/* 注册单位 */
	private function triggerInAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		local integer utid = GetUnitTypeId(u)
		local integer uhid = GetHandleId(u)
		local boolean isBind = false
		//排除单位类型
		if(utid==hAbility_ABILITY_TOKEN or utid==hAbility_ABILITY_BREAK or utid==hAbility_ABILITY_SWIM)then
			return
		endif
		//注册事件
		set isBind = LoadBoolean( hash , uhid , 1 )
		if(isBind != true)then
			call console.log(GetUnitName(u)+"注册了属性")
			call GroupAddUnit(ATTR_GROUP, u)
			call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_BEHUNT , u , EVENT_UNIT_DAMAGED )
			call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_DEATH , u , EVENT_UNIT_DEATH )
			if( is.hero(u) )then
				//英雄升级
				call TriggerRegisterUnitEvent( ATTR_TRIGGER_HERO_LEVEL , u , EVENT_UNIT_HERO_LEVEL )
	        endif
	        call punishTtg(u)
	        call SaveBoolean( hash , uhid , 1 , true )
		endif
        set u = null
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

		call time.setInterval( 0.45 , function lifemanaback )
		call time.setInterval( 5.00 , function punishback )

	endfunction

endlibrary
