/* 事件.j */

library hEvent initializer init needs hPlayer
    
    globals

        private hashtable hash = null

    endglobals

    /**
     * 设置凶手单位
     */
    public function setKiller takes unit toUnit,unit killer returns nothing
        local integer hid = GetHandleId(toUnit)
        if(is.death(toUnit)==true)then
            call SaveUnitHandle(hash, hid , 1, killer)
            call hPlayer_addKill(GetOwningPlayer(killer),1)
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

    //on - 受伤
    public function onHunt takes unit whichUnit returns nothing
        
    endfunction

    private function init takes nothing returns nothing
        set hash = InitHashtable()
    endfunction

endlibrary

