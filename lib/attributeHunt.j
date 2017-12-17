/* 属性 - 伤害 */
globals
    hAttrHunt attrHunt = 0
endglobals

struct hAttrHuntBean

    public static unit fromUnit = null
    public static unit toUnit = null
    public static string huntEff = null
    public static real damage = 0
    public static string huntKind = null
    public static string huntType = null
    public static string isBreak = null
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
        set x.fromUnit = null
        set x.toUnit = null
        set x.huntEff = null
        set x.damage = 0
        set x.huntKind = null
        set x.huntType = null
        set x.isBreak = null
        set x.isNoAvoid = false
        set x.special = null
        set x.specialVal = 0
        set x.specialDuring = 0
        set x.whichGroup = null
        set x.whichGroupRepeat = null
        set x.whichGroupHuntEff = null
        set x.whichGroupHuntEffLoc = null
        return x
    endmethod
    method destroy takes nothing returns nothing
        set fromUnit = null
        set toUnit = null
        set huntEff = null
        set damage = 0
        set huntKind = null
        set huntType = null
        set isBreak = null
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

struct hAttrHunt

	/**
     * 伤害单位
     * heffect 特效
     * bean.huntKind伤害方式: 
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
    public static method huntUnit takes hAttrHuntBean bean returns nothing
    	
    	local real realDamage = 0
        local real punishEffectRatio = 0
        local real punishEffect = 0

        local real fromUnitPunishHeavy = 1

    	local real fromUnitAttackPhysical = attr.getAttackPhysical(bean.fromUnit)
        local real fromUnitAttackMagic = attr.getAttackMagic(bean.fromUnit)
    	local real fromUnitAim = attrExt.getAim(bean.fromUnit)
    	local real fromUnitKnocking = attrExt.getKnocking(bean.fromUnit)
    	local real fromUnitViolence = attrExt.getViolence(bean.fromUnit)
    	local real fromUnitHemophagia = attrExt.getHemophagia(bean.fromUnit)
    	local real fromUnitHemophagiaSkill = attrExt.getHemophagiaSkill(bean.fromUnit)
        local real fromUnitSplit = attrExt.getSplit(bean.fromUnit)
    	local real fromUnitRange = 200.00
    	local real fromUnitLuck = attrExt.getLuck(bean.fromUnit)
        local real fromUnitHuntAmplitude = attrExt.getHuntAmplitude(bean.fromUnit)
        local real fromUnitNaturalFire = attrNatural.getFire(bean.fromUnit)
        local real fromUnitNaturalSoil = attrNatural.getSoil(bean.fromUnit)
        local real fromUnitNaturalWater = attrNatural.getWater(bean.fromUnit)
        local real fromUnitNaturalWind = attrNatural.getWind(bean.fromUnit)
        local real fromUnitNaturalLight = attrNatural.getLight(bean.fromUnit)
        local real fromUnitNaturalDark = attrNatural.getDark(bean.fromUnit)
        local real fromUnitNaturalWood = attrNatural.getWood(bean.fromUnit)
    	local real fromUnitNaturalThunder = attrNatural.getThunder(bean.fromUnit)

    	local real toUnitDefend = attr.getDefend(bean.toUnit)
    	local real toUnitResistance = attrExt.getResistance(bean.toUnit)
    	local real toUnitToughness = attrExt.getToughness(bean.toUnit)
    	local real toUnitAvoid = attrExt.getAvoid(bean.toUnit)
    	local real toUnitMortalOppose = attrExt.getMortalOppose(bean.toUnit)
    	local real toUnitSwimOppose = attrExt.getSwimOppose(bean.toUnit)
    	local real toUnitLuck = attrExt.getLuck(bean.toUnit)
    	local real toUnitInvincible = attrExt.getInvincible(bean.toUnit)
    	local real toUnitHuntRebound = attrExt.getHuntRebound(bean.toUnit)
    	local real toUnitCure = attrExt.getCure(bean.toUnit)
        local real toUnitPunishOppose = attrExt.getPunishOppose(bean.toUnit)
        local real toUnitNaturalFireOppose = attrNatural.getFireOppose(bean.toUnit)
        local real toUnitNaturalSoilOppose = attrNatural.getSoilOppose(bean.toUnit)
        local real toUnitNaturalWaterOppose = attrNatural.getWaterOppose(bean.toUnit)
        local real toUnitNaturalWindOppose = attrNatural.getWindOppose(bean.toUnit)
        local real toUnitNaturalLightOppose = attrNatural.getLightOppose(bean.toUnit)
        local real toUnitNaturalDarkOppose = attrNatural.getDarkOppose(bean.toUnit)
        local real toUnitNaturalWoodOppose = attrNatural.getWoodOppose(bean.toUnit)
        local real toUnitNaturalThunderOppose = attrNatural.getThunderOppose(bean.toUnit)

        local boolean isInvincible = false

    	local location loc = null
    	local group g = null
    	local unit u = null
        local integer tempInt = 0
        local real tempReal = 0
        local hFilter filter = 0

    	if( bean.huntEff != null and bean.huntEff != "" ) then
    		set loc = GetUnitLoc( bean.toUnit )
			call heffect.toLoc(bean.huntEff,loc,0)
            call RemoveLocation( loc )
    	endif

        //计算硬直抵抗
        set punishEffectRatio = 0.99
        if(toUnitPunishOppose>0)then
            set punishEffectRatio = punishEffectRatio-toUnitPunishOppose*0.01
            if(punishEffectRatio<0.01)then
                set punishEffectRatio = 0.01
            endif
        endif

    	if(is.alive(bean.toUnit)==true and bean.damage>0.5)then

            //*重要* hjass必须设定护甲因子为0，这里为了修正魔兽负护甲依然因子保持0.06的bug
            //当护甲x为负时，最大-20,公式2-(1-a)^abs(x)
            if(toUnitDefend<0 and toUnitDefend>=-20)then
                set bean.damage =  bean.damage / (2-Pow(0.94,math.rabs(toUnitDefend)))
            elseif(toUnitDefend<0 and toUnitDefend<-20)then
                set bean.damage =  bean.damage / (2-Pow(0.94,20))
            endif

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

            //call console.info("bean.huntType:"+bean.huntType)

	        //判断无视Break 分为 null defend resistance both
	        if( bean.isBreak == "defend" ) then
                //@触发无视护甲事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "breakDefend"
                set hevtBean.triggerUnit = bean.fromUnit
                set hevtBean.targetUnit = bean.toUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被无视护甲事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beBreakDefend"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //
	        	if(toUnitDefend>0) then
	        		set toUnitDefend = 0
	        	endif
            elseif( bean.isBreak == "resistance" ) then
                //@触发无视魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "breakResistance"
                set hevtBean.triggerUnit = bean.fromUnit
                set hevtBean.targetUnit = bean.toUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitResistance
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被无视魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beBreakResistance"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitResistance
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //
                if(toUnitResistance>0) then
                    set toUnitResistance = 0
                endif
            elseif( bean.isBreak == "both" ) then
                //@触发同时无视护甲和魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "breakDefendAndResistance"
                set hevtBean.triggerUnit = bean.fromUnit
                set hevtBean.targetUnit = bean.toUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                set hevtBean.value2 = toUnitResistance
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被同时无视护甲和魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beBreakDefendAndResistance"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                set hevtBean.value2 = toUnitResistance
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //
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
                //@触发物理暴击事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "knocking"
                set hevtBean.triggerUnit = bean.fromUnit
                set hevtBean.targetUnit = bean.toUnit
                set hevtBean.damage = realDamage
                set hevtBean.value = fromUnitKnocking/300
                set hevtBean.value2 = fromUnitKnocking*0.05
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被物理暴击事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beKnocking"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.damage = realDamage
                set hevtBean.value = fromUnitKnocking/300
                set hevtBean.value2 = fromUnitKnocking*0.05
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
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
                    //@触发魔法暴击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "violence"
                    set hevtBean.triggerUnit = bean.fromUnit
                    set hevtBean.targetUnit = bean.toUnit
                    set hevtBean.damage = realDamage
                    set hevtBean.value = fromUnitKnocking/200
                    set hevtBean.value2 = fromUnitKnocking*0.03
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被魔法暴击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beViolence"
                    set hevtBean.triggerUnit = bean.toUnit
                    set hevtBean.sourceUnit = bean.fromUnit
                    set hevtBean.damage = realDamage
                    set hevtBean.value = fromUnitKnocking/200
                    set hevtBean.value2 = fromUnitKnocking*0.03
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif
	        endif
	        //计算回避 X 命中
    		if( bean.huntType == "physical" and realDamage<(hunit.getMaxLife(bean.toUnit)*0.25) and R2I(toUnitAvoid-fromUnitAim)>0 and GetRandomInt(1, 100)<=R2I(toUnitAvoid-fromUnitAim))then
                set realDamage = 0
                call hmsg.style(  hmsg.ttg2Unit(bean.toUnit,"回避",6.00,"5ef78e",10,1.00,10.00)  ,"scale",0,0.2)
                //@触发回避事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "avoid"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.attacker = bean.fromUnit
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被回避事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beAvoid"
                set hevtBean.triggerUnit = bean.fromUnit
                set hevtBean.attacker = bean.fromUnit
                set hevtBean.targetUnit = bean.toUnit
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
    		endif
    		//计算护甲
    		if( bean.huntType == "physical" and toUnitDefend!=0 )then
				if(toUnitDefend>0)then
					set realDamage = realDamage * (1-toUnitDefend/(toUnitDefend+200))
				else
                    set tempReal = 1+I2R(R2I(RAbsBJ(toUnitDefend)+149)/100)
                    set realDamage = realDamage * (tempReal-Pow(0.99, RAbsBJ(toUnitDefend)-(tempReal-2)*100))
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
    		if( bean.huntType != "absolute" and (is.invincible(bean.toUnit)==true or GetRandomInt(1,100)<R2I(toUnitInvincible)  ))then
    			set realDamage = 0
                set isInvincible = true
    		endif

    		//造成伤害
            //call console.info("realDamage:"+R2S(realDamage))
    		if( realDamage > 0 ) then
				call hunit.subLife(bean.toUnit,realDamage) //#
                call hplayer.addDamage(GetOwningPlayer(bean.fromUnit),realDamage)
                call hplayer.addBeDamage(GetOwningPlayer(bean.toUnit),realDamage)

                if(bean.isNoAvoid==true)then
                    //@触发造成无法回避伤害事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "noAvoid"
                    set hevtBean.triggerUnit = bean.fromUnit
                    set hevtBean.targetUnit = bean.toUnit
                    set hevtBean.damage = realDamage
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被无法回避伤害事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beNoAvoid"
                    set hevtBean.triggerUnit = bean.toUnit
                    set hevtBean.sourceUnit = bean.fromUnit
                    set hevtBean.damage = realDamage
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif

                //@触发伤害事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "damage"
                set hevtBean.triggerUnit = bean.fromUnit
                set hevtBean.targetUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.damage = bean.damage
                set hevtBean.realDamage = realDamage
                set hevtBean.damageKind = bean.huntKind
                set hevtBean.damageType = bean.huntType
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被伤害事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beDamage"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.damage = bean.damage
                set hevtBean.realDamage = realDamage
                set hevtBean.damageKind = bean.huntKind
                set hevtBean.damageType = bean.huntType
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                
				//分裂
				if( bean.huntType == "physical" and fromUnitSplit >0 )then
	                set loc = GetUnitLoc( bean.toUnit )
                    set filter = hFilter.create()
                    call filter.setUnit(bean.fromUnit)
                    call filter.isAlive(true)
                    call filter.isEnemy(true)
                    call filter.isBuilding(false)
	                set g = hgroup.createByLoc(loc,fromUnitRange,function hFilter.get )
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
                    //@触发分裂事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "spilt"
                    set hevtBean.triggerUnit = bean.fromUnit
                    set hevtBean.targetUnit = bean.toUnit
                    set hevtBean.damage = realDamage * fromUnitSplit * 0.01
                    set hevtBean.range = fromUnitRange
                    set hevtBean.value = fromUnitSplit
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被分裂事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beSpilt"
                    set hevtBean.triggerUnit = bean.toUnit
                    set hevtBean.sourceUnit = bean.fromUnit
                    set hevtBean.damage = realDamage * fromUnitSplit * 0.01
                    set hevtBean.range = fromUnitRange
                    set hevtBean.value = fromUnitSplit
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
	            endif
	            //吸血
				if( bean.huntType == "physical" and fromUnitHemophagia >0 )then
                    call hunit.addLife(bean.fromUnit,realDamage * fromUnitHemophagia * 0.01)
					call heffect.toUnit("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",bean.fromUnit,"origin",1.00)
                    //@触发吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "hemophagia"
                    set hevtBean.triggerUnit = bean.fromUnit
                    set hevtBean.targetUnit = bean.toUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagia * 0.01
                    set hevtBean.value = fromUnitHemophagia
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beHemophagia"
                    set hevtBean.triggerUnit = bean.toUnit
                    set hevtBean.sourceUnit = bean.fromUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagia * 0.01
                    set hevtBean.value = fromUnitHemophagia
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
				endif
				//技能吸血
				if( bean.huntType == "magic" and bean.huntKind == "skill" and fromUnitHemophagiaSkill >0 )then
                    call hunit.addLife(bean.fromUnit,realDamage * fromUnitHemophagiaSkill * 0.01)
                    call heffect.toUnit("Abilities\\Spells\\Items\\HealingSalve\\HealingSalveTarget.mdl",bean.fromUnit,"weapon",1.8)
                    //@触发技能吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "skillHemophagia"
                    set hevtBean.triggerUnit = bean.fromUnit
                    set hevtBean.targetUnit = bean.toUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagiaSkill * 0.01
                    set hevtBean.value = fromUnitHemophagiaSkill
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被技能吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beSkillHemophagia"
                    set hevtBean.triggerUnit = bean.toUnit
                    set hevtBean.sourceUnit = bean.fromUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagiaSkill * 0.01
                    set hevtBean.value = fromUnitHemophagiaSkill
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
				endif
				//硬直
                if( is.alive(bean.toUnit) )then
                    if( bean.special == "effect_heavy" and bean.specialVal>1 ) then
                        set fromUnitPunishHeavy = fromUnitPunishHeavy * bean.specialVal
                    endif
                    call attrExt.subPunishCurrent(bean.toUnit,realDamage*fromUnitPunishHeavy,0)

                    if(attrExt.getPunishCurrent(bean.toUnit) <= 0 ) then
                        call attrExt.setPunishCurrent(bean.toUnit,attrExt.getPunish(bean.toUnit),0)
                        set punishEffect = attr.getAttackSpeed(bean.toUnit)*punishEffectRatio
                        if(punishEffect<1)then
                            set punishEffect = 1.00
                        endif
                        call attr.subAttackSpeed( bean.toUnit , punishEffect , 5.00 )
                        set punishEffect = attr.getMove(bean.toUnit)*punishEffectRatio
                        if(punishEffect<1)then
                            set punishEffect = 1.00
                        endif
                        call attr.subMove( bean.toUnit , punishEffect , 5.00 )
                        call hmsg.style(hmsg.ttg2Unit(bean.toUnit,"僵硬",6.00,"c0c0c0",0,2.50,50.00)  ,"scale",0,0.05)

                        //@触发硬直事件
                        set hevtBean = hEvtBean.create()
                        set hevtBean.triggerKey = "punish"
                        set hevtBean.triggerUnit = bean.toUnit
                        set hevtBean.sourceUnit = bean.fromUnit
                        set hevtBean.value = punishEffect
                        set hevtBean.during = 5.00
                        call evt.triggerEvent(hevtBean)
                        call hevtBean.destroy()

                    endif
                endif
                //反射
                if( toUnitHuntRebound >0 )then
					call hunit.subLife(bean.fromUnit,realDamage * toUnitHuntRebound * 0.01)
                    call hmsg.style(hmsg.ttg2Unit(bean.fromUnit,"反射"+I2S(R2I(realDamage*toUnitHuntRebound*0.01)),10.00,"f8aaeb",10,1.00,10.00)  ,"shrink",0,0.2)
				    //@触发反伤事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "rebound"
                    set hevtBean.triggerUnit = bean.toUnit
                    set hevtBean.sourceUnit = bean.fromUnit
                    set hevtBean.damage = realDamage * toUnitHuntRebound * 0.01
                    call evt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
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

        //特殊效果,不需要是攻击，不需要大于0伤害，一定会触发
        if( isInvincible == false and bean.specialVal != 0 and bean.specialDuring > 0 )then
            if( bean.special == "null" ) then
            elseif( bean.special == "effect_life_back" ) then
                call attrExt.addLifeBack(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_mana_back" ) then
                call attrExt.addManaBack(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_attack_speed" ) then
                call attr.addAttackSpeed(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_attack_physical" ) then
                call attr.addAttackPhysical(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_attack_magic" ) then
                call attr.addAttackMagic(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_move" ) then
                call attr.addMove(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_aim" ) then
                call attrExt.addAim(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_str" ) then
                call attr.addStr(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_agi" ) then
                call attr.addAgi(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_int" ) then
                call attr.addInt(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_knocking" ) then
                call attrExt.addKnocking(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_violence" ) then
                call attrExt.addViolence(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_hemophagia" ) then
                call attrExt.addHemophagia(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_hemophagia_skill" ) then
                call attrExt.addHemophagiaSkill(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_split" ) then
                call attrExt.addSplit(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_luck" ) then
                call attrExt.addLuck(bean.fromUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_hunt_amplitude" ) then
                call attrExt.addHuntAmplitude(bean.fromUnit,bean.specialVal,bean.specialDuring)
            endif
            if( bean.special == "null" ) then
            elseif( bean.special == "effect_poison" ) then
                call attrExt.subLifeBack(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_dry" ) then
                call attrExt.subManaBack(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_freeze" ) then
                call attr.subAttackSpeed(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_cold" ) then
                call attr.subMove(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_blunt" ) then
                call attr.subAttackPhysical(bean.toUnit,bean.specialVal,bean.specialDuring)
                call attr.subAttackMagic(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_corrosion" ) then
                call attr.subDefend(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_chaos" ) then
                call attrExt.subResistance(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_twine" ) then
                call attrExt.subAvoid(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_blind" ) then
                call attrExt.subAim(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_tortua" ) then
                call attrExt.subToughness(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_weak" ) then
                call attr.subStr(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_bound" ) then
                call attr.subAgi(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_foolish" ) then
                call attr.subInt(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_lazy" ) then
                call attrExt.subKnocking(bean.toUnit,bean.specialVal,bean.specialDuring)
                call attrExt.subViolence(bean.toUnit,bean.specialVal,bean.specialDuring)
            elseif( bean.special == "effect_swim") then
                if(toUnitSwimOppose!=0)then
                    set bean.specialVal = bean.specialVal - toUnitSwimOppose
                    set bean.specialDuring = bean.specialDuring * (1-toUnitSwimOppose*0.01)
                endif
                //@触发眩晕事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "swim"
                set hevtBean.triggerUnit = bean.fromUnit
                set hevtBean.targetUnit = bean.toUnit
                set hevtBean.value = bean.specialVal
                set hevtBean.during = bean.specialDuring
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被眩晕事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beSwim"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.value = bean.specialVal
                set hevtBean.during = bean.specialDuring
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //
                if(GetRandomReal(1,100)<bean.specialVal and bean.specialDuring>0)then
                    call hability.swim( bean.toUnit , bean.specialDuring )
                endif
            elseif( bean.special == "effect_break" and GetRandomReal(1,100)<bean.specialVal ) then
                set punishEffect = attr.getAttackSpeed(bean.toUnit)*punishEffectRatio
                if(punishEffect<1)then
                    set punishEffect = 1.00
                endif
                call attr.subAttackSpeed( bean.toUnit , punishEffect , bean.specialDuring )
                set punishEffect = attr.getMove(bean.toUnit)*punishEffectRatio
                if(punishEffect<1)then
                    set punishEffect = 1.00
                endif
                call attr.subMove( bean.toUnit , punishEffect , bean.specialDuring )
                
                //@触发硬直事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "punish"
                set hevtBean.triggerUnit = bean.toUnit
                set hevtBean.sourceUnit = bean.fromUnit
                set hevtBean.value = punishEffect
                set hevtBean.during = bean.specialDuring
                call evt.triggerEvent(hevtBean)
                call hevtBean.destroy()

            elseif( bean.special == "effect_unluck" ) then
                call attrExt.subLuck(bean.toUnit,bean.specialVal,bean.specialDuring)
            endif

            //@触发伤害特效事件
            set hevtBean = hEvtBean.create()
            set hevtBean.triggerKey = "damageEffect"
            set hevtBean.sourceUnit = bean.fromUnit
            set hevtBean.triggerUnit = bean.fromUnit
            set hevtBean.targetUnit = bean.toUnit
            set hevtBean.damage = bean.damage
            set hevtBean.realDamage = realDamage
            set hevtBean.damageEffect = bean.special
            set hevtBean.damageKind = bean.huntKind
            set hevtBean.damageType = bean.huntType
            set hevtBean.value = bean.specialVal
            set hevtBean.during = bean.specialDuring
            call evt.triggerEvent(hevtBean)
            call hevtBean.destroy()
            //@触发被伤害特效事件
            set hevtBean = hEvtBean.create()
            set hevtBean.triggerKey = "beDamageEffect"
            set hevtBean.sourceUnit = bean.fromUnit
            set hevtBean.triggerUnit = bean.toUnit
            set hevtBean.damage = bean.damage
            set hevtBean.realDamage = realDamage
            set hevtBean.damageEffect = bean.special
            set hevtBean.damageKind = bean.huntKind
            set hevtBean.damageType = bean.huntType
            set hevtBean.value = bean.specialVal
            set hevtBean.during = bean.specialDuring
            call evt.triggerEvent(hevtBean)
            call hevtBean.destroy()
        endif

    endmethod

    /**
     * 伤害群
     */
    public static method huntGroup takes hAttrHuntBean bean returns nothing
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
    endmethod

endstruct
