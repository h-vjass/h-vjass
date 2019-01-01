//属性系统

#include "attributeIds.j" //当使用自行设定属性技能时，请注释此行

globals
	//系统最大移动速度
	real MAX_MOVE_SPEED = 522
	//默认攻速计算
	real DEFAULT_ATTACK_SPEED_SPACE = 1.50
endglobals

globals
	hAttr hattr
	hashtable hash_attr = null
	group ATTR_GROUP_LIFE_BACK = CreateGroup()
	group ATTR_GROUP_MANA_BACK = CreateGroup()
	group ATTR_GROUP_LIFE_SOURCE = CreateGroup()
	group ATTR_GROUP_MANA_SOURCE = CreateGroup()
	group ATTR_GROUP_PUNISH = CreateGroup()
endglobals

struct hAttrBean
public static real life = 0.0
public static real mana = 0.0
public static real move = 0.0
public static real defend  = 0.0
public static real attackSpeed = 0.0
public static string attackHuntType = ""
public static real attackPhysical = 0.0
public static real attackMagic = 0.0
public static real attackRange = 0.0
public static real sight = 0.0
public static real str = 0.0
public static real agi = 0.0
public static real int = 0.0
public static real strWhite = 0.0
public static real agiWhite = 0.0
public static real intWhite = 0.0
public static real lifeBack = 0.0
public static real lifeSource = 0.0
public static real lifeSourceCurrent = 0.0
public static real manaBack = 0.0
public static real manaSource = 0.0
public static real manaSourceCurrent = 0.0
public static real resistance = 0.0
public static real toughness = 0.0
public static real avoid = 0.0
public static real aim = 0.0
public static real knocking = 0.0
public static real violence = 0.0
public static real punish = 0.0
public static real punishCurrent = 0.0
public static real meditative = 0.0
public static real help = 0.0
public static real hemophagia = 0.0
public static real hemophagiaSkill = 0.0
public static real split = 0.0
public static real splitRange = 0.0
public static real goldRatio = 0.0
public static real lumberRatio = 0.0
public static real expRatio = 0.0
public static real luck = 0.0
public static real invincible = 0.0
public static real weight = 0.0
public static real weightCurrent = 0.0
public static real huntAmplitude = 0.0
public static real huntRebound = 0.0
public static real cure = 0.0
public static real knockingOppose = 0.0
public static real violenceOppose = 0.0
public static real hemophagiaOppose = 0.0
public static real splitOppose = 0.0
public static real punishOppose = 0.0
public static real huntReboundOppose = 0.0
public static real swimOppose = 0.0
public static real heavyOppose = 0.0
public static real breakOppose = 0.0
public static real unluckOppose = 0.0
public static real silentOppose = 0.0
public static real unarmOppose = 0.0
public static real fetterOppose = 0.0
public static real bombOppose = 0.0
public static real lightningChainOppose = 0.0
public static real crackFlyOppose = 0.0
public static real fire = 0.0
public static real soil = 0.0
public static real water = 0.0
public static real ice = 0.0
public static real wind = 0.0
public static real light = 0.0
public static real dark = 0.0
public static real wood = 0.0
public static real thunder = 0.0
public static real poison = 0.0
public static real ghost = 0.0
public static real metal = 0.0
public static real dragon = 0.0
public static real fireOppose = 0.0
public static real soilOppose = 0.0
public static real waterOppose = 0.0
public static real iceOppose = 0.0
public static real windOppose = 0.0
public static real lightOppose = 0.0
public static real darkOppose = 0.0
public static real woodOppose = 0.0
public static real thunderOppose = 0.0
public static real poisonOppose = 0.0
public static real ghostOppose = 0.0
public static real metalOppose = 0.0
public static real dragonOppose = 0.0
 public static real lifeBackVal = 0.0
 public static real lifeBackDuring = 0.0
 public static real manaBackVal = 0.0
 public static real manaBackDuring = 0.0
 public static real attackSpeedVal = 0.0
 public static real attackSpeedDuring = 0.0
 public static real attackPhysicalVal = 0.0
 public static real attackPhysicalDuring = 0.0
 public static real attackMagicVal = 0.0
 public static real attackMagicDuring = 0.0
 public static real attackRangeVal = 0.0
 public static real attackRangeDuring = 0.0
 public static real sightVal = 0.0
 public static real sightDuring = 0.0
 public static real moveVal = 0.0
 public static real moveDuring = 0.0
 public static real aimVal = 0.0
 public static real aimDuring = 0.0
 public static real strVal = 0.0
 public static real strDuring = 0.0
 public static real agiVal = 0.0
 public static real agiDuring = 0.0
 public static real intVal = 0.0
 public static real intDuring = 0.0
 public static real knockingVal = 0.0
 public static real knockingDuring = 0.0
 public static real violenceVal = 0.0
 public static real violenceDuring = 0.0
 public static real hemophagiaVal = 0.0
 public static real hemophagiaDuring = 0.0
 public static real hemophagiaSkillVal = 0.0
 public static real hemophagiaSkillDuring = 0.0
 public static real splitVal = 0.0
 public static real splitDuring = 0.0
 public static real luckVal = 0.0
 public static real luckDuring = 0.0
 public static real huntAmplitudeVal = 0.0
 public static real huntAmplitudeDuring = 0.0
 public static real fireVal = 0.0
 public static real fireDuring = 0.0
 public static real soilVal = 0.0
 public static real soilDuring = 0.0
 public static real waterVal = 0.0
 public static real waterDuring = 0.0
 public static real iceVal = 0.0
 public static real iceDuring = 0.0
 public static real windVal = 0.0
 public static real windDuring = 0.0
 public static real lightVal = 0.0
 public static real lightDuring = 0.0
 public static real darkVal = 0.0
 public static real darkDuring = 0.0
 public static real woodVal = 0.0
 public static real woodDuring = 0.0
 public static real thunderVal = 0.0
 public static real thunderDuring = 0.0
 public static real poisonVal = 0.0
 public static real poisonDuring = 0.0
 public static real ghostVal = 0.0
 public static real ghostDuring = 0.0
 public static real metalVal = 0.0
 public static real metalDuring = 0.0
 public static real dragonVal = 0.0
 public static real dragonDuring = 0.0
 public static real fireOpposeVal = 0.0
 public static real fireOpposeDuring = 0.0
 public static real soilOpposeVal = 0.0
 public static real soilOpposeDuring = 0.0
 public static real waterOpposeVal = 0.0
 public static real waterOpposeDuring = 0.0
 public static real iceOpposeVal = 0.0
 public static real iceOpposeDuring = 0.0
 public static real windOpposeVal = 0.0
 public static real windOpposeDuring = 0.0
 public static real lightOpposeVal = 0.0
 public static real lightOpposeDuring = 0.0
 public static real darkOpposeVal = 0.0
 public static real darkOpposeDuring = 0.0
 public static real woodOpposeVal = 0.0
 public static real woodOpposeDuring = 0.0
 public static real thunderOpposeVal = 0.0
 public static real thunderOpposeDuring = 0.0
 public static real poisonOpposeVal = 0.0
 public static real poisonOpposeDuring = 0.0
 public static real ghostOpposeVal = 0.0
 public static real ghostOpposeDuring = 0.0
 public static real metalOpposeVal = 0.0
 public static real metalOpposeDuring = 0.0
 public static real dragonOpposeVal = 0.0
 public static real dragonOpposeDuring = 0.0
 public static real toxicVal = 0.0
 public static real toxicDuring = 0.0
 public static real burnVal = 0.0
 public static real burnDuring = 0.0
 public static real dryVal = 0.0
 public static real dryDuring = 0.0
 public static real freezeVal = 0.0
 public static real freezeDuring = 0.0
 public static real coldVal = 0.0
 public static real coldDuring = 0.0
 public static real bluntVal = 0.0
 public static real bluntDuring = 0.0
 public static real myopiaVal = 0.0
 public static real myopiaDuring = 0.0
 public static real muggleVal = 0.0
 public static real muggleDuring = 0.0
 public static real blindVal = 0.0
 public static real blindDuring = 0.0
 public static real corrosionVal = 0.0
 public static real corrosionDuring = 0.0
 public static real chaosVal = 0.0
 public static real chaosDuring = 0.0
 public static real twineVal = 0.0
 public static real twineDuring = 0.0
 public static real drunkVal = 0.0
 public static real drunkDuring = 0.0
 public static real tortuaVal = 0.0
 public static real tortuaDuring = 0.0
 public static real weakVal = 0.0
 public static real weakDuring = 0.0
 public static real astrictVal = 0.0
 public static real astrictDuring = 0.0
 public static real foolishVal = 0.0
 public static real foolishDuring = 0.0
 public static real dullVal = 0.0
 public static real dullDuring = 0.0
 public static real dirtVal = 0.0
 public static real dirtDuring = 0.0
 public static real swimOdds = 0.0
 public static real swimDuring = 0.0
 public static real heavyOdds = 0.0
 public static real heavyVal = 0.0
 public static real breakOdds = 0.0
 public static real breakDuring = 0.0
 public static real unluckVal = 0.0
 public static real unluckDuring = 0.0
 public static real silentOdds = 0.0
 public static real silentDuring = 0.0
 public static real unarmOdds = 0.0
 public static real unarmDuring = 0.0
 public static real fetterOdds = 0.0
 public static real fetterDuring = 0.0
 public static real bombVal = 0.0
 public static real bombOdds = 0.0
 public static string bombModel = ""
 public static real lightningChainVal = 0.0
 public static real lightningChainOdds = 0.0
 public static real lightningChainQty = 0.0
 public static real lightningChainReduce = 0.0
 public static string lightningChainModel = ""
 public static real crackFlyVal = 0.0
 public static real crackFlyOdds = 0.0
 public static real crackFlyDistance = 0.0
 public static real crackFlyHigh = 0.0
	
	static method create takes nothing returns hAttrBean
        local hAttrBean x
        set x = hAttrBean.allocate()
        
set x.life = 0
set x.mana = 0
set x.move = 0
set x.defend  = 0
set x.attackSpeed = 0
set x.attackHuntType = ""
set x.attackPhysical = 0
set x.attackMagic = 0
set x.attackRange = 0
set x.sight = 0
set x.str = 0
set x.agi = 0
set x.int = 0
set x.strWhite = 0
set x.agiWhite = 0
set x.intWhite = 0
set x.lifeBack = 0
set x.lifeSource = 0
set x.lifeSourceCurrent = 0
set x.manaBack = 0
set x.manaSource = 0
set x.manaSourceCurrent = 0
set x.resistance = 0
set x.toughness = 0
set x.avoid = 0
set x.aim = 0
set x.knocking = 0
set x.violence = 0
set x.punish = 0
set x.punishCurrent = 0
set x.meditative = 0
set x.help = 0
set x.hemophagia = 0
set x.hemophagiaSkill = 0
set x.split = 0
set x.splitRange = 0
set x.goldRatio = 0
set x.lumberRatio = 0
set x.expRatio = 0
set x.luck = 0
set x.invincible = 0
set x.weight = 0
set x.weightCurrent = 0
set x.huntAmplitude = 0
set x.huntRebound = 0
set x.cure = 0
set x.knockingOppose = 0
set x.violenceOppose = 0
set x.hemophagiaOppose = 0
set x.splitOppose = 0
set x.punishOppose = 0
set x.huntReboundOppose = 0
set x.swimOppose = 0
set x.heavyOppose = 0
set x.breakOppose = 0
set x.unluckOppose = 0
set x.silentOppose = 0
set x.unarmOppose = 0
set x.fetterOppose = 0
set x.bombOppose = 0
set x.lightningChainOppose = 0
set x.crackFlyOppose = 0
set x.fire = 0
set x.soil = 0
set x.water = 0
set x.ice = 0
set x.wind = 0
set x.light = 0
set x.dark = 0
set x.wood = 0
set x.thunder = 0
set x.poison = 0
set x.ghost = 0
set x.metal = 0
set x.dragon = 0
set x.fireOppose = 0
set x.soilOppose = 0
set x.waterOppose = 0
set x.iceOppose = 0
set x.windOppose = 0
set x.lightOppose = 0
set x.darkOppose = 0
set x.woodOppose = 0
set x.thunderOppose = 0
set x.poisonOppose = 0
set x.ghostOppose = 0
set x.metalOppose = 0
set x.dragonOppose = 0
 set x.lifeBackVal = 0.0
 set x.lifeBackDuring = 0.0
 set x.manaBackVal = 0.0
 set x.manaBackDuring = 0.0
 set x.attackSpeedVal = 0.0
 set x.attackSpeedDuring = 0.0
 set x.attackPhysicalVal = 0.0
 set x.attackPhysicalDuring = 0.0
 set x.attackMagicVal = 0.0
 set x.attackMagicDuring = 0.0
 set x.attackRangeVal = 0.0
 set x.attackRangeDuring = 0.0
 set x.sightVal = 0.0
 set x.sightDuring = 0.0
 set x.moveVal = 0.0
 set x.moveDuring = 0.0
 set x.aimVal = 0.0
 set x.aimDuring = 0.0
 set x.strVal = 0.0
 set x.strDuring = 0.0
 set x.agiVal = 0.0
 set x.agiDuring = 0.0
 set x.intVal = 0.0
 set x.intDuring = 0.0
 set x.knockingVal = 0.0
 set x.knockingDuring = 0.0
 set x.violenceVal = 0.0
 set x.violenceDuring = 0.0
 set x.hemophagiaVal = 0.0
 set x.hemophagiaDuring = 0.0
 set x.hemophagiaSkillVal = 0.0
 set x.hemophagiaSkillDuring = 0.0
 set x.splitVal = 0.0
 set x.splitDuring = 0.0
 set x.luckVal = 0.0
 set x.luckDuring = 0.0
 set x.huntAmplitudeVal = 0.0
 set x.huntAmplitudeDuring = 0.0
 set x.fireVal = 0.0
 set x.fireDuring = 0.0
 set x.soilVal = 0.0
 set x.soilDuring = 0.0
 set x.waterVal = 0.0
 set x.waterDuring = 0.0
 set x.iceVal = 0.0
 set x.iceDuring = 0.0
 set x.windVal = 0.0
 set x.windDuring = 0.0
 set x.lightVal = 0.0
 set x.lightDuring = 0.0
 set x.darkVal = 0.0
 set x.darkDuring = 0.0
 set x.woodVal = 0.0
 set x.woodDuring = 0.0
 set x.thunderVal = 0.0
 set x.thunderDuring = 0.0
 set x.poisonVal = 0.0
 set x.poisonDuring = 0.0
 set x.ghostVal = 0.0
 set x.ghostDuring = 0.0
 set x.metalVal = 0.0
 set x.metalDuring = 0.0
 set x.dragonVal = 0.0
 set x.dragonDuring = 0.0
 set x.fireOpposeVal = 0.0
 set x.fireOpposeDuring = 0.0
 set x.soilOpposeVal = 0.0
 set x.soilOpposeDuring = 0.0
 set x.waterOpposeVal = 0.0
 set x.waterOpposeDuring = 0.0
 set x.iceOpposeVal = 0.0
 set x.iceOpposeDuring = 0.0
 set x.windOpposeVal = 0.0
 set x.windOpposeDuring = 0.0
 set x.lightOpposeVal = 0.0
 set x.lightOpposeDuring = 0.0
 set x.darkOpposeVal = 0.0
 set x.darkOpposeDuring = 0.0
 set x.woodOpposeVal = 0.0
 set x.woodOpposeDuring = 0.0
 set x.thunderOpposeVal = 0.0
 set x.thunderOpposeDuring = 0.0
 set x.poisonOpposeVal = 0.0
 set x.poisonOpposeDuring = 0.0
 set x.ghostOpposeVal = 0.0
 set x.ghostOpposeDuring = 0.0
 set x.metalOpposeVal = 0.0
 set x.metalOpposeDuring = 0.0
 set x.dragonOpposeVal = 0.0
 set x.dragonOpposeDuring = 0.0
 set x.toxicVal = 0.0
 set x.toxicDuring = 0.0
 set x.burnVal = 0.0
 set x.burnDuring = 0.0
 set x.dryVal = 0.0
 set x.dryDuring = 0.0
 set x.freezeVal = 0.0
 set x.freezeDuring = 0.0
 set x.coldVal = 0.0
 set x.coldDuring = 0.0
 set x.bluntVal = 0.0
 set x.bluntDuring = 0.0
 set x.myopiaVal = 0.0
 set x.myopiaDuring = 0.0
 set x.muggleVal = 0.0
 set x.muggleDuring = 0.0
 set x.blindVal = 0.0
 set x.blindDuring = 0.0
 set x.corrosionVal = 0.0
 set x.corrosionDuring = 0.0
 set x.chaosVal = 0.0
 set x.chaosDuring = 0.0
 set x.twineVal = 0.0
 set x.twineDuring = 0.0
 set x.drunkVal = 0.0
 set x.drunkDuring = 0.0
 set x.tortuaVal = 0.0
 set x.tortuaDuring = 0.0
 set x.weakVal = 0.0
 set x.weakDuring = 0.0
 set x.astrictVal = 0.0
 set x.astrictDuring = 0.0
 set x.foolishVal = 0.0
 set x.foolishDuring = 0.0
 set x.dullVal = 0.0
 set x.dullDuring = 0.0
 set x.dirtVal = 0.0
 set x.dirtDuring = 0.0
 set x.swimOdds = 0.0
 set x.swimDuring = 0.0
 set x.heavyOdds = 0.0
 set x.heavyVal = 0.0
 set x.breakOdds = 0.0
 set x.breakDuring = 0.0
 set x.unluckVal = 0.0
 set x.unluckDuring = 0.0
 set x.silentOdds = 0.0
 set x.silentDuring = 0.0
 set x.unarmOdds = 0.0
 set x.unarmDuring = 0.0
 set x.fetterOdds = 0.0
 set x.fetterDuring = 0.0
 set x.bombVal = 0.0
 set x.bombOdds = 0.0
 set x.bombModel = ""
 set x.lightningChainVal = 0.0
 set x.lightningChainOdds = 0.0
 set x.lightningChainQty = 0.0
 set x.lightningChainReduce = 0.0
 set x.lightningChainModel = ""
 set x.crackFlyVal = 0.0
 set x.crackFlyOdds = 0.0
 set x.crackFlyDistance = 0.0
 set x.crackFlyHigh = 0.0
        return x
    endmethod
    method destroy takes nothing returns nothing
set life = 0
set mana = 0
set move = 0
set defend  = 0
set attackSpeed = 0
set attackHuntType = ""
set attackPhysical = 0
set attackMagic = 0
set attackRange = 0
set sight = 0
set str = 0
set agi = 0
set int = 0
set strWhite = 0
set agiWhite = 0
set intWhite = 0
set lifeBack = 0
set lifeSource = 0
set lifeSourceCurrent = 0
set manaBack = 0
set manaSource = 0
set manaSourceCurrent = 0
set resistance = 0
set toughness = 0
set avoid = 0
set aim = 0
set knocking = 0
set violence = 0
set punish = 0
set punishCurrent = 0
set meditative = 0
set help = 0
set hemophagia = 0
set hemophagiaSkill = 0
set split = 0
set splitRange = 0
set goldRatio = 0
set lumberRatio = 0
set expRatio = 0
set luck = 0
set invincible = 0
set weight = 0
set weightCurrent = 0
set huntAmplitude = 0
set huntRebound = 0
set cure = 0
set knockingOppose = 0
set violenceOppose = 0
set hemophagiaOppose = 0
set splitOppose = 0
set punishOppose = 0
set huntReboundOppose = 0
set swimOppose = 0
set heavyOppose = 0
set breakOppose = 0
set unluckOppose = 0
set silentOppose = 0
set unarmOppose = 0
set fetterOppose = 0
set bombOppose = 0
set lightningChainOppose = 0
set crackFlyOppose = 0
set fire = 0
set soil = 0
set water = 0
set ice = 0
set wind = 0
set light = 0
set dark = 0
set wood = 0
set thunder = 0
set poison = 0
set ghost = 0
set metal = 0
set dragon = 0
set fireOppose = 0
set soilOppose = 0
set waterOppose = 0
set iceOppose = 0
set windOppose = 0
set lightOppose = 0
set darkOppose = 0
set woodOppose = 0
set thunderOppose = 0
set poisonOppose = 0
set ghostOppose = 0
set metalOppose = 0
set dragonOppose = 0
 set lifeBackVal = 0.0
 set lifeBackDuring = 0.0
 set manaBackVal = 0.0
 set manaBackDuring = 0.0
 set attackSpeedVal = 0.0
 set attackSpeedDuring = 0.0
 set attackPhysicalVal = 0.0
 set attackPhysicalDuring = 0.0
 set attackMagicVal = 0.0
 set attackMagicDuring = 0.0
 set attackRangeVal = 0.0
 set attackRangeDuring = 0.0
 set sightVal = 0.0
 set sightDuring = 0.0
 set moveVal = 0.0
 set moveDuring = 0.0
 set aimVal = 0.0
 set aimDuring = 0.0
 set strVal = 0.0
 set strDuring = 0.0
 set agiVal = 0.0
 set agiDuring = 0.0
 set intVal = 0.0
 set intDuring = 0.0
 set knockingVal = 0.0
 set knockingDuring = 0.0
 set violenceVal = 0.0
 set violenceDuring = 0.0
 set hemophagiaVal = 0.0
 set hemophagiaDuring = 0.0
 set hemophagiaSkillVal = 0.0
 set hemophagiaSkillDuring = 0.0
 set splitVal = 0.0
 set splitDuring = 0.0
 set luckVal = 0.0
 set luckDuring = 0.0
 set huntAmplitudeVal = 0.0
 set huntAmplitudeDuring = 0.0
 set fireVal = 0.0
 set fireDuring = 0.0
 set soilVal = 0.0
 set soilDuring = 0.0
 set waterVal = 0.0
 set waterDuring = 0.0
 set iceVal = 0.0
 set iceDuring = 0.0
 set windVal = 0.0
 set windDuring = 0.0
 set lightVal = 0.0
 set lightDuring = 0.0
 set darkVal = 0.0
 set darkDuring = 0.0
 set woodVal = 0.0
 set woodDuring = 0.0
 set thunderVal = 0.0
 set thunderDuring = 0.0
 set poisonVal = 0.0
 set poisonDuring = 0.0
 set ghostVal = 0.0
 set ghostDuring = 0.0
 set metalVal = 0.0
 set metalDuring = 0.0
 set dragonVal = 0.0
 set dragonDuring = 0.0
 set fireOpposeVal = 0.0
 set fireOpposeDuring = 0.0
 set soilOpposeVal = 0.0
 set soilOpposeDuring = 0.0
 set waterOpposeVal = 0.0
 set waterOpposeDuring = 0.0
 set iceOpposeVal = 0.0
 set iceOpposeDuring = 0.0
 set windOpposeVal = 0.0
 set windOpposeDuring = 0.0
 set lightOpposeVal = 0.0
 set lightOpposeDuring = 0.0
 set darkOpposeVal = 0.0
 set darkOpposeDuring = 0.0
 set woodOpposeVal = 0.0
 set woodOpposeDuring = 0.0
 set thunderOpposeVal = 0.0
 set thunderOpposeDuring = 0.0
 set poisonOpposeVal = 0.0
 set poisonOpposeDuring = 0.0
 set ghostOpposeVal = 0.0
 set ghostOpposeDuring = 0.0
 set metalOpposeVal = 0.0
 set metalOpposeDuring = 0.0
 set dragonOpposeVal = 0.0
 set dragonOpposeDuring = 0.0
 set toxicVal = 0.0
 set toxicDuring = 0.0
 set burnVal = 0.0
 set burnDuring = 0.0
 set dryVal = 0.0
 set dryDuring = 0.0
 set freezeVal = 0.0
 set freezeDuring = 0.0
 set coldVal = 0.0
 set coldDuring = 0.0
 set bluntVal = 0.0
 set bluntDuring = 0.0
 set myopiaVal = 0.0
 set myopiaDuring = 0.0
 set muggleVal = 0.0
 set muggleDuring = 0.0
 set blindVal = 0.0
 set blindDuring = 0.0
 set corrosionVal = 0.0
 set corrosionDuring = 0.0
 set chaosVal = 0.0
 set chaosDuring = 0.0
 set twineVal = 0.0
 set twineDuring = 0.0
 set drunkVal = 0.0
 set drunkDuring = 0.0
 set tortuaVal = 0.0
 set tortuaDuring = 0.0
 set weakVal = 0.0
 set weakDuring = 0.0
 set astrictVal = 0.0
 set astrictDuring = 0.0
 set foolishVal = 0.0
 set foolishDuring = 0.0
 set dullVal = 0.0
 set dullDuring = 0.0
 set dirtVal = 0.0
 set dirtDuring = 0.0
 set swimOdds = 0.0
 set swimDuring = 0.0
 set heavyOdds = 0.0
 set heavyVal = 0.0
 set breakOdds = 0.0
 set breakDuring = 0.0
 set unluckVal = 0.0
 set unluckDuring = 0.0
 set silentOdds = 0.0
 set silentDuring = 0.0
 set unarmOdds = 0.0
 set unarmDuring = 0.0
 set fetterOdds = 0.0
 set fetterDuring = 0.0
 set bombVal = 0.0
 set bombOdds = 0.0
 set bombModel = ""
 set lightningChainVal = 0.0
 set lightningChainOdds = 0.0
 set lightningChainQty = 0.0
 set lightningChainReduce = 0.0
 set lightningChainModel = ""
 set crackFlyVal = 0.0
 set crackFlyOdds = 0.0
 set crackFlyDistance = 0.0
 set crackFlyHigh = 0.0
    endmethod
endstruct

struct hAttr

	private static integer ATTR_FLAG_UNIT = 1
	private static integer ATTR_FLAG_IS_PUNISH = 2

    private static integer ATTR_FLAG_LIFE = 7
    private static integer ATTR_FLAG_MANA = 8
    private static integer ATTR_FLAG_MOVE = 9
    private static integer ATTR_FLAG_DEFEND = 10
    private static integer ATTR_FLAG_ATTACK_SPEED = 12
	private static integer ATTR_FLAG_ATTACK_SPEED_SPACE = 13
    private static integer ATTR_FLAG_ATTACK_HUNT_TYPE = 14
    private static integer ATTR_FLAG_ATTACK_PHYSICAL = 15
    private static integer ATTR_FLAG_ATTACK_MAGIC = 16
    private static integer ATTR_FLAG_ATTACK_RANGE = 17
    private static integer ATTR_FLAG_SIGHT = 18
    private static integer ATTR_FLAG_STR = 19
    private static integer ATTR_FLAG_AGI = 20
    private static integer ATTR_FLAG_INT = 21
    private static integer ATTR_FLAG_STR_WHITE = 22
    private static integer ATTR_FLAG_AGI_WHITE = 23
    private static integer ATTR_FLAG_INT_WHITE = 24

	private static integer ATTR_FLAG_UP_LIFE_BACK = 1001
	private static integer ATTR_FLAG_UP_LIFE_SOURCE = 1002
	private static integer ATTR_FLAG_UP_LIFE_SOURCE_CURRENT = 1003
	private static integer ATTR_FLAG_UP_MANA_BACK = 1004
	private static integer ATTR_FLAG_UP_MANA_SOURCE = 1005
	private static integer ATTR_FLAG_UP_MANA_SOURCE_CURRENT = 1006
	private static integer ATTR_FLAG_UP_RESISTANCE = 1007
	private static integer ATTR_FLAG_UP_TOUGHNESS = 1008
	private static integer ATTR_FLAG_UP_AVOID = 1009
	private static integer ATTR_FLAG_UP_AIM = 1010
	private static integer ATTR_FLAG_UP_KNOCKING = 1011
	private static integer ATTR_FLAG_UP_VIOLENCE = 1012
	private static integer ATTR_FLAG_UP_PUNISH = 1013
	private static integer ATTR_FLAG_UP_PUNISH_CURRENT = 1014
	private static integer ATTR_FLAG_UP_MEDITATIVE = 1015
	private static integer ATTR_FLAG_UP_HELP = 1016
	private static integer ATTR_FLAG_UP_HEMOPHAGIA = 1017
	private static integer ATTR_FLAG_UP_HEMOPHAGIA_SKILL = 1018
	private static integer ATTR_FLAG_UP_SPLIT = 1019
	private static integer ATTR_FLAG_UP_SPLIT_RANGE = 1020
	private static integer ATTR_FLAG_UP_LUCK = 1021
	private static integer ATTR_FLAG_UP_INVINCIBLE = 1022
	private static integer ATTR_FLAG_UP_WEIGHT = 1023
	private static integer ATTR_FLAG_UP_WEIGHT_CURRENT = 1024
	private static integer ATTR_FLAG_UP_HUNT_AMPLITUDE = 1025
	private static integer ATTR_FLAG_UP_HUNT_REBOUND = 1026
	private static integer ATTR_FLAG_UP_CURE = 1027
	private static integer ATTR_FLAG_UP_KNOCKING_OPPOSE = 1028
	private static integer ATTR_FLAG_UP_VIOLENCE_OPPOSE = 1029
	private static integer ATTR_FLAG_UP_HEMOPHAGIA_OPPOSE = 1030
	private static integer ATTR_FLAG_UP_SPLIT_OPPOSE = 1031
	private static integer ATTR_FLAG_UP_PUNISH_OPPOSE = 1032
	private static integer ATTR_FLAG_UP_HUNT_REBOUND_OPPOSE = 1033
	private static integer ATTR_FLAG_UP_SWIM_OPPOSE = 1034
	private static integer ATTR_FLAG_UP_HEAVY_OPPOSE = 1035
	private static integer ATTR_FLAG_UP_BREAK_OPPOSE = 1036
	private static integer ATTR_FLAG_UP_UNLUCK_OPPOSE = 1037
	private static integer ATTR_FLAG_UP_SILENT_OPPOSE = 1038
	private static integer ATTR_FLAG_UP_UNARM_OPPOSE = 1039
	private static integer ATTR_FLAG_UP_FETTER_OPPOSE = 1040
	private static integer ATTR_FLAG_UP_BOMB_OPPOSE = 1041
	private static integer ATTR_FLAG_UP_LIGHTNING_CHAIN_OPPOSE = 1042
	private static integer ATTR_FLAG_UP_CRACK_FLY_OPPOSE = 1043

	static method create takes nothing returns hAttr
        local hAttr x
        set x = hAttr.allocate()
        return x
    endmethod

	//单位注册所有属性技能
	public static method regAllAttrSkill takes unit whichUnit returns nothing
		//生命魔法
		call UnitAddAbility( whichUnit, Attr_Ability_life_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_10000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_100000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_1000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_10000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_100000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_10000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_100000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_1000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_10000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_life_FU_100000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_10000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_100000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_1000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_10000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_100000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_1 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_10 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_100 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_1000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_10000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_100000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_1000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_10000000 )
		call UnitAddAbility( whichUnit, Attr_Ability_mana_FU_100000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_100000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_1000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_10000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_100000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_100000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_1000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_10000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_life_FU_100000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_100000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_1000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_10000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_100000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_1 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_10 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_100 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_1000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_10000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_100000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_1000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_10000000 )
		call UnitRemoveAbility( whichUnit, Attr_Ability_mana_FU_100000000 )
		//物品栏
        if(GetUnitAbilityLevel(whichUnit,ITEM_ABILITY)<1)then
            call UnitAddAbility(whichUnit, ITEM_ABILITY)
            call UnitRemoveAbility(whichUnit, ITEM_ABILITY)
        endif
		//绿字攻击
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_100)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_10000000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_100000000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_10000000)
        call UnitAddAbility( whichUnit , Attr_Ability_attack_magic_FU_100000000)
		//绿色属性
		call UnitAddAbility( whichUnit , Attr_Ability_str_1)
        call UnitAddAbility( whichUnit , Attr_Ability_str_10)
        call UnitAddAbility( whichUnit , Attr_Ability_str_100)
        call UnitAddAbility( whichUnit , Attr_Ability_str_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_10000000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_str_FU_10000000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_1)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_10)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_100)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_10000000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_agi_FU_10000000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_1)
        call UnitAddAbility( whichUnit , Attr_Ability_int_10)
        call UnitAddAbility( whichUnit , Attr_Ability_int_100)
        call UnitAddAbility( whichUnit , Attr_Ability_int_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_10000000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_1000000)
        call UnitAddAbility( whichUnit , Attr_Ability_int_FU_10000000)
        //攻击速度
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_100)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_attackSpeed_FU_1000)
        //防御
		call UnitAddAbility( whichUnit , Attr_Ability_defend_1)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_10)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_100)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_100000)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_1)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_10)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_100)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_1000)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_10000)
        call UnitAddAbility( whichUnit , Attr_Ability_defend_FU_100000)

        //设定特殊技能永久性
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_1 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_10 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_100 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_1000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_10000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_100000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_1000000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_10000000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_100000000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_1 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_10 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_100 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_1000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_10000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_100000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_1000000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_10000000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attack_physical_FU_100000000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_100000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_1000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_10000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_100000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_1000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_str_FU_10000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_100000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_1000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_10000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_100000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_1000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_agi_FU_1000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_100000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_1000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_10000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_100000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_1000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_int_FU_10000000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_attackSpeed_FU_1000)
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_100000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_1)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_10)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_100)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_1000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_10000)
        call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_defend_FU_100000)
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_50 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_100 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_200 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_300 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_400 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_1000 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_FU_50 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_FU_100 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_FU_200 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_FU_300 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_FU_400 )
		call UnitMakeAbilityPermanent( whichUnit , true, Attr_Ability_sight_FU_1000 )
		// 
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1,   	1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_10,  	1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_100, 	1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1000,	1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1,  	1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_10, 	1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_100,	1 )
    	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1000,	1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100000,  1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100000,  1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100000000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1000,    1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1000000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100000000,   1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1,        1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10,       1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100,      1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000000,     1 )
        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000000,     1 )
		if(his.hero(whichUnit)==true)then
			call UnitAddAbility( whichUnit , ITEM_ABILITY_SEPARATE)
			call UnitMakeAbilityPermanent( whichUnit , true, ITEM_ABILITY_SEPARATE)
        	call SetUnitAbilityLevel( whichUnit , ITEM_ABILITY_SEPARATE, 1 )
		endif
	endmethod

	/**
     * 为单位添加N个同样的生命魔法技能 1级设0 2级设负 负减法（卡血牌bug）
     */
    private static method setLM takes unit u,integer abilityId ,integer qty returns nothing
    	local integer i = 1
    	if( qty <= 0 )then
	    	return
		endif
    	loop
	    	exitwhen i > qty
	    		call UnitAddAbility( u, abilityId )
	    		call SetUnitAbilityLevel( u, abilityId, 2 )
	    		call UnitRemoveAbility( u, abilityId )
	    	set i = i+1
    	endloop
    endmethod

	/**
     * 为单位添加N个同样的视野技能
     */
    private static method setSightAbility takes unit u,integer abilityId ,integer qty returns nothing
    	local integer i = 1
    	if( qty <= 0 )then
	    	return
		endif
    	loop
	    	exitwhen i > qty
	    		call UnitAddAbility( u, abilityId )
	    	set i = i+1
    	endloop
    endmethod

    /**
     * 为单位添加N个同样的攻击之书 （ITEM_ABILITY 为物品栏技能）
     */
    private static method setWhiteAttack takes unit u,integer itemId ,integer qty returns nothing
    	local integer i = 1
    	local item it = null
    	local integer itemBox = GetUnitAbilityLevel(u, ITEM_ABILITY)
    	if( qty <= 0 )then
	    	return
		endif
		if(itemBox < 1)then
			call UnitAddAbility(u, ITEM_ABILITY)
		endif
    	loop
	    	exitwhen i > qty
		    	set it = CreateItem( itemId , 0, 0)
				call hitem.setIsHjass(it,true)
		    	call UnitAddItem(u,it)
		    	call hitem.del(it,0)
				set it = null
	    	set i = i+1
    	endloop
    	if(itemBox < 1)then
			call UnitRemoveAbility(u, ITEM_ABILITY)
		endif
    endmethod

	//设定属性(即时/计时)
	//白字攻击	-999999999 ～ 999999999
	//绿字攻击	-999999999 ～ 999999999
	//攻速 		-9999% ～ 9999%<*实际上为-80% ～ 400%>
	//视野 		-2050 ～ 2050（视野设定以50一个间隔设定，如/-50/0/50/500/950，自动退一法归50，例如即使你设为1/21/44会归为0，151/199会归为150）
	//射程 		0 ～ 
    //力敏智		～
    //力敏智(绿)	-99999999 ～ 99999999
    //护甲		-999999 ～ 999999
    //活力 魔法	1 ～ 9999999999
    //硬直    	1 ～
    //物暴 术暴 分裂 回避 移动力 力量 敏捷 智力 救助力 吸血 负重 各率 下限：0
	private static method setAttrDo takes integer flag , unit whichUnit , real diff returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local real currentVal = 0
		local real futureVal = 0
		local integer level = 0
		local real tempPercent = 0
		local real tempCure = 0
		local integer tempInt = 0
		if( diff!=0 )then
			// 生命
			if( flag == ATTR_FLAG_LIFE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal >= ATTR_MAX_LIFE ) then
					if( currentVal >= ATTR_MAX_LIFE ) then
						set diff = 0
					else
						set diff = ATTR_MAX_LIFE - currentVal
					endif
				elseif( futureVal <= ATTR_MIN_LIFE ) then
					if( currentVal <= ATTR_MIN_LIFE ) then
						set diff = 0
					else
						set diff = ATTR_MIN_LIFE - currentVal
					endif
				endif
				set tempInt = R2I(diff)
				if( tempInt>0 )then
					set level = tempInt/100000000
					set tempInt = tempInt - (tempInt/100000000)*100000000
					call setLM( whichUnit , Attr_Ability_life_100000000 , level )
					set level = tempInt/10000000
					set tempInt = tempInt - (tempInt/10000000)*10000000
					call setLM( whichUnit , Attr_Ability_life_10000000 , level )
					set level = tempInt/1000000
					set tempInt = tempInt - (tempInt/1000000)*1000000
					call setLM( whichUnit , Attr_Ability_life_1000000 , level )
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_life_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_life_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_life_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_life_100  , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_life_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_life_1 , level )
				elseif( tempInt<0 )then
					set tempInt = IAbsBJ(tempInt)
					set level = tempInt/100000000
					set tempInt = tempInt - (tempInt/100000000)*100000000
					call setLM( whichUnit , Attr_Ability_life_FU_100000000 , level )
					set level = tempInt/10000000
					set tempInt = tempInt - (tempInt/10000000)*10000000
					call setLM( whichUnit , Attr_Ability_life_FU_10000000 , level )
					set level = tempInt/1000000
					set tempInt = tempInt - (tempInt/1000000)*1000000
					call setLM( whichUnit , Attr_Ability_life_FU_1000000 , level )
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_life_FU_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_life_FU_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_life_FU_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_life_FU_100 , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_life_FU_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_life_FU_1 , level )
				endif
				return
			endif
			// 魔法
			if( flag == ATTR_FLAG_MANA ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal >= ATTR_MAX_MANA ) then
					if( currentVal >= ATTR_MAX_MANA ) then
						set diff = 0
					else
						set diff = ATTR_MAX_MANA - currentVal
					endif
				elseif( futureVal <= ATTR_MIN_MANA ) then
					if( currentVal <= ATTR_MIN_MANA ) then
						set diff = 0
					else
						set diff = ATTR_MIN_MANA - currentVal
					endif
				endif
				set tempInt = R2I(diff)
				if( tempInt>0 )then
					set level = tempInt/100000000
					set tempInt = tempInt - (tempInt/100000000)*100000000
					call setLM( whichUnit , Attr_Ability_mana_100000000 , level )
					set level = tempInt/10000000
					set tempInt = tempInt - (tempInt/10000000)*10000000
					call setLM( whichUnit , Attr_Ability_mana_10000000 , level )
					set level = tempInt/1000000
					set tempInt = tempInt - (tempInt/1000000)*1000000
					call setLM( whichUnit , Attr_Ability_mana_1000000 , level )
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_mana_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_mana_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_mana_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_mana_100  , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_mana_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_mana_1 , level )
				elseif( tempInt<0 )then
					set tempInt = IAbsBJ(tempInt)
					set level = tempInt/100000000
					set tempInt = tempInt - (tempInt/100000000)*100000000
					call setLM( whichUnit , Attr_Ability_mana_FU_100000000 , level )
					set level = tempInt/10000000
					set tempInt = tempInt - (tempInt/10000000)*10000000
					call setLM( whichUnit , Attr_Ability_mana_FU_10000000 , level )
					set level = tempInt/1000000
					set tempInt = tempInt - (tempInt/1000000)*1000000
					call setLM( whichUnit , Attr_Ability_mana_FU_1000000 , level )
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setLM( whichUnit , Attr_Ability_mana_FU_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setLM( whichUnit , Attr_Ability_mana_FU_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setLM( whichUnit , Attr_Ability_mana_FU_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setLM( whichUnit , Attr_Ability_mana_FU_100 , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setLM( whichUnit , Attr_Ability_mana_FU_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setLM( whichUnit , Attr_Ability_mana_FU_1 , level )
				endif
				return
			endif
			// 移动
			if( flag == ATTR_FLAG_MOVE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal < 0 ) then
					call SetUnitMoveSpeed( whichUnit , 0 )
				else
					if(hcamera.model=="zoomin")then
						call SetUnitMoveSpeed( whichUnit , R2I(futureVal*0.5) )
					else
						call SetUnitMoveSpeed( whichUnit , R2I(futureVal) )
					endif
				endif
				return
			endif
			// 护甲
			if( flag == ATTR_FLAG_DEFEND ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal < -ATTR_MAX_DEFEND ) then
					set futureVal = -ATTR_MAX_DEFEND
				elseif( futureVal > ATTR_MAX_DEFEND ) then
					set futureVal = ATTR_MAX_DEFEND
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100000,    1 )
		        set tempInt = R2I(futureVal)
				if(tempInt>=0)then
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
			        call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_defend_FU_1, tempInt+1 )
		        endif
				return
			endif
			// 攻击速度
		    if( flag == ATTR_FLAG_ATTACK_SPEED ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal < ATTR_MIN_ATTACK_SPEED ) then
					set futureVal = ATTR_MIN_ATTACK_SPEED
				elseif( futureVal > ATTR_MAX_ATTACK_SPEED ) then
					set futureVal = ATTR_MAX_ATTACK_SPEED
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1,  1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_10, 1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_100,1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1000,1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1,  1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_10, 1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_100,1 )
	        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1000,1 )
	        	set tempInt = R2I(futureVal)
	        	if(tempInt>0)then
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1000, tempInt/1000+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_100, tempInt/100+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_10, tempInt/10+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_1, tempInt+1 )
		        elseif(tempInt<0)then
		            set tempInt = IAbsBJ(tempInt)
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1000, tempInt/1000+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_100, tempInt/100+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_10, tempInt/10+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attackSpeed_FU_1, tempInt+1 )
		        endif
				//修改攻速间隔
				call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_SPEED_SPACE , hunit.getAttackSpeedBaseSpace(GetUnitTypeId(whichUnit))/(1+futureVal*0.01) )
				return
			endif
			// 物理攻击
			if( flag == ATTR_FLAG_ATTACK_PHYSICAL ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if(futureVal > ATTR_MAX_ATTACK_PHYSICAL or futureVal < -ATTR_MAX_ATTACK_PHYSICAL)then
					set diff = 0
				endif
		        set tempInt = R2I(diff)
		        if( tempInt>0 )then
					set level = tempInt/100000000
					set tempInt = tempInt - (tempInt/100000000)*100000000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_100000000 , level )
					set level = tempInt/10000000
					set tempInt = tempInt - (tempInt/10000000)*10000000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_10000000 , level )
					set level = tempInt/1000000
					set tempInt = tempInt - (tempInt/1000000)*1000000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_1000000 , level )
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_100  , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_item_1 , level )
				elseif( tempInt<0 )then
					set tempInt = IAbsBJ(tempInt)
					set level = tempInt/100000000
					set tempInt = tempInt - (tempInt/100000000)*100000000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_100000000 , level )
					set level = tempInt/10000000
					set tempInt = tempInt - (tempInt/10000000)*10000000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_10000000 , level )
					set level = tempInt/1000000
					set tempInt = tempInt - (tempInt/1000000)*1000000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_1000000 , level )
					set level = tempInt/100000
					set tempInt = tempInt - (tempInt/100000)*100000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_100000 , level )
					set level = tempInt/10000
					set tempInt = tempInt - (tempInt/10000)*10000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_10000 , level )
					set level = tempInt/1000
					set tempInt = tempInt - (tempInt/1000)*1000
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_1000 , level )
					set level = tempInt/100
					set tempInt = tempInt - (tempInt/100)*100
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_100 , level )
					set level = tempInt/10
					set tempInt = tempInt - (tempInt/10)*10
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_10 , level )
					set level = tempInt/1
					set tempInt = tempInt - (tempInt/1)*1
					call setWhiteAttack( whichUnit , Attr_Ability_attack_physical_FU_item_1 , level )
				endif
				return
			endif
			// 魔法攻击
			if( flag == ATTR_FLAG_ATTACK_MAGIC ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_ATTACK_MAGIC) then
					set futureVal = ATTR_MAX_ATTACK_MAGIC
				elseif( futureVal < -ATTR_MAX_ATTACK_MAGIC ) then
					set futureVal = -ATTR_MAX_ATTACK_MAGIC
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100000000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1000,    1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1000000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000000,   1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100000000,   1 )
		        set tempInt = R2I(futureVal)
				if(tempInt>=0)then
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100000000, (tempInt/100000000)+1 )
		            set tempInt = tempInt - (tempInt/100000000)*100000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*10000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100000000, (tempInt/100000000)+1 )
		            set tempInt = tempInt - (tempInt/100000000)*10000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*10000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_attack_magic_FU_1, tempInt+1 )
				endif
				return
			endif
			// 攻击范围
			if( flag == ATTR_FLAG_ATTACK_RANGE ) then
				set futureVal = LoadReal( hash_attr , uhid , flag ) + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if(futureVal < 550)then
					set futureVal = 550
				endif
				if(hcamera.model=="zoomin")then
					set futureVal = futureVal * 0.5
				endif
				call SetUnitAcquireRange( whichUnit, futureVal*1.1 )
				return
			endif
			// 视野
			if( flag == ATTR_FLAG_SIGHT ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal < -ATTR_MAX_SIGHT ) then
					set futureVal = -ATTR_MAX_SIGHT
				elseif( futureVal > ATTR_MAX_SIGHT ) then
					set futureVal = ATTR_MAX_SIGHT
				endif
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_50 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_100 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_200 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_300 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_400 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_1000 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_FU_50 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_FU_100 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_FU_200 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_FU_300 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_FU_400 )
				call UnitRemoveAbility( whichUnit , Attr_Ability_sight_FU_1000 )
				set tempInt = hlogic.iabs(R2I(futureVal) / 50)
				if(hlogic.imod(tempInt,2) == 1)then
					call UnitAddAbility(whichUnit,Attr_Ability_sight_50)// is50
					set tempInt = (tempInt-1) * 50
				else
					set tempInt = tempInt * 50
				endif
				if(tempInt > 0)then
					if(futureVal > 0)then
						if(tempInt >= 1000)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_1000)
							set tempInt = tempInt - 1000
						endif
						if(tempInt == 0)then//nothing
						elseif(tempInt == 100)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_100)
						elseif(tempInt == 200)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_200)
						elseif(tempInt == 300)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_300)
						elseif(tempInt == 400)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_400)
						elseif(tempInt == 500)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_100)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_400)
						elseif(tempInt == 600)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_200)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_400)
						elseif(tempInt == 700)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_400)
						elseif(tempInt == 800)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_100)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_400)
						elseif(tempInt == 900)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_200)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_400)
						elseif(tempInt == 1000)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_100)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_200)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_400)
						endif
					else
						if(tempInt >= 1000)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_1000)
							set tempInt = tempInt - 1000
						endif
						if(tempInt == 0)then//nothing
						elseif(tempInt == 100)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_100)
						elseif(tempInt == 200)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_200)
						elseif(tempInt == 300)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_300)
						elseif(tempInt == 400)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_400)
						elseif(tempInt == 500)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_100)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_400)
						elseif(tempInt == 600)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_200)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_400)
						elseif(tempInt == 700)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_400)
						elseif(tempInt == 800)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_100)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_400)
						elseif(tempInt == 900)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_200)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_400)
						elseif(tempInt == 1000)then
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_100)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_200)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_300)
							call UnitAddAbility(whichUnit,Attr_Ability_sight_FU_400)
						endif
					endif
				endif
				return
			endif
			// 绿字力量
			if( flag == ATTR_FLAG_STR ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_STR_GREEN) then
					set futureVal = ATTR_MAX_STR_GREEN
				elseif( futureVal < -ATTR_MAX_STR_GREEN ) then
					set futureVal = -ATTR_MAX_STR_GREEN
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*10000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*10000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_str_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_AGI ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_AGI_GREEN) then
					set futureVal = ATTR_MAX_AGI_GREEN
				elseif( futureVal < -ATTR_MAX_AGI_GREEN ) then
					set futureVal = -ATTR_MAX_AGI_GREEN
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_agi_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_INT ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				if( futureVal > ATTR_MAX_INT_GREEN) then
					set futureVal = ATTR_MAX_INT_GREEN
				elseif( futureVal < -ATTR_MAX_INT_GREEN ) then
					set futureVal = -ATTR_MAX_INT_GREEN
				endif
				call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1,        1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10,       1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100,      1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000000,     1 )
		        call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000000,     1 )
		        set tempInt = R2I(futureVal)
		        if(tempInt>=0)then
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*10000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		        	call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_1, tempInt+1 )
		        else
		            set tempInt = IAbsBJ(tempInt)
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000000, (tempInt/10000000)+1 )
		            set tempInt = tempInt - (tempInt/10000000)*10000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000000, (tempInt/1000000)+1 )
		            set tempInt = tempInt - (tempInt/1000000)*1000000
					call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100000, (tempInt/100000)+1 )
		            set tempInt = tempInt - (tempInt/100000)*100000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10000, (tempInt/10000)+1 )
		            set tempInt = tempInt - (tempInt/10000)*10000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1000, (tempInt/1000)+1 )
		            set tempInt = tempInt - (tempInt/1000)*1000
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_100, (tempInt/100)+1 )
		            set tempInt = tempInt - (tempInt/100)*100
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_10, (tempInt/10)+1 )
		            set tempInt = tempInt - (tempInt/10)*10
		            call SetUnitAbilityLevel( whichUnit , Attr_Ability_int_FU_1, tempInt+1 )
		        endif
			elseif( flag == ATTR_FLAG_STR_WHITE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				call SetHeroStr( whichUnit , R2I(futureVal) , true )
			elseif( flag == ATTR_FLAG_AGI_WHITE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				call SetHeroAgi( whichUnit , R2I(futureVal) , true )
			elseif( flag == ATTR_FLAG_INT_WHITE ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
				set futureVal = currentVal + diff
				call SaveReal( hash_attr , uhid , flag , futureVal )
				call SetHeroInt( whichUnit , R2I(futureVal) , true )
            //TODO - EXT
			elseif( flag == ATTR_FLAG_UP_LIFE_BACK ) then
				set futureVal = LoadReal( hash_attr , uhid , flag ) + diff
				if (hlogic.rabs(futureVal) > 0.02) then
					call hgroup.in(whichUnit, ATTR_GROUP_LIFE_BACK)
				elseif (hlogic.rabs(futureVal) < 0.02) then
					call hgroup.out(whichUnit, ATTR_GROUP_LIFE_BACK)
				endif
                call SaveReal( hash_attr , uhid , flag , futureVal )
			elseif( flag == ATTR_FLAG_UP_MANA_BACK ) then
				set futureVal = LoadReal( hash_attr , uhid , flag ) + diff
				if (hlogic.rabs(futureVal) > 0.02) then
					call hgroup.in(whichUnit, ATTR_GROUP_MANA_BACK)
				elseif (hlogic.rabs(futureVal) < 0.02) then
					call hgroup.out(whichUnit, ATTR_GROUP_MANA_BACK)
				endif
                call SaveReal( hash_attr , uhid , flag , futureVal )
			elseif( flag == ATTR_FLAG_UP_LIFE_SOURCE_CURRENT ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
                set futureVal = currentVal + diff
                if( futureVal > LoadReal( hash_attr , uhid , ATTR_FLAG_UP_LIFE_SOURCE ) ) then
                    set futureVal = LoadReal( hash_attr , uhid , ATTR_FLAG_UP_LIFE_SOURCE )
                endif
				if (futureVal > 1 ) then
					call hgroup.in(whichUnit, ATTR_GROUP_LIFE_SOURCE)
				elseif (futureVal < 1 ) then
					call hgroup.out(whichUnit, ATTR_GROUP_LIFE_SOURCE)
				endif
                call SaveReal( hash_attr , uhid , flag , futureVal )
			elseif( flag == ATTR_FLAG_UP_MANA_SOURCE_CURRENT ) then
				set currentVal = LoadReal( hash_attr , uhid , flag )
                set futureVal = currentVal + diff
                if( futureVal > LoadReal( hash_attr , uhid , ATTR_FLAG_UP_MANA_SOURCE ) ) then
                    set futureVal = LoadReal( hash_attr , uhid , ATTR_FLAG_UP_MANA_SOURCE )
                endif
				if (futureVal > 1 ) then
					call hgroup.in(whichUnit, ATTR_GROUP_MANA_SOURCE)
				elseif (futureVal < 1 ) then
					call hgroup.out(whichUnit, ATTR_GROUP_MANA_SOURCE)
				endif
                call SaveReal( hash_attr , uhid , flag , futureVal )
            elseif( flag == ATTR_FLAG_UP_PUNISH and hunit.isOpenPunish(whichUnit)) then
                set currentVal = LoadReal( hash_attr , uhid , flag )
                set futureVal = currentVal + diff
                call SaveReal( hash_attr , uhid , flag , futureVal )
                if( currentVal > 0 ) then
                    set tempPercent = futureVal / currentVal
                    call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , tempPercent*LoadReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH_CURRENT ) )
                else
                    call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , futureVal )
                endif
            elseif( flag == ATTR_FLAG_UP_PUNISH_CURRENT and hunit.isOpenPunish(whichUnit)) then
                set currentVal = LoadReal( hash_attr , uhid , flag )
                set futureVal = currentVal + diff
                if( futureVal > LoadReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH ) ) then
                    set futureVal = LoadReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH )
                endif
                call SaveReal( hash_attr , uhid , flag , futureVal )
            else
                call SaveReal( hash_attr , uhid , flag , LoadReal( hash_attr , uhid , flag ) + diff )
            endif
		endif//diff
	endmethod

	private static method setAttrDuring takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer flag = htime.getInteger(t,1)
		local unit whichUnit = htime.getUnit(t,2)
		local real diff = htime.getReal(t,3)
		call htime.delTimer( t )
		call setAttrDo( flag , whichUnit , diff )
		set t = null
		set whichUnit = null
	endmethod

	//验证单位是否初始化过参数
	public static method initAttr takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		local integer judgeHandleId = LoadInteger( hash_attr , uhid , ATTR_FLAG_UNIT )
		local real tempReal = 0
		if( uhid != judgeHandleId ) then
            //call hconsole.log(GetUnitName(whichUnit)+"准备注册技能")
			call regAllAttrSkill(whichUnit)//注册技能
            //call hconsole.log(GetUnitName(whichUnit)+"完成技能注册")
			call SaveInteger( hash_attr , uhid , ATTR_FLAG_UNIT , uhid )
			//todo 变量初始化
			call SaveReal( hash_attr , uhid , ATTR_FLAG_LIFE , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit) )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_MANA , GetUnitStateSwap(UNIT_STATE_MAX_MANA, whichUnit) )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_DEFEND , 0 )
            call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_SPEED , 0 )
            call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_SPEED_SPACE , DEFAULT_ATTACK_SPEED_SPACE )
			call SaveStr( hash_attr , uhid , ATTR_FLAG_ATTACK_HUNT_TYPE , "physicalmagic" )//攻击类型默认物理+魔法(攻击类型不能为空)
			call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_PHYSICAL , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_MAGIC , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_STR , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_AGI , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_INT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_STR_WHITE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_AGI_WHITE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_INT_WHITE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_MOVE , GetUnitDefaultMoveSpeed(whichUnit) )
			if(hcamera.model=="zoomin")then
				call SetUnitMoveSpeed( whichUnit , R2I(LoadReal( hash_attr , uhid , ATTR_FLAG_MOVE)*0.5) )
			endif
			//todo 设定默认值
			if( his.hero(whichUnit) ) then
				//白字
				set tempReal = I2R(GetHeroStr(whichUnit, false))
				call SaveReal( hash_attr , uhid , ATTR_FLAG_STR_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*0.2 )
				call setAttrDo( ATTR_FLAG_LIFE , whichUnit , tempReal*5 )

				set tempReal = I2R(GetHeroAgi(whichUnit, false))
				call SaveReal( hash_attr , uhid , ATTR_FLAG_AGI_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , tempReal*0.3 )
				call setAttrDo( ATTR_FLAG_ATTACK_SPEED , whichUnit , tempReal*0.05 )

				set tempReal = I2R(GetHeroInt(whichUnit, false))
				call SaveReal( hash_attr , uhid , ATTR_FLAG_INT_WHITE , tempReal )
				call setAttrDo( ATTR_FLAG_ATTACK_MAGIC , whichUnit , tempReal*0.3 )
				call setAttrDo( ATTR_FLAG_MANA , whichUnit , tempReal*5 )
			endif
            //EXT
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_LIFE_BACK , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_LIFE_SOURCE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_MANA_BACK , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_MANA_SOURCE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_MANA_SOURCE_CURRENT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_RESISTANCE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_TOUGHNESS , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_AVOID , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_AIM , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_KNOCKING , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_VIOLENCE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_MEDITATIVE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HELP , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HEMOPHAGIA , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HEMOPHAGIA_SKILL , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_SPLIT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_SPLIT_RANGE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_LUCK , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_INVINCIBLE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_WEIGHT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_WEIGHT_CURRENT , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HUNT_AMPLITUDE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HUNT_REBOUND , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_CURE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_KNOCKING_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_VIOLENCE_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HEMOPHAGIA_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_SPLIT_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HUNT_REBOUND_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_SWIM_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_HEAVY_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_BREAK_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_UNLUCK_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_SILENT_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_UNARM_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_FETTER_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_BOMB_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_LIGHTNING_CHAIN_OPPOSE , 0 )
			call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_CRACK_FLY_OPPOSE , 0 )
            //todo 设定默认值
            if( his.hero(whichUnit) ) then
                //白字
                set tempReal = I2R(GetHeroStr(whichUnit, false))
                call setAttrDo( ATTR_FLAG_UP_TOUGHNESS , whichUnit , tempReal*0.2 )
                call setAttrDo( ATTR_FLAG_UP_KNOCKING , whichUnit , tempReal*5 )
                call setAttrDo( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , tempReal*0.03 )
                set tempReal = I2R(GetHeroAgi(whichUnit, false))
                call setAttrDo( ATTR_FLAG_UP_KNOCKING , whichUnit , tempReal*3 )
                call setAttrDo( ATTR_FLAG_UP_AVOID , whichUnit , tempReal*0.02 )
                set tempReal = I2R(GetHeroInt(whichUnit, false))
                call setAttrDo( ATTR_FLAG_UP_MANA_BACK , whichUnit , tempReal*0.2 )
                call setAttrDo( ATTR_FLAG_UP_VIOLENCE , whichUnit , tempReal*10 )
                call setAttrDo( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , tempReal*0.02 )
                //救助力
                call setAttrDo( ATTR_FLAG_UP_HELP , whichUnit , 100 + 2 * I2R(GetHeroLevel(whichUnit)-1) )
                //负重
                call setAttrDo( ATTR_FLAG_UP_WEIGHT , whichUnit , 10.00 + 0.25 * I2R(GetHeroLevel(whichUnit)-1) )
                //源
                call setAttrDo( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , 10 * I2R(GetHeroLevel(whichUnit)-1) )
                call setAttrDo( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , 10 * I2R(GetHeroLevel(whichUnit)-1) )
				//给予默认攻击距离,先判断全局有没有设定过这一个单位类型的攻击距离，大于 1 则使用，否则使用默认的近战100，远程600
				if(hunit.getAttackRange(GetUnitTypeId(whichUnit)) > 1)then
					call setAttrDo( ATTR_FLAG_ATTACK_RANGE , whichUnit , hunit.getAttackRange(GetUnitTypeId(whichUnit)) )
				else
					if(his.melee(whichUnit))then // 近战
						call setAttrDo( ATTR_FLAG_ATTACK_RANGE , whichUnit , 100 )
					elseif(his.ranged(whichUnit))then // 远程
						call setAttrDo( ATTR_FLAG_ATTACK_RANGE , whichUnit , 600 )
					endif
				endif
            endif
            call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)/2 )
            call SaveReal( hash_attr , uhid , ATTR_FLAG_UP_PUNISH_CURRENT , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit)/2 )
			return true
		endif
		return false
	endmethod

	// 检查单位是否已经init
	public static method isInit takes unit whichUnit returns boolean
		local integer uhid = GetHandleId(whichUnit)
		return LoadInteger( hash_attr , uhid , ATTR_FLAG_UNIT ) == uhid
	endmethod

	public static method resetSkill takes unit whichUnit returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local real life = LoadReal( hash_attr , uhid , ATTR_FLAG_LIFE )
		local real mana = LoadReal( hash_attr , uhid , ATTR_FLAG_MANA )
		local real move = LoadReal( hash_attr , uhid , ATTR_FLAG_MOVE )
		local real strGreen = LoadReal( hash_attr , uhid , ATTR_FLAG_STR )
		local real agiGreen = LoadReal( hash_attr , uhid , ATTR_FLAG_AGI )
		local real intGreen = LoadReal( hash_attr , uhid , ATTR_FLAG_INT )
		local real strWhite = LoadReal( hash_attr , uhid , ATTR_FLAG_STR_WHITE )
		local real agiWhite = LoadReal( hash_attr , uhid , ATTR_FLAG_AGI_WHITE )
		local real intWhite = LoadReal( hash_attr , uhid , ATTR_FLAG_INT_WHITE )
		local real attackPhysical = LoadReal( hash_attr , uhid , ATTR_FLAG_ATTACK_PHYSICAL )
		local real attackMagic = LoadReal( hash_attr , uhid , ATTR_FLAG_ATTACK_MAGIC )
		local real attackSpeed = LoadReal( hash_attr , uhid , ATTR_FLAG_ATTACK_SPEED )
		local real defend = LoadReal( hash_attr , uhid , ATTR_FLAG_DEFEND )
		//注册技能
		call regAllAttrSkill(whichUnit)
		//弥补属性
		call SetHeroStr(whichUnit,R2I(strWhite),true)
		call SetHeroAgi(whichUnit,R2I(agiWhite),true)
		call SetHeroInt(whichUnit,R2I(intWhite),true)
		if( move < 0 ) then
			call SetUnitMoveSpeed( whichUnit , 0 )
		else
			if(hcamera.model=="zoomin")then
				call SetUnitMoveSpeed( whichUnit , R2I(move*0.5) )
			else
				call SetUnitMoveSpeed( whichUnit , R2I(move) )
			endif
		endif

		call SaveReal( hash_attr , uhid , ATTR_FLAG_LIFE , GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit) )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_MANA , GetUnitStateSwap(UNIT_STATE_MAX_MANA, whichUnit) )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_DEFEND , 0 )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_SPEED , 0 )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_PHYSICAL , 0 )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_ATTACK_MAGIC , 0 )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_STR , 0 )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_AGI , 0 )
		call SaveReal( hash_attr , uhid , ATTR_FLAG_INT , 0 )

		call thistype.addLife(whichUnit,life-GetUnitStateSwap(UNIT_STATE_MAX_LIFE, whichUnit),0)
		call thistype.addMana(whichUnit,mana-GetUnitStateSwap(UNIT_STATE_MAX_MANA, whichUnit),0)
		call thistype.addStr(whichUnit,strGreen,0)
		call thistype.addAgi(whichUnit,agiGreen,0)
		call thistype.addInt(whichUnit,intGreen,0)
		call thistype.addAttackPhysical(whichUnit,attackPhysical,0)
		call thistype.addAttackMagic(whichUnit,attackMagic,0)
		call thistype.addAttackSpeed(whichUnit,attackSpeed,0)
		call thistype.addDefend(whichUnit,defend,0)
	endmethod

	public static method resetAttrGroups takes unit whichUnit returns nothing
		local integer uhid = GetHandleId(whichUnit)
		if (hgroup.isIn(whichUnit,ATTR_GROUP_LIFE_BACK) == false and hlogic.rabs(LoadReal(hash_attr , uhid , ATTR_FLAG_UP_LIFE_BACK)) > 0.02)then
			call GroupAddUnit(ATTR_GROUP_LIFE_BACK,whichUnit)
		endif
		if (hgroup.isIn(whichUnit,ATTR_GROUP_MANA_BACK) == false and  hlogic.rabs(LoadReal(hash_attr , uhid , ATTR_FLAG_UP_MANA_BACK)) > 0.02)then
			call GroupAddUnit(ATTR_GROUP_MANA_BACK,whichUnit)
		endif
		if (hgroup.isIn(whichUnit,ATTR_GROUP_LIFE_SOURCE) == false and  hlogic.rabs(LoadReal(hash_attr , uhid , ATTR_FLAG_UP_LIFE_SOURCE)) > 1)then
			call GroupAddUnit(ATTR_GROUP_LIFE_SOURCE,whichUnit)
		endif
		if (hgroup.isIn(whichUnit,ATTR_GROUP_MANA_SOURCE) == false and  hlogic.rabs(LoadReal(hash_attr , uhid , ATTR_FLAG_UP_MANA_SOURCE)) > 1)then
			call GroupAddUnit(ATTR_GROUP_MANA_SOURCE,whichUnit)
		endif
	endmethod

	private static method setAttr takes integer flag , unit whichUnit , real diff , real during returns nothing
		local integer uhid = GetHandleId(whichUnit)
		local timer t = null
		local real tempCure = 0
		call initAttr( whichUnit )
		// 处理治疗增益
		if(diff > 0 and (flag == ATTR_FLAG_UP_LIFE_BACK or flag == ATTR_FLAG_UP_MANA_BACK))then
			set tempCure = LoadReal(hash_attr , uhid , ATTR_FLAG_UP_CURE)
			if(tempCure < 0.01 and tempCure > -0.01)then
				// nothing
			elseif(tempCure < -100)then
				set diff = 0
			else
				set diff = diff * ((tempCure + 100) * 0.01)
			endif
		endif
		call setAttrDo( flag , whichUnit , diff )
		if( during > 0.01 ) then
			set t = htime.setTimeout( during , function thistype.setAttrDuring )
			call htime.setInteger(t,1,flag)
			call htime.setUnit(t,2,whichUnit)
			call htime.setReal(t,3, -diff )
			set t = null
		endif
	endmethod

	private static method getAttr takes integer flag , unit whichUnit returns real
		call initAttr( whichUnit )
		return LoadReal( hash_attr , GetHandleId(whichUnit) , flag )
	endmethod

	// 使单位硬直
	private static method setPunishingOver takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local integer id = htime.getInteger(t,1)
		call htime.delTimer(t)
		call SaveBoolean( hash_attr, id , ATTR_FLAG_IS_PUNISH , false)
		set t = null
	endmethod
	public static method setPunishing takes unit whichUnit, real during returns nothing
		local boolean isPunish = LoadBoolean( hash_attr, GetHandleId(whichUnit) , ATTR_FLAG_IS_PUNISH )
		local timer t = null
		if(isPunish != true)then
			call SaveBoolean( hash_attr, GetHandleId(whichUnit) , ATTR_FLAG_IS_PUNISH , true)
			set t = htime.setTimeout(during,function thistype.setPunishingOver)
			call htime.setInteger(t,1,GetHandleId(whichUnit))
			set t = null
		endif
	endmethod
	public static method isPunishing takes unit whichUnit returns boolean
		return LoadBoolean( hash_attr, GetHandleId(whichUnit) , ATTR_FLAG_IS_PUNISH )
	endmethod


	// 生命 ------------------------------------------------------------ 
	public static method getLife takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_LIFE , whichUnit )
	endmethod
	public static method addLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , value , during )
	endmethod
	public static method subLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , -value , during )
	endmethod
	public static method setLife takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_LIFE , whichUnit , value - getLife(whichUnit) , during )
	endmethod

	// 魔法 ------------------------------------------------------------ 
	public static method getMana takes unit whichUnit returns real
	    return getAttr( ATTR_FLAG_MANA , whichUnit )
	endmethod
	public static method addMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , value , during )
	endmethod
	public static method subMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , -value , during )
	endmethod
	public static method setMana takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MANA , whichUnit , value - getMana(whichUnit) , during )
	endmethod

	// 移动力 ------------------------------------------------------------ 
	public static method getMove takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_MOVE , whichUnit )
	endmethod
	public static method addMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , value , during )
	endmethod
	public static method subMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , -value , during )
	endmethod
	public static method setMove takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_MOVE , whichUnit , value - getMove(whichUnit) , during )
	endmethod

	// 护甲 ------------------------------------------------------------ 
	public static method getDefend takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_DEFEND , whichUnit )
	endmethod
	public static method addDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , value , during )
	endmethod
	public static method subDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , -value , during )
	endmethod
	public static method setDefend takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_DEFEND , whichUnit , value - getDefend(whichUnit) , during )
	endmethod

	// 攻击速度 ------------------------------------------------------------ 
	public static method getAttackSpeed takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit )
	endmethod
	public static method addAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , value , during )
	endmethod
	public static method subAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , -value , during )
	endmethod
	public static method setAttackSpeed takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , value - getAttackSpeed(whichUnit) , during )
	endmethod

	// 攻击速度间隔 ------------------------------------------------------------ 
	public static method getAttackSpeedSpace takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_SPEED_SPACE , whichUnit )
	endmethod

    // 攻击伤害类型 ------------------------------------------------------------ 
    public static method getAttackHuntType takes unit whichUnit returns string
		call initAttr(whichUnit)
        return LoadStr(hash_attr, GetHandleId(whichUnit), ATTR_FLAG_ATTACK_HUNT_TYPE)
    endmethod
    private static method addAttackHuntTypeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit whichUnit = htime.getUnit(t,1)
        local string value = htime.getString(t,2)
        local integer hid = GetHandleId(whichUnit)
		call initAttr(whichUnit)
        call htime.delTimer(t)
        call SaveStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE,LoadStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE)+value)
		set t = null
		set whichUnit = null
		set value = null
    endmethod
    private static method subAttackHuntTypeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit whichUnit = htime.getUnit(t,1)
        local string value = htime.getString(t,2)
        local integer hid = GetHandleId(whichUnit)
        local string old = LoadStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE)
        local integer valueIndex = hlogic.strpos(old,value)
        call htime.delTimer(t)
		set t = null
		call initAttr(whichUnit)
		set whichUnit = null
        if(valueIndex==-1 or value==null)then
			set value = null
			set old = null
            return
        else
            call SaveStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE,hlogic.substr(old,0,valueIndex)+hlogic.substr(old,valueIndex+StringLength(value),StringLength(old)))
			set value = null
			set old = null
		endif
    endmethod
    private static method setAttackHuntTypeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit whichUnit = htime.getUnit(t,1)
        local string value = htime.getString(t,2)
        local integer hid = GetHandleId(whichUnit)
        call htime.delTimer(t)
		set t = null
		call initAttr(whichUnit)
		set whichUnit = null
        if(value==null)then
            return
        else
            call SaveStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE,value)
			set value = null
        endif
    endmethod
    public static method addAttackHuntType takes unit whichUnit , string value , real during returns nothing
        local integer hid = GetHandleId(whichUnit)
        local timer t = null
		call initAttr(whichUnit)
        call SaveStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE,LoadStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE)+value)
        if(during > 0)then
            set t = htime.setTimeout(during,function thistype.subAttackHuntTypeCall)
            call htime.setUnit(t,1,whichUnit)
            call htime.setString(t,2,value)
			set t = null
        endif
    endmethod
    public static method subAttackHuntType takes unit whichUnit , string value , real during returns nothing
        local integer hid = GetHandleId(whichUnit)
        local string old = LoadStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE)
        local integer valueIndex = hlogic.strpos(old,value)
        local timer t = null
		call initAttr(whichUnit)
        if(valueIndex==-1 or value==null)then
			set old = null
            return
        else
            call SaveStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE,hlogic.substr(old,0,valueIndex)+hlogic.substr(old,valueIndex+StringLength(value),StringLength(old)))
            if(during > 0)then
                set t = htime.setTimeout(during,function thistype.addAttackHuntTypeCall)
                call htime.setUnit(t,1,whichUnit)
                call htime.setString(t,2,value)
				set t = null
            endif
			set old = null
        endif
    endmethod
    public static method setAttackHuntType takes unit whichUnit , string value, real during returns nothing
		local string old = null
		local integer hid = GetHandleId(whichUnit)
		local timer t = null
		call initAttr(whichUnit)
        if(value==null)then
            return
        else
			if(during > 0)then
				set old = LoadStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE)
                set t = htime.setTimeout(during,function thistype.setAttackHuntTypeCall)
                call htime.setUnit(t,1,whichUnit)
                call htime.setString(t,2,old)
				set t = null
				set old = null
            endif
			call SaveStr(hash_attr, hid, ATTR_FLAG_ATTACK_HUNT_TYPE,value)
        endif
    endmethod

	// 物理攻击力 ------------------------------------------------------------ 
	public static method getAttackPhysical takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit )
	endmethod
	public static method addAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , value , during )
	endmethod
	public static method subAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , -value , during )
	endmethod
	public static method setAttackPhysical takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , value - getAttackPhysical(whichUnit) , during )
	endmethod

	// 魔法攻击力 ------------------------------------------------------------ 
	public static method getAttackMagic takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit )
	endmethod
	public static method addAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , value , during )
	endmethod
	public static method subAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , -value , during )
	endmethod
	public static method setAttackMagic takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , value - getAttackMagic(whichUnit) , during )
	endmethod

	// 攻击距离 ------------------------------------------------------------ 
	public static method getAttackRange takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_ATTACK_RANGE , whichUnit )
	endmethod
	public static method addAttackRange takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_RANGE , whichUnit , value , during )
	endmethod
	public static method subAttackRange takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_RANGE , whichUnit , -value , during )
	endmethod
	public static method setAttackRange takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_ATTACK_RANGE , whichUnit , value - getAttackRange(whichUnit) , during )
	endmethod

	// 视野 ------------------------------------------------------------ 
	public static method getSight takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_SIGHT , whichUnit )
	endmethod
	public static method addSight takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SIGHT , whichUnit , value , during )
	endmethod
	public static method subSight takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SIGHT , whichUnit , -value , during )
	endmethod
	public static method setSight takes unit whichUnit , real value , real during returns nothing
		call setAttr( ATTR_FLAG_SIGHT , whichUnit , value - getSight(whichUnit) , during )
	endmethod

	// 力量 ------------------------------------------------------------ 
	public static method getStr takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_STR , whichUnit )
	endmethod
	public static method setStr takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getStr(whichUnit)
		local real attackPhysical = value*0.15
		local real attackMagic = value*0.15
		local real life = value*2
		local real toughness = value*0.025
		local real knocking = value*0.25
		local real punish = value*1
		call setAttr( ATTR_FLAG_STR , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , toughness , during )
		call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , punish , during )
	endmethod
	public static method addStr takes unit whichUnit , real value , real during returns nothing
		call setStr( whichUnit , getStr(whichUnit)+value , during )
	endmethod
	public static method subStr takes unit whichUnit , real value , real during returns nothing
		call setStr( whichUnit , getStr(whichUnit)-value , during )
	endmethod

	// 敏捷 ------------------------------------------------------------ 
	public static method getAgi takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AGI , whichUnit )
	endmethod
	public static method setAgi takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getAgi(whichUnit)
		local real attackPhysical = value*0.25
		local real attackspeed = value*0.01
		local real knocking = value*0.30
		local real avoid = value*0.005
		call setAttr( ATTR_FLAG_AGI , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , attackspeed , during )
		call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , avoid , during )
	endmethod
	public static method addAgi takes unit whichUnit , real value , real during returns nothing
		call setAgi( whichUnit , getAgi(whichUnit)+value , during )
	endmethod
	public static method subAgi takes unit whichUnit , real value , real during returns nothing
		call setAgi( whichUnit , getAgi(whichUnit)-value , during )
	endmethod

	// 智力 ------------------------------------------------------------ 
	public static method getInt takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_INT , whichUnit )
	endmethod
	public static method setInt takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getInt(whichUnit)
		local real attackMagic = value*0.25
		local real mana = value*2
		local real manaback = value*0.05
		local real violence = value*0.5
		local real hemophagiaSkill = value*0.01
		call setAttr( ATTR_FLAG_INT , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_MANA , whichUnit , mana , during )
		call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , manaback , during )
		call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , violence , during )
		call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , hemophagiaSkill , during )
	endmethod
	public static method addInt takes unit whichUnit , real value , real during returns nothing
		call setInt( whichUnit , getInt(whichUnit)+value , during )
	endmethod
	public static method subInt takes unit whichUnit , real value , real during returns nothing
		call setInt( whichUnit , getInt(whichUnit)-value , during )
	endmethod

	// 力量（白字） ------------------------------------------------------------ 
	public static method getStrWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_STR_WHITE , whichUnit )
	endmethod
	public static method setStrWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getStrWhite(whichUnit)
		local real attackPhysical = value*0.30
		local real attackMagic = value*0.30
		local real life = value*4
		local real toughness = value*0.05
		local real knocking = value*0.5
		local real punish = value*2
		call setAttr( ATTR_FLAG_STR_WHITE , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_LIFE , whichUnit , life , during )
		call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , toughness , during )
		call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , punish , during )
	endmethod
	public static method addStrWhite takes unit whichUnit , real value , real during returns nothing
		call setStrWhite( whichUnit , getStrWhite(whichUnit)+value , during )
	endmethod
	public static method subStrWhite takes unit whichUnit , real value , real during returns nothing
		call setStrWhite( whichUnit , getStrWhite(whichUnit)-value , during )
	endmethod

	// 敏捷（白字） ------------------------------------------------------------ 
	public static method getAgiWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_AGI_WHITE , whichUnit )
	endmethod
	public static method setAgiWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getAgiWhite(whichUnit)
		local real attackPhysical = value*0.5
		local real attackspeed = value*0.02
		local real knocking = value*0.60
		local real avoid = value*0.01
		call setAttr( ATTR_FLAG_AGI_WHITE , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_PHYSICAL , whichUnit , attackPhysical , during )
		call setAttr( ATTR_FLAG_ATTACK_SPEED , whichUnit , attackspeed , during )
		call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , knocking , during )
		call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , avoid , during )
	endmethod
	public static method addAgiWhite takes unit whichUnit , real value , real during returns nothing
		call setAgiWhite( whichUnit , getAgiWhite(whichUnit)+value , during )
	endmethod
	public static method subAgiWhite takes unit whichUnit , real value , real during returns nothing
		call setAgiWhite( whichUnit , getAgiWhite(whichUnit)-value , during )
	endmethod

	// 智力（白字） ------------------------------------------------------------ 
	public static method getIntWhite takes unit whichUnit returns real
		return getAttr( ATTR_FLAG_INT_WHITE , whichUnit )
	endmethod
	public static method setIntWhite takes unit whichUnit , real valueSet , real during returns nothing
		local real value = valueSet - getIntWhite(whichUnit)
		local real attackMagic = value*0.5
		local real mana = value*4
		local real manaback = value*0.1
		local real violence = value*1.0
		local real hemophagiaSkill = value*0.01
		call setAttr( ATTR_FLAG_INT_WHITE , whichUnit , value , during )
		call setAttr( ATTR_FLAG_ATTACK_MAGIC , whichUnit , attackMagic , during )
		call setAttr( ATTR_FLAG_MANA , whichUnit , mana , during )
		call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , manaback , during )
		call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , violence , during )
		call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , hemophagiaSkill , during )
	endmethod
	public static method addIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)+value , during )
	endmethod
	public static method subIntWhite takes unit whichUnit , real value , real during returns nothing
		call setIntWhite( whichUnit , getIntWhite(whichUnit)-value , during )
	endmethod












    //-EXT---------------------------------------------------------------------------
    //-EXT---------------------------------------------------------------------------
    //-EXT---------------------------------------------------------------------------
    //-EXT---------------------------------------------------------------------------

// 高级属性[life_back]
public static method getLifeBack takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit )
endmethod
public static method addLifeBack takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit , value , during )
endmethod
public static method subLifeBack takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit , -value , during )
endmethod
public static method setLifeBack takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_BACK , whichUnit , value - getLifeBack(whichUnit) , during )
endmethod
// 高级属性[life_source]
public static method getLifeSource takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit )
endmethod
public static method addLifeSource takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , value , during )
endmethod
public static method subLifeSource takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , -value , during )
endmethod
public static method setLifeSource takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE , whichUnit , value - getLifeSource(whichUnit) , during )
endmethod
// 高级属性[life_source_current]
public static method getLifeSourceCurrent takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit )
endmethod
public static method addLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , value , during )
endmethod
public static method subLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , -value , during )
endmethod
public static method setLifeSourceCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIFE_SOURCE_CURRENT , whichUnit , value - getLifeSourceCurrent(whichUnit) , during )
endmethod
// 高级属性[mana_back]
public static method getManaBack takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit )
endmethod
public static method addManaBack takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , value , during )
endmethod
public static method subManaBack takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , -value , during )
endmethod
public static method setManaBack takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_BACK , whichUnit , value - getManaBack(whichUnit) , during )
endmethod
// 高级属性[mana_source]
public static method getManaSource takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit )
endmethod
public static method addManaSource takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , value , during )
endmethod
public static method subManaSource takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , -value , during )
endmethod
public static method setManaSource takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_SOURCE , whichUnit , value - getManaSource(whichUnit) , during )
endmethod
// 高级属性[mana_source_current]
public static method getManaSourceCurrent takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit )
endmethod
public static method addManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , value , during )
endmethod
public static method subManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , -value , during )
endmethod
public static method setManaSourceCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MANA_SOURCE_CURRENT , whichUnit , value - getManaSourceCurrent(whichUnit) , during )
endmethod
// 高级属性[resistance]
public static method getResistance takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit )
endmethod
public static method addResistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit , value , during )
endmethod
public static method subResistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit , -value , during )
endmethod
public static method setResistance takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_RESISTANCE , whichUnit , value - getResistance(whichUnit) , during )
endmethod
// 高级属性[toughness]
public static method getToughness takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit )
endmethod
public static method addToughness takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , value , during )
endmethod
public static method subToughness takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , -value , during )
endmethod
public static method setToughness takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_TOUGHNESS , whichUnit , value - getToughness(whichUnit) , during )
endmethod
// 高级属性[avoid]
public static method getAvoid takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_AVOID , whichUnit )
endmethod
public static method addAvoid takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , value , during )
endmethod
public static method subAvoid takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , -value , during )
endmethod
public static method setAvoid takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_AVOID , whichUnit , value - getAvoid(whichUnit) , during )
endmethod
// 高级属性[aim]
public static method getAim takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_AIM , whichUnit )
endmethod
public static method addAim takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_AIM , whichUnit , value , during )
endmethod
public static method subAim takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_AIM , whichUnit , -value , during )
endmethod
public static method setAim takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_AIM , whichUnit , value - getAim(whichUnit) , during )
endmethod
// 高级属性[knocking]
public static method getKnocking takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_KNOCKING , whichUnit )
endmethod
public static method addKnocking takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , value , during )
endmethod
public static method subKnocking takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , -value , during )
endmethod
public static method setKnocking takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_KNOCKING , whichUnit , value - getKnocking(whichUnit) , during )
endmethod
// 高级属性[violence]
public static method getViolence takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit )
endmethod
public static method addViolence takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , value , during )
endmethod
public static method subViolence takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , -value , during )
endmethod
public static method setViolence takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_VIOLENCE , whichUnit , value - getViolence(whichUnit) , during )
endmethod
// 高级属性[punish]
public static method getPunish takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_PUNISH , whichUnit )
endmethod
public static method addPunish takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , value , during )
endmethod
public static method subPunish takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , -value , during )
endmethod
public static method setPunish takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH , whichUnit , value - getPunish(whichUnit) , during )
endmethod
// 高级属性[punish_current]
public static method getPunishCurrent takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit )
endmethod
public static method addPunishCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit , value , during )
endmethod
public static method subPunishCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit , -value , during )
endmethod
public static method setPunishCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH_CURRENT , whichUnit , value - getPunishCurrent(whichUnit) , during )
endmethod
// 高级属性[meditative]
public static method getMeditative takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit )
endmethod
public static method addMeditative takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit , value , during )
endmethod
public static method subMeditative takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit , -value , during )
endmethod
public static method setMeditative takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_MEDITATIVE , whichUnit , value - getMeditative(whichUnit) , during )
endmethod
// 高级属性[help]
public static method getHelp takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HELP , whichUnit )
endmethod
public static method addHelp takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HELP , whichUnit , value , during )
endmethod
public static method subHelp takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HELP , whichUnit , -value , during )
endmethod
public static method setHelp takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HELP , whichUnit , value - getHelp(whichUnit) , during )
endmethod
// 高级属性[hemophagia]
public static method getHemophagia takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit )
endmethod
public static method addHemophagia takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit , value , during )
endmethod
public static method subHemophagia takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit , -value , during )
endmethod
public static method setHemophagia takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA , whichUnit , value - getHemophagia(whichUnit) , during )
endmethod
// 高级属性[hemophagia_skill]
public static method getHemophagiaSkill takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit )
endmethod
public static method addHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , value , during )
endmethod
public static method subHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , -value , during )
endmethod
public static method setHemophagiaSkill takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_SKILL , whichUnit , value - getHemophagiaSkill(whichUnit) , during )
endmethod
// 高级属性[split]
public static method getSplit takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_SPLIT , whichUnit )
endmethod
public static method addSplit takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT , whichUnit , value , during )
endmethod
public static method subSplit takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT , whichUnit , -value , during )
endmethod
public static method setSplit takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT , whichUnit , value - getSplit(whichUnit) , during )
endmethod
// 高级属性[split_range]
public static method getSplitRange takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_SPLIT_RANGE , whichUnit )
endmethod
public static method addSplitRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT_RANGE , whichUnit , value , during )
endmethod
public static method subSplitRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT_RANGE , whichUnit , -value , during )
endmethod
public static method setSplitRange takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT_RANGE , whichUnit , value - getSplitRange(whichUnit) , during )
endmethod
// 高级属性[luck]
public static method getLuck takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_LUCK , whichUnit )
endmethod
public static method addLuck takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LUCK , whichUnit , value , during )
endmethod
public static method subLuck takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LUCK , whichUnit , -value , during )
endmethod
public static method setLuck takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LUCK , whichUnit , value - getLuck(whichUnit) , during )
endmethod
// 高级属性[invincible]
public static method getInvincible takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit )
endmethod
public static method addInvincible takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit , value , during )
endmethod
public static method subInvincible takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit , -value , during )
endmethod
public static method setInvincible takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_INVINCIBLE , whichUnit , value - getInvincible(whichUnit) , during )
endmethod
// 高级属性[weight]
public static method getWeight takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_WEIGHT , whichUnit )
endmethod
public static method addWeight takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_WEIGHT , whichUnit , value , during )
endmethod
public static method subWeight takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_WEIGHT , whichUnit , -value , during )
endmethod
public static method setWeight takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_WEIGHT , whichUnit , value - getWeight(whichUnit) , during )
endmethod
// 高级属性[weight_current]
public static method getWeightCurrent takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit )
endmethod
public static method addWeightCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit , value , during )
endmethod
public static method subWeightCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit , -value , during )
endmethod
public static method setWeightCurrent takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_WEIGHT_CURRENT , whichUnit , value - getWeightCurrent(whichUnit) , during )
endmethod
// 高级属性[hunt_amplitude]
public static method getHuntAmplitude takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit )
endmethod
public static method addHuntAmplitude takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit , value , during )
endmethod
public static method subHuntAmplitude takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit , -value , during )
endmethod
public static method setHuntAmplitude takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_AMPLITUDE , whichUnit , value - getHuntAmplitude(whichUnit) , during )
endmethod
// 高级属性[hunt_rebound]
public static method getHuntRebound takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit )
endmethod
public static method addHuntRebound takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit , value , during )
endmethod
public static method subHuntRebound takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit , -value , during )
endmethod
public static method setHuntRebound takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND , whichUnit , value - getHuntRebound(whichUnit) , during )
endmethod
// 高级属性[cure]
public static method getCure takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_CURE , whichUnit )
endmethod
public static method addCure takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_CURE , whichUnit , value , during )
endmethod
public static method subCure takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_CURE , whichUnit , -value , during )
endmethod
public static method setCure takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_CURE , whichUnit , value - getCure(whichUnit) , during )
endmethod
// 高级属性[knocking_oppose]
public static method getKnockingOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_KNOCKING_OPPOSE , whichUnit )
endmethod
public static method addKnockingOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_KNOCKING_OPPOSE , whichUnit , value , during )
endmethod
public static method subKnockingOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_KNOCKING_OPPOSE , whichUnit , -value , during )
endmethod
public static method setKnockingOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_KNOCKING_OPPOSE , whichUnit , value - getKnockingOppose(whichUnit) , during )
endmethod
// 高级属性[violence_oppose]
public static method getViolenceOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_VIOLENCE_OPPOSE , whichUnit )
endmethod
public static method addViolenceOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_VIOLENCE_OPPOSE , whichUnit , value , during )
endmethod
public static method subViolenceOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_VIOLENCE_OPPOSE , whichUnit , -value , during )
endmethod
public static method setViolenceOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_VIOLENCE_OPPOSE , whichUnit , value - getViolenceOppose(whichUnit) , during )
endmethod
// 高级属性[hemophagia_oppose]
public static method getHemophagiaOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HEMOPHAGIA_OPPOSE , whichUnit )
endmethod
public static method addHemophagiaOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_OPPOSE , whichUnit , value , during )
endmethod
public static method subHemophagiaOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_OPPOSE , whichUnit , -value , during )
endmethod
public static method setHemophagiaOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEMOPHAGIA_OPPOSE , whichUnit , value - getHemophagiaOppose(whichUnit) , during )
endmethod
// 高级属性[split_oppose]
public static method getSplitOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_SPLIT_OPPOSE , whichUnit )
endmethod
public static method addSplitOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT_OPPOSE , whichUnit , value , during )
endmethod
public static method subSplitOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT_OPPOSE , whichUnit , -value , during )
endmethod
public static method setSplitOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SPLIT_OPPOSE , whichUnit , value - getSplitOppose(whichUnit) , during )
endmethod
// 高级属性[punish_oppose]
public static method getPunishOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_PUNISH_OPPOSE , whichUnit )
endmethod
public static method addPunishOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH_OPPOSE , whichUnit , value , during )
endmethod
public static method subPunishOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH_OPPOSE , whichUnit , -value , during )
endmethod
public static method setPunishOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_PUNISH_OPPOSE , whichUnit , value - getPunishOppose(whichUnit) , during )
endmethod
// 高级属性[hunt_rebound_oppose]
public static method getHuntReboundOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HUNT_REBOUND_OPPOSE , whichUnit )
endmethod
public static method addHuntReboundOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND_OPPOSE , whichUnit , value , during )
endmethod
public static method subHuntReboundOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND_OPPOSE , whichUnit , -value , during )
endmethod
public static method setHuntReboundOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HUNT_REBOUND_OPPOSE , whichUnit , value - getHuntReboundOppose(whichUnit) , during )
endmethod
// 高级属性[swim_oppose]
public static method getSwimOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit )
endmethod
public static method addSwimOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , value , during )
endmethod
public static method subSwimOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , -value , during )
endmethod
public static method setSwimOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SWIM_OPPOSE , whichUnit , value - getSwimOppose(whichUnit) , during )
endmethod
// 高级属性[heavy_oppose]
public static method getHeavyOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_HEAVY_OPPOSE , whichUnit )
endmethod
public static method addHeavyOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEAVY_OPPOSE , whichUnit , value , during )
endmethod
public static method subHeavyOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEAVY_OPPOSE , whichUnit , -value , during )
endmethod
public static method setHeavyOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_HEAVY_OPPOSE , whichUnit , value - getHeavyOppose(whichUnit) , during )
endmethod
// 高级属性[break_oppose]
public static method getBreakOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_BREAK_OPPOSE , whichUnit )
endmethod
public static method addBreakOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_BREAK_OPPOSE , whichUnit , value , during )
endmethod
public static method subBreakOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_BREAK_OPPOSE , whichUnit , -value , during )
endmethod
public static method setBreakOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_BREAK_OPPOSE , whichUnit , value - getBreakOppose(whichUnit) , during )
endmethod
// 高级属性[unluck_oppose]
public static method getUnluckOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_UNLUCK_OPPOSE , whichUnit )
endmethod
public static method addUnluckOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_UNLUCK_OPPOSE , whichUnit , value , during )
endmethod
public static method subUnluckOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_UNLUCK_OPPOSE , whichUnit , -value , during )
endmethod
public static method setUnluckOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_UNLUCK_OPPOSE , whichUnit , value - getUnluckOppose(whichUnit) , during )
endmethod
// 高级属性[silent_oppose]
public static method getSilentOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_SILENT_OPPOSE , whichUnit )
endmethod
public static method addSilentOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SILENT_OPPOSE , whichUnit , value , during )
endmethod
public static method subSilentOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SILENT_OPPOSE , whichUnit , -value , during )
endmethod
public static method setSilentOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_SILENT_OPPOSE , whichUnit , value - getSilentOppose(whichUnit) , during )
endmethod
// 高级属性[unarm_oppose]
public static method getUnarmOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_UNARM_OPPOSE , whichUnit )
endmethod
public static method addUnarmOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_UNARM_OPPOSE , whichUnit , value , during )
endmethod
public static method subUnarmOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_UNARM_OPPOSE , whichUnit , -value , during )
endmethod
public static method setUnarmOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_UNARM_OPPOSE , whichUnit , value - getUnarmOppose(whichUnit) , during )
endmethod
// 高级属性[fetter_oppose]
public static method getFetterOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_FETTER_OPPOSE , whichUnit )
endmethod
public static method addFetterOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_FETTER_OPPOSE , whichUnit , value , during )
endmethod
public static method subFetterOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_FETTER_OPPOSE , whichUnit , -value , during )
endmethod
public static method setFetterOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_FETTER_OPPOSE , whichUnit , value - getFetterOppose(whichUnit) , during )
endmethod
// 高级属性[bomb_oppose]
public static method getBombOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_BOMB_OPPOSE , whichUnit )
endmethod
public static method addBombOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_BOMB_OPPOSE , whichUnit , value , during )
endmethod
public static method subBombOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_BOMB_OPPOSE , whichUnit , -value , during )
endmethod
public static method setBombOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_BOMB_OPPOSE , whichUnit , value - getBombOppose(whichUnit) , during )
endmethod
// 高级属性[lightning_chain_oppose]
public static method getLightningChainOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_LIGHTNING_CHAIN_OPPOSE , whichUnit )
endmethod
public static method addLightningChainOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIGHTNING_CHAIN_OPPOSE , whichUnit , value , during )
endmethod
public static method subLightningChainOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIGHTNING_CHAIN_OPPOSE , whichUnit , -value , during )
endmethod
public static method setLightningChainOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_LIGHTNING_CHAIN_OPPOSE , whichUnit , value - getLightningChainOppose(whichUnit) , during )
endmethod
// 高级属性[crack_fly_oppose]
public static method getCrackFlyOppose takes unit whichUnit returns real
   return getAttr( ATTR_FLAG_UP_CRACK_FLY_OPPOSE , whichUnit )
endmethod
public static method addCrackFlyOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_CRACK_FLY_OPPOSE , whichUnit , value , during )
endmethod
public static method subCrackFlyOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_CRACK_FLY_OPPOSE , whichUnit , -value , during )
endmethod
public static method setCrackFlyOppose takes unit whichUnit , real value , real during returns nothing
   call setAttr( ATTR_FLAG_UP_CRACK_FLY_OPPOSE , whichUnit , value - getCrackFlyOppose(whichUnit) , during )
endmethod

endstruct
