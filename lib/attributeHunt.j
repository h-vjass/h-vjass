/* 属性 - 伤害 */
struct hAttrHuntBean

    public static unit fromUnit = null
    public static unit toUnit = null
    public static string huntEff = null
    public static real damage = 0
    public static string huntKind = null
    public static string huntType = null
    public static boolean isBreak = false
    public static boolean isNoAvoid = false
    public static string special = null
    public static real specialVal = 0
    public static real specialDuring = 0

    public static group whichGroup = null
    public static group whichGroupRepeat = null
    public static string whichGroupHuntEff = null
    public static location whichGroupHuntEffLoc = null

    static method create takes nothing returns hAttrHuntBean
        local hAttrHuntBean x = 0
        set x = hAttrHuntBean.allocate()
        return x
    endmethod
    method destroy takes nothing returns nothing
        set fromUnit = null
        set toUnit = null
        set huntEff = null
        set damage = 0
        set huntKind = null
        set huntType = null
        set isBreak = false
        set isNoAvoid = false
        set special = null
        set specialVal = 0
        set specialDuring = 0
        set whichGroupHuntEff = null
        if(whichGroup!=null)then
            call GroupClear(whichGroup)
            call DestroyGroup(whichGroup)
            set whichGroup = null
        endif
        if(whichGroupRepeat!=null)then
            call GroupClear(whichGroupRepeat)
            call DestroyGroup(whichGroupRepeat)
            set whichGroupRepeat = null
        endif
        if(whichGroupHuntEffLoc!=null)then
            call RemoveLocation(whichGroupHuntEffLoc)
            set whichGroupHuntEffLoc = null
        endif
    endmethod
endstruct

library hAttrHunt initializer init needs hAttrNatural

	/**
     * 伤害单位
     * heffect 特效
     * bean.huntKind伤害类型: 
     		attack 攻击
     		skill 技能
     		item 物品
     * bean.huntType伤害类型: 
     		physical 物理
     		magic 魔法<魔法涵盖了自然属性，享受魔法加成，受魔抗影响>
                magic_fire    火
                magic_soil    土
                magic_water   水 
                magic_wind    风
                magic_light   光 
                magic_dark    暗
                magic_wood    木
                magic_thunder 雷
     		real 真实
     		absolute 绝对
     * isBreak是否无视：true | false 物理伤害则无视护甲 | 魔法伤害则无视魔抗
     * isNoAvoid是否无法回避：true | false
     * special特殊：
     		null 无
            //buff
            effect_life_back
            effect_mana_back
            effect_attack_speed
            effect_attack_physical
            effect_attack_magic
            effect_move
            effect_aim
            effect_str
            effect_agi
            effect_int
            effect_knocking
            effect_violence
            effect_hemophagia
            effect_hemophagia_skill
            effect_split
            effect_luck
            effect_hunt_amplitude
            //de
     		effect_poison 		中毒[减少生命恢复]
            effect_dry          枯竭[减少魔法恢复]
     		effect_freeze 		冻结[减少攻击速度]
     		effect_cold 		寒冷[减少移动力]
     		effect_blunt		迟钝[减少物理和魔法攻击力]
     		effect_corrosion	腐蚀[减少护甲]
     		effect_chaos		混乱[减少魔抗]
     		effect_twine		缠绕[减少回避]
            effect_blind        致盲[减少命中]
     		effect_tortua		剧痛[减少韧性]
            effect_weak         乏力[减少力量(绿字)]
            effect_bound        束缚[减少敏捷(绿字)]
            effect_foolish      愚蠢[减少智力(绿字)]
     		effect_lazy		    懒惰[减少物理暴击和魔法暴击]
     		effect_swim 		眩晕[特定眩晕，直接眩晕，不受抵抗]
     		effect_heavy 		沉重[加重硬直减少量]
            effect_break        打断[直接僵直]
     		effect_unluck 		倒霉[减少运气]
     * specialVal特殊数值：作用于特殊效果的数值
     * specialDuring特殊持续时间
     */
    public function huntUnit takes hAttrHuntBean bean returns nothing
    	
    	local real realDamage = 0

        local real fromUnitPunishHeavy = 1

    	local real fromUnitAttackPhysical = hAttr_getAttackPhysical(bean.fromUnit)
        local real fromUnitAttackMagic = hAttr_getAttackMagic(bean.fromUnit)
    	local real fromUnitAim = hAttrExt_getAim(bean.fromUnit)
    	local real fromUnitKnocking = hAttrExt_getKnocking(bean.fromUnit)
    	local real fromUnitViolence = hAttrExt_getViolence(bean.fromUnit)
    	local real fromUnitHemophagia = hAttrExt_getHemophagia(bean.fromUnit)
    	local real fromUnitHemophagiaSkill = hAttrExt_getHemophagiaSkill(bean.fromUnit)
    	local real fromUnitSplit = hAttrExt_getSplit(bean.fromUnit)
    	local real fromUnitLuck = hAttrExt_getLuck(bean.fromUnit)
        local real fromUnitHuntAmplitude = hAttrExt_getHuntAmplitude(bean.fromUnit)
        local real fromUnitNaturalFire = hAttrNatural_getFire(bean.fromUnit)
        local real fromUnitNaturalSoil = hAttrNatural_getSoil(bean.fromUnit)
        local real fromUnitNaturalWater = hAttrNatural_getWater(bean.fromUnit)
        local real fromUnitNaturalWind = hAttrNatural_getWind(bean.fromUnit)
        local real fromUnitNaturalLight = hAttrNatural_getLight(bean.fromUnit)
        local real fromUnitNaturalDark = hAttrNatural_getDark(bean.fromUnit)
        local real fromUnitNaturalWood = hAttrNatural_getWood(bean.fromUnit)
    	local real fromUnitNaturalThunder = hAttrNatural_getThunder(bean.fromUnit)

    	local real toUnitDefend = hAttr_getDefend(bean.toUnit)
    	local real toUnitResistance = hAttrExt_getResistance(bean.toUnit)
    	local real toUnitToughness = hAttrExt_getToughness(bean.toUnit)
    	local real toUnitAvoid = hAttrExt_getAvoid(bean.toUnit)
    	local real toUnitMortalOppose = hAttrExt_getMortalOppose(bean.toUnit)
    	local real toUnitSwimOppose = hAttrExt_getSwimOppose(bean.toUnit)
    	local real toUnitLuck = hAttrExt_getLuck(bean.toUnit)
    	local real toUnitInvincible = hAttrExt_getInvincible(bean.toUnit)
    	local real toUnitHuntRebound = hAttrExt_getHuntRebound(bean.toUnit)
    	local real toUnitCure = hAttrExt_getCure(bean.toUnit)
        local real toUnitNaturalFireOppose = hAttrNatural_getFireOppose(bean.toUnit)
        local real toUnitNaturalSoilOppose = hAttrNatural_getSoilOppose(bean.toUnit)
        local real toUnitNaturalWaterOppose = hAttrNatural_getWaterOppose(bean.toUnit)
        local real toUnitNaturalWindOppose = hAttrNatural_getWindOppose(bean.toUnit)
        local real toUnitNaturalLightOppose = hAttrNatural_getLightOppose(bean.toUnit)
        local real toUnitNaturalDarkOppose = hAttrNatural_getDarkOppose(bean.toUnit)
        local real toUnitNaturalWoodOppose = hAttrNatural_getWoodOppose(bean.toUnit)
        local real toUnitNaturalThunderOppose = hAttrNatural_getThunderOppose(bean.toUnit)

        local boolean isInvincible = false

    	local location loc = null
    	local group g = null
    	local unit u = null
        local hFilter filter = 0

    	if( bean.huntEff != null and bean.huntEff != "" ) then
    		set loc = GetUnitLoc( bean.toUnit )
			call heffect.toLoc(bean.huntEff,loc,0)
            call RemoveLocation( loc )
    	endif

    	if(is.alive(bean.toUnit)==true and bean.damage>0.5)then

            //赋值伤害
            set realDamage = bean.damage

    		//判断伤害方式
    		if( bean.huntKind=="attack" )then
    			set realDamage = realDamage - fromUnitAttackMagic //减去绿字
	        elseif( bean.huntKind=="skill" )then
	    	elseif( bean.huntKind=="item" )then
	    	else
	    		call console.error("伤害单位错误：bean.huntKind")
	    		return
	        endif
            call console.error("realDamage1="+R2S(realDamage))
    		//判断伤害类型
    		if( bean.huntType=="physical" )then
				set fromUnitViolence = 0
	        elseif( bean.huntType=="magic" )then
	        	set fromUnitKnocking = 0
            elseif( bean.huntType=="magic_fire" or bean.huntType=="magic_soil" or bean.huntType=="magic_water" or bean.huntType=="magic_wind" or bean.huntType=="magic_light" or bean.huntType=="magic_dark" or bean.huntType=="magic_wood" or bean.huntType=="magic_thunder" )then
                set fromUnitKnocking = 0
	    	elseif( bean.huntType=="real" )then
	    		set fromUnitViolence = 0
	    		set fromUnitKnocking = 0
	    	elseif( bean.huntType=="absolute" )then
	    		set fromUnitViolence = 0
	    		set fromUnitKnocking = 0
	    	else
	    		call console.error("伤害单位错误：bean.huntType")
	    		return
	        endif

            call console.log("bean.huntType:"+bean.huntType)

	        //判断无视Break
	        if( bean.isBreak == true ) then
	        	if(toUnitDefend>0) then
	        		set toUnitDefend = 0
	        	endif
	        	if(toUnitResistance>0) then
	        		set toUnitResistance = 0
	        	endif
	        endif
	        //判断无视回避
	        if( bean.isNoAvoid == true ) then
	        	set toUnitAvoid = 0
	        endif
	        //计算伤害增幅
	        if( fromUnitHuntAmplitude != 0 ) then
	        	set realDamage = realDamage * (1+fromUnitHuntAmplitude*0.01)
	        endif
	        //计算物理暴击,满30000
	        if( bean.huntType == "physical" and (fromUnitKnocking-toUnitMortalOppose)>0 and GetRandomInt(1, 1000)<=R2I((fromUnitKnocking-toUnitMortalOppose)/30) ) then
	       		set realDamage = realDamage * (1+(fromUnitKnocking-toUnitMortalOppose)*0.0004)
	       		set toUnitAvoid = toUnitAvoid * 0.5
                call hmsg.style(  hmsg.ttg2Unit(bean.toUnit,"暴击"+I2S(R2I(realDamage)),6.00,"ef3215",10,1.00,10.00)  ,"toggle",0,0.2)
	        endif

            //计算自然属性
            if( bean.huntType == "magic_fire" and fromUnitNaturalFire>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalFire-toUnitNaturalFireOppose)*0.01)
            endif
            if( bean.huntType == "magic_soil" and fromUnitNaturalSoil>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalSoil-toUnitNaturalSoilOppose)*0.01)
            endif
            if( bean.huntType == "magic_water" and fromUnitNaturalWater>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalWater-toUnitNaturalWaterOppose)*0.01)
            endif
            if( bean.huntType == "magic_wind" and fromUnitNaturalWind>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalWind-toUnitNaturalWindOppose)*0.01)
            endif
            if( bean.huntType == "magic_light" and fromUnitNaturalLight>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalLight-toUnitNaturalLightOppose)*0.01)
            endif
            if( bean.huntType == "magic_dark" and fromUnitNaturalDark>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalDark-toUnitNaturalDarkOppose)*0.01)
            endif
            if( bean.huntType == "magic_wood" and fromUnitNaturalWood>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalWood-toUnitNaturalWoodOppose)*0.01)
            endif
            if( bean.huntType == "magic_thunder" and fromUnitNaturalThunder>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalThunder-toUnitNaturalThunderOppose)*0.01)
            endif
	        //计算魔法暴击,满20000
	        if( bean.huntType == "magic" or bean.huntType=="magic_fire" or bean.huntType=="magic_soil" or bean.huntType=="magic_water" or bean.huntType=="magic_wind" or bean.huntType=="magic_light" or bean.huntType=="magic_dark" or bean.huntType=="magic_wood" or bean.huntType=="magic_thunder" ) then
                if((fromUnitViolence-toUnitMortalOppose)>0 and GetRandomInt(1, 1000)<=R2I((fromUnitViolence-toUnitMortalOppose)/20))then
                    set realDamage = realDamage * (1+(fromUnitViolence-toUnitMortalOppose)*0.0002)
                    set toUnitAvoid = toUnitAvoid * 0.5
                    call hmsg.style(  hmsg.ttg2Unit(bean.toUnit,"暴击"+I2S(R2I(realDamage)),6.00,"15bcef",10,1.00,10.00)  ,"toggle",0,0.2)
                endif
	        endif
	        //计算回避 X 命中
    		if( bean.huntType == "physical" and realDamage<(hunit.getMaxLife(bean.toUnit)*0.25) and R2I(toUnitAvoid-fromUnitAim)>0 and GetRandomInt(1, 100)<=R2I(toUnitAvoid-fromUnitAim))then
                set realDamage = 0
                call hmsg.style(  hmsg.ttg2Unit(bean.toUnit,"回避",6.00,"5ef78e",10,1.00,10.00)  ,"scale",0,0.2)
    		endif
    		//计算护甲
    		if( bean.huntType == "physical" and toUnitDefend!=0 )then
				if(toUnitDefend>0)then
					set realDamage = realDamage * (1-toUnitDefend/(toUnitDefend+200))
				else
					set realDamage = realDamage * (2-Pow(0.99, toUnitDefend))
				endif
    		endif
    		//计算魔抗
    		if( bean.huntType == "magic" or bean.huntType=="magic_fire" or bean.huntType=="magic_soil" or bean.huntType=="magic_water" or bean.huntType=="magic_wind" or bean.huntType=="magic_light" or bean.huntType=="magic_dark" or bean.huntType=="magic_wood" or bean.huntType=="magic_thunder")then
                if( toUnitResistance!=0 )then
    				if(toUnitResistance>=100)then
    					set realDamage = 0
                        call hunit.subLife(bean.fromUnit,realDamage*(toUnitResistance-100)*0.01)
    				else
    					set realDamage = realDamage * (1-toUnitResistance*0.01)
                    endif
    			endif
    		endif
    		//计算韧性
    		if( toUnitToughness>0 )then
    			if( (realDamage-toUnitToughness) < realDamage*0.1 )then
    				set realDamage = realDamage * 0.1
    			else
					set realDamage = realDamage - toUnitToughness
    			endif
    		endif
	        //计算单位是否无敌且不是绝对伤害,无敌属性为百分比计算，被动触发抵挡一次
    		if( bean.huntType == "absolute" and (is.invincible(bean.toUnit)==true or GetRandomInt(1,100)<R2I(toUnitInvincible)  ))then
    			set realDamage = 0
                set isInvincible = true
    		endif

            call console.log("realDamage:"+R2S(realDamage))

    		//造成伤害
    		if( realDamage > 0 ) then
				call hunit.subLife(bean.toUnit,realDamage) //#
                call hEvent_setKiller(bean.toUnit,bean.fromUnit)
                call hplayer.addDamage(GetOwningPlayer(bean.fromUnit),realDamage)
                call hplayer.addBeDamage(GetOwningPlayer(bean.toUnit),realDamage)
				//分裂
				if( bean.huntType == "physical" and fromUnitSplit >0 )then
	                set loc = GetUnitLoc( bean.toUnit )
                    set filter = hFilter.create()
                    call filter.setUnit(bean.fromUnit)
                    call filter.isAlive(true)
                    call filter.isEnemy(true)
                    call filter.isBuilding(false)
	                set g = hgroup.createByLoc(loc,200.00,function hFilter.get )
                    call filter.destroy()
	                loop
			            exitwhen(IsUnitGroupEmptyBJ(g) == true)
			                set u = FirstOfGroup(g)
			                call GroupRemoveUnit( g , u )
		                    if(u!=bean.toUnit and IsUnitEnemy(u,GetOwningPlayer(bean.fromUnit)) == true) then
                                call hunit.subLife(u,realDamage * fromUnitSplit * 0.01)
		                    endif
        			endloop
	                call GroupClear(g)
	                call DestroyGroup(g)
	                set g = null
	                call heffect.toLoc("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl",loc,0)
	                call RemoveLocation( loc )
	            endif
	            //吸血
				if( bean.huntType == "physical" and fromUnitHemophagia >0 )then
                    call hunit.addLife(bean.fromUnit,realDamage * fromUnitHemophagia * 0.01)
					call heffect.toUnit("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",bean.fromUnit,"origin",1.00)
				endif
				//技能吸血
				if( bean.huntType == "magic" and bean.huntKind == "skill" and fromUnitHemophagiaSkill >0 )then
                    call hunit.addLife(bean.fromUnit,realDamage * fromUnitHemophagiaSkill * 0.01)
                    call heffect.toUnit("Abilities\\Spells\\Items\\HealingSalve\\HealingSalveTarget.mdl",bean.fromUnit,"weapon",1.8)
				endif
				//硬直
                if( is.alive(bean.toUnit) )then
                    if( IsUnitPaused(bean.toUnit) == false ) then
                        if( bean.special == "effect_heavy" and bean.specialVal>1 ) then
                            set fromUnitPunishHeavy = fromUnitPunishHeavy * bean.specialVal
                        endif
                        call hAttrExt_subPunishCurrent(bean.toUnit,realDamage*fromUnitPunishHeavy,0)
                    endif
                    if(hAttrExt_getPunishCurrent(bean.toUnit) <= 0 ) then
                        call hAttrExt_setPunishCurrent(bean.toUnit,hAttrExt_getPunish(bean.toUnit),0)
                        call hAbility_punish( bean.toUnit , 3.00 , 0 )
                        call hmsg.ttg2Unit(bean.toUnit,"僵硬",10.00,"c0c0c0",0,3.00,50.00)
                    endif
                endif
                //反射
                if( toUnitHuntRebound >0 )then
					call hunit.subLife(bean.fromUnit,realDamage * toUnitHuntRebound * 0.01)
                    call hmsg.style(hmsg.ttg2Unit(bean.fromUnit,"反射"+I2S(R2I(realDamage*toUnitHuntRebound*0.01)),10.00,"f8aaeb",10,1.00,10.00)  ,"shrink",0,0.2)
				endif
                //治疗
                if( toUnitCure >0 )then
                    call hunit.addLife(bean.toUnit,realDamage * toUnitCure * 0.01)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",bean.toUnit,"origin",1.00)
                    set loc = GetUnitLoc( bean.toUnit )
                    call hmsg.style(hmsg.ttg2Loc(loc,"治疗"+I2S(R2I(realDamage*toUnitCure*0.01)),10.00,"f5f89b",10,1.00,10.00)  ,"shrink",0,0.2)
                    call RemoveLocation( loc )
				endif
    		endif
    	endif

        //特殊效果,不需要伤害，一定会触发
        if( bean.specialVal != 0 and bean.specialDuring > 0 )then
            if(bean.huntKind=="attack")then
                if( bean.special == "null" ) then
                elseif( bean.special == "effect_life_back" ) then
                    call hAttrExt_addLifeBack(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_mana_back" ) then
                    call hAttrExt_addManaBack(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_attack_speed" ) then
                    call hAttr_addAttackSpeed(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_attack_physical" ) then
                    call hAttr_addAttackPhysical(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_attack_magic" ) then
                    call hAttr_addAttackMagic(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_move" ) then
                    call hAttr_addMove(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_aim" ) then
                    call hAttrExt_addAim(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_str" ) then
                    call hAttr_addStr(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_agi" ) then
                    call hAttr_addAgi(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_int" ) then
                    call hAttr_addInt(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_knocking" ) then
                    call hAttrExt_addKnocking(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_violence" ) then
                    call hAttrExt_addViolence(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_hemophagia" ) then
                    call hAttrExt_addHemophagia(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_hemophagia_skill" ) then
                    call hAttrExt_addHemophagiaSkill(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_split" ) then
                    call hAttrExt_addSplit(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_luck" ) then
                    call hAttrExt_addLuck(bean.fromUnit,bean.specialVal,bean.specialDuring)
                elseif( bean.special == "effect_hunt_amplitude" ) then
                    call hAttrExt_addHuntAmplitude(bean.fromUnit,bean.specialVal,bean.specialDuring)
                endif
            endif
            if( bean.special == "null" ) then
            elseif( bean.special == "effect_poison" ) then
                call hAttrExt_subLifeBack(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_dry" ) then
                call hAttrExt_subManaBack(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_freeze" ) then
                call hAttr_subAttackSpeed(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_cold" ) then
                call hAttr_subMove(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_blunt" ) then
                call hAttr_subAttackPhysical(bean.toUnit,bean.specialVal,bean.specialDuring)
                call hAttr_subAttackMagic(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_corrosion" ) then
                call hAttr_subDefend(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_chaos" ) then
                call hAttrExt_subResistance(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_twine" ) then
                call hAttrExt_subAvoid(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_blind" ) then
                call hAttrExt_subAim(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_tortua" ) then
                call hAttrExt_subToughness(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_weak" ) then
                call hAttr_subStr(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_bound" ) then
                call hAttr_subAgi(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_foolish" ) then
                call hAttr_subInt(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_lazy" ) then
                call hAttrExt_subKnocking(bean.toUnit,bean.specialVal,bean.specialDuring)
                call hAttrExt_subViolence(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_swim") then
                if(toUnitSwimOppose!=0)then
                    set bean.specialVal = bean.specialVal - toUnitSwimOppose
                    set bean.specialDuring = bean.specialDuring * (1-toUnitSwimOppose*0.01)
                endif
                call console.error("b="+R2S(bean.specialVal))
                call console.error("b="+R2S(bean.specialDuring))
                if(GetRandomReal(1,100)<bean.specialVal and bean.specialDuring>0)then
                    call hAbility_swim( bean.toUnit , bean.specialDuring )
                endif
            elseif( bean.special == "effect_break" and GetRandomReal(1,100)<bean.specialVal ) then
                call hAbility_punish( bean.toUnit , bean.specialDuring , 0 )
            elseif( bean.special == "effect_unluck" ) then
                call hAttrExt_subLuck(bean.toUnit,bean.specialVal,bean.specialDuring)
            endif
        endif

    endfunction

    /**
     * 伤害群
     */
    public function huntGroup takes hAttrHuntBean bean returns nothing
    	local unit u = null
        local group g = null
    	if( bean.whichGroupHuntEff != null and bean.whichGroupHuntEff != "" and bean.whichGroupHuntEffLoc != null) then
			call heffect.toLoc(bean.whichGroupHuntEff,bean.whichGroupHuntEffLoc,0)
    	endif
        call GroupAddGroup(g, bean.whichGroup)
    	loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                if(IsUnitEnemy(u,GetOwningPlayer(bean.fromUnit))==true and (bean.whichGroupRepeat==null or IsUnitInGroup(u,bean.whichGroupRepeat)==false)) then
                    call huntUnit(bean)
                endif
                if( bean.whichGroupRepeat != null) then
                	call GroupAddUnit( bean.whichGroupRepeat,u )
                endif
        endloop
        set u = null
    endfunction


	private function init takes nothing returns nothing

	endfunction

endlibrary
