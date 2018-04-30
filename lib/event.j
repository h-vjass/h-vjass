//事件.j
globals
    hEvt hevt
    hEvtBean hevtBean
    hashtable hash_trigger_register = null
    hashtable hash_trigger = null
    
    trigger event_trigger_attackDetect = null
    trigger event_trigger_attackGetTarget = null
    trigger event_trigger_attackReady = null
    trigger event_trigger_beAttackReady = null
    trigger event_trigger_skillStudy = null
    trigger event_trigger_skillReady = null
    trigger event_trigger_skillStart = null
    trigger event_trigger_skillHappen = null
    trigger event_trigger_skillStop = null
    trigger event_trigger_skillOver = null
    trigger event_trigger_itemUsed = null
    trigger event_trigger_itemSell = null
    trigger event_trigger_itemDrop = null
    trigger event_trigger_itemGet = null
    trigger event_trigger_itemPawn = null
    trigger event_trigger_itemDestroy = null
    trigger event_trigger_levelUp = null
    trigger event_trigger_summon = null
    trigger event_trigger_enterUnitRange = null
    trigger event_trigger_enterRect = null
    trigger event_trigger_leaveRect = null
    trigger event_trigger_chat = null
    trigger event_trigger_chatLike = null
    trigger event_trigger_esc = null
    trigger event_trigger_selection = null
    trigger event_trigger_selectionDouble = null
    trigger event_trigger_selectionTriple = null
    trigger event_trigger_unSelection = null
    trigger event_trigger_upgradeStart = null
    trigger event_trigger_upgradeCancel = null
    trigger event_trigger_upgradeFinish = null
    trigger event_trigger_constructStart = null
    trigger event_trigger_constructCancel = null
    trigger event_trigger_constructFinish = null

endglobals

struct hEvtBean
    public static handle triggerHandle = null
    public static string triggerKey = null
    public static unit triggerUnit = null
    public static unit triggerEnterUnit = null
    public static rect triggerRect = null
    public static item triggerItem = null
    public static player triggerPlayer = null
    public static string triggerString = null
    public static string triggerStringMatched = null
    public static integer triggerSkill = 0
    public static unit sourceUnit = null
    public static unit targetUnit = null
    public static location targetLoc = null
    public static unit attacker = null
    public static unit killer = null
    public static real damage = 0
    public static real realDamage = 0
    public static real range = 0
    public static integer id = 0
    public static real value = 0
    public static real value2 = 0
    public static real value3 = 0
    public static real during = 0
    public static string damageKind = null
    public static string damageType = null
    public static string breakType = null
    public static string type = null
    public static boolean isNoAvoid = false

    static method create takes nothing returns thistype
        local hEvtBean s = 0
        set s = hEvtBean.allocate()
        set s.triggerHandle = null
        set s.triggerKey = null
        set s.triggerUnit = null
        set s.triggerEnterUnit = null
        set s.triggerRect = null
        set s.triggerItem = null
        set s.triggerPlayer = null
        set s.triggerString = null
        set s.triggerStringMatched = null
        set s.triggerSkill = 0
        set s.sourceUnit = null
        set s.targetUnit = null
        set s.targetLoc = null
        set s.attacker = null
        set s.killer = null
        set s.damage = 0
        set s.realDamage = 0
        set s.range = 0
        set s.id = 0
        set s.value = 0
        set s.value2 = 0
        set s.value3 = 0
        set s.during = 0
        set s.damageKind = null
        set s.damageType = null
        set s.breakType = null
        set s.type = null
        set s.isNoAvoid = false
        return s
    endmethod
    method destroy takes nothing returns nothing
        set triggerHandle = null
        set triggerKey = null
        set triggerUnit = null
        set triggerEnterUnit = null
        set triggerRect = null
        set triggerItem = null
        set triggerPlayer = null
        set triggerString = null
        set triggerStringMatched = null
        set triggerSkill = 0
        set sourceUnit = null
        set targetUnit = null
        set targetLoc = null
        set attacker = null
        set killer = null
        set damage = 0
        set realDamage = 0
        set range = 0
        set id = 0
        set value = 0
        set value2 = 0
        set value3 = 0
        set during = 0
        set damageKind = null
        set damageType = null
        set breakType = null
        set type = null
        set isNoAvoid = false
    endmethod
endstruct

struct hEvt

    private static integer trigger_limit = 9999

    public static integer hashkey_onAttackDetect_inc = 5001
    public static integer hashkey_onAttackGetTarget_inc = 5002
    public static integer hashkey_onAttackReady_inc = 5003
    public static integer hashkey_onBeAttackReady_inc = 5004
    public static integer hashkey_onSkillStudy_inc = 5005
    public static integer hashkey_onSkillReady_inc = 5006
    public static integer hashkey_onSkillStart_inc = 5007
    public static integer hashkey_onSkillHappen_inc = 5008
    public static integer hashkey_onSkillStop_inc = 5009
    public static integer hashkey_onSkillOver_inc = 5010
    public static integer hashkey_onItemUsed_inc = 5011
    public static integer hashkey_onItemSell_inc = 5012
    public static integer hashkey_onItemDrop_inc = 5013
    public static integer hashkey_onItemGet_inc = 5014
    public static integer hashkey_onItemPawn_inc = 5015
    public static integer hashkey_onItemDestroy_inc = 5016
    public static integer hashkey_onItemMix_inc = 5017
    public static integer hashkey_onItemSeparate_inc = 5018
    public static integer hashkey_onDamage_inc = 5019
    public static integer hashkey_onBeDamage_inc = 5020
    public static integer hashkey_onDamageEffect_inc = 5021
    public static integer hashkey_onBeDamageEffect_inc = 5022
    public static integer hashkey_onAvoid_inc = 5023
    public static integer hashkey_onBeAvoid_inc = 5024
    public static integer hashkey_onBreakDefend_inc = 5025
    public static integer hashkey_onBeBreakDefend_inc = 5026
    public static integer hashkey_onBreakResistance_inc = 5027
    public static integer hashkey_onBeBreakResistance_inc = 5028
    public static integer hashkey_onBreakDefendAndResistance_inc = 5029
    public static integer hashkey_onBeBreakDefendAndResistance_inc = 5030
    public static integer hashkey_onSwim_inc = 5031
    public static integer hashkey_onBeSwim_inc = 5032
    public static integer hashkey_onRebound_inc = 5033
    public static integer hashkey_onNoAvoid_inc = 5034
    public static integer hashkey_onBeNoAvoid_inc = 5035
    public static integer hashkey_onKnocking_inc = 5036
    public static integer hashkey_onBeKnocking_inc = 5037
    public static integer hashkey_onViolence_inc = 5038
    public static integer hashkey_onBeViolence_inc = 5039
    public static integer hashkey_onSpilt_inc = 5040
    public static integer hashkey_onBeSpilt_inc = 5041
    public static integer hashkey_onHemophagia_inc = 5042
    public static integer hashkey_onBeHemophagia_inc = 5043
    public static integer hashkey_onSkillHemophagia_inc = 5044
    public static integer hashkey_onBeSkillHemophagia_inc = 5045
    public static integer hashkey_onPunish_inc = 5046
    public static integer hashkey_onDead_inc = 5047
    public static integer hashkey_onKill_inc = 5048
    public static integer hashkey_onReborn_inc = 5049
    public static integer hashkey_onLevelUp_inc = 5050
    public static integer hashkey_onSummon_inc = 5051
    public static integer hashkey_onEnterUnitRange_inc = 5052
    public static integer hashkey_onEnterRect_inc = 5053
    public static integer hashkey_onLeaveRect_inc = 5054
    public static integer hashkey_onChat_inc = 5055
    public static integer hashkey_onChatLike_inc = 5056
    public static integer hashkey_onEsc_inc = 5057
    public static integer hashkey_onSelection_inc = 5058
    public static integer hashkey_onSelectionDouble_inc = 5059
    public static integer hashkey_onSelectionTriple_inc = 5060
    public static integer hashkey_onUnSelection_inc = 5061
    public static integer hashkey_onUpgradeStart_inc = 5062
    public static integer hashkey_onUpgradeCancel_inc = 5063
    public static integer hashkey_onUpgradeFinish_inc = 5064
    public static integer hashkey_onConstructStart_inc = 5065
    public static integer hashkey_onConstructCancel_inc = 5066
    public static integer hashkey_onConstructFinish_inc = 5067

    private static integer hashkey_trigger_onAttackDetect = 10000
    private static integer hashkey_trigger_onAttackGetTarget = 20000
    private static integer hashkey_trigger_onAttackReady = 30000
    private static integer hashkey_trigger_onBeAttackReady = 40000
    private static integer hashkey_trigger_onSkillStudy = 50000
    private static integer hashkey_trigger_onSkillReady = 60000
    private static integer hashkey_trigger_onSkillStart = 70000
    private static integer hashkey_trigger_onSkillHappen = 80000
    private static integer hashkey_trigger_onSkillStop = 90000
    private static integer hashkey_trigger_onSkillOver = 100000
    private static integer hashkey_trigger_onItemUsed = 110000
    private static integer hashkey_trigger_onItemSell = 120000
    private static integer hashkey_trigger_onItemDrop = 130000
    private static integer hashkey_trigger_onItemGet = 140000
    private static integer hashkey_trigger_onItemPawn = 150000
    private static integer hashkey_trigger_onItemDestroy = 160000
    private static integer hashkey_trigger_onItemMix = 170000
    private static integer hashkey_trigger_onItemSeparate = 180000
    private static integer hashkey_trigger_onDamage = 190000
    private static integer hashkey_trigger_onBeDamage = 200000
    private static integer hashkey_trigger_onDamageEffect = 210000
    private static integer hashkey_trigger_onBeDamageEffect = 220000
    private static integer hashkey_trigger_onAvoid = 230000
    private static integer hashkey_trigger_onBeAvoid = 240000
    private static integer hashkey_trigger_onBreakDefend = 250000
    private static integer hashkey_trigger_onBeBreakDefend = 260000
    private static integer hashkey_trigger_onBreakResistance = 270000
    private static integer hashkey_trigger_onBeBreakResistance = 280000
    private static integer hashkey_trigger_onBreakDefendAndResistance = 290000
    private static integer hashkey_trigger_onBeBreakDefendAndResistance = 300000
    private static integer hashkey_trigger_onSwim = 310000
    private static integer hashkey_trigger_onBeSwim = 320000
    private static integer hashkey_trigger_onRebound = 330000
    private static integer hashkey_trigger_onNoAvoid = 340000
    private static integer hashkey_trigger_onBeNoAvoid = 350000
    private static integer hashkey_trigger_onKnocking = 360000
    private static integer hashkey_trigger_onBeKnocking = 370000
    private static integer hashkey_trigger_onViolence = 380000
    private static integer hashkey_trigger_onBeViolence = 390000
    private static integer hashkey_trigger_onSpilt = 400000
    private static integer hashkey_trigger_onBeSpilt = 410000
    private static integer hashkey_trigger_onHemophagia = 420000
    private static integer hashkey_trigger_onBeHemophagia = 430000
    private static integer hashkey_trigger_onSkillHemophagia = 440000
    private static integer hashkey_trigger_onBeSkillHemophagia = 450000
    private static integer hashkey_trigger_onPunish = 460000
    private static integer hashkey_trigger_onDead = 470000
    private static integer hashkey_trigger_onKill = 480000
    private static integer hashkey_trigger_onReborn = 490000
    private static integer hashkey_trigger_onLevelUp = 500000
    private static integer hashkey_trigger_onSummon = 510000
    private static integer hashkey_trigger_onEnterUnitRange = 520000
    private static integer hashkey_trigger_onEnterRect = 530000
    private static integer hashkey_trigger_onLeaveRect = 540000
    private static integer hashkey_trigger_onChat = 550000
    private static integer hashkey_trigger_onChatLike = 560000
    private static integer hashkey_trigger_onEsc = 570000
    private static integer hashkey_trigger_onSelection = 580000
    private static integer hashkey_trigger_onSelectionDouble = 590000
    private static integer hashkey_trigger_onSelectionTriple = 600000
    private static integer hashkey_trigger_onUnSelection = 610000
    private static integer hashkey_trigger_onUpgradeStart = 620000
    private static integer hashkey_trigger_onUpgradeCancel = 630000
    private static integer hashkey_trigger_onUpgradeFinish = 640000
    private static integer hashkey_trigger_onConstructStart = 650000
    private static integer hashkey_trigger_onConstructCancel = 660000
    private static integer hashkey_trigger_onConstructFinish = 670000

    private static integer hashkey_type_TriggerHandle = 1
    private static integer hashkey_type_TriggerUnit = 2
    private static integer hashkey_type_TriggerEnterUnit = 3
    private static integer hashkey_type_TriggerRect = 4
    private static integer hashkey_type_TriggerItem = 5
    private static integer hashkey_type_TriggerPlayer = 6
    private static integer hashkey_type_TriggerString = 7
    private static integer hashkey_type_TriggerStringMatched = 8
    private static integer hashkey_type_TriggerSkill = 9
    private static integer hashkey_type_SourceUnit = 10
    private static integer hashkey_type_TargetUnit = 11
    private static integer hashkey_type_TargetLoc = 12
    private static integer hashkey_type_Attacker = 13
    private static integer hashkey_type_Killer = 14
    private static integer hashkey_type_Damage = 15
    private static integer hashkey_type_RealDamage = 16
    private static integer hashkey_type_Id = 17
    private static integer hashkey_type_Range = 18
    private static integer hashkey_type_Value = 19
    private static integer hashkey_type_Value2 = 20
    private static integer hashkey_type_Value3 = 21
    private static integer hashkey_type_During = 22
    private static integer hashkey_type_DamageKind = 23
    private static integer hashkey_type_DamageType = 24
    private static integer hashkey_type_BreakType = 25
    private static integer hashkey_type_Type = 26
    private static integer hashkey_type_IsNoAvoid = 27

    private static integer hashkey_last_damage = 99980211
    private static integer hashkey_unit_range = 10000
    private static integer hashkey_rect_enter = 20003
    private static integer hashkey_rect_leave = 21003
    private static integer hashkey_esc = 22003
    private static integer hashkey_selection = 23003
    private static integer hashkey_selection_timer = 23103

    private static method getTriggerKeyByString takes string str returns integer
        local integer inc = -1
        //! textmacro getTriggerKeyByStringInc takes N1,N2
        if(str=="$N1$")then
            set inc = hashkey_on$N2$_inc
        endif
        //! endtextmacro

        //! runtextmacro getTriggerKeyByStringInc("attackDetect","AttackDetect")
        //! runtextmacro getTriggerKeyByStringInc("attackGetTarget","AttackGetTarget")
        //! runtextmacro getTriggerKeyByStringInc("attackReady","AttackReady")
        //! runtextmacro getTriggerKeyByStringInc("beAttackReady","BeAttackReady")
        //! runtextmacro getTriggerKeyByStringInc("skillStudy","SkillStudy")
        //! runtextmacro getTriggerKeyByStringInc("skillReady","SkillReady")
        //! runtextmacro getTriggerKeyByStringInc("skillStart","SkillStart")
        //! runtextmacro getTriggerKeyByStringInc("skillHappen","SkillHappen")
        //! runtextmacro getTriggerKeyByStringInc("skillStop","SkillStop")
        //! runtextmacro getTriggerKeyByStringInc("skillOver","SkillOver")
        //! runtextmacro getTriggerKeyByStringInc("itemUsed","ItemUsed")
        //! runtextmacro getTriggerKeyByStringInc("itemSell","ItemSell")
        //! runtextmacro getTriggerKeyByStringInc("itemDrop","ItemDrop")
        //! runtextmacro getTriggerKeyByStringInc("itemGet","ItemGet")
        //! runtextmacro getTriggerKeyByStringInc("itemPawn","ItemPawn")
        //! runtextmacro getTriggerKeyByStringInc("itemDestroy","ItemDestroy")
        //! runtextmacro getTriggerKeyByStringInc("itemMix","ItemMix")
        //! runtextmacro getTriggerKeyByStringInc("itemSeparate","ItemSeparate")
        //! runtextmacro getTriggerKeyByStringInc("damage","Damage")
        //! runtextmacro getTriggerKeyByStringInc("beDamage","BeDamage")
        //! runtextmacro getTriggerKeyByStringInc("damageEffect","DamageEffect")
        //! runtextmacro getTriggerKeyByStringInc("beDamageEffect","BeDamageEffect")
        //! runtextmacro getTriggerKeyByStringInc("avoid","Avoid")
        //! runtextmacro getTriggerKeyByStringInc("beAvoid","BeAvoid")
        //! runtextmacro getTriggerKeyByStringInc("breakDefend","BreakDefend")
        //! runtextmacro getTriggerKeyByStringInc("beBreakDefend","BeBreakDefend")
        //! runtextmacro getTriggerKeyByStringInc("breakResistance","BreakResistance")
        //! runtextmacro getTriggerKeyByStringInc("beBreakResistance","BeBreakResistance")
        //! runtextmacro getTriggerKeyByStringInc("breakDefendAndResistance","BreakDefendAndResistance")
        //! runtextmacro getTriggerKeyByStringInc("beBreakDefendAndResistance","BeBreakDefendAndResistance")
        //! runtextmacro getTriggerKeyByStringInc("swim","Swim")
        //! runtextmacro getTriggerKeyByStringInc("beSwim","BeSwim")
        //! runtextmacro getTriggerKeyByStringInc("rebound","Rebound")
        //! runtextmacro getTriggerKeyByStringInc("noAvoid","NoAvoid")
        //! runtextmacro getTriggerKeyByStringInc("beNoAvoid","BeNoAvoid")
        //! runtextmacro getTriggerKeyByStringInc("knocking","Knocking")
        //! runtextmacro getTriggerKeyByStringInc("beKnocking","BeKnocking")
        //! runtextmacro getTriggerKeyByStringInc("violence","Violence")
        //! runtextmacro getTriggerKeyByStringInc("beViolence","BeViolence")
        //! runtextmacro getTriggerKeyByStringInc("spilt","Spilt")
        //! runtextmacro getTriggerKeyByStringInc("beSpilt","BeSpilt")
        //! runtextmacro getTriggerKeyByStringInc("hemophagia","Hemophagia")
        //! runtextmacro getTriggerKeyByStringInc("beHemophagia","BeHemophagia")
        //! runtextmacro getTriggerKeyByStringInc("skillHemophagia","SkillHemophagia")
        //! runtextmacro getTriggerKeyByStringInc("beSkillHemophagia","BeSkillHemophagia")
        //! runtextmacro getTriggerKeyByStringInc("punish","Punish")
        //! runtextmacro getTriggerKeyByStringInc("dead","Dead")
        //! runtextmacro getTriggerKeyByStringInc("kill","Kill")
        //! runtextmacro getTriggerKeyByStringInc("reborn","Reborn")
        //! runtextmacro getTriggerKeyByStringInc("levelUp","LevelUp")
        //! runtextmacro getTriggerKeyByStringInc("summon","Summon")
        //! runtextmacro getTriggerKeyByStringInc("enterUnitRange","EnterUnitRange")
        //! runtextmacro getTriggerKeyByStringInc("enterRect","EnterRect")
        //! runtextmacro getTriggerKeyByStringInc("leaveRect","LeaveRect")
        //! runtextmacro getTriggerKeyByStringInc("chat","Chat")
        //! runtextmacro getTriggerKeyByStringInc("chatLike","ChatLike")
        //! runtextmacro getTriggerKeyByStringInc("esc","Esc")
        //! runtextmacro getTriggerKeyByStringInc("selection","Selection")
        //! runtextmacro getTriggerKeyByStringInc("selectionDouble","SelectionDouble")
        //! runtextmacro getTriggerKeyByStringInc("selectionTriple","SelectionTriple")
        //! runtextmacro getTriggerKeyByStringInc("unSelection","UnSelection")
        //! runtextmacro getTriggerKeyByStringInc("upgradeStart","UpgradeStart")
        //! runtextmacro getTriggerKeyByStringInc("upgradeCancel","UpgradeCancel")
        //! runtextmacro getTriggerKeyByStringInc("upgradeFinish","UpgradeFinish")
        //! runtextmacro getTriggerKeyByStringInc("constructStart","ConstructStart")
        //! runtextmacro getTriggerKeyByStringInc("constructCancel","ConstructCancel")
        //! runtextmacro getTriggerKeyByStringInc("constructFinish","ConstructFinish")
        return inc
    endmethod

    //检查该handle是否绑定过单位事件
    private static method isHandleRegister takes handle which,integer k returns integer
        if(which==null)then
            return 0
        endif
        return LoadInteger(hash_trigger_register, GetHandleId(which), k )
    endmethod
    //获取handle事件触发
    private static method getHandleTrigger takes handle which,integer k,integer inc returns trigger
        return LoadTriggerHandle(hash_trigger, GetHandleId(which), k+inc )
    endmethod

    //触发计数器
    private static method addInc takes integer hid,integer k returns integer
        local integer inc = LoadInteger(hash_trigger_register, hid, k)
        if(inc >= 1)then
            set inc = inc+1
        else
            set inc = 1
        endif
        if(inc >= trigger_limit)then
            call hconsole.error("break<"+I2S(k)+">trigger_limit:"+I2S(trigger_limit))
            return -1
        endif
        call SaveInteger(hash_trigger_register, hid, k,inc )
        return inc
    endmethod

    //set最后一位伤害的单位
    public static method setLastDamageUnit takes unit which,unit last returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(which), hashkey_last_damage , last )
    endmethod
    //get最后一位伤害的单位
    public static method getLastDamageUnit takes unit which returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(which), hashkey_last_damage )
    endmethod

    //-- TODO SET GET DATA --
    //设置 triggerUnit 单位
    private static method setTriggerUnit takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerUnit , which )
    endmethod
    //设置 triggerEnterUnit 单位
    private static method setTriggerEnterUnit takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerEnterUnit , which )
    endmethod
    //设置 triggerRect 区域
    private static method setTriggerRect takes trigger tgr,rect which returns nothing
        call SaveRectHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerRect , which )
    endmethod
    //设置 triggerItem 物品
    private static method setTriggerItem takes trigger tgr,item which returns nothing
        call SaveItemHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerItem , which )
    endmethod
    //设置 triggerPlayer 玩家
    private static method setTriggerPlayer takes trigger tgr,player which returns nothing
        call SavePlayerHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerPlayer , which )
    endmethod
    //设置 triggerString 字符串
    private static method setTriggerString takes trigger tgr,string which returns nothing
        call SaveStr(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerString , which )
    endmethod
    //设置 triggerStringMatched 字符串
    private static method setTriggerStringMatched takes trigger tgr,string which returns nothing
        call SaveStr(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerStringMatched , which )
    endmethod
    //设置 triggerSkill 整型
    private static method setTriggerSkill takes trigger tgr,integer which returns nothing
        call SaveInteger(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerSkill , which )
    endmethod
    //设置 sourceUnit 单位
    private static method setSourceUnit takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_SourceUnit , which )
    endmethod
    //设置 targetUnit 单位
    private static method setTargetUnit takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TargetUnit , which )
    endmethod
    //设置 targetLoc 点
    private static method setTargetLoc takes trigger tgr,location which returns nothing
        call SaveLocationHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TargetLoc , which )
    endmethod
    //设置 attacker 单位
    private static method setAttacker takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_Attacker , which )
    endmethod
    //设置 killer 单位
    private static method setKiller takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_Killer , which )
    endmethod
    //设置 damage 实数
    private static method setDamage takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_Damage , which )
    endmethod
    //设置 realDamage 实数
    private static method setRealDamage takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_RealDamage , which )
    endmethod
    //设置 id 整型
    private static method setId takes trigger tgr,integer which returns nothing
        call SaveInteger(hash_trigger, GetHandleId(tgr), hashkey_type_Id , which )
    endmethod
    //设置 range 实数
    private static method setRange takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_Range , which )
    endmethod
    //设置 value 实数
    private static method setValue takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_Value , which )
    endmethod
    //设置 value2 实数
    private static method setValue2 takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_Value2 , which )
    endmethod
    //设置 value3 实数
    private static method setValue3 takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_Value3 , which )
    endmethod
    //设置 during 实数
    private static method setDuring takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_During , which )
    endmethod
    //设置 damageKind 字符串
    private static method setDamageKind takes trigger tgr,string which returns nothing
        call SaveStr(hash_trigger, GetHandleId(tgr), hashkey_type_DamageKind , which )
    endmethod
    //设置 damageType 字符串
    private static method setDamageType takes trigger tgr,string which returns nothing
        call SaveStr(hash_trigger, GetHandleId(tgr), hashkey_type_DamageType , which )
    endmethod
    //设置 breakType 字符串
    private static method setBreakType takes trigger tgr,string which returns nothing
        call SaveStr(hash_trigger, GetHandleId(tgr), hashkey_type_BreakType , which )
    endmethod
    //设置 type 字符串
    private static method setType takes trigger tgr,string which returns nothing
        call SaveStr(hash_trigger, GetHandleId(tgr), hashkey_type_Type , which )
    endmethod
    //设置 isNoAvoid 布尔值
    private static method setIsNoAvoid takes trigger tgr,boolean which returns nothing
        call SaveBoolean(hash_trigger, GetHandleId(tgr), hashkey_type_IsNoAvoid , which )
    endmethod

    //获取 triggerUnit 单位
    public static method getTriggerUnit takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerUnit )
    endmethod
    //获取 triggerEnterUnit 单位
    public static method getTriggerEnterUnit takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerEnterUnit )
    endmethod
    //获取 triggerRect 区域
    public static method getTriggerRect takes nothing returns rect
        return LoadRectHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerRect )
    endmethod
    //获取 triggerItem 物品
    public static method getTriggerItem takes nothing returns item
        return LoadItemHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerItem )
    endmethod
    //获取 triggerPlayer 玩家
    public static method getTriggerPlayer takes nothing returns player
        return LoadPlayerHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerPlayer )
    endmethod
    //获取 triggerString 字符串
    public static method getTriggerString takes nothing returns string
        return LoadStr(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerString )
    endmethod
    //获取 triggerStringMatched 字符串
    public static method getTriggerStringMatched takes nothing returns string
        return LoadStr(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerStringMatched )
    endmethod
    //获取 triggerSkill 整型
    public static method getTriggerSkill takes nothing returns integer
        return LoadInteger(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerSkill )
    endmethod
    //获取 sourceUnit 单位
    public static method getSourceUnit takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_SourceUnit )
    endmethod
    //获取 targetUnit 单位
    public static method getTargetUnit takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TargetUnit )
    endmethod
    //获取 targetLoc 点
    public static method getTargetLoc takes nothing returns location
        return LoadLocationHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TargetLoc )
    endmethod
    //获取 attacker 单位
    public static method getAttacker takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Attacker )
    endmethod
    //获取 killer 单位
    public static method getKiller takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Killer )
    endmethod
    //获取 damage 实数
    public static method getDamage takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Damage )
    endmethod
    //获取 realDamage 实数
    public static method getRealDamage takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_RealDamage )
    endmethod
    //获取 id 整型
    public static method getId takes nothing returns integer
        return LoadInteger(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Id )
    endmethod
    //获取 range 实数
    public static method getRange takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Range )
    endmethod
    //获取 value 实数
    public static method getValue takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Value )
    endmethod
    //获取 value2 实数
    public static method getValue2 takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Value2 )
    endmethod
    //获取 value3 实数
    public static method getValue3 takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Value3 )
    endmethod
    //获取 during 实数
    public static method getDuring takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_During )
    endmethod
    //获取 damageKind 字符串
    public static method getDamageKind takes nothing returns string
        return LoadStr(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_DamageKind )
    endmethod
    //获取 damageType 字符串
    public static method getDamageType takes nothing returns string
        return LoadStr(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_DamageType )
    endmethod
    //获取 breakType 字符串
    public static method getBreakType takes nothing returns string
        return LoadStr(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_BreakType )
    endmethod
    //获取 type 字符串
    public static method getType takes nothing returns string
        return LoadStr(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Type )
    endmethod
    //获取 isNoAvoid 布尔值
    public static method getIsNoAvoid takes nothing returns boolean
        return LoadBoolean(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_IsNoAvoid )
    endmethod











    //------内部开放的方法------

    //triggerByHandle
    public static method triggerEvent takes hEvtBean bean returns nothing
        local integer k = getTriggerKeyByString(hEvtBean.triggerKey)
        local trigger tempTgr = null
        local integer i = 0
        if(bean.triggerHandle==null and bean.triggerPlayer!=null)then
            set bean.triggerHandle = bean.triggerPlayer
        endif
        if(bean.triggerHandle==null and bean.triggerRect!=null)then
            set bean.triggerHandle = bean.triggerRect
        endif
        if(bean.triggerHandle==null and bean.triggerItem!=null)then
            set bean.triggerHandle = bean.triggerItem
        endif
        if(bean.triggerHandle==null and bean.triggerEnterUnit!=null)then
            set bean.triggerHandle = bean.triggerEnterUnit
        endif
        if(bean.triggerHandle==null and bean.triggerUnit!=null)then
            set bean.triggerHandle = bean.triggerUnit
        endif
        if(bean.triggerHandle!=null)then
            set i = isHandleRegister(bean.triggerHandle,k)
            loop
                exitwhen i==0
                set tempTgr = getHandleTrigger(bean.triggerHandle,k,i)
                if(bean.triggerUnit!=null)then
                    call setTriggerUnit(tempTgr,bean.triggerUnit)
                endif
                if(bean.triggerEnterUnit!=null)then
                    call setTriggerEnterUnit(tempTgr,bean.triggerEnterUnit)
                endif
                if(bean.triggerRect!=null)then
                    call setTriggerRect(tempTgr,bean.triggerRect)
                endif
                if(bean.triggerItem!=null)then
                    call setTriggerItem(tempTgr,bean.triggerItem)
                endif
                if(bean.triggerPlayer!=null)then
                    call setTriggerPlayer(tempTgr,bean.triggerPlayer)
                endif
                if(bean.triggerString!=null)then
                    call setTriggerString(tempTgr,bean.triggerString)
                endif
                if(bean.triggerStringMatched!=null)then
                    call setTriggerStringMatched(tempTgr,bean.triggerStringMatched)
                endif
                if(bean.triggerSkill!=null)then
                    call setTriggerSkill(tempTgr,bean.triggerSkill)
                endif
                if(bean.sourceUnit!=null)then
                    call setSourceUnit(tempTgr,bean.sourceUnit)
                endif
                if(bean.targetUnit!=null)then
                    call setTargetUnit(tempTgr,bean.targetUnit)
                endif
                if(bean.targetLoc!=null)then
                    call setTargetLoc(tempTgr,bean.targetLoc)
                endif
                if(bean.attacker!=null)then
                    call setAttacker(tempTgr,bean.attacker)
                endif
                if(bean.killer!=null)then
                    call setKiller(tempTgr,bean.killer)
                endif
                if(bean.damage!=0)then
                    call setDamage(tempTgr,bean.damage)
                endif
                if(bean.realDamage!=0)then
                    call setRealDamage(tempTgr,bean.realDamage)
                endif
                if(bean.id!=null)then
                    call setId(tempTgr,bean.id)
                endif
                if(bean.range!=0)then
                    call setRange(tempTgr,bean.range)
                endif
                if(bean.value!=0)then
                    call setValue(tempTgr,bean.value)
                endif
                if(bean.value2!=0)then
                    call setValue2(tempTgr,bean.value2)
                endif
                if(bean.value3!=0)then
                    call setValue3(tempTgr,bean.value3)
                endif
                if(bean.during!=0)then
                    call setDuring(tempTgr,bean.during)
                endif
                if(bean.damageKind!=null)then
                    call setDamageKind(tempTgr,bean.damageKind)
                endif
                if(bean.damageType!=null)then
                    call setDamageType(tempTgr,bean.damageType)
                endif
                if(bean.breakType!=null)then
                    call setBreakType(tempTgr,bean.breakType)
                endif
                if(bean.type!=null)then
                    call setType(tempTgr,bean.type)
                endif
                if(bean.isNoAvoid!=false)then
                    call setIsNoAvoid(tempTgr,bean.isNoAvoid)
                endif
                call TriggerExecute(tempTgr)
                set tempTgr = null
                set i=i-1
            endloop
        endif
    endmethod

    //------on事件------

    //on - 通用法
    private static method onEventByHandle takes string evt,handle whichHandle,code action returns trigger
        local integer k = 0
        local integer hid = 0
        local integer inc = 0
        local trigger tg = null
        if(StringLength(evt)<1)then
            return null
        endif
        if(whichHandle == null)then
            return null
        endif
        if(action == null)then
            return null
        endif
        set k = getTriggerKeyByString(evt)
        set hid = GetHandleId(whichHandle)
        set inc = addInc( hid, k )
        if(inc==-1)then
            return tg
        endif
        set tg = CreateTrigger()
        call TriggerAddAction(tg,action)
        call SaveTriggerHandle(hash_trigger, hid, k+inc , tg )
        return tg
    endmethod

    //on - 注意到攻击目标
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取被注意/目标单位
    private static method onAttackDetectAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "attackDetect"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.targetUnit = GetEventTargetUnit()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onAttackDetect takes unit whichUnit,code action returns trigger
        if(event_trigger_attackDetect==null)then
            set event_trigger_attackDetect = CreateTrigger()
            call TriggerAddAction(event_trigger_attackReady, function thistype.onAttackDetectAction)
        endif
        call TriggerRegisterUnitEvent( event_trigger_attackDetect, whichUnit, EVENT_UNIT_ACQUIRED_TARGET )
        return onEventByHandle("attackDetect",whichUnit,action)
    endmethod

    //on - 获取攻击目标
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取被获取/目标单位
    private static method onAttackGetTargetAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "attackGetTarget"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.targetUnit = GetEventTargetUnit()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onAttackGetTarget takes unit whichUnit,code action returns trigger
        if(event_trigger_attackGetTarget==null)then
            set event_trigger_attackGetTarget = CreateTrigger()
            call TriggerAddAction(event_trigger_attackGetTarget, function thistype.onAttackGetTargetAction)
        endif
        call TriggerRegisterUnitEvent( event_trigger_attackGetTarget, whichUnit, EVENT_UNIT_TARGET_IN_RANGE )
        return onEventByHandle("attackGetTarget",whichUnit,action)
    endmethod

    //on - 准备攻击
    //@getTriggerUnit 获取攻击单位
    //@getTargetUnit 获取被攻击单位
    //@getAttacker 获取攻击单位
    private static method onAttackReadyAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "attackReady"
        set bean.triggerUnit = GetAttacker()
        set bean.targetUnit = GetTriggerUnit()
        set bean.attacker = GetAttacker()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onAttackReady takes unit whichUnit,code action returns trigger
        if(event_trigger_attackReady==null)then
            set event_trigger_attackReady = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_attackReady, EVENT_PLAYER_UNIT_ATTACKED )
            call TriggerAddAction(event_trigger_attackReady, function thistype.onAttackReadyAction)
        endif
        return onEventByHandle("attackReady",whichUnit,action)
    endmethod

    //on - 准备被攻击
    //@getTriggerUnit 获取被攻击单位
    //@getTargetUnit 获取攻击单位
    //@getAttacker 获取攻击单位
    private static method onBeAttackReadyAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "beAttackReady"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.targetUnit = GetAttacker()
        set bean.attacker = GetAttacker()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onBeAttackReady takes unit whichUnit,code action returns trigger
        if(event_trigger_beAttackReady==null)then
            set event_trigger_beAttackReady = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_beAttackReady, EVENT_PLAYER_UNIT_ATTACKED )
            call TriggerAddAction(event_trigger_beAttackReady, function thistype.onBeAttackReadyAction)
        endif
        return onEventByHandle("beAttackReady",whichUnit,action)
    endmethod

    //on - 学习技能
    //@getTriggerUnit 获取学习单位
    //@getTriggerSkill 获取学习技能ID
    private static method onSkillStudyAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "skillStudy"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.triggerSkill = GetLearnedSkill()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onSkillStudy takes unit whichUnit,code action returns trigger
        if(event_trigger_skillStudy==null)then
            set event_trigger_skillStudy = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_skillStudy, EVENT_PLAYER_HERO_SKILL )
            call TriggerAddAction(event_trigger_skillStudy, function thistype.onSkillStudyAction)
        endif
        return onEventByHandle("skillStudy",whichUnit,action)
    endmethod

    //on - 准备施放技能
    //@getTriggerUnit 获取施放单位
    //@getTargetUnit 获取目标单位(只对对目标施放有效)
    //@getTriggerSkill 获取施放技能ID
    //@getTargetLoc 获取施放目标点
    private static method onSkillReadyAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "skillReady"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.targetUnit = GetSpellTargetUnit()
        set bean.triggerSkill = GetSpellAbilityId()
        set bean.targetLoc = GetSpellTargetLoc()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onSkillReady takes unit whichUnit,code action returns trigger
        if(event_trigger_skillReady==null)then
            set event_trigger_skillReady = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_skillReady, EVENT_PLAYER_UNIT_SPELL_CHANNEL )
            call TriggerAddAction(event_trigger_skillReady, function thistype.onSkillReadyAction)
        endif
        return onEventByHandle("skillReady",whichUnit,action)
    endmethod

    //on - 开始施放技能
    //@getTriggerUnit 获取施放单位
    //@getTargetUnit 获取目标单位(只对对目标施放有效)
    //@getTriggerSkill 获取施放技能ID
    //@getTargetLoc 获取施放目标点
    private static method onSkillStartAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "skillStart"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.targetUnit = GetSpellTargetUnit()
        set bean.triggerSkill = GetSpellAbilityId()
        set bean.targetLoc = GetSpellTargetLoc()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onSkillStart takes unit whichUnit,code action returns trigger
        if(event_trigger_skillStart==null)then
            set event_trigger_skillStart = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_skillStart, EVENT_PLAYER_UNIT_SPELL_CAST )
            call TriggerAddAction(event_trigger_skillStart, function thistype.onSkillStartAction)
        endif
        return onEventByHandle("skillStart",whichUnit,action)
    endmethod

    //on - 停止施放技能
    //@getTriggerUnit 获取施放单位
    //@getTriggerSkill 获取施放技能ID
    private static method onSkillStopAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "skillStop"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.triggerSkill = GetSpellAbilityId()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onSkillStop takes unit whichUnit,code action returns trigger
        if(event_trigger_skillStop==null)then
            set event_trigger_skillStop = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_skillStop, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
            call TriggerAddAction(event_trigger_skillStop, function thistype.onSkillStopAction)
        endif
        return onEventByHandle("skillStop",whichUnit,action)
    endmethod

    //on - 发动技能
    //@getTriggerUnit 获取施放单位
    //@getTargetUnit 获取目标单位(只对对目标施放有效)
    //@getTriggerSkill 获取施放技能ID
    //@getTargetLoc 获取施放目标点
    private static method onSkillHappenAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "skillHappen"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.targetUnit = GetSpellTargetUnit()
        set bean.triggerSkill = GetSpellAbilityId()
        set bean.targetLoc = GetSpellTargetLoc()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onSkillHappen takes unit whichUnit,code action returns trigger
        if(event_trigger_skillHappen==null)then
            set event_trigger_skillHappen = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_skillHappen, EVENT_PLAYER_UNIT_SPELL_EFFECT )
            call TriggerAddAction(event_trigger_skillHappen, function thistype.onSkillHappenAction)
        endif
        return onEventByHandle("skillHappen",whichUnit,action)
    endmethod

    //on - 施放技能结束
    //@getTriggerUnit 获取施放单位
    //@getTriggerSkill 获取施放技能ID
    private static method onSkillOverAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "skillOver"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.triggerSkill = GetSpellAbilityId()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onSkillOver takes unit whichUnit,code action returns trigger
        if(event_trigger_skillOver==null)then
            set event_trigger_skillOver = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_skillOver, EVENT_PLAYER_UNIT_SPELL_FINISH )
            call TriggerAddAction(event_trigger_skillOver, function thistype.onSkillOverAction)
        endif
        return onEventByHandle("skillOver",whichUnit,action)
    endmethod

    //on - 使用物品
    //@getTriggerUnit 获取触发单位
    //@getTriggerItem 获取触发物品
    private static method onItemUsedAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "itemUsed"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.triggerItem = GetManipulatedItem()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onItemUsed takes unit whichUnit,code action returns trigger
        if(event_trigger_itemUsed==null)then
            set event_trigger_itemUsed = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_itemUsed, EVENT_PLAYER_UNIT_USE_ITEM )
            call TriggerAddAction(event_trigger_itemUsed, function thistype.onItemUsedAction)
        endif
        return onEventByHandle("itemUsed",whichUnit,action)
    endmethod

    //on - 出售物品(商店卖给玩家)
    //@getTriggerUnit 获取触发单位
    //@getTriggerItem 获取触发物品
    private static method onItemSellAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "itemSell"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.triggerItem = GetSoldItem()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onItemSell takes unit whichUnit,code action returns trigger
        if(event_trigger_itemSell==null)then
            set event_trigger_itemSell = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_itemSell, EVENT_PLAYER_UNIT_SELL_ITEM )
            call TriggerAddAction(event_trigger_itemSell, function thistype.onItemSellAction)
        endif
        return onEventByHandle("itemSell",whichUnit,action)
    endmethod

    //on - 丢弃物品
    //@getTriggerUnit 获取触发单位
    //@getTriggerItem 获取触发物品
    public static method onItemDrop takes unit whichUnit,code action returns trigger
        return onEventByHandle("itemDrop",whichUnit,action)
    endmethod

    //on - 获得物品
    //@getTriggerUnit 获取触发单位
    //@getTriggerItem 获取触发物品
    public static method onItemGet takes unit whichUnit,code action returns trigger
        return onEventByHandle("itemGet",whichUnit,action)
    endmethod

    //on - 抵押物品（玩家把物品扔给商店）
    //@getTriggerUnit 获取触发单位
    //@getTriggerItem 获取触发物品
    public static method onItemPawn takes unit whichUnit,code action returns trigger
        return onEventByHandle("itemPawn",whichUnit,action)
    endmethod

    //on - 物品被破坏
    //@getTriggerUnit 获取触发单位
    //@getTriggerItem 获取触发物品
    private static method onItemDestroyAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "itemDestroy"
        set bean.triggerUnit = GetKillingUnit()
        set bean.triggerItem = GetManipulatedItem()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onItemDestroy takes item whichItem,code action returns trigger
        if(event_trigger_itemDestroy==null)then
            set event_trigger_itemDestroy = CreateTrigger()
            call TriggerRegisterDeathEvent( event_trigger_itemDestroy, whichItem )
            call TriggerAddAction(event_trigger_itemDestroy, function thistype.onItemDestroyAction)
        endif
        return onEventByHandle("itemDestroy",whichItem,action)
    endmethod

    //on - 合成物品
    //@getTriggerUnit 获取触发单位
    //@getTriggerItem 获取合成的物品
    public static method onItemMix takes unit whichUnit,code action returns trigger
        return onEventByHandle("itemMix",whichUnit,action)
    endmethod

    //on - 拆分物品
    //@getTriggerUnit 获取触发单位
    //@getId 获取拆分的物品ID
    //@getType 获取拆分的类型
    //————simple 单件拆分
    //————mixed 合成品拆分
    public static method onItemSeparate takes unit whichUnit,code action returns trigger
        return onEventByHandle("itemSeparate",whichUnit,action)
    endmethod

    //on - 造成伤害
    //@getTriggerUnit 获取伤害来源
    //@getTargetUnit 获取被伤害单位
    //@getSourceUnit 获取伤害来源
    //@getDamage 获取初始伤害
    //@getRealDamage 获取实际伤害
    //@getDamageKind 获取伤害方式
    //@getDamageType 获取伤害类型
    public static method onDamage takes unit whichUnit,code action returns trigger
        return onEventByHandle("damage",whichUnit,action)
    endmethod

    //on - 承受伤害
    //@getTriggerUnit 获取被伤害单位
    //@getSourceUnit 获取伤害来源
    //@getDamage 获取初始伤害
    //@getRealDamage 获取实际伤害
    //@getDamageKind 获取伤害方式
    //@getDamageType 获取伤害类型
    public static method onBeDamage takes unit whichUnit,code action returns trigger
        return onEventByHandle("beDamage",whichUnit,action)
    endmethod

    //on - 回避攻击成功
    //@getTriggerUnit 获取触发单位
    //@getAttacker 获取攻击单位
    public static method onAvoid takes unit whichUnit,code action returns trigger
        return onEventByHandle("avoid",whichUnit,action)
    endmethod

    //on - 攻击被回避
    //@getTriggerUnit 获取攻击单位
    //@getAttacker 获取攻击单位
    //@getTargetUnit 获取回避的单位
    public static method onBeAvoid takes unit whichUnit,code action returns trigger
        return onEventByHandle("beAvoid",whichUnit,action)
    endmethod

    //on - 无视护甲成功
    //@getBreakType 获取无视类型
    //@getTriggerUnit 获取破甲单位
    //@getTargetUnit 获取目标单位
    //@getValue 获取破甲的数值
    public static method onBreakDefend takes unit whichUnit,code action returns trigger
        return onEventByHandle("breakDefend",whichUnit,action)
    endmethod

    //on - 被无视护甲
    //@getBreakType 获取无视类型
    //@getTriggerUnit 获取被破甲单位
    //@getSourceUnit 获取来源单位
    //@getValue 获取破甲的数值
    public static method onBeBreakDefend takes unit whichUnit,code action returns trigger
        return onEventByHandle("beBreakDefend",whichUnit,action)
    endmethod

    //on - 无视魔抗成功
    //@getBreakType 获取无视类型
    //@getTriggerUnit 获取破抗单位
    //@getTargetUnit 获取目标单位
    //@getValue 获取破抗的百分比
    public static method onBreakResistance takes unit whichUnit,code action returns trigger
        return onEventByHandle("breakResistance",whichUnit,action)
    endmethod

    //on - 被无视魔抗
    //@getBreakType 获取无视类型
    //@getTriggerUnit 获取被破抗单位
    //@getSourceUnit 获取来源单位
    //@getValue 获取破抗的百分比
    public static method onBeBreakResistance takes unit whichUnit,code action returns trigger
        return onEventByHandle("beBreakResistance",whichUnit,action)
    endmethod

    //on - 无视护甲和魔抗同时成功
    //@getBreakType 获取无视类型
    //@getTriggerUnit 获取破甲/抗单位
    //@getTargetUnit 获取目标单位
    //@getValue 获取破甲的数值
    //@getValue2 获取破抗的百分比
    public static method onBreakDefendAndResistance takes unit whichUnit,code action returns trigger
        return onEventByHandle("breakDefendAndResistance",whichUnit,action)
    endmethod

    //on - 被同时无视护甲和魔抗
    //@getBreakType 获取无视类型
    //@getTriggerUnit 获取被破甲/抗单位
    //@getSourceUnit 获取来源单位
    //@getValue 获取破甲的数值
    //@getValue2 获取破抗的百分比
    public static method onBeBreakDefendAndResistance takes unit whichUnit,code action returns trigger
        return onEventByHandle("beBreakDefendAndResistance",whichUnit,action)
    endmethod

    //on - 眩晕成功
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取被眩晕单位
    //@getValue 获取眩晕几率百分比
    //@getDuring 获取眩晕时间（秒）
    public static method onSwim takes unit whichUnit,code action returns trigger
        return onEventByHandle("swim",whichUnit,action)
    endmethod

    //on - 被眩晕
    //@getTriggerUnit 获取被眩晕单位
    //@getSourceUnit 获取来源单位
    //@getValue 获取眩晕几率百分比
    //@getDuring 获取眩晕时间（秒）
    public static method onBeSwim takes unit whichUnit,code action returns trigger
        return onEventByHandle("beSwim",whichUnit,action)
    endmethod

    //on - 反伤时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getDamage 获取反伤伤害
    public static method onRebound takes unit whichUnit,code action returns trigger
        return onEventByHandle("rebound",whichUnit,action)
    endmethod

    //on - 造成无法回避的伤害时
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取目标单位
    //@getDamage 获取伤害值
    public static method onNoAvoid takes unit whichUnit,code action returns trigger
        return onEventByHandle("noAvoid",whichUnit,action)
    endmethod

    //on - 被造成无法回避的伤害时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getDamage 获取暴击伤害值
    public static method onBeNoAvoid takes unit whichUnit,code action returns trigger
        return onEventByHandle("beNoAvoid",whichUnit,action)
    endmethod

    //on - 物理暴击时
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取目标单位
    //@getDamage 获取暴击伤害值
    //@getValue 获取暴击几率百分比
    //@getValue2 获取暴击增幅百分比
    public static method onKnocking takes unit whichUnit,code action returns trigger
        return onEventByHandle("knocking",whichUnit,action)
    endmethod

    //on - 承受物理暴击时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getDamage 获取暴击伤害值
    //@getValue 获取暴击几率百分比
    //@getValue2 获取暴击增幅百分比
    public static method onBeKnocking takes unit whichUnit,code action returns trigger
        return onEventByHandle("beKnocking",whichUnit,action)
    endmethod

    //on - 魔法暴击时
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取目标单位
    //@getDamage 获取暴击伤害值
    //@getValue 获取暴击几率百分比
    //@getValue2 获取暴击增幅百分比
    public static method onViolence takes unit whichUnit,code action returns trigger
        return onEventByHandle("violence",whichUnit,action)
    endmethod

    //on - 承受魔法暴击时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getDamage 获取暴击伤害值
    //@getValue 获取暴击几率百分比
    //@getValue2 获取暴击增幅百分比
    public static method onBeViolence takes unit whichUnit,code action returns trigger
        return onEventByHandle("beViolence",whichUnit,action)
    endmethod

    //on - 分裂时
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取目标单位
    //@getDamage 获取分裂伤害值
    //@getRange 获取分裂范围(px)
    //@getValue 获取分裂百分比
    public static method onSpilt takes unit whichUnit,code action returns trigger
        return onEventByHandle("spilt",whichUnit,action)
    endmethod

    //on - 承受分裂时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getDamage 获取分裂伤害值
    //@getRange 获取分裂范围(px)
    //@getValue 获取分裂百分比
    public static method onBeSpilt takes unit whichUnit,code action returns trigger
        return onEventByHandle("beSpilt",whichUnit,action)
    endmethod

    //on - 吸血时
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取目标单位
    //@getDamage 获取吸血值
    //@getValue 获取吸血百分比
    public static method onHemophagia takes unit whichUnit,code action returns trigger
        return onEventByHandle("hemophagia",whichUnit,action)
    endmethod

    //on - 被吸血时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getDamage 获取吸血值
    //@getValue 获取吸血百分比
    public static method onBeHemophagia takes unit whichUnit,code action returns trigger
        return onEventByHandle("beHemophagia",whichUnit,action)
    endmethod

    //on - 技能吸血时
    //@getTriggerUnit 获取触发单位
    //@getTargetUnit 获取目标单位
    //@getDamage 获取吸血值
    //@getValue 获取吸血百分比
    public static method onSkillHemophagia takes unit whichUnit,code action returns trigger
        return onEventByHandle("skillHemophagia",whichUnit,action)
    endmethod

    //on - 被技能吸血时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getDamage 获取吸血值
    //@getValue 获取吸血百分比
    public static method onBeSkillHemophagia takes unit whichUnit,code action returns trigger
        return onEventByHandle("beSkillHemophagia",whichUnit,action)
    endmethod

    //on - 硬直时
    //@getTriggerUnit 获取触发单位
    //@getSourceUnit 获取来源单位
    //@getValue 获取硬直程度百分比
    //@getDuring 获取持续时间
    public static method onPunish takes unit whichUnit,code action returns trigger
        return onEventByHandle("punish",whichUnit,action)
    endmethod

    //on - 死亡时
    //@getTriggerUnit 获取触发单位
    //@getKiller 获取凶手单位
    public static method onDead takes unit whichUnit,code action returns trigger
        return onEventByHandle("dead",whichUnit,action)
    endmethod

    //on - 击杀时
    //@getTriggerUnit 获取触发单位
    //@getKiller 获取凶手单位
    //@getTargetUnit 获取死亡单位
    public static method onKill takes unit whichUnit,code action returns trigger
        return onEventByHandle("kill",whichUnit,action)
    endmethod

    //on - 复活时
    //@getTriggerUnit 获取触发单位
    public static method onReborn takes unit whichUnit,code action returns trigger
        return onEventByHandle("reborn",whichUnit,action)
    endmethod

    //on - 提升升等级时
    //@getTriggerUnit 获取触发单位
    public static method onLevelUp takes unit whichUnit,code action returns trigger
        return onEventByHandle("levelUp",whichUnit,action)
    endmethod

    //on - 被召唤时
    //@getTriggerUnit 获取被召唤单位
    private static method onSummonAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "summon"
        set bean.triggerUnit = GetTriggerUnit()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onSummon takes unit whichUnit,code action returns trigger
        if(event_trigger_summon==null)then
            set event_trigger_summon = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_summon, EVENT_PLAYER_UNIT_SUMMON )
            call TriggerAddAction(event_trigger_summon, function thistype.onSummonAction)
        endif
        return onEventByHandle("summon",whichUnit,action)
    endmethod

    //on - 进入某单位（whichUnit）范围内
    //@getTriggerUnit 获取被进入范围的中心单位
    //@getTriggerEnterUnit 获取进入范围的单位
    //@getRange 获取设定范围
    private static method onEnterUnitRangeAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "enterUnitRange"
        set bean.triggerUnit = getTriggerUnit()
        set bean.triggerEnterUnit = GetTriggerUnit()
        set bean.range = getRange()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onEnterUnitRange takes unit whichUnit,real range,code action returns trigger
        local boolean isInit = LoadBoolean(hash_trigger,GetHandleId(whichUnit),hashkey_unit_range+R2I(range))
        local trigger tgr = null
        if(isInit != true)then
            call SaveBoolean(hash_trigger,GetHandleId(whichUnit),hashkey_unit_range+R2I(range),true)
            call TriggerRegisterUnitInRangeSimple( tgr,range, whichUnit )
            call TriggerAddAction(tgr, function thistype.onEnterUnitRangeAction)
            call setTriggerUnit(tgr,whichUnit)
            call setRange(tgr,range)
        endif
        return onEventByHandle("enterUnitRange",whichUnit,action)
    endmethod

    //on - 进入某区域内
    //@getTriggerRect 获取被进入的矩形区域
    //@getTriggerUnit 获取进入矩形区域的单位
    private static method onEnterRectAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "enterRect"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.triggerRect = getTriggerRect()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onEnterRect takes rect whichRect,code action returns trigger
        local boolean isInit = LoadBoolean(hash_trigger,GetHandleId(whichRect),hashkey_rect_enter)
        local trigger tgr = null
        if(isInit != true)then
            call SaveBoolean(hash_trigger,GetHandleId(whichRect),hashkey_rect_enter,true)
            set tgr = CreateTrigger()
            call TriggerRegisterEnterRectSimple( tgr, whichRect )
            call TriggerAddAction(tgr, function thistype.onEnterRectAction)
            call setTriggerRect(tgr,whichRect)
        endif
        return onEventByHandle("enterRect",whichRect,action)
    endmethod

    //on - 离开某区域内
    //@getTriggerRect 获取被离开的矩形区域
    //@getTriggerUnit 获取离开矩形区域的单位
    private static method onLeaveRectAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "leaveRect"
        set bean.triggerUnit = GetTriggerUnit()
        set bean.triggerRect = getTriggerRect()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onLeaveRect takes rect whichRect,code action returns trigger
        local boolean isInit = LoadBoolean(hash_trigger,GetHandleId(whichRect),hashkey_rect_leave)
        local trigger tgr = null
        if(isInit != true)then
            call SaveBoolean(hash_trigger,GetHandleId(whichRect),hashkey_rect_leave,true)
            set tgr = CreateTrigger()
            call TriggerRegisterLeaveRectSimple( tgr, whichRect )
            call TriggerAddAction(tgr, function thistype.onLeaveRectAction)
            call setTriggerRect(tgr,whichRect)
        endif
        return onEventByHandle("leaveRect",whichRect,action)
    endmethod

    //on - 聊天时（全匹配）
    //@getTriggerPlayer 获取聊天的玩家
    //@getTriggerString 获取聊天的内容
    //@getTriggerStringMatched 获取匹配命中的内容
    private static method onChatAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "chat"
        set bean.triggerPlayer = GetTriggerPlayer()
        set bean.triggerString = GetEventPlayerChatString()
        set bean.triggerStringMatched = GetEventPlayerChatStringMatched()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onChat takes player whichPlayer,string chatStr,code action returns nothing
        local trigger tgr = CreateTrigger()
        local integer i = 0
        if(whichPlayer==null)then
            set i = player_max_qty
            loop
                exitwhen i<=0
                call TriggerRegisterPlayerChatEvent( tgr,players[i],chatStr,true)
                call TriggerAddAction(tgr, function thistype.onChatAction)
                call onEventByHandle("chat",players[i],action)
                set i=i-1
            endloop
        else
            call TriggerRegisterPlayerChatEvent( tgr,whichPlayer,chatStr,true)
            call TriggerAddAction(tgr, function thistype.onChatAction)
            call onEventByHandle("chat",whichPlayer,action)
        endif
    endmethod

    //on - 聊天时（like匹配）
    //getTriggerPlayer 获取聊天的玩家
    //getTriggerString 获取聊天的内容
    //getTriggerStringMatched 获取匹配命中的内容
    private static method onChatLikeAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "chatLike"
        set bean.triggerPlayer = GetTriggerPlayer()
        set bean.triggerString = GetEventPlayerChatString()
        set bean.triggerStringMatched = GetEventPlayerChatStringMatched()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onChatLike takes player whichPlayer,string chatStr,code action returns nothing
        local trigger tgr = CreateTrigger()
        local integer i = 0
        if(whichPlayer==null)then
            set i = player_max_qty
            loop
                exitwhen i<=0
                call TriggerRegisterPlayerChatEvent( tgr,players[i],chatStr,false)
                call TriggerAddAction(tgr, function thistype.onChatAction)
                call onEventByHandle("chatLike",players[i],action)
                set i=i-1
            endloop
        else
            call TriggerRegisterPlayerChatEvent( tgr,whichPlayer,chatStr,false)
            call TriggerAddAction(tgr, function thistype.onChatAction)
            call onEventByHandle("chatLike",whichPlayer,action)
        endif
    endmethod

    //on - 按ESC
    //getTriggerPlayer 获取触发玩家
    private static method onEscAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "esc"
        set bean.triggerPlayer = GetTriggerPlayer()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onEsc takes player whichPlayer,code action returns nothing
        local boolean isInit = false
        local trigger tgr = null
        local integer i = 0
        if(whichPlayer==null)then
            set i = player_max_qty
            loop
                exitwhen i<=0
                    set isInit = LoadBoolean(hash_trigger,GetHandleId(players[i]),hashkey_esc)
                    if(isInit != true)then
                        call SaveBoolean(hash_trigger,GetHandleId(players[i]),hashkey_esc,true)
                        set tgr = CreateTrigger()
                        call TriggerRegisterPlayerEventEndCinematic( tgr, players[i] )
                        call TriggerAddAction(tgr, function thistype.onEscAction)
                        call onEventByHandle("esc",players[i],action)
                    endif
                set i=i-1
            endloop
        else
            set isInit = LoadBoolean(hash_trigger,GetHandleId(whichPlayer),hashkey_esc)
            if(isInit != true)then
                call SaveBoolean(hash_trigger,GetHandleId(whichPlayer),hashkey_esc,true)
                set tgr = CreateTrigger()
                call TriggerRegisterPlayerEventEndCinematic( tgr, whichPlayer )
                call TriggerAddAction(tgr, function thistype.onEscAction)
                call onEventByHandle("esc",whichPlayer,action)
            endif
        endif
    endmethod

    //TODO 选择单位
    private static method onSelectionActionExpire takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer pid = htime.getInteger(t,1)
        local integer uid = htime.getInteger(t,2)
        call SaveInteger(hash_trigger,pid,uid,0)
    endmethod
    private static method onSelectionAction takes nothing returns nothing
        local player triggerPlayer = GetTriggerPlayer()
        local unit triggerUnit = GetTriggerUnit()
        local integer qty = 1+LoadInteger(hash_trigger,GetHandleId(triggerPlayer),GetHandleId(triggerUnit))
        local hEvtBean bean
        local timer t = LoadTimerHandle(hash_trigger,GetHandleId(triggerPlayer),hashkey_selection_timer)
        if(t != null)then
            call htime.delTimer(t)
        endif
        if(qty<1)then
            set qty = 1
        endif
        call SaveInteger(hash_trigger,GetHandleId(triggerPlayer),GetHandleId(triggerUnit),qty)
        if(qty == 1)then
            set bean = hEvtBean.create()
            set bean.triggerKey = "selection"
            set bean.triggerPlayer = triggerPlayer
            set bean.triggerUnit = triggerUnit
            call triggerEvent(bean)
            call bean.destroy()
        endif
        if(qty == 2)then
            set bean = hEvtBean.create()
            set bean.triggerKey = "selectionDouble"
            set bean.triggerPlayer = triggerPlayer
            set bean.triggerUnit = triggerUnit
            call triggerEvent(bean)
            call bean.destroy()
        endif
        if(qty == 3)then
            set bean = hEvtBean.create()
            set bean.triggerKey = "selectionTriple"
            set bean.triggerPlayer = triggerPlayer
            set bean.triggerUnit = triggerUnit
            call triggerEvent(bean)
            call bean.destroy()
        endif
        set t = htime.setTimeout(0.3,function thistype.onSelectionActionExpire)
        call htime.setInteger(t,1,GetHandleId(triggerPlayer))
        call htime.setInteger(t,2,GetHandleId(triggerUnit))
        call SaveTimerHandle(hash_trigger,GetHandleId(triggerPlayer),hashkey_selection_timer,t)
    endmethod
    private static method onSelectionBind takes player whichPlayer,code action,string evt returns nothing
        local boolean isInit = false
        local trigger tgr = null
        local integer i = 0
        if(whichPlayer==null)then
            set i = player_max_qty
            loop
                exitwhen i<=0
                    set isInit = LoadBoolean(hash_trigger,GetHandleId(players[i]),hashkey_selection)
                    if(isInit != true)then
                        call SaveBoolean(hash_trigger,GetHandleId(players[i]),hashkey_selection,true)
                        set tgr = CreateTrigger()
                        call TriggerRegisterPlayerSelectionEventBJ( tgr, players[i], true )
                        call TriggerAddAction(tgr, function thistype.onSelectionAction)
                        call onEventByHandle(evt,players[i],action)
                    endif
                set i=i-1
            endloop
        else
            set isInit = LoadBoolean(hash_trigger,GetHandleId(whichPlayer),hashkey_selection)
            if(isInit != true)then
                call SaveBoolean(hash_trigger,GetHandleId(whichPlayer),hashkey_selection,true)
                set tgr = CreateTrigger()
                call TriggerRegisterPlayerSelectionEventBJ( tgr, whichPlayer, true )
                call TriggerAddAction(tgr, function thistype.onSelectionAction)
                call onEventByHandle(evt,whichPlayer,action)
            endif
        endif
    endmethod
    //on - 玩家单击选择单位
    //getTriggerPlayer 获取触发玩家
    //getTriggerUnit 获取触发单位
    public static method onSelection takes player whichPlayer,code action returns nothing
        call onSelectionBind(whichPlayer,action,"selection")
    endmethod
    //on - 玩家双击选择单位
    //getTriggerPlayer 获取触发玩家
    //getTriggerUnit 获取触发单位
    public static method onSelectionDouble takes player whichPlayer,code action returns nothing
        call onSelectionBind(whichPlayer,action,"selectionDouble")
    endmethod
    //on - 玩家三击选择单位
    //getTriggerPlayer 获取触发玩家
    //getTriggerUnit 获取触发单位
    public static method onSelectionTriple takes player whichPlayer,code action returns nothing
        call onSelectionBind(whichPlayer,action,"selectionTriple")
    endmethod


    //on - 玩家取消选择单位
    //getTriggerPlayer 获取触发玩家
    //getTriggerUnit 获取触发单位
    private static method onUnSelectionAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "unSelection"
        set bean.triggerPlayer = GetTriggerPlayer()
        set bean.triggerUnit = GetTriggerUnit()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onUnSelection takes player whichPlayer,code action returns trigger
        local trigger tgr = CreateTrigger()
        local integer i = 0
        if(whichPlayer==null)then
            set i = player_max_qty
            loop
                exitwhen i<=0
                call TriggerRegisterPlayerSelectionEventBJ( tgr, players[i], false )
                set i=i-1
            endloop
        else
            call TriggerRegisterPlayerSelectionEventBJ( tgr, whichPlayer, false )
        endif
        call TriggerAddAction(tgr, function thistype.onUnSelectionAction)
        return onEventByHandle("unSelection",whichPlayer,action)
    endmethod

    //on - 建筑升级开始时
    //@getTriggerUnit 获取触发单位
    private static method onUpgradeStartAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "upgradeStart"
        set bean.triggerUnit = GetTriggerUnit()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onUpgradeStart takes unit whichUnit,code action returns trigger
        if(event_trigger_upgradeStart==null)then
            set event_trigger_upgradeStart = CreateTrigger()
            call TriggerRegisterUnitEvent( event_trigger_upgradeStart, whichUnit, EVENT_UNIT_UPGRADE_START )
            call TriggerAddAction(event_trigger_upgradeStart, function thistype.onUpgradeStartAction)
        endif
        return onEventByHandle("upgradeStart",whichUnit,action)
    endmethod
    //on - 建筑升级取消时
    //@getTriggerUnit 获取触发单位
    private static method onUpgradeCancelAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "upgradeCancel"
        set bean.triggerUnit = GetTriggerUnit()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onUpgradeCancel takes unit whichUnit,code action returns trigger
        if(event_trigger_upgradeCancel==null)then
            set event_trigger_upgradeCancel = CreateTrigger()
            call TriggerRegisterUnitEvent( event_trigger_upgradeCancel, whichUnit, EVENT_UNIT_UPGRADE_CANCEL )
            call TriggerAddAction(event_trigger_upgradeCancel, function thistype.onUpgradeCancelAction)
        endif
        return onEventByHandle("upgradeCancel",whichUnit,action)
    endmethod
    //on - 建筑升级完成时
    //@getTriggerUnit 获取触发单位
    private static method onUpgradeFinishAction takes nothing returns nothing
        local hEvtBean bean = hEvtBean.create()
        set bean.triggerKey = "upgradeFinish"
        set bean.triggerUnit = GetTriggerUnit()
        call triggerEvent(bean)
        call bean.destroy()
    endmethod
    public static method onUpgradeFinish takes unit whichUnit,code action returns trigger
        if(event_trigger_upgradeFinish==null)then
            set event_trigger_upgradeFinish = CreateTrigger()
            call TriggerRegisterUnitEvent( event_trigger_upgradeFinish, whichUnit, EVENT_UNIT_UPGRADE_FINISH )
            call TriggerAddAction(event_trigger_upgradeFinish, function thistype.onUpgradeFinishAction)
        endif
        return onEventByHandle("upgradeFinish",whichUnit,action)
    endmethod

    //on - 任意建筑建造开始时
    //@使用默认的 GetTriggerUnit 获取触发单位
    public static method onConstructStart takes code action returns trigger
        local trigger tg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( tg, EVENT_PLAYER_UNIT_CONSTRUCT_START )
        call TriggerAddAction(tg, action)
        return tg
    endmethod
    //on - 任意建筑建造取消时
    //@使用默认的 GetCancelledStructure 获取触发单位
    public static method onConstructCancel takes code action returns trigger
        local trigger tg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( tg, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL )
        call TriggerAddAction(tg, action)
        return tg
    endmethod
    //on - 任意建筑建造完成时
    //@使用默认的 GetConstructedStructure 获取触发单位
    public static method onConstructFinish takes code action returns trigger
        local trigger tg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( tg, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH )
        call TriggerAddAction(tg, action)
        return tg
    endmethod

   

endstruct
