/**
 属性 - 伤害
*/
globals
    hAttrHunt hattrHunt
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
    public static boolean isEffect = false

    public static group whichGroup = null
    public static group whichGroupRepeat = null
    public static string whichGroupHuntEff = null
    public static location whichGroupHuntEffLoc = null

    static method create takes nothing returns hAttrHuntBean
        local hAttrHuntBean x
        set x = hAttrHuntBean.allocate()
        set x.fromUnit = null
        set x.toUnit = null
        set x.huntEff = null
        set x.damage = 0
        set x.huntKind = null
        set x.huntType = null
        set x.isBreak = null
        set x.isNoAvoid = false
        set x.isEffect = false
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
        set isEffect = false
        set whichGroup = null
        set whichGroupRepeat = null
        set whichGroupHuntEff = null
        set whichGroupHuntEffLoc = null
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
     		special 特殊（如分裂，攻击特效的爆炸、闪电链之类的）
     * bean.huntType伤害类型: 
     		physical 物理伤害则无视护甲<享受物理暴击加成，受护甲影响>
     		magic 魔法<享受魔法暴击加成，受魔抗影响>
            fire    火
            soil    土
            water   水 
            ice     冰 
            wind    风
            light   光 
            dark    暗
            wood    木
            thunder 雷
            poison  毒
            ghost   鬼
            metal   金
            dragon  龙
     		real 真实
     		absolute 绝对
     * isBreak是否无视：true | false 物理伤害则无视护甲 | 魔法伤害则无视魔抗
     * isNoAvoid是否无法回避：true | false
     * isEffect是否触发伤害特效：true | false 攻击默认强制设为true
     * 沉默时，爆炸、闪电链、击飞会失效，其他不受影响
     */
    public static method huntUnit takes hAttrHuntBean bean returns nothing
    	
        local unit fromUnit = bean.fromUnit
        local unit toUnit = bean.toUnit
    	local real realDamage = 0
    	local real realDamagePercent = 0.0
        local string realDamageString = null
        local string realDamageStringColor = "d9d9d9"
        local real punishEffectRatio = 0
        local real punishEffect = 0

        local real fromUnitPunishHeavy = 1
        local boolean isEffect = bean.isEffect
        local boolean isAvoid = false
        local boolean isKnocking = false
        local boolean isViolence = false

    	local location loc = null
    	local group g = null
    	local unit u = null
        local integer tempInt = 0
        local real tempReal = 0
        local hFilter filter
        local hAttrHuntBean huntBean

        //获取单位属性
    	local real fromUnitAttackPhysical = 0.0
        local real fromUnitAttackMagic = 0.0
        local real fromUnitAttackPhysicalPercent = 0.0
        local real fromUnitAttackMagicPercent = 0.0
    	local real fromUnitAim = 0.0
    	local real fromUnitKnocking = 0.0
    	local real fromUnitViolence = 0.0
    	local real fromUnitHemophagia = 0.0
    	local real fromUnitHemophagiaSkill = 0.0
        local real fromUnitSplit = 0.0
    	local real fromUnitSplitRange = 0.0
    	local real fromUnitLuck = 0.0
        local real fromUnitHuntAmplitude = 0.0
        local real fromUnitHuntReboundOppose = 0.0
        local real fromUnitNaturalFire = 0.0
        local real fromUnitNaturalSoil = 0.0
        local real fromUnitNaturalWater = 0.0
        local real fromUnitNaturalIce = 0.0
        local real fromUnitNaturalWind = 0.0
        local real fromUnitNaturalLight = 0.0
        local real fromUnitNaturalDark = 0.0
        local real fromUnitNaturalWood = 0.0
        local real fromUnitNaturalThunder = 0.0
    	local real fromUnitNaturalPoison = 0.0
    	local real fromUnitNaturalGhost = 0.0
    	local real fromUnitNaturalMetal = 0.0
    	local real fromUnitNaturalDragon = 0.0
        //获取攻击/伤害特效
        local real fromUnitHuntEffectLifeBackVal = 0.0
        local real fromUnitHuntEffectLifeBackDuring = 0.0
        local real fromUnitHuntEffectManaBackVal = 0.0
        local real fromUnitHuntEffectManaBackDuring = 0.0
        local real fromUnitHuntEffectAttackSpeedVal = 0.0
        local real fromUnitHuntEffectAttackSpeedDuring = 0.0
        local real fromUnitHuntEffectAttackPhysicalVal = 0.0
        local real fromUnitHuntEffectAttackPhysicalDuring = 0.0
        local real fromUnitHuntEffectAttackMagicVal = 0.0
        local real fromUnitHuntEffectAttackMagicDuring = 0.0
        local real fromUnitHuntEffectAttackRangeVal = 0.0
        local real fromUnitHuntEffectAttackRangeDuring = 0.0
        local real fromUnitHuntEffectSightVal = 0.0
        local real fromUnitHuntEffectSightDuring = 0.0
        local real fromUnitHuntEffectMoveVal = 0.0
        local real fromUnitHuntEffectMoveDuring = 0.0
        local real fromUnitHuntEffectAimVal = 0.0
        local real fromUnitHuntEffectAimDuring = 0.0
        local real fromUnitHuntEffectStrVal = 0.0
        local real fromUnitHuntEffectStrDuring = 0.0
        local real fromUnitHuntEffectAgiVal = 0.0
        local real fromUnitHuntEffectAgiDuring = 0.0
        local real fromUnitHuntEffectIntVal = 0.0
        local real fromUnitHuntEffectIntDuring = 0.0
        local real fromUnitHuntEffectKnockingVal = 0.0
        local real fromUnitHuntEffectKnockingDuring = 0.0
        local real fromUnitHuntEffectViolenceVal = 0.0
        local real fromUnitHuntEffectViolenceDuring = 0.0
        local real fromUnitHuntEffectHemophagiaVal = 0.0
        local real fromUnitHuntEffectHemophagiaDuring = 0.0
        local real fromUnitHuntEffectHemophagiaSkillVal = 0.0
        local real fromUnitHuntEffectHemophagiaSkillDuring = 0.0
        local real fromUnitHuntEffectSplitVal = 0.0
        local real fromUnitHuntEffectSplitDuring = 0.0
        local real fromUnitHuntEffectLuckVal = 0.0
        local real fromUnitHuntEffectLuckDuring = 0.0
        local real fromUnitHuntEffectHuntAmplitudeVal = 0.0
        local real fromUnitHuntEffectHuntAmplitudeDuring = 0.0
        local real fromUnitHuntEffectFireVal = 0.0
        local real fromUnitHuntEffectFireDuring = 0.0
        local real fromUnitHuntEffectSoilVal = 0.0
        local real fromUnitHuntEffectSoilDuring = 0.0
        local real fromUnitHuntEffectWaterVal = 0.0
        local real fromUnitHuntEffectWaterDuring = 0.0
        local real fromUnitHuntEffectIceVal = 0.0
        local real fromUnitHuntEffectIceDuring = 0.0
        local real fromUnitHuntEffectWindVal = 0.0
        local real fromUnitHuntEffectWindDuring = 0.0
        local real fromUnitHuntEffectLightVal = 0.0
        local real fromUnitHuntEffectLightDuring = 0.0
        local real fromUnitHuntEffectDarkVal = 0.0
        local real fromUnitHuntEffectDarkDuring = 0.0
        local real fromUnitHuntEffectWoodVal = 0.0
        local real fromUnitHuntEffectWoodDuring = 0.0
        local real fromUnitHuntEffectThunderVal = 0.0
        local real fromUnitHuntEffectThunderDuring = 0.0
        local real fromUnitHuntEffectPoisonVal = 0.0
        local real fromUnitHuntEffectPoisonDuring = 0.0
        local real fromUnitHuntEffectGhostVal = 0.0
        local real fromUnitHuntEffectGhostDuring = 0.0
        local real fromUnitHuntEffectMetalVal = 0.0
        local real fromUnitHuntEffectMetalDuring = 0.0
        local real fromUnitHuntEffectDragonVal = 0.0
        local real fromUnitHuntEffectDragonDuring = 0.0
        local real fromUnitHuntEffectFireOpposeVal = 0.0
        local real fromUnitHuntEffectFireOpposeDuring = 0.0
        local real fromUnitHuntEffectSoilOpposeVal = 0.0
        local real fromUnitHuntEffectSoilOpposeDuring = 0.0
        local real fromUnitHuntEffectWaterOpposeVal = 0.0
        local real fromUnitHuntEffectWaterOpposeDuring = 0.0
        local real fromUnitHuntEffectIceOpposeVal = 0.0
        local real fromUnitHuntEffectIceOpposeDuring = 0.0
        local real fromUnitHuntEffectWindOpposeVal = 0.0
        local real fromUnitHuntEffectWindOpposeDuring = 0.0
        local real fromUnitHuntEffectLightOpposeVal = 0.0
        local real fromUnitHuntEffectLightOpposeDuring = 0.0
        local real fromUnitHuntEffectDarkOpposeVal = 0.0
        local real fromUnitHuntEffectDarkOpposeDuring = 0.0
        local real fromUnitHuntEffectWoodOpposeVal = 0.0
        local real fromUnitHuntEffectWoodOpposeDuring = 0.0
        local real fromUnitHuntEffectThunderOpposeVal = 0.0
        local real fromUnitHuntEffectThunderOpposeDuring = 0.0
        local real fromUnitHuntEffectPoisonOpposeVal = 0.0
        local real fromUnitHuntEffectPoisonOpposeDuring = 0.0
        local real fromUnitHuntEffectGhostOpposeVal = 0.0
        local real fromUnitHuntEffectGhostOpposeDuring = 0.0
        local real fromUnitHuntEffectMetalOpposeVal = 0.0
        local real fromUnitHuntEffectMetalOpposeDuring = 0.0
        local real fromUnitHuntEffectDragonOpposeVal = 0.0
        local real fromUnitHuntEffectDragonOpposeDuring = 0.0
        local real fromUnitHuntEffectToxicVal = 0.0
        local real fromUnitHuntEffectToxicDuring = 0.0
        local real fromUnitHuntEffectBurnVal = 0.0
        local real fromUnitHuntEffectBurnDuring = 0.0
        local real fromUnitHuntEffectDryVal = 0.0
        local real fromUnitHuntEffectDryDuring = 0.0
        local real fromUnitHuntEffectFreezeVal = 0.0
        local real fromUnitHuntEffectFreezeDuring = 0.0
        local real fromUnitHuntEffectColdVal = 0.0
        local real fromUnitHuntEffectColdDuring = 0.0
        local real fromUnitHuntEffectBluntVal = 0.0
        local real fromUnitHuntEffectBluntDuring = 0.0
        local real fromUnitHuntEffectMuggleVal = 0.0
        local real fromUnitHuntEffectMuggleDuring = 0.0
        local real fromUnitHuntEffectMyopiaVal = 0.0
        local real fromUnitHuntEffectMyopiaDuring = 0.0
        local real fromUnitHuntEffectBlindVal = 0.0
        local real fromUnitHuntEffectBlindDuring = 0.0
        local real fromUnitHuntEffectCorrosionVal = 0.0
        local real fromUnitHuntEffectCorrosionDuring = 0.0
        local real fromUnitHuntEffectChaosVal = 0.0
        local real fromUnitHuntEffectChaosDuring = 0.0
        local real fromUnitHuntEffectTwineVal = 0.0
        local real fromUnitHuntEffectTwineDuring = 0.0
        local real fromUnitHuntEffectDrunkVal = 0.0
        local real fromUnitHuntEffectDrunkDuring = 0.0
        local real fromUnitHuntEffectTortuaVal = 0.0
        local real fromUnitHuntEffectTortuaDuring = 0.0
        local real fromUnitHuntEffectWeakVal = 0.0
        local real fromUnitHuntEffectWeakDuring = 0.0
        local real fromUnitHuntEffectAstrictVal = 0.0
        local real fromUnitHuntEffectAstrictDuring = 0.0
        local real fromUnitHuntEffectFoolishVal = 0.0
        local real fromUnitHuntEffectFoolishDuring = 0.0
        local real fromUnitHuntEffectDullVal = 0.0
        local real fromUnitHuntEffectDullDuring = 0.0
        local real fromUnitHuntEffectDirtVal = 0.0
        local real fromUnitHuntEffectDirtDuring = 0.0
        local real fromUnitHuntEffectSwimOdds = 0.0
        local real fromUnitHuntEffectSwimDuring = 0.0
        local real fromUnitHuntEffectHeavyOdds = 0.0
        local real fromUnitHuntEffectHeavyVal = 0.0
        local real fromUnitHuntEffectBreakOdds = 0.0
        local real fromUnitHuntEffectBreakDuring = 0.0
        local real fromUnitHuntEffectUnluckVal = 0.0
        local real fromUnitHuntEffectUnluckDuring = 0.0
        local real fromUnitHuntEffectSilentOdds = 0.0
        local real fromUnitHuntEffectSilentDuring = 0.0
        local real fromUnitHuntEffectUnarmOdds = 0.0
        local real fromUnitHuntEffectUnarmDuring = 0.0
        local real fromUnitHuntEffectFetterOdds = 0.0
        local real fromUnitHuntEffectFetterDuring = 0.0
        local real fromUnitHuntEffectBombVal = 0.0
        local real fromUnitHuntEffectBombOdds = 0.0
        local real fromUnitHuntEffectBombRange = 0.0
        local string fromUnitHuntEffectBombModel = ""
        local real fromUnitHuntEffectLightningChainVal = 0.0
        local real fromUnitHuntEffectLightningChainOdds = 0.0
        local real fromUnitHuntEffectLightningChainQty = 0.0
        local real fromUnitHuntEffectLightningChainReduce = 0.0
        local string fromUnitHuntEffectLightningChainModel = ""
        local real fromUnitHuntEffectCrackFlyVal = 0.0
        local real fromUnitHuntEffectCrackFlyOdds = 0.0
        local real fromUnitHuntEffectCrackFlyDistance = 0.0
        local real fromUnitHuntEffectCrackFlyHigh = 0.0
        //获取受伤单位抵抗属性
    	local real toUnitDefend = 0.0
    	local real toUnitResistance = 0.0
    	local real toUnitToughness = 0.0
    	local real toUnitAvoid = 0.0
    	local real toUnitLuck = 0.0
    	local real toUnitHuntRebound = 0.0
        local real toUnitKnockingOppose = 0.0
	    local real toUnitViolenceOppose = 0.0
	    local real toUnitHemophagiaOppose = 0.0
	    local real toUnitSplitOppose = 0.0
	    local real toUnitPunishOppose = 0.0
	    local real toUnitSwimOppose = 0.0
	    local real toUnitHeavyOppose = 0.0
        local real toUnitBreakOppose = 0.0
        local real toUnitUnluckOppose = 0.0
        local real toUnitSilentOppose = 0.0
        local real toUnitUnarmOppose = 0.0
        local real toUnitFetterOppose = 0.0
        local real toUnitBombOppose = 0.0
        local real toUnitLightningChainOppose = 0.0
        local real toUnitCrackFlyOppose = 0.0
        local real toUnitNaturalFireOppose = 0.0
        local real toUnitNaturalSoilOppose = 0.0
        local real toUnitNaturalWaterOppose = 0.0
        local real toUnitNaturalIceOppose = 0.0
        local real toUnitNaturalWindOppose = 0.0
        local real toUnitNaturalLightOppose = 0.0
        local real toUnitNaturalDarkOppose = 0.0
        local real toUnitNaturalWoodOppose = 0.0
        local real toUnitNaturalThunderOppose = 0.0
        local real toUnitNaturalPoisonOppose = 0.0
        local real toUnitNaturalGhostOppose = 0.0
    	local real toUnitNaturalMetalOppose = 0.0
    	local real toUnitNaturalDragonOppose = 0.0

        local boolean isDoDamage = true

        if(bean.damage<0.2)then
            call hconsole.warning("伤害太小被忽略")
            set isDoDamage = false
        endif
        if(fromUnit==null)then
            call hconsole.warning("伤害源不存在")
            set isDoDamage = false
        endif
        if(toUnit==null)then
            call hconsole.warning("目标不存在")
            set isDoDamage = false
        endif
        if(his.alive(toUnit)==false)then
            call hconsole.warning("目标已死亡")
            set isDoDamage = false
        endif

        //判断伤害方式
        if( bean.huntKind=="attack" )then
            if(his.unarm(fromUnit)==true)then
                set isDoDamage = false
            endif
            set isEffect = true
        elseif( bean.huntKind=="skill" )then
            if(his.silent(fromUnit)==true)then
                set isDoDamage = false
            endif
        elseif( bean.huntKind=="item" )then
        elseif( bean.huntKind=="special" )then
        else
            call hconsole.error("伤害单位错误：bean.huntKind")
            set isDoDamage = false
        endif

        //计算单位是否无敌且伤害类型不混合绝对伤害（无敌属性为百分比计算，被动触发抵挡一次）
        if( hlogic.strpos(bean.huntType,"absolute")==-1 and (his.invincible(toUnit)==true or GetRandomInt(1,100)<R2I(hattr.getInvincible(toUnit))  ))then
            set isDoDamage = false
        endif

    	if( bean.huntEff != null and bean.huntEff != "" ) then
    		set loc = GetUnitLoc( toUnit )
			call heffect.toLoc(bean.huntEff,loc,0)
            call RemoveLocation( loc )
            set loc = null
    	endif

        if(isDoDamage == true)then // ! 伤害有效
            //获取单位属性
            set fromUnitAttackPhysical = hattr.getAttackPhysical(fromUnit)
            set fromUnitAttackMagic = hattr.getAttackMagic(fromUnit)
            set fromUnitAttackPhysicalPercent = 0
            set fromUnitAttackMagicPercent = 0
            set fromUnitAim = hattr.getAim(fromUnit)
            set fromUnitKnocking = hattr.getKnocking(fromUnit)
            set fromUnitViolence = hattr.getViolence(fromUnit)
            set fromUnitHemophagia = hattr.getHemophagia(fromUnit)
            set fromUnitHemophagiaSkill = hattr.getHemophagiaSkill(fromUnit)
            set fromUnitSplit = hattr.getSplit(fromUnit)
            set fromUnitSplitRange = hattr.getSplitRange(fromUnit)
            set fromUnitLuck = hattr.getLuck(fromUnit)
            set fromUnitHuntAmplitude = hattr.getHuntAmplitude(fromUnit)
            set fromUnitHuntReboundOppose = hattr.getHuntReboundOppose(fromUnit)
            set fromUnitNaturalFire = hattrNatural.getFire(fromUnit)
            set fromUnitNaturalSoil = hattrNatural.getSoil(fromUnit)
            set fromUnitNaturalWater = hattrNatural.getWater(fromUnit)
            set fromUnitNaturalIce = hattrNatural.getIce(fromUnit)
            set fromUnitNaturalWind = hattrNatural.getWind(fromUnit)
            set fromUnitNaturalLight = hattrNatural.getLight(fromUnit)
            set fromUnitNaturalDark = hattrNatural.getDark(fromUnit)
            set fromUnitNaturalWood = hattrNatural.getWood(fromUnit)
            set fromUnitNaturalThunder = hattrNatural.getThunder(fromUnit)
            set fromUnitNaturalPoison = hattrNatural.getPoison(fromUnit)
            set fromUnitNaturalGhost = hattrNatural.getGhost(fromUnit)
            set fromUnitNaturalMetal = hattrNatural.getMetal(fromUnit)
            set fromUnitNaturalDragon = hattrNatural.getDragon(fromUnit)
            //获取攻击/伤害特效
            set fromUnitHuntEffectLifeBackVal = hAttrEffect.getLifeBackVal(bean.fromUnit)
            set fromUnitHuntEffectLifeBackDuring = hAttrEffect.getLifeBackDuring(bean.fromUnit)
            set fromUnitHuntEffectManaBackVal = hAttrEffect.getManaBackVal(bean.fromUnit)
            set fromUnitHuntEffectManaBackDuring = hAttrEffect.getManaBackDuring(bean.fromUnit)
            set fromUnitHuntEffectAttackSpeedVal = hAttrEffect.getAttackSpeedVal(bean.fromUnit)
            set fromUnitHuntEffectAttackSpeedDuring = hAttrEffect.getAttackSpeedDuring(bean.fromUnit)
            set fromUnitHuntEffectAttackPhysicalVal = hAttrEffect.getAttackPhysicalVal(bean.fromUnit)
            set fromUnitHuntEffectAttackPhysicalDuring = hAttrEffect.getAttackPhysicalDuring(bean.fromUnit)
            set fromUnitHuntEffectAttackMagicVal = hAttrEffect.getAttackMagicVal(bean.fromUnit)
            set fromUnitHuntEffectAttackMagicDuring = hAttrEffect.getAttackMagicDuring(bean.fromUnit)
            set fromUnitHuntEffectAttackRangeVal = hAttrEffect.getAttackRangeVal(bean.fromUnit)
            set fromUnitHuntEffectAttackRangeDuring = hAttrEffect.getAttackRangeDuring(bean.fromUnit)
            set fromUnitHuntEffectSightVal = hAttrEffect.getSightVal(bean.fromUnit)
            set fromUnitHuntEffectSightDuring = hAttrEffect.getSightDuring(bean.fromUnit)
            set fromUnitHuntEffectMoveVal = hAttrEffect.getMoveVal(bean.fromUnit)
            set fromUnitHuntEffectMoveDuring = hAttrEffect.getMoveDuring(bean.fromUnit)
            set fromUnitHuntEffectAimVal = hAttrEffect.getAimVal(bean.fromUnit)
            set fromUnitHuntEffectAimDuring = hAttrEffect.getAimDuring(bean.fromUnit)
            set fromUnitHuntEffectStrVal = hAttrEffect.getStrVal(bean.fromUnit)
            set fromUnitHuntEffectStrDuring = hAttrEffect.getStrDuring(bean.fromUnit)
            set fromUnitHuntEffectAgiVal = hAttrEffect.getAgiVal(bean.fromUnit)
            set fromUnitHuntEffectAgiDuring = hAttrEffect.getAgiDuring(bean.fromUnit)
            set fromUnitHuntEffectIntVal = hAttrEffect.getIntVal(bean.fromUnit)
            set fromUnitHuntEffectIntDuring = hAttrEffect.getIntDuring(bean.fromUnit)
            set fromUnitHuntEffectKnockingVal = hAttrEffect.getKnockingVal(bean.fromUnit)
            set fromUnitHuntEffectKnockingDuring = hAttrEffect.getKnockingDuring(bean.fromUnit)
            set fromUnitHuntEffectViolenceVal = hAttrEffect.getViolenceVal(bean.fromUnit)
            set fromUnitHuntEffectViolenceDuring = hAttrEffect.getViolenceDuring(bean.fromUnit)
            set fromUnitHuntEffectHemophagiaVal = hAttrEffect.getHemophagiaVal(bean.fromUnit)
            set fromUnitHuntEffectHemophagiaDuring = hAttrEffect.getHemophagiaDuring(bean.fromUnit)
            set fromUnitHuntEffectHemophagiaSkillVal = hAttrEffect.getHemophagiaSkillVal(bean.fromUnit)
            set fromUnitHuntEffectHemophagiaSkillDuring = hAttrEffect.getHemophagiaSkillDuring(bean.fromUnit)
            set fromUnitHuntEffectSplitVal = hAttrEffect.getSplitVal(bean.fromUnit)
            set fromUnitHuntEffectSplitDuring = hAttrEffect.getSplitDuring(bean.fromUnit)
            set fromUnitHuntEffectLuckVal = hAttrEffect.getLuckVal(bean.fromUnit)
            set fromUnitHuntEffectLuckDuring = hAttrEffect.getLuckDuring(bean.fromUnit)
            set fromUnitHuntEffectHuntAmplitudeVal = hAttrEffect.getHuntAmplitudeVal(bean.fromUnit)
            set fromUnitHuntEffectHuntAmplitudeDuring = hAttrEffect.getHuntAmplitudeDuring(bean.fromUnit)
            set fromUnitHuntEffectFireVal = hAttrEffect.getFireVal(bean.fromUnit)
            set fromUnitHuntEffectFireDuring = hAttrEffect.getFireDuring(bean.fromUnit)
            set fromUnitHuntEffectSoilVal = hAttrEffect.getSoilVal(bean.fromUnit)
            set fromUnitHuntEffectSoilDuring = hAttrEffect.getSoilDuring(bean.fromUnit)
            set fromUnitHuntEffectWaterVal = hAttrEffect.getWaterVal(bean.fromUnit)
            set fromUnitHuntEffectWaterDuring = hAttrEffect.getWaterDuring(bean.fromUnit)
            set fromUnitHuntEffectIceVal = hAttrEffect.getIceVal(bean.fromUnit)
            set fromUnitHuntEffectIceDuring = hAttrEffect.getIceDuring(bean.fromUnit)
            set fromUnitHuntEffectWindVal = hAttrEffect.getWindVal(bean.fromUnit)
            set fromUnitHuntEffectWindDuring = hAttrEffect.getWindDuring(bean.fromUnit)
            set fromUnitHuntEffectLightVal = hAttrEffect.getLightVal(bean.fromUnit)
            set fromUnitHuntEffectLightDuring = hAttrEffect.getLightDuring(bean.fromUnit)
            set fromUnitHuntEffectDarkVal = hAttrEffect.getDarkVal(bean.fromUnit)
            set fromUnitHuntEffectDarkDuring = hAttrEffect.getDarkDuring(bean.fromUnit)
            set fromUnitHuntEffectWoodVal = hAttrEffect.getWoodVal(bean.fromUnit)
            set fromUnitHuntEffectWoodDuring = hAttrEffect.getWoodDuring(bean.fromUnit)
            set fromUnitHuntEffectThunderVal = hAttrEffect.getThunderVal(bean.fromUnit)
            set fromUnitHuntEffectThunderDuring = hAttrEffect.getThunderDuring(bean.fromUnit)
            set fromUnitHuntEffectPoisonVal = hAttrEffect.getPoisonVal(bean.fromUnit)
            set fromUnitHuntEffectPoisonDuring = hAttrEffect.getPoisonDuring(bean.fromUnit)
            set fromUnitHuntEffectGhostVal = hAttrEffect.getGhostVal(bean.fromUnit)
            set fromUnitHuntEffectGhostDuring = hAttrEffect.getGhostDuring(bean.fromUnit)
            set fromUnitHuntEffectMetalVal = hAttrEffect.getMetalVal(bean.fromUnit)
            set fromUnitHuntEffectMetalDuring = hAttrEffect.getMetalDuring(bean.fromUnit)
            set fromUnitHuntEffectDragonVal = hAttrEffect.getDragonVal(bean.fromUnit)
            set fromUnitHuntEffectDragonDuring = hAttrEffect.getDragonDuring(bean.fromUnit)
            set fromUnitHuntEffectFireOpposeVal = hAttrEffect.getFireOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectFireOpposeDuring = hAttrEffect.getFireOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectSoilOpposeVal = hAttrEffect.getSoilOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectSoilOpposeDuring = hAttrEffect.getSoilOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectWaterOpposeVal = hAttrEffect.getWaterOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectWaterOpposeDuring = hAttrEffect.getWaterOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectIceOpposeVal = hAttrEffect.getIceOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectIceOpposeDuring = hAttrEffect.getIceOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectWindOpposeVal = hAttrEffect.getWindOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectWindOpposeDuring = hAttrEffect.getWindOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectLightOpposeVal = hAttrEffect.getLightOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectLightOpposeDuring = hAttrEffect.getLightOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectDarkOpposeVal = hAttrEffect.getDarkOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectDarkOpposeDuring = hAttrEffect.getDarkOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectWoodOpposeVal = hAttrEffect.getWoodOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectWoodOpposeDuring = hAttrEffect.getWoodOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectThunderOpposeVal = hAttrEffect.getThunderOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectThunderOpposeDuring = hAttrEffect.getThunderOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectPoisonOpposeVal = hAttrEffect.getPoisonOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectPoisonOpposeDuring = hAttrEffect.getPoisonOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectGhostOpposeVal = hAttrEffect.getGhostOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectGhostOpposeDuring = hAttrEffect.getGhostOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectMetalOpposeVal = hAttrEffect.getMetalOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectMetalOpposeDuring = hAttrEffect.getMetalOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectDragonOpposeVal = hAttrEffect.getDragonOpposeVal(bean.fromUnit)
            set fromUnitHuntEffectDragonOpposeDuring = hAttrEffect.getDragonOpposeDuring(bean.fromUnit)
            set fromUnitHuntEffectToxicVal = hAttrEffect.getToxicVal(bean.fromUnit)
            set fromUnitHuntEffectToxicDuring = hAttrEffect.getToxicDuring(bean.fromUnit)
            set fromUnitHuntEffectBurnVal = hAttrEffect.getBurnVal(bean.fromUnit)
            set fromUnitHuntEffectBurnDuring = hAttrEffect.getBurnDuring(bean.fromUnit)
            set fromUnitHuntEffectDryVal = hAttrEffect.getDryVal(bean.fromUnit)
            set fromUnitHuntEffectDryDuring = hAttrEffect.getDryDuring(bean.fromUnit)
            set fromUnitHuntEffectFreezeVal = hAttrEffect.getFreezeVal(bean.fromUnit)
            set fromUnitHuntEffectFreezeDuring = hAttrEffect.getFreezeDuring(bean.fromUnit)
            set fromUnitHuntEffectColdVal = hAttrEffect.getColdVal(bean.fromUnit)
            set fromUnitHuntEffectColdDuring = hAttrEffect.getColdDuring(bean.fromUnit)
            set fromUnitHuntEffectBluntVal = hAttrEffect.getBluntVal(bean.fromUnit)
            set fromUnitHuntEffectBluntDuring = hAttrEffect.getBluntDuring(bean.fromUnit)
            set fromUnitHuntEffectMuggleVal = hAttrEffect.getMuggleVal(bean.fromUnit)
            set fromUnitHuntEffectMuggleDuring = hAttrEffect.getMuggleDuring(bean.fromUnit)
            set fromUnitHuntEffectMyopiaVal = hAttrEffect.getMyopiaVal(bean.fromUnit)
            set fromUnitHuntEffectMyopiaDuring = hAttrEffect.getMyopiaDuring(bean.fromUnit)
            set fromUnitHuntEffectBlindVal = hAttrEffect.getBlindVal(bean.fromUnit)
            set fromUnitHuntEffectBlindDuring = hAttrEffect.getBlindDuring(bean.fromUnit)
            set fromUnitHuntEffectCorrosionVal = hAttrEffect.getCorrosionVal(bean.fromUnit)
            set fromUnitHuntEffectCorrosionDuring = hAttrEffect.getCorrosionDuring(bean.fromUnit)
            set fromUnitHuntEffectChaosVal = hAttrEffect.getChaosVal(bean.fromUnit)
            set fromUnitHuntEffectChaosDuring = hAttrEffect.getChaosDuring(bean.fromUnit)
            set fromUnitHuntEffectTwineVal = hAttrEffect.getTwineVal(bean.fromUnit)
            set fromUnitHuntEffectTwineDuring = hAttrEffect.getTwineDuring(bean.fromUnit)
            set fromUnitHuntEffectDrunkVal = hAttrEffect.getDrunkVal(bean.fromUnit)
            set fromUnitHuntEffectDrunkDuring = hAttrEffect.getDrunkDuring(bean.fromUnit)
            set fromUnitHuntEffectTortuaVal = hAttrEffect.getTortuaVal(bean.fromUnit)
            set fromUnitHuntEffectTortuaDuring = hAttrEffect.getTortuaDuring(bean.fromUnit)
            set fromUnitHuntEffectWeakVal = hAttrEffect.getWeakVal(bean.fromUnit)
            set fromUnitHuntEffectWeakDuring = hAttrEffect.getWeakDuring(bean.fromUnit)
            set fromUnitHuntEffectAstrictVal = hAttrEffect.getAstrictVal(bean.fromUnit)
            set fromUnitHuntEffectAstrictDuring = hAttrEffect.getAstrictDuring(bean.fromUnit)
            set fromUnitHuntEffectFoolishVal = hAttrEffect.getFoolishVal(bean.fromUnit)
            set fromUnitHuntEffectFoolishDuring = hAttrEffect.getFoolishDuring(bean.fromUnit)
            set fromUnitHuntEffectDullVal = hAttrEffect.getDullVal(bean.fromUnit)
            set fromUnitHuntEffectDullDuring = hAttrEffect.getDullDuring(bean.fromUnit)
            set fromUnitHuntEffectDirtVal = hAttrEffect.getDirtVal(bean.fromUnit)
            set fromUnitHuntEffectDirtDuring = hAttrEffect.getDirtDuring(bean.fromUnit)
            set fromUnitHuntEffectSwimOdds = hAttrEffect.getSwimOdds(bean.fromUnit)
            set fromUnitHuntEffectSwimDuring = hAttrEffect.getSwimDuring(bean.fromUnit)
            set fromUnitHuntEffectHeavyOdds = hAttrEffect.getHeavyOdds(bean.fromUnit)
            set fromUnitHuntEffectHeavyVal = hAttrEffect.getHeavyVal(bean.fromUnit)
            set fromUnitHuntEffectBreakOdds = hAttrEffect.getBreakOdds(bean.fromUnit)
            set fromUnitHuntEffectBreakDuring = hAttrEffect.getBreakDuring(bean.fromUnit)
            set fromUnitHuntEffectUnluckVal = hAttrEffect.getUnluckVal(bean.fromUnit)
            set fromUnitHuntEffectUnluckDuring = hAttrEffect.getUnluckDuring(bean.fromUnit)
            set fromUnitHuntEffectSilentOdds = hAttrEffect.getSilentOdds(bean.fromUnit)
            set fromUnitHuntEffectSilentDuring = hAttrEffect.getSilentDuring(bean.fromUnit)
            set fromUnitHuntEffectUnarmOdds = hAttrEffect.getUnarmOdds(bean.fromUnit)
            set fromUnitHuntEffectUnarmDuring = hAttrEffect.getUnarmDuring(bean.fromUnit)
            set fromUnitHuntEffectFetterOdds = hAttrEffect.getFetterOdds(bean.fromUnit)
            set fromUnitHuntEffectFetterDuring = hAttrEffect.getFetterDuring(bean.fromUnit)
            set fromUnitHuntEffectBombVal = hAttrEffect.getBombVal(bean.fromUnit)
            set fromUnitHuntEffectBombOdds = hAttrEffect.getBombOdds(bean.fromUnit)
            set fromUnitHuntEffectBombRange = hAttrEffect.getBombRange(bean.fromUnit)
            set fromUnitHuntEffectBombModel = hAttrEffect.getBombModel(bean.fromUnit)
            set fromUnitHuntEffectLightningChainVal = hAttrEffect.getLightningChainVal(bean.fromUnit)
            set fromUnitHuntEffectLightningChainOdds = hAttrEffect.getLightningChainOdds(bean.fromUnit)
            set fromUnitHuntEffectLightningChainQty = hAttrEffect.getLightningChainQty(bean.fromUnit)
            set fromUnitHuntEffectLightningChainReduce = hAttrEffect.getLightningChainReduce(bean.fromUnit)
            set fromUnitHuntEffectLightningChainModel = hAttrEffect.getLightningChainModel(bean.fromUnit)
            set fromUnitHuntEffectCrackFlyVal = hAttrEffect.getCrackFlyVal(bean.fromUnit)
            set fromUnitHuntEffectCrackFlyOdds = hAttrEffect.getCrackFlyOdds(bean.fromUnit)
            set fromUnitHuntEffectCrackFlyDistance = hAttrEffect.getCrackFlyDistance(bean.fromUnit)
            set fromUnitHuntEffectCrackFlyHigh = hAttrEffect.getCrackFlyHigh(bean.fromUnit)
            //获取受伤单位抵抗属性
            set toUnitDefend = hattr.getDefend(toUnit)
            set toUnitResistance = hattr.getResistance(toUnit)
            set toUnitToughness = hattr.getToughness(toUnit)
            set toUnitAvoid = hattr.getAvoid(toUnit)
            set toUnitLuck = hattr.getLuck(toUnit)
            set toUnitHuntRebound = hattr.getHuntRebound(toUnit)
            set toUnitKnockingOppose = hattr.getKnockingOppose(toUnit)
            set toUnitViolenceOppose = hattr.getViolenceOppose(toUnit)
            set toUnitHemophagiaOppose = hattr.getHemophagiaOppose(toUnit)
            set toUnitSplitOppose = hattr.getSplitOppose(toUnit)
            set toUnitPunishOppose = hattr.getPunishOppose(toUnit)
            set toUnitSwimOppose = hattr.getSwimOppose(toUnit)
            set toUnitHeavyOppose = hattr.getHeavyOppose(toUnit)
            set toUnitBreakOppose = hattr.getBreakOppose(toUnit)
            set toUnitUnluckOppose = hattr.getUnluckOppose(toUnit)
            set toUnitSilentOppose = hattr.getSilentOppose(toUnit)
            set toUnitUnarmOppose = hattr.getUnarmOppose(toUnit)
            set toUnitFetterOppose = hattr.getFetterOppose(toUnit)
            set toUnitBombOppose = hattr.getBombOppose(toUnit)
            set toUnitLightningChainOppose = hattr.getLightningChainOppose(toUnit)
            set toUnitCrackFlyOppose =hattr.getCrackFlyOppose(toUnit)
            set toUnitNaturalFireOppose = hattrNatural.getFireOppose(toUnit)
            set toUnitNaturalSoilOppose = hattrNatural.getSoilOppose(toUnit)
            set toUnitNaturalWaterOppose = hattrNatural.getWaterOppose(toUnit)
            set toUnitNaturalIceOppose = hattrNatural.getIceOppose(toUnit)
            set toUnitNaturalWindOppose = hattrNatural.getWindOppose(toUnit)
            set toUnitNaturalLightOppose = hattrNatural.getLightOppose(toUnit)
            set toUnitNaturalDarkOppose = hattrNatural.getDarkOppose(toUnit)
            set toUnitNaturalWoodOppose = hattrNatural.getWoodOppose(toUnit)
            set toUnitNaturalThunderOppose = hattrNatural.getThunderOppose(toUnit)
            set toUnitNaturalPoisonOppose = hattrNatural.getPoisonOppose(toUnit)
            set toUnitNaturalGhostOppose = hattrNatural.getGhostOppose(toUnit)
            set toUnitNaturalMetalOppose = hattrNatural.getMetalOppose(toUnit)
            set toUnitNaturalDragonOppose = hattrNatural.getDragonOppose(toUnit)

            //计算硬直抵抗
            set punishEffectRatio = 0.99
            if(toUnitPunishOppose>0)then
                set punishEffectRatio = punishEffectRatio-toUnitPunishOppose*0.01
                if(punishEffectRatio<0.100)then
                    set punishEffectRatio = 0.100
                endif
            endif

            //*重要* hjass必须设定护甲因子为0，这里为了修正魔兽负护甲依然因子保持0.06的bug
            //当护甲x为负时，最大-20,公式2-(1-a)^abs(x)
            if(toUnitDefend<0 and toUnitDefend>=-20)then
                set bean.damage =  bean.damage / (2-Pow(0.94,hlogic.rabs(toUnitDefend)))
            elseif(toUnitDefend<0 and toUnitDefend< -20)then
                set bean.damage =  bean.damage / (2-Pow(0.94,20))
            endif

            //赋值伤害
            set realDamage = bean.damage

            //计算物理攻击和魔法攻击的占比
            if(fromUnitAttackPhysical+fromUnitAttackMagic>0)then
                set fromUnitAttackPhysicalPercent = fromUnitAttackPhysical/(fromUnitAttackPhysical+fromUnitAttackMagic)
                set fromUnitAttackMagicPercent = fromUnitAttackMagic/(fromUnitAttackPhysical+fromUnitAttackMagic)
            endif

            //判断伤害类型
            if( bean.huntType=="physical" )then
                set fromUnitViolence = 0
            elseif( bean.huntType=="magic" )then
                set fromUnitKnocking = 0
            endif

            //判断无视Break 分为 null defend resistance both
            if( bean.isBreak == "defend" ) then
                //@触发无视护甲事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "breakDefend"
                set hevtBean.triggerUnit = fromUnit
                set hevtBean.targetUnit = toUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被无视护甲事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beBreakDefend"
                set hevtBean.triggerUnit = toUnit
                set hevtBean.sourceUnit = fromUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //
                if(toUnitDefend>0) then
                    set toUnitDefend = 0
                endif
                set realDamageString = realDamageString+"无视护甲"
                set realDamageStringColor = "f97373"
            elseif( bean.isBreak == "resistance" ) then
                //@触发无视魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "breakResistance"
                set hevtBean.triggerUnit = fromUnit
                set hevtBean.targetUnit = toUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitResistance
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被无视魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beBreakResistance"
                set hevtBean.triggerUnit = toUnit
                set hevtBean.sourceUnit = fromUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitResistance
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //
                if(toUnitResistance>0) then
                    set toUnitResistance = 0
                endif
                set realDamageString = realDamageString+"无视魔抗"
                set realDamageStringColor = "6fa8dc"
            elseif( bean.isBreak == "both" ) then
                //@触发同时无视护甲和魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "breakDefendAndResistance"
                set hevtBean.triggerUnit = fromUnit
                set hevtBean.targetUnit = toUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                set hevtBean.value2 = toUnitResistance
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被同时无视护甲和魔抗事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beBreakDefendAndResistance"
                set hevtBean.triggerUnit = toUnit
                set hevtBean.sourceUnit = fromUnit
                set hevtBean.breakType = bean.isBreak
                set hevtBean.value = toUnitDefend
                set hevtBean.value2 = toUnitResistance
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //
                if(toUnitDefend>0) then
                    set toUnitDefend = 0
                endif
                if(toUnitResistance>0) then
                    set toUnitResistance = 0
                endif
                set realDamageString = realDamageString+"无视防御"
                set realDamageStringColor = "8e7cc3"
            endif

            //判断无视回避
            if( bean.isNoAvoid == true ) then
                set toUnitAvoid = 0
                set realDamageString = realDamageString+"无视回避"
                set realDamageStringColor = "76a5af"
            endif

            //如果遇到真实伤害，无法回避
            if( hlogic.strpos(bean.huntType,"real")!=-1 )then
                set toUnitAvoid = 0
                set realDamageString = realDamageString+"真实"
            endif

            //如果遇到绝对伤害，无法回避
            if( hlogic.strpos(bean.huntType,"absolute")!=-1 )then
                set toUnitAvoid = 0
                set realDamageString = realDamageString+"绝对"
            endif

            //计算物理暴击,几率50000满100%，伤害每10000点增加5%
            if( hlogic.strpos(bean.huntType,"physical")!=-1 and (fromUnitKnocking-toUnitKnockingOppose)>0 and GetRandomInt(1, 1000)<=R2I((fromUnitKnocking-toUnitKnockingOppose)/50) ) then
                set realDamagePercent = realDamagePercent + fromUnitAttackPhysicalPercent * (fromUnitKnocking-toUnitKnockingOppose)*0.0005
                set toUnitAvoid = 0 //触发暴击，无法回避
                set isKnocking = true
            endif

            //计算魔法暴击,几率75000满100%，伤害每10000点增加8%
            if( hlogic.strpos(bean.huntType,"magic")!=-1 and (fromUnitViolence-toUnitViolenceOppose)>0 and GetRandomInt(1, 1000)<=R2I((fromUnitViolence-toUnitViolenceOppose)/75)) then
                set realDamagePercent = realDamagePercent + fromUnitAttackMagicPercent * (fromUnitViolence-toUnitViolenceOppose)*0.0008
                set toUnitAvoid = 0 //触发暴击，无法回避
                set isViolence = true
            endif

            //计算回避 X 命中
            if( bean.huntKind == "attack" and R2I(toUnitAvoid-fromUnitAim)>0 and GetRandomInt(1, 100)<=R2I(toUnitAvoid-fromUnitAim))then
                set isAvoid = true
                set realDamage = 0
                call hmsg.style(hmsg.ttg2Unit(toUnit,"回避",6.00,"5ef78e",10,1.00,10.00)  ,"scale",0,0.2)
                //@触发回避事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "avoid"
                set hevtBean.triggerUnit = toUnit
                set hevtBean.attacker = fromUnit
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被回避事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beAvoid"
                set hevtBean.triggerUnit = fromUnit
                set hevtBean.attacker = fromUnit
                set hevtBean.targetUnit = toUnit
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
            endif

            //计算伤害增幅
            if( realDamage > 0 and fromUnitHuntAmplitude != 0 ) then
                set realDamagePercent = realDamagePercent + fromUnitHuntAmplitude*0.01
            endif

            //计算自然属性
            if( realDamage > 0)then
                set fromUnitNaturalFire = fromUnitNaturalFire-toUnitNaturalFireOppose+10
                set fromUnitNaturalSoil = fromUnitNaturalSoil-toUnitNaturalSoilOppose+10
                set fromUnitNaturalWater = fromUnitNaturalWater-toUnitNaturalWaterOppose+10
                set fromUnitNaturalIce = fromUnitNaturalIce-toUnitNaturalIceOppose+10
                set fromUnitNaturalWind = fromUnitNaturalWind-toUnitNaturalWindOppose+10
                set fromUnitNaturalLight = fromUnitNaturalLight-toUnitNaturalLightOppose+10
                set fromUnitNaturalDark = fromUnitNaturalDark-toUnitNaturalDarkOppose+10
                set fromUnitNaturalWood = fromUnitNaturalWood-toUnitNaturalWoodOppose+10
                set fromUnitNaturalThunder = fromUnitNaturalThunder-toUnitNaturalThunderOppose+10
                set fromUnitNaturalPoison = fromUnitNaturalPoison-toUnitNaturalPoisonOppose+10
                set fromUnitNaturalGhost = fromUnitNaturalGhost-toUnitNaturalGhostOppose+10
                set fromUnitNaturalMetal = fromUnitNaturalMetal-toUnitNaturalMetalOppose+10
                set fromUnitNaturalDragon = fromUnitNaturalDragon-toUnitNaturalDragonOppose+10
                if(fromUnitNaturalFire < -100)then
                    set fromUnitNaturalFire = -100
                endif
                if(fromUnitNaturalSoil < -100)then
                    set fromUnitNaturalSoil = -100
                endif
                if(fromUnitNaturalWater < -100)then
                    set fromUnitNaturalWater = -100
                endif
                if(fromUnitNaturalIce < -100)then
                    set fromUnitNaturalIce = -100
                endif
                if(fromUnitNaturalWind < -100)then
                    set fromUnitNaturalWind = -100
                endif
                if(fromUnitNaturalLight < -100)then
                    set fromUnitNaturalLight = -100
                endif
                if(fromUnitNaturalDark < -100)then
                    set fromUnitNaturalDark = -100
                endif
                if(fromUnitNaturalWood < -100)then
                    set fromUnitNaturalWood = -100
                endif
                if(fromUnitNaturalThunder < -100)then
                    set fromUnitNaturalThunder = -100
                endif
                if(fromUnitNaturalPoison < -100)then
                    set fromUnitNaturalPoison = -100
                endif
                if(fromUnitNaturalGhost < -100)then
                    set fromUnitNaturalGhost = -100
                endif
                if(fromUnitNaturalMetal < -100)then
                    set fromUnitNaturalMetal = -100
                endif
                if(fromUnitNaturalDragon < -100)then
                    set fromUnitNaturalDragon = -100
                endif
                if( hlogic.strpos(bean.huntType,"fire")!=-1 and fromUnitNaturalFire!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalFire*0.01
                    set realDamageString = realDamageString+"火"
                    set realDamageStringColor = "f45454"
                    set fromUnitHuntEffectBurnVal = fromUnitHuntEffectBurnVal * (1.0+fromUnitNaturalFire*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"soil")!=-1 and fromUnitNaturalSoil!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalSoil*0.01
                    set realDamageString = realDamageString+"土"
                    set realDamageStringColor = "dbb745"
                    set fromUnitHuntEffectDirtVal = fromUnitHuntEffectDirtVal * (1.0+fromUnitNaturalSoil*0.01)
                    set fromUnitHuntEffectHeavyVal = fromUnitHuntEffectHeavyVal * (1.0+fromUnitNaturalSoil*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"water")!=-1 and fromUnitNaturalWater!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalWater*0.01
                    set realDamageString = realDamageString+"水"
                    set realDamageStringColor = "85adee"
                    set fromUnitHuntEffectFreezeDuring = fromUnitHuntEffectFreezeDuring * (1.0+fromUnitNaturalWater*0.01)
                    set fromUnitHuntEffectColdDuring = fromUnitHuntEffectColdDuring * (1.0+fromUnitNaturalWater*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"ice")!=-1 and fromUnitNaturalIce!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalIce*0.01
                    set realDamageString = realDamageString+"冰"
                    set realDamageStringColor = "85f4f4"
                    set fromUnitHuntEffectFreezeVal = fromUnitHuntEffectFreezeVal * (1.0+fromUnitNaturalIce*0.01)
                    set fromUnitHuntEffectColdVal = fromUnitHuntEffectColdVal * (1.0+fromUnitNaturalIce*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"wind")!=-1 and fromUnitNaturalWind!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalWind*0.01
                    set realDamageString = realDamageString+"风"
                    set realDamageStringColor = "b6d7a8"
                    set fromUnitHuntEffectCrackFlyVal = fromUnitHuntEffectCrackFlyVal * (1.0+fromUnitNaturalWind*0.01)
                    set fromUnitHuntEffectSwimDuring = fromUnitHuntEffectSwimDuring * (1.0+fromUnitNaturalWind*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"light")!=-1 and fromUnitNaturalLight!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalLight*0.01
                    set realDamageString = realDamageString+"光"
                    set realDamageStringColor = "f9f99c"
                    set fromUnitHuntEffectBlindDuring = fromUnitHuntEffectBlindDuring * (1.0+fromUnitNaturalLight*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"dark")!=-1 and fromUnitNaturalDark!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalDark*0.01
                    set realDamageString = realDamageString+"暗"
                    set realDamageStringColor = "383434"
                    set fromUnitHuntEffectCorrosionDuring = fromUnitHuntEffectCorrosionDuring * (1.0+fromUnitNaturalDark*0.01)
                    set fromUnitHuntEffectChaosDuring = fromUnitHuntEffectChaosDuring * (1.0+fromUnitNaturalDark*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"wood")!=-1 and fromUnitNaturalWood!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalWood*0.01
                    set realDamageString = realDamageString+"木"
                    set realDamageStringColor = "7cbd60"
                    set fromUnitHuntEffectTwineDuring = fromUnitHuntEffectTwineDuring * (1.0+fromUnitNaturalWood*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"thunder")!=-1 and fromUnitNaturalThunder!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalThunder*0.01
                    set realDamageString = realDamageString+"雷"
                    set realDamageStringColor = "7cbd60"
                    set fromUnitHuntEffectLightningChainVal = fromUnitHuntEffectLightningChainVal * (1.0+fromUnitNaturalThunder*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"poison")!=-1 and fromUnitNaturalPoison!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalPoison*0.01
                    set realDamageString = realDamageString+"毒"
                    set realDamageStringColor = "45f7f7"
                    set fromUnitHuntEffectToxicVal = fromUnitHuntEffectToxicVal * (1.0+fromUnitNaturalPoison*0.01)
                    set fromUnitHuntEffectWeakDuring = fromUnitHuntEffectWeakDuring * (1.0+fromUnitNaturalPoison*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"ghost")!=-1 and fromUnitNaturalGhost!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalGhost*0.01
                    set realDamageString = realDamageString+"鬼"
                    set realDamageStringColor = "383434"
                    set fromUnitHuntEffectUnluckVal = fromUnitHuntEffectUnluckVal * (1.0+fromUnitNaturalGhost*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"metal")!=-1 and fromUnitNaturalMetal!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalMetal*0.01
                    set realDamageString = realDamageString+"金"
                    set realDamageStringColor = "f9f99c"
                    set fromUnitHuntEffectHeavyVal = fromUnitHuntEffectHeavyVal * (1.0+fromUnitNaturalMetal*0.01)
                endif
                if( hlogic.strpos(bean.huntType,"dragon")!=-1 and fromUnitNaturalDragon!=0 )then
                    set realDamagePercent = realDamagePercent + fromUnitNaturalDragon*0.01
                    set realDamageString = realDamageString+"龙"
                    set realDamageStringColor = "7cbd60"
                    set fromUnitHuntEffectBombVal = fromUnitHuntEffectBombVal * (1.0+fromUnitNaturalDragon*0.01)
                endif
            endif
            

            //计算混合了物理的杂乱伤害，护甲效果减弱
            if( bean.huntType!="physical" and hlogic.strpos(bean.huntType,"physical")!=-1 and toUnitDefend>0 )then
                set toUnitDefend = toUnitDefend * fromUnitAttackPhysicalPercent
            endif
            //计算护甲
            if( hlogic.strpos(bean.huntType,"physical")!=-1 and toUnitDefend!=0 )then
                if(toUnitDefend>0)then
                    set realDamagePercent = realDamagePercent - toUnitDefend/(toUnitDefend+200)
                else
                    set realDamagePercent = realDamagePercent + -toUnitDefend/(-toUnitDefend+100)
                endif
            endif

            //计算混合了魔法的杂乱伤害，魔抗效果减弱
            if( bean.huntType!="magic" and hlogic.strpos(bean.huntType,"magic")!=-1 and toUnitResistance>0 )then
                set toUnitResistance = toUnitResistance * fromUnitAttackMagicPercent
            endif
            //计算魔抗
            if( hlogic.strpos(bean.huntType,"magic")!=-1 )then
                if( toUnitResistance!=0 )then
                    if(toUnitResistance>=100)then
                        set realDamage = realDamage * fromUnitAttackPhysicalPercent
                    else
                        set realDamagePercent = realDamagePercent - toUnitResistance*0.01
                    endif
                endif
            endif

            // 总结realDamagePercent
            set realDamage = realDamage * (1+realDamagePercent)

            //计算韧性
            if( toUnitToughness>0 )then
                if( (realDamage-toUnitToughness) < realDamage*0.1 )then
                    set realDamage = realDamage * 0.1
                else
                    set realDamage = realDamage - toUnitToughness
                endif
            endif

            // ------------------ TODO 上面都是先行计算 ------------------ 

            //造成伤害
            //call console.info("realDamage:"+R2S(realDamage))
            if( realDamage >= 1 ) then

                if(isKnocking)then
                    //@触发物理暴击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "knocking"
                    set hevtBean.triggerUnit = fromUnit
                    set hevtBean.targetUnit = toUnit
                    set hevtBean.damage = realDamage
                    set hevtBean.value = fromUnitKnocking/500
                    set hevtBean.value2 = fromUnitKnocking*0.05
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被物理暴击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beKnocking"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.damage = realDamage
                    set hevtBean.value = fromUnitKnocking/500
                    set hevtBean.value2 = fromUnitKnocking*0.05
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif
                if(isViolence)then
                    //@触发魔法暴击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "violence"
                    set hevtBean.triggerUnit = fromUnit
                    set hevtBean.targetUnit = toUnit
                    set hevtBean.damage = realDamage
                    set hevtBean.value = fromUnitKnocking/750
                    set hevtBean.value2 = fromUnitKnocking*0.08
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被魔法暴击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beViolence"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.damage = realDamage
                    set hevtBean.value = fromUnitKnocking/750
                    set hevtBean.value2 = fromUnitKnocking*0.08
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif

                //暴击文本加持
                if(isKnocking and isViolence)then
                    set realDamageString = realDamageString+"双暴击"
                    set realDamageStringColor = "b054ee"
                elseif(isKnocking)then
                    set realDamageString = realDamageString+"暴击"
                    set realDamageStringColor = "ef3215"
                elseif(isViolence)then
                    set realDamageString = realDamageString+"暴击"
                    set realDamageStringColor = "15bcef"
                endif
                //文本显示
                call hmsg.style(  hmsg.ttg2Unit(toUnit,realDamageString+I2S(R2I(realDamage)),6.00,realDamageStringColor,10,1.1,11.00)  ,"toggle",-0.05,0)

                call hevt.setLastDamageUnit(toUnit,fromUnit)
                call hplayer.addDamage(GetOwningPlayer(fromUnit),realDamage)
                call hplayer.addBeDamage(GetOwningPlayer(toUnit),realDamage)
                call hunit.subLife(toUnit,realDamage) //#

                if(bean.isNoAvoid==true)then
                    //@触发造成无法回避伤害事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "noAvoid"
                    set hevtBean.triggerUnit = fromUnit
                    set hevtBean.targetUnit = toUnit
                    set hevtBean.damage = realDamage
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被无法回避伤害事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beNoAvoid"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.damage = realDamage
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif

                if( bean.huntKind == "attack")then
                    //@触发攻击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "attack"
                    set hevtBean.triggerUnit = fromUnit
                    set hevtBean.attacker = fromUnit
                    set hevtBean.targetUnit = toUnit
                    set hevtBean.damage = bean.damage
                    set hevtBean.realDamage = realDamage
                    set hevtBean.damageKind = bean.huntKind
                    set hevtBean.damageType = bean.huntType
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被攻击事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beAttack"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.attacker = fromUnit
                    set hevtBean.damage = bean.damage
                    set hevtBean.realDamage = realDamage
                    set hevtBean.damageKind = bean.huntKind
                    set hevtBean.damageType = bean.huntType
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif

                //@触发伤害事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "damage"
                set hevtBean.triggerUnit = fromUnit
                set hevtBean.targetUnit = toUnit
                set hevtBean.sourceUnit = fromUnit
                set hevtBean.damage = bean.damage
                set hevtBean.realDamage = realDamage
                set hevtBean.damageKind = bean.huntKind
                set hevtBean.damageType = bean.huntType
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                //@触发被伤害事件
                set hevtBean = hEvtBean.create()
                set hevtBean.triggerKey = "beDamage"
                set hevtBean.triggerUnit = toUnit
                set hevtBean.sourceUnit = fromUnit
                set hevtBean.damage = bean.damage
                set hevtBean.realDamage = realDamage
                set hevtBean.damageKind = bean.huntKind
                set hevtBean.damageType = bean.huntType
                call hevt.triggerEvent(hevtBean)
                call hevtBean.destroy()
                
                //分裂
                if( bean.huntKind == "attack" and fromUnitSplit >0 )then
                    set loc = GetUnitLoc( toUnit )
                    set filter = hFilter.create()
                    call filter.isAlive(true)
                    call filter.isEnemy(true,fromUnit)
                    call filter.isBuilding(false)
                    set g = hgroup.createByLoc(loc,fromUnitSplitRange,function hFilter.get )
                    call filter.destroy()
                    call heffect.toLoc("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl",loc,0)
                    call RemoveLocation( loc )
                    loop
                        exitwhen(IsUnitGroupEmptyBJ(g) == true)
                            set u = FirstOfGroup(g)
                            call GroupRemoveUnit( g , u )
                            if(u!=toUnit and IsUnitEnemy(u,GetOwningPlayer(fromUnit)) == true) then
                                set huntBean = hAttrHuntBean.create()
                                set huntBean.fromUnit = fromUnit
                                set huntBean.toUnit = u
                                set huntBean.damage = realDamage * fromUnitSplit * 0.01
                                set huntBean.huntKind = "special"
                                set huntBean.huntType = "physical"
                                set huntBean.isBreak = "defend"
                                call thistype.huntUnit(huntBean)
                                call heffect.toUnitLoc("Abilities\\Spells\\Other\\Cleave\\CleaveDamageTarget.mdl",u,0)
                                call huntBean.destroy()
                            endif
                    endloop
                    call GroupClear(g)
                    call DestroyGroup(g)
                    set g = null

                    //@触发分裂事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "spilt"
                    set hevtBean.triggerUnit = fromUnit
                    set hevtBean.targetUnit = toUnit
                    set hevtBean.damage = realDamage * fromUnitSplit * 0.01
                    set hevtBean.range = fromUnitSplitRange
                    set hevtBean.value = fromUnitSplit
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被分裂事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beSpilt"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.damage = realDamage * fromUnitSplit * 0.01
                    set hevtBean.range = fromUnitSplitRange
                    set hevtBean.value = fromUnitSplit
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif
                //吸血
                set fromUnitHemophagia = fromUnitHemophagia-toUnitHemophagiaOppose
                if( bean.huntKind == "attack" and fromUnitHemophagia >0 )then
                    call hunit.addLife(fromUnit,realDamage * fromUnitHemophagia * 0.01)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",fromUnit,"origin",1.00)
                    //@触发吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "hemophagia"
                    set hevtBean.triggerUnit = fromUnit
                    set hevtBean.targetUnit = toUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagia * 0.01
                    set hevtBean.value = fromUnitHemophagia
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beHemophagia"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagia * 0.01
                    set hevtBean.value = fromUnitHemophagia
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif
                //技能吸血
                set fromUnitHemophagiaSkill = fromUnitHemophagiaSkill-toUnitHemophagiaOppose
                if( bean.huntKind == "skill" and fromUnitHemophagiaSkill >0 )then
                    call hunit.addLife(fromUnit,realDamage * fromUnitHemophagiaSkill * 0.01)
                    call heffect.toUnit("Abilities\\Spells\\Items\\HealingSalve\\HealingSalveTarget.mdl",fromUnit,"origin",1.8)
                    //@触发技能吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "skillHemophagia"
                    set hevtBean.triggerUnit = fromUnit
                    set hevtBean.targetUnit = toUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagiaSkill * 0.01
                    set hevtBean.value = fromUnitHemophagiaSkill
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                    //@触发被技能吸血事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "beSkillHemophagia"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.damage = realDamage * fromUnitHemophagiaSkill * 0.01
                    set hevtBean.value = fromUnitHemophagiaSkill
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif
                //硬直
                if( realDamage > 3 and his.alive(toUnit) and hattr.isPunishing(toUnit) != true and hunit.isOpenPunish(toUnit) )then
                    if( isEffect == true and fromUnitHuntEffectHeavyVal > 100 and GetRandomReal(1,100) <= fromUnitHuntEffectHeavyOdds ) then
                        set fromUnitPunishHeavy = fromUnitPunishHeavy * (fromUnitHuntEffectHeavyVal* 0.01)
                    endif
                    call hattr.subPunishCurrent(toUnit,realDamage*fromUnitPunishHeavy,0)

                    if(hattr.getPunishCurrent(toUnit) <= 0 ) then
                        call hattr.setPunishing(toUnit, 5.00 )
                        call hattr.setPunishCurrent(toUnit,hattr.getPunish(toUnit),0)
                        set punishEffect = (100 + hattr.getAttackSpeed(toUnit))*punishEffectRatio
                        if(punishEffect<1)then
                            set punishEffect = 1.00
                        endif
                        call hattr.subAttackSpeed( toUnit , punishEffect , 5.00 )
                        set punishEffect = hattr.getMove(toUnit)*punishEffectRatio
                        if(punishEffect<1)then
                            set punishEffect = 1.00
                        endif
                        call hattr.subMove( toUnit , punishEffect , 5.00 )
                        call hmsg.style(hmsg.ttg2Unit(toUnit,"僵硬",6.00,"c0c0c0",0,2.50,50.00)  ,"scale",0,0)

                        //@触发硬直事件
                        set hevtBean = hEvtBean.create()
                        set hevtBean.triggerKey = "punish"
                        set hevtBean.triggerUnit = toUnit
                        set hevtBean.sourceUnit = fromUnit
                        set hevtBean.value = punishEffect
                        set hevtBean.during = 5.00
                        call hevt.triggerEvent(hevtBean)
                        call hevtBean.destroy()

                    endif
                endif
                //反射
                if( toUnitHuntRebound >0 )then
                    call hunit.subLife(fromUnit,realDamage * toUnitHuntRebound * 0.01)
                    call hmsg.style(hmsg.ttg2Unit(fromUnit,"反伤"+R2S(realDamage*toUnitHuntRebound*0.01),10.00,"f8aaeb",10,1.00,10.00)  ,"shrink",-0.05,0)
                    //@触发反伤事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "rebound"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.damage = realDamage * toUnitHuntRebound * 0.01
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif
            endif

            //特殊效果,需要非无敌并处于效果启动状态下
            if( isEffect == true )then

                if( fromUnitHuntEffectLifeBackVal!=0 and fromUnitHuntEffectLifeBackDuring>0 ) then
                    call hattr.addLifeBack(bean.fromUnit,fromUnitHuntEffectLifeBackVal,fromUnitHuntEffectLifeBackDuring)
                endif
                if( fromUnitHuntEffectManaBackVal!=0 and fromUnitHuntEffectManaBackDuring>0 ) then
                    call hattr.addManaBack(bean.fromUnit,fromUnitHuntEffectManaBackVal,fromUnitHuntEffectManaBackDuring)
                endif
                if( fromUnitHuntEffectAttackSpeedVal!=0 and fromUnitHuntEffectAttackSpeedDuring>0 ) then
                    call hattr.addAttackSpeed(bean.fromUnit,fromUnitHuntEffectAttackSpeedVal,fromUnitHuntEffectAttackSpeedDuring)
                endif
                if( fromUnitHuntEffectAttackPhysicalVal!=0 and fromUnitHuntEffectAttackPhysicalDuring>0 ) then
                    call hattr.addAttackPhysical(bean.fromUnit,fromUnitHuntEffectAttackPhysicalVal,fromUnitHuntEffectAttackPhysicalDuring)
                endif
                if( fromUnitHuntEffectAttackMagicVal!=0 and fromUnitHuntEffectAttackMagicDuring>0 ) then
                    call hattr.addAttackMagic(bean.fromUnit,fromUnitHuntEffectAttackMagicVal,fromUnitHuntEffectAttackMagicDuring)
                endif
                if( fromUnitHuntEffectAttackRangeVal!=0 and fromUnitHuntEffectAttackRangeDuring>0 ) then
                    call hattr.addAttackRange(bean.fromUnit,fromUnitHuntEffectAttackRangeVal,fromUnitHuntEffectAttackRangeDuring)
                endif
                if( fromUnitHuntEffectSightVal!=0 and fromUnitHuntEffectSightDuring>0 ) then
                    call hattr.addSight(bean.fromUnit,fromUnitHuntEffectSightVal,fromUnitHuntEffectSightDuring)
                endif
                if( fromUnitHuntEffectMoveVal!=0 and fromUnitHuntEffectMoveDuring>0 ) then
                    call hattr.addMove(bean.fromUnit,fromUnitHuntEffectMoveVal,fromUnitHuntEffectMoveDuring)
                endif
                if( fromUnitHuntEffectAimVal!=0 and fromUnitHuntEffectAimDuring>0 ) then
                    call hattr.addAim(bean.fromUnit,fromUnitHuntEffectAimVal,fromUnitHuntEffectAimDuring)
                endif
                if( fromUnitHuntEffectStrVal!=0 and fromUnitHuntEffectStrDuring>0 ) then
                    call hattr.addStr(bean.fromUnit,fromUnitHuntEffectStrVal,fromUnitHuntEffectStrDuring)
                endif
                if( fromUnitHuntEffectAgiVal!=0 and fromUnitHuntEffectAgiDuring>0 ) then
                    call hattr.addAgi(bean.fromUnit,fromUnitHuntEffectAgiVal,fromUnitHuntEffectAgiDuring)
                endif
                if( fromUnitHuntEffectIntVal!=0 and fromUnitHuntEffectIntDuring>0 ) then
                    call hattr.addInt(bean.fromUnit,fromUnitHuntEffectIntVal,fromUnitHuntEffectIntDuring)
                endif
                if( fromUnitHuntEffectKnockingVal!=0 and fromUnitHuntEffectKnockingDuring>0 ) then
                    call hattr.addKnocking(bean.fromUnit,fromUnitHuntEffectKnockingVal,fromUnitHuntEffectKnockingDuring)
                endif
                if( fromUnitHuntEffectViolenceVal!=0 and fromUnitHuntEffectViolenceDuring>0 ) then
                    call hattr.addViolence(bean.fromUnit,fromUnitHuntEffectViolenceVal,fromUnitHuntEffectViolenceDuring)
                endif
                if( fromUnitHuntEffectHemophagiaVal!=0 and fromUnitHuntEffectHemophagiaDuring>0 ) then
                    call hattr.addHemophagia(bean.fromUnit,fromUnitHuntEffectHemophagiaVal,fromUnitHuntEffectHemophagiaDuring)
                endif
                if( fromUnitHuntEffectHemophagiaSkillVal!=0 and fromUnitHuntEffectHemophagiaSkillDuring>0 ) then
                    call hattr.addHemophagiaSkill(bean.fromUnit,fromUnitHuntEffectHemophagiaSkillVal,fromUnitHuntEffectHemophagiaSkillDuring)
                endif
                if( fromUnitHuntEffectSplitVal!=0 and fromUnitHuntEffectSplitDuring>0 ) then
                    call hattr.addSplit(bean.fromUnit,fromUnitHuntEffectSplitVal,fromUnitHuntEffectSplitDuring)
                endif
                if( fromUnitHuntEffectLuckVal!=0 and fromUnitHuntEffectLuckDuring>0 ) then
                    call hattr.addLuck(bean.fromUnit,fromUnitHuntEffectLuckVal,fromUnitHuntEffectLuckDuring)
                endif
                if( fromUnitHuntEffectHuntAmplitudeVal!=0 and fromUnitHuntEffectHuntAmplitudeDuring>0 ) then
                    call hattr.addHuntAmplitude(bean.fromUnit,fromUnitHuntEffectHuntAmplitudeVal,fromUnitHuntEffectHuntAmplitudeDuring)
                endif
                if( fromUnitHuntEffectFireVal!=0 and fromUnitHuntEffectFireDuring>0 ) then
                    call hattrNatural.addFire(bean.fromUnit,fromUnitHuntEffectFireVal,fromUnitHuntEffectFireDuring)
                endif
                if( fromUnitHuntEffectSoilVal!=0 and fromUnitHuntEffectSoilDuring>0 ) then
                    call hattrNatural.addSoil(bean.fromUnit,fromUnitHuntEffectSoilVal,fromUnitHuntEffectSoilDuring)
                endif
                if( fromUnitHuntEffectWaterVal!=0 and fromUnitHuntEffectWaterDuring>0 ) then
                    call hattrNatural.addWater(bean.fromUnit,fromUnitHuntEffectWaterVal,fromUnitHuntEffectWaterDuring)
                endif
                if( fromUnitHuntEffectIceVal!=0 and fromUnitHuntEffectIceDuring>0 ) then
                    call hattrNatural.addIce(bean.fromUnit,fromUnitHuntEffectIceVal,fromUnitHuntEffectIceDuring)
                endif
                if( fromUnitHuntEffectWindVal!=0 and fromUnitHuntEffectWindDuring>0 ) then
                    call hattrNatural.addWind(bean.fromUnit,fromUnitHuntEffectWindVal,fromUnitHuntEffectWindDuring)
                endif
                if( fromUnitHuntEffectLightVal!=0 and fromUnitHuntEffectLightDuring>0 ) then
                    call hattrNatural.addLight(bean.fromUnit,fromUnitHuntEffectLightVal,fromUnitHuntEffectLightDuring)
                endif
                if( fromUnitHuntEffectDarkVal!=0 and fromUnitHuntEffectDarkDuring>0 ) then
                    call hattrNatural.addDark(bean.fromUnit,fromUnitHuntEffectDarkVal,fromUnitHuntEffectDarkDuring)
                endif
                if( fromUnitHuntEffectWoodVal!=0 and fromUnitHuntEffectWoodDuring>0 ) then
                    call hattrNatural.addWood(bean.fromUnit,fromUnitHuntEffectWoodVal,fromUnitHuntEffectWoodDuring)
                endif
                if( fromUnitHuntEffectThunderVal!=0 and fromUnitHuntEffectThunderDuring>0 ) then
                    call hattrNatural.addThunder(bean.fromUnit,fromUnitHuntEffectThunderVal,fromUnitHuntEffectThunderDuring)
                endif
                if( fromUnitHuntEffectPoisonVal!=0 and fromUnitHuntEffectPoisonDuring>0 ) then
                    call hattrNatural.addPoison(bean.fromUnit,fromUnitHuntEffectPoisonVal,fromUnitHuntEffectPoisonDuring)
                endif
                if( fromUnitHuntEffectGhostVal!=0 and fromUnitHuntEffectGhostDuring>0 ) then
                    call hattrNatural.addGhost(bean.fromUnit,fromUnitHuntEffectGhostVal,fromUnitHuntEffectGhostDuring)
                endif
                if( fromUnitHuntEffectMetalVal!=0 and fromUnitHuntEffectMetalDuring>0 ) then
                    call hattrNatural.addMetal(bean.fromUnit,fromUnitHuntEffectMetalVal,fromUnitHuntEffectMetalDuring)
                endif
                if( fromUnitHuntEffectDragonVal!=0 and fromUnitHuntEffectDragonDuring>0 ) then
                    call hattrNatural.addDragon(bean.fromUnit,fromUnitHuntEffectDragonVal,fromUnitHuntEffectDragonDuring)
                endif
                if( fromUnitHuntEffectFireOpposeVal!=0 and fromUnitHuntEffectFireOpposeDuring>0 ) then
                    call hattrNatural.addFireOppose(bean.fromUnit,fromUnitHuntEffectFireOpposeVal,fromUnitHuntEffectFireOpposeDuring)
                endif
                if( fromUnitHuntEffectSoilOpposeVal!=0 and fromUnitHuntEffectSoilOpposeDuring>0 ) then
                    call hattrNatural.addSoilOppose(bean.fromUnit,fromUnitHuntEffectSoilOpposeVal,fromUnitHuntEffectSoilOpposeDuring)
                endif
                if( fromUnitHuntEffectWaterOpposeVal!=0 and fromUnitHuntEffectWaterOpposeDuring>0 ) then
                    call hattrNatural.addWaterOppose(bean.fromUnit,fromUnitHuntEffectWaterOpposeVal,fromUnitHuntEffectWaterOpposeDuring)
                endif
                if( fromUnitHuntEffectIceOpposeVal!=0 and fromUnitHuntEffectIceOpposeDuring>0 ) then
                    call hattrNatural.addIceOppose(bean.fromUnit,fromUnitHuntEffectIceOpposeVal,fromUnitHuntEffectIceOpposeDuring)
                endif
                if( fromUnitHuntEffectWindOpposeVal!=0 and fromUnitHuntEffectWindOpposeDuring>0 ) then
                    call hattrNatural.addWindOppose(bean.fromUnit,fromUnitHuntEffectWindOpposeVal,fromUnitHuntEffectWindOpposeDuring)
                endif
                if( fromUnitHuntEffectLightOpposeVal!=0 and fromUnitHuntEffectLightOpposeDuring>0 ) then
                    call hattrNatural.addLightOppose(bean.fromUnit,fromUnitHuntEffectLightOpposeVal,fromUnitHuntEffectLightOpposeDuring)
                endif
                if( fromUnitHuntEffectDarkOpposeVal!=0 and fromUnitHuntEffectDarkOpposeDuring>0 ) then
                    call hattrNatural.addDarkOppose(bean.fromUnit,fromUnitHuntEffectDarkOpposeVal,fromUnitHuntEffectDarkOpposeDuring)
                endif
                if( fromUnitHuntEffectWoodOpposeVal!=0 and fromUnitHuntEffectWoodOpposeDuring>0 ) then
                    call hattrNatural.addWoodOppose(bean.fromUnit,fromUnitHuntEffectWoodOpposeVal,fromUnitHuntEffectWoodOpposeDuring)
                endif
                if( fromUnitHuntEffectThunderOpposeVal!=0 and fromUnitHuntEffectThunderOpposeDuring>0 ) then
                    call hattrNatural.addThunderOppose(bean.fromUnit,fromUnitHuntEffectThunderOpposeVal,fromUnitHuntEffectThunderOpposeDuring)
                endif
                if( fromUnitHuntEffectPoisonOpposeVal!=0 and fromUnitHuntEffectPoisonOpposeDuring>0 ) then
                    call hattrNatural.addPoisonOppose(bean.fromUnit,fromUnitHuntEffectPoisonOpposeVal,fromUnitHuntEffectPoisonOpposeDuring)
                endif
                if( fromUnitHuntEffectGhostOpposeVal!=0 and fromUnitHuntEffectGhostOpposeDuring>0 ) then
                    call hattrNatural.addGhostOppose(bean.fromUnit,fromUnitHuntEffectGhostOpposeVal,fromUnitHuntEffectGhostOpposeDuring)
                endif
                if( fromUnitHuntEffectMetalOpposeVal!=0 and fromUnitHuntEffectMetalOpposeDuring>0 ) then
                    call hattrNatural.addMetalOppose(bean.fromUnit,fromUnitHuntEffectMetalOpposeVal,fromUnitHuntEffectMetalOpposeDuring)
                endif
                if( fromUnitHuntEffectDragonOpposeVal!=0 and fromUnitHuntEffectDragonOpposeDuring>0 ) then
                    call hattrNatural.addDragonOppose(bean.fromUnit,fromUnitHuntEffectDragonOpposeVal,fromUnitHuntEffectDragonOpposeDuring)
                endif
                // ------------
                if( fromUnitHuntEffectToxicVal!=0 and fromUnitHuntEffectToxicDuring>0 ) then
                    call hattr.subLifeBack(toUnit,fromUnitHuntEffectToxicVal,fromUnitHuntEffectToxicDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",toUnit,"origin",fromUnitHuntEffectToxicDuring)
                endif
                if( fromUnitHuntEffectBurnVal!=0 and fromUnitHuntEffectBurnDuring>0 ) then
                    call hattr.subLifeBack(toUnit,fromUnitHuntEffectBurnVal,fromUnitHuntEffectBurnDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl",toUnit,"origin",fromUnitHuntEffectBurnDuring)
                endif
                if( fromUnitHuntEffectDryVal!=0 and fromUnitHuntEffectDryDuring>0 ) then
                    call hattr.subManaBack(toUnit,fromUnitHuntEffectDryVal,fromUnitHuntEffectDryDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl",toUnit,"origin",fromUnitHuntEffectDryDuring)
                endif
                if( fromUnitHuntEffectFreezeVal!=0 and fromUnitHuntEffectFreezeDuring>0 ) then
                    call hattr.subAttackSpeed(toUnit,fromUnitHuntEffectFreezeVal,fromUnitHuntEffectFreezeDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\FrostDamage\\FrostDamage.mdl",toUnit,"foot",fromUnitHuntEffectFreezeDuring)
                endif
                if( fromUnitHuntEffectColdVal!=0 and fromUnitHuntEffectColdDuring>0 ) then
                    call hattr.subMove(toUnit,fromUnitHuntEffectColdVal,fromUnitHuntEffectColdDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\FrostDamage\\FrostDamage.mdl",toUnit,"origin",fromUnitHuntEffectColdDuring)
                endif
                if( fromUnitHuntEffectBluntVal!=0 and fromUnitHuntEffectBluntDuring>0 ) then
                    call hattr.subAttackPhysical(toUnit,fromUnitHuntEffectBluntVal,fromUnitHuntEffectBluntDuring)
                    call heffect.toUnit("Abilities\\Spells\\NightElf\\Barkskin\\BarkSkinTarget.mdl",toUnit,"origin",fromUnitHuntEffectBluntDuring)
                endif
                if( fromUnitHuntEffectMuggleVal!=0 and fromUnitHuntEffectMuggleDuring>0 ) then
                    call hattr.subAttackMagic(toUnit,fromUnitHuntEffectMuggleVal,fromUnitHuntEffectMuggleDuring)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\Cripple\\CrippleTarget.mdl",toUnit,"origin",fromUnitHuntEffectMuggleDuring)
                endif
                if( fromUnitHuntEffectMyopiaVal!=0 and fromUnitHuntEffectMyopiaDuring>0 ) then
                    call hattr.subAttackRange(toUnit,fromUnitHuntEffectMyopiaVal,fromUnitHuntEffectMyopiaDuring)
                    call heffect.toUnit("Abilities\\Spells\\Orc\\SpiritLink\\SpiritLinkTarget.mdl",toUnit,"weapon",fromUnitHuntEffectFetterDuring)
                endif
                if( fromUnitHuntEffectBlindVal!=0 and fromUnitHuntEffectBlindDuring>0 ) then
                    call hattr.subSight(toUnit,fromUnitHuntEffectBlindVal,fromUnitHuntEffectBlindDuring)
                    call heffect.toUnit("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl",toUnit,"origin",fromUnitHuntEffectBlindDuring)
                endif
                if( fromUnitHuntEffectCorrosionVal!=0 and fromUnitHuntEffectCorrosionDuring>0 ) then
                    call hattr.subDefend(toUnit,fromUnitHuntEffectCorrosionVal,fromUnitHuntEffectCorrosionDuring)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl",toUnit,"origin",fromUnitHuntEffectCorrosionDuring)
                endif
                if( fromUnitHuntEffectChaosVal!=0 and fromUnitHuntEffectChaosDuring>0 ) then
                    call hattr.subResistance(toUnit,fromUnitHuntEffectChaosVal,fromUnitHuntEffectChaosDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",toUnit,"origin",fromUnitHuntEffectChaosDuring)
                endif
                if( fromUnitHuntEffectTwineVal!=0 and fromUnitHuntEffectTwineDuring>0 ) then
                    call hattr.subAvoid(toUnit,fromUnitHuntEffectTwineVal,fromUnitHuntEffectTwineDuring)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\Web\\Web_AirTarget.mdl",toUnit,"origin",fromUnitHuntEffectTwineDuring)
                endif
                if( fromUnitHuntEffectDrunkVal!=0 and fromUnitHuntEffectDrunkDuring>0 ) then
                    call hattr.subAim(toUnit,fromUnitHuntEffectDrunkVal,fromUnitHuntEffectDrunkDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\StrongDrink\\BrewmasterTarget.mdl",toUnit,"head",fromUnitHuntEffectDrunkDuring)
                endif
                if( fromUnitHuntEffectTortuaVal!=0 and fromUnitHuntEffectTortuaDuring>0 ) then
                    call hattr.subToughness(toUnit,fromUnitHuntEffectTortuaVal,fromUnitHuntEffectTortuaDuring)
                    call heffect.toUnit("Abilities\\Spells\\Other\\Incinerate\\IncinerateBuff.mdl",toUnit,"origin",fromUnitHuntEffectTortuaDuring)
                endif
                if( fromUnitHuntEffectWeakVal!=0 and fromUnitHuntEffectWeakDuring>0 ) then
                    call hattr.subStr(toUnit,fromUnitHuntEffectWeakVal,fromUnitHuntEffectWeakDuring)
                    call heffect.toUnit("Units\\Undead\\PlagueCloud\\PlagueCloudtarget.mdl",toUnit,"head",fromUnitHuntEffectWeakDuring)
                endif
                if( fromUnitHuntEffectAstrictVal!=0 and fromUnitHuntEffectAstrictDuring>0 ) then
                    call hattr.subAgi(toUnit,fromUnitHuntEffectAstrictVal,fromUnitHuntEffectAstrictDuring)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\Sleep\\SleepSpecialArt.mdl",toUnit,"origin",fromUnitHuntEffectAstrictDuring)
                endif
                if( fromUnitHuntEffectFoolishVal!=0 and fromUnitHuntEffectFoolishDuring>0 ) then
                    call hattr.subInt(toUnit,fromUnitHuntEffectFoolishVal,fromUnitHuntEffectFoolishDuring)
                    call heffect.toUnit("Abilities\\Spells\\Undead\\Sleep\\SleepTarget.mdl",toUnit,"head",fromUnitHuntEffectFoolishDuring)
                endif
                if( fromUnitHuntEffectDullVal!=0 and fromUnitHuntEffectDullDuring>0 ) then
                    call hattr.subKnocking(toUnit,fromUnitHuntEffectDullVal,fromUnitHuntEffectDullDuring)
                    call heffect.toUnit("Abilities\\Spells\\NightElf\\Barkskin\\BarkSkinTarget.mdl",toUnit,"weapon",fromUnitHuntEffectDullDuring)
                endif
                if( fromUnitHuntEffectDirtVal!=0 and fromUnitHuntEffectDirtDuring>0 ) then
                    call hattr.subViolence(toUnit,fromUnitHuntEffectDirtVal,fromUnitHuntEffectDirtDuring)
                    call heffect.toUnit("Abilities\\Spells\\Items\\OrbCorruption\\OrbCorruptionSpecialArt.mdl",toUnit,"weapon",fromUnitHuntEffectDirtDuring)
                endif
                if( fromUnitHuntEffectSwimOdds>0 and fromUnitHuntEffectSwimDuring>=0.01 ) then
                    if(toUnitSwimOppose!=0)then
                        set fromUnitHuntEffectSwimOdds = fromUnitHuntEffectSwimOdds - toUnitSwimOppose
                        set fromUnitHuntEffectSwimDuring = fromUnitHuntEffectSwimDuring * (1-toUnitSwimOppose*0.01)
                    endif
                    if(GetRandomReal(1,100)<=fromUnitHuntEffectSwimOdds and fromUnitHuntEffectSwimDuring>=0.01)then
                        //@触发眩晕事件
                        set hevtBean = hEvtBean.create()
                        set hevtBean.triggerKey = "swim"
                        set hevtBean.triggerUnit = fromUnit
                        set hevtBean.targetUnit = toUnit
                        set hevtBean.value = fromUnitHuntEffectSwimOdds
                        set hevtBean.during = fromUnitHuntEffectSwimDuring
                        call hevt.triggerEvent(hevtBean)
                        call hevtBean.destroy()
                        //@触发被眩晕事件
                        set hevtBean = hEvtBean.create()
                        set hevtBean.triggerKey = "beSwim"
                        set hevtBean.triggerUnit = toUnit
                        set hevtBean.sourceUnit = fromUnit
                        set hevtBean.value = fromUnitHuntEffectSwimOdds
                        set hevtBean.during = fromUnitHuntEffectSwimDuring
                        call hevt.triggerEvent(hevtBean)
                        call hevtBean.destroy()
                        call hability.swim( toUnit , fromUnitHuntEffectSwimDuring )
                    endif
                endif
                if( GetRandomReal(1,100)<=(fromUnitHuntEffectBreakOdds-toUnitBreakOppose) and fromUnitHuntEffectBreakDuring>0 ) then
                    set punishEffect = hattr.getAttackSpeed(toUnit)*punishEffectRatio
                    if(punishEffect<1)then
                        set punishEffect = 1.00
                    endif
                    call hattr.subAttackSpeed( toUnit , punishEffect , 5.00 )
                    set punishEffect = hattr.getMove(toUnit)*punishEffectRatio
                    if(punishEffect<1)then
                        set punishEffect = 1.00
                    endif
                    call hattr.subMove( toUnit , punishEffect , 5.00 )
                    //@触发硬直事件
                    set hevtBean = hEvtBean.create()
                    set hevtBean.triggerKey = "punish"
                    set hevtBean.triggerUnit = toUnit
                    set hevtBean.sourceUnit = fromUnit
                    set hevtBean.value = punishEffect
                    set hevtBean.during = fromUnitHuntEffectBreakDuring
                    call hevt.triggerEvent(hevtBean)
                    call hevtBean.destroy()
                endif
                if( fromUnitHuntEffectUnluckVal!=0 and fromUnitHuntEffectUnluckDuring>0 ) then
                    set fromUnitHuntEffectUnluckVal = fromUnitHuntEffectUnluckVal * (1 - toUnitSilentOppose * 0.01) // 不幸抵抗
                    call hattr.subLuck(toUnit,fromUnitHuntEffectUnluckVal,fromUnitHuntEffectUnluckDuring)
                endif
                if( GetRandomReal(1,100)<=(fromUnitHuntEffectSilentOdds-toUnitSilentOppose) and fromUnitHuntEffectSilentDuring>0 ) then
                    call hability.silent(toUnit,fromUnitHuntEffectSilentDuring)
                endif
                if( GetRandomReal(1,100)<=(fromUnitHuntEffectUnarmOdds-toUnitUnarmOppose) and fromUnitHuntEffectUnarmDuring>0 ) then
                    call hability.unarm(toUnit,fromUnitHuntEffectUnarmDuring)
                endif
                if( GetRandomReal(1,100)<=(fromUnitHuntEffectFetterOdds-toUnitFetterOppose) and fromUnitHuntEffectFetterDuring>0 ) then
                    call hattr.subMove(toUnit,1000,fromUnitHuntEffectFetterDuring)
                    call heffect.toUnit("Abilities\\Spells\\Orc\\SpiritLink\\SpiritLinkTarget.mdl",toUnit,"origin",fromUnitHuntEffectFetterDuring)
                endif
                if( GetRandomReal(1,100)<=(fromUnitHuntEffectBombOdds-toUnitBombOppose) and fromUnitHuntEffectBombVal!=0 and fromUnitHuntEffectBombRange>0 and his.silent(fromUnit) == false ) then
                    if(fromUnitHuntEffectBombModel=="")then
                        set fromUnitHuntEffectBombModel = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
                    endif
                    call heffect.toUnitLoc(fromUnitHuntEffectBombModel,toUnit,0)
                    set filter = hFilter.create()
                    call filter.isEnemy(true,fromUnit)
                    call filter.isBuilding(false)
                    set g = hgroup.createByUnit(toUnit,fromUnitHuntEffectBombRange,function hFilter.get)
                    call filter.destroy()
                    loop
                        exitwhen(IsUnitGroupEmptyBJ(g) == true)
                            set u = FirstOfGroup(g)
                            call GroupRemoveUnit( g , u )
                            if( IsUnitAliveBJ(u) )then
                                set huntBean = hAttrHuntBean.create()
                                set huntBean.fromUnit = fromUnit
                                set huntBean.toUnit = u
                                set huntBean.damage = fromUnitHuntEffectBombVal
                                set huntBean.huntKind = "special"
                                set huntBean.huntType = bean.huntType
                                call thistype.huntUnit(huntBean)
                                call huntBean.destroy()
                            endif
                    endloop
                    call GroupClear( g )
                    call DestroyGroup( g )
                    set g = null
                    set u = null
                endif
                if( GetRandomReal(1,100)<=(fromUnitHuntEffectLightningChainOdds-toUnitLightningChainOppose) and fromUnitHuntEffectLightningChainVal!=0 and fromUnitHuntEffectLightningChainQty>0 and his.silent(fromUnit) == false ) then
                    if(fromUnitHuntEffectLightningChainModel=="")then
                        set fromUnitHuntEffectLightningChainModel = "Abilities\\Weapons\\Bolt\\BoltImpact.mdl"
                    endif
                    set huntBean = hAttrHuntBean.create()
                    set huntBean.fromUnit = fromUnit
                    set huntBean.toUnit = toUnit
                    set huntBean.damage = fromUnitHuntEffectLightningChainVal
                    set huntBean.huntEff = fromUnitHuntEffectLightningChainModel
                    set huntBean.huntKind = "special"
                    set huntBean.huntType = "magicthunder"
                    call hskill.lightningChain(lightningCode_shandianlian_ci,R2I(fromUnitHuntEffectLightningChainQty),fromUnitHuntEffectLightningChainReduce,false,huntBean)
                    call huntBean.destroy()
                endif
                if( GetRandomReal(1,100)<=(fromUnitHuntEffectCrackFlyOdds-toUnitCrackFlyOppose) and fromUnitHuntEffectCrackFlyVal!=0 and his.building(toUnit) == false and his.silent(fromUnit) == false ) then
                    set huntBean = hAttrHuntBean.create()
                    set huntBean.fromUnit = fromUnit
                    set huntBean.toUnit = toUnit
                    set huntBean.damage = fromUnitHuntEffectCrackFlyVal
                    //set huntBean.huntEff = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl"
                    set huntBean.huntKind = "special"
                    set huntBean.huntType = "physical"
                    call hskill.crackFly(fromUnitHuntEffectCrackFlyDistance,fromUnitHuntEffectCrackFlyHigh,0.6,huntBean)
                    call huntBean.destroy()
                endif
            endif
        endif
        // clear
        set fromUnit = null
        set toUnit = null
        set realDamageString = null
        set realDamageStringColor = null
    	set loc = null
    	set g = null
    	set u = null
        set fromUnitHuntEffectBombModel = null
        set fromUnitHuntEffectLightningChainModel = null
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
        set g = CreateGroup()
        call GroupAddGroup(bean.whichGroup,g)
    	loop
            exitwhen(IsUnitGroupEmptyBJ(g) == true)
                set u = FirstOfGroup(g)
                call GroupRemoveUnit( g , u )
                if(IsUnitEnemy(u,GetOwningPlayer(bean.fromUnit))==true and (bean.whichGroupRepeat==null or IsUnitInGroup(u,bean.whichGroupRepeat)==false)) then
                    set bean.toUnit = u
                    call thistype.huntUnit(bean)
                endif
                if( bean.whichGroupRepeat != null) then
                	call GroupAddUnit( bean.whichGroupRepeat,u )
                endif
                set u = null
        endloop
        call GroupClear(g)
        call DestroyGroup(g)
        set g = null
    endmethod

endstruct
