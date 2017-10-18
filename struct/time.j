
globals
    hTime time = 0
    hashtable hash_time = null
    integer clock_h = 0
    integer clock_m = 0
    integer clock_i = 0
    integer clock_count = 0
endglobals

struct hTime

    //系统时间
    private static method clock takes nothing returns nothing
        set clock_count = clock_count + 1
        set clock_i = clock_i + 1
        if (clock_i >= 60) then
            set clock_m = clock_m + 1
            set clock_i = 0
            if (clock_m >= 60) then
                set clock_h = clock_h + 1
                set clock_m = 0
            endif
        endif
    endmethod

    static method create takes nothing returns hTime
        local hTime t = 0
        set t = hTime.allocate()
        if(hash_time==null)then
            set hash_time = InitHashtable()
        endif
        call TimerStart( CreateTimer() , 1.00 , true, function hTime.clock )
        return t
    endmethod
    method onDestroy takes nothing returns nothing
    endmethod

    //获取时
    public method hour takes nothing returns integer
        return clock_h
    endmethod
    //获取分
    public method min takes nothing returns integer
        return clock_m
    endmethod
    //获取秒
    public method sec takes nothing returns integer
        return clock_i
    endmethod
    //获取累计秒
    public method count takes nothing returns integer
        return clock_count
    endmethod
    //获取时分秒
    public method his takes nothing returns string
        local integer h = hour()
        local integer i = min()
        local integer s = sec()
        local string str = ""
        if(h<10)then
            set str = str + "0"+I2S(h)
        else
            set str = str + I2S(h)
        endif
        set str = str + ":"
        if(i<10)then
            set str = str + "0"+I2S(i)
        else
            set str = str + I2S(i)
        endif
        set str = str + ":"
        if(s<10)then
            set str = str + "0"+I2S(s)
        else
            set str = str + I2S(s)
        endif
        return str
    endmethod

    /**
     * GET SET TIMER PARAMS
     */
     //SET
    public method setReal takes timer t,integer k,real value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveReal(hash_time, timerHandleId, k, value)
    endmethod
    public method setInteger takes timer t,integer k,integer value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveInteger(hash_time, timerHandleId, k, value)
    endmethod
    public method setUnit takes timer t,integer k,unit value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveUnitHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setString takes timer t,integer k,string value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveStr(hash_time, timerHandleId, k, value)
    endmethod
    public method setBoolean takes timer t,integer k,boolean value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveBoolean(hash_time, timerHandleId, k, value)
    endmethod
    public method setLoc takes timer t,integer k,location value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveLocationHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setGroup takes timer t,integer k,group value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveGroupHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setPlayer takes timer t,integer k,player value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SavePlayerHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setItem takes timer t,integer k,item value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveItemHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setTimerDialog takes timer t,integer k,timerdialog value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveTimerDialogHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setTexttag takes timer t,integer k,texttag value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveTextTagHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setEffect takes timer t,integer k,effect value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveEffectHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setRect takes timer t,integer k,rect value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveRectHandle(hash_time, timerHandleId, k, value)
    endmethod
    public method setBx takes timer t,integer k,boolexpr value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveBooleanExprHandle(hash_time, timerHandleId, k, value)
    endmethod
    //GET
    public method getReal takes timer t,integer k returns real
        local integer timerHandleId = GetHandleId(t)
        return LoadReal(hash_time, timerHandleId, k)
    endmethod
    public method getInteger takes timer t,integer k returns integer
        local integer timerHandleId = GetHandleId(t)
        return LoadInteger(hash_time, timerHandleId, k)
    endmethod
    public method getUnit takes timer t,integer k returns unit
        local integer timerHandleId = GetHandleId(t)
        return LoadUnitHandle(hash_time, timerHandleId, k)
    endmethod
    public method getString takes timer t,integer k returns string
        local integer timerHandleId = GetHandleId(t)
        return LoadStr(hash_time, timerHandleId, k)
    endmethod
    public method getBoolean takes timer t,integer k returns boolean
        local integer timerHandleId = GetHandleId(t)
        return LoadBoolean(hash_time, timerHandleId, k)
    endmethod
    public method getLoc takes timer t,integer k returns location
        local integer timerHandleId = GetHandleId(t)
        return LoadLocationHandle(hash_time, timerHandleId, k)
    endmethod
    public method getGroup takes timer t,integer k returns group
        local integer timerHandleId = GetHandleId(t)
        return LoadGroupHandle(hash_time, timerHandleId, k)
    endmethod
    public method getPlayer takes timer t,integer k returns player
        local integer timerHandleId = GetHandleId(t)
        return LoadPlayerHandle(hash_time, timerHandleId, k)
    endmethod
    public method getItem takes timer t,integer k returns item
        local integer timerHandleId = GetHandleId(t)
        return LoadItemHandle(hash_time, timerHandleId, k)
    endmethod
    public method getTimerDialog takes timer t,integer k returns timerdialog
        local integer timerHandleId = GetHandleId(t)
        return LoadTimerDialogHandle(hash_time, timerHandleId, k)
    endmethod
    public method getTexttag takes timer t,integer k returns texttag
        local integer timerHandleId = GetHandleId(t)
        return LoadTextTagHandle(hash_time, timerHandleId, k)
    endmethod
    public method getEffect takes timer t,integer k returns effect
        local integer timerHandleId = GetHandleId(t)
        return LoadEffectHandle(hash_time, timerHandleId, k)
    endmethod
    public method getRect takes timer t,integer k returns rect
        local integer timerHandleId = GetHandleId(t)
        return LoadRectHandle(hash_time, timerHandleId, k)
    endmethod
    public method getBx takes timer t,integer k returns boolexpr
        local integer timerHandleId = GetHandleId(t)
        return LoadBooleanExprHandle(hash_time, timerHandleId, k)
    endmethod

    /**
     * 获取计时器设置时间
     */
    public method getSetTime takes timer t returns real
        if(t==null)then
            return 0
        else
            return TimerGetTimeout(t)
        endif
    endmethod

    /**
     * 获取计时器剩余时间
     */
    public method getRemainTime takes timer t returns real
        if(t==null)then
            return 0
        else
            return TimerGetRemaining(t)
        endif
    endmethod 

    /**
     * 获取计时器已过去时间
     */
    public method getElapsedTime takes timer t returns real
        if(t==null)then
            return 0
        else
            return TimerGetElapsed(t)
        endif
    endmethod 

    /**
     * 设置一次性计时器
     */
    public method setTimeout takes real time,code func returns timer
        local timer t = CreateTimer()
        call TimerStart( t, time , false, func )
        return t
    endmethod

    /**
     * 设置计时器窗口
     */
    public method setDialog takes timer t,string title returns timerdialog
        local timerdialog td = CreateTimerDialog(t)
        call TimerDialogSetTitle(td, title)
        call TimerDialogDisplay(td, true)
        call setTimerDialog( t , 9001 , td )
        return td
    endmethod

    /**
     * 获取计时器窗口
     */
    public method getDialog takes timer t returns timerdialog
        if(t == null) then
            return null
        endif
        return getTimerDialog( t , 9001 )
    endmethod
/**
     * 删除计时器窗口
     */
    public method delDialog takes timerdialog td returns nothing
        if(td == null) then
            return
        endif
        call DestroyTimerDialog(td)
    endmethod

    /**
     * 删除计时器 | 窗口
     */
    public method delTimer takes timer t returns nothing
        local timerdialog td = null
        if(t != null) then
            call PauseTimer(t)
            //找找看哈希表，看看有没有窗口
            set td = getDialog(t)
            if(td != null) then
                call DestroyTimerDialog(td)
                set td = null
            endif
            call DestroyTimer(t)
            set t = null
        endif
    endmethod

    /**
     * 设置循环计时器
     */
    public method setInterval takes real time,code func returns timer
        local timer t = CreateTimer()
        call TimerStart( t, time , true, func )
        return t
    endmethod

endstruct
