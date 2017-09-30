/* 事件.j */

globals

    hashtable hash_event = null

endglobals

library hEvent initializer init needs hFilter
    
    /**
     * 设置凶手单位
     */
    public function setKiller takes unit toUnit,unit killer returns nothing
        local integer hid = GetHandleId(toUnit)
        if(hIs_death(toUnit)==true)then
            call SaveUnitHandle(hash_event, hid , 1, killer)
        endif
    endfunction
    /**
     * 获取凶手单位
     */
    public function getKiller takes unit toUnit returns unit
        local integer hid = GetHandleId(toUnit)
        if(hIs_death(toUnit)!=true)then
            return null
        endif
        return LoadUnitHandle(hash_event, hid , 1)
    endfunction

    private function init takes nothing returns nothing
        set hash_event = InitHashtable()
    endfunction

endlibrary
