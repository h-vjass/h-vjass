/* 属性 - 单位 */

globals
	hAttrUnit hattrUnit = 0
	hashtable hash_attr_unit = InitHashtable()
	boolean PUNISH_SWITCH = false 			//有的游戏不需要硬直条就把他关闭
	boolean PUNISH_SWITCH_ONLYHERO = true 	//是否只有英雄有硬直条
	real PUNISH_TEXTTAG_HEIGHT = 0
	trigger ATTR_TRIGGER_UNIT_BEHUNT = null
	trigger ATTR_TRIGGER_HERO_LEVEL = null
	trigger ATTR_TRIGGER_UNIT_DEATH = null
	group ATTR_GROUP = CreateGroup()
endglobals

struct hAttrUnit

	static method create takes nothing returns hAttrUnit
        local hAttrUnit x = 0
        set x = hAttrUnit.allocate()
        return x
    endmethod


	/* 设定硬直条是否显示 */
	public static method punishTtgIsOpen takes boolean isOpen returns nothing
		set PUNISH_SWITCH = isOpen
	endmethod

	/* 设定硬直条是否只有英雄显示 */
	public static method punishTtgIsOnlyHero takes boolean isOnlyhero returns nothing
		set PUNISH_SWITCH_ONLYHERO = isOnlyhero
	endmethod

	/* 设定硬直条高度 */
	public static method punishTtgHeight takes real high returns nothing
		if(hcamera.model=="zoomin")then
			set PUNISH_TEXTTAG_HEIGHT = high*0.5
		else
			set PUNISH_TEXTTAG_HEIGHT = high
		endif
	endmethod

	/* 把单位赶出属性组 */
	private static method groupOut takes unit whichUnit returns nothing
		if( IsUnitInGroup( whichUnit , ATTR_GROUP ) == true ) then
			call GroupRemoveUnit( ATTR_GROUP , whichUnit )
		endif
	endmethod

	/* 活力/魔法恢复 */
	private static method lifemanaback takes nothing returns nothing
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
		                call SetUnitLifeBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_LIFE, tempUnit) + ( hattrExt.getLifeBack(tempUnit) * period ) ) )
	            		call SetUnitManaBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_MANA, tempUnit) + ( hattrExt.getManaBack(tempUnit) * period ) ) )
	                endif
	            	//
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
	endmethod

	public static method createBlockText takes real current,real all,integer blockMax,string colorFt,string colorBg returns string
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
	endmethod

	/**
	 * 设置硬直漂浮字
	 */
    private static method punishTtgCall takes nothing returns nothing
    	local timer t = GetExpiredTimer()
		local string ttgStr = ""
		local unit whichUnit =  htime.getUnit(t,1)
		local texttag ttg =  htime.getTexttag(t,2)
		local real zOffset =  htime.getReal(t,3)
		local real size =  htime.getReal(t,4)
		local real punishNow = hattrExt.getPunishCurrent(whichUnit)
		local real punishAll = hattrExt.getPunish(whichUnit)
		local integer blockMax = 14
		local real scale = 0.5
		if( ttg == null ) then
        	call htime.delTimer(t)
        endif
        if(hcamera.model=="zoomin")then
        	set scale = 0.25
        elseif(hcamera.model=="zoomout")then
        	set scale = 1
        endif
        call SetTextTagPos( ttg , GetUnitX(whichUnit)-blockMax*size*scale , GetUnitY(whichUnit) , zOffset )
        if( his.alive(whichUnit)== false )then
        	call hmsg.setTtgMsg(ttg,"",size)
        	call SetTextTagVisibility( ttg , false )
        else
        	set ttgStr = createBlockText(punishNow,punishAll,blockMax,"f8f5ec","000000")
	        call hmsg.setTtgMsg(ttg,ttgStr,size)
	        call SetTextTagVisibility( ttg , true )
        endif
	endmethod

	//硬直条
	public static method punishTtg takes unit whichUnit returns nothing
		local timer t = null
		local texttag = ttg = null
		local real size = 5
		if(PUNISH_SWITCH == true and (PUNISH_SWITCH_ONLYHERO==false or (PUNISH_SWITCH_ONLYHERO==true and his.hero(whichUnit))))then
			set ttg = hmsg.ttg2Unit(whichUnit,"",size,"",10,0,PUNISH_TEXTTAG_HEIGHT)
	        set t =  htime.setInterval( 0.03 , function thistype.punishTtgCall )
	        call htime.setUnit( t , 1 , whichUnit )
	        call htime.setTexttag( t , 2 , ttg )
	        call htime.setReal( t , 3 , PUNISH_TEXTTAG_HEIGHT )
	        call htime.setReal( t , 4 , size )
		endif
	endmethod

	/* 硬直恢复器(+100/5s) */
	private static method punishback takes nothing returns nothing
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
	                call hattrExt.addPunishCurrent( tempUnit , 100 , 0 )
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
	endmethod

	/* 单位收到伤害(因为所有的伤害有hunt方法接管，所以这里的伤害全部是攻击伤害) */
	private static method triggerUnitbeHuntCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit fromUnit =  htime.getUnit(t,801)
		local unit toUnit =  htime.getUnit(t,802)
		local real damage =  htime.getReal(t,803)
		local real oldLife =  htime.getReal(t,804)
		local hAttrHuntBean bean = 0
		//计算攻击特效
		local real fromUnitLifeBack = hattrEffect.getLifeBack(fromUnit)
		local real fromUnitManaBack = hattrEffect.getManaBack(fromUnit)
		local real fromUnitAttackSpeed = hattrEffect.getAttackSpeed(fromUnit)
		local real fromUnitAttackPhysical = hattrEffect.getAttackPhysical(fromUnit)
		local real fromUnitAttackMagic = hattrEffect.getAttackMagic(fromUnit)
		local real fromUnitMove = hattrEffect.getMove(fromUnit)
		local real fromUnitAim = hattrEffect.getAim(fromUnit)
		local real fromUnitStr = hattrEffect.getStr(fromUnit)
		local real fromUnitAgi = hattrEffect.getAgi(fromUnit)
		local real fromUnitInt = hattrEffect.getInt(fromUnit)
		local real fromUnitKnocking = hattrEffect.getKnocking(fromUnit)
		local real fromUnitViolence = hattrEffect.getViolence(fromUnit)
		local real fromUnitHemophagia = hattrEffect.getHemophagia(fromUnit)
		local real fromUnitHemophagiaSkill = hattrEffect.getHemophagiaSkill(fromUnit)
		local real fromUnitSplit = hattrEffect.getSplit(fromUnit)
		local real fromUnitLuck = hattrEffect.getLuck(fromUnit)
		local real fromUnitHuntAmplitude = hattrEffect.getHuntAmplitude(fromUnit)
		local real fromUnitPoison = hattrEffect.getPoison(fromUnit)
		local real fromUnitDry = hattrEffect.getDry(fromUnit)
		local real fromUnitFreeze = hattrEffect.getFreeze(fromUnit)
		local real fromUnitCold = hattrEffect.getCold(fromUnit)
		local real fromUnitBlunt = hattrEffect.getBlunt(fromUnit)
		local real fromUnitCorrosion = hattrEffect.getCorrosion(fromUnit)
		local real fromUnitChaos = hattrEffect.getChaos(fromUnit)
		local real fromUnitTwine = hattrEffect.getTwine(fromUnit)
		local real fromUnitBlind = hattrEffect.getBlind(fromUnit)
		local real fromUnitTortua = hattrEffect.getTortua(fromUnit)
		local real fromUnitWeak = hattrEffect.getWeak(fromUnit)
		local real fromUnitBound = hattrEffect.getBound(fromUnit)
		local real fromUnitFoolish = hattrEffect.getFoolish(fromUnit)
		local real fromUnitLazy = hattrEffect.getLazy(fromUnit)
		local real fromUnitSwim = hattrEffect.getSwim(fromUnit)
		local real fromUnitBreak = hattrEffect.getBreak(fromUnit)
		local real fromUnitHeavy = hattrEffect.getHeavy(fromUnit)
		local real fromUnitUnluck = hattrEffect.getUnluck(fromUnit)

		local real fromUnitLifeBackDuring = hattrEffect.getLifeBackDuring(fromUnit)
		local real fromUnitManaBackDuring = hattrEffect.getManaBackDuring(fromUnit)
		local real fromUnitAttackSpeedDuring = hattrEffect.getAttackSpeedDuring(fromUnit)
		local real fromUnitAttackPhysicalDuring = hattrEffect.getAttackPhysicalDuring(fromUnit)
		local real fromUnitAttackMagicDuring = hattrEffect.getAttackMagicDuring(fromUnit)
		local real fromUnitMoveDuring = hattrEffect.getMoveDuring(fromUnit)
		local real fromUnitAimDuring = hattrEffect.getAimDuring(fromUnit)
		local real fromUnitStrDuring = hattrEffect.getStrDuring(fromUnit)
		local real fromUnitAgiDuring = hattrEffect.getAgiDuring(fromUnit)
		local real fromUnitIntDuring = hattrEffect.getIntDuring(fromUnit)
		local real fromUnitKnockingDuring = hattrEffect.getKnockingDuring(fromUnit)
		local real fromUnitViolenceDuring = hattrEffect.getViolenceDuring(fromUnit)
		local real fromUnitHemophagiaDuring = hattrEffect.getHemophagiaDuring(fromUnit)
		local real fromUnitHemophagiaSkillDuring = hattrEffect.getHemophagiaSkillDuring(fromUnit)
		local real fromUnitSplitDuring = hattrEffect.getSplitDuring(fromUnit)
		local real fromUnitLuckDuring = hattrEffect.getLuckDuring(fromUnit)
		local real fromUnitHuntAmplitudeDuring = hattrEffect.getHuntAmplitudeDuring(fromUnit)
		local real fromUnitPoisonDuring = hattrEffect.getPoisonDuring(fromUnit)
		local real fromUnitDryDuring = hattrEffect.getDryDuring(fromUnit)
		local real fromUnitFreezeDuring = hattrEffect.getFreezeDuring(fromUnit)
		local real fromUnitColdDuring = hattrEffect.getColdDuring(fromUnit)
		local real fromUnitBluntDuring = hattrEffect.getBluntDuring(fromUnit)
		local real fromUnitCorrosionDuring = hattrEffect.getCorrosionDuring(fromUnit)
		local real fromUnitChaosDuring = hattrEffect.getChaosDuring(fromUnit)
		local real fromUnitTwineDuring = hattrEffect.getTwineDuring(fromUnit)
		local real fromUnitBlindDuring = hattrEffect.getBlindDuring(fromUnit)
		local real fromUnitTortuaDuring = hattrEffect.getTortuaDuring(fromUnit)
		local real fromUnitWeakDuring = hattrEffect.getWeakDuring(fromUnit)
		local real fromUnitBoundDuring = hattrEffect.getBoundDuring(fromUnit)
		local real fromUnitFoolishDuring = hattrEffect.getFoolishDuring(fromUnit)
		local real fromUnitLazyDuring = hattrEffect.getLazyDuring(fromUnit)
		local real fromUnitSwimDuring = hattrEffect.getSwimDuring(fromUnit)
		local real fromUnitBreakDuring = hattrEffect.getBreakDuring(fromUnit)
		local real fromUnitHeavyDuring = hattrEffect.getHeavyDuring(fromUnit)
		local real fromUnitUnluckDuring = hattrEffect.getUnluckDuring(fromUnit)

		call htime.delTimer(t)
		call hattr.subLife(toUnit,damage,0)
		call hunit.setLife(toUnit,oldLife)

		call bean.create()
		set bean.fromUnit = fromUnit
		set bean.toUnit = toUnit
		set bean.damage = damage
		set bean.huntKind = "attack"
		set bean.huntType = "physical"
		call hattrHunt.huntUnit( bean )
		call bean.destroy()

		//伤害特效
		call bean.create()
		set bean.fromUnit = fromUnit
		set bean.toUnit = toUnit
		set bean.huntKind = "attack"
		set bean.huntType = "physical"
		if( fromUnitLifeBack != 0 and fromUnitLifeBackDuring > 0 ) then
		   set bean.special = "effect_life_back"
		   set bean.specialVal = fromUnitLifeBack
		   set bean.specialDuring = fromUnitLifeBackDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitManaBack != 0 and fromUnitManaBackDuring > 0 ) then
		   set bean.special = "effect_mana_back"
		   set bean.specialVal = fromUnitManaBack
		   set bean.specialDuring = fromUnitManaBackDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitAttackSpeed != 0 and fromUnitAttackSpeedDuring > 0 ) then
		   set bean.special = "effect_attack_speed"
		   set bean.specialVal = fromUnitAttackSpeed
		   set bean.specialDuring = fromUnitAttackSpeedDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitAttackPhysical != 0 and fromUnitAttackPhysicalDuring > 0 ) then
		   set bean.special = "effect_attack_physical"
		   set bean.specialVal = fromUnitAttackPhysical
		   set bean.specialDuring = fromUnitAttackPhysicalDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitAttackMagic != 0 and fromUnitAttackMagicDuring > 0 ) then
		   set bean.special = "effect_attack_magic"
		   set bean.specialVal = fromUnitAttackMagic
		   set bean.specialDuring = fromUnitAttackMagicDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitMove != 0 and fromUnitMoveDuring > 0 ) then
		   set bean.special = "effect_move"
		   set bean.specialVal = fromUnitMove
		   set bean.specialDuring = fromUnitMoveDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitAim != 0 and fromUnitAimDuring > 0 ) then
		   set bean.special = "effect_aim"
		   set bean.specialVal = fromUnitAim
		   set bean.specialDuring = fromUnitAimDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitStr != 0 and fromUnitStrDuring > 0 ) then
		   set bean.special = "effect_str"
		   set bean.specialVal = fromUnitStr
		   set bean.specialDuring = fromUnitStrDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitAgi != 0 and fromUnitAgiDuring > 0 ) then
		   set bean.special = "effect_agi"
		   set bean.specialVal = fromUnitAgi
		   set bean.specialDuring = fromUnitAgiDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitInt != 0 and fromUnitIntDuring > 0 ) then
		   set bean.special = "effect_int"
		   set bean.specialVal = fromUnitInt
		   set bean.specialDuring = fromUnitIntDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitKnocking != 0 and fromUnitKnockingDuring > 0 ) then
		   set bean.special = "effect_knocking"
		   set bean.specialVal = fromUnitKnocking
		   set bean.specialDuring = fromUnitKnockingDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitViolence != 0 and fromUnitViolenceDuring > 0 ) then
		   set bean.special = "effect_violence"
		   set bean.specialVal = fromUnitViolence
		   set bean.specialDuring = fromUnitViolenceDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitHemophagia != 0 and fromUnitHemophagiaDuring > 0 ) then
		   set bean.special = "effect_hemophagia"
		   set bean.specialVal = fromUnitHemophagia
		   set bean.specialDuring = fromUnitHemophagiaDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitHemophagiaSkill != 0 and fromUnitHemophagiaSkillDuring > 0 ) then
		   set bean.special = "effect_hemophagia_skill"
		   set bean.specialVal = fromUnitHemophagiaSkill
		   set bean.specialDuring = fromUnitHemophagiaSkillDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitSplit != 0 and fromUnitSplitDuring > 0 ) then
		   set bean.special = "effect_split"
		   set bean.specialVal = fromUnitSplit
		   set bean.specialDuring = fromUnitSplitDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitLuck != 0 and fromUnitLuckDuring > 0 ) then
		   set bean.special = "effect_luck"
		   set bean.specialVal = fromUnitLuck
		   set bean.specialDuring = fromUnitLuckDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitHuntAmplitude != 0 and fromUnitHuntAmplitudeDuring > 0 ) then
		   set bean.special = "effect_hunt_amplitude"
		   set bean.specialVal = fromUnitHuntAmplitude
		   set bean.specialDuring = fromUnitHuntAmplitudeDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitPoison != 0 and fromUnitPoisonDuring > 0 ) then
		   set bean.special = "effect_poison"
		   set bean.specialVal = fromUnitPoison
		   set bean.specialDuring = fromUnitPoisonDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitDry != 0 and fromUnitDryDuring > 0 ) then
		   set bean.special = "effect_dry"
		   set bean.specialVal = fromUnitDry
		   set bean.specialDuring = fromUnitDryDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitFreeze != 0 and fromUnitFreezeDuring > 0 ) then
		   set bean.special = "effect_freeze"
		   set bean.specialVal = fromUnitFreeze
		   set bean.specialDuring = fromUnitFreezeDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitCold != 0 and fromUnitColdDuring > 0 ) then
		   set bean.special = "effect_cold"
		   set bean.specialVal = fromUnitCold
		   set bean.specialDuring = fromUnitColdDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitBlunt != 0 and fromUnitBluntDuring > 0 ) then
		   set bean.special = "effect_blunt"
		   set bean.specialVal = fromUnitBlunt
		   set bean.specialDuring = fromUnitBluntDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitCorrosion != 0 and fromUnitCorrosionDuring > 0 ) then
		   set bean.special = "effect_corrosion"
		   set bean.specialVal = fromUnitCorrosion
		   set bean.specialDuring = fromUnitCorrosionDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitChaos != 0 and fromUnitChaosDuring > 0 ) then
		   set bean.special = "effect_chaos"
		   set bean.specialVal = fromUnitChaos
		   set bean.specialDuring = fromUnitChaosDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitTwine != 0 and fromUnitTwineDuring > 0 ) then
		   set bean.special = "effect_twine"
		   set bean.specialVal = fromUnitTwine
		   set bean.specialDuring = fromUnitTwineDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitBlind != 0 and fromUnitBlindDuring > 0 ) then
		   set bean.special = "effect_blind"
		   set bean.specialVal = fromUnitBlind
		   set bean.specialDuring = fromUnitBlindDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitTortua != 0 and fromUnitTortuaDuring > 0 ) then
		   set bean.special = "effect_tortua"
		   set bean.specialVal = fromUnitTortua
		   set bean.specialDuring = fromUnitTortuaDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitWeak != 0 and fromUnitWeakDuring > 0 ) then
		   set bean.special = "effect_weak"
		   set bean.specialVal = fromUnitWeak
		   set bean.specialDuring = fromUnitWeakDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitBound != 0 and fromUnitBoundDuring > 0 ) then
		   set bean.special = "effect_bound"
		   set bean.specialVal = fromUnitBound
		   set bean.specialDuring = fromUnitBoundDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitFoolish != 0 and fromUnitFoolishDuring > 0 ) then
		   set bean.special = "effect_foolish"
		   set bean.specialVal = fromUnitFoolish
		   set bean.specialDuring = fromUnitFoolishDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitLazy != 0 and fromUnitLazyDuring > 0 ) then
		   set bean.special = "effect_lazy"
		   set bean.specialVal = fromUnitLazy
		   set bean.specialDuring = fromUnitLazyDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitSwim != 0 and fromUnitSwimDuring > 0 ) then
		   set bean.special = "effect_swim"
		   set bean.specialVal = fromUnitSwim
		   set bean.specialDuring = fromUnitSwimDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitBreak != 0 and fromUnitBreakDuring > 0 ) then
		   set bean.special = "effect_break"
		   set bean.specialVal = fromUnitBreak
		   set bean.specialDuring = fromUnitBreakDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitHeavy != 0 and fromUnitHeavyDuring > 0 ) then
		   set bean.special = "effect_heavy"
		   set bean.specialVal = fromUnitHeavy
		   set bean.specialDuring = fromUnitHeavyDuring
		   call hattrHunt.huntUnit(bean)
		endif
		if( fromUnitUnluck != 0 and fromUnitUnluckDuring > 0 ) then
		   set bean.special = "effect_unluck"
		   set bean.specialVal = fromUnitUnluck
		   set bean.specialDuring = fromUnitUnluckDuring
		   call hattrHunt.huntUnit(bean)
		endif
		call bean.destroy()
	endmethod
	private static method triggerUnitbeHuntAction takes nothing returns nothing
		local unit fromUnit = GetEventDamageSource()
		local unit toUnit = GetTriggerUnit()
		local real damage = GetEventDamage()
		local real oldLife = hunit.getLife(toUnit)
		local timer t = null
		if(damage>0.4)then
			call hattr.addLife(toUnit,damage,0)
			set t =  htime.setTimeout(0,function thistype.triggerUnitbeHuntCall)
			call htime.setUnit(t,801,fromUnit)
			call htime.setUnit(t,802,toUnit)
			call htime.setReal(t,803,damage)
			call htime.setReal(t,804,oldLife)
		endif
		set fromUnit = null
		set toUnit = null
	endmethod

	/* 英雄升级 - 计算白字 */
	private static method triggerUnitHeroLevelAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		call hattr.setStrWhite( u , GetHeroStr(u,false) , 0 )
		call hattr.setAgiWhite( u , GetHeroAgi(u,false) , 0 )
		call hattr.setIntWhite( u , GetHeroInt(u,false) , 0 )
		call hattrExt.addHelp( u , 2 , 0 )
		call hattrExt.addWeight( u , 0.25 , 0 )
		call hattrExt.addLifeSource( u , 10 , 0 )
		call hattrExt.addManaSource( u , 10 , 0 )

		//@触发升级事件
		set hevtBean = hEvtBean.create()
        set hevtBean.triggerKey = "levelUp"
        set hevtBean.triggerUnit = u
        call hevt.triggerEvent(hevtBean)
        call hevtBean.destroy()

		set u = null
	endmethod

	/* 单位死亡（一般排除玩家的英雄） */
	private static method triggerUnitDeathAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		local unit killer = hevt.getLastDamageUnit(u)
		if( his.hero(u)==false and IsUnitInGroup(u, ATTR_GROUP) ) then
			call groupOut(u)
		endif
		if( PUNISH_SWITCH == true )then
			call SaveTextTagHandle(hash_attr_unit, GetHandleId(u), 7896 , null)
		endif
		//@触发死亡事件
		set hevtBean = hEvtBean.create()
        set hevtBean.triggerKey = "dead"
        set hevtBean.triggerUnit = u
        set hevtBean.killer = killer
        call hevt.triggerEvent(hevtBean)
        call hevtBean.destroy()
        //@触发击杀事件
        set hevtBean = hEvtBean.create()
        set hevtBean.triggerKey = "kill"
        set hevtBean.killer = killer
        set hevtBean.triggerUnit = killer
        set hevtBean.targetUnit = u
        call hevt.triggerEvent(hevtBean)
        call hevtBean.destroy()
		set u = null
	endmethod

	/* 注册单位 */
	private static method triggerInAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		local integer utid = GetUnitTypeId(u)
		local integer uhid = GetHandleId(u)
		local boolean isBind = false
		//排除单位类型
		if(utid==ABILITY_TOKEN or utid==ABILITY_BREAK or utid==ABILITY_SWIM)then
			return
		endif
		//注册事件
		set isBind = LoadBoolean( hash_attr_unit , uhid , 1 )
		if(isBind != true)then
			call hconsole.log(GetUnitName(u)+"注册了属性")
			call GroupAddUnit(ATTR_GROUP, u)
			call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_BEHUNT , u , EVENT_UNIT_DAMAGED )
			call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_DEATH , u , EVENT_UNIT_DEATH )
			if( his.hero(u) )then
				//英雄升级
				call TriggerRegisterUnitEvent( ATTR_TRIGGER_HERO_LEVEL , u , EVENT_UNIT_HERO_LEVEL )
	        endif
	        call punishTtg(u)
	        call SaveBoolean( hash_attr_unit , uhid , 1 , true )
		endif
        set u = null
	endmethod

	/* 初始化 */
	public static method initSet takes nothing returns nothing
		local trigger triggerIn = CreateTrigger()
		//触发设定
		set ATTR_TRIGGER_UNIT_BEHUNT = CreateTrigger()
		set ATTR_TRIGGER_HERO_LEVEL = CreateTrigger()
		set ATTR_TRIGGER_UNIT_DEATH = CreateTrigger()
		call TriggerAddAction(ATTR_TRIGGER_UNIT_BEHUNT,function thistype.triggerUnitbeHuntAction)
		call TriggerAddAction(ATTR_TRIGGER_HERO_LEVEL, function thistype.triggerUnitHeroLevelAction)
		call TriggerAddAction(ATTR_TRIGGER_UNIT_DEATH, function thistype.triggerUnitDeathAction)

		//单位进入区域注册
		call TriggerRegisterEnterRectSimple( triggerIn , GetPlayableMapRect() )
		call TriggerAddAction( triggerIn , function thistype.triggerInAction)

		call htime.setInterval( 0.45 , function thistype.lifemanaback )
		call htime.setInterval( 5.00 , function thistype.punishback )

	endmethod

endstruct
