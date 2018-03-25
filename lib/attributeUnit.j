//属性 - 单位

globals
	hAttrUnit hattrUnit
	hashtable hash_attr_unit = null
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



	//根据bean修改单位属性
	public static method modifyAttrByBean takes unit whichUnit,hAttrBean bean,real during returns nothing
		if(bean.attackHuntType!="")then
			call hattr.setAttackHuntType(whichUnit,bean.attackHuntType,during)
		endif
		//COPY
		if(bean.life>0)then
			call hattr.addLife(whichUnit,bean.life,during)
		elseif(bean.life<0)then
			call hattr.subLife(whichUnit,bean.life,during)
		endif
		if(bean.mana>0)then
			call hattr.addMana(whichUnit,bean.mana,during)
		elseif(bean.mana<0)then
			call hattr.subMana(whichUnit,bean.mana,during)
		endif
		if(bean.move>0)then
			call hattr.addMove(whichUnit,bean.move,during)
		elseif(bean.move<0)then
			call hattr.subMove(whichUnit,bean.move,during)
		endif
		if(bean.defend>0)then
			call hattr.addDefend (whichUnit,bean.defend ,during)
		elseif(bean.defend<0)then
			call hattr.subDefend (whichUnit,bean.defend ,during)
		endif
		if(bean.attackSpeed>0)then
			call hattr.addAttackSpeed(whichUnit,bean.attackSpeed ,during)
		elseif(bean.attackSpeed<0)then
			call hattr.subAttackSpeed(whichUnit,bean.attackSpeed ,during)
		endif
		if(bean.attackPhysical>0)then
			call hattr.addAttackPhysical(whichUnit,bean.attackPhysical,during)
		elseif(bean.attackPhysical<0)then
			call hattr.subAttackPhysical(whichUnit,bean.attackPhysical,during)
		endif
		if(bean.attackMagic>0)then
			call hattr.addAttackMagic(whichUnit,bean.attackMagic,during)
		elseif(bean.attackMagic<0)then
			call hattr.subAttackMagic(whichUnit,bean.attackMagic,during)
		endif
		if(bean.str>0)then
			call hattr.addStr(whichUnit,bean.str,during)
		elseif(bean.str<0)then
			call hattr.subStr(whichUnit,bean.str,during)
		endif
		if(bean.agi>0)then
			call hattr.addAgi(whichUnit,bean.agi,during)
		elseif(bean.agi<0)then
			call hattr.subAgi(whichUnit,bean.agi,during)
		endif
		if(bean.int>0)then
			call hattr.addInt(whichUnit,bean.int,during)
		elseif(bean.int<0)then
			call hattr.subInt(whichUnit,bean.int,during)
		endif
		if(bean.strWhite>0)then
			call hattr.addStrWhite(whichUnit,bean.strWhite,during)
		elseif(bean.strWhite<0)then
			call hattr.subStrWhite(whichUnit,bean.strWhite,during)
		endif
		if(bean.agiWhite>0)then
			call hattr.addAgiWhite(whichUnit,bean.agiWhite,during)
		elseif(bean.agiWhite<0)then
			call hattr.subAgiWhite(whichUnit,bean.agiWhite,during)
		endif
		if(bean.intWhite>0)then
			call hattr.addIntWhite(whichUnit,bean.intWhite,during)
		elseif(bean.intWhite<0)then
			call hattr.subIntWhite(whichUnit,bean.intWhite,during)
		endif
		if(bean.lifeBack>0)then
			call hattr.addLifeBack(whichUnit,bean.lifeBack,during)
		elseif(bean.lifeBack<0)then
			call hattr.subLifeBack(whichUnit,bean.lifeBack,during)
		endif
		if(bean.lifeSource>0)then
			call hattr.addLifeSource(whichUnit,bean.lifeSource,during)
		elseif(bean.lifeSource<0)then
			call hattr.subLifeSource(whichUnit,bean.lifeSource,during)
		endif
		if(bean.lifeSourceCurrent>0)then
			call hattr.addLifeSourceCurrent(whichUnit,bean.lifeSourceCurrent,during)
		elseif(bean.lifeSourceCurrent<0)then
			call hattr.subLifeSourceCurrent(whichUnit,bean.lifeSourceCurrent,during)
		endif
		if(bean.manaBack>0)then
			call hattr.addManaBack(whichUnit,bean.manaBack,during)
		elseif(bean.manaBack<0)then
			call hattr.subManaBack(whichUnit,bean.manaBack,during)
		endif
		if(bean.manaSource>0)then
			call hattr.addManaSource(whichUnit,bean.manaSource,during)
		elseif(bean.manaSource<0)then
			call hattr.subManaSource(whichUnit,bean.manaSource,during)
		endif
		if(bean.manaSourceCurrent>0)then
			call hattr.addManaSourceCurrent(whichUnit,bean.manaSourceCurrent,during)
		elseif(bean.manaSourceCurrent<0)then
			call hattr.subManaSourceCurrent(whichUnit,bean.manaSourceCurrent,during)
		endif
		if(bean.resistance>0)then
			call hattr.addResistance(whichUnit,bean.resistance,during)
		elseif(bean.resistance<0)then
			call hattr.subResistance(whichUnit,bean.resistance,during)
		endif
		if(bean.toughness>0)then
			call hattr.addToughness(whichUnit,bean.toughness,during)
		elseif(bean.toughness<0)then
			call hattr.subToughness(whichUnit,bean.toughness,during)
		endif
		if(bean.avoid>0)then
			call hattr.addAvoid(whichUnit,bean.avoid,during)
		elseif(bean.avoid<0)then
			call hattr.subAvoid(whichUnit,bean.avoid,during)
		endif
		if(bean.aim>0)then
			call hattr.addAim(whichUnit,bean.aim,during)
		elseif(bean.aim<0)then
			call hattr.subAim(whichUnit,bean.aim,during)
		endif
		if(bean.knocking>0)then
			call hattr.addKnocking(whichUnit,bean.knocking,during)
		elseif(bean.knocking<0)then
			call hattr.subKnocking(whichUnit,bean.knocking,during)
		endif
		if(bean.violence>0)then
			call hattr.addViolence(whichUnit,bean.violence,during)
		elseif(bean.violence<0)then
			call hattr.subViolence(whichUnit,bean.violence,during)
		endif
		if(bean.mortalOppose>0)then
			call hattr.addMortalOppose(whichUnit,bean.mortalOppose,during)
		elseif(bean.mortalOppose<0)then
			call hattr.subMortalOppose(whichUnit,bean.mortalOppose,during)
		endif
		if(bean.punish>0)then
			call hattr.addPunish(whichUnit,bean.punish,during)
		elseif(bean.punish<0)then
			call hattr.subPunish(whichUnit,bean.punish,during)
		endif
		if(bean.punishCurrent>0)then
			call hattr.addPunishCurrent(whichUnit,bean.punishCurrent,during)
		elseif(bean.punishCurrent<0)then
			call hattr.subPunishCurrent(whichUnit,bean.punishCurrent,during)
		endif
		if(bean.punishOppose>0)then
			call hattr.addPunishOppose(whichUnit,bean.punishOppose,during)
		elseif(bean.punishOppose<0)then
			call hattr.subPunishOppose(whichUnit,bean.punishOppose,during)
		endif
		if(bean.meditative>0)then
			call hattr.addMeditative(whichUnit,bean.meditative,during)
		elseif(bean.meditative<0)then
			call hattr.subMeditative(whichUnit,bean.meditative,during)
		endif
		if(bean.help>0)then
			call hattr.addHelp(whichUnit,bean.help,during)
		elseif(bean.help<0)then
			call hattr.subHelp(whichUnit,bean.help,during)
		endif
		if(bean.hemophagia>0)then
			call hattr.addHemophagia(whichUnit,bean.hemophagia,during)
		elseif(bean.hemophagia<0)then
			call hattr.subHemophagia(whichUnit,bean.hemophagia,during)
		endif
		if(bean.hemophagiaSkill>0)then
			call hattr.addHemophagiaSkill(whichUnit,bean.hemophagiaSkill,during)
		elseif(bean.hemophagiaSkill<0)then
			call hattr.subHemophagiaSkill(whichUnit,bean.hemophagiaSkill,during)
		endif
		if(bean.split>0)then
			call hattr.addSplit(whichUnit,bean.split,during)
		elseif(bean.split<0)then
			call hattr.subSplit(whichUnit,bean.split,during)
		endif
		if(bean.splitRange>0)then
			call hattr.addSplitRange(whichUnit,bean.splitRange,during)
		elseif(bean.splitRange<0)then
			call hattr.subSplitRange(whichUnit,bean.splitRange,during)
		endif
		if(bean.goldRatio>0)then
			call hattr.addGoldRatio(whichUnit,bean.goldRatio,during)
		elseif(bean.goldRatio<0)then
			call hattr.subGoldRatio(whichUnit,bean.goldRatio,during)
		endif
		if(bean.lumberRatio>0)then
			call hattr.addLumberRatio(whichUnit,bean.lumberRatio,during)
		elseif(bean.lumberRatio<0)then
			call hattr.subLumberRatio(whichUnit,bean.lumberRatio,during)
		endif
		if(bean.expRatio>0)then
			call hattr.addExpRatio(whichUnit,bean.expRatio,during)
		elseif(bean.expRatio<0)then
			call hattr.subExpRatio(whichUnit,bean.expRatio,during)
		endif
		if(bean.swimOppose>0)then
			call hattr.addSwimOppose(whichUnit,bean.swimOppose,during)
		elseif(bean.swimOppose<0)then
			call hattr.subSwimOppose(whichUnit,bean.swimOppose,during)
		endif
		if(bean.luck>0)then
			call hattr.addLuck(whichUnit,bean.luck,during)
		elseif(bean.luck<0)then
			call hattr.subLuck(whichUnit,bean.luck,during)
		endif
		if(bean.invincible>0)then
			call hattr.addInvincible(whichUnit,bean.invincible,during)
		elseif(bean.invincible<0)then
			call hattr.subInvincible(whichUnit,bean.invincible,during)
		endif
		if(bean.weight>0)then
			call hattr.addWeight(whichUnit,bean.weight,during)
		elseif(bean.weight<0)then
			call hattr.subWeight(whichUnit,bean.weight,during)
		endif
		if(bean.weightCurrent>0)then
			call hattr.addWeightCurrent(whichUnit,bean.weightCurrent,during)
		elseif(bean.weightCurrent<0)then
			call hattr.subWeightCurrent(whichUnit,bean.weightCurrent,during)
		endif
		if(bean.huntAmplitude>0)then
			call hattr.addHuntAmplitude(whichUnit,bean.huntAmplitude,during)
		elseif(bean.huntAmplitude<0)then
			call hattr.subHuntAmplitude(whichUnit,bean.huntAmplitude,during)
		endif
		if(bean.huntRebound>0)then
			call hattr.addHuntRebound(whichUnit,bean.huntRebound,during)
		elseif(bean.huntRebound<0)then
			call hattr.subHuntRebound(whichUnit,bean.huntRebound,during)
		endif
		if(bean.cure>0)then
			call hattr.addCure(whichUnit,bean.cure,during)
		elseif(bean.cure<0)then
			call hattr.subCure(whichUnit,bean.cure,during)
		endif
		if(bean.fire>0)then
			call hattrNatural.addFire(whichUnit,bean.fire,during)
		elseif(bean.fire<0)then
			call hattrNatural.subFire(whichUnit,bean.fire,during)
		endif
		if(bean.soil>0)then
			call hattrNatural.addSoil(whichUnit,bean.soil,during)
		elseif(bean.soil<0)then
			call hattrNatural.subSoil(whichUnit,bean.soil,during)
		endif
		if(bean.water>0)then
			call hattrNatural.addWater(whichUnit,bean.water,during)
		elseif(bean.water<0)then
			call hattrNatural.subWater(whichUnit,bean.water,during)
		endif
		if(bean.ice>0)then
			call hattrNatural.addIce(whichUnit,bean.ice,during)
		elseif(bean.ice<0)then
			call hattrNatural.subIce(whichUnit,bean.ice,during)
		endif
		if(bean.wind>0)then
			call hattrNatural.addWind(whichUnit,bean.wind,during)
		elseif(bean.wind<0)then
			call hattrNatural.subWind(whichUnit,bean.wind,during)
		endif
		if(bean.light>0)then
			call hattrNatural.addLight(whichUnit,bean.light,during)
		elseif(bean.light<0)then
			call hattrNatural.subLight(whichUnit,bean.light,during)
		endif
		if(bean.dark>0)then
			call hattrNatural.addDark(whichUnit,bean.dark,during)
		elseif(bean.dark<0)then
			call hattrNatural.subDark(whichUnit,bean.dark,during)
		endif
		if(bean.wood>0)then
			call hattrNatural.addWood(whichUnit,bean.wood,during)
		elseif(bean.wood<0)then
			call hattrNatural.subWood(whichUnit,bean.wood,during)
		endif
		if(bean.thunder>0)then
			call hattrNatural.addThunder(whichUnit,bean.thunder,during)
		elseif(bean.thunder<0)then
			call hattrNatural.subThunder(whichUnit,bean.thunder,during)
		endif
		if(bean.poison>0)then
			call hattrNatural.addPoison(whichUnit,bean.poison,during)
		elseif(bean.poison<0)then
			call hattrNatural.subPoison(whichUnit,bean.poison,during)
		endif
		if(bean.fireOppose>0)then
			call hattrNatural.addFireOppose(whichUnit,bean.fireOppose,during)
		elseif(bean.fireOppose<0)then
			call hattrNatural.subFireOppose(whichUnit,bean.fireOppose,during)
		endif
		if(bean.soilOppose>0)then
			call hattrNatural.addSoilOppose(whichUnit,bean.soilOppose,during)
		elseif(bean.soilOppose<0)then
			call hattrNatural.subSoilOppose(whichUnit,bean.soilOppose,during)
		endif
		if(bean.waterOppose>0)then
			call hattrNatural.addWaterOppose(whichUnit,bean.waterOppose,during)
		elseif(bean.waterOppose<0)then
			call hattrNatural.subWaterOppose(whichUnit,bean.waterOppose,during)
		endif
		if(bean.iceOppose>0)then
			call hattrNatural.addIceOppose(whichUnit,bean.iceOppose,during)
		elseif(bean.iceOppose<0)then
			call hattrNatural.subIceOppose(whichUnit,bean.iceOppose,during)
		endif
		if(bean.windOppose>0)then
			call hattrNatural.addWindOppose(whichUnit,bean.windOppose,during)
		elseif(bean.windOppose<0)then
			call hattrNatural.subWindOppose(whichUnit,bean.windOppose,during)
		endif
		if(bean.lightOppose>0)then
			call hattrNatural.addLightOppose(whichUnit,bean.lightOppose,during)
		elseif(bean.lightOppose<0)then
			call hattrNatural.subLightOppose(whichUnit,bean.lightOppose,during)
		endif
		if(bean.darkOppose>0)then
			call hattrNatural.addDarkOppose(whichUnit,bean.darkOppose,during)
		elseif(bean.darkOppose<0)then
			call hattrNatural.subDarkOppose(whichUnit,bean.darkOppose,during)
		endif
		if(bean.woodOppose>0)then
			call hattrNatural.addWoodOppose(whichUnit,bean.woodOppose,during)
		elseif(bean.woodOppose<0)then
			call hattrNatural.subWoodOppose(whichUnit,bean.woodOppose,during)
		endif
		if(bean.thunderOppose>0)then
			call hattrNatural.addThunderOppose(whichUnit,bean.thunderOppose,during)
		elseif(bean.thunderOppose<0)then
			call hattrNatural.subThunderOppose(whichUnit,bean.thunderOppose,during)
		endif
		if(bean.poisonOppose>0)then
			call hattrNatural.addPoisonOppose(whichUnit,bean.poisonOppose,during)
		elseif(bean.poisonOppose<0)then
			call hattrNatural.subPoisonOppose(whichUnit,bean.poisonOppose,during)
		endif
	endmethod



	//设定硬直条是否显示
	public static method punishTtgIsOpen takes boolean isOpen returns nothing
		set PUNISH_SWITCH = isOpen
	endmethod

	//设定硬直条是否只有英雄显示
	public static method punishTtgIsOnlyHero takes boolean isOnlyhero returns nothing
		set PUNISH_SWITCH_ONLYHERO = isOnlyhero
	endmethod

	//设定硬直条高度
	public static method punishTtgHeight takes real high returns nothing
		if(hcamera.model=="zoomin")then
			set PUNISH_TEXTTAG_HEIGHT = high*0.5
		else
			set PUNISH_TEXTTAG_HEIGHT = high
		endif
	endmethod

	//把单位赶出属性组
	private static method groupOut takes unit whichUnit returns nothing
		if( IsUnitInGroup( whichUnit , ATTR_GROUP ) == true ) then
			call GroupRemoveUnit( ATTR_GROUP , whichUnit )
		endif
	endmethod

	//活力/魔法恢复
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
		                call SetUnitLifeBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_LIFE, tempUnit) + ( hattr.getLifeBack(tempUnit) * period ) ) )
	            		call SetUnitManaBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_MANA, tempUnit) + ( hattr.getManaBack(tempUnit) * period ) ) )
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
		local real punishNow = hattr.getPunishCurrent(whichUnit)
		local real punishAll = hattr.getPunish(whichUnit)
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

	//硬直恢复器(+100/5s)
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
	                call hattr.addPunishCurrent( tempUnit , 100 , 0 )
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
	endmethod

	//单位收到伤害(因为所有的伤害有hunt方法接管，所以这里的伤害全部是攻击伤害)
	private static method triggerUnitbeHuntCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit fromUnit =  htime.getUnit(t,801)
		local unit toUnit =  htime.getUnit(t,802)
		local real damage =  htime.getReal(t,803)
		local real oldLife =  htime.getReal(t,804)
		local hAttrHuntBean bean

		call htime.delTimer(t)
		call hattr.subLife(toUnit,damage,0)
		call hunit.setLife(toUnit,oldLife)

		set bean = hAttrHuntBean.create()
		set bean.fromUnit = fromUnit
		set bean.toUnit = toUnit
		set bean.damage = damage
		set bean.huntKind = "attack"
		set bean.huntType = hattr.getAttackHuntType(fromUnit)
		call hattrHunt.huntUnit( bean )
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

	//英雄升级 - 计算白字
	private static method triggerUnitHeroLevelAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		call hattr.setStrWhite( u , GetHeroStr(u,false) , 0 )
		call hattr.setAgiWhite( u , GetHeroAgi(u,false) , 0 )
		call hattr.setIntWhite( u , GetHeroInt(u,false) , 0 )
		call hattr.addHelp( u , 2 , 0 )
		call hattr.addWeight( u , 0.25 , 0 )
		call hattr.addLifeSource( u , 10 , 0 )
		call hattr.addManaSource( u , 10 , 0 )

		//@触发升级事件
		set hevtBean = hEvtBean.create()
        set hevtBean.triggerKey = "levelUp"
        set hevtBean.triggerUnit = u
        call hevt.triggerEvent(hevtBean)
        call hevtBean.destroy()

		set u = null
	endmethod

	//单位死亡（一般排除玩家的英雄）
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

	//注册单位
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
			call hconsole.log(GetUnitName(u)+"进入了地图")
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

	//初始化
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
