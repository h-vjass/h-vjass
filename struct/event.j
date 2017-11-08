/* 事件.j */
globals
    hEvt evt = 0
    hashtable hash_trigger_register = InitHashtable()
    hashtable hash_trigger_data = InitHashtable()
    hashtable hash_trigger = InitHashtable()
endglobals

struct hEvt

    private static integer trigger_limit = 99

    private static integer hashkey_onattack_inc = 10001
    private static integer hashkey_onskillHunt_int = 10002

    private static integer hashkey_onattack_trigger = 100
    private static integer hashkey_onskill_hunt_trigger = 200

    private static integer hashkey_trigger_unit = 90000
    private static integer hashkey_attacker = 90001
    private static integer hashkey_skill_hunter = 90002


    //设置触发单位
    private static method setTriggerUnit takes trigger tgr,unit whichUnit returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_trigger_unit , whichUnit )
    endmethod

    //TODO 攻击事件(内部调用)

    //检查该单位是否绑定过攻击事件
    public static method isAttackRegister takes unit whichUnit returns integer
        return LoadInteger(hash_trigger_register, GetHandleId(whichUnit), hashkey_onattack_inc )
    endmethod
    //获取攻击事件触发
    public static method getAttackTrigger takes unit whichUnit,integer inc returns trigger
        return LoadTriggerHandle(hash_trigger, GetHandleId(whichUnit), hashkey_onattack_trigger+inc )
    endmethod
    //设置攻击单位
    private static method setAttacker takes trigger tgr,unit whichUnit returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_attacker , whichUnit )
    endmethod

    //检查该单位是否绑定过技能伤害事件
    public static method isSkillHuntRegister takes unit whichUnit returns integer
        return LoadInteger(hash_trigger_register, GetHandleId(whichUnit), hashkey_onskillHunt_int )
    endmethod
    //获取技能伤害事件触发
    public static method getSkillHuntTrigger takes unit whichUnit,integer inc returns trigger
        return LoadTriggerHandle(hash_trigger, GetHandleId(whichUnit), hashkey_onskill_hunt_trigger+inc )
    endmethod
    //设置技能伤害单位
    private static method setSkillHunter takes trigger tgr,unit whichUnit returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_skill_hunter , whichUnit )
    endmethod

    //设置凶手单位
    public static method setKiller takes unit toUnit,unit whichUnit returns nothing
        local integer hid = GetHandleId(toUnit)
        if(is.death(toUnit)==true)then
            call SaveUnitHandle(hash_trigger_register, hid , 1, whichUnit)
            call hplayer.addKill(GetOwningPlayer(whichUnit),1)
        endif
    endmethod





    //------开放的事件------

    private static method onCheckInc takes integer hid,integer hashkey returns integer
        local integer inc = LoadInteger(hash_trigger_register, hid, hashkey)
        if(inc >= 1)then
            set inc = inc+1
        else
            set inc = 1
        endif
        if(inc >= trigger_limit)then
            call console.error("break<"+I2S(hashkey)+">trigger_limit:"+I2S(trigger_limit))
            return -1
        endif
        call SaveInteger(hash_trigger_register, hid, hashkey , inc )
        return inc
    endmethod

    //on - 攻击
    public static method onAttack takes unit whichUnit,code action returns nothing
        local integer hid = GetHandleId(whichUnit)
        local integer inc = thistype.onCheckInc( hid, hashkey_onattack_inc )
        local trigger tg = null
        if(inc==-1)then
            return
        endif
        set tg = CreateTrigger()
        call TriggerAddAction(tg,action)
        call thistype.setTriggerUnit(tg,whichUnit)
        call thistype.setAttacker(tg,whichUnit)
        call SaveTriggerHandle(hash_trigger, hid, hashkey_onattack_trigger+inc , tg )
    endmethod

    //on - 受伤
    public method onHunt takes unit whichUnit returns nothing
        
    endmethod


    
    //------开放的获取触发数据------

    //设置触发单位
    private static method getTriggerUnit takes trigger tgr returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_trigger_unit )
    endmethod

    /**
     * 获取凶手单位
     */
    public static method getKiller takes unit toUnit returns unit
        local integer hid = GetHandleId(toUnit)
        if(is.death(toUnit)!=true)then
            return null
        endif
        return LoadUnitHandle(hash_trigger_register, hid , 1)
    endmethod

    public static method getAttacker takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_attacker )
    endmethod


endstruct
