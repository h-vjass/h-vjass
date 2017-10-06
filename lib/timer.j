
library hTimer initializer init needs hSys

    /* 计时器 */
    globals

        private hashtable hash = null

    endglobals

    /**
     * GET SET TIMER PARAMS
     */
     //SET
    public function setReal takes timer t,integer k,real value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveReal(hash, timerHandleId, k, value)
    endfunction
    public function setInteger takes timer t,integer k,integer value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveInteger(hash, timerHandleId, k, value)
    endfunction
    public function setUnit takes timer t,integer k,unit value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveUnitHandle(hash, timerHandleId, k, value)
    endfunction
    public function setString takes timer t,integer k,string value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveStr(hash, timerHandleId, k, value)
    endfunction
    public function setBoolean takes timer t,integer k,boolean value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveBoolean(hash, timerHandleId, k, value)
    endfunction
    public function setLoc takes timer t,integer k,location value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveLocationHandle(hash, timerHandleId, k, value)
    endfunction
    public function setGroup takes timer t,integer k,group value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveGroupHandle(hash, timerHandleId, k, value)
    endfunction
    public function setPlayer takes timer t,integer k,player value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SavePlayerHandle(hash, timerHandleId, k, value)
    endfunction
    public function setItem takes timer t,integer k,item value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveItemHandle(hash, timerHandleId, k, value)
    endfunction
    public function setTimerDialog takes timer t,integer k,timerdialog value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveTimerDialogHandle(hash, timerHandleId, k, value)
    endfunction
    public function setTexttag takes timer t,integer k,texttag value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveTextTagHandle(hash, timerHandleId, k, value)
    endfunction
    //GET
    public function getReal takes timer t,integer k returns real
        local integer timerHandleId = GetHandleId(t)
        return LoadReal(hash, timerHandleId, k)
    endfunction
    public function getInteger takes timer t,integer k returns integer
        local integer timerHandleId = GetHandleId(t)
        return LoadInteger(hash, timerHandleId, k)
    endfunction
    public function getUnit takes timer t,integer k returns unit
        local integer timerHandleId = GetHandleId(t)
        return LoadUnitHandle(hash, timerHandleId, k)
    endfunction
    public function getString takes timer t,integer k returns string
        local integer timerHandleId = GetHandleId(t)
        return LoadStr(hash, timerHandleId, k)
    endfunction
    public function getBoolean takes timer t,integer k returns boolean
        local integer timerHandleId = GetHandleId(t)
        return LoadBoolean(hash, timerHandleId, k)
    endfunction
    public function getLoc takes timer t,integer k returns location
        local integer timerHandleId = GetHandleId(t)
        return LoadLocationHandle(hash, timerHandleId, k)
    endfunction
    public function getGroup takes timer t,integer k returns group
        local integer timerHandleId = GetHandleId(t)
        return LoadGroupHandle(hash, timerHandleId, k)
    endfunction
    public function getPlayer takes timer t,integer k returns player
        local integer timerHandleId = GetHandleId(t)
        return LoadPlayerHandle(hash, timerHandleId, k)
    endfunction
    public function getItem takes timer t,integer k returns item
        local integer timerHandleId = GetHandleId(t)
        return LoadItemHandle(hash, timerHandleId, k)
    endfunction
    public function getTimerDialog takes timer t,integer k returns timerdialog
        local integer timerHandleId = GetHandleId(t)
        return LoadTimerDialogHandle(hash, timerHandleId, k)
    endfunction
    public function getTexttag takes timer t,integer k returns texttag
        local integer timerHandleId = GetHandleId(t)
        return LoadTextTagHandle(hash, timerHandleId, k)
    endfunction

    /**
     * 设置一次性计时器
     */
    public function setTimeout takes real time,code func returns timer
        local timer t = CreateTimer()
        call TimerStart( t, time , false, func )
        return t
    endfunction

    /**
     * 设置计时器窗口
     */
    public function setDialog takes timer t,string title returns timerdialog
        local timerdialog td = CreateTimerDialog(t)
        call TimerDialogSetTitle(td, title)
        call TimerDialogDisplay(td, true)
        call setTimerDialog( t , 9001 , td )
        return td
    endfunction

    /**
     * 获取计时器窗口
     */
    public function getDialog takes timer t returns timerdialog
        if(t == null) then
            return null
        endif
        return getTimerDialog( t , 9001 )
    endfunction

    /**
     * 删除计时器 | 窗口
     */
    public function delTimer takes timer t,timerdialog td returns nothing
        if(t != null) then
            call PauseTimer(t)
            //如果没有窗口，就去找找看哈希表，看看有没有
            if(td == null) then
                set td = getDialog(t)
            endif
            if(td != null) then
                call DestroyTimerDialog(td)
            endif
            call DestroyTimer(t)
        endif
    endfunction

    /**
     * 设置循环计时器
     */
    public function setInterval takes real time,code func returns timer
        local timer t = CreateTimer()
        call TimerStart( t, time , true, func )
        return t
    endfunction
    
    private function init takes nothing returns nothing
        set hash = InitHashtable()
    endfunction

endlibrary
