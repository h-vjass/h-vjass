/* 事件.j */
globals
    hEvt evt = 0
    hashtable hash_trigger_register = InitHashtable()
    hashtable hash_trigger = InitHashtable()
    trigger event_trigger_attackHappen = null
endglobals

struct hEvt

    private static integer trigger_limit = 9999

    private static integer hashkey_onAttackHappen_inc = 5001
    private static integer hashkey_onAttackDamaged_inc = 5002
    private static integer hashkey_onAttackAvoid_inc = 5003

    private static integer hashkey_trigger_onAttackHappen = 10000
    private static integer hashkey_trigger_onAttackDamaged = 20000
    private static integer hashkey_trigger_onAttackAvoid = 30000

    private static integer hashkey_type_TriggerUnit = 1
    private static integer hashkey_type_TriggerRect = 2
    private static integer hashkey_type_TriggerDamage = 3
    private static integer hashkey_type_TargetUnit = 4
    private static integer hashkey_type_TargetLoc = 5
    private static integer hashkey_type_Attacker = 6
    private static integer hashkey_type_BeAttacker = 7
    private static integer hashkey_type_Damager = 8
    private static integer hashkey_type_BeDamager = 9

    //检查该单位是否绑定过单位事件
    private static method isUnitRegister takes unit which,integer k returns integer
        return LoadInteger(hash_trigger_register, GetHandleId(which), k )
    endmethod
    //获取单位事件触发
    private static method getUnitTrigger takes unit which,integer k,integer inc returns trigger
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
            call console.error("break<"+I2S(k)+">trigger_limit:"+I2S(trigger_limit))
            return -1
        endif
        call SaveInteger(hash_trigger_register, hid, k,inc )
        return inc
    endmethod

    //-- TODO SET DATA --
    //设置 triggerUnit 单位
    private static method setTriggerUnit takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerUnit , which )
    endmethod
    //设置 triggerRect 区域
    private static method setTriggerRect takes trigger tgr,rect which returns nothing
        call SaveRectHandle(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerRect , which )
    endmethod
    //设置 triggerDamage 实数
    private static method setTriggerDamage takes trigger tgr,real which returns nothing
        call SaveReal(hash_trigger, GetHandleId(tgr), hashkey_type_TriggerDamage , which )
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
    //设置 beAttacker 单位
    private static method setBeAttacker takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_BeAttacker , which )
    endmethod
    //设置 damager 单位
    private static method setDamager takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_Damager , which )
    endmethod
    //设置 beDamager 单位
    private static method setBeDamager takes trigger tgr,unit which returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_type_BeDamager , which )
    endmethod






    //------开放的方法------

    //trigger - 发动攻击
    public static method triggerAttackHappen takes unit triggerUnit returns nothing
        local integer k = hashkey_onAttackHappen_inc
        local trigger tempTgr = null
        local integer i = isUnitRegister(triggerUnit,k)
        if(i>0)then
            loop
                exitwhen i==0
                set tempTgr = getUnitTrigger(triggerUnit,k,i)
                call TriggerExecute(tempTgr)
                set tempTgr = null
                set i=i-1
            endloop
        endif
    endmethod

    //trigger - 攻击造成伤害事件
    public static method triggerAttackDamaged takes unit triggerUnit returns nothing
        local integer k = hashkey_onAttackDamaged_inc
        local trigger tempTgr = null
        local integer i = isUnitRegister(triggerUnit,k)
        if(i>0)then
            loop
                exitwhen i==0
                set tempTgr = getUnitTrigger(triggerUnit,k,i)
                call TriggerExecute(tempTgr)
                set tempTgr = null
                set i=i-1
            endloop
        endif
    endmethod

    //------on事件------

    //on - 发动攻击
    public static method onAttackHappen takes unit whichUnit,code action returns trigger
        local integer k = hashkey_onAttackHappen_inc
        local integer hid = GetHandleId(whichUnit)
        local integer inc = addInc( hid, k )
        local trigger tg = null
        if(inc==-1)then
            return tg
        endif
        set tg = CreateTrigger()
        call TriggerAddAction(tg,action)
        call setTriggerUnit(tg,whichUnit)
        call setAttacker(tg,whichUnit)
        call SaveTriggerHandle(hash_trigger, hid, k+inc , tg )
        return tg
    endmethod

    //on - 攻击造成伤害事件
    public static method onAttackDamaged takes unit whichUnit,code action returns trigger
        local integer k = hashkey_onAttackDamaged_inc
        local integer hid = GetHandleId(whichUnit)
        local integer inc = addInc( hid, k )
        local trigger tg = null
        if(inc==-1)then
            return tg
        endif
        set tg = CreateTrigger()
        call TriggerAddAction(tg,action)
        call setTriggerUnit(tg,whichUnit)
        call setAttacker(tg,whichUnit)
        call SaveTriggerHandle(hash_trigger, hid, k+inc , tg )
        return tg
    endmethod

    //-----获取触发数据-----
    //获取 triggerUnit 单位
    public static method getTriggerUnit takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerUnit )
    endmethod
    //获取 triggerRect 区域
    public static method getTriggerRect takes nothing returns rect
        return LoadRectHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerRect )
    endmethod
    //获取 triggerDamage 实数
    public static method getTriggerDamage takes nothing returns real
        return LoadReal(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_TriggerDamage )
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
    //获取 beAttacker 单位
    public static method getBeAttacker takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_BeAttacker )
    endmethod
    //获取 damager 单位
    public static method getDamager takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_Damager )
    endmethod
    //获取 beDamager 单位
    public static method getBeDamager takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_type_BeDamager )
    endmethod

    //初始化与默认结合的触发事件
    private static method event_trigger_attackHappen_action takes nothing returns nothing
        call triggerAttackHappen(GetAttacker())
    endmethod
    public static method initDefaultEvent takes nothing returns nothing
        //发动攻击事件
        if(event_trigger_attackHappen==null)then
            set event_trigger_attackHappen = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ( event_trigger_attackHappen, EVENT_PLAYER_UNIT_ATTACKED )
            call TriggerAddAction(event_trigger_attackHappen, function thistype.event_trigger_attackHappen_action)
        endif
    endmethod

endstruct
