//物品系统
/*
物品分为（item_type）
1、永久型物品 forever
2、消耗型物品 consume
3、瞬逝型 moment

每个英雄最大支持使用6件物品
支持满背包合成
物品存在重量，背包有负重，超过负重即使存在合成关系，也会被暂时禁止合成

主动指玩家需要手动触发的技能
被动指英雄不需要主动使用而是在满足特定条件后（如攻击成功时）自动触发的技能
属性有三种叠加： 线性 | 非线性 | 不叠加
属性的叠加不仅限于几率也有可能是持续时间，伤害等等
-线性：直接叠加，如：100伤害的物品，持有2件时，造成伤害将提升为200
-非线性：一般几率的计算为33%左右的叠加效益，如：30%几率的物品，持有两件时，触发几率将提升为42.9%左右
-不叠加：数量不影响几率，如：30%几率的物品，持有100件也为30%
*物品不说明的属性不涉及叠加规定，默认不叠加
*/

globals
    hItem hitem
    hashtable hash_item = null
    item hjass_global_item
    integer ITEM_ABILITY = 'AInv' //默认物品栏技能（英雄6格那个）hjass默认全部认定这个技能为物品栏，如有需要自行更改
	integer ITEM_ABILITY_SEPARATE = 'A039'
	trigger ITEM_TRIGGER_PICKUP = null
	trigger ITEM_TRIGGER_PICKUP_DEFAULT = null
	trigger ITEM_TRIGGER_PICKUP_FALSE = null
	trigger ITEM_TRIGGER_DROP = null
	trigger ITEM_TRIGGER_PAWN = null
	trigger ITEM_TRIGGER_SELL = null
	trigger ITEM_TRIGGER_SEPARATE = null
	trigger ITEM_TRIGGER_USE = null
	string HITEM_TYPE_FOREVER = "forever"
	string HITEM_TYPE_CONSUME = "consume"
	string HITEM_TYPE_MOMENT = "moment"
	integer HITEM_IS_UNIT_INIT = 10071
	integer HITEM_IS_SHOP_INIT = 10072
endglobals

struct hItemBean

    //物品设定
    public static integer item_id = 0            //物品id
    public static string item_type = "forever" 	 //物品类型
    public static integer item_overlay = 1       //最大叠加,默认1
    public static integer item_level = 1         //等级，默认1级
    public static integer item_gold = 0          //价值黄金
    public static integer item_lumber = 0        //价值木头
    public static real item_weight = 0           //重量
    public static string item_icon = ""          //物品图标路径
    //属性
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
 public static real muggleVal = 0.0
 public static real muggleDuring = 0.0
 public static real myopiaVal = 0.0
 public static real myopiaDuring = 0.0
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

    static method create takes nothing returns hItemBean
        local hItemBean x = 0
        set x = hItemBean.allocate()
        set x.item_id = 0
        set x.item_type = ""
        set x.item_overlay = 10
        set x.item_level = 1
        set x.item_gold = 0
        set x.item_lumber = 0
        set x.item_weight = 0
        set x.item_icon = ""
        //
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
 set x.muggleVal = 0.0
 set x.muggleDuring = 0.0
 set x.myopiaVal = 0.0
 set x.myopiaDuring = 0.0
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
        set item_id = 0
        set item_type = ""
        set item_overlay = 10
        set item_level = 1
        set item_gold = 0
        set item_lumber = 0
        set item_weight = 0
		set item_icon = ""
        //
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
 set muggleVal = 0.0
 set muggleDuring = 0.0
 set myopiaVal = 0.0
 set myopiaDuring = 0.0
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

struct hItem

	private static integer hk_item_is_hjass = 9
    private static integer hk_item_init = 10
    private static integer hk_item_id = 11
    private static integer hk_item_type = 12
    private static integer hk_item_overlay = 13
    private static integer hk_item_level = 14
    private static integer hk_item_gold = 15
    private static integer hk_item_lumber = 16
    private static integer hk_item_weight = 17
    private static integer hk_item_icon = 18
    private static integer hk_item_is_powerup = 19
	private static integer hk_item_combat_effectiveness = 20
	private static integer hk_item_onuse_trigger = 21
	private static integer hk_item_onmoment_trigger = 22
    //
private static integer hk_life = 1000
private static integer hk_mana = 1001
private static integer hk_move = 1002
private static integer hk_defend  = 1003
private static integer hk_attackSpeed = 1004
private static integer hk_attackHuntType = 1005
private static integer hk_attackPhysical = 1006
private static integer hk_attackMagic = 1007
private static integer hk_attackRange = 1008
private static integer hk_sight = 1009
private static integer hk_str = 1010
private static integer hk_agi = 1011
private static integer hk_int = 1012
private static integer hk_strWhite = 1013
private static integer hk_agiWhite = 1014
private static integer hk_intWhite = 1015
private static integer hk_lifeBack = 1016
private static integer hk_lifeSource = 1017
private static integer hk_lifeSourceCurrent = 1018
private static integer hk_manaBack = 1019
private static integer hk_manaSource = 1020
private static integer hk_manaSourceCurrent = 1021
private static integer hk_resistance = 1022
private static integer hk_toughness = 1023
private static integer hk_avoid = 1024
private static integer hk_aim = 1025
private static integer hk_knocking = 1026
private static integer hk_violence = 1027
private static integer hk_punish = 1028
private static integer hk_punishCurrent = 1029
private static integer hk_meditative = 1030
private static integer hk_help = 1031
private static integer hk_hemophagia = 1032
private static integer hk_hemophagiaSkill = 1033
private static integer hk_split = 1034
private static integer hk_splitRange = 1035
private static integer hk_goldRatio = 1036
private static integer hk_lumberRatio = 1037
private static integer hk_expRatio = 1038
private static integer hk_luck = 1039
private static integer hk_invincible = 1040
private static integer hk_weight = 1041
private static integer hk_weightCurrent = 1042
private static integer hk_huntAmplitude = 1043
private static integer hk_huntRebound = 1044
private static integer hk_cure = 1045
private static integer hk_knockingOppose = 1046
private static integer hk_violenceOppose = 1047
private static integer hk_hemophagiaOppose = 1048
private static integer hk_splitOppose = 1049
private static integer hk_punishOppose = 1050
private static integer hk_huntReboundOppose = 1051
private static integer hk_swimOppose = 1052
private static integer hk_heavyOppose = 1053
private static integer hk_breakOppose = 1054
private static integer hk_unluckOppose = 1055
private static integer hk_silentOppose = 1056
private static integer hk_unarmOppose = 1057
private static integer hk_fetterOppose = 1058
private static integer hk_bombOppose = 1059
private static integer hk_lightningChainOppose = 1060
private static integer hk_crackFlyOppose = 1061
private static integer hk_fire = 1062
private static integer hk_soil = 1063
private static integer hk_water = 1064
private static integer hk_ice = 1065
private static integer hk_wind = 1066
private static integer hk_light = 1067
private static integer hk_dark = 1068
private static integer hk_wood = 1069
private static integer hk_thunder = 1070
private static integer hk_poison = 1071
private static integer hk_ghost = 1072
private static integer hk_metal = 1073
private static integer hk_dragon = 1074
private static integer hk_fireOppose = 1075
private static integer hk_soilOppose = 1076
private static integer hk_waterOppose = 1077
private static integer hk_iceOppose = 1078
private static integer hk_windOppose = 1079
private static integer hk_lightOppose = 1080
private static integer hk_darkOppose = 1081
private static integer hk_woodOppose = 1082
private static integer hk_thunderOppose = 1083
private static integer hk_poisonOppose = 1084
private static integer hk_ghostOppose = 1085
private static integer hk_metalOppose = 1086
private static integer hk_dragonOppose = 1087
 private static integer hk_lifeBackVal = 10000
 private static integer hk_lifeBackDuring = 10001
 private static integer hk_manaBackVal = 10100
 private static integer hk_manaBackDuring = 10101
 private static integer hk_attackSpeedVal = 10200
 private static integer hk_attackSpeedDuring = 10201
 private static integer hk_attackPhysicalVal = 10300
 private static integer hk_attackPhysicalDuring = 10301
 private static integer hk_attackMagicVal = 10400
 private static integer hk_attackMagicDuring = 10401
 private static integer hk_attackRangeVal = 10500
 private static integer hk_attackRangeDuring = 10501
 private static integer hk_sightVal = 10600
 private static integer hk_sightDuring = 10601
 private static integer hk_moveVal = 10700
 private static integer hk_moveDuring = 10701
 private static integer hk_aimVal = 10800
 private static integer hk_aimDuring = 10801
 private static integer hk_strVal = 10900
 private static integer hk_strDuring = 10901
 private static integer hk_agiVal = 11000
 private static integer hk_agiDuring = 11001
 private static integer hk_intVal = 11100
 private static integer hk_intDuring = 11101
 private static integer hk_knockingVal = 11200
 private static integer hk_knockingDuring = 11201
 private static integer hk_violenceVal = 11300
 private static integer hk_violenceDuring = 11301
 private static integer hk_hemophagiaVal = 11400
 private static integer hk_hemophagiaDuring = 11401
 private static integer hk_hemophagiaSkillVal = 11500
 private static integer hk_hemophagiaSkillDuring = 11501
 private static integer hk_splitVal = 11600
 private static integer hk_splitDuring = 11601
 private static integer hk_luckVal = 11700
 private static integer hk_luckDuring = 11701
 private static integer hk_huntAmplitudeVal = 11800
 private static integer hk_huntAmplitudeDuring = 11801
 private static integer hk_fireVal = 11900
 private static integer hk_fireDuring = 11901
 private static integer hk_soilVal = 12000
 private static integer hk_soilDuring = 12001
 private static integer hk_waterVal = 12100
 private static integer hk_waterDuring = 12101
 private static integer hk_iceVal = 12200
 private static integer hk_iceDuring = 12201
 private static integer hk_windVal = 12300
 private static integer hk_windDuring = 12301
 private static integer hk_lightVal = 12400
 private static integer hk_lightDuring = 12401
 private static integer hk_darkVal = 12500
 private static integer hk_darkDuring = 12501
 private static integer hk_woodVal = 12600
 private static integer hk_woodDuring = 12601
 private static integer hk_thunderVal = 12700
 private static integer hk_thunderDuring = 12701
 private static integer hk_poisonVal = 12800
 private static integer hk_poisonDuring = 12801
 private static integer hk_ghostVal = 12900
 private static integer hk_ghostDuring = 12901
 private static integer hk_metalVal = 13000
 private static integer hk_metalDuring = 13001
 private static integer hk_dragonVal = 13100
 private static integer hk_dragonDuring = 13101
 private static integer hk_fireOpposeVal = 13200
 private static integer hk_fireOpposeDuring = 13201
 private static integer hk_soilOpposeVal = 13300
 private static integer hk_soilOpposeDuring = 13301
 private static integer hk_waterOpposeVal = 13400
 private static integer hk_waterOpposeDuring = 13401
 private static integer hk_iceOpposeVal = 13500
 private static integer hk_iceOpposeDuring = 13501
 private static integer hk_windOpposeVal = 13600
 private static integer hk_windOpposeDuring = 13601
 private static integer hk_lightOpposeVal = 13700
 private static integer hk_lightOpposeDuring = 13701
 private static integer hk_darkOpposeVal = 13800
 private static integer hk_darkOpposeDuring = 13801
 private static integer hk_woodOpposeVal = 13900
 private static integer hk_woodOpposeDuring = 13901
 private static integer hk_thunderOpposeVal = 14000
 private static integer hk_thunderOpposeDuring = 14001
 private static integer hk_poisonOpposeVal = 14100
 private static integer hk_poisonOpposeDuring = 14101
 private static integer hk_ghostOpposeVal = 14200
 private static integer hk_ghostOpposeDuring = 14201
 private static integer hk_metalOpposeVal = 14300
 private static integer hk_metalOpposeDuring = 14301
 private static integer hk_dragonOpposeVal = 14400
 private static integer hk_dragonOpposeDuring = 14401
 private static integer hk_toxicVal = 14500
 private static integer hk_toxicDuring = 14501
 private static integer hk_burnVal = 14600
 private static integer hk_burnDuring = 14601
 private static integer hk_dryVal = 14700
 private static integer hk_dryDuring = 14701
 private static integer hk_freezeVal = 14800
 private static integer hk_freezeDuring = 14801
 private static integer hk_coldVal = 14900
 private static integer hk_coldDuring = 14901
 private static integer hk_bluntVal = 15000
 private static integer hk_bluntDuring = 15001
 private static integer hk_muggleVal = 15100
 private static integer hk_muggleDuring = 15101
 private static integer hk_myopiaVal = 15200
 private static integer hk_myopiaDuring = 15201
 private static integer hk_blindVal = 15300
 private static integer hk_blindDuring = 15301
 private static integer hk_corrosionVal = 15400
 private static integer hk_corrosionDuring = 15401
 private static integer hk_chaosVal = 15500
 private static integer hk_chaosDuring = 15501
 private static integer hk_twineVal = 15600
 private static integer hk_twineDuring = 15601
 private static integer hk_drunkVal = 15700
 private static integer hk_drunkDuring = 15701
 private static integer hk_tortuaVal = 15800
 private static integer hk_tortuaDuring = 15801
 private static integer hk_weakVal = 15900
 private static integer hk_weakDuring = 15901
 private static integer hk_astrictVal = 16000
 private static integer hk_astrictDuring = 16001
 private static integer hk_foolishVal = 16100
 private static integer hk_foolishDuring = 16101
 private static integer hk_dullVal = 16200
 private static integer hk_dullDuring = 16201
 private static integer hk_dirtVal = 16300
 private static integer hk_dirtDuring = 16301
 private static integer hk_swimOdds = 16400
 private static integer hk_swimDuring = 16401
 private static integer hk_heavyOdds = 16500
 private static integer hk_heavyVal = 16501
 private static integer hk_breakOdds = 16600
 private static integer hk_breakDuring = 16601
 private static integer hk_unluckVal = 16700
 private static integer hk_unluckDuring = 16701
 private static integer hk_silentOdds = 16800
 private static integer hk_silentDuring = 16801
 private static integer hk_unarmOdds = 16900
 private static integer hk_unarmDuring = 16901
 private static integer hk_fetterOdds = 17000
 private static integer hk_fetterDuring = 17001
 private static integer hk_bombVal = 17100
 private static integer hk_bombOdds = 17101
 private static integer hk_bombRange = 17102
 private static integer hk_bombModel = 17103
 private static integer hk_lightningChainVal = 17200
 private static integer hk_lightningChainOdds = 17201
 private static integer hk_lightningChainQty = 17202
 private static integer hk_lightningChainReduce = 17203
 private static integer hk_lightningChainModel = 17204
 private static integer hk_crackFlyVal = 17300
 private static integer hk_crackFlyOdds = 17301
 private static integer hk_crackFlyDistance = 17302
 private static integer hk_crackFlyHigh = 17303

	/**
     * 删除物品回调
     */
    private static method delCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local item it = htime.getItem(t, 1 )
        call htime.delTimer(t)
        set t = null
        if( it != null ) then
            call FlushChildHashtable(hash_item, GetHandleId(it))
            call FlushChildHashtable(hash_trigger,GetHandleId(it))
		    call FlushChildHashtable(hash_trigger_register,GetHandleId(it))
            call SetWidgetLife(it,1.00)
	        call RemoveItem(it)
            set it = null
    	endif
    endmethod
	/**
	 * 删除物品，可延时
	 */
	public static method del takes item it,real during returns nothing
        local timer t = null
        if( during <= 0 ) then
            call FlushChildHashtable(hash_item, GetHandleId(it))
            call FlushChildHashtable(hash_trigger,GetHandleId(it))
		    call FlushChildHashtable(hash_trigger_register,GetHandleId(it))
            call SetWidgetLife(it,1.00)
            call RemoveItem(it)
            set it = null
        else
            set t = htime.setTimeout( during , function thistype.delCall)
            call htime.setItem( t, 1 ,it )
            set t = null
        endif
	endmethod

    //获取注册的物品数量
    public static method getTotalQty takes nothing returns integer
        local integer i = LoadInteger(hash_item,0,StringHash("_TOTAL_QTY_"))
        if(i<=0)then
            set i = 0
        endif
        return i
    endmethod
	//设定注册的物品数量
    public static method setTotalQty takes integer qty returns nothing
        call SaveInteger(hash_item,0,StringHash("_TOTAL_QTY_"), qty)
    endmethod


    //获取物品是否hjass内部函数创建
    public static method isHjass takes item it returns boolean
        return LoadBoolean(hash_item,GetHandleId(it),hk_item_is_hjass)
    endmethod
	//设定物品是否hjass内部函数创建
    public static method setIsHjass takes item it,boolean b returns nothing
        call SaveBoolean(hash_item,GetHandleId(it),hk_item_is_hjass, b)
    endmethod


	//获取某单位身上空格物品栏数量
    public static method getEmptySlot takes unit u returns integer
        local integer qty = UnitInventorySize(u)
        local item it = null
        local integer i = 0
        loop
            exitwhen i > 5
            set it = UnitItemInSlot(u, i)
            if(it != null and GetItemCharges(it) > 0) then
                set qty = qty - 1
            endif
            set it = null
            set i=i+1
        endloop
        return qty
    endmethod

	//获取某单位身上某种物品的使用总次数
    public static method getCharges takes integer itemId,unit u returns integer
        local integer charges = 0
        local integer i = 0
        local item it = null
        loop
            exitwhen i > 5
            set it = UnitItemInSlot(u, i)
            if(it != null and GetItemTypeId(it) == itemId and GetItemCharges(it) > 0) then
                set charges = charges + GetItemCharges(it)
            endif
            set it = null
            set i=i+1
        endloop
        return charges
    endmethod

	//绑定使用操作
	public static method onUse takes integer itemid,code func returns nothing
        local trigger tg = null
		if(itemid>0 and func!=null)then
			set tg = CreateTrigger()
			call TriggerAddAction(tg,func)
			call SaveTriggerHandle(hash_item,itemid,hk_item_onuse_trigger,tg)
            set tg = null
		endif
	endmethod 

	//触发物品的瞬逝
	private static method triggerMoment takes nothing returns nothing
        local trigger tg = null
		local unit it = hevt.getTriggerUnit()
		local unit triggerUnit = hevt.getTriggerEnterUnit()
		local integer charges = 0
		if(it!=null and triggerUnit!=null and his.hasSlot(triggerUnit) and his.alive(triggerUnit))then
			set charges = GetUnitUserData(it)
			if(charges<=0)then
				call hunit.del(it,0)
                set it = null
                set triggerUnit = null
				return
			endif
			set tg = LoadTriggerHandle(hash_item,GetUnitTypeId(it),hk_item_onmoment_trigger)
			if(tg!=null)then
				call hevt.setTriggerUnit(tg,triggerUnit)
				call hevt.setId(tg,GetUnitTypeId(it))
				call hevt.setValue(tg,charges)
				call TriggerExecute(tg)
                set tg = null
			endif
			call SetUnitUserData(it,0)
			call hunit.del(it,0)
		endif
        set it = null
        set triggerUnit = null
	endmethod

	//绑定物品的瞬逝
	public static method onMoment takes integer itid,code func returns nothing
        local trigger tg = null
		if(itid>0)then
			set tg = CreateTrigger()
			call TriggerAddAction(tg,func)
			call SaveTriggerHandle(hash_item,itid,hk_item_onmoment_trigger,tg)
            set tg = null
		endif
	endmethod

	//绑定物品到系统截断调用
    private static method formatEval takes hItemBean bean returns nothing
		local integer score = 0
        local item it = null
		local string itype = HITEM_TYPE_FOREVER
        if(bean.item_id!=0)then
			call setTotalQty(1+getTotalQty())
			set it = CreateItem(bean.item_id,0,0)
			if(IsItemPowerup(it))then
				call SaveBoolean(hash_item, bean.item_id, hk_item_is_powerup,true)
			else
				call SaveBoolean(hash_item, bean.item_id, hk_item_is_powerup,false)
			endif
			call del(it,0)
			set it = null
			if(StringLength(bean.item_type)>0)then
				set itype = bean.item_type
			endif
            call SaveBoolean(hash_item, bean.item_id, hk_item_init, true)
            call SaveStr(hash_item, bean.item_id, hk_item_type, itype)
            set itype = null
            call SaveInteger(hash_item, bean.item_id, hk_item_overlay, bean.item_overlay)
            call SaveInteger(hash_item, bean.item_id, hk_item_level, bean.item_level)
            call SaveInteger(hash_item, bean.item_id, hk_item_gold, bean.item_gold)
            call SaveInteger(hash_item, bean.item_id, hk_item_lumber, bean.item_lumber)
            call SaveReal(hash_item, bean.item_id, hk_item_weight, bean.item_weight)
            call SaveStr(hash_item, bean.item_id, hk_item_icon, bean.item_icon)
			//
			call SaveStr(hash_item, bean.item_id, hk_attackHuntType, bean.attackHuntType)
            //COPY
call SaveReal(hash_item, bean.item_id, hk_goldRatio, bean.goldRatio)
call SaveReal(hash_item, bean.item_id, hk_lumberRatio, bean.lumberRatio)
call SaveReal(hash_item, bean.item_id, hk_expRatio, bean.expRatio)
call SaveReal(hash_item, bean.item_id, hk_life, bean.life)
call SaveReal(hash_item, bean.item_id, hk_mana, bean.mana)
call SaveReal(hash_item, bean.item_id, hk_move, bean.move)
call SaveReal(hash_item, bean.item_id, hk_defend , bean.defend )
call SaveReal(hash_item, bean.item_id, hk_attackSpeed, bean.attackSpeed)
call SaveReal(hash_item, bean.item_id, hk_attackPhysical, bean.attackPhysical)
call SaveReal(hash_item, bean.item_id, hk_attackMagic, bean.attackMagic)
call SaveReal(hash_item, bean.item_id, hk_attackRange, bean.attackRange)
call SaveReal(hash_item, bean.item_id, hk_sight, bean.sight)
call SaveReal(hash_item, bean.item_id, hk_str, bean.str)
call SaveReal(hash_item, bean.item_id, hk_agi, bean.agi)
call SaveReal(hash_item, bean.item_id, hk_int, bean.int)
call SaveReal(hash_item, bean.item_id, hk_strWhite, bean.strWhite)
call SaveReal(hash_item, bean.item_id, hk_agiWhite, bean.agiWhite)
call SaveReal(hash_item, bean.item_id, hk_intWhite, bean.intWhite)
call SaveReal(hash_item, bean.item_id, hk_lifeBack, bean.lifeBack)
call SaveReal(hash_item, bean.item_id, hk_lifeSource, bean.lifeSource)
call SaveReal(hash_item, bean.item_id, hk_lifeSourceCurrent, bean.lifeSourceCurrent)
call SaveReal(hash_item, bean.item_id, hk_manaBack, bean.manaBack)
call SaveReal(hash_item, bean.item_id, hk_manaSource, bean.manaSource)
call SaveReal(hash_item, bean.item_id, hk_manaSourceCurrent, bean.manaSourceCurrent)
call SaveReal(hash_item, bean.item_id, hk_resistance, bean.resistance)
call SaveReal(hash_item, bean.item_id, hk_toughness, bean.toughness)
call SaveReal(hash_item, bean.item_id, hk_avoid, bean.avoid)
call SaveReal(hash_item, bean.item_id, hk_aim, bean.aim)
call SaveReal(hash_item, bean.item_id, hk_knocking, bean.knocking)
call SaveReal(hash_item, bean.item_id, hk_violence, bean.violence)
call SaveReal(hash_item, bean.item_id, hk_punish, bean.punish)
call SaveReal(hash_item, bean.item_id, hk_punishCurrent, bean.punishCurrent)
call SaveReal(hash_item, bean.item_id, hk_meditative, bean.meditative)
call SaveReal(hash_item, bean.item_id, hk_help, bean.help)
call SaveReal(hash_item, bean.item_id, hk_hemophagia, bean.hemophagia)
call SaveReal(hash_item, bean.item_id, hk_hemophagiaSkill, bean.hemophagiaSkill)
call SaveReal(hash_item, bean.item_id, hk_split, bean.split)
call SaveReal(hash_item, bean.item_id, hk_splitRange, bean.splitRange)
call SaveReal(hash_item, bean.item_id, hk_luck, bean.luck)
call SaveReal(hash_item, bean.item_id, hk_invincible, bean.invincible)
call SaveReal(hash_item, bean.item_id, hk_weight, bean.weight)
call SaveReal(hash_item, bean.item_id, hk_weightCurrent, bean.weightCurrent)
call SaveReal(hash_item, bean.item_id, hk_huntAmplitude, bean.huntAmplitude)
call SaveReal(hash_item, bean.item_id, hk_huntRebound, bean.huntRebound)
call SaveReal(hash_item, bean.item_id, hk_cure, bean.cure)
call SaveReal(hash_item, bean.item_id, hk_knockingOppose, bean.knockingOppose)
call SaveReal(hash_item, bean.item_id, hk_violenceOppose, bean.violenceOppose)
call SaveReal(hash_item, bean.item_id, hk_hemophagiaOppose, bean.hemophagiaOppose)
call SaveReal(hash_item, bean.item_id, hk_splitOppose, bean.splitOppose)
call SaveReal(hash_item, bean.item_id, hk_punishOppose, bean.punishOppose)
call SaveReal(hash_item, bean.item_id, hk_huntReboundOppose, bean.huntReboundOppose)
call SaveReal(hash_item, bean.item_id, hk_swimOppose, bean.swimOppose)
call SaveReal(hash_item, bean.item_id, hk_heavyOppose, bean.heavyOppose)
call SaveReal(hash_item, bean.item_id, hk_breakOppose, bean.breakOppose)
call SaveReal(hash_item, bean.item_id, hk_unluckOppose, bean.unluckOppose)
call SaveReal(hash_item, bean.item_id, hk_silentOppose, bean.silentOppose)
call SaveReal(hash_item, bean.item_id, hk_unarmOppose, bean.unarmOppose)
call SaveReal(hash_item, bean.item_id, hk_fetterOppose, bean.fetterOppose)
call SaveReal(hash_item, bean.item_id, hk_bombOppose, bean.bombOppose)
call SaveReal(hash_item, bean.item_id, hk_lightningChainOppose, bean.lightningChainOppose)
call SaveReal(hash_item, bean.item_id, hk_crackFlyOppose, bean.crackFlyOppose)
call SaveReal(hash_item, bean.item_id, hk_fire, bean.fire)
call SaveReal(hash_item, bean.item_id, hk_soil, bean.soil)
call SaveReal(hash_item, bean.item_id, hk_water, bean.water)
call SaveReal(hash_item, bean.item_id, hk_ice, bean.ice)
call SaveReal(hash_item, bean.item_id, hk_wind, bean.wind)
call SaveReal(hash_item, bean.item_id, hk_light, bean.light)
call SaveReal(hash_item, bean.item_id, hk_dark, bean.dark)
call SaveReal(hash_item, bean.item_id, hk_wood, bean.wood)
call SaveReal(hash_item, bean.item_id, hk_thunder, bean.thunder)
call SaveReal(hash_item, bean.item_id, hk_poison, bean.poison)
call SaveReal(hash_item, bean.item_id, hk_ghost, bean.ghost)
call SaveReal(hash_item, bean.item_id, hk_metal, bean.metal)
call SaveReal(hash_item, bean.item_id, hk_dragon, bean.dragon)
call SaveReal(hash_item, bean.item_id, hk_fireOppose, bean.fireOppose)
call SaveReal(hash_item, bean.item_id, hk_soilOppose, bean.soilOppose)
call SaveReal(hash_item, bean.item_id, hk_waterOppose, bean.waterOppose)
call SaveReal(hash_item, bean.item_id, hk_iceOppose, bean.iceOppose)
call SaveReal(hash_item, bean.item_id, hk_windOppose, bean.windOppose)
call SaveReal(hash_item, bean.item_id, hk_lightOppose, bean.lightOppose)
call SaveReal(hash_item, bean.item_id, hk_darkOppose, bean.darkOppose)
call SaveReal(hash_item, bean.item_id, hk_woodOppose, bean.woodOppose)
call SaveReal(hash_item, bean.item_id, hk_thunderOppose, bean.thunderOppose)
call SaveReal(hash_item, bean.item_id, hk_poisonOppose, bean.poisonOppose)
call SaveReal(hash_item, bean.item_id, hk_ghostOppose, bean.ghostOppose)
call SaveReal(hash_item, bean.item_id, hk_metalOppose, bean.metalOppose)
call SaveReal(hash_item, bean.item_id, hk_dragonOppose, bean.dragonOppose)
 call SaveReal(hash_item, bean.item_id, hk_lifeBackVal, bean.lifeBackVal)
 call SaveReal(hash_item, bean.item_id, hk_lifeBackDuring, bean.lifeBackDuring)
 call SaveReal(hash_item, bean.item_id, hk_manaBackVal, bean.manaBackVal)
 call SaveReal(hash_item, bean.item_id, hk_manaBackDuring, bean.manaBackDuring)
 call SaveReal(hash_item, bean.item_id, hk_attackSpeedVal, bean.attackSpeedVal)
 call SaveReal(hash_item, bean.item_id, hk_attackSpeedDuring, bean.attackSpeedDuring)
 call SaveReal(hash_item, bean.item_id, hk_attackPhysicalVal, bean.attackPhysicalVal)
 call SaveReal(hash_item, bean.item_id, hk_attackPhysicalDuring, bean.attackPhysicalDuring)
 call SaveReal(hash_item, bean.item_id, hk_attackMagicVal, bean.attackMagicVal)
 call SaveReal(hash_item, bean.item_id, hk_attackMagicDuring, bean.attackMagicDuring)
 call SaveReal(hash_item, bean.item_id, hk_attackRangeVal, bean.attackRangeVal)
 call SaveReal(hash_item, bean.item_id, hk_attackRangeDuring, bean.attackRangeDuring)
 call SaveReal(hash_item, bean.item_id, hk_sightVal, bean.sightVal)
 call SaveReal(hash_item, bean.item_id, hk_sightDuring, bean.sightDuring)
 call SaveReal(hash_item, bean.item_id, hk_moveVal, bean.moveVal)
 call SaveReal(hash_item, bean.item_id, hk_moveDuring, bean.moveDuring)
 call SaveReal(hash_item, bean.item_id, hk_aimVal, bean.aimVal)
 call SaveReal(hash_item, bean.item_id, hk_aimDuring, bean.aimDuring)
 call SaveReal(hash_item, bean.item_id, hk_strVal, bean.strVal)
 call SaveReal(hash_item, bean.item_id, hk_strDuring, bean.strDuring)
 call SaveReal(hash_item, bean.item_id, hk_agiVal, bean.agiVal)
 call SaveReal(hash_item, bean.item_id, hk_agiDuring, bean.agiDuring)
 call SaveReal(hash_item, bean.item_id, hk_intVal, bean.intVal)
 call SaveReal(hash_item, bean.item_id, hk_intDuring, bean.intDuring)
 call SaveReal(hash_item, bean.item_id, hk_knockingVal, bean.knockingVal)
 call SaveReal(hash_item, bean.item_id, hk_knockingDuring, bean.knockingDuring)
 call SaveReal(hash_item, bean.item_id, hk_violenceVal, bean.violenceVal)
 call SaveReal(hash_item, bean.item_id, hk_violenceDuring, bean.violenceDuring)
 call SaveReal(hash_item, bean.item_id, hk_hemophagiaVal, bean.hemophagiaVal)
 call SaveReal(hash_item, bean.item_id, hk_hemophagiaDuring, bean.hemophagiaDuring)
 call SaveReal(hash_item, bean.item_id, hk_hemophagiaSkillVal, bean.hemophagiaSkillVal)
 call SaveReal(hash_item, bean.item_id, hk_hemophagiaSkillDuring, bean.hemophagiaSkillDuring)
 call SaveReal(hash_item, bean.item_id, hk_splitVal, bean.splitVal)
 call SaveReal(hash_item, bean.item_id, hk_splitDuring, bean.splitDuring)
 call SaveReal(hash_item, bean.item_id, hk_luckVal, bean.luckVal)
 call SaveReal(hash_item, bean.item_id, hk_luckDuring, bean.luckDuring)
 call SaveReal(hash_item, bean.item_id, hk_huntAmplitudeVal, bean.huntAmplitudeVal)
 call SaveReal(hash_item, bean.item_id, hk_huntAmplitudeDuring, bean.huntAmplitudeDuring)
 call SaveReal(hash_item, bean.item_id, hk_fireVal, bean.fireVal)
 call SaveReal(hash_item, bean.item_id, hk_fireDuring, bean.fireDuring)
 call SaveReal(hash_item, bean.item_id, hk_soilVal, bean.soilVal)
 call SaveReal(hash_item, bean.item_id, hk_soilDuring, bean.soilDuring)
 call SaveReal(hash_item, bean.item_id, hk_waterVal, bean.waterVal)
 call SaveReal(hash_item, bean.item_id, hk_waterDuring, bean.waterDuring)
 call SaveReal(hash_item, bean.item_id, hk_iceVal, bean.iceVal)
 call SaveReal(hash_item, bean.item_id, hk_iceDuring, bean.iceDuring)
 call SaveReal(hash_item, bean.item_id, hk_windVal, bean.windVal)
 call SaveReal(hash_item, bean.item_id, hk_windDuring, bean.windDuring)
 call SaveReal(hash_item, bean.item_id, hk_lightVal, bean.lightVal)
 call SaveReal(hash_item, bean.item_id, hk_lightDuring, bean.lightDuring)
 call SaveReal(hash_item, bean.item_id, hk_darkVal, bean.darkVal)
 call SaveReal(hash_item, bean.item_id, hk_darkDuring, bean.darkDuring)
 call SaveReal(hash_item, bean.item_id, hk_woodVal, bean.woodVal)
 call SaveReal(hash_item, bean.item_id, hk_woodDuring, bean.woodDuring)
 call SaveReal(hash_item, bean.item_id, hk_thunderVal, bean.thunderVal)
 call SaveReal(hash_item, bean.item_id, hk_thunderDuring, bean.thunderDuring)
 call SaveReal(hash_item, bean.item_id, hk_poisonVal, bean.poisonVal)
 call SaveReal(hash_item, bean.item_id, hk_poisonDuring, bean.poisonDuring)
 call SaveReal(hash_item, bean.item_id, hk_ghostVal, bean.ghostVal)
 call SaveReal(hash_item, bean.item_id, hk_ghostDuring, bean.ghostDuring)
 call SaveReal(hash_item, bean.item_id, hk_metalVal, bean.metalVal)
 call SaveReal(hash_item, bean.item_id, hk_metalDuring, bean.metalDuring)
 call SaveReal(hash_item, bean.item_id, hk_dragonVal, bean.dragonVal)
 call SaveReal(hash_item, bean.item_id, hk_dragonDuring, bean.dragonDuring)
 call SaveReal(hash_item, bean.item_id, hk_fireOpposeVal, bean.fireOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_fireOpposeDuring, bean.fireOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_soilOpposeVal, bean.soilOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_soilOpposeDuring, bean.soilOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_waterOpposeVal, bean.waterOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_waterOpposeDuring, bean.waterOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_iceOpposeVal, bean.iceOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_iceOpposeDuring, bean.iceOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_windOpposeVal, bean.windOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_windOpposeDuring, bean.windOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_lightOpposeVal, bean.lightOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_lightOpposeDuring, bean.lightOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_darkOpposeVal, bean.darkOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_darkOpposeDuring, bean.darkOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_woodOpposeVal, bean.woodOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_woodOpposeDuring, bean.woodOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_thunderOpposeVal, bean.thunderOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_thunderOpposeDuring, bean.thunderOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_poisonOpposeVal, bean.poisonOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_poisonOpposeDuring, bean.poisonOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_ghostOpposeVal, bean.ghostOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_ghostOpposeDuring, bean.ghostOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_metalOpposeVal, bean.metalOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_metalOpposeDuring, bean.metalOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_dragonOpposeVal, bean.dragonOpposeVal)
 call SaveReal(hash_item, bean.item_id, hk_dragonOpposeDuring, bean.dragonOpposeDuring)
 call SaveReal(hash_item, bean.item_id, hk_toxicVal, bean.toxicVal)
 call SaveReal(hash_item, bean.item_id, hk_toxicDuring, bean.toxicDuring)
 call SaveReal(hash_item, bean.item_id, hk_burnVal, bean.burnVal)
 call SaveReal(hash_item, bean.item_id, hk_burnDuring, bean.burnDuring)
 call SaveReal(hash_item, bean.item_id, hk_dryVal, bean.dryVal)
 call SaveReal(hash_item, bean.item_id, hk_dryDuring, bean.dryDuring)
 call SaveReal(hash_item, bean.item_id, hk_freezeVal, bean.freezeVal)
 call SaveReal(hash_item, bean.item_id, hk_freezeDuring, bean.freezeDuring)
 call SaveReal(hash_item, bean.item_id, hk_coldVal, bean.coldVal)
 call SaveReal(hash_item, bean.item_id, hk_coldDuring, bean.coldDuring)
 call SaveReal(hash_item, bean.item_id, hk_bluntVal, bean.bluntVal)
 call SaveReal(hash_item, bean.item_id, hk_bluntDuring, bean.bluntDuring)
 call SaveReal(hash_item, bean.item_id, hk_muggleVal, bean.muggleVal)
 call SaveReal(hash_item, bean.item_id, hk_muggleDuring, bean.muggleDuring)
 call SaveReal(hash_item, bean.item_id, hk_myopiaVal, bean.myopiaVal)
 call SaveReal(hash_item, bean.item_id, hk_myopiaDuring, bean.myopiaDuring)
 call SaveReal(hash_item, bean.item_id, hk_blindVal, bean.blindVal)
 call SaveReal(hash_item, bean.item_id, hk_blindDuring, bean.blindDuring)
 call SaveReal(hash_item, bean.item_id, hk_corrosionVal, bean.corrosionVal)
 call SaveReal(hash_item, bean.item_id, hk_corrosionDuring, bean.corrosionDuring)
 call SaveReal(hash_item, bean.item_id, hk_chaosVal, bean.chaosVal)
 call SaveReal(hash_item, bean.item_id, hk_chaosDuring, bean.chaosDuring)
 call SaveReal(hash_item, bean.item_id, hk_twineVal, bean.twineVal)
 call SaveReal(hash_item, bean.item_id, hk_twineDuring, bean.twineDuring)
 call SaveReal(hash_item, bean.item_id, hk_drunkVal, bean.drunkVal)
 call SaveReal(hash_item, bean.item_id, hk_drunkDuring, bean.drunkDuring)
 call SaveReal(hash_item, bean.item_id, hk_tortuaVal, bean.tortuaVal)
 call SaveReal(hash_item, bean.item_id, hk_tortuaDuring, bean.tortuaDuring)
 call SaveReal(hash_item, bean.item_id, hk_weakVal, bean.weakVal)
 call SaveReal(hash_item, bean.item_id, hk_weakDuring, bean.weakDuring)
 call SaveReal(hash_item, bean.item_id, hk_astrictVal, bean.astrictVal)
 call SaveReal(hash_item, bean.item_id, hk_astrictDuring, bean.astrictDuring)
 call SaveReal(hash_item, bean.item_id, hk_foolishVal, bean.foolishVal)
 call SaveReal(hash_item, bean.item_id, hk_foolishDuring, bean.foolishDuring)
 call SaveReal(hash_item, bean.item_id, hk_dullVal, bean.dullVal)
 call SaveReal(hash_item, bean.item_id, hk_dullDuring, bean.dullDuring)
 call SaveReal(hash_item, bean.item_id, hk_dirtVal, bean.dirtVal)
 call SaveReal(hash_item, bean.item_id, hk_dirtDuring, bean.dirtDuring)
 call SaveReal(hash_item, bean.item_id, hk_swimOdds, bean.swimOdds)
 call SaveReal(hash_item, bean.item_id, hk_swimDuring, bean.swimDuring)
 call SaveReal(hash_item, bean.item_id, hk_heavyOdds, bean.heavyOdds)
 call SaveReal(hash_item, bean.item_id, hk_heavyVal, bean.heavyVal)
 call SaveReal(hash_item, bean.item_id, hk_breakOdds, bean.breakOdds)
 call SaveReal(hash_item, bean.item_id, hk_breakDuring, bean.breakDuring)
 call SaveReal(hash_item, bean.item_id, hk_unluckVal, bean.unluckVal)
 call SaveReal(hash_item, bean.item_id, hk_unluckDuring, bean.unluckDuring)
 call SaveReal(hash_item, bean.item_id, hk_silentOdds, bean.silentOdds)
 call SaveReal(hash_item, bean.item_id, hk_silentDuring, bean.silentDuring)
 call SaveReal(hash_item, bean.item_id, hk_unarmOdds, bean.unarmOdds)
 call SaveReal(hash_item, bean.item_id, hk_unarmDuring, bean.unarmDuring)
 call SaveReal(hash_item, bean.item_id, hk_fetterOdds, bean.fetterOdds)
 call SaveReal(hash_item, bean.item_id, hk_fetterDuring, bean.fetterDuring)
 call SaveReal(hash_item, bean.item_id, hk_bombVal, bean.bombVal)
 call SaveReal(hash_item, bean.item_id, hk_bombOdds, bean.bombOdds)
 call SaveStr(hash_item, bean.item_id, hk_bombModel, bean.bombModel)
 call SaveReal(hash_item, bean.item_id, hk_lightningChainVal, bean.lightningChainVal)
 call SaveReal(hash_item, bean.item_id, hk_lightningChainOdds, bean.lightningChainOdds)
 call SaveReal(hash_item, bean.item_id, hk_lightningChainQty, bean.lightningChainQty)
 call SaveReal(hash_item, bean.item_id, hk_lightningChainReduce, bean.lightningChainReduce)
 call SaveStr(hash_item, bean.item_id, hk_lightningChainModel, bean.lightningChainModel)
 call SaveReal(hash_item, bean.item_id, hk_crackFlyVal, bean.crackFlyVal)
 call SaveReal(hash_item, bean.item_id, hk_crackFlyOdds, bean.crackFlyOdds)
 call SaveReal(hash_item, bean.item_id, hk_crackFlyDistance, bean.crackFlyDistance)
 call SaveReal(hash_item, bean.item_id, hk_crackFlyHigh, bean.crackFlyHigh)
			//-------
			if(bean.attackHuntType!="")then
				set score = score + 500
			endif
			//-------
if(bean.life!=0)then
    set score = score + R2I(bean.life)*3
endif
if(bean.mana!=0)then
    set score = score + R2I(bean.mana)*1
endif
if(bean.move!=0)then
    set score = score + R2I(bean.move)*5
endif
if(bean.defend!=0)then
    set score = score + R2I(bean.defend)*2
endif
if(bean.attackSpeed!=0)then
    set score = score + R2I(bean.attackSpeed)*3
endif
if(bean.attackPhysical!=0)then
    set score = score + R2I(bean.attackPhysical)*4
endif
if(bean.attackMagic!=0)then
    set score = score + R2I(bean.attackMagic)*4
endif
if(bean.attackRange!=0)then
    set score = score + R2I(bean.attackRange)*3
endif
if(bean.sight!=0)then
    set score = score + R2I(bean.sight)*3
endif
if(bean.str!=0)then
    set score = score + R2I(bean.str)*3
endif
if(bean.agi!=0)then
    set score = score + R2I(bean.agi)*3
endif
if(bean.int!=0)then
    set score = score + R2I(bean.int)*3
endif
if(bean.strWhite!=0)then
    set score = score + R2I(bean.strWhite)*4
endif
if(bean.agiWhite!=0)then
    set score = score + R2I(bean.agiWhite)*4
endif
if(bean.intWhite!=0)then
    set score = score + R2I(bean.intWhite)*4
endif
if(bean.lifeBack!=0)then
    set score = score + R2I(bean.lifeBack)*2
endif
if(bean.lifeSource!=0)then
    set score = score + R2I(bean.lifeSource)*1
endif
if(bean.manaBack!=0)then
    set score = score + R2I(bean.manaBack)*1
endif
if(bean.manaSource!=0)then
    set score = score + R2I(bean.manaSource)*1
endif
if(bean.resistance!=0)then
    set score = score + R2I(bean.resistance)*2
endif
if(bean.toughness!=0)then
    set score = score + R2I(bean.toughness)*3
endif
if(bean.avoid!=0)then
    set score = score + R2I(bean.avoid)*2
endif
if(bean.aim!=0)then
    set score = score + R2I(bean.aim)*2
endif
if(bean.knocking!=0)then
    set score = score + R2I(bean.knocking)*4
endif
if(bean.violence!=0)then
    set score = score + R2I(bean.violence)*4
endif
if(bean.punish!=0)then
    set score = score + R2I(bean.punish)*3
endif
if(bean.meditative!=0)then
    set score = score + R2I(bean.meditative)*1
endif
if(bean.help!=0)then
    set score = score + R2I(bean.help)*1
endif
if(bean.hemophagia!=0)then
    set score = score + R2I(bean.hemophagia)*4
endif
if(bean.hemophagiaSkill!=0)then
    set score = score + R2I(bean.hemophagiaSkill)*4
endif
if(bean.split!=0)then
    set score = score + R2I(bean.split)*4
endif
if(bean.splitRange!=0)then
    set score = score + R2I(bean.splitRange)*1
endif
if(bean.goldRatio!=0)then
    set score = score + R2I(bean.goldRatio)*1
endif
if(bean.lumberRatio!=0)then
    set score = score + R2I(bean.lumberRatio)*1
endif
if(bean.expRatio!=0)then
    set score = score + R2I(bean.expRatio)*1
endif
if(bean.luck!=0)then
    set score = score + R2I(bean.luck)*2
endif
if(bean.invincible!=0)then
    set score = score + R2I(bean.invincible)*2
endif
if(bean.huntAmplitude!=0)then
    set score = score + R2I(bean.huntAmplitude)*8
endif
if(bean.huntRebound!=0)then
    set score = score + R2I(bean.huntRebound)*5
endif
if(bean.cure!=0)then
    set score = score + R2I(bean.cure)*2
endif
if(bean.knockingOppose!=0)then
    set score = score + R2I(bean.knockingOppose)*3
endif
if(bean.violenceOppose!=0)then
    set score = score + R2I(bean.violenceOppose)*3
endif
if(bean.hemophagiaOppose!=0)then
    set score = score + R2I(bean.hemophagiaOppose)*3
endif
/*
if(bean.hemophagiaSkillOppose!=0)then
    set score = score + R2I(bean.hemophagiaSkillOppose)*3
endif
*/
if(bean.splitOppose!=0)then
    set score = score + R2I(bean.splitOppose)*3
endif
if(bean.punishOppose!=0)then
    set score = score + R2I(bean.punishOppose)*3
endif
if(bean.huntReboundOppose!=0)then
    set score = score + R2I(bean.huntReboundOppose)*3
endif
if(bean.swimOppose!=0)then
    set score = score + R2I(bean.swimOppose)*3
endif
if(bean.heavyOppose!=0)then
    set score = score + R2I(bean.heavyOppose)*3
endif
if(bean.breakOppose!=0)then
    set score = score + R2I(bean.breakOppose)*3
endif
if(bean.unluckOppose!=0)then
    set score = score + R2I(bean.unluckOppose)*3
endif
if(bean.silentOppose!=0)then
    set score = score + R2I(bean.silentOppose)*3
endif
if(bean.unarmOppose!=0)then
    set score = score + R2I(bean.unarmOppose)*3
endif
if(bean.fetterOppose!=0)then
    set score = score + R2I(bean.fetterOppose)*3
endif
if(bean.bombOppose!=0)then
    set score = score + R2I(bean.bombOppose)*3
endif
if(bean.lightningChainOppose!=0)then
    set score = score + R2I(bean.lightningChainOppose)*3
endif
if(bean.crackFlyOppose!=0)then
    set score = score + R2I(bean.crackFlyOppose)*3
endif
if(bean.fire!=0)then
    set score = score + R2I(bean.fire)*5
endif
if(bean.soil!=0)then
    set score = score + R2I(bean.soil)*5
endif
if(bean.water!=0)then
    set score = score + R2I(bean.water)*5
endif
if(bean.ice!=0)then
    set score = score + R2I(bean.ice)*5
endif
if(bean.wind!=0)then
    set score = score + R2I(bean.wind)*5
endif
if(bean.light!=0)then
    set score = score + R2I(bean.light)*5
endif
if(bean.dark!=0)then
    set score = score + R2I(bean.dark)*5
endif
if(bean.wood!=0)then
    set score = score + R2I(bean.wood)*5
endif
if(bean.thunder!=0)then
    set score = score + R2I(bean.thunder)*5
endif
if(bean.poison!=0)then
    set score = score + R2I(bean.poison)*5
endif
if(bean.ghost!=0)then
    set score = score + R2I(bean.ghost)*5
endif
if(bean.metal!=0)then
    set score = score + R2I(bean.metal)*5
endif
if(bean.dragon!=0)then
    set score = score + R2I(bean.dragon)*5
endif
if(bean.fireOppose!=0)then
    set score = score + R2I(bean.fireOppose)*4
endif
if(bean.soilOppose!=0)then
    set score = score + R2I(bean.soilOppose)*4
endif
if(bean.waterOppose!=0)then
    set score = score + R2I(bean.waterOppose)*4
endif
if(bean.iceOppose!=0)then
    set score = score + R2I(bean.iceOppose)*4
endif
if(bean.windOppose!=0)then
    set score = score + R2I(bean.windOppose)*4
endif
if(bean.lightOppose!=0)then
    set score = score + R2I(bean.lightOppose)*4
endif
if(bean.darkOppose!=0)then
    set score = score + R2I(bean.darkOppose)*4
endif
if(bean.woodOppose!=0)then
    set score = score + R2I(bean.woodOppose)*4
endif
if(bean.thunderOppose!=0)then
    set score = score + R2I(bean.thunderOppose)*4
endif
if(bean.poisonOppose!=0)then
    set score = score + R2I(bean.poisonOppose)*4
endif
if(bean.ghostOppose!=0)then
    set score = score + R2I(bean.ghostOppose)*5
endif
if(bean.metalOppose!=0)then
    set score = score + R2I(bean.metalOppose)*5
endif
if(bean.dragonOppose!=0)then
    set score = score + R2I(bean.dragonOppose)*5
endif
 if(bean.lifeBackVal!=0)then
    set score = score + R2I(bean.lifeBackVal)*3
endif
 if(bean.lifeBackDuring!=0)then
    set score = score + R2I(bean.lifeBackDuring)*3
endif
 if(bean.manaBackVal!=0)then
    set score = score + R2I(bean.manaBackVal)*3
endif
 if(bean.manaBackDuring!=0)then
    set score = score + R2I(bean.manaBackDuring)*3
endif
 if(bean.attackSpeedVal!=0)then
    set score = score + R2I(bean.attackSpeedVal)*3
endif
 if(bean.attackSpeedDuring!=0)then
    set score = score + R2I(bean.attackSpeedDuring)*3
endif
 if(bean.attackPhysicalVal!=0)then
    set score = score + R2I(bean.attackPhysicalVal)*3
endif
 if(bean.attackPhysicalDuring!=0)then
    set score = score + R2I(bean.attackPhysicalDuring)*3
endif
 if(bean.attackMagicVal!=0)then
    set score = score + R2I(bean.attackMagicVal)*3
endif
 if(bean.attackMagicDuring!=0)then
    set score = score + R2I(bean.attackMagicDuring)*3
endif
 if(bean.moveVal!=0)then
    set score = score + R2I(bean.moveVal)*3
endif
 if(bean.moveDuring!=0)then
    set score = score + R2I(bean.moveDuring)*3
endif
 if(bean.aimVal!=0)then
    set score = score + R2I(bean.aimVal)*3
endif
 if(bean.aimDuring!=0)then
    set score = score + R2I(bean.aimDuring)*3
endif
 if(bean.strVal!=0)then
    set score = score + R2I(bean.strVal)*3
endif
 if(bean.strDuring!=0)then
    set score = score + R2I(bean.strDuring)*3
endif
 if(bean.agiVal!=0)then
    set score = score + R2I(bean.agiVal)*3
endif
 if(bean.agiDuring!=0)then
    set score = score + R2I(bean.agiDuring)*3
endif
 if(bean.intVal!=0)then
    set score = score + R2I(bean.intVal)*3
endif
 if(bean.intDuring!=0)then
    set score = score + R2I(bean.intDuring)*3
endif
 if(bean.knockingVal!=0)then
    set score = score + R2I(bean.knockingVal)*3
endif
 if(bean.knockingDuring!=0)then
    set score = score + R2I(bean.knockingDuring)*3
endif
 if(bean.violenceVal!=0)then
    set score = score + R2I(bean.violenceVal)*3
endif
 if(bean.violenceDuring!=0)then
    set score = score + R2I(bean.violenceDuring)*3
endif
 if(bean.hemophagiaVal!=0)then
    set score = score + R2I(bean.hemophagiaVal)*3
endif
 if(bean.hemophagiaDuring!=0)then
    set score = score + R2I(bean.hemophagiaDuring)*3
endif
 if(bean.hemophagiaSkillVal!=0)then
    set score = score + R2I(bean.hemophagiaSkillVal)*3
endif
 if(bean.hemophagiaSkillDuring!=0)then
    set score = score + R2I(bean.hemophagiaSkillDuring)*3
endif
 if(bean.splitVal!=0)then
    set score = score + R2I(bean.splitVal)*3
endif
 if(bean.splitDuring!=0)then
    set score = score + R2I(bean.splitDuring)*3
endif
 if(bean.luckVal!=0)then
    set score = score + R2I(bean.luckVal)*3
endif
 if(bean.luckDuring!=0)then
    set score = score + R2I(bean.luckDuring)*3
endif
 if(bean.huntAmplitudeVal!=0)then
    set score = score + R2I(bean.huntAmplitudeVal)*3
endif
 if(bean.huntAmplitudeDuring!=0)then
    set score = score + R2I(bean.huntAmplitudeDuring)*3
endif
 if(bean.fireVal!=0)then
    set score = score + R2I(bean.fireVal)*3
endif
 if(bean.fireDuring!=0)then
    set score = score + R2I(bean.fireDuring)*3
endif
 if(bean.soilVal!=0)then
    set score = score + R2I(bean.soilVal)*3
endif
 if(bean.soilDuring!=0)then
    set score = score + R2I(bean.soilDuring)*3
endif
 if(bean.waterVal!=0)then
    set score = score + R2I(bean.waterVal)*3
endif
 if(bean.waterDuring!=0)then
    set score = score + R2I(bean.waterDuring)*3
endif
 if(bean.iceVal!=0)then
    set score = score + R2I(bean.iceVal)*3
endif
 if(bean.iceDuring!=0)then
    set score = score + R2I(bean.iceDuring)*3
endif
 if(bean.windVal!=0)then
    set score = score + R2I(bean.windVal)*3
endif
 if(bean.windDuring!=0)then
    set score = score + R2I(bean.windDuring)*3
endif
 if(bean.lightVal!=0)then
    set score = score + R2I(bean.lightVal)*3
endif
 if(bean.lightDuring!=0)then
    set score = score + R2I(bean.lightDuring)*3
endif
 if(bean.darkVal!=0)then
    set score = score + R2I(bean.darkVal)*3
endif
 if(bean.darkDuring!=0)then
    set score = score + R2I(bean.darkDuring)*3
endif
 if(bean.woodVal!=0)then
    set score = score + R2I(bean.woodVal)*3
endif
 if(bean.woodDuring!=0)then
    set score = score + R2I(bean.woodDuring)*3
endif
 if(bean.thunderVal!=0)then
    set score = score + R2I(bean.thunderVal)*3
endif
 if(bean.thunderDuring!=0)then
    set score = score + R2I(bean.thunderDuring)*3
endif
 if(bean.poisonVal!=0)then
    set score = score + R2I(bean.poisonVal)*3
endif
 if(bean.poisonDuring!=0)then
    set score = score + R2I(bean.poisonDuring)*3
endif
 if(bean.ghostVal!=0)then
    set score = score + R2I(bean.ghostVal)*3
endif
 if(bean.ghostDuring!=0)then
    set score = score + R2I(bean.ghostDuring)*3
endif
 if(bean.metalVal!=0)then
    set score = score + R2I(bean.metalVal)*3
endif
 if(bean.metalDuring!=0)then
    set score = score + R2I(bean.metalDuring)*3
endif
 if(bean.dragonVal!=0)then
    set score = score + R2I(bean.dragonVal)*3
endif
 if(bean.dragonDuring!=0)then
    set score = score + R2I(bean.dragonDuring)*3
endif
 if(bean.fireOpposeVal!=0)then
    set score = score + R2I(bean.fireOpposeVal)*3
endif
 if(bean.fireOpposeDuring!=0)then
    set score = score + R2I(bean.fireOpposeDuring)*3
endif
 if(bean.soilOpposeVal!=0)then
    set score = score + R2I(bean.soilOpposeVal)*3
endif
 if(bean.soilOpposeDuring!=0)then
    set score = score + R2I(bean.soilOpposeDuring)*3
endif
 if(bean.waterOpposeVal!=0)then
    set score = score + R2I(bean.waterOpposeVal)*3
endif
 if(bean.waterOpposeDuring!=0)then
    set score = score + R2I(bean.waterOpposeDuring)*3
endif
 if(bean.iceOpposeVal!=0)then
    set score = score + R2I(bean.iceOpposeVal)*3
endif
 if(bean.iceOpposeDuring!=0)then
    set score = score + R2I(bean.iceOpposeDuring)*3
endif
 if(bean.windOpposeVal!=0)then
    set score = score + R2I(bean.windOpposeVal)*3
endif
 if(bean.windOpposeDuring!=0)then
    set score = score + R2I(bean.windOpposeDuring)*3
endif
 if(bean.lightOpposeVal!=0)then
    set score = score + R2I(bean.lightOpposeVal)*3
endif
 if(bean.lightOpposeDuring!=0)then
    set score = score + R2I(bean.lightOpposeDuring)*3
endif
 if(bean.darkOpposeVal!=0)then
    set score = score + R2I(bean.darkOpposeVal)*3
endif
 if(bean.darkOpposeDuring!=0)then
    set score = score + R2I(bean.darkOpposeDuring)*3
endif
 if(bean.woodOpposeVal!=0)then
    set score = score + R2I(bean.woodOpposeVal)*3
endif
 if(bean.woodOpposeDuring!=0)then
    set score = score + R2I(bean.woodOpposeDuring)*3
endif
 if(bean.thunderOpposeVal!=0)then
    set score = score + R2I(bean.thunderOpposeVal)*3
endif
 if(bean.thunderOpposeDuring!=0)then
    set score = score + R2I(bean.thunderOpposeDuring)*3
endif
 if(bean.poisonOpposeVal!=0)then
    set score = score + R2I(bean.poisonOpposeVal)*3
endif
 if(bean.poisonOpposeDuring!=0)then
    set score = score + R2I(bean.poisonOpposeDuring)*3
endif
 if(bean.ghostOpposeVal!=0)then
    set score = score + R2I(bean.ghostOpposeVal)*3
endif
 if(bean.ghostOpposeDuring!=0)then
    set score = score + R2I(bean.ghostOpposeDuring)*3
endif
 if(bean.metalOpposeVal!=0)then
    set score = score + R2I(bean.metalOpposeVal)*3
endif
 if(bean.metalOpposeDuring!=0)then
    set score = score + R2I(bean.metalOpposeDuring)*3
endif
 if(bean.dragonOpposeVal!=0)then
    set score = score + R2I(bean.dragonOpposeVal)*3
endif
 if(bean.dragonOpposeDuring!=0)then
    set score = score + R2I(bean.dragonOpposeDuring)*3
endif
 if(bean.toxicVal!=0)then
    set score = score + R2I(bean.toxicVal)*3
endif
 if(bean.toxicDuring!=0)then
    set score = score + R2I(bean.toxicDuring)*3
endif
 if(bean.burnVal!=0)then
    set score = score + R2I(bean.burnVal)*3
endif
 if(bean.burnDuring!=0)then
    set score = score + R2I(bean.burnDuring)*3
endif
 if(bean.dryVal!=0)then
    set score = score + R2I(bean.dryVal)*3
endif
 if(bean.dryDuring!=0)then
    set score = score + R2I(bean.dryDuring)*3
endif
 if(bean.freezeVal!=0)then
    set score = score + R2I(bean.freezeVal)*3
endif
 if(bean.freezeDuring!=0)then
    set score = score + R2I(bean.freezeDuring)*3
endif
 if(bean.coldVal!=0)then
    set score = score + R2I(bean.coldVal)*3
endif
 if(bean.coldDuring!=0)then
    set score = score + R2I(bean.coldDuring)*3
endif
 if(bean.bluntVal!=0)then
    set score = score + R2I(bean.bluntVal)*3
endif
 if(bean.bluntDuring!=0)then
    set score = score + R2I(bean.bluntDuring)*3
endif
 if(bean.muggleVal!=0)then
    set score = score + R2I(bean.muggleVal)*3
endif
 if(bean.muggleDuring!=0)then
    set score = score + R2I(bean.muggleDuring)*3
endif
 if(bean.myopiaVal!=0)then
    set score = score + R2I(bean.myopiaVal)*3
endif
 if(bean.myopiaDuring!=0)then
    set score = score + R2I(bean.myopiaDuring)*3
endif
 if(bean.blindVal!=0)then
    set score = score + R2I(bean.blindVal)*3
endif
 if(bean.blindDuring!=0)then
    set score = score + R2I(bean.blindDuring)*3
endif
 if(bean.corrosionVal!=0)then
    set score = score + R2I(bean.corrosionVal)*3
endif
 if(bean.corrosionDuring!=0)then
    set score = score + R2I(bean.corrosionDuring)*3
endif
 if(bean.chaosVal!=0)then
    set score = score + R2I(bean.chaosVal)*3
endif
 if(bean.chaosDuring!=0)then
    set score = score + R2I(bean.chaosDuring)*3
endif
 if(bean.twineVal!=0)then
    set score = score + R2I(bean.twineVal)*3
endif
 if(bean.twineDuring!=0)then
    set score = score + R2I(bean.twineDuring)*3
endif
 if(bean.drunkVal!=0)then
    set score = score + R2I(bean.drunkVal)*3
endif
 if(bean.drunkDuring!=0)then
    set score = score + R2I(bean.drunkDuring)*3
endif
 if(bean.tortuaVal!=0)then
    set score = score + R2I(bean.tortuaVal)*3
endif
 if(bean.tortuaDuring!=0)then
    set score = score + R2I(bean.tortuaDuring)*3
endif
 if(bean.weakVal!=0)then
    set score = score + R2I(bean.weakVal)*3
endif
 if(bean.weakDuring!=0)then
    set score = score + R2I(bean.weakDuring)*3
endif
 if(bean.astrictVal!=0)then
    set score = score + R2I(bean.astrictVal)*3
endif
 if(bean.astrictDuring!=0)then
    set score = score + R2I(bean.astrictDuring)*3
endif
 if(bean.foolishVal!=0)then
    set score = score + R2I(bean.foolishVal)*3
endif
 if(bean.foolishDuring!=0)then
    set score = score + R2I(bean.foolishDuring)*3
endif
 if(bean.dullVal!=0)then
    set score = score + R2I(bean.dullVal)*3
endif
 if(bean.dullDuring!=0)then
    set score = score + R2I(bean.dullDuring)*3
endif
 if(bean.dirtVal!=0)then
    set score = score + R2I(bean.dirtVal)*3
endif
 if(bean.dirtDuring!=0)then
    set score = score + R2I(bean.dirtDuring)*3
endif
 if(bean.swimOdds!=0)then
    set score = score + R2I(bean.swimOdds)*3
endif
 if(bean.swimDuring!=0)then
    set score = score + R2I(bean.swimDuring)*3
endif
 if(bean.heavyOdds!=0)then
    set score = score + R2I(bean.heavyOdds)*3
endif
 if(bean.heavyVal!=0)then
    set score = score + R2I(bean.heavyVal)*3
endif
 if(bean.breakOdds!=0)then
    set score = score + R2I(bean.breakOdds)*3
endif
 if(bean.breakDuring!=0)then
    set score = score + R2I(bean.breakDuring)*3
endif
 if(bean.unluckVal!=0)then
    set score = score + R2I(bean.unluckVal)*3
endif
 if(bean.unluckDuring!=0)then
    set score = score + R2I(bean.unluckDuring)*3
endif
 if(bean.silentOdds!=0)then
    set score = score + R2I(bean.silentOdds)*3
endif
 if(bean.silentDuring!=0)then
    set score = score + R2I(bean.silentDuring)*3
endif
 if(bean.unarmOdds!=0)then
    set score = score + R2I(bean.unarmOdds)*3
endif
 if(bean.unarmDuring!=0)then
    set score = score + R2I(bean.unarmDuring)*3
endif
 if(bean.fetterOdds!=0)then
    set score = score + R2I(bean.fetterOdds)*3
endif
 if(bean.fetterDuring!=0)then
    set score = score + R2I(bean.fetterDuring)*3
endif
 if(bean.bombVal!=0)then
    set score = score + R2I(bean.bombVal)*3
endif
 if(bean.bombOdds!=0)then
    set score = score + R2I(bean.bombOdds)*3
endif
 if(bean.lightningChainVal!=0)then
    set score = score + R2I(bean.lightningChainVal)*3
endif
 if(bean.lightningChainOdds!=0)then
    set score = score + R2I(bean.lightningChainOdds)*3
endif
 if(bean.lightningChainQty!=0)then
    set score = score + R2I(bean.lightningChainQty)*3
endif
 if(bean.lightningChainReduce!=0)then
    set score = score + R2I(bean.lightningChainReduce)*3
endif
 if(bean.crackFlyVal!=0)then
    set score = score + R2I(bean.crackFlyVal)*3
endif
 if(bean.crackFlyOdds!=0)then
    set score = score + R2I(bean.crackFlyOdds)*3
endif
 if(bean.crackFlyDistance!=0)then
    set score = score + R2I(bean.crackFlyDistance)*3
endif
 if(bean.crackFlyHigh!=0)then
    set score = score + R2I(bean.crackFlyHigh)*3
endif
			//
			call SaveInteger(hash_item, bean.item_id, hk_item_combat_effectiveness,score/10)
        endif
	endmethod

    //绑定物品到系统
    public static method format takes hItemBean bean returns nothing
		call formatEval.evaluate(bean)
    endmethod

	//获取物品ID是否注册过
    public static method isFormat takes integer itemId returns boolean
        return LoadBoolean(hash_item, itemId, hk_item_init)
    endmethod

	private static method addAttrCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer item_id = htime.getInteger(t,1)
        local real charges = htime.getReal(t,2)
        local boolean isPlus = htime.getBoolean(t,4)
        //
local real goldRatio = LoadReal(hash_item, item_id, hk_goldRatio)*charges
local real lumberRatio = LoadReal(hash_item, item_id, hk_lumberRatio)*charges
local real expRatio = LoadReal(hash_item, item_id, hk_expRatio)*charges
local real life = LoadReal(hash_item, item_id, hk_life)*charges
local real mana = LoadReal(hash_item, item_id, hk_mana)*charges
local real move = LoadReal(hash_item, item_id, hk_move)*charges
local real defend  = LoadReal(hash_item, item_id, hk_defend )*charges
local real attackSpeed = LoadReal(hash_item, item_id, hk_attackSpeed)*charges
local real attackPhysical = LoadReal(hash_item, item_id, hk_attackPhysical)*charges
local real attackMagic = LoadReal(hash_item, item_id, hk_attackMagic)*charges
local real attackRange = LoadReal(hash_item, item_id, hk_attackRange)*charges
local real sight = LoadReal(hash_item, item_id, hk_sight)*charges
local real str = LoadReal(hash_item, item_id, hk_str)*charges
local real agi = LoadReal(hash_item, item_id, hk_agi)*charges
local real int = LoadReal(hash_item, item_id, hk_int)*charges
local real strWhite = LoadReal(hash_item, item_id, hk_strWhite)*charges
local real agiWhite = LoadReal(hash_item, item_id, hk_agiWhite)*charges
local real intWhite = LoadReal(hash_item, item_id, hk_intWhite)*charges
local real lifeBack = LoadReal(hash_item, item_id, hk_lifeBack)*charges
local real lifeSource = LoadReal(hash_item, item_id, hk_lifeSource)*charges
local real lifeSourceCurrent = LoadReal(hash_item, item_id, hk_lifeSourceCurrent)*charges
local real manaBack = LoadReal(hash_item, item_id, hk_manaBack)*charges
local real manaSource = LoadReal(hash_item, item_id, hk_manaSource)*charges
local real manaSourceCurrent = LoadReal(hash_item, item_id, hk_manaSourceCurrent)*charges
local real resistance = LoadReal(hash_item, item_id, hk_resistance)*charges
local real toughness = LoadReal(hash_item, item_id, hk_toughness)*charges
local real avoid = LoadReal(hash_item, item_id, hk_avoid)*charges
local real aim = LoadReal(hash_item, item_id, hk_aim)*charges
local real knocking = LoadReal(hash_item, item_id, hk_knocking)*charges
local real violence = LoadReal(hash_item, item_id, hk_violence)*charges
local real punish = LoadReal(hash_item, item_id, hk_punish)*charges
local real punishCurrent = LoadReal(hash_item, item_id, hk_punishCurrent)*charges
local real meditative = LoadReal(hash_item, item_id, hk_meditative)*charges
local real help = LoadReal(hash_item, item_id, hk_help)*charges
local real hemophagia = LoadReal(hash_item, item_id, hk_hemophagia)*charges
local real hemophagiaSkill = LoadReal(hash_item, item_id, hk_hemophagiaSkill)*charges
local real split = LoadReal(hash_item, item_id, hk_split)*charges
local real splitRange = LoadReal(hash_item, item_id, hk_splitRange)*charges
local real luck = LoadReal(hash_item, item_id, hk_luck)*charges
local real invincible = LoadReal(hash_item, item_id, hk_invincible)*charges
local real weight = LoadReal(hash_item, item_id, hk_weight)*charges
local real weightCurrent = LoadReal(hash_item, item_id, hk_weightCurrent)*charges
local real huntAmplitude = LoadReal(hash_item, item_id, hk_huntAmplitude)*charges
local real huntRebound = LoadReal(hash_item, item_id, hk_huntRebound)*charges
local real cure = LoadReal(hash_item, item_id, hk_cure)*charges
local real knockingOppose = LoadReal(hash_item, item_id, hk_knockingOppose)*charges
local real violenceOppose = LoadReal(hash_item, item_id, hk_violenceOppose)*charges
local real hemophagiaOppose = LoadReal(hash_item, item_id, hk_hemophagiaOppose)*charges
local real splitOppose = LoadReal(hash_item, item_id, hk_splitOppose)*charges
local real punishOppose = LoadReal(hash_item, item_id, hk_punishOppose)*charges
local real huntReboundOppose = LoadReal(hash_item, item_id, hk_huntReboundOppose)*charges
local real swimOppose = LoadReal(hash_item, item_id, hk_swimOppose)*charges
local real heavyOppose = LoadReal(hash_item, item_id, hk_heavyOppose)*charges
local real breakOppose = LoadReal(hash_item, item_id, hk_breakOppose)*charges
local real unluckOppose = LoadReal(hash_item, item_id, hk_unluckOppose)*charges
local real silentOppose = LoadReal(hash_item, item_id, hk_silentOppose)*charges
local real unarmOppose = LoadReal(hash_item, item_id, hk_unarmOppose)*charges
local real fetterOppose = LoadReal(hash_item, item_id, hk_fetterOppose)*charges
local real bombOppose = LoadReal(hash_item, item_id, hk_bombOppose)*charges
local real lightningChainOppose = LoadReal(hash_item, item_id, hk_lightningChainOppose)*charges
local real crackFlyOppose = LoadReal(hash_item, item_id, hk_crackFlyOppose)*charges
local real fire = LoadReal(hash_item, item_id, hk_fire)*charges
local real soil = LoadReal(hash_item, item_id, hk_soil)*charges
local real water = LoadReal(hash_item, item_id, hk_water)*charges
local real ice = LoadReal(hash_item, item_id, hk_ice)*charges
local real wind = LoadReal(hash_item, item_id, hk_wind)*charges
local real light = LoadReal(hash_item, item_id, hk_light)*charges
local real dark = LoadReal(hash_item, item_id, hk_dark)*charges
local real wood = LoadReal(hash_item, item_id, hk_wood)*charges
local real thunder = LoadReal(hash_item, item_id, hk_thunder)*charges
local real poison = LoadReal(hash_item, item_id, hk_poison)*charges
local real ghost = LoadReal(hash_item, item_id, hk_ghost)*charges
local real metal = LoadReal(hash_item, item_id, hk_metal)*charges
local real dragon = LoadReal(hash_item, item_id, hk_dragon)*charges
local real fireOppose = LoadReal(hash_item, item_id, hk_fireOppose)*charges
local real soilOppose = LoadReal(hash_item, item_id, hk_soilOppose)*charges
local real waterOppose = LoadReal(hash_item, item_id, hk_waterOppose)*charges
local real iceOppose = LoadReal(hash_item, item_id, hk_iceOppose)*charges
local real windOppose = LoadReal(hash_item, item_id, hk_windOppose)*charges
local real lightOppose = LoadReal(hash_item, item_id, hk_lightOppose)*charges
local real darkOppose = LoadReal(hash_item, item_id, hk_darkOppose)*charges
local real woodOppose = LoadReal(hash_item, item_id, hk_woodOppose)*charges
local real thunderOppose = LoadReal(hash_item, item_id, hk_thunderOppose)*charges
local real poisonOppose = LoadReal(hash_item, item_id, hk_poisonOppose)*charges
local real ghostOppose = LoadReal(hash_item, item_id, hk_ghostOppose)*charges
local real metalOppose = LoadReal(hash_item, item_id, hk_metalOppose)*charges
local real dragonOppose = LoadReal(hash_item, item_id, hk_dragonOppose)*charges
 local real lifeBackVal = LoadReal(hash_item, item_id, hk_lifeBackVal)*charges
 local real lifeBackDuring = LoadReal(hash_item, item_id, hk_lifeBackDuring)*charges
 local real manaBackVal = LoadReal(hash_item, item_id, hk_manaBackVal)*charges
 local real manaBackDuring = LoadReal(hash_item, item_id, hk_manaBackDuring)*charges
 local real attackSpeedVal = LoadReal(hash_item, item_id, hk_attackSpeedVal)*charges
 local real attackSpeedDuring = LoadReal(hash_item, item_id, hk_attackSpeedDuring)*charges
 local real attackPhysicalVal = LoadReal(hash_item, item_id, hk_attackPhysicalVal)*charges
 local real attackPhysicalDuring = LoadReal(hash_item, item_id, hk_attackPhysicalDuring)*charges
 local real attackMagicVal = LoadReal(hash_item, item_id, hk_attackMagicVal)*charges
 local real attackMagicDuring = LoadReal(hash_item, item_id, hk_attackMagicDuring)*charges
 local real attackRangeVal = LoadReal(hash_item, item_id, hk_attackRangeVal)*charges
 local real attackRangeDuring = LoadReal(hash_item, item_id, hk_attackRangeDuring)*charges
 local real sightVal = LoadReal(hash_item, item_id, hk_sightVal)*charges
 local real sightDuring = LoadReal(hash_item, item_id, hk_sightDuring)*charges
 local real moveVal = LoadReal(hash_item, item_id, hk_moveVal)*charges
 local real moveDuring = LoadReal(hash_item, item_id, hk_moveDuring)*charges
 local real aimVal = LoadReal(hash_item, item_id, hk_aimVal)*charges
 local real aimDuring = LoadReal(hash_item, item_id, hk_aimDuring)*charges
 local real strVal = LoadReal(hash_item, item_id, hk_strVal)*charges
 local real strDuring = LoadReal(hash_item, item_id, hk_strDuring)*charges
 local real agiVal = LoadReal(hash_item, item_id, hk_agiVal)*charges
 local real agiDuring = LoadReal(hash_item, item_id, hk_agiDuring)*charges
 local real intVal = LoadReal(hash_item, item_id, hk_intVal)*charges
 local real intDuring = LoadReal(hash_item, item_id, hk_intDuring)*charges
 local real knockingVal = LoadReal(hash_item, item_id, hk_knockingVal)*charges
 local real knockingDuring = LoadReal(hash_item, item_id, hk_knockingDuring)*charges
 local real violenceVal = LoadReal(hash_item, item_id, hk_violenceVal)*charges
 local real violenceDuring = LoadReal(hash_item, item_id, hk_violenceDuring)*charges
 local real hemophagiaVal = LoadReal(hash_item, item_id, hk_hemophagiaVal)*charges
 local real hemophagiaDuring = LoadReal(hash_item, item_id, hk_hemophagiaDuring)*charges
 local real hemophagiaSkillVal = LoadReal(hash_item, item_id, hk_hemophagiaSkillVal)*charges
 local real hemophagiaSkillDuring = LoadReal(hash_item, item_id, hk_hemophagiaSkillDuring)*charges
 local real splitVal = LoadReal(hash_item, item_id, hk_splitVal)*charges
 local real splitDuring = LoadReal(hash_item, item_id, hk_splitDuring)*charges
 local real luckVal = LoadReal(hash_item, item_id, hk_luckVal)*charges
 local real luckDuring = LoadReal(hash_item, item_id, hk_luckDuring)*charges
 local real huntAmplitudeVal = LoadReal(hash_item, item_id, hk_huntAmplitudeVal)*charges
 local real huntAmplitudeDuring = LoadReal(hash_item, item_id, hk_huntAmplitudeDuring)*charges
 local real fireVal = LoadReal(hash_item, item_id, hk_fireVal)*charges
 local real fireDuring = LoadReal(hash_item, item_id, hk_fireDuring)*charges
 local real soilVal = LoadReal(hash_item, item_id, hk_soilVal)*charges
 local real soilDuring = LoadReal(hash_item, item_id, hk_soilDuring)*charges
 local real waterVal = LoadReal(hash_item, item_id, hk_waterVal)*charges
 local real waterDuring = LoadReal(hash_item, item_id, hk_waterDuring)*charges
 local real iceVal = LoadReal(hash_item, item_id, hk_iceVal)*charges
 local real iceDuring = LoadReal(hash_item, item_id, hk_iceDuring)*charges
 local real windVal = LoadReal(hash_item, item_id, hk_windVal)*charges
 local real windDuring = LoadReal(hash_item, item_id, hk_windDuring)*charges
 local real lightVal = LoadReal(hash_item, item_id, hk_lightVal)*charges
 local real lightDuring = LoadReal(hash_item, item_id, hk_lightDuring)*charges
 local real darkVal = LoadReal(hash_item, item_id, hk_darkVal)*charges
 local real darkDuring = LoadReal(hash_item, item_id, hk_darkDuring)*charges
 local real woodVal = LoadReal(hash_item, item_id, hk_woodVal)*charges
 local real woodDuring = LoadReal(hash_item, item_id, hk_woodDuring)*charges
 local real thunderVal = LoadReal(hash_item, item_id, hk_thunderVal)*charges
 local real thunderDuring = LoadReal(hash_item, item_id, hk_thunderDuring)*charges
 local real poisonVal = LoadReal(hash_item, item_id, hk_poisonVal)*charges
 local real poisonDuring = LoadReal(hash_item, item_id, hk_poisonDuring)*charges
 local real ghostVal = LoadReal(hash_item, item_id, hk_ghostVal)*charges
 local real ghostDuring = LoadReal(hash_item, item_id, hk_ghostDuring)*charges
 local real metalVal = LoadReal(hash_item, item_id, hk_metalVal)*charges
 local real metalDuring = LoadReal(hash_item, item_id, hk_metalDuring)*charges
 local real dragonVal = LoadReal(hash_item, item_id, hk_dragonVal)*charges
 local real dragonDuring = LoadReal(hash_item, item_id, hk_dragonDuring)*charges
 local real fireOpposeVal = LoadReal(hash_item, item_id, hk_fireOpposeVal)*charges
 local real fireOpposeDuring = LoadReal(hash_item, item_id, hk_fireOpposeDuring)*charges
 local real soilOpposeVal = LoadReal(hash_item, item_id, hk_soilOpposeVal)*charges
 local real soilOpposeDuring = LoadReal(hash_item, item_id, hk_soilOpposeDuring)*charges
 local real waterOpposeVal = LoadReal(hash_item, item_id, hk_waterOpposeVal)*charges
 local real waterOpposeDuring = LoadReal(hash_item, item_id, hk_waterOpposeDuring)*charges
 local real iceOpposeVal = LoadReal(hash_item, item_id, hk_iceOpposeVal)*charges
 local real iceOpposeDuring = LoadReal(hash_item, item_id, hk_iceOpposeDuring)*charges
 local real windOpposeVal = LoadReal(hash_item, item_id, hk_windOpposeVal)*charges
 local real windOpposeDuring = LoadReal(hash_item, item_id, hk_windOpposeDuring)*charges
 local real lightOpposeVal = LoadReal(hash_item, item_id, hk_lightOpposeVal)*charges
 local real lightOpposeDuring = LoadReal(hash_item, item_id, hk_lightOpposeDuring)*charges
 local real darkOpposeVal = LoadReal(hash_item, item_id, hk_darkOpposeVal)*charges
 local real darkOpposeDuring = LoadReal(hash_item, item_id, hk_darkOpposeDuring)*charges
 local real woodOpposeVal = LoadReal(hash_item, item_id, hk_woodOpposeVal)*charges
 local real woodOpposeDuring = LoadReal(hash_item, item_id, hk_woodOpposeDuring)*charges
 local real thunderOpposeVal = LoadReal(hash_item, item_id, hk_thunderOpposeVal)*charges
 local real thunderOpposeDuring = LoadReal(hash_item, item_id, hk_thunderOpposeDuring)*charges
 local real poisonOpposeVal = LoadReal(hash_item, item_id, hk_poisonOpposeVal)*charges
 local real poisonOpposeDuring = LoadReal(hash_item, item_id, hk_poisonOpposeDuring)*charges
 local real ghostOpposeVal = LoadReal(hash_item, item_id, hk_ghostOpposeVal)*charges
 local real ghostOpposeDuring = LoadReal(hash_item, item_id, hk_ghostOpposeDuring)*charges
 local real metalOpposeVal = LoadReal(hash_item, item_id, hk_metalOpposeVal)*charges
 local real metalOpposeDuring = LoadReal(hash_item, item_id, hk_metalOpposeDuring)*charges
 local real dragonOpposeVal = LoadReal(hash_item, item_id, hk_dragonOpposeVal)*charges
 local real dragonOpposeDuring = LoadReal(hash_item, item_id, hk_dragonOpposeDuring)*charges
 local real toxicVal = LoadReal(hash_item, item_id, hk_toxicVal)*charges
 local real toxicDuring = LoadReal(hash_item, item_id, hk_toxicDuring)*charges
 local real burnVal = LoadReal(hash_item, item_id, hk_burnVal)*charges
 local real burnDuring = LoadReal(hash_item, item_id, hk_burnDuring)*charges
 local real dryVal = LoadReal(hash_item, item_id, hk_dryVal)*charges
 local real dryDuring = LoadReal(hash_item, item_id, hk_dryDuring)*charges
 local real freezeVal = LoadReal(hash_item, item_id, hk_freezeVal)*charges
 local real freezeDuring = LoadReal(hash_item, item_id, hk_freezeDuring)*charges
 local real coldVal = LoadReal(hash_item, item_id, hk_coldVal)*charges
 local real coldDuring = LoadReal(hash_item, item_id, hk_coldDuring)*charges
 local real bluntVal = LoadReal(hash_item, item_id, hk_bluntVal)*charges
 local real bluntDuring = LoadReal(hash_item, item_id, hk_bluntDuring)*charges
 local real muggleVal = LoadReal(hash_item, item_id, hk_muggleVal)*charges
 local real muggleDuring = LoadReal(hash_item, item_id, hk_muggleDuring)*charges
 local real myopiaVal = LoadReal(hash_item, item_id, hk_myopiaVal)*charges
 local real myopiaDuring = LoadReal(hash_item, item_id, hk_myopiaDuring)*charges
 local real blindVal = LoadReal(hash_item, item_id, hk_blindVal)*charges
 local real blindDuring = LoadReal(hash_item, item_id, hk_blindDuring)*charges
 local real corrosionVal = LoadReal(hash_item, item_id, hk_corrosionVal)*charges
 local real corrosionDuring = LoadReal(hash_item, item_id, hk_corrosionDuring)*charges
 local real chaosVal = LoadReal(hash_item, item_id, hk_chaosVal)*charges
 local real chaosDuring = LoadReal(hash_item, item_id, hk_chaosDuring)*charges
 local real twineVal = LoadReal(hash_item, item_id, hk_twineVal)*charges
 local real twineDuring = LoadReal(hash_item, item_id, hk_twineDuring)*charges
 local real drunkVal = LoadReal(hash_item, item_id, hk_drunkVal)*charges
 local real drunkDuring = LoadReal(hash_item, item_id, hk_drunkDuring)*charges
 local real tortuaVal = LoadReal(hash_item, item_id, hk_tortuaVal)*charges
 local real tortuaDuring = LoadReal(hash_item, item_id, hk_tortuaDuring)*charges
 local real weakVal = LoadReal(hash_item, item_id, hk_weakVal)*charges
 local real weakDuring = LoadReal(hash_item, item_id, hk_weakDuring)*charges
 local real astrictVal = LoadReal(hash_item, item_id, hk_astrictVal)*charges
 local real astrictDuring = LoadReal(hash_item, item_id, hk_astrictDuring)*charges
 local real foolishVal = LoadReal(hash_item, item_id, hk_foolishVal)*charges
 local real foolishDuring = LoadReal(hash_item, item_id, hk_foolishDuring)*charges
 local real dullVal = LoadReal(hash_item, item_id, hk_dullVal)*charges
 local real dullDuring = LoadReal(hash_item, item_id, hk_dullDuring)*charges
 local real dirtVal = LoadReal(hash_item, item_id, hk_dirtVal)*charges
 local real dirtDuring = LoadReal(hash_item, item_id, hk_dirtDuring)*charges
 local real swimOdds = LoadReal(hash_item, item_id, hk_swimOdds)*charges
 local real swimDuring = LoadReal(hash_item, item_id, hk_swimDuring)*charges
 local real heavyOdds = LoadReal(hash_item, item_id, hk_heavyOdds)*charges
 local real heavyVal = LoadReal(hash_item, item_id, hk_heavyVal)*charges
 local real breakOdds = LoadReal(hash_item, item_id, hk_breakOdds)*charges
 local real breakDuring = LoadReal(hash_item, item_id, hk_breakDuring)*charges
 local real unluckVal = LoadReal(hash_item, item_id, hk_unluckVal)*charges
 local real unluckDuring = LoadReal(hash_item, item_id, hk_unluckDuring)*charges
 local real silentOdds = LoadReal(hash_item, item_id, hk_silentOdds)*charges
 local real silentDuring = LoadReal(hash_item, item_id, hk_silentDuring)*charges
 local real unarmOdds = LoadReal(hash_item, item_id, hk_unarmOdds)*charges
 local real unarmDuring = LoadReal(hash_item, item_id, hk_unarmDuring)*charges
 local real fetterOdds = LoadReal(hash_item, item_id, hk_fetterOdds)*charges
 local real fetterDuring = LoadReal(hash_item, item_id, hk_fetterDuring)*charges
 local real bombVal = LoadReal(hash_item, item_id, hk_bombVal)*charges
 local real bombOdds = LoadReal(hash_item, item_id, hk_bombOdds)*charges
 local string bombModel = LoadStr(hash_item, item_id, hk_bombModel)
 local real lightningChainVal = LoadReal(hash_item, item_id, hk_lightningChainVal)*charges
 local real lightningChainOdds = LoadReal(hash_item, item_id, hk_lightningChainOdds)*charges
 local real lightningChainQty = LoadReal(hash_item, item_id, hk_lightningChainQty)*charges
 local real lightningChainReduce = LoadReal(hash_item, item_id, hk_lightningChainReduce)*charges
 local string lightningChainModel = LoadStr(hash_item, item_id, hk_lightningChainModel)
 local real crackFlyVal = LoadReal(hash_item, item_id, hk_crackFlyVal)*charges
 local real crackFlyOdds = LoadReal(hash_item, item_id, hk_crackFlyOdds)*charges
 local real crackFlyDistance = LoadReal(hash_item, item_id, hk_crackFlyDistance)*charges
 local real crackFlyHigh = LoadReal(hash_item, item_id, hk_crackFlyHigh)*charges
		//
		local string attackHuntType = LoadStr(hash_item, item_id, hk_attackHuntType)
        local unit whichUnit = htime.getUnit(t,3)
        call htime.delTimer(t)
        set t = null
		if(attackHuntType!="")then
            if(isPlus == true)then
                call hattr.addAttackHuntType(whichUnit,attackHuntType,0)
            else
                call hattr.subAttackHuntType(whichUnit,attackHuntType,0)
            endif
		endif
		//
if(goldRatio!=0)then
    if(isPlus == true)then
        call hplayer.addGoldRatio(GetOwningPlayer(whichUnit),goldRatio,0)
    else
        call hplayer.subGoldRatio(GetOwningPlayer(whichUnit),goldRatio,0)
    endif
endif
if(lumberRatio!=0)then
    if(isPlus == true)then
        call hplayer.addLumberRatio(GetOwningPlayer(whichUnit),lumberRatio,0)
    else
        call hplayer.subLumberRatio(GetOwningPlayer(whichUnit),lumberRatio,0)
    endif
endif
if(expRatio!=0)then
    if(isPlus == true)then
        call hplayer.addExpRatio(GetOwningPlayer(whichUnit),expRatio,0)
    else
        call hplayer.subExpRatio(GetOwningPlayer(whichUnit),expRatio,0)
    endif
endif
if(life!=0)then
    if(isPlus == true)then
        call hattr.addLife(whichUnit,life,0)
    else
        call hattr.subLife(whichUnit,life,0)
    endif
endif
if(mana!=0)then
    if(isPlus == true)then
        call hattr.addMana(whichUnit,mana,0)
    else
        call hattr.subMana(whichUnit,mana,0)
    endif
endif
if(move!=0)then
    if(isPlus == true)then
        call hattr.addMove(whichUnit,move,0)
    else
        call hattr.subMove(whichUnit,move,0)
    endif
endif
if(defend !=0)then
    if(isPlus == true)then
        call hattr.addDefend (whichUnit,defend ,0)
    else
        call hattr.subDefend (whichUnit,defend ,0)
    endif
endif
if(attackSpeed!=0)then
    if(isPlus == true)then
        call hattr.addAttackSpeed(whichUnit,attackSpeed,0)
    else
        call hattr.subAttackSpeed(whichUnit,attackSpeed,0)
    endif
endif
if(attackPhysical!=0)then
    if(isPlus == true)then
        call hattr.addAttackPhysical(whichUnit,attackPhysical,0)
    else
        call hattr.subAttackPhysical(whichUnit,attackPhysical,0)
    endif
endif
if(attackMagic!=0)then
    if(isPlus == true)then
        call hattr.addAttackMagic(whichUnit,attackMagic,0)
    else
        call hattr.subAttackMagic(whichUnit,attackMagic,0)
    endif
endif
if(attackRange!=0)then
    if(isPlus == true)then
        call hattr.addAttackRange(whichUnit,attackRange,0)
    else
        call hattr.subAttackRange(whichUnit,attackRange,0)
    endif
endif
if(sight!=0)then
    if(isPlus == true)then
        call hattr.addSight(whichUnit,sight,0)
    else
        call hattr.subSight(whichUnit,sight,0)
    endif
endif
if(str!=0)then
    if(isPlus == true)then
        call hattr.addStr(whichUnit,str,0)
    else
        call hattr.subStr(whichUnit,str,0)
    endif
endif
if(agi!=0)then
    if(isPlus == true)then
        call hattr.addAgi(whichUnit,agi,0)
    else
        call hattr.subAgi(whichUnit,agi,0)
    endif
endif
if(int!=0)then
    if(isPlus == true)then
        call hattr.addInt(whichUnit,int,0)
    else
        call hattr.subInt(whichUnit,int,0)
    endif
endif
if(strWhite!=0)then
    if(isPlus == true)then
        call hattr.addStrWhite(whichUnit,strWhite,0)
    else
        call hattr.subStrWhite(whichUnit,strWhite,0)
    endif
endif
if(agiWhite!=0)then
    if(isPlus == true)then
        call hattr.addAgiWhite(whichUnit,agiWhite,0)
    else
        call hattr.subAgiWhite(whichUnit,agiWhite,0)
    endif
endif
if(intWhite!=0)then
    if(isPlus == true)then
        call hattr.addIntWhite(whichUnit,intWhite,0)
    else
        call hattr.subIntWhite(whichUnit,intWhite,0)
    endif
endif
if(lifeBack!=0)then
    if(isPlus == true)then
        call hattr.addLifeBack(whichUnit,lifeBack,0)
    else
        call hattr.subLifeBack(whichUnit,lifeBack,0)
    endif
endif
if(lifeSource!=0)then
    if(isPlus == true)then
        call hattr.addLifeSource(whichUnit,lifeSource,0)
    else
        call hattr.subLifeSource(whichUnit,lifeSource,0)
    endif
endif
if(lifeSourceCurrent!=0)then
    if(isPlus == true)then
        call hattr.addLifeSourceCurrent(whichUnit,lifeSourceCurrent,0)
    else
        call hattr.subLifeSourceCurrent(whichUnit,lifeSourceCurrent,0)
    endif
endif
if(manaBack!=0)then
    if(isPlus == true)then
        call hattr.addManaBack(whichUnit,manaBack,0)
    else
        call hattr.subManaBack(whichUnit,manaBack,0)
    endif
endif
if(manaSource!=0)then
    if(isPlus == true)then
        call hattr.addManaSource(whichUnit,manaSource,0)
    else
        call hattr.subManaSource(whichUnit,manaSource,0)
    endif
endif
if(manaSourceCurrent!=0)then
    if(isPlus == true)then
        call hattr.addManaSourceCurrent(whichUnit,manaSourceCurrent,0)
    else
        call hattr.subManaSourceCurrent(whichUnit,manaSourceCurrent,0)
    endif
endif
if(resistance!=0)then
    if(isPlus == true)then
        call hattr.addResistance(whichUnit,resistance,0)
    else
        call hattr.subResistance(whichUnit,resistance,0)
    endif
endif
if(toughness!=0)then
    if(isPlus == true)then
        call hattr.addToughness(whichUnit,toughness,0)
    else
        call hattr.subToughness(whichUnit,toughness,0)
    endif
endif
if(avoid!=0)then
    if(isPlus == true)then
        call hattr.addAvoid(whichUnit,avoid,0)
    else
        call hattr.subAvoid(whichUnit,avoid,0)
    endif
endif
if(aim!=0)then
    if(isPlus == true)then
        call hattr.addAim(whichUnit,aim,0)
    else
        call hattr.subAim(whichUnit,aim,0)
    endif
endif
if(knocking!=0)then
    if(isPlus == true)then
        call hattr.addKnocking(whichUnit,knocking,0)
    else
        call hattr.subKnocking(whichUnit,knocking,0)
    endif
endif
if(violence!=0)then
    if(isPlus == true)then
        call hattr.addViolence(whichUnit,violence,0)
    else
        call hattr.subViolence(whichUnit,violence,0)
    endif
endif
if(punish!=0)then
    if(isPlus == true)then
        call hattr.addPunish(whichUnit,punish,0)
    else
        call hattr.subPunish(whichUnit,punish,0)
    endif
endif
if(punishCurrent!=0)then
    if(isPlus == true)then
        call hattr.addPunishCurrent(whichUnit,punishCurrent,0)
    else
        call hattr.subPunishCurrent(whichUnit,punishCurrent,0)
    endif
endif
if(meditative!=0)then
    if(isPlus == true)then
        call hattr.addMeditative(whichUnit,meditative,0)
    else
        call hattr.subMeditative(whichUnit,meditative,0)
    endif
endif
if(help!=0)then
    if(isPlus == true)then
        call hattr.addHelp(whichUnit,help,0)
    else
        call hattr.subHelp(whichUnit,help,0)
    endif
endif
if(hemophagia!=0)then
    if(isPlus == true)then
        call hattr.addHemophagia(whichUnit,hemophagia,0)
    else
        call hattr.subHemophagia(whichUnit,hemophagia,0)
    endif
endif
if(hemophagiaSkill!=0)then
    if(isPlus == true)then
        call hattr.addHemophagiaSkill(whichUnit,hemophagiaSkill,0)
    else
        call hattr.subHemophagiaSkill(whichUnit,hemophagiaSkill,0)
    endif
endif
if(split!=0)then
    if(isPlus == true)then
        call hattr.addSplit(whichUnit,split,0)
    else
        call hattr.subSplit(whichUnit,split,0)
    endif
endif
if(splitRange!=0)then
    if(isPlus == true)then
        call hattr.addSplitRange(whichUnit,splitRange,0)
    else
        call hattr.subSplitRange(whichUnit,splitRange,0)
    endif
endif
if(luck!=0)then
    if(isPlus == true)then
        call hattr.addLuck(whichUnit,luck,0)
    else
        call hattr.subLuck(whichUnit,luck,0)
    endif
endif
if(invincible!=0)then
    if(isPlus == true)then
        call hattr.addInvincible(whichUnit,invincible,0)
    else
        call hattr.subInvincible(whichUnit,invincible,0)
    endif
endif
if(weight!=0)then
    if(isPlus == true)then
        call hattr.addWeight(whichUnit,weight,0)
    else
        call hattr.subWeight(whichUnit,weight,0)
    endif
endif
if(weightCurrent!=0)then
    if(isPlus == true)then
        call hattr.addWeightCurrent(whichUnit,weightCurrent,0)
    else
        call hattr.subWeightCurrent(whichUnit,weightCurrent,0)
    endif
endif
if(huntAmplitude!=0)then
    if(isPlus == true)then
        call hattr.addHuntAmplitude(whichUnit,huntAmplitude,0)
    else
        call hattr.subHuntAmplitude(whichUnit,huntAmplitude,0)
    endif
endif
if(huntRebound!=0)then
    if(isPlus == true)then
        call hattr.addHuntRebound(whichUnit,huntRebound,0)
    else
        call hattr.subHuntRebound(whichUnit,huntRebound,0)
    endif
endif
if(cure!=0)then
    if(isPlus == true)then
        call hattr.addCure(whichUnit,cure,0)
    else
        call hattr.subCure(whichUnit,cure,0)
    endif
endif
if(knockingOppose!=0)then
    if(isPlus == true)then
        call hattr.addKnockingOppose(whichUnit,knockingOppose,0)
    else
        call hattr.subKnockingOppose(whichUnit,knockingOppose,0)
    endif
endif
if(violenceOppose!=0)then
    if(isPlus == true)then
        call hattr.addViolenceOppose(whichUnit,violenceOppose,0)
    else
        call hattr.subViolenceOppose(whichUnit,violenceOppose,0)
    endif
endif
if(hemophagiaOppose!=0)then
    if(isPlus == true)then
        call hattr.addHemophagiaOppose(whichUnit,hemophagiaOppose,0)
    else
        call hattr.subHemophagiaOppose(whichUnit,hemophagiaOppose,0)
    endif
endif
if(splitOppose!=0)then
    if(isPlus == true)then
        call hattr.addSplitOppose(whichUnit,splitOppose,0)
    else
        call hattr.subSplitOppose(whichUnit,splitOppose,0)
    endif
endif
if(punishOppose!=0)then
    if(isPlus == true)then
        call hattr.addPunishOppose(whichUnit,punishOppose,0)
    else
        call hattr.subPunishOppose(whichUnit,punishOppose,0)
    endif
endif
if(huntReboundOppose!=0)then
    if(isPlus == true)then
        call hattr.addHuntReboundOppose(whichUnit,huntReboundOppose,0)
    else
        call hattr.subHuntReboundOppose(whichUnit,huntReboundOppose,0)
    endif
endif
if(swimOppose!=0)then
    if(isPlus == true)then
        call hattr.addSwimOppose(whichUnit,swimOppose,0)
    else
        call hattr.subSwimOppose(whichUnit,swimOppose,0)
    endif
endif
if(heavyOppose!=0)then
    if(isPlus == true)then
        call hattr.addHeavyOppose(whichUnit,heavyOppose,0)
    else
        call hattr.subHeavyOppose(whichUnit,heavyOppose,0)
    endif
endif
if(breakOppose!=0)then
    if(isPlus == true)then
        call hattr.addBreakOppose(whichUnit,breakOppose,0)
    else
        call hattr.subBreakOppose(whichUnit,breakOppose,0)
    endif
endif
if(unluckOppose!=0)then
    if(isPlus == true)then
        call hattr.addUnluckOppose(whichUnit,unluckOppose,0)
    else
        call hattr.subUnluckOppose(whichUnit,unluckOppose,0)
    endif
endif
if(silentOppose!=0)then
    if(isPlus == true)then
        call hattr.addSilentOppose(whichUnit,silentOppose,0)
    else
        call hattr.subSilentOppose(whichUnit,silentOppose,0)
    endif
endif
if(unarmOppose!=0)then
    if(isPlus == true)then
        call hattr.addUnarmOppose(whichUnit,unarmOppose,0)
    else
        call hattr.subUnarmOppose(whichUnit,unarmOppose,0)
    endif
endif
if(fetterOppose!=0)then
    if(isPlus == true)then
        call hattr.addFetterOppose(whichUnit,fetterOppose,0)
    else
        call hattr.subFetterOppose(whichUnit,fetterOppose,0)
    endif
endif
if(bombOppose!=0)then
    if(isPlus == true)then
        call hattr.addBombOppose(whichUnit,bombOppose,0)
    else
        call hattr.subBombOppose(whichUnit,bombOppose,0)
    endif
endif
if(lightningChainOppose!=0)then
    if(isPlus == true)then
        call hattr.addLightningChainOppose(whichUnit,lightningChainOppose,0)
    else
        call hattr.subLightningChainOppose(whichUnit,lightningChainOppose,0)
    endif
endif
if(crackFlyOppose!=0)then
    if(isPlus == true)then
        call hattr.addCrackFlyOppose(whichUnit,crackFlyOppose,0)
    else
        call hattr.subCrackFlyOppose(whichUnit,crackFlyOppose,0)
    endif
endif
if(fire!=0)then
    if(isPlus == true)then
        call hattrNatural.addFire(whichUnit,fire,0)
    else
        call hattrNatural.subFire(whichUnit,fire,0)
    endif
endif
if(soil!=0)then
    if(isPlus == true)then
        call hattrNatural.addSoil(whichUnit,soil,0)
    else
        call hattrNatural.subSoil(whichUnit,soil,0)
    endif
endif
if(water!=0)then
    if(isPlus == true)then
        call hattrNatural.addWater(whichUnit,water,0)
    else
        call hattrNatural.subWater(whichUnit,water,0)
    endif
endif
if(ice!=0)then
    if(isPlus == true)then
        call hattrNatural.addIce(whichUnit,ice,0)
    else
        call hattrNatural.subIce(whichUnit,ice,0)
    endif
endif
if(wind!=0)then
    if(isPlus == true)then
        call hattrNatural.addWind(whichUnit,wind,0)
    else
        call hattrNatural.subWind(whichUnit,wind,0)
    endif
endif
if(light!=0)then
    if(isPlus == true)then
        call hattrNatural.addLight(whichUnit,light,0)
    else
        call hattrNatural.subLight(whichUnit,light,0)
    endif
endif
if(dark!=0)then
    if(isPlus == true)then
        call hattrNatural.addDark(whichUnit,dark,0)
    else
        call hattrNatural.subDark(whichUnit,dark,0)
    endif
endif
if(wood!=0)then
    if(isPlus == true)then
        call hattrNatural.addWood(whichUnit,wood,0)
    else
        call hattrNatural.subWood(whichUnit,wood,0)
    endif
endif
if(thunder!=0)then
    if(isPlus == true)then
        call hattrNatural.addThunder(whichUnit,thunder,0)
    else
        call hattrNatural.subThunder(whichUnit,thunder,0)
    endif
endif
if(poison!=0)then
    if(isPlus == true)then
        call hattrNatural.addPoison(whichUnit,poison,0)
    else
        call hattrNatural.subPoison(whichUnit,poison,0)
    endif
endif
if(ghost!=0)then
    if(isPlus == true)then
        call hattrNatural.addGhost(whichUnit,ghost,0)
    else
        call hattrNatural.subGhost(whichUnit,ghost,0)
    endif
endif
if(metal!=0)then
    if(isPlus == true)then
        call hattrNatural.addMetal(whichUnit,metal,0)
    else
        call hattrNatural.subMetal(whichUnit,metal,0)
    endif
endif
if(dragon!=0)then
    if(isPlus == true)then
        call hattrNatural.addDragon(whichUnit,dragon,0)
    else
        call hattrNatural.subDragon(whichUnit,dragon,0)
    endif
endif
if(fireOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addFireOppose(whichUnit,fireOppose,0)
    else
        call hattrNatural.subFireOppose(whichUnit,fireOppose,0)
    endif
endif
if(soilOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addSoilOppose(whichUnit,soilOppose,0)
    else
        call hattrNatural.subSoilOppose(whichUnit,soilOppose,0)
    endif
endif
if(waterOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addWaterOppose(whichUnit,waterOppose,0)
    else
        call hattrNatural.subWaterOppose(whichUnit,waterOppose,0)
    endif
endif
if(iceOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addIceOppose(whichUnit,iceOppose,0)
    else
        call hattrNatural.subIceOppose(whichUnit,iceOppose,0)
    endif
endif
if(windOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addWindOppose(whichUnit,windOppose,0)
    else
        call hattrNatural.subWindOppose(whichUnit,windOppose,0)
    endif
endif
if(lightOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addLightOppose(whichUnit,lightOppose,0)
    else
        call hattrNatural.subLightOppose(whichUnit,lightOppose,0)
    endif
endif
if(darkOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addDarkOppose(whichUnit,darkOppose,0)
    else
        call hattrNatural.subDarkOppose(whichUnit,darkOppose,0)
    endif
endif
if(woodOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addWoodOppose(whichUnit,woodOppose,0)
    else
        call hattrNatural.subWoodOppose(whichUnit,woodOppose,0)
    endif
endif
if(thunderOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addThunderOppose(whichUnit,thunderOppose,0)
    else
        call hattrNatural.subThunderOppose(whichUnit,thunderOppose,0)
    endif
endif
if(poisonOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addPoisonOppose(whichUnit,poisonOppose,0)
    else
        call hattrNatural.subPoisonOppose(whichUnit,poisonOppose,0)
    endif
endif
if(ghostOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addGhostOppose(whichUnit,ghostOppose,0)
    else
        call hattrNatural.subGhostOppose(whichUnit,ghostOppose,0)
    endif
endif
if(metalOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addMetalOppose(whichUnit,metalOppose,0)
    else
        call hattrNatural.subMetalOppose(whichUnit,metalOppose,0)
    endif
endif
if(dragonOppose!=0)then
    if(isPlus == true)then
        call hattrNatural.addDragonOppose(whichUnit,dragonOppose,0)
    else
        call hattrNatural.subDragonOppose(whichUnit,dragonOppose,0)
    endif
endif
 if(lifeBackVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addLifeBackVal(whichUnit,lifeBackVal,0)
    else
        call hattrEffect.subLifeBackVal(whichUnit,lifeBackVal,0)
    endif
endif
 if(lifeBackDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addLifeBackDuring(whichUnit,lifeBackDuring,0)
    else
        call hattrEffect.subLifeBackDuring(whichUnit,lifeBackDuring,0)
    endif
endif
 if(manaBackVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addManaBackVal(whichUnit,manaBackVal,0)
    else
        call hattrEffect.subManaBackVal(whichUnit,manaBackVal,0)
    endif
endif
 if(manaBackDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addManaBackDuring(whichUnit,manaBackDuring,0)
    else
        call hattrEffect.subManaBackDuring(whichUnit,manaBackDuring,0)
    endif
endif
 if(attackSpeedVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackSpeedVal(whichUnit,attackSpeedVal,0)
    else
        call hattrEffect.subAttackSpeedVal(whichUnit,attackSpeedVal,0)
    endif
endif
 if(attackSpeedDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackSpeedDuring(whichUnit,attackSpeedDuring,0)
    else
        call hattrEffect.subAttackSpeedDuring(whichUnit,attackSpeedDuring,0)
    endif
endif
 if(attackPhysicalVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackPhysicalVal(whichUnit,attackPhysicalVal,0)
    else
        call hattrEffect.subAttackPhysicalVal(whichUnit,attackPhysicalVal,0)
    endif
endif
 if(attackPhysicalDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackPhysicalDuring(whichUnit,attackPhysicalDuring,0)
    else
        call hattrEffect.subAttackPhysicalDuring(whichUnit,attackPhysicalDuring,0)
    endif
endif
 if(attackMagicVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackMagicVal(whichUnit,attackMagicVal,0)
    else
        call hattrEffect.subAttackMagicVal(whichUnit,attackMagicVal,0)
    endif
endif
 if(attackMagicDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackMagicDuring(whichUnit,attackMagicDuring,0)
    else
        call hattrEffect.subAttackMagicDuring(whichUnit,attackMagicDuring,0)
    endif
endif
 if(attackRangeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackRangeVal(whichUnit,attackRangeVal,0)
    else
        call hattrEffect.subAttackRangeVal(whichUnit,attackRangeVal,0)
    endif
endif
 if(attackRangeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addAttackRangeDuring(whichUnit,attackRangeDuring,0)
    else
        call hattrEffect.subAttackRangeDuring(whichUnit,attackRangeDuring,0)
    endif
endif
 if(sightVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addSightVal(whichUnit,sightVal,0)
    else
        call hattrEffect.subSightVal(whichUnit,sightVal,0)
    endif
endif
 if(sightDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addSightDuring(whichUnit,sightDuring,0)
    else
        call hattrEffect.subSightDuring(whichUnit,sightDuring,0)
    endif
endif
 if(moveVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addMoveVal(whichUnit,moveVal,0)
    else
        call hattrEffect.subMoveVal(whichUnit,moveVal,0)
    endif
endif
 if(moveDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addMoveDuring(whichUnit,moveDuring,0)
    else
        call hattrEffect.subMoveDuring(whichUnit,moveDuring,0)
    endif
endif
 if(aimVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addAimVal(whichUnit,aimVal,0)
    else
        call hattrEffect.subAimVal(whichUnit,aimVal,0)
    endif
endif
 if(aimDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addAimDuring(whichUnit,aimDuring,0)
    else
        call hattrEffect.subAimDuring(whichUnit,aimDuring,0)
    endif
endif
 if(strVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addStrVal(whichUnit,strVal,0)
    else
        call hattrEffect.subStrVal(whichUnit,strVal,0)
    endif
endif
 if(strDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addStrDuring(whichUnit,strDuring,0)
    else
        call hattrEffect.subStrDuring(whichUnit,strDuring,0)
    endif
endif
 if(agiVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addAgiVal(whichUnit,agiVal,0)
    else
        call hattrEffect.subAgiVal(whichUnit,agiVal,0)
    endif
endif
 if(agiDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addAgiDuring(whichUnit,agiDuring,0)
    else
        call hattrEffect.subAgiDuring(whichUnit,agiDuring,0)
    endif
endif
 if(intVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addIntVal(whichUnit,intVal,0)
    else
        call hattrEffect.subIntVal(whichUnit,intVal,0)
    endif
endif
 if(intDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addIntDuring(whichUnit,intDuring,0)
    else
        call hattrEffect.subIntDuring(whichUnit,intDuring,0)
    endif
endif
 if(knockingVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addKnockingVal(whichUnit,knockingVal,0)
    else
        call hattrEffect.subKnockingVal(whichUnit,knockingVal,0)
    endif
endif
 if(knockingDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addKnockingDuring(whichUnit,knockingDuring,0)
    else
        call hattrEffect.subKnockingDuring(whichUnit,knockingDuring,0)
    endif
endif
 if(violenceVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addViolenceVal(whichUnit,violenceVal,0)
    else
        call hattrEffect.subViolenceVal(whichUnit,violenceVal,0)
    endif
endif
 if(violenceDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addViolenceDuring(whichUnit,violenceDuring,0)
    else
        call hattrEffect.subViolenceDuring(whichUnit,violenceDuring,0)
    endif
endif
 if(hemophagiaVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addHemophagiaVal(whichUnit,hemophagiaVal,0)
    else
        call hattrEffect.subHemophagiaVal(whichUnit,hemophagiaVal,0)
    endif
endif
 if(hemophagiaDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addHemophagiaDuring(whichUnit,hemophagiaDuring,0)
    else
        call hattrEffect.subHemophagiaDuring(whichUnit,hemophagiaDuring,0)
    endif
endif
 if(hemophagiaSkillVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addHemophagiaSkillVal(whichUnit,hemophagiaSkillVal,0)
    else
        call hattrEffect.subHemophagiaSkillVal(whichUnit,hemophagiaSkillVal,0)
    endif
endif
 if(hemophagiaSkillDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addHemophagiaSkillDuring(whichUnit,hemophagiaSkillDuring,0)
    else
        call hattrEffect.subHemophagiaSkillDuring(whichUnit,hemophagiaSkillDuring,0)
    endif
endif
 if(splitVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addSplitVal(whichUnit,splitVal,0)
    else
        call hattrEffect.subSplitVal(whichUnit,splitVal,0)
    endif
endif
 if(splitDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addSplitDuring(whichUnit,splitDuring,0)
    else
        call hattrEffect.subSplitDuring(whichUnit,splitDuring,0)
    endif
endif
 if(luckVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addLuckVal(whichUnit,luckVal,0)
    else
        call hattrEffect.subLuckVal(whichUnit,luckVal,0)
    endif
endif
 if(luckDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addLuckDuring(whichUnit,luckDuring,0)
    else
        call hattrEffect.subLuckDuring(whichUnit,luckDuring,0)
    endif
endif
 if(huntAmplitudeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addHuntAmplitudeVal(whichUnit,huntAmplitudeVal,0)
    else
        call hattrEffect.subHuntAmplitudeVal(whichUnit,huntAmplitudeVal,0)
    endif
endif
 if(huntAmplitudeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addHuntAmplitudeDuring(whichUnit,huntAmplitudeDuring,0)
    else
        call hattrEffect.subHuntAmplitudeDuring(whichUnit,huntAmplitudeDuring,0)
    endif
endif
 if(fireVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addFireVal(whichUnit,fireVal,0)
    else
        call hattrEffect.subFireVal(whichUnit,fireVal,0)
    endif
endif
 if(fireDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addFireDuring(whichUnit,fireDuring,0)
    else
        call hattrEffect.subFireDuring(whichUnit,fireDuring,0)
    endif
endif
 if(soilVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addSoilVal(whichUnit,soilVal,0)
    else
        call hattrEffect.subSoilVal(whichUnit,soilVal,0)
    endif
endif
 if(soilDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addSoilDuring(whichUnit,soilDuring,0)
    else
        call hattrEffect.subSoilDuring(whichUnit,soilDuring,0)
    endif
endif
 if(waterVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addWaterVal(whichUnit,waterVal,0)
    else
        call hattrEffect.subWaterVal(whichUnit,waterVal,0)
    endif
endif
 if(waterDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addWaterDuring(whichUnit,waterDuring,0)
    else
        call hattrEffect.subWaterDuring(whichUnit,waterDuring,0)
    endif
endif
 if(iceVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addIceVal(whichUnit,iceVal,0)
    else
        call hattrEffect.subIceVal(whichUnit,iceVal,0)
    endif
endif
 if(iceDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addIceDuring(whichUnit,iceDuring,0)
    else
        call hattrEffect.subIceDuring(whichUnit,iceDuring,0)
    endif
endif
 if(windVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addWindVal(whichUnit,windVal,0)
    else
        call hattrEffect.subWindVal(whichUnit,windVal,0)
    endif
endif
 if(windDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addWindDuring(whichUnit,windDuring,0)
    else
        call hattrEffect.subWindDuring(whichUnit,windDuring,0)
    endif
endif
 if(lightVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightVal(whichUnit,lightVal,0)
    else
        call hattrEffect.subLightVal(whichUnit,lightVal,0)
    endif
endif
 if(lightDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightDuring(whichUnit,lightDuring,0)
    else
        call hattrEffect.subLightDuring(whichUnit,lightDuring,0)
    endif
endif
 if(darkVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDarkVal(whichUnit,darkVal,0)
    else
        call hattrEffect.subDarkVal(whichUnit,darkVal,0)
    endif
endif
 if(darkDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDarkDuring(whichUnit,darkDuring,0)
    else
        call hattrEffect.subDarkDuring(whichUnit,darkDuring,0)
    endif
endif
 if(woodVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addWoodVal(whichUnit,woodVal,0)
    else
        call hattrEffect.subWoodVal(whichUnit,woodVal,0)
    endif
endif
 if(woodDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addWoodDuring(whichUnit,woodDuring,0)
    else
        call hattrEffect.subWoodDuring(whichUnit,woodDuring,0)
    endif
endif
 if(thunderVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addThunderVal(whichUnit,thunderVal,0)
    else
        call hattrEffect.subThunderVal(whichUnit,thunderVal,0)
    endif
endif
 if(thunderDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addThunderDuring(whichUnit,thunderDuring,0)
    else
        call hattrEffect.subThunderDuring(whichUnit,thunderDuring,0)
    endif
endif
 if(poisonVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addPoisonVal(whichUnit,poisonVal,0)
    else
        call hattrEffect.subPoisonVal(whichUnit,poisonVal,0)
    endif
endif
 if(poisonDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addPoisonDuring(whichUnit,poisonDuring,0)
    else
        call hattrEffect.subPoisonDuring(whichUnit,poisonDuring,0)
    endif
endif
 if(ghostVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addGhostVal(whichUnit,ghostVal,0)
    else
        call hattrEffect.subGhostVal(whichUnit,ghostVal,0)
    endif
endif
 if(ghostDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addGhostDuring(whichUnit,ghostDuring,0)
    else
        call hattrEffect.subGhostDuring(whichUnit,ghostDuring,0)
    endif
endif
 if(metalVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addMetalVal(whichUnit,metalVal,0)
    else
        call hattrEffect.subMetalVal(whichUnit,metalVal,0)
    endif
endif
 if(metalDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addMetalDuring(whichUnit,metalDuring,0)
    else
        call hattrEffect.subMetalDuring(whichUnit,metalDuring,0)
    endif
endif
 if(dragonVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDragonVal(whichUnit,dragonVal,0)
    else
        call hattrEffect.subDragonVal(whichUnit,dragonVal,0)
    endif
endif
 if(dragonDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDragonDuring(whichUnit,dragonDuring,0)
    else
        call hattrEffect.subDragonDuring(whichUnit,dragonDuring,0)
    endif
endif
 if(fireOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addFireOpposeVal(whichUnit,fireOpposeVal,0)
    else
        call hattrEffect.subFireOpposeVal(whichUnit,fireOpposeVal,0)
    endif
endif
 if(fireOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addFireOpposeDuring(whichUnit,fireOpposeDuring,0)
    else
        call hattrEffect.subFireOpposeDuring(whichUnit,fireOpposeDuring,0)
    endif
endif
 if(soilOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addSoilOpposeVal(whichUnit,soilOpposeVal,0)
    else
        call hattrEffect.subSoilOpposeVal(whichUnit,soilOpposeVal,0)
    endif
endif
 if(soilOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addSoilOpposeDuring(whichUnit,soilOpposeDuring,0)
    else
        call hattrEffect.subSoilOpposeDuring(whichUnit,soilOpposeDuring,0)
    endif
endif
 if(waterOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addWaterOpposeVal(whichUnit,waterOpposeVal,0)
    else
        call hattrEffect.subWaterOpposeVal(whichUnit,waterOpposeVal,0)
    endif
endif
 if(waterOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addWaterOpposeDuring(whichUnit,waterOpposeDuring,0)
    else
        call hattrEffect.subWaterOpposeDuring(whichUnit,waterOpposeDuring,0)
    endif
endif
 if(iceOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addIceOpposeVal(whichUnit,iceOpposeVal,0)
    else
        call hattrEffect.subIceOpposeVal(whichUnit,iceOpposeVal,0)
    endif
endif
 if(iceOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addIceOpposeDuring(whichUnit,iceOpposeDuring,0)
    else
        call hattrEffect.subIceOpposeDuring(whichUnit,iceOpposeDuring,0)
    endif
endif
 if(windOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addWindOpposeVal(whichUnit,windOpposeVal,0)
    else
        call hattrEffect.subWindOpposeVal(whichUnit,windOpposeVal,0)
    endif
endif
 if(windOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addWindOpposeDuring(whichUnit,windOpposeDuring,0)
    else
        call hattrEffect.subWindOpposeDuring(whichUnit,windOpposeDuring,0)
    endif
endif
 if(lightOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightOpposeVal(whichUnit,lightOpposeVal,0)
    else
        call hattrEffect.subLightOpposeVal(whichUnit,lightOpposeVal,0)
    endif
endif
 if(lightOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightOpposeDuring(whichUnit,lightOpposeDuring,0)
    else
        call hattrEffect.subLightOpposeDuring(whichUnit,lightOpposeDuring,0)
    endif
endif
 if(darkOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDarkOpposeVal(whichUnit,darkOpposeVal,0)
    else
        call hattrEffect.subDarkOpposeVal(whichUnit,darkOpposeVal,0)
    endif
endif
 if(darkOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDarkOpposeDuring(whichUnit,darkOpposeDuring,0)
    else
        call hattrEffect.subDarkOpposeDuring(whichUnit,darkOpposeDuring,0)
    endif
endif
 if(woodOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addWoodOpposeVal(whichUnit,woodOpposeVal,0)
    else
        call hattrEffect.subWoodOpposeVal(whichUnit,woodOpposeVal,0)
    endif
endif
 if(woodOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addWoodOpposeDuring(whichUnit,woodOpposeDuring,0)
    else
        call hattrEffect.subWoodOpposeDuring(whichUnit,woodOpposeDuring,0)
    endif
endif
 if(thunderOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addThunderOpposeVal(whichUnit,thunderOpposeVal,0)
    else
        call hattrEffect.subThunderOpposeVal(whichUnit,thunderOpposeVal,0)
    endif
endif
 if(thunderOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addThunderOpposeDuring(whichUnit,thunderOpposeDuring,0)
    else
        call hattrEffect.subThunderOpposeDuring(whichUnit,thunderOpposeDuring,0)
    endif
endif
 if(poisonOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addPoisonOpposeVal(whichUnit,poisonOpposeVal,0)
    else
        call hattrEffect.subPoisonOpposeVal(whichUnit,poisonOpposeVal,0)
    endif
endif
 if(poisonOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addPoisonOpposeDuring(whichUnit,poisonOpposeDuring,0)
    else
        call hattrEffect.subPoisonOpposeDuring(whichUnit,poisonOpposeDuring,0)
    endif
endif
 if(ghostOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addGhostOpposeVal(whichUnit,ghostOpposeVal,0)
    else
        call hattrEffect.subGhostOpposeVal(whichUnit,ghostOpposeVal,0)
    endif
endif
 if(ghostOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addGhostOpposeDuring(whichUnit,ghostOpposeDuring,0)
    else
        call hattrEffect.subGhostOpposeDuring(whichUnit,ghostOpposeDuring,0)
    endif
endif
 if(metalOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addMetalOpposeVal(whichUnit,metalOpposeVal,0)
    else
        call hattrEffect.subMetalOpposeVal(whichUnit,metalOpposeVal,0)
    endif
endif
 if(metalOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addMetalOpposeDuring(whichUnit,metalOpposeDuring,0)
    else
        call hattrEffect.subMetalOpposeDuring(whichUnit,metalOpposeDuring,0)
    endif
endif
 if(dragonOpposeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDragonOpposeVal(whichUnit,dragonOpposeVal,0)
    else
        call hattrEffect.subDragonOpposeVal(whichUnit,dragonOpposeVal,0)
    endif
endif
 if(dragonOpposeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDragonOpposeDuring(whichUnit,dragonOpposeDuring,0)
    else
        call hattrEffect.subDragonOpposeDuring(whichUnit,dragonOpposeDuring,0)
    endif
endif
 if(toxicVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addToxicVal(whichUnit,toxicVal,0)
    else
        call hattrEffect.subToxicVal(whichUnit,toxicVal,0)
    endif
endif
 if(toxicDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addToxicDuring(whichUnit,toxicDuring,0)
    else
        call hattrEffect.subToxicDuring(whichUnit,toxicDuring,0)
    endif
endif
 if(burnVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addBurnVal(whichUnit,burnVal,0)
    else
        call hattrEffect.subBurnVal(whichUnit,burnVal,0)
    endif
endif
 if(burnDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addBurnDuring(whichUnit,burnDuring,0)
    else
        call hattrEffect.subBurnDuring(whichUnit,burnDuring,0)
    endif
endif
 if(dryVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDryVal(whichUnit,dryVal,0)
    else
        call hattrEffect.subDryVal(whichUnit,dryVal,0)
    endif
endif
 if(dryDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDryDuring(whichUnit,dryDuring,0)
    else
        call hattrEffect.subDryDuring(whichUnit,dryDuring,0)
    endif
endif
 if(freezeVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addFreezeVal(whichUnit,freezeVal,0)
    else
        call hattrEffect.subFreezeVal(whichUnit,freezeVal,0)
    endif
endif
 if(freezeDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addFreezeDuring(whichUnit,freezeDuring,0)
    else
        call hattrEffect.subFreezeDuring(whichUnit,freezeDuring,0)
    endif
endif
 if(coldVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addColdVal(whichUnit,coldVal,0)
    else
        call hattrEffect.subColdVal(whichUnit,coldVal,0)
    endif
endif
 if(coldDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addColdDuring(whichUnit,coldDuring,0)
    else
        call hattrEffect.subColdDuring(whichUnit,coldDuring,0)
    endif
endif
 if(bluntVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addBluntVal(whichUnit,bluntVal,0)
    else
        call hattrEffect.subBluntVal(whichUnit,bluntVal,0)
    endif
endif
 if(bluntDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addBluntDuring(whichUnit,bluntDuring,0)
    else
        call hattrEffect.subBluntDuring(whichUnit,bluntDuring,0)
    endif
endif
 if(muggleVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addMuggleVal(whichUnit,muggleVal,0)
    else
        call hattrEffect.subMuggleVal(whichUnit,muggleVal,0)
    endif
endif
 if(muggleDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addMuggleDuring(whichUnit,muggleDuring,0)
    else
        call hattrEffect.subMuggleDuring(whichUnit,muggleDuring,0)
    endif
endif
 if(myopiaVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addMyopiaVal(whichUnit,myopiaVal,0)
    else
        call hattrEffect.subMyopiaVal(whichUnit,myopiaVal,0)
    endif
endif
 if(myopiaDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addMyopiaDuring(whichUnit,myopiaDuring,0)
    else
        call hattrEffect.subMyopiaDuring(whichUnit,myopiaDuring,0)
    endif
endif
 if(blindVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addBlindVal(whichUnit,blindVal,0)
    else
        call hattrEffect.subBlindVal(whichUnit,blindVal,0)
    endif
endif
 if(blindDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addBlindDuring(whichUnit,blindDuring,0)
    else
        call hattrEffect.subBlindDuring(whichUnit,blindDuring,0)
    endif
endif
 if(corrosionVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addCorrosionVal(whichUnit,corrosionVal,0)
    else
        call hattrEffect.subCorrosionVal(whichUnit,corrosionVal,0)
    endif
endif
 if(corrosionDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addCorrosionDuring(whichUnit,corrosionDuring,0)
    else
        call hattrEffect.subCorrosionDuring(whichUnit,corrosionDuring,0)
    endif
endif
 if(chaosVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addChaosVal(whichUnit,chaosVal,0)
    else
        call hattrEffect.subChaosVal(whichUnit,chaosVal,0)
    endif
endif
 if(chaosDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addChaosDuring(whichUnit,chaosDuring,0)
    else
        call hattrEffect.subChaosDuring(whichUnit,chaosDuring,0)
    endif
endif
 if(twineVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addTwineVal(whichUnit,twineVal,0)
    else
        call hattrEffect.subTwineVal(whichUnit,twineVal,0)
    endif
endif
 if(twineDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addTwineDuring(whichUnit,twineDuring,0)
    else
        call hattrEffect.subTwineDuring(whichUnit,twineDuring,0)
    endif
endif
 if(drunkVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDrunkVal(whichUnit,drunkVal,0)
    else
        call hattrEffect.subDrunkVal(whichUnit,drunkVal,0)
    endif
endif
 if(drunkDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDrunkDuring(whichUnit,drunkDuring,0)
    else
        call hattrEffect.subDrunkDuring(whichUnit,drunkDuring,0)
    endif
endif
 if(tortuaVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addTortuaVal(whichUnit,tortuaVal,0)
    else
        call hattrEffect.subTortuaVal(whichUnit,tortuaVal,0)
    endif
endif
 if(tortuaDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addTortuaDuring(whichUnit,tortuaDuring,0)
    else
        call hattrEffect.subTortuaDuring(whichUnit,tortuaDuring,0)
    endif
endif
 if(weakVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addWeakVal(whichUnit,weakVal,0)
    else
        call hattrEffect.subWeakVal(whichUnit,weakVal,0)
    endif
endif
 if(weakDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addWeakDuring(whichUnit,weakDuring,0)
    else
        call hattrEffect.subWeakDuring(whichUnit,weakDuring,0)
    endif
endif
 if(astrictVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addAstrictVal(whichUnit,astrictVal,0)
    else
        call hattrEffect.subAstrictVal(whichUnit,astrictVal,0)
    endif
endif
 if(astrictDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addAstrictDuring(whichUnit,astrictDuring,0)
    else
        call hattrEffect.subAstrictDuring(whichUnit,astrictDuring,0)
    endif
endif
 if(foolishVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addFoolishVal(whichUnit,foolishVal,0)
    else
        call hattrEffect.subFoolishVal(whichUnit,foolishVal,0)
    endif
endif
 if(foolishDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addFoolishDuring(whichUnit,foolishDuring,0)
    else
        call hattrEffect.subFoolishDuring(whichUnit,foolishDuring,0)
    endif
endif
 if(dullVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDullVal(whichUnit,dullVal,0)
    else
        call hattrEffect.subDullVal(whichUnit,dullVal,0)
    endif
endif
 if(dullDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDullDuring(whichUnit,dullDuring,0)
    else
        call hattrEffect.subDullDuring(whichUnit,dullDuring,0)
    endif
endif
 if(dirtVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addDirtVal(whichUnit,dirtVal,0)
    else
        call hattrEffect.subDirtVal(whichUnit,dirtVal,0)
    endif
endif
 if(dirtDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addDirtDuring(whichUnit,dirtDuring,0)
    else
        call hattrEffect.subDirtDuring(whichUnit,dirtDuring,0)
    endif
endif
 if(swimOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addSwimOdds(whichUnit,swimOdds,0)
    else
        call hattrEffect.subSwimOdds(whichUnit,swimOdds,0)
    endif
endif
 if(swimDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addSwimDuring(whichUnit,swimDuring,0)
    else
        call hattrEffect.subSwimDuring(whichUnit,swimDuring,0)
    endif
endif
 if(heavyOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addHeavyOdds(whichUnit,heavyOdds,0)
    else
        call hattrEffect.subHeavyOdds(whichUnit,heavyOdds,0)
    endif
endif
 if(heavyVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addHeavyVal(whichUnit,heavyVal,0)
    else
        call hattrEffect.subHeavyVal(whichUnit,heavyVal,0)
    endif
endif
 if(breakOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addBreakOdds(whichUnit,breakOdds,0)
    else
        call hattrEffect.subBreakOdds(whichUnit,breakOdds,0)
    endif
endif
 if(breakDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addBreakDuring(whichUnit,breakDuring,0)
    else
        call hattrEffect.subBreakDuring(whichUnit,breakDuring,0)
    endif
endif
 if(unluckVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addUnluckVal(whichUnit,unluckVal,0)
    else
        call hattrEffect.subUnluckVal(whichUnit,unluckVal,0)
    endif
endif
 if(unluckDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addUnluckDuring(whichUnit,unluckDuring,0)
    else
        call hattrEffect.subUnluckDuring(whichUnit,unluckDuring,0)
    endif
endif
 if(silentOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addSilentOdds(whichUnit,silentOdds,0)
    else
        call hattrEffect.subSilentOdds(whichUnit,silentOdds,0)
    endif
endif
 if(silentDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addSilentDuring(whichUnit,silentDuring,0)
    else
        call hattrEffect.subSilentDuring(whichUnit,silentDuring,0)
    endif
endif
 if(unarmOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addUnarmOdds(whichUnit,unarmOdds,0)
    else
        call hattrEffect.subUnarmOdds(whichUnit,unarmOdds,0)
    endif
endif
 if(unarmDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addUnarmDuring(whichUnit,unarmDuring,0)
    else
        call hattrEffect.subUnarmDuring(whichUnit,unarmDuring,0)
    endif
endif
 if(fetterOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addFetterOdds(whichUnit,fetterOdds,0)
    else
        call hattrEffect.subFetterOdds(whichUnit,fetterOdds,0)
    endif
endif
 if(fetterDuring!=0)then
    if(isPlus == true)then
        call hattrEffect.addFetterDuring(whichUnit,fetterDuring,0)
    else
        call hattrEffect.subFetterDuring(whichUnit,fetterDuring,0)
    endif
endif
 if(bombVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addBombVal(whichUnit,bombVal,0)
    else
        call hattrEffect.subBombVal(whichUnit,bombVal,0)
    endif
endif
 if(bombOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addBombOdds(whichUnit,bombOdds,0)
    else
        call hattrEffect.subBombOdds(whichUnit,bombOdds,0)
    endif
endif
 if(bombModel!="" and isPlus == true)then
    call hattrEffect.setBombModel(whichUnit,bombModel)
endif
 if(lightningChainVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightningChainVal(whichUnit,lightningChainVal,0)
    else
        call hattrEffect.subLightningChainVal(whichUnit,lightningChainVal,0)
    endif
endif
 if(lightningChainOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightningChainOdds(whichUnit,lightningChainOdds,0)
    else
        call hattrEffect.subLightningChainOdds(whichUnit,lightningChainOdds,0)
    endif
endif
 if(lightningChainQty!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightningChainQty(whichUnit,lightningChainQty,0)
    else
        call hattrEffect.subLightningChainQty(whichUnit,lightningChainQty,0)
    endif
endif
 if(lightningChainReduce!=0)then
    if(isPlus == true)then
        call hattrEffect.addLightningChainReduce(whichUnit,lightningChainReduce,0)
    else
        call hattrEffect.subLightningChainReduce(whichUnit,lightningChainReduce,0)
    endif
endif
 if(lightningChainModel!="" and isPlus == true)then
    call hattrEffect.setLightningChainModel(whichUnit,lightningChainModel)
endif
 if(crackFlyVal!=0)then
    if(isPlus == true)then
        call hattrEffect.addCrackFlyVal(whichUnit,crackFlyVal,0)
    else
        call hattrEffect.subCrackFlyVal(whichUnit,crackFlyVal,0)
    endif
endif
 if(crackFlyOdds!=0)then
    if(isPlus == true)then
        call hattrEffect.addCrackFlyOdds(whichUnit,crackFlyOdds,0)
    else
        call hattrEffect.subCrackFlyOdds(whichUnit,crackFlyOdds,0)
    endif
endif
 if(crackFlyDistance!=0)then
    if(isPlus == true)then
        call hattrEffect.addCrackFlyDistance(whichUnit,crackFlyDistance,0)
    else
        call hattrEffect.subCrackFlyDistance(whichUnit,crackFlyDistance,0)
    endif
endif
 if(crackFlyHigh!=0)then
    if(isPlus == true)then
        call hattrEffect.addCrackFlyHigh(whichUnit,crackFlyHigh,0)
    else
        call hattrEffect.subCrackFlyHigh(whichUnit,crackFlyHigh,0)
    endif
endif
        set whichUnit = null
    endmethod
	//增加物品属性
	public static method addAttr takes integer item_id,real charges,unit whichUnit,boolean isPlus returns nothing
        local timer t = htime.setTimeout(0,function thistype.addAttrCall)
        call htime.setInteger(t,1,item_id)
        call htime.setReal(t,2,charges)
        call htime.setUnit(t,3,whichUnit)
        call htime.setBoolean(t,4,isPlus)
        set t = null
	endmethod

	//获取物品ID名字
	public static method getNameById takes integer itid returns string
		return GetObjectName(itid)
	endmethod

	//获取物品图标（需要在format时设定路径）
	public static method getIcon takes integer itid returns string
		return LoadStr(hash_item, itid, hk_item_icon)
	endmethod

	//获取物品类型
	public static method getType takes integer itid returns string
		return LoadStr(hash_item, itid, hk_item_type)
	endmethod

	//获取物品ID是否自动使用
	public static method getIsPowerup takes integer itid returns boolean
		return LoadBoolean(hash_item, itid, hk_item_is_powerup)
	endmethod

	//获取物品ID等级
	public static method getLevel takes integer itid returns integer
		return LoadInteger(hash_item, itid, hk_item_level)
	endmethod

	//获取物品ID黄金
	public static method getGold takes integer itid returns integer
		return LoadInteger(hash_item, itid, hk_item_gold)
	endmethod

	//获取物品ID木头
	public static method getLumber takes integer itid returns integer
		return LoadInteger(hash_item, itid, hk_item_lumber)
	endmethod

	//获取物品ID叠加数
	public static method getOverlay takes integer itid returns integer
		return LoadInteger(hash_item, itid, hk_item_overlay)
	endmethod

	//获取物品ID重量
	public static method getWeight takes integer itid returns real
		return LoadReal(hash_item, itid, hk_item_weight)
	endmethod

	//获取物品ID战力
	public static method getCombatEffectiveness takes integer itid returns integer
		return LoadInteger(hash_item, itid, hk_item_combat_effectiveness)
	endmethod

	/*
	 * 创建物品给单位(内部)
	 * itemid 物品ID
	 * charges 使用次数
	 * whichUnit 哪个单位
	 * isMix 设定是否合成（true则触发事件）
	 */
	private static method toUnitPrivate takes integer itemid,integer charges,unit whichUnit,boolean isMix returns nothing
        local trigger tg = null
		local integer remainCharges = charges
		local integer i = 0
		local integer itCharges = 0
		local integer overlay = getOverlay(itemid)
		local real weight = 0
		local integer canGetQty = 0
		local integer notGetQty = 0
		if(charges<1)then
			set charges = 1
		endif
		//检测物品类型,是否瞬逝型
        // or 判断物品是否自动使用，自动使用的物品不会检测叠加和合成，而是直接执行属性分析
		if(getType(itemid)==HITEM_TYPE_MOMENT or getIsPowerup(itemid) == true)then
			set tg = LoadTriggerHandle(hash_item,itemid,hk_item_onmoment_trigger)
			if(tg!=null)then
				call hevt.setTriggerUnit(tg,whichUnit)
				call hevt.setValue(tg,charges)
				call TriggerExecute(tg)
                set tg = null
			endif
			return
		endif
		//检测重量,没空间就丢在地上
		if(getWeight(itemid)>0)then
			set canGetQty = R2I((hattr.getWeight(whichUnit) - hattr.getWeightCurrent(whichUnit)) / getWeight(itemid)) //算出以剩下的背包空间还能放多少件
			if(canGetQty>charges)then
				set canGetQty = charges
			endif
			set notGetQty = charges - canGetQty
			//拿到的计算中来那个
			if(canGetQty>0)then
				set weight = hattr.getWeightCurrent(whichUnit) + getWeight(itemid) * I2R(canGetQty) //计算出最终重量
				call hattr.setWeightCurrent(whichUnit,weight,0)
			endif
			//拿不到的扔在地上
			if(notGetQty>0)then
				set hjass_global_item = CreateItem(itemid, GetUnitX(whichUnit),GetUnitY(whichUnit))
				call SetItemCharges(hjass_global_item,notGetQty)
				call hmsg.style(hmsg.ttg2Unit(whichUnit,"背包负重不足",6.00,"ffff80",0,2.50,50.00) ,"scale",0,0.05)
				//如果一件都拿不到，后面不执行
				if(notGetQty>=charges)then
					return
				endif
			endif
		endif
		//执行叠加
		set i = 5
        loop
            exitwhen i < 0
            set hjass_global_item = UnitItemInSlot(whichUnit,i)
            if ( hjass_global_item!=null and itemid == GetItemTypeId(hjass_global_item)) then
                //如果第i格物品和获得的一致
                //如果有极限值 并且原有的物品未达上限
                if(overlay>0 and GetItemCharges(hjass_global_item) != overlay) then
                    if((remainCharges+GetItemCharges(hjass_global_item))<= overlay) then
                        //条件：如果新物品加旧物品使用次数不大于极限值
                        //使旧物品使用次数增加，新物品数量清0
						call addAttr(itemid,remainCharges,whichUnit,true)
                        call SetItemCharges(hjass_global_item,GetItemCharges(hjass_global_item)+remainCharges) 
                        set remainCharges = 0
                    else
                        //否则，如果使用次数大于极限值,旧物品次数满载，新物品数量减少
						call addAttr(itemid,overlay-GetItemCharges(hjass_global_item),whichUnit,true)
                        set remainCharges = GetItemCharges(hjass_global_item)+remainCharges-overlay
						call SetItemCharges(hjass_global_item,overlay)
                    endif
                    call DoNothing() YDNL exitwhen true//(  )
                endif
            endif
            set i = i - 1
        endloop
		//执行合成
		set remainCharges = hitemMix.execByItem(itemid,remainCharges,whichUnit)
		//end处理
		if(remainCharges>0)then
			//建在地上
			set hjass_global_item = CreateItem(itemid, GetUnitX(whichUnit),GetUnitY(whichUnit))
			call SetItemCharges(hjass_global_item,remainCharges)
			if(isMix == true)then
				call hmsg.echoTo(GetOwningPlayer(whichUnit),"成功合成了：["+GetItemName(hjass_global_item)+"]",0)
				//@触发 合成物品 事件
				set hevtBean = hEvtBean.create()
				set hevtBean.triggerKey = "itemMix"
				set hevtBean.triggerUnit = whichUnit
				set hevtBean.triggerItem = hjass_global_item
				call hevt.triggerEvent(hevtBean)
				call hevtBean.destroy()
			endif
			if(getEmptySlot(whichUnit)>=1)then
				//有格子则扔到单位上，并分析属性
				call setIsHjass(hjass_global_item,true)
				call UnitAddItem(whichUnit,hjass_global_item)
				call addAttr(itemid,remainCharges,whichUnit,true)
				//@触发 获得物品 事件
				set hevtBean = hEvtBean.create()
				set hevtBean.triggerKey = "itemGet"
				set hevtBean.triggerUnit = whichUnit
				set hevtBean.triggerItem = hjass_global_item
				call hevt.triggerEvent(hevtBean)
				call hevtBean.destroy()
			endif
		endif
	endmethod

	/*
	 * 创建非合成物品给单位
	 * itemid 物品ID
	 * charges 使用次数
	 * whichUnit 哪个单位
	 */
	public static method toUnit takes integer itemid,integer charges,unit whichUnit returns nothing
		call toUnitPrivate(itemid,charges,whichUnit,false)
	endmethod

	/*
	 * 创建合成物品给单位（会触发合成事件）
	 * itemid 物品ID
	 * charges 使用次数
	 * whichUnit 哪个单位
	 */
	public static method toUnitMix takes integer itemid,integer charges,unit whichUnit returns nothing
		call toUnitPrivate(itemid,charges,whichUnit,true)
	endmethod

	/*
	 * 创建非合成物品到XY坐标
	 * itemid 物品ID
	 * charges 使用次数
	 * x y 坐标
	 */
	public static method toXY takes integer itemid,integer charges,real x,real y,real during returns nothing
		local real range = 0
        local unit u = null
        local string itype = getType(itemid)
		if(charges<1)then
			set charges = 1
		endif
		if(itype == HITEM_TYPE_MOMENT)then
			set u = hunit.createUnitXY(Player(PLAYER_NEUTRAL_PASSIVE),itemid,x,y)
			call SetUnitUserData(u,charges)
			if(hcamera.model=="zoomin")then
				set range = 50
			else
				set range = 100
			endif
			call hevt.onEnterUnitRange(u,range,function thistype.triggerMoment)
			if(during > 0)then
				call hunit.del(u,during)
			endif
            set u = null
		else
			set hjass_global_item = CreateItem(itemid, x, y)
			call SetItemCharges(hjass_global_item,charges)
			if(during > 0)then
				call hitem.del(hjass_global_item,during)
			endif
            set hjass_global_item = null
		endif
        set u = null
        set itype = null
	endmethod

	/*
	 * 创建非合成物品给单位
	 * itemid 物品ID
	 * charges 使用次数
	 * whichLoc 哪个点
	 */
	public static method toLoc takes integer itemid,integer charges,location whichLoc,real during returns nothing
		call toXY(itemid,charges,GetLocationX(whichLoc),GetLocationY(whichLoc),during)
	endmethod



	//捡起物品(检测)
	private static method itemPickupCheck takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = htime.getUnit(t,2)
		local integer during = htime.getInteger(t,0)
		local integer itid = 0
		local integer charges = 0
		set hjass_global_item = htime.getItem(t,1)
		if(during>200 or hjass_global_item==null or his.death(u) or LoadInteger(hash_item,GetHandleId(u),StringHash("_ITEMPICKUPCHECK_"))!=GetHandleId(hjass_global_item))then
			call htime.delTimer(t)
            set t = null
			set hjass_global_item = null
			set u = null
			return
		endif
		call htime.setInteger(t,0,during+1)
		if(hcamera.model=="zoomin")then
			if(hlogic.getDistanceBetweenXY(GetItemX(hjass_global_item),GetItemY(hjass_global_item),GetUnitX(u),GetUnitY(u))>125)then
				return
			endif
		elseif(hlogic.getDistanceBetweenXY(GetItemX(hjass_global_item),GetItemY(hjass_global_item),GetUnitX(u),GetUnitY(u))>250)then
			return
		endif
		call htime.delTimer(t)
        set t = null
		//先删除物品,在创建
		set itid = GetItemTypeId(hjass_global_item)
		set charges = GetItemCharges(hjass_global_item)
		call del(hjass_global_item,0)
		call toUnit(itid,charges,u)
        set hjass_global_item = null
		set u = null
	endmethod

	//捡起物品
	private static method itemPickupFalse takes nothing returns nothing
		call SaveInteger(hash_item,GetHandleId(GetTriggerUnit()),StringHash("_ITEMPICKUPCHECK_"),0)
	endmethod

	//捡起物品
	private static method itemPickup takes nothing returns nothing
        local unit u = GetTriggerUnit()
		local integer itid = 0
		local integer charges = 0
        local timer t = null
		set hjass_global_item = GetOrderTargetItem()
        set itid = GetItemTypeId(hjass_global_item)
		if(isFormat(itid)!=true)then
            set u = null
			return
		endif
		call SaveInteger(hash_item,GetHandleId(u),StringHash("_ITEMPICKUPCHECK_"),0)
		if(hjass_global_item!=null and GetIssuedOrderId() == OrderId("smart"))then
			set charges = GetItemCharges(hjass_global_item)
			if(hcamera.model=="zoomin")then
				if(hlogic.getDistanceBetweenXY(GetItemX(hjass_global_item),GetItemY(hjass_global_item),GetUnitX(u),GetUnitY(u))>75)then
					call SaveInteger(hash_item,GetHandleId(u),StringHash("_ITEMPICKUPCHECK_"),GetHandleId(hjass_global_item))
					set t = htime.setInterval(0.10,function thistype.itemPickupCheck)
					call htime.setInteger(t,0,0)
					call htime.setItem(t,1,hjass_global_item)
					call htime.setUnit(t,2,u)
                    set t = null
                    set u = null
					return
				endif
			elseif(hlogic.getDistanceBetweenXY(GetItemX(hjass_global_item),GetItemY(hjass_global_item),GetUnitX(u),GetUnitY(u))>150)then
				call SaveInteger(hash_item,GetHandleId(u),StringHash("_ITEMPICKUPCHECK_"),GetHandleId(hjass_global_item))
				set t = htime.setInterval(0.1,function thistype.itemPickupCheck)
				call htime.setInteger(t,0,0)
				call htime.setItem(t,1,hjass_global_item)
				call htime.setUnit(t,2,u)
                set t = null
                set u = null
				return
			endif
			//先删除物品,在创建
			call del(hjass_global_item,0)
			set hjass_global_item = null
			call toUnit(itid,charges,u)
		endif
        set u = null
	endmethod

	//单位获得物品（默认模式）
	//例如商店售卖的物品就是不由 htem.toUnit 得到的，这时要把它纳入到系统中来
	public static method itemPickupDefault takes nothing returns nothing
        local trigger tg = null
        local unit u = GetTriggerUnit()
		local integer itid =0
		local integer charges = 0
		set hjass_global_item = GetManipulatedItem()
		set itid = GetItemTypeId(hjass_global_item)
		set charges = GetItemCharges(hjass_global_item)
        //检测物品类型,是否瞬逝型
        // or 判断物品是否自动使用，自动使用的物品不会检测叠加和合成，而是直接执行属性分析
		if(getType(itid)==HITEM_TYPE_MOMENT or getIsPowerup(itid) == true or GetItemType(hjass_global_item) == ITEM_TYPE_POWERUP)then
			set tg = LoadTriggerHandle(hash_item,itid,hk_item_onmoment_trigger)
			if(tg!=null)then
				call hevt.setTriggerUnit(tg,u)
				call hevt.setValue(tg,charges)
				call TriggerExecute(tg)
                set tg = null
			endif
			return
		endif
		if(isHjass(hjass_global_item) == false)then
			call del(hjass_global_item,0)
			set hjass_global_item = null
			call toUnit(itid,charges,u)
		endif
        set u = null
	endmethod

	//丢弃物品
	private static method itemDrop takes nothing returns nothing
		local real weight = 0
        local unit u = GetTriggerUnit()
		set hjass_global_item = GetManipulatedItem()
		if(hjass_global_item!=null and isFormat(GetItemTypeId(hjass_global_item))==true and IsItemOwned(hjass_global_item) and OrderId2StringBJ(GetUnitCurrentOrder(u))=="dropitem")then
			call addAttr(GetItemTypeId(hjass_global_item),GetItemCharges(hjass_global_item),u,false)
			set weight = hattr.getWeightCurrent(u) - getWeight(GetItemTypeId(hjass_global_item)) * I2R(GetItemCharges(hjass_global_item))
			call hattr.setWeightCurrent(u,weight,0)
			//@触发 丢弃物品 事件
			set hevtBean = hEvtBean.create()
			set hevtBean.triggerKey = "itemDrop"
			set hevtBean.triggerUnit = u
			set hevtBean.triggerItem = hjass_global_item
			call hevt.triggerEvent(hevtBean)
			call hevtBean.destroy()
			call thistype.setIsHjass(hjass_global_item,false)
		endif
        set u = null
	endmethod

	//单位售卖物品给商店
	private static method itemPawn takes nothing returns nothing
		local integer itid = 0
		local integer charges = 0
		local integer gold = 0
		local integer lumber = 0
		local real sellRadio = 0
        local unit u = GetTriggerUnit()
		set hjass_global_item = GetSoldItem()
        set itid = GetItemTypeId(hjass_global_item)
        set charges = GetItemCharges(hjass_global_item)
        set gold = getGold(itid)*charges
        set lumber = getLumber(itid)*charges
        set sellRadio = hplayer.getSellRatio(GetOwningPlayer(u))
		if(hjass_global_item!=null)then
			if(isFormat(GetItemTypeId(hjass_global_item))==true and sellRadio > 0 and (gold>=1 or lumber>=1))then
				call haward.forUnit(u,0,R2I(I2R(gold)*sellRadio*0.01),R2I(I2R(lumber)*sellRadio*0.01))
			endif
			//@触发 售卖物品 事件
			set hevtBean = hEvtBean.create()
			set hevtBean.triggerKey = "itemPawn"
			set hevtBean.triggerUnit = u
			set hevtBean.triggerItem = hjass_global_item
			call hevt.triggerEvent(hevtBean)
			call hevtBean.destroy()
		endif
        set u = null
	endmethod

	//商店卖出物品
	private static method itemSell takes nothing returns nothing
        local player p = null
		local integer itid = 0
		local integer charges = 0
		local integer gold = 0
		local integer lumber = 0
        set hjass_global_item = GetSoldItem()
		if(hjass_global_item!=null)then
            set itid = GetItemTypeId(hjass_global_item)
            set charges = GetItemCharges(hjass_global_item)
            set gold = getGold(itid)*charges
            set lumber = getLumber(itid)*charges
            set p = GetOwningPlayer(GetBuyingUnit())
			if(hplayer.getGold(p) < gold)then
				call del(hjass_global_item,0)
				call hmsg.style(hmsg.ttg2Unit(GetBuyingUnit(),"金币不足",6.00,"ffff80",0,2.50,50.00) ,"scale",0,0.05)
			elseif(hplayer.getLumber(p) < lumber)then
				call del(hjass_global_item,0)
				call hmsg.style(hmsg.ttg2Unit(GetBuyingUnit(),"木材不足",6.00,"14db2b",0,2.50,50.00) ,"scale",0,0.05)
			else
				call hplayer.subGold(p,gold)
				call hplayer.subLumber(p,lumber)
				//@触发 售卖物品 事件
				set hevtBean = hEvtBean.create()
				set hevtBean.triggerKey = "itemSell"
				set hevtBean.triggerUnit = GetSellingUnit()
				set hevtBean.targetUnit = GetBuyingUnit()
				set hevtBean.triggerItem = hjass_global_item
				call hevt.triggerEvent(hevtBean)
				call hevtBean.destroy()
			endif
            set hjass_global_item = null
		endif
        set p = null
	endmethod

	//拆成单品
	private static method itemSeparateSimple takes item itSeparate,unit u returns nothing
		local integer itid = GetItemTypeId(itSeparate)
		local integer charges = GetItemCharges(itSeparate)
		local real x = 0
		local real y = 0
		local real weight = 0
		local integer i = 0
		if(IsItemOwned(itSeparate) == true)then
			set x = GetUnitX(u)
			set y = GetUnitY(u)
			set weight = hattr.getWeightCurrent(u) - getWeight(itid) * I2R(charges)
			call hattr.setWeightCurrent(u,weight,0)
		else
			set x = GetItemX(itSeparate)
			set y = GetItemY(itSeparate)
		endif
		//@触发 拆分物品 事件(多件拆分为单件)
		set hevtBean = hEvtBean.create()
		set hevtBean.triggerKey = "itemSeparate"
		set hevtBean.triggerUnit = u
		set hevtBean.id = itid
		set hevtBean.type = "simple"
		call hevt.triggerEvent(hevtBean)
		call hevtBean.destroy()
		if(IsItemOwned(itSeparate) == true)then
			set weight = hattr.getWeightCurrent(u) - getWeight(itid)*I2R(charges)
			call hattr.setWeightCurrent(u,weight,0)
		endif
		call del(itSeparate,0)
		set i = charges
		loop
			exitwhen i <= 0
				call SetItemCharges(CreateItem(itid,x,y),1)
			set i = i-1
		endloop
		call hmsg.echoTo(GetOwningPlayer(u),"已拆分成 |cffffff80"+I2S(charges)+" 件单品|r",0)
	endmethod

	//合成品拆分
	private static method itemSeparateMulti takes item itSeparate,integer formula,unit u returns nothing
        local string txt = null
		local integer itid = 0
		local integer formulaFlagmentQty = 0
		local integer i = 0
		local real x = 0
		local real y = 0
		local integer formulaNeedType = 0
		local integer formulaNeedQty = 0
		local real weight = 0
		if(formula>0 and itSeparate!=null and u!=null)then
			set itid = GetItemTypeId(itSeparate)
			//@触发 拆分物品 事件(合成拆分)
			set hevtBean = hEvtBean.create()
			set hevtBean.triggerKey = "itemSeparate"
			set hevtBean.triggerUnit = u
			set hevtBean.id = itid
			set hevtBean.type = "mixed"
			call hevt.triggerEvent(hevtBean)
			call hevtBean.destroy()

			if(IsItemOwned(itSeparate) == true)then
				set x = GetUnitX(u)
				set y = GetUnitY(u)
				set weight = hattr.getWeightCurrent(u) - getWeight(itid) * I2R(GetItemCharges(itSeparate))
				call hattr.setWeightCurrent(u,weight,0)
			else
				set x = GetItemX(itSeparate)
				set y = GetItemY(itSeparate)
			endif
			set formulaFlagmentQty = hitemMix.getFormulaFlagmentQty(itid,formula)
			set i = formulaFlagmentQty
			set txt = "已拆分成 "
			loop
				exitwhen i <= 0
					set formulaNeedType = hitemMix.getFormulaFlagmentNeedType(itid,formula,i)
					set formulaNeedQty = hitemMix.getFormulaFlagmentNeedQty(itid,formula,i)
					if(formulaNeedQty>0)then
						set hjass_global_item = CreateItem(formulaNeedType,x,y)
						call SetItemCharges(hjass_global_item,formulaNeedQty)
						if(i == 1)then
							set txt = txt+"|cffffff80 "+GetItemName(hjass_global_item)+"x"+I2S(formulaNeedQty)+" |r"
						else
							set txt = txt+"|cffffff80 "+GetItemName(hjass_global_item)+"x"+I2S(formulaNeedQty)+" |r + "
						endif
					endif
				set i = i-1
			endloop
			if(formulaFlagmentQty == 1)then
				call itemSeparateSimple(hjass_global_item,u)
			endif
			call del(itSeparate,0)
			call hmsg.echoTo(GetOwningPlayer(u),txt,0)
		endif
	endmethod

	//对话框拆分物品
	private static method itemSeparateDialog takes nothing returns nothing
		local unit u = LoadUnitHandle(hash_item,GetHandleId(GetClickedButton()),3)
        call RemoveSavedHandle(hash_item,GetHandleId(GetClickedButton()),1)
        call RemoveSavedInteger(hash_item,GetHandleId(GetClickedButton()),2)
        call RemoveSavedHandle(hash_item,GetHandleId(GetClickedButton()),3)
		call itemSeparateMulti(LoadItemHandle(hash_item,GetHandleId(GetClickedButton()),1),LoadInteger(hash_item,GetHandleId(GetClickedButton()),2),u)
		call DialogClear(GetClickedDialog())
		call DialogDestroy(GetClickedDialog())
		call DisableTrigger(GetTriggeringTrigger())
		call DestroyTrigger(GetTriggeringTrigger())
        set u = null
	endmethod

	//拆分物品
	private static method itemSeparate takes nothing returns nothing
        local trigger tg = null
        local unit u = GetTriggerUnit()
        local item it = GetSpellTargetItem()
        local string txt = null
        local dialog d = null
        local button b = null
		local integer itid = 0
		local integer charges = 0
		local integer formulaQty = 0
		local integer formulaFlagmentQty = 0
		local integer formulaNeedType = 0
		local integer formulaNeedQty = 0
		local integer i = 0
		local integer j = 0
		local real weight = 0
		if(it!=null and GetSpellAbilityId()==ITEM_ABILITY_SEPARATE )then
			if(isFormat(GetItemTypeId(it))!=true)then
				call hmsg.echoTo(GetOwningPlayer(u),"|cffff8080物品不在hJass系统内|r",0)
                set u = null
                set it = null
				return
			endif
			call IssueImmediateOrder(u,"stop")
			set itid = GetItemTypeId(it)
			set charges = GetItemCharges(it)
			if(charges>1)then
				call itemSeparateSimple(it,u)
			elseif(charges==1)then
				set formulaQty = hitemMix.getFormulaQty(itid)
				if(formulaQty == 1)then
					call itemSeparateMulti(it,1,u)
				elseif(formulaQty > 1)then
					set d = DialogCreate()
					call DialogSetMessage(d, "拆分："+GetItemName(it) )
					set j = formulaQty
					loop
						exitwhen j <= 0
							set formulaFlagmentQty = hitemMix.getFormulaFlagmentQty(itid,j)
							set i = formulaFlagmentQty
							set txt = ""
							loop
								exitwhen i <= 0
									set formulaNeedType = hitemMix.getFormulaFlagmentNeedType(itid,j,i)
									set formulaNeedQty = hitemMix.getFormulaFlagmentNeedQty(itid,j,i)
									if(formulaNeedType>=1)then
										if(i == 1)then
											set txt = txt+getNameById(formulaNeedType)+" x"+I2S(formulaNeedQty)
										else
											set txt = txt+getNameById(formulaNeedType)+" x"+I2S(formulaNeedQty)+"+"
										endif
									endif
								set i = i-1
							endloop
							set b = DialogAddButton(d,txt,0)
							call SaveItemHandle(hash_item,GetHandleId(b),1,it)
							call SaveInteger(hash_item,GetHandleId(b),2,j)
							call SaveUnitHandle(hash_item,GetHandleId(b),3,u)
                            set b = null
						set j = j-1
					endloop
					set b = DialogAddButton(d,"取消 ( ESC )",512)
					call SaveItemHandle(hash_item,GetHandleId(b),1,null)
					call SaveInteger(hash_item,GetHandleId(b),2,0)
					call SaveUnitHandle(hash_item,GetHandleId(b),3,null)
                    set b = null
					set tg = CreateTrigger()
					call TriggerAddAction(tg, function thistype.itemSeparateDialog)
					call TriggerRegisterDialogEvent( tg , d )
                    set tg = null
					call DialogDisplay( GetOwningPlayer(u),d, true )
                    set d = null
				else
					call hmsg.echoTo(GetOwningPlayer(u),"|cffff8080已不可拆分|r",0)
				endif
			endif
		endif
		set it = null
        set u = null
        set d = null
        set b = null
        set txt = null
	endmethod

	//单位使用物品
	public static method itemUse takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local item it = GetManipulatedItem()
        local trigger tg = null
		local integer itid = GetItemTypeId(it)
		local integer charges = GetItemCharges(it)
		local string itype = getType(itid)
		if(itype == HITEM_TYPE_FOREVER)then			//永久型物品
			set charges = charges+1
			call SetItemCharges(it,charges)
		elseif(itype == HITEM_TYPE_CONSUME)then		//消耗型物品
			call addAttr(itid,1,u,false)
			if(charges<=0)then
				call del(it,0)
			endif
		elseif(itype == HITEM_TYPE_MOMENT)then		//瞬逝型
		endif
		set tg = LoadTriggerHandle(hash_item,itid,hk_item_onuse_trigger)
		if(tg != null)then
			call hevt.setTriggerUnit(tg,u)
			call hevt.setTriggerItem(tg,it)
			call hevt.setId(tg,itid)
			call TriggerExecute(tg)
			//@触发 使用物品 事件
			set hevtBean = hEvtBean.create()
			set hevtBean.triggerKey = "itemUsed"
			set hevtBean.triggerUnit = u
			set hevtBean.triggerItem = it
			set hevtBean.id = itid
			call hevt.triggerEvent(hevtBean)
			call hevtBean.destroy()
            set tg = null
		endif
	endmethod

	// 复制一个单位的物品给另一个单位
	public static method copy takes unit origin,unit target returns nothing
		local integer i = 0
        local item it = null
		if(origin == null or target == null)then
			return
		endif
        loop
            exitwhen i > 5
            set it = UnitItemInSlot(origin,i)
            if ( it!=null) then
            	call toUnitPrivate(GetItemTypeId(it),GetItemCharges(it),target,false)
            endif
            set it = null
            set i = i + 1
        endloop
	endmethod

	// 令一个单位把物品全部仍在地上
	public static method drop takes unit origin returns nothing
		local integer i = 0
        local item it = null
		if(origin == null)then
			return
		endif
        loop
            exitwhen i > 5
            set it = UnitItemInSlot(origin,i)
            if ( it!=null) then
            	call toXY(GetItemTypeId(it),GetItemCharges(it),GetUnitX(origin),GetUnitY(origin),-1)
				call del(it,0)
            endif
            set it = null
            set i = i + 1
        endloop
	endmethod

	//初始化单位，绑定事件等
	public static method initUnit takes unit whichUnit returns nothing
		if(LoadInteger(hash_item,GetHandleId(whichUnit),HITEM_IS_UNIT_INIT) != 5)then
			call SaveInteger(hash_item,GetHandleId(whichUnit),HITEM_IS_UNIT_INIT,5)
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_PICKUP,whichUnit,EVENT_UNIT_ISSUED_TARGET_ORDER )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_PICKUP_DEFAULT,whichUnit,EVENT_UNIT_PICKUP_ITEM )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_PICKUP_FALSE, whichUnit, EVENT_UNIT_ISSUED_ORDER )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_PICKUP_FALSE, whichUnit, EVENT_UNIT_ISSUED_POINT_ORDER )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_DROP, whichUnit, EVENT_UNIT_DROP_ITEM )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_PAWN, whichUnit, EVENT_UNIT_PAWN_ITEM )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_SELL, whichUnit, EVENT_UNIT_SELL_ITEM )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_SEPARATE, whichUnit, EVENT_UNIT_SPELL_EFFECT )
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_USE, whichUnit, EVENT_UNIT_USE_ITEM )
		endif
	endmethod

	//初始化商店，绑定事件等
	public static method initShop takes unit whichUnit returns nothing
		if(LoadInteger(hash_item,GetHandleId(whichUnit),HITEM_IS_SHOP_INIT) != 5)then
			call SaveInteger(hash_item,GetHandleId(whichUnit),HITEM_IS_SHOP_INIT,5)
			call TriggerRegisterUnitEvent( ITEM_TRIGGER_SELL, whichUnit, EVENT_UNIT_SELL_ITEM )
		endif
	endmethod

	//初始化
	public static method initSet takes nothing returns nothing
		set ITEM_TRIGGER_PICKUP = CreateTrigger()
		set ITEM_TRIGGER_PICKUP_DEFAULT = CreateTrigger()
		set ITEM_TRIGGER_PICKUP_FALSE = CreateTrigger()
		set ITEM_TRIGGER_DROP = CreateTrigger()
		set ITEM_TRIGGER_PAWN = CreateTrigger()
		set ITEM_TRIGGER_SELL = CreateTrigger()
		set ITEM_TRIGGER_SEPARATE = CreateTrigger()
		set ITEM_TRIGGER_USE = CreateTrigger()
		call TriggerAddAction(ITEM_TRIGGER_PICKUP, function thistype.itemPickup)
		call TriggerAddAction(ITEM_TRIGGER_PICKUP_DEFAULT, function thistype.itemPickupDefault)
		call TriggerAddAction(ITEM_TRIGGER_PICKUP_FALSE, function thistype.itemPickupFalse)
		call TriggerAddAction(ITEM_TRIGGER_DROP, function thistype.itemDrop)
		call TriggerAddAction(ITEM_TRIGGER_PAWN, function thistype.itemPawn)
		call TriggerAddAction(ITEM_TRIGGER_SELL, function thistype.itemSell)
		call TriggerAddAction(ITEM_TRIGGER_SEPARATE, function thistype.itemSeparate)
		call TriggerAddAction(ITEM_TRIGGER_USE, function thistype.itemUse)
	endmethod

endstruct
