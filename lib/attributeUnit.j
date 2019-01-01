//属性 - 单位

globals
	hAttrUnit hattrUnit
	hashtable hash_attr_unit = null
	boolean PUNISH_SWITCH = false 			//有的游戏不需要硬直条就把他关闭
	boolean PUNISH_SWITCH_ONLYHERO = true 	//是否只有英雄有硬直条
	real PUNISH_TEXTTAG_HEIGHT = 0
	trigger ATTR_TRIGGER_UNIT_BEHUNT = null
	trigger ATTR_TRIGGER_UNIT_DEATH = null
	boolean allowDenied = false
endglobals

struct hAttrUnit

	static method create takes nothing returns hAttrUnit
        local hAttrUnit x = 0
        set x = hAttrUnit.allocate()
        return x
    endmethod

	public static method setAllowDenied takes boolean b returns nothing
		set allowDenied = b
	endmethod

	public static method getAllowDenied takes nothing returns boolean
		return allowDenied
	endmethod

	//根据bean修改单位属性
	public static method modifyAttrByBean takes unit whichUnit,hAttrBean bean,real during returns nothing
		if(bean.attackHuntType!="")then
			call hattr.setAttackHuntType(whichUnit,bean.attackHuntType,during)
		endif
		//COPY
if(bean.goldRatio>0)then
    call hplayer.addGoldRatio(GetOwningPlayer(whichUnit),bean.goldRatio,during)
elseif(bean.goldRatio<0)then
    call hplayer.subGoldRatio(GetOwningPlayer(whichUnit),bean.goldRatio,during)
endif
if(bean.lumberRatio>0)then
    call hplayer.addLumberRatio(GetOwningPlayer(whichUnit),bean.lumberRatio,during)
elseif(bean.lumberRatio<0)then
    call hplayer.subLumberRatio(GetOwningPlayer(whichUnit),bean.lumberRatio,during)
endif
if(bean.expRatio>0)then
    call hplayer.addExpRatio(GetOwningPlayer(whichUnit),bean.expRatio,during)
elseif(bean.expRatio<0)then
    call hplayer.subExpRatio(GetOwningPlayer(whichUnit),bean.expRatio,during)
endif
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
if(bean.defend >0)then
    call hattr.addDefend (whichUnit,bean.defend ,during)
elseif(bean.defend <0)then
    call hattr.subDefend (whichUnit,bean.defend ,during)
endif
if(bean.attackSpeed>0)then
    call hattr.addAttackSpeed(whichUnit,bean.attackSpeed,during)
elseif(bean.attackSpeed<0)then
    call hattr.subAttackSpeed(whichUnit,bean.attackSpeed,during)
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
if(bean.attackRange>0)then
    call hattr.addAttackRange(whichUnit,bean.attackRange,during)
elseif(bean.attackRange<0)then
    call hattr.subAttackRange(whichUnit,bean.attackRange,during)
endif
if(bean.sight>0)then
    call hattr.addSight(whichUnit,bean.sight,during)
elseif(bean.sight<0)then
    call hattr.subSight(whichUnit,bean.sight,during)
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
if(bean.knockingOppose>0)then
    call hattr.addKnockingOppose(whichUnit,bean.knockingOppose,during)
elseif(bean.knockingOppose<0)then
    call hattr.subKnockingOppose(whichUnit,bean.knockingOppose,during)
endif
if(bean.violenceOppose>0)then
    call hattr.addViolenceOppose(whichUnit,bean.violenceOppose,during)
elseif(bean.violenceOppose<0)then
    call hattr.subViolenceOppose(whichUnit,bean.violenceOppose,during)
endif
if(bean.hemophagiaOppose>0)then
    call hattr.addHemophagiaOppose(whichUnit,bean.hemophagiaOppose,during)
elseif(bean.hemophagiaOppose<0)then
    call hattr.subHemophagiaOppose(whichUnit,bean.hemophagiaOppose,during)
endif
if(bean.splitOppose>0)then
    call hattr.addSplitOppose(whichUnit,bean.splitOppose,during)
elseif(bean.splitOppose<0)then
    call hattr.subSplitOppose(whichUnit,bean.splitOppose,during)
endif
if(bean.punishOppose>0)then
    call hattr.addPunishOppose(whichUnit,bean.punishOppose,during)
elseif(bean.punishOppose<0)then
    call hattr.subPunishOppose(whichUnit,bean.punishOppose,during)
endif
if(bean.huntReboundOppose>0)then
    call hattr.addHuntReboundOppose(whichUnit,bean.huntReboundOppose,during)
elseif(bean.huntReboundOppose<0)then
    call hattr.subHuntReboundOppose(whichUnit,bean.huntReboundOppose,during)
endif
if(bean.swimOppose>0)then
    call hattr.addSwimOppose(whichUnit,bean.swimOppose,during)
elseif(bean.swimOppose<0)then
    call hattr.subSwimOppose(whichUnit,bean.swimOppose,during)
endif
if(bean.heavyOppose>0)then
    call hattr.addHeavyOppose(whichUnit,bean.heavyOppose,during)
elseif(bean.heavyOppose<0)then
    call hattr.subHeavyOppose(whichUnit,bean.heavyOppose,during)
endif
if(bean.breakOppose>0)then
    call hattr.addBreakOppose(whichUnit,bean.breakOppose,during)
elseif(bean.breakOppose<0)then
    call hattr.subBreakOppose(whichUnit,bean.breakOppose,during)
endif
if(bean.unluckOppose>0)then
    call hattr.addUnluckOppose(whichUnit,bean.unluckOppose,during)
elseif(bean.unluckOppose<0)then
    call hattr.subUnluckOppose(whichUnit,bean.unluckOppose,during)
endif
if(bean.silentOppose>0)then
    call hattr.addSilentOppose(whichUnit,bean.silentOppose,during)
elseif(bean.silentOppose<0)then
    call hattr.subSilentOppose(whichUnit,bean.silentOppose,during)
endif
if(bean.unarmOppose>0)then
    call hattr.addUnarmOppose(whichUnit,bean.unarmOppose,during)
elseif(bean.unarmOppose<0)then
    call hattr.subUnarmOppose(whichUnit,bean.unarmOppose,during)
endif
if(bean.fetterOppose>0)then
    call hattr.addFetterOppose(whichUnit,bean.fetterOppose,during)
elseif(bean.fetterOppose<0)then
    call hattr.subFetterOppose(whichUnit,bean.fetterOppose,during)
endif
if(bean.bombOppose>0)then
    call hattr.addBombOppose(whichUnit,bean.bombOppose,during)
elseif(bean.bombOppose<0)then
    call hattr.subBombOppose(whichUnit,bean.bombOppose,during)
endif
if(bean.lightningChainOppose>0)then
    call hattr.addLightningChainOppose(whichUnit,bean.lightningChainOppose,during)
elseif(bean.lightningChainOppose<0)then
    call hattr.subLightningChainOppose(whichUnit,bean.lightningChainOppose,during)
endif
if(bean.crackFlyOppose>0)then
    call hattr.addCrackFlyOppose(whichUnit,bean.crackFlyOppose,during)
elseif(bean.crackFlyOppose<0)then
    call hattr.subCrackFlyOppose(whichUnit,bean.crackFlyOppose,during)
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
 if(bean.lifeBackVal>0)then
    call hattrEffect.addLifeBackVal(whichUnit,bean.lifeBackVal,during)
elseif(bean.lifeBackVal<0)then
    call hattrEffect.subLifeBackVal(whichUnit,bean.lifeBackVal,during)
endif
 if(bean.lifeBackDuring>0)then
    call hattrEffect.addLifeBackDuring(whichUnit,bean.lifeBackDuring,during)
elseif(bean.lifeBackDuring<0)then
    call hattrEffect.subLifeBackDuring(whichUnit,bean.lifeBackDuring,during)
endif
 if(bean.manaBackVal>0)then
    call hattrEffect.addManaBackVal(whichUnit,bean.manaBackVal,during)
elseif(bean.manaBackVal<0)then
    call hattrEffect.subManaBackVal(whichUnit,bean.manaBackVal,during)
endif
 if(bean.manaBackDuring>0)then
    call hattrEffect.addManaBackDuring(whichUnit,bean.manaBackDuring,during)
elseif(bean.manaBackDuring<0)then
    call hattrEffect.subManaBackDuring(whichUnit,bean.manaBackDuring,during)
endif
 if(bean.attackSpeedVal>0)then
    call hattrEffect.addAttackSpeedVal(whichUnit,bean.attackSpeedVal,during)
elseif(bean.attackSpeedVal<0)then
    call hattrEffect.subAttackSpeedVal(whichUnit,bean.attackSpeedVal,during)
endif
 if(bean.attackSpeedDuring>0)then
    call hattrEffect.addAttackSpeedDuring(whichUnit,bean.attackSpeedDuring,during)
elseif(bean.attackSpeedDuring<0)then
    call hattrEffect.subAttackSpeedDuring(whichUnit,bean.attackSpeedDuring,during)
endif
 if(bean.attackPhysicalVal>0)then
    call hattrEffect.addAttackPhysicalVal(whichUnit,bean.attackPhysicalVal,during)
elseif(bean.attackPhysicalVal<0)then
    call hattrEffect.subAttackPhysicalVal(whichUnit,bean.attackPhysicalVal,during)
endif
 if(bean.attackPhysicalDuring>0)then
    call hattrEffect.addAttackPhysicalDuring(whichUnit,bean.attackPhysicalDuring,during)
elseif(bean.attackPhysicalDuring<0)then
    call hattrEffect.subAttackPhysicalDuring(whichUnit,bean.attackPhysicalDuring,during)
endif
 if(bean.attackMagicVal>0)then
    call hattrEffect.addAttackMagicVal(whichUnit,bean.attackMagicVal,during)
elseif(bean.attackMagicVal<0)then
    call hattrEffect.subAttackMagicVal(whichUnit,bean.attackMagicVal,during)
endif
 if(bean.attackMagicDuring>0)then
    call hattrEffect.addAttackMagicDuring(whichUnit,bean.attackMagicDuring,during)
elseif(bean.attackMagicDuring<0)then
    call hattrEffect.subAttackMagicDuring(whichUnit,bean.attackMagicDuring,during)
endif
 if(bean.attackRangeVal>0)then
    call hattrEffect.addAttackRangeVal(whichUnit,bean.attackRangeVal,during)
elseif(bean.attackRangeVal<0)then
    call hattrEffect.subAttackRangeVal(whichUnit,bean.attackRangeVal,during)
endif
 if(bean.attackRangeDuring>0)then
    call hattrEffect.addAttackRangeDuring(whichUnit,bean.attackRangeDuring,during)
elseif(bean.attackRangeDuring<0)then
    call hattrEffect.subAttackRangeDuring(whichUnit,bean.attackRangeDuring,during)
endif
 if(bean.sightVal>0)then
    call hattrEffect.addSightVal(whichUnit,bean.sightVal,during)
elseif(bean.sightVal<0)then
    call hattrEffect.subSightVal(whichUnit,bean.sightVal,during)
endif
 if(bean.sightDuring>0)then
    call hattrEffect.addSightDuring(whichUnit,bean.sightDuring,during)
elseif(bean.sightDuring<0)then
    call hattrEffect.subSightDuring(whichUnit,bean.sightDuring,during)
endif
 if(bean.moveVal>0)then
    call hattrEffect.addMoveVal(whichUnit,bean.moveVal,during)
elseif(bean.moveVal<0)then
    call hattrEffect.subMoveVal(whichUnit,bean.moveVal,during)
endif
 if(bean.moveDuring>0)then
    call hattrEffect.addMoveDuring(whichUnit,bean.moveDuring,during)
elseif(bean.moveDuring<0)then
    call hattrEffect.subMoveDuring(whichUnit,bean.moveDuring,during)
endif
 if(bean.aimVal>0)then
    call hattrEffect.addAimVal(whichUnit,bean.aimVal,during)
elseif(bean.aimVal<0)then
    call hattrEffect.subAimVal(whichUnit,bean.aimVal,during)
endif
 if(bean.aimDuring>0)then
    call hattrEffect.addAimDuring(whichUnit,bean.aimDuring,during)
elseif(bean.aimDuring<0)then
    call hattrEffect.subAimDuring(whichUnit,bean.aimDuring,during)
endif
 if(bean.strVal>0)then
    call hattrEffect.addStrVal(whichUnit,bean.strVal,during)
elseif(bean.strVal<0)then
    call hattrEffect.subStrVal(whichUnit,bean.strVal,during)
endif
 if(bean.strDuring>0)then
    call hattrEffect.addStrDuring(whichUnit,bean.strDuring,during)
elseif(bean.strDuring<0)then
    call hattrEffect.subStrDuring(whichUnit,bean.strDuring,during)
endif
 if(bean.agiVal>0)then
    call hattrEffect.addAgiVal(whichUnit,bean.agiVal,during)
elseif(bean.agiVal<0)then
    call hattrEffect.subAgiVal(whichUnit,bean.agiVal,during)
endif
 if(bean.agiDuring>0)then
    call hattrEffect.addAgiDuring(whichUnit,bean.agiDuring,during)
elseif(bean.agiDuring<0)then
    call hattrEffect.subAgiDuring(whichUnit,bean.agiDuring,during)
endif
 if(bean.intVal>0)then
    call hattrEffect.addIntVal(whichUnit,bean.intVal,during)
elseif(bean.intVal<0)then
    call hattrEffect.subIntVal(whichUnit,bean.intVal,during)
endif
 if(bean.intDuring>0)then
    call hattrEffect.addIntDuring(whichUnit,bean.intDuring,during)
elseif(bean.intDuring<0)then
    call hattrEffect.subIntDuring(whichUnit,bean.intDuring,during)
endif
 if(bean.knockingVal>0)then
    call hattrEffect.addKnockingVal(whichUnit,bean.knockingVal,during)
elseif(bean.knockingVal<0)then
    call hattrEffect.subKnockingVal(whichUnit,bean.knockingVal,during)
endif
 if(bean.knockingDuring>0)then
    call hattrEffect.addKnockingDuring(whichUnit,bean.knockingDuring,during)
elseif(bean.knockingDuring<0)then
    call hattrEffect.subKnockingDuring(whichUnit,bean.knockingDuring,during)
endif
 if(bean.violenceVal>0)then
    call hattrEffect.addViolenceVal(whichUnit,bean.violenceVal,during)
elseif(bean.violenceVal<0)then
    call hattrEffect.subViolenceVal(whichUnit,bean.violenceVal,during)
endif
 if(bean.violenceDuring>0)then
    call hattrEffect.addViolenceDuring(whichUnit,bean.violenceDuring,during)
elseif(bean.violenceDuring<0)then
    call hattrEffect.subViolenceDuring(whichUnit,bean.violenceDuring,during)
endif
 if(bean.hemophagiaVal>0)then
    call hattrEffect.addHemophagiaVal(whichUnit,bean.hemophagiaVal,during)
elseif(bean.hemophagiaVal<0)then
    call hattrEffect.subHemophagiaVal(whichUnit,bean.hemophagiaVal,during)
endif
 if(bean.hemophagiaDuring>0)then
    call hattrEffect.addHemophagiaDuring(whichUnit,bean.hemophagiaDuring,during)
elseif(bean.hemophagiaDuring<0)then
    call hattrEffect.subHemophagiaDuring(whichUnit,bean.hemophagiaDuring,during)
endif
 if(bean.hemophagiaSkillVal>0)then
    call hattrEffect.addHemophagiaSkillVal(whichUnit,bean.hemophagiaSkillVal,during)
elseif(bean.hemophagiaSkillVal<0)then
    call hattrEffect.subHemophagiaSkillVal(whichUnit,bean.hemophagiaSkillVal,during)
endif
 if(bean.hemophagiaSkillDuring>0)then
    call hattrEffect.addHemophagiaSkillDuring(whichUnit,bean.hemophagiaSkillDuring,during)
elseif(bean.hemophagiaSkillDuring<0)then
    call hattrEffect.subHemophagiaSkillDuring(whichUnit,bean.hemophagiaSkillDuring,during)
endif
 if(bean.splitVal>0)then
    call hattrEffect.addSplitVal(whichUnit,bean.splitVal,during)
elseif(bean.splitVal<0)then
    call hattrEffect.subSplitVal(whichUnit,bean.splitVal,during)
endif
 if(bean.splitDuring>0)then
    call hattrEffect.addSplitDuring(whichUnit,bean.splitDuring,during)
elseif(bean.splitDuring<0)then
    call hattrEffect.subSplitDuring(whichUnit,bean.splitDuring,during)
endif
 if(bean.luckVal>0)then
    call hattrEffect.addLuckVal(whichUnit,bean.luckVal,during)
elseif(bean.luckVal<0)then
    call hattrEffect.subLuckVal(whichUnit,bean.luckVal,during)
endif
 if(bean.luckDuring>0)then
    call hattrEffect.addLuckDuring(whichUnit,bean.luckDuring,during)
elseif(bean.luckDuring<0)then
    call hattrEffect.subLuckDuring(whichUnit,bean.luckDuring,during)
endif
 if(bean.huntAmplitudeVal>0)then
    call hattrEffect.addHuntAmplitudeVal(whichUnit,bean.huntAmplitudeVal,during)
elseif(bean.huntAmplitudeVal<0)then
    call hattrEffect.subHuntAmplitudeVal(whichUnit,bean.huntAmplitudeVal,during)
endif
 if(bean.huntAmplitudeDuring>0)then
    call hattrEffect.addHuntAmplitudeDuring(whichUnit,bean.huntAmplitudeDuring,during)
elseif(bean.huntAmplitudeDuring<0)then
    call hattrEffect.subHuntAmplitudeDuring(whichUnit,bean.huntAmplitudeDuring,during)
endif
 if(bean.fireVal>0)then
    call hattrEffect.addFireVal(whichUnit,bean.fireVal,during)
elseif(bean.fireVal<0)then
    call hattrEffect.subFireVal(whichUnit,bean.fireVal,during)
endif
 if(bean.fireDuring>0)then
    call hattrEffect.addFireDuring(whichUnit,bean.fireDuring,during)
elseif(bean.fireDuring<0)then
    call hattrEffect.subFireDuring(whichUnit,bean.fireDuring,during)
endif
 if(bean.soilVal>0)then
    call hattrEffect.addSoilVal(whichUnit,bean.soilVal,during)
elseif(bean.soilVal<0)then
    call hattrEffect.subSoilVal(whichUnit,bean.soilVal,during)
endif
 if(bean.soilDuring>0)then
    call hattrEffect.addSoilDuring(whichUnit,bean.soilDuring,during)
elseif(bean.soilDuring<0)then
    call hattrEffect.subSoilDuring(whichUnit,bean.soilDuring,during)
endif
 if(bean.waterVal>0)then
    call hattrEffect.addWaterVal(whichUnit,bean.waterVal,during)
elseif(bean.waterVal<0)then
    call hattrEffect.subWaterVal(whichUnit,bean.waterVal,during)
endif
 if(bean.waterDuring>0)then
    call hattrEffect.addWaterDuring(whichUnit,bean.waterDuring,during)
elseif(bean.waterDuring<0)then
    call hattrEffect.subWaterDuring(whichUnit,bean.waterDuring,during)
endif
 if(bean.iceVal>0)then
    call hattrEffect.addIceVal(whichUnit,bean.iceVal,during)
elseif(bean.iceVal<0)then
    call hattrEffect.subIceVal(whichUnit,bean.iceVal,during)
endif
 if(bean.iceDuring>0)then
    call hattrEffect.addIceDuring(whichUnit,bean.iceDuring,during)
elseif(bean.iceDuring<0)then
    call hattrEffect.subIceDuring(whichUnit,bean.iceDuring,during)
endif
 if(bean.windVal>0)then
    call hattrEffect.addWindVal(whichUnit,bean.windVal,during)
elseif(bean.windVal<0)then
    call hattrEffect.subWindVal(whichUnit,bean.windVal,during)
endif
 if(bean.windDuring>0)then
    call hattrEffect.addWindDuring(whichUnit,bean.windDuring,during)
elseif(bean.windDuring<0)then
    call hattrEffect.subWindDuring(whichUnit,bean.windDuring,during)
endif
 if(bean.lightVal>0)then
    call hattrEffect.addLightVal(whichUnit,bean.lightVal,during)
elseif(bean.lightVal<0)then
    call hattrEffect.subLightVal(whichUnit,bean.lightVal,during)
endif
 if(bean.lightDuring>0)then
    call hattrEffect.addLightDuring(whichUnit,bean.lightDuring,during)
elseif(bean.lightDuring<0)then
    call hattrEffect.subLightDuring(whichUnit,bean.lightDuring,during)
endif
 if(bean.darkVal>0)then
    call hattrEffect.addDarkVal(whichUnit,bean.darkVal,during)
elseif(bean.darkVal<0)then
    call hattrEffect.subDarkVal(whichUnit,bean.darkVal,during)
endif
 if(bean.darkDuring>0)then
    call hattrEffect.addDarkDuring(whichUnit,bean.darkDuring,during)
elseif(bean.darkDuring<0)then
    call hattrEffect.subDarkDuring(whichUnit,bean.darkDuring,during)
endif
 if(bean.woodVal>0)then
    call hattrEffect.addWoodVal(whichUnit,bean.woodVal,during)
elseif(bean.woodVal<0)then
    call hattrEffect.subWoodVal(whichUnit,bean.woodVal,during)
endif
 if(bean.woodDuring>0)then
    call hattrEffect.addWoodDuring(whichUnit,bean.woodDuring,during)
elseif(bean.woodDuring<0)then
    call hattrEffect.subWoodDuring(whichUnit,bean.woodDuring,during)
endif
 if(bean.thunderVal>0)then
    call hattrEffect.addThunderVal(whichUnit,bean.thunderVal,during)
elseif(bean.thunderVal<0)then
    call hattrEffect.subThunderVal(whichUnit,bean.thunderVal,during)
endif
 if(bean.thunderDuring>0)then
    call hattrEffect.addThunderDuring(whichUnit,bean.thunderDuring,during)
elseif(bean.thunderDuring<0)then
    call hattrEffect.subThunderDuring(whichUnit,bean.thunderDuring,during)
endif
 if(bean.poisonVal>0)then
    call hattrEffect.addPoisonVal(whichUnit,bean.poisonVal,during)
elseif(bean.poisonVal<0)then
    call hattrEffect.subPoisonVal(whichUnit,bean.poisonVal,during)
endif
 if(bean.poisonDuring>0)then
    call hattrEffect.addPoisonDuring(whichUnit,bean.poisonDuring,during)
elseif(bean.poisonDuring<0)then
    call hattrEffect.subPoisonDuring(whichUnit,bean.poisonDuring,during)
endif
 if(bean.ghostVal>0)then
    call hattrEffect.addGhostVal(whichUnit,bean.ghostVal,during)
elseif(bean.ghostVal<0)then
    call hattrEffect.subGhostVal(whichUnit,bean.ghostVal,during)
endif
 if(bean.ghostDuring>0)then
    call hattrEffect.addGhostDuring(whichUnit,bean.ghostDuring,during)
elseif(bean.ghostDuring<0)then
    call hattrEffect.subGhostDuring(whichUnit,bean.ghostDuring,during)
endif
 if(bean.metalVal>0)then
    call hattrEffect.addMetalVal(whichUnit,bean.metalVal,during)
elseif(bean.metalVal<0)then
    call hattrEffect.subMetalVal(whichUnit,bean.metalVal,during)
endif
 if(bean.metalDuring>0)then
    call hattrEffect.addMetalDuring(whichUnit,bean.metalDuring,during)
elseif(bean.metalDuring<0)then
    call hattrEffect.subMetalDuring(whichUnit,bean.metalDuring,during)
endif
 if(bean.dragonVal>0)then
    call hattrEffect.addDragonVal(whichUnit,bean.dragonVal,during)
elseif(bean.dragonVal<0)then
    call hattrEffect.subDragonVal(whichUnit,bean.dragonVal,during)
endif
 if(bean.dragonDuring>0)then
    call hattrEffect.addDragonDuring(whichUnit,bean.dragonDuring,during)
elseif(bean.dragonDuring<0)then
    call hattrEffect.subDragonDuring(whichUnit,bean.dragonDuring,during)
endif
 if(bean.fireOpposeVal>0)then
    call hattrEffect.addFireOpposeVal(whichUnit,bean.fireOpposeVal,during)
elseif(bean.fireOpposeVal<0)then
    call hattrEffect.subFireOpposeVal(whichUnit,bean.fireOpposeVal,during)
endif
 if(bean.fireOpposeDuring>0)then
    call hattrEffect.addFireOpposeDuring(whichUnit,bean.fireOpposeDuring,during)
elseif(bean.fireOpposeDuring<0)then
    call hattrEffect.subFireOpposeDuring(whichUnit,bean.fireOpposeDuring,during)
endif
 if(bean.soilOpposeVal>0)then
    call hattrEffect.addSoilOpposeVal(whichUnit,bean.soilOpposeVal,during)
elseif(bean.soilOpposeVal<0)then
    call hattrEffect.subSoilOpposeVal(whichUnit,bean.soilOpposeVal,during)
endif
 if(bean.soilOpposeDuring>0)then
    call hattrEffect.addSoilOpposeDuring(whichUnit,bean.soilOpposeDuring,during)
elseif(bean.soilOpposeDuring<0)then
    call hattrEffect.subSoilOpposeDuring(whichUnit,bean.soilOpposeDuring,during)
endif
 if(bean.waterOpposeVal>0)then
    call hattrEffect.addWaterOpposeVal(whichUnit,bean.waterOpposeVal,during)
elseif(bean.waterOpposeVal<0)then
    call hattrEffect.subWaterOpposeVal(whichUnit,bean.waterOpposeVal,during)
endif
 if(bean.waterOpposeDuring>0)then
    call hattrEffect.addWaterOpposeDuring(whichUnit,bean.waterOpposeDuring,during)
elseif(bean.waterOpposeDuring<0)then
    call hattrEffect.subWaterOpposeDuring(whichUnit,bean.waterOpposeDuring,during)
endif
 if(bean.iceOpposeVal>0)then
    call hattrEffect.addIceOpposeVal(whichUnit,bean.iceOpposeVal,during)
elseif(bean.iceOpposeVal<0)then
    call hattrEffect.subIceOpposeVal(whichUnit,bean.iceOpposeVal,during)
endif
 if(bean.iceOpposeDuring>0)then
    call hattrEffect.addIceOpposeDuring(whichUnit,bean.iceOpposeDuring,during)
elseif(bean.iceOpposeDuring<0)then
    call hattrEffect.subIceOpposeDuring(whichUnit,bean.iceOpposeDuring,during)
endif
 if(bean.windOpposeVal>0)then
    call hattrEffect.addWindOpposeVal(whichUnit,bean.windOpposeVal,during)
elseif(bean.windOpposeVal<0)then
    call hattrEffect.subWindOpposeVal(whichUnit,bean.windOpposeVal,during)
endif
 if(bean.windOpposeDuring>0)then
    call hattrEffect.addWindOpposeDuring(whichUnit,bean.windOpposeDuring,during)
elseif(bean.windOpposeDuring<0)then
    call hattrEffect.subWindOpposeDuring(whichUnit,bean.windOpposeDuring,during)
endif
 if(bean.lightOpposeVal>0)then
    call hattrEffect.addLightOpposeVal(whichUnit,bean.lightOpposeVal,during)
elseif(bean.lightOpposeVal<0)then
    call hattrEffect.subLightOpposeVal(whichUnit,bean.lightOpposeVal,during)
endif
 if(bean.lightOpposeDuring>0)then
    call hattrEffect.addLightOpposeDuring(whichUnit,bean.lightOpposeDuring,during)
elseif(bean.lightOpposeDuring<0)then
    call hattrEffect.subLightOpposeDuring(whichUnit,bean.lightOpposeDuring,during)
endif
 if(bean.darkOpposeVal>0)then
    call hattrEffect.addDarkOpposeVal(whichUnit,bean.darkOpposeVal,during)
elseif(bean.darkOpposeVal<0)then
    call hattrEffect.subDarkOpposeVal(whichUnit,bean.darkOpposeVal,during)
endif
 if(bean.darkOpposeDuring>0)then
    call hattrEffect.addDarkOpposeDuring(whichUnit,bean.darkOpposeDuring,during)
elseif(bean.darkOpposeDuring<0)then
    call hattrEffect.subDarkOpposeDuring(whichUnit,bean.darkOpposeDuring,during)
endif
 if(bean.woodOpposeVal>0)then
    call hattrEffect.addWoodOpposeVal(whichUnit,bean.woodOpposeVal,during)
elseif(bean.woodOpposeVal<0)then
    call hattrEffect.subWoodOpposeVal(whichUnit,bean.woodOpposeVal,during)
endif
 if(bean.woodOpposeDuring>0)then
    call hattrEffect.addWoodOpposeDuring(whichUnit,bean.woodOpposeDuring,during)
elseif(bean.woodOpposeDuring<0)then
    call hattrEffect.subWoodOpposeDuring(whichUnit,bean.woodOpposeDuring,during)
endif
 if(bean.thunderOpposeVal>0)then
    call hattrEffect.addThunderOpposeVal(whichUnit,bean.thunderOpposeVal,during)
elseif(bean.thunderOpposeVal<0)then
    call hattrEffect.subThunderOpposeVal(whichUnit,bean.thunderOpposeVal,during)
endif
 if(bean.thunderOpposeDuring>0)then
    call hattrEffect.addThunderOpposeDuring(whichUnit,bean.thunderOpposeDuring,during)
elseif(bean.thunderOpposeDuring<0)then
    call hattrEffect.subThunderOpposeDuring(whichUnit,bean.thunderOpposeDuring,during)
endif
 if(bean.poisonOpposeVal>0)then
    call hattrEffect.addPoisonOpposeVal(whichUnit,bean.poisonOpposeVal,during)
elseif(bean.poisonOpposeVal<0)then
    call hattrEffect.subPoisonOpposeVal(whichUnit,bean.poisonOpposeVal,during)
endif
 if(bean.poisonOpposeDuring>0)then
    call hattrEffect.addPoisonOpposeDuring(whichUnit,bean.poisonOpposeDuring,during)
elseif(bean.poisonOpposeDuring<0)then
    call hattrEffect.subPoisonOpposeDuring(whichUnit,bean.poisonOpposeDuring,during)
endif
 if(bean.ghostOpposeVal>0)then
    call hattrEffect.addGhostOpposeVal(whichUnit,bean.ghostOpposeVal,during)
elseif(bean.ghostOpposeVal<0)then
    call hattrEffect.subGhostOpposeVal(whichUnit,bean.ghostOpposeVal,during)
endif
 if(bean.ghostOpposeDuring>0)then
    call hattrEffect.addGhostOpposeDuring(whichUnit,bean.ghostOpposeDuring,during)
elseif(bean.ghostOpposeDuring<0)then
    call hattrEffect.subGhostOpposeDuring(whichUnit,bean.ghostOpposeDuring,during)
endif
 if(bean.metalOpposeVal>0)then
    call hattrEffect.addMetalOpposeVal(whichUnit,bean.metalOpposeVal,during)
elseif(bean.metalOpposeVal<0)then
    call hattrEffect.subMetalOpposeVal(whichUnit,bean.metalOpposeVal,during)
endif
 if(bean.metalOpposeDuring>0)then
    call hattrEffect.addMetalOpposeDuring(whichUnit,bean.metalOpposeDuring,during)
elseif(bean.metalOpposeDuring<0)then
    call hattrEffect.subMetalOpposeDuring(whichUnit,bean.metalOpposeDuring,during)
endif
 if(bean.dragonOpposeVal>0)then
    call hattrEffect.addDragonOpposeVal(whichUnit,bean.dragonOpposeVal,during)
elseif(bean.dragonOpposeVal<0)then
    call hattrEffect.subDragonOpposeVal(whichUnit,bean.dragonOpposeVal,during)
endif
 if(bean.dragonOpposeDuring>0)then
    call hattrEffect.addDragonOpposeDuring(whichUnit,bean.dragonOpposeDuring,during)
elseif(bean.dragonOpposeDuring<0)then
    call hattrEffect.subDragonOpposeDuring(whichUnit,bean.dragonOpposeDuring,during)
endif
 if(bean.toxicVal>0)then
    call hattrEffect.addToxicVal(whichUnit,bean.toxicVal,during)
elseif(bean.toxicVal<0)then
    call hattrEffect.subToxicVal(whichUnit,bean.toxicVal,during)
endif
 if(bean.toxicDuring>0)then
    call hattrEffect.addToxicDuring(whichUnit,bean.toxicDuring,during)
elseif(bean.toxicDuring<0)then
    call hattrEffect.subToxicDuring(whichUnit,bean.toxicDuring,during)
endif
 if(bean.burnVal>0)then
    call hattrEffect.addBurnVal(whichUnit,bean.burnVal,during)
elseif(bean.burnVal<0)then
    call hattrEffect.subBurnVal(whichUnit,bean.burnVal,during)
endif
 if(bean.burnDuring>0)then
    call hattrEffect.addBurnDuring(whichUnit,bean.burnDuring,during)
elseif(bean.burnDuring<0)then
    call hattrEffect.subBurnDuring(whichUnit,bean.burnDuring,during)
endif
 if(bean.dryVal>0)then
    call hattrEffect.addDryVal(whichUnit,bean.dryVal,during)
elseif(bean.dryVal<0)then
    call hattrEffect.subDryVal(whichUnit,bean.dryVal,during)
endif
 if(bean.dryDuring>0)then
    call hattrEffect.addDryDuring(whichUnit,bean.dryDuring,during)
elseif(bean.dryDuring<0)then
    call hattrEffect.subDryDuring(whichUnit,bean.dryDuring,during)
endif
 if(bean.freezeVal>0)then
    call hattrEffect.addFreezeVal(whichUnit,bean.freezeVal,during)
elseif(bean.freezeVal<0)then
    call hattrEffect.subFreezeVal(whichUnit,bean.freezeVal,during)
endif
 if(bean.freezeDuring>0)then
    call hattrEffect.addFreezeDuring(whichUnit,bean.freezeDuring,during)
elseif(bean.freezeDuring<0)then
    call hattrEffect.subFreezeDuring(whichUnit,bean.freezeDuring,during)
endif
 if(bean.coldVal>0)then
    call hattrEffect.addColdVal(whichUnit,bean.coldVal,during)
elseif(bean.coldVal<0)then
    call hattrEffect.subColdVal(whichUnit,bean.coldVal,during)
endif
 if(bean.coldDuring>0)then
    call hattrEffect.addColdDuring(whichUnit,bean.coldDuring,during)
elseif(bean.coldDuring<0)then
    call hattrEffect.subColdDuring(whichUnit,bean.coldDuring,during)
endif
 if(bean.bluntVal>0)then
    call hattrEffect.addBluntVal(whichUnit,bean.bluntVal,during)
elseif(bean.bluntVal<0)then
    call hattrEffect.subBluntVal(whichUnit,bean.bluntVal,during)
endif
 if(bean.bluntDuring>0)then
    call hattrEffect.addBluntDuring(whichUnit,bean.bluntDuring,during)
elseif(bean.bluntDuring<0)then
    call hattrEffect.subBluntDuring(whichUnit,bean.bluntDuring,during)
endif
 if(bean.myopiaVal>0)then
    call hattrEffect.addMyopiaVal(whichUnit,bean.myopiaVal,during)
elseif(bean.myopiaVal<0)then
    call hattrEffect.subMyopiaVal(whichUnit,bean.myopiaVal,during)
endif
 if(bean.myopiaDuring>0)then
    call hattrEffect.addMyopiaDuring(whichUnit,bean.myopiaDuring,during)
elseif(bean.myopiaDuring<0)then
    call hattrEffect.subMyopiaDuring(whichUnit,bean.myopiaDuring,during)
endif
 if(bean.muggleVal>0)then
    call hattrEffect.addMuggleVal(whichUnit,bean.muggleVal,during)
elseif(bean.muggleVal<0)then
    call hattrEffect.subMuggleVal(whichUnit,bean.muggleVal,during)
endif
 if(bean.muggleDuring>0)then
    call hattrEffect.addMuggleDuring(whichUnit,bean.muggleDuring,during)
elseif(bean.muggleDuring<0)then
    call hattrEffect.subMuggleDuring(whichUnit,bean.muggleDuring,during)
endif
 if(bean.blindVal>0)then
    call hattrEffect.addBlindVal(whichUnit,bean.blindVal,during)
elseif(bean.blindVal<0)then
    call hattrEffect.subBlindVal(whichUnit,bean.blindVal,during)
endif
 if(bean.blindDuring>0)then
    call hattrEffect.addBlindDuring(whichUnit,bean.blindDuring,during)
elseif(bean.blindDuring<0)then
    call hattrEffect.subBlindDuring(whichUnit,bean.blindDuring,during)
endif
 if(bean.corrosionVal>0)then
    call hattrEffect.addCorrosionVal(whichUnit,bean.corrosionVal,during)
elseif(bean.corrosionVal<0)then
    call hattrEffect.subCorrosionVal(whichUnit,bean.corrosionVal,during)
endif
 if(bean.corrosionDuring>0)then
    call hattrEffect.addCorrosionDuring(whichUnit,bean.corrosionDuring,during)
elseif(bean.corrosionDuring<0)then
    call hattrEffect.subCorrosionDuring(whichUnit,bean.corrosionDuring,during)
endif
 if(bean.chaosVal>0)then
    call hattrEffect.addChaosVal(whichUnit,bean.chaosVal,during)
elseif(bean.chaosVal<0)then
    call hattrEffect.subChaosVal(whichUnit,bean.chaosVal,during)
endif
 if(bean.chaosDuring>0)then
    call hattrEffect.addChaosDuring(whichUnit,bean.chaosDuring,during)
elseif(bean.chaosDuring<0)then
    call hattrEffect.subChaosDuring(whichUnit,bean.chaosDuring,during)
endif
 if(bean.twineVal>0)then
    call hattrEffect.addTwineVal(whichUnit,bean.twineVal,during)
elseif(bean.twineVal<0)then
    call hattrEffect.subTwineVal(whichUnit,bean.twineVal,during)
endif
 if(bean.twineDuring>0)then
    call hattrEffect.addTwineDuring(whichUnit,bean.twineDuring,during)
elseif(bean.twineDuring<0)then
    call hattrEffect.subTwineDuring(whichUnit,bean.twineDuring,during)
endif
 if(bean.drunkVal>0)then
    call hattrEffect.addDrunkVal(whichUnit,bean.drunkVal,during)
elseif(bean.drunkVal<0)then
    call hattrEffect.subDrunkVal(whichUnit,bean.drunkVal,during)
endif
 if(bean.drunkDuring>0)then
    call hattrEffect.addDrunkDuring(whichUnit,bean.drunkDuring,during)
elseif(bean.drunkDuring<0)then
    call hattrEffect.subDrunkDuring(whichUnit,bean.drunkDuring,during)
endif
 if(bean.tortuaVal>0)then
    call hattrEffect.addTortuaVal(whichUnit,bean.tortuaVal,during)
elseif(bean.tortuaVal<0)then
    call hattrEffect.subTortuaVal(whichUnit,bean.tortuaVal,during)
endif
 if(bean.tortuaDuring>0)then
    call hattrEffect.addTortuaDuring(whichUnit,bean.tortuaDuring,during)
elseif(bean.tortuaDuring<0)then
    call hattrEffect.subTortuaDuring(whichUnit,bean.tortuaDuring,during)
endif
 if(bean.weakVal>0)then
    call hattrEffect.addWeakVal(whichUnit,bean.weakVal,during)
elseif(bean.weakVal<0)then
    call hattrEffect.subWeakVal(whichUnit,bean.weakVal,during)
endif
 if(bean.weakDuring>0)then
    call hattrEffect.addWeakDuring(whichUnit,bean.weakDuring,during)
elseif(bean.weakDuring<0)then
    call hattrEffect.subWeakDuring(whichUnit,bean.weakDuring,during)
endif
 if(bean.astrictVal>0)then
    call hattrEffect.addAstrictVal(whichUnit,bean.astrictVal,during)
elseif(bean.astrictVal<0)then
    call hattrEffect.subAstrictVal(whichUnit,bean.astrictVal,during)
endif
 if(bean.astrictDuring>0)then
    call hattrEffect.addAstrictDuring(whichUnit,bean.astrictDuring,during)
elseif(bean.astrictDuring<0)then
    call hattrEffect.subAstrictDuring(whichUnit,bean.astrictDuring,during)
endif
 if(bean.foolishVal>0)then
    call hattrEffect.addFoolishVal(whichUnit,bean.foolishVal,during)
elseif(bean.foolishVal<0)then
    call hattrEffect.subFoolishVal(whichUnit,bean.foolishVal,during)
endif
 if(bean.foolishDuring>0)then
    call hattrEffect.addFoolishDuring(whichUnit,bean.foolishDuring,during)
elseif(bean.foolishDuring<0)then
    call hattrEffect.subFoolishDuring(whichUnit,bean.foolishDuring,during)
endif
 if(bean.dullVal>0)then
    call hattrEffect.addDullVal(whichUnit,bean.dullVal,during)
elseif(bean.dullVal<0)then
    call hattrEffect.subDullVal(whichUnit,bean.dullVal,during)
endif
 if(bean.dullDuring>0)then
    call hattrEffect.addDullDuring(whichUnit,bean.dullDuring,during)
elseif(bean.dullDuring<0)then
    call hattrEffect.subDullDuring(whichUnit,bean.dullDuring,during)
endif
 if(bean.dirtVal>0)then
    call hattrEffect.addDirtVal(whichUnit,bean.dirtVal,during)
elseif(bean.dirtVal<0)then
    call hattrEffect.subDirtVal(whichUnit,bean.dirtVal,during)
endif
 if(bean.dirtDuring>0)then
    call hattrEffect.addDirtDuring(whichUnit,bean.dirtDuring,during)
elseif(bean.dirtDuring<0)then
    call hattrEffect.subDirtDuring(whichUnit,bean.dirtDuring,during)
endif
 if(bean.swimOdds>0)then
    call hattrEffect.addSwimOdds(whichUnit,bean.swimOdds,during)
elseif(bean.swimOdds<0)then
    call hattrEffect.subSwimOdds(whichUnit,bean.swimOdds,during)
endif
 if(bean.swimDuring>0)then
    call hattrEffect.addSwimDuring(whichUnit,bean.swimDuring,during)
elseif(bean.swimDuring<0)then
    call hattrEffect.subSwimDuring(whichUnit,bean.swimDuring,during)
endif
 if(bean.heavyOdds>0)then
    call hattrEffect.addHeavyOdds(whichUnit,bean.heavyOdds,during)
elseif(bean.heavyOdds<0)then
    call hattrEffect.subHeavyOdds(whichUnit,bean.heavyOdds,during)
endif
 if(bean.heavyVal>0)then
    call hattrEffect.addHeavyVal(whichUnit,bean.heavyVal,during)
elseif(bean.heavyVal<0)then
    call hattrEffect.subHeavyVal(whichUnit,bean.heavyVal,during)
endif
 if(bean.breakOdds>0)then
    call hattrEffect.addBreakOdds(whichUnit,bean.breakOdds,during)
elseif(bean.breakOdds<0)then
    call hattrEffect.subBreakOdds(whichUnit,bean.breakOdds,during)
endif
 if(bean.breakDuring>0)then
    call hattrEffect.addBreakDuring(whichUnit,bean.breakDuring,during)
elseif(bean.breakDuring<0)then
    call hattrEffect.subBreakDuring(whichUnit,bean.breakDuring,during)
endif
 if(bean.unluckVal>0)then
    call hattrEffect.addUnluckVal(whichUnit,bean.unluckVal,during)
elseif(bean.unluckVal<0)then
    call hattrEffect.subUnluckVal(whichUnit,bean.unluckVal,during)
endif
 if(bean.unluckDuring>0)then
    call hattrEffect.addUnluckDuring(whichUnit,bean.unluckDuring,during)
elseif(bean.unluckDuring<0)then
    call hattrEffect.subUnluckDuring(whichUnit,bean.unluckDuring,during)
endif
 if(bean.silentOdds>0)then
    call hattrEffect.addSilentOdds(whichUnit,bean.silentOdds,during)
elseif(bean.silentOdds<0)then
    call hattrEffect.subSilentOdds(whichUnit,bean.silentOdds,during)
endif
 if(bean.silentDuring>0)then
    call hattrEffect.addSilentDuring(whichUnit,bean.silentDuring,during)
elseif(bean.silentDuring<0)then
    call hattrEffect.subSilentDuring(whichUnit,bean.silentDuring,during)
endif
 if(bean.unarmOdds>0)then
    call hattrEffect.addUnarmOdds(whichUnit,bean.unarmOdds,during)
elseif(bean.unarmOdds<0)then
    call hattrEffect.subUnarmOdds(whichUnit,bean.unarmOdds,during)
endif
 if(bean.unarmDuring>0)then
    call hattrEffect.addUnarmDuring(whichUnit,bean.unarmDuring,during)
elseif(bean.unarmDuring<0)then
    call hattrEffect.subUnarmDuring(whichUnit,bean.unarmDuring,during)
endif
 if(bean.fetterOdds>0)then
    call hattrEffect.addFetterOdds(whichUnit,bean.fetterOdds,during)
elseif(bean.fetterOdds<0)then
    call hattrEffect.subFetterOdds(whichUnit,bean.fetterOdds,during)
endif
 if(bean.fetterDuring>0)then
    call hattrEffect.addFetterDuring(whichUnit,bean.fetterDuring,during)
elseif(bean.fetterDuring<0)then
    call hattrEffect.subFetterDuring(whichUnit,bean.fetterDuring,during)
endif
 if(bean.bombVal>0)then
    call hattrEffect.addBombVal(whichUnit,bean.bombVal,during)
elseif(bean.bombVal<0)then
    call hattrEffect.subBombVal(whichUnit,bean.bombVal,during)
endif
 if(bean.bombOdds>0)then
    call hattrEffect.addBombOdds(whichUnit,bean.bombOdds,during)
elseif(bean.bombOdds<0)then
    call hattrEffect.subBombOdds(whichUnit,bean.bombOdds,during)
endif
 if(bean.bombModel!="")then
    call hattrEffect.setBombModel(whichUnit,bean.bombModel)
endif
 if(bean.lightningChainVal>0)then
    call hattrEffect.addLightningChainVal(whichUnit,bean.lightningChainVal,during)
elseif(bean.lightningChainVal<0)then
    call hattrEffect.subLightningChainVal(whichUnit,bean.lightningChainVal,during)
endif
 if(bean.lightningChainOdds>0)then
    call hattrEffect.addLightningChainOdds(whichUnit,bean.lightningChainOdds,during)
elseif(bean.lightningChainOdds<0)then
    call hattrEffect.subLightningChainOdds(whichUnit,bean.lightningChainOdds,during)
endif
 if(bean.lightningChainQty>0)then
    call hattrEffect.addLightningChainQty(whichUnit,bean.lightningChainQty,during)
elseif(bean.lightningChainQty<0)then
    call hattrEffect.subLightningChainQty(whichUnit,bean.lightningChainQty,during)
endif
 if(bean.lightningChainReduce>0)then
    call hattrEffect.addLightningChainReduce(whichUnit,bean.lightningChainReduce,during)
elseif(bean.lightningChainReduce<0)then
    call hattrEffect.subLightningChainReduce(whichUnit,bean.lightningChainReduce,during)
endif
 if(bean.lightningChainModel!="")then
    call hattrEffect.setLightningChainModel(whichUnit,bean.lightningChainModel)
endif
 if(bean.crackFlyVal>0)then
    call hattrEffect.addCrackFlyVal(whichUnit,bean.crackFlyVal,during)
elseif(bean.crackFlyVal<0)then
    call hattrEffect.subCrackFlyVal(whichUnit,bean.crackFlyVal,during)
endif
 if(bean.crackFlyOdds>0)then
    call hattrEffect.addCrackFlyOdds(whichUnit,bean.crackFlyOdds,during)
elseif(bean.crackFlyOdds<0)then
    call hattrEffect.subCrackFlyOdds(whichUnit,bean.crackFlyOdds,during)
endif
 if(bean.crackFlyDistance>0)then
    call hattrEffect.addCrackFlyDistance(whichUnit,bean.crackFlyDistance,during)
elseif(bean.crackFlyDistance<0)then
    call hattrEffect.subCrackFlyDistance(whichUnit,bean.crackFlyDistance,during)
endif
 if(bean.crackFlyHigh>0)then
    call hattrEffect.addCrackFlyHigh(whichUnit,bean.crackFlyHigh,during)
elseif(bean.crackFlyHigh<0)then
    call hattrEffect.subCrackFlyHigh(whichUnit,bean.crackFlyHigh,during)
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
			set PUNISH_TEXTTAG_HEIGHT = high * 0.5
		else
			set PUNISH_TEXTTAG_HEIGHT = high
		endif
	endmethod

	//生命/魔法恢复 ; 生命源/魔法源触动
	private static method lifemanasourceCall takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit u = htime.getUnit(t,1)
		local integer typ = htime.getInteger(t,2)
		call htime.delTimer(t)
		if(u!=null)then
			if(typ==1)then
				call SaveBoolean(hash_attr_unit,GetHandleId(u),StringHash("lsc"),false)
			elseif(typ==2)then
				call SaveBoolean(hash_attr_unit,GetHandleId(u),StringHash("msc"),false)
			endif
		endif
		set t = null
		set u = null
	endmethod
	private static method lifemanaback takes nothing returns nothing
	    local timer t = GetExpiredTimer()
	    local real period = TimerGetTimeout(t)
	    local group tempGroup = null
		local unit tempUnit = null
		local real tempReal = 0
		local real sourceTime = 10.00
		local timer tmpt = null
		if( hgroup.isEmpty(ATTR_GROUP_LIFE_BACK) == false )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP_LIFE_BACK , tempGroup )
			loop
	            exitwhen(hgroup.isEmpty(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
	                //
					if( IsUnitAliveBJ(tempUnit) )then
						if(hattr.getLifeBack(tempUnit)!=0)then
							call SetUnitLifeBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_LIFE, tempUnit) + ( hattr.getLifeBack(tempUnit) * period ) ) )
						endif
					else
						call GroupRemoveUnit( ATTR_GROUP_LIFE_BACK , tempUnit )
	                endif
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
		if( hgroup.isEmpty(ATTR_GROUP_LIFE_SOURCE) == false )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP_LIFE_SOURCE , tempGroup )
			loop
	            exitwhen(hgroup.isEmpty(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
	                //
					if( IsUnitAliveBJ(tempUnit) )then
						if( LoadBoolean(hash_attr_unit,GetHandleId(tempUnit),StringHash("lsc"))==false and hunit.getLifePercent(tempUnit)<hplayer.getLifeSourceRatio(GetOwningPlayer(tempUnit)) )then
							set tempReal = GetUnitStateSwap(UNIT_STATE_MAX_LIFE, tempUnit)-GetUnitStateSwap(UNIT_STATE_LIFE, tempUnit)
							if(tempReal<hattr.getLifeSourceCurrent(tempUnit))then
								call SaveBoolean(hash_attr_unit,GetHandleId(tempUnit),StringHash("lsc"),true)
								call hattr.subLifeSourceCurrent(tempUnit,tempReal,0)
								call hattr.addLifeBack(tempUnit,tempReal/sourceTime,sourceTime)
								set tmpt = htime.setTimeout(sourceTime,function thistype.lifemanasourceCall)
								call htime.setUnit(tmpt,1,tempUnit)
								call htime.setInteger(tmpt,2,1)
								call hmsg.style(  hmsg.ttg2Unit(tempUnit,"源力加持",6.00,"bce43a",10,1.00,10.00)  ,"scale",0,0.2)
								set tmpt = null
							endif
						endif
					else
						call GroupRemoveUnit( ATTR_GROUP_LIFE_SOURCE , tempUnit )
	                endif
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
		if( hgroup.isEmpty(ATTR_GROUP_MANA_BACK) == false )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP_MANA_BACK , tempGroup )
			loop
	            exitwhen(hgroup.isEmpty(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
	                //
					if( IsUnitAliveBJ(tempUnit) )then
						if(hattr.getManaBack(tempUnit)!=0)then
							call SetUnitManaBJ( tempUnit , ( GetUnitStateSwap(UNIT_STATE_MANA, tempUnit) + ( hattr.getManaBack(tempUnit) * period ) ) )
						endif
					else
						call GroupRemoveUnit( ATTR_GROUP_MANA_BACK , tempUnit )
	                endif
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
		if( hgroup.isEmpty(ATTR_GROUP_MANA_SOURCE) == false )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP_MANA_SOURCE , tempGroup )
			loop
	            exitwhen(hgroup.isEmpty(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
	                //
					if( IsUnitAliveBJ(tempUnit) )then
						if( LoadBoolean(hash_attr_unit,GetHandleId(tempUnit),StringHash("msc"))==false and hunit.getManaPercent(tempUnit)<hplayer.getManaSourceRatio(GetOwningPlayer(tempUnit)) )then
							set tempReal = GetUnitStateSwap(UNIT_STATE_MAX_MANA, tempUnit)-GetUnitStateSwap(UNIT_STATE_MANA, tempUnit)
							if(tempReal<hattr.getManaSourceCurrent(tempUnit))then
								call SaveBoolean(hash_attr_unit,GetHandleId(tempUnit),StringHash("msc"),true)
								call hattr.subManaSourceCurrent(tempUnit,tempReal,0)
								call hattr.addManaBack(tempUnit,tempReal/sourceTime,sourceTime)
								set tmpt = htime.setTimeout(sourceTime,function thistype.lifemanasourceCall)
								call htime.setUnit(tmpt,1,tempUnit)
								call htime.setInteger(tmpt,2,2)
								call hmsg.style(  hmsg.ttg2Unit(tempUnit,"源力加持",6.00,"93d3f1",10,1.00,10.00)  ,"scale",0,0.2)
								set tmpt = null
							endif
						endif
					else
						call GroupRemoveUnit( ATTR_GROUP_MANA_SOURCE , tempUnit )
	                endif
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
		set t = null
	endmethod

	public static method createBlockText takes real current,real all,integer blockMax,string colorFt,string colorBg returns string
		local string str = null
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
		set font = null
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
		set t = null
		set ttgStr = null
		set whichUnit = null
		set ttg = null
	endmethod

	//硬直条
	public static method punishTtg takes unit whichUnit returns nothing
		local timer t = null
		local texttag ttg = null
		local real size = 5
		if(PUNISH_SWITCH == true and (PUNISH_SWITCH_ONLYHERO==false or (PUNISH_SWITCH_ONLYHERO==true and his.hero(whichUnit))))then
			set ttg = hmsg.ttg2Unit(whichUnit,"",size,"",10,0,PUNISH_TEXTTAG_HEIGHT)
	        set t =  htime.setInterval( 0.03 , function thistype.punishTtgCall )
	        call htime.setUnit( t , 1 , whichUnit )
	        call htime.setTexttag( t , 2 , ttg )
	        call htime.setReal( t , 3 , PUNISH_TEXTTAG_HEIGHT )
	        call htime.setReal( t , 4 , size )
			set t = null
			set ttg = null
		endif
	endmethod

	//硬直恢复器(+100/5s)
	private static method punishback takes nothing returns nothing
	    local integer i = 0
	    local integer addPunish = 0
	    local group tempGroup = null
		local unit tempUnit = null
		if( hgroup.isEmpty(ATTR_GROUP_PUNISH) == false )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP_PUNISH , tempGroup )
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

	//源恢复器(L +300/25s | M +200/25s)
	private static method sourceback takes nothing returns nothing
	    local integer i = 0
	    local integer addPunish = 0
	    local group tempGroup = null
		local unit tempUnit = null
		if( hgroup.isEmpty(ATTR_GROUP_LIFE_SOURCE) == false )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP_LIFE_SOURCE , tempGroup )
			loop
	            exitwhen(IsUnitGroupEmptyBJ(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
					if( hattr.getLifeSourceCurrent(tempUnit)<hattr.getLifeSource(tempUnit) )then
						call hattr.addLifeSourceCurrent( tempUnit , 300 , 0 )
					endif
					set tempUnit = null
	        endloop
	        call GroupClear( tempGroup )
	        call DestroyGroup( tempGroup )
	        set tempGroup = null
		endif
		if( hgroup.isEmpty(ATTR_GROUP_MANA_SOURCE) == false )then
			set tempGroup = CreateGroup()
			call GroupAddGroup( ATTR_GROUP_MANA_SOURCE , tempGroup )
			loop
	            exitwhen(IsUnitGroupEmptyBJ(tempGroup) == true)
	                set tempUnit = FirstOfGroup(tempGroup)
	                call GroupRemoveUnit( tempGroup , tempUnit )
					if( hattr.getManaSourceCurrent(tempUnit)<hattr.getManaSource(tempUnit) )then
						call hattr.addManaSourceCurrent( tempUnit , 200 , 0 )
					endif
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
		set t = null
		set fromUnit = null
		set toUnit = null
	endmethod

	private static method triggerUnitbeHuntAction takes nothing returns nothing
		local unit fromUnit = GetEventDamageSource()
		local unit toUnit = GetTriggerUnit()
		local real damage = GetEventDamage()
		local real oldLife = hunit.getLife(toUnit)
		local timer t = null
		if(damage>0.2)then
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

	//单位死亡
	private static method triggerUnitDeathAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		local unit killer = hevt.getLastDamageUnit(u)
		if(PUNISH_SWITCH == true)then
			call SaveTextTagHandle(hash_attr_unit, GetHandleId(u), 7896 , null)
		endif
		call hplayer.addKill(GetOwningPlayer(killer),1)
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
		set killer = null
	endmethod

	//注册单位
	private static method triggerInAction takes nothing returns nothing
		local unit u = GetTriggerUnit()
		local integer utid = GetUnitTypeId(u)
		local integer uhid = GetHandleId(u)
		local boolean isBind = false
		//排除单位类型
		if(utid==ABILITY_TOKEN or utid==ABILITY_BREAK or utid==ABILITY_SWIM or utid==HERO_SELECTION_TOKEN)then
			set u = null
			return
		endif
		//注册事件
		set isBind = LoadBoolean( hash_attr_unit , uhid , 1 )
		if(isBind != true)then
			call SaveBoolean( hash_attr_unit , uhid , 1 , true )
			call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_BEHUNT , u , EVENT_UNIT_DAMAGED )
			if(GetUnitAbilityLevel(u,'Aloc')>0)then
				//蝗虫不做某些处理
			else
				call TriggerRegisterUnitEvent( ATTR_TRIGGER_UNIT_DEATH , u , EVENT_UNIT_DEATH )
				call punishTtg(u)
				//拥有物品栏的单位绑定物品处理
				if( his.hasSlot(u) )then
					call hitem.initUnit(u)
				endif
				//触发注册事件(全局)
				set hevtBean = hEvtBean.create()
				set hevtBean.triggerKey = "register"
				set hevtBean.triggerHandle = hevt.getDefaultHandle()
				set hevtBean.triggerUnit = u
				call hevt.triggerEvent(hevtBean)
				call hevtBean.destroy()
			endif
		endif
        set u = null
	endmethod

	//初始化
	public static method initSet takes nothing returns nothing
		local trigger triggerIn = CreateTrigger()
		//触发设定
		set ATTR_TRIGGER_UNIT_BEHUNT = CreateTrigger()
		set ATTR_TRIGGER_UNIT_DEATH = CreateTrigger()
		call TriggerAddAction(ATTR_TRIGGER_UNIT_BEHUNT,function thistype.triggerUnitbeHuntAction)
		call TriggerAddAction(ATTR_TRIGGER_UNIT_DEATH, function thistype.triggerUnitDeathAction)

		//单位进入区域注册
		call TriggerRegisterEnterRectSimple( triggerIn , GetPlayableMapRect() )
		call TriggerAddAction( triggerIn , function thistype.triggerInAction)

		call htime.setInterval( 0.50 , function thistype.lifemanaback )
		call htime.setInterval( 5.00 , function thistype.punishback )
		call htime.setInterval(25.00 , function thistype.sourceback )

		set triggerIn = null

	endmethod

endstruct
