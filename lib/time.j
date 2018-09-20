
globals
    hTime htime
    hashtable hash_time = null
endglobals

struct hTime

    private static integer clock_h = 0
    private static integer clock_m = 0
    private static integer clock_i = 0
    private static integer clock_count = 0

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
        if(hconsole.status==false)then
            call FogEnable( true )
            call FogMaskEnable( true )
        endif
    endmethod

    static method create takes nothing returns thistype
        local hTime t = 0
        set t = hTime.allocate()
        call TimerStart( CreateTimer() , 1.00 , true, function thistype.clock )
        return t
    endmethod

    //获取时
    public static method hour takes nothing returns integer
        return clock_h
    endmethod
    //获取分
    public static method min takes nothing returns integer
        return clock_m
    endmethod
    //获取秒
    public static method sec takes nothing returns integer
        return clock_i
    endmethod
    //获取累计秒
    public static method count takes nothing returns integer
        return clock_count
    endmethod
    //获取时分秒
    public static method his takes nothing returns string
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

    //设置计时器类型 timeout | interval
    private static method setType takes timer t,string type1 returns nothing
        call SaveStr(hash_time, GetHandleId(t), StringHash("timer_type"), type1)
    endmethod

    //获取计时器类型
    public static method getType takes timer t returns string
        return LoadStr(hash_time, GetHandleId(t) , StringHash("timer_type"))
    endmethod
    
    /**
     * GET SET TIMER PARAMS
     */
     //SET
    public static method setReal takes timer t,integer k,real value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveReal(hash_time, timerHandleId, k, value)
    endmethod
    public static method setInteger takes timer t,integer k,integer value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveInteger(hash_time, timerHandleId, k, value)
    endmethod
    public static method setUnit takes timer t,integer k,unit value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveUnitHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setString takes timer t,integer k,string value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveStr(hash_time, timerHandleId, k, value)
    endmethod
    public static method setBoolean takes timer t,integer k,boolean value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveBoolean(hash_time, timerHandleId, k, value)
    endmethod
    public static method setLoc takes timer t,integer k,location value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveLocationHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setGroup takes timer t,integer k,group value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveGroupHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setPlayer takes timer t,integer k,player value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SavePlayerHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setItem takes timer t,integer k,item value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveItemHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setTimerDialog takes timer t,integer k,timerdialog value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveTimerDialogHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setTexttag takes timer t,integer k,texttag value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveTextTagHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setEffect takes timer t,integer k,effect value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveEffectHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setLightning takes timer t,integer k,lightning value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveLightningHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setRect takes timer t,integer k,rect value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveRectHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setBx takes timer t,integer k,boolexpr value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveBooleanExprHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setTrigger takes timer t,integer k,trigger value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveTriggerHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setMultiboard takes timer t,integer k,multiboard value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveMultiboardHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setDestructable takes timer t,integer k,destructable value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveDestructableHandle(hash_time, timerHandleId, k, value)
    endmethod
    public static method setForce takes timer t,integer k,force value returns nothing
        local integer timerHandleId = GetHandleId(t)
        call SaveForceHandle(hash_time, timerHandleId, k, value)
    endmethod
    //GET
    public static method getReal takes timer t,integer k returns real
        local integer timerHandleId = GetHandleId(t)
        return LoadReal(hash_time, timerHandleId, k)
    endmethod
    public static method getInteger takes timer t,integer k returns integer
        local integer timerHandleId = GetHandleId(t)
        return LoadInteger(hash_time, timerHandleId, k)
    endmethod
    public static method getUnit takes timer t,integer k returns unit
        local integer timerHandleId = GetHandleId(t)
        return LoadUnitHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getString takes timer t,integer k returns string
        local integer timerHandleId = GetHandleId(t)
        return LoadStr(hash_time, timerHandleId, k)
    endmethod
    public static method getBoolean takes timer t,integer k returns boolean
        local integer timerHandleId = GetHandleId(t)
        return LoadBoolean(hash_time, timerHandleId, k)
    endmethod
    public static method getLoc takes timer t,integer k returns location
        local integer timerHandleId = GetHandleId(t)
        return LoadLocationHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getGroup takes timer t,integer k returns group
        local integer timerHandleId = GetHandleId(t)
        return LoadGroupHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getPlayer takes timer t,integer k returns player
        local integer timerHandleId = GetHandleId(t)
        return LoadPlayerHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getItem takes timer t,integer k returns item
        local integer timerHandleId = GetHandleId(t)
        return LoadItemHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getTimerDialog takes timer t,integer k returns timerdialog
        local integer timerHandleId = GetHandleId(t)
        return LoadTimerDialogHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getTexttag takes timer t,integer k returns texttag
        local integer timerHandleId = GetHandleId(t)
        return LoadTextTagHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getEffect takes timer t,integer k returns effect
        local integer timerHandleId = GetHandleId(t)
        return LoadEffectHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getLightning takes timer t,integer k returns lightning
        local integer timerHandleId = GetHandleId(t)
        return LoadLightningHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getRect takes timer t,integer k returns rect
        local integer timerHandleId = GetHandleId(t)
        return LoadRectHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getBx takes timer t,integer k returns boolexpr
        local integer timerHandleId = GetHandleId(t)
        return LoadBooleanExprHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getTrigger takes timer t,integer k returns trigger
        local integer timerHandleId = GetHandleId(t)
        return LoadTriggerHandle(hash_time, timerHandleId, k)
    endmethod
     public static method getMultiboard takes timer t,integer k returns multiboard
        local integer timerHandleId = GetHandleId(t)
        return LoadMultiboardHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getDestructable takes timer t,integer k returns destructable
        local integer timerHandleId = GetHandleId(t)
        return LoadDestructableHandle(hash_time, timerHandleId, k)
    endmethod
    public static method getForce takes timer t,integer k returns force
        local integer timerHandleId = GetHandleId(t)
        return LoadForceHandle(hash_time, timerHandleId, k)
    endmethod

    /**
     * 获取计时器设置时间
     */
    public static method getSetTime takes timer t returns real
        if(t==null)then
            return 0
        else
            return TimerGetTimeout(t)
        endif
    endmethod

    /**
     * 获取计时器剩余时间
     */
    public static method getRemainTime takes timer t returns real
        if(t==null)then
            return 0
        else
            return TimerGetRemaining(t)
        endif
    endmethod 

    /**
     * 获取计时器已过去时间
     */
    public static method getElapsedTime takes timer t returns real
        if(t==null)then
            return 0
        else
            return TimerGetElapsed(t)
        endif
    endmethod 

    /**
     * 设置一次性计时器
     */
    public static method setTimeout takes real time,code func returns timer
        local timer t = CreateTimer()
        call setType(t,"timeout")
        call TimerStart( t, time , false, func )
        return t
    endmethod

    /**
     * 设置计时器窗口
     */
    public static method setDialog takes timer t,string title returns timerdialog
        local timerdialog td = CreateTimerDialog(t)
        call TimerDialogSetTitle(td, title)
        call TimerDialogDisplay(td, true)
        call setTimerDialog( t , 9001 , td )
        call thistype.setDialogTitle( td , title )
        return td
    endmethod

    /**
     * 设置取计时器标题
     */
    private static method setDialogTitle takes timerdialog td,string title returns nothing
        if(td == null) then
            return
        endif
        call SaveStr(hash_time,GetHandleId(td),8001,title)
    endmethod

    /**
     * 获取计时器标题
     */
    public static method getDialogTitle takes timerdialog td returns string
        if(td == null) then
            return ""
        endif
        return LoadStr(hash_time,GetHandleId(td),8001)
    endmethod

    /**
     * 获取计时器窗口
     */
    public static method getDialog takes timer t returns timerdialog
        if(t == null) then
            return null
        endif
        return getTimerDialog( t , 9001 )
    endmethod
/**
     * 删除计时器窗口
     */
    public static method delDialog takes timerdialog td returns nothing
        if(td == null) then
            return
        endif
        call DestroyTimerDialog(td)
    endmethod

    /**
     * 删除计时器 | 窗口
     */
    public static method delTimer takes timer t returns nothing
        local timerdialog td = null
        if(t != null) then
            call PauseTimer(t)
            //找找看哈希表，看看有没有窗口
            set td = getDialog(t)
            if(td != null) then
                call DestroyTimerDialog(td)
                set td = null
            endif
            call PauseTimer(t)
            call DestroyTimer(t)
            set t = null
        endif
    endmethod

    /**
     * 设置循环计时器
     */
    public static method setInterval takes real time,code func returns timer
        local timer t = CreateTimer()
        call setType(t,"interval")
        call TimerStart( t, time , true, func )
        return t
    endmethod

    /**
     * 暂停计时器
     */
    public static method pause takes timer t returns nothing
        local timer recallTimer = null
        local trigger recallTrigger = null
        if(t==null)then
            return
        endif
        set recallTimer = LoadTimerHandle(hash_time,GetHandleId(t),StringHash("pause_timer"))
        if(recallTimer != null)then
            call delTimer(recallTimer)
        endif
        call SaveReal(hash_time,GetHandleId(t),StringHash("pause_settimeout"),TimerGetTimeout(t))
        call SaveReal(hash_time,GetHandleId(t),StringHash("pause_remaining"),TimerGetRemaining(t))
        call PauseTimer(t)
    endmethod

    /**
     * 重启计时器
     */
    public static method resume takes timer t,code func returns nothing
        local string type1 = ""
        local real settimeout = 0
        local real remaining = 0
        local timer recallTimer = null
        local string title = ""
        if(t==null)then
            return
        endif
        if(type1 == "timeout")then
            call ResumeTimer(t)
        else
            set title = getDialogTitle(getDialog(t))
            set type1 = getType(t)
            set settimeout = LoadReal(hash_time,GetHandleId(t),StringHash("pause_settimeout"))
            set remaining = LoadReal(hash_time,GetHandleId(t),StringHash("pause_remaining"))
            call delTimer(t)
            set recallTimer = setTimeout(settimeout,func)
            call setDialog(recallTimer, title)
        endif
    endmethod

endstruct
