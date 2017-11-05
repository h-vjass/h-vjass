/* 事件.j */

library hEvent initializer init needs hSys
    
    globals

        private hashtable hash = null
        private hashtable hash_trigger = null

        private integer hashkey_onattack_inc = 10001
        private integer hashkey_onattack_unit = 10002

        private integer trigger_limit = 100
        private integer hashkey_onattack_trigger = 100

        private integer hashkey_attacker = 90000

    endglobals

    /**
     * 设置凶手单位
     */
    public function setKiller takes unit toUnit,unit killer returns nothing
        local integer hid = GetHandleId(toUnit)
        if(is.death(toUnit)==true)then
            call SaveUnitHandle(hash, hid , 1, killer)
            call hplayer.addKill(GetOwningPlayer(killer),1)
        endif
    endfunction
    /**
     * 获取凶手单位
     */
    public function getKiller takes unit toUnit returns unit
        local integer hid = GetHandleId(toUnit)
        if(is.death(toUnit)!=true)then
            return null
        endif
        return LoadUnitHandle(hash, hid , 1)
    endfunction

    //on - 攻击
    public function onAttack takes unit whichUnit,code action returns nothing
        local integer hid = GetHandleId(whichUnit)
        local integer inc = LoadInteger(hash, hid, hashkey_onattack_inc)
        local trigger tg = CreateTrigger()
        call TriggerAddAction(tg,action)
        if(inc >= 1)then
            set inc = inc+1
        else
            set inc = 1
            call SaveBoolean(hash, hid, hashkey_onattack_unit, true)
        endif
        if(inc >= trigger_limit)then
            call console.error("break trigger_limit")
            return
        endif
        call SaveInteger(hash, hid, hashkey_onattack_inc , inc )
        call SaveTriggerHandle(hash_trigger, hid, hashkey_onattack_trigger+inc , tg )
    endfunction
    //检查该单位是否绑定过攻击事件
    public function isRegisterAttack takes unit whichUnit returns boolean
        return LoadBoolean(hash, GetHandleId(whichUnit), hashkey_onattack_unit)
    endfunction
    //获取攻击事件绑定数
    public function getAttackInc takes unit whichUnit returns integer
        return LoadInteger(hash, GetHandleId(whichUnit), hashkey_onattack_inc )
    endfunction
    //获取攻击事件触发
    public function getAttackTrigger takes unit whichUnit,integer inc returns trigger
        return LoadTriggerHandle(hash_trigger, GetHandleId(whichUnit), hashkey_onattack_trigger+inc )
    endfunction
    //--
    public function setAttacker takes trigger tgr,unit whichUnit returns nothing
        call SaveUnitHandle(hash_trigger, GetHandleId(tgr), hashkey_attacker , whichUnit )
    endfunction
    public function getAttacker takes nothing returns unit
        return LoadUnitHandle(hash_trigger, GetHandleId(GetTriggeringTrigger()), hashkey_attacker )
    endfunction

    //on - 受伤
    public function onHunt takes unit whichUnit returns nothing
        
    endfunction

    private function init takes nothing returns nothing
        set hash = InitHashtable()
        set hash_trigger = InitHashtable()
    endfunction

endlibrary

