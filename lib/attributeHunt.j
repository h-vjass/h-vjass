/* 属性 - 伤害 */
library hAttrHunt initializer init needs hAttrNatural

	/**
     * 伤害单位
     * heffect 特效
     * hkind伤害类型: 
     		attack 攻击
     		skill 技能
     		item 物品
     * htype伤害类型: 
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
    public function huntUnit takes unit fromUnit,unit toUnit,string heff,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
    	
    	local real realDamage = 0

        local real fromUnitPunishHeavy = 1

    	local real fromUnitAttackPhysical = hAttr_getAttackPhysical(fromUnit)
        local real fromUnitAttackMagic = hAttr_getAttackMagic(fromUnit)
    	local real fromUnitAim = hAttrExt_getAim(fromUnit)
    	local real fromUnitKnocking = hAttrExt_getKnocking(fromUnit)
    	local real fromUnitViolence = hAttrExt_getViolence(fromUnit)
    	local real fromUnitHemophagia = hAttrExt_getHemophagia(fromUnit)
    	local real fromUnitHemophagiaSkill = hAttrExt_getHemophagiaSkill(fromUnit)
    	local real fromUnitSplit = hAttrExt_getSplit(fromUnit)
    	local real fromUnitLuck = hAttrExt_getLuck(fromUnit)
        local real fromUnitHuntAmplitude = hAttrExt_getHuntAmplitude(fromUnit)
        local real fromUnitNaturalFire = hAttrNatural_getFire(fromUnit)
        local real fromUnitNaturalSoil = hAttrNatural_getSoil(fromUnit)
        local real fromUnitNaturalWater = hAttrNatural_getWater(fromUnit)
        local real fromUnitNaturalWind = hAttrNatural_getWind(fromUnit)
        local real fromUnitNaturalLight = hAttrNatural_getLight(fromUnit)
        local real fromUnitNaturalDark = hAttrNatural_getDark(fromUnit)
        local real fromUnitNaturalWood = hAttrNatural_getWood(fromUnit)
    	local real fromUnitNaturalThunder = hAttrNatural_getThunder(fromUnit)

    	local real toUnitDefend = hAttr_getDefend(toUnit)
    	local real toUnitResistance = hAttrExt_getResistance(toUnit)
    	local real toUnitToughness = hAttrExt_getToughness(toUnit)
    	local real toUnitAvoid = hAttrExt_getAvoid(toUnit)
    	local real toUnitMortalOppose = hAttrExt_getMortalOppose(toUnit)
    	local real toUnitSwimOppose = hAttrExt_getSwimOppose(toUnit)
    	local real toUnitLuck = hAttrExt_getLuck(toUnit)
    	local real toUnitInvincible = hAttrExt_getInvincible(toUnit)
    	local real toUnitHuntRebound = hAttrExt_getHuntRebound(toUnit)
    	local real toUnitCure = hAttrExt_getCure(toUnit)
        local real toUnitNaturalFireOppose = hAttrNatural_getFireOppose(toUnit)
        local real toUnitNaturalSoilOppose = hAttrNatural_getSoilOppose(toUnit)
        local real toUnitNaturalWaterOppose = hAttrNatural_getWaterOppose(toUnit)
        local real toUnitNaturalWindOppose = hAttrNatural_getWindOppose(toUnit)
        local real toUnitNaturalLightOppose = hAttrNatural_getLightOppose(toUnit)
        local real toUnitNaturalDarkOppose = hAttrNatural_getDarkOppose(toUnit)
        local real toUnitNaturalWoodOppose = hAttrNatural_getWoodOppose(toUnit)
        local real toUnitNaturalThunderOppose = hAttrNatural_getThunderOppose(toUnit)

        local boolean isInvincible = false

    	local location loc = null
    	local group g = null
    	local unit u = null
        local hFilter filter = 0

    	if( heff != null and heff != "" ) then
    		set loc = GetUnitLoc( toUnit )
			call heffect.toLoc(heff,loc,0)
            call RemoveLocation( loc )
    	endif

    	if(is.alive(toUnit)==true and damage>0.5)then

            //赋值伤害
            set realDamage = damage

    		//判断伤害方式
    		if( hkind=="attack" )then
    			set realDamage = realDamage - fromUnitAttackMagic //减去绿字
	        elseif( hkind=="skill" )then
	    	elseif( hkind=="item" )then
	    	else
	    		call console.error("伤害单位错误：hkind")
	    		return
	        endif
    		//判断伤害类型
    		if( htype=="physical" )then
				set fromUnitViolence = 0
	        elseif( htype=="magic" )then
	        	set fromUnitKnocking = 0
            elseif( htype=="magic_fire" or htype=="magic_soil" or htype=="magic_water" or htype=="magic_wind" or htype=="magic_light" or htype=="magic_dark" or htype=="magic_wood" or htype=="magic_thunder" )then
                set fromUnitKnocking = 0
	    	elseif( htype=="real" )then
	    		set fromUnitViolence = 0
	    		set fromUnitKnocking = 0
	    	elseif( htype=="absolute" )then
	    		set fromUnitViolence = 0
	    		set fromUnitKnocking = 0
	    	else
	    		call console.error("伤害单位错误：htype")
	    		return
	        endif

            call console.log("htype:"+htype)

	        //判断无视Break
	        if( isBreak == true ) then
	        	if(toUnitDefend>0) then
	        		set toUnitDefend = 0
	        	endif
	        	if(toUnitResistance>0) then
	        		set toUnitResistance = 0
	        	endif
	        endif
	        //判断无视回避
	        if( isNoAvoid == true ) then
	        	set toUnitAvoid = 0
	        endif
	        //计算伤害增幅
	        if( fromUnitHuntAmplitude != 0 ) then
	        	set realDamage = realDamage * (1+fromUnitHuntAmplitude*0.01)
	        endif
	        //计算物理暴击,满30000
	        if( htype == "physical" and (fromUnitKnocking-toUnitMortalOppose)>0 and GetRandomInt(1, 1000)<=R2I((fromUnitKnocking-toUnitMortalOppose)/30) ) then
	       		set realDamage = realDamage * (1+(fromUnitKnocking-toUnitMortalOppose)*0.0004)
	       		set toUnitAvoid = toUnitAvoid * 0.5
                call hMsg_style(  hMsg_ttg2Unit(toUnit,"暴击",6.00,"ef3215",10,1.00,10.00)  ,"toggle",0,0.2)
	        endif
            //计算自然属性
            if( htype == "magic_fire" and fromUnitNaturalFire>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalFire-toUnitNaturalFireOppose)*0.01)
            endif
            if( htype == "magic_soil" and fromUnitNaturalSoil>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalSoil-toUnitNaturalSoilOppose)*0.01)
            endif
            if( htype == "magic_water" and fromUnitNaturalWater>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalWater-toUnitNaturalWaterOppose)*0.01)
            endif
            if( htype == "magic_wind" and fromUnitNaturalWind>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalWind-toUnitNaturalWindOppose)*0.01)
            endif
            if( htype == "magic_light" and fromUnitNaturalLight>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalLight-toUnitNaturalLightOppose)*0.01)
            endif
            if( htype == "magic_dark" and fromUnitNaturalDark>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalDark-toUnitNaturalDarkOppose)*0.01)
            endif
            if( htype == "magic_wood" and fromUnitNaturalWood>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalWood-toUnitNaturalWoodOppose)*0.01)
            endif
            if( htype == "magic_thunder" and fromUnitNaturalThunder>0 )then
                set realDamage = realDamage * (1+(fromUnitNaturalThunder-toUnitNaturalThunderOppose)*0.01)
            endif
	        //计算魔法暴击,满20000
	        if( htype == "magic" or htype=="magic_fire" or htype=="magic_soil" or htype=="magic_water" or htype=="magic_wind" or htype=="magic_light" or htype=="magic_dark" or htype=="magic_wood" or htype=="magic_thunder" ) then
                if((fromUnitViolence-toUnitMortalOppose)>0 and GetRandomInt(1, 1000)<=R2I((fromUnitViolence-toUnitMortalOppose)/20))then
                    set realDamage = realDamage * (1+(fromUnitViolence-toUnitMortalOppose)*0.0002)
                    set toUnitAvoid = toUnitAvoid * 0.5
                    call hMsg_style(  hMsg_ttg2Unit(toUnit,"暴击",6.00,"15bcef",10,1.00,10.00)  ,"toggle",0,0.2)
                endif
	        endif
	        //计算回避 X 命中
    		if( htype == "physical" and realDamage<(hunit.getMaxLife(toUnit)*0.25) and R2I(toUnitAvoid-fromUnitAim)>0 and GetRandomInt(1, 100)<=R2I(toUnitAvoid-fromUnitAim))then
                set realDamage = 0
                call hMsg_style(  hMsg_ttg2Unit(toUnit,"回避",6.00,"5ef78e",10,1.00,10.00)  ,"scale",0,0.2)
    		endif
    		//计算护甲
    		if( htype == "physical" and toUnitDefend!=0 )then
				if(toUnitDefend>0)then
					set realDamage = realDamage * (1-toUnitDefend/(toUnitDefend+200))
				else
					set realDamage = realDamage * (2-Pow(0.99, toUnitDefend))
				endif
    		endif
    		//计算魔抗
    		if( htype == "magic" or htype=="magic_fire" or htype=="magic_soil" or htype=="magic_water" or htype=="magic_wind" or htype=="magic_light" or htype=="magic_dark" or htype=="magic_wood" or htype=="magic_thunder")then
                if( toUnitResistance!=0 )then
    				if(toUnitResistance>=100)then
    					set realDamage = 0
                        call hunit.subLife(fromUnit,realDamage*(toUnitResistance-100)*0.01)
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
    		if( htype == "absolute" and (is.invincible(toUnit)==true or GetRandomInt(1,100)<R2I(toUnitInvincible)  ))then
    			set realDamage = 0
                set isInvincible = true
    		endif

            call console.log("realDamage:"+R2S(realDamage))

    		//造成伤害
    		if( realDamage > 0 ) then
				call hunit.subLife(toUnit,realDamage) //#
                call hEvent_setKiller(toUnit,fromUnit)
                call hPlayer_addDamage(GetOwningPlayer(fromUnit),realDamage)
                call hPlayer_addBeDamage(GetOwningPlayer(toUnit),realDamage)
				//分裂
				if( htype == "physical" and fromUnitSplit >0 )then
	                set loc = GetUnitLoc( toUnit )
                    set filter = hFilter.create()
                    call filter.setUnit(fromUnit)
                    call filter.isAlive(true)
                    call filter.isEnemy(true)
                    call filter.isBuilding(false)
	                set g = hgroup.createByLoc(loc,200.00,function hFilter.get )
                    call filter.destroy()
	                loop
			            exitwhen(IsUnitGroupEmptyBJ(g) == true)
			                set u = FirstOfGroup(g)
			                call GroupRemoveUnit( g , u )
		                    if(u!=toUnit and IsUnitEnemy(u,GetOwningPlayer(fromUnit)) == true) then
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
				if( htype == "physical" and fromUnitHemophagia >0 )then
                    call hunit.addLife(fromUnit,realDamage * fromUnitHemophagia * 0.01)
					call heffect.toUnit("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",fromUnit,"origin",1.00)
				endif
				//技能吸血
				if( htype == "magic" and hkind == "skill" and fromUnitHemophagiaSkill >0 )then
                    call hunit.addLife(fromUnit,realDamage * fromUnitHemophagiaSkill * 0.01)
                    call heffect.toUnit("Abilities\\Spells\\Items\\HealingSalve\\HealingSalveTarget.mdl",fromUnit,"weapon",1.8)
				endif
				//硬直
                if( is.alive(toUnit) )then
                    if( IsUnitPaused(toUnit) == false ) then
                        if( special == "effect_heavy" and specialVal>1 ) then
                            set fromUnitPunishHeavy = fromUnitPunishHeavy * specialVal
                        endif
                        call hAttrExt_subPunishCurrent(toUnit,realDamage*fromUnitPunishHeavy,0)
                    endif
                    if(hAttrExt_getPunishCurrent(toUnit) <= 0 ) then
                        call hAttrExt_setPunishCurrent(toUnit,hAttrExt_getPunish(toUnit),0)
                        call hAbility_punish( toUnit , 3.00 , 0 )
                        call hMsg_ttg2Unit(toUnit,"僵硬",10.00,"c0c0c0",0,3.00,50.00)
                    endif
                endif
                //反射
                if( toUnitHuntRebound >0 )then
					call hunit.subLife(fromUnit,realDamage * toUnitHuntRebound * 0.01)
                    call hMsg_style(hMsg_ttg2Unit(fromUnit,"反射"+I2S(R2I(realDamage*toUnitHuntRebound*0.01)),10.00,"f8aaeb",10,1.00,10.00)  ,"shrink",0,0.2)
				endif
                //治疗
                if( toUnitCure >0 )then
                    call hunit.addLife(toUnit,realDamage * toUnitCure * 0.01)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",toUnit,"origin",1.00)
                    set loc = GetUnitLoc( toUnit )
                    call hMsg_style(hMsg_ttg2Loc(loc,"治疗"+I2S(R2I(realDamage*toUnitCure*0.01)),10.00,"f5f89b",10,1.00,10.00)  ,"shrink",0,0.2)
                    call RemoveLocation( loc )
				endif
    		endif
    	endif

        //特殊效果,不需要伤害，一定会触发
        if( specialVal != 0 and specialDuring > 0 )then
            if(hkind=="attack")then
                if( special == "null" ) then
                elseif( special == "effect_life_back" ) then
                    call hAttrExt_addLifeBack(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_mana_back" ) then
                    call hAttrExt_addManaBack(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_attack_speed" ) then
                    call hAttr_addAttackSpeed(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_attack_physical" ) then
                    call hAttr_addAttackPhysical(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_attack_magic" ) then
                    call hAttr_addAttackMagic(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_move" ) then
                    call hAttr_addMove(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_aim" ) then
                    call hAttrExt_addAim(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_str" ) then
                    call hAttr_addStr(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_agi" ) then
                    call hAttr_addAgi(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_int" ) then
                    call hAttr_addInt(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_knocking" ) then
                    call hAttrExt_addKnocking(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_violence" ) then
                    call hAttrExt_addViolence(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_hemophagia" ) then
                    call hAttrExt_addHemophagia(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_hemophagia_skill" ) then
                    call hAttrExt_addHemophagiaSkill(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_split" ) then
                    call hAttrExt_addSplit(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_luck" ) then
                    call hAttrExt_addLuck(fromUnit,specialVal,specialDuring)
                elseif( special == "effect_hunt_amplitude" ) then
                    call hAttrExt_addHuntAmplitude(fromUnit,specialVal,specialDuring)
                endif
            endif
            if( special == "null" ) then
            elseif( special == "effect_poison" ) then
                call hAttrExt_subLifeBack(toUnit,specialVal,specialDuring)
            elseif( special == "effect_dry" ) then
                call hAttrExt_subManaBack(toUnit,specialVal,specialDuring)
            elseif( special == "effect_freeze" ) then
                call hAttr_subAttackSpeed(toUnit,specialVal,specialDuring)
            elseif( special == "effect_cold" ) then
                call hAttr_subMove(toUnit,specialVal,specialDuring)
            elseif( special == "effect_blunt" ) then
                call hAttr_subAttackPhysical(toUnit,specialVal,specialDuring)
                call hAttr_subAttackMagic(toUnit,specialVal,specialDuring)
            elseif( special == "effect_corrosion" ) then
                call hAttr_subDefend(toUnit,specialVal,specialDuring)
            elseif( special == "effect_chaos" ) then
                call hAttrExt_subResistance(toUnit,specialVal,specialDuring)
            elseif( special == "effect_twine" ) then
                call hAttrExt_subAvoid(toUnit,specialVal,specialDuring)
            elseif( special == "effect_blind" ) then
                call hAttrExt_subAim(toUnit,specialVal,specialDuring)
            elseif( special == "effect_tortua" ) then
                call hAttrExt_subToughness(toUnit,specialVal,specialDuring)
            elseif( special == "effect_weak" ) then
                call hAttr_subStr(toUnit,specialVal,specialDuring)
            elseif( special == "effect_bound" ) then
                call hAttr_subAgi(toUnit,specialVal,specialDuring)
            elseif( special == "effect_foolish" ) then
                call hAttr_subInt(toUnit,specialVal,specialDuring)
            elseif( special == "effect_lazy" ) then
                call hAttrExt_subKnocking(toUnit,specialVal,specialDuring)
                call hAttrExt_subViolence(toUnit,specialVal,specialDuring)
            elseif( special == "effect_swim") then
                if(toUnitSwimOppose!=0)then
                    set specialVal = specialVal - toUnitSwimOppose
                    set specialDuring = specialDuring * (1-toUnitSwimOppose*0.01)
                endif
                if(GetRandomReal(1,100)<specialVal and specialDuring>0)then
                    call hAbility_swim( toUnit , specialDuring )
                endif
            elseif( special == "effect_break" and GetRandomReal(1,100)<specialVal ) then
                call hAbility_punish( toUnit , specialDuring , 0 )
            elseif( special == "effect_unluck" ) then
                call hAttrExt_subLuck(toUnit,specialVal,specialDuring)
            endif
        endif

    endfunction

    /**
     * 伤害群
     */
    public function huntGroup takes group g,group rg,string gheffect,location gheffectloc,unit fromUnit,string heff,real damage,string hkind,string htype,boolean isBreak,boolean isNoAvoid,string special,real specialVal,real specialDuring returns nothing
    	local unit u = null
    	if( gheffect != null and gheffect != "" and gheffectloc != null) then
			call heffect.toLoc(gheffect,gheffectloc,0)
    	endif
    	loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                if(IsUnitEnemy(u,GetOwningPlayer(fromUnit)) == true and (rg == null or IsUnitInGroup(u, rg)==false)) then
                    call huntUnit(fromUnit,u,heff,damage,hkind,htype,isBreak,isNoAvoid,special,specialVal,specialDuring)
                endif
                if( rg != null) then
                	call GroupAddUnit( rg, u )
                endif
        endloop
        set u = null
    endfunction


	private function init takes nothing returns nothing

	endfunction

endlibrary
