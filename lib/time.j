
globals
    hTime htime
    hashtable hash_time = null
    timer hjass_global_timer = null
    string hjass_global_timer_txt = null
    timerdialog hjass_global_timer_dialog = null
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
        if(hconsole.isOpenDebug()==false)then
            call FogEnable( true )
            call FogMaskEnable( true )
        endif
    endmethod

    static method create takes nothing returns thistype
        local hTime t
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
        set hjass_global_timer_txt = ""
        if(hour()<10)then
            set hjass_global_timer_txt = hjass_global_timer_txt + "0"+I2S(hour())
        else
            set hjass_global_timer_txt = hjass_global_timer_txt + I2S(hour())
        endif
        set hjass_global_timer_txt = hjass_global_timer_txt + ":"
        if(min()<10)then
            set hjass_global_timer_txt = hjass_global_timer_txt + "0"+I2S(min())
        else
            set hjass_global_timer_txt = hjass_global_timer_txt + I2S(min())
        endif
        set hjass_global_timer_txt = hjass_global_timer_txt + ":"
        if(sec()<10)then
            set hjass_global_timer_txt = hjass_global_timer_txt + "0"+I2S(sec())
        else
            set hjass_global_timer_txt = hjass_global_timer_txt + I2S(sec())
        endif
        return hjass_global_timer_txt
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
        call SaveReal(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setInteger takes timer t,integer k,integer value returns nothing
        call SaveInteger(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setUnit takes timer t,integer k,unit value returns nothing
        call SaveUnitHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setString takes timer t,integer k,string value returns nothing
        call SaveStr(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setBoolean takes timer t,integer k,boolean value returns nothing
        call SaveBoolean(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setLoc takes timer t,integer k,location value returns nothing
        call SaveLocationHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setGroup takes timer t,integer k,group value returns nothing
        call SaveGroupHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setPlayer takes timer t,integer k,player value returns nothing
        call SavePlayerHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setItem takes timer t,integer k,item value returns nothing
        call SaveItemHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setTimerDialog takes timer t,integer k,timerdialog value returns nothing
        call SaveTimerDialogHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setTexttag takes timer t,integer k,texttag value returns nothing
        call SaveTextTagHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setEffect takes timer t,integer k,effect value returns nothing
        call SaveEffectHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setLightning takes timer t,integer k,lightning value returns nothing
        call SaveLightningHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setRect takes timer t,integer k,rect value returns nothing
        call SaveRectHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setBx takes timer t,integer k,boolexpr value returns nothing
        call SaveBooleanExprHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setTrigger takes timer t,integer k,trigger value returns nothing
        call SaveTriggerHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setMultiboard takes timer t,integer k,multiboard value returns nothing
        call SaveMultiboardHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setDestructable takes timer t,integer k,destructable value returns nothing
        call SaveDestructableHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    public static method setForce takes timer t,integer k,force value returns nothing
        call SaveForceHandle(hash_time, GetHandleId(t), k, value)
    endmethod
    //GET
    public static method getReal takes timer t,integer k returns real
        return LoadReal(hash_time, GetHandleId(t), k)
    endmethod
    public static method getInteger takes timer t,integer k returns integer
        return LoadInteger(hash_time, GetHandleId(t), k)
    endmethod
    public static method getUnit takes timer t,integer k returns unit
        return LoadUnitHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getString takes timer t,integer k returns string
        return LoadStr(hash_time, GetHandleId(t), k)
    endmethod
    public static method getBoolean takes timer t,integer k returns boolean
        return LoadBoolean(hash_time, GetHandleId(t), k)
    endmethod
    public static method getLoc takes timer t,integer k returns location
        return LoadLocationHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getGroup takes timer t,integer k returns group
        return LoadGroupHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getPlayer takes timer t,integer k returns player
        return LoadPlayerHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getItem takes timer t,integer k returns item
        return LoadItemHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getTimerDialog takes timer t,integer k returns timerdialog
        return LoadTimerDialogHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getTexttag takes timer t,integer k returns texttag
        return LoadTextTagHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getEffect takes timer t,integer k returns effect
        return LoadEffectHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getLightning takes timer t,integer k returns lightning
        return LoadLightningHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getRect takes timer t,integer k returns rect
        return LoadRectHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getBx takes timer t,integer k returns boolexpr
        return LoadBooleanExprHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getTrigger takes timer t,integer k returns trigger
        return LoadTriggerHandle(hash_time, GetHandleId(t), k)
    endmethod
     public static method getMultiboard takes timer t,integer k returns multiboard
        return LoadMultiboardHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getDestructable takes timer t,integer k returns destructable
        return LoadDestructableHandle(hash_time, GetHandleId(t), k)
    endmethod
    public static method getForce takes timer t,integer k returns force
        return LoadForceHandle(hash_time, GetHandleId(t), k)
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
        set hjass_global_timer = CreateTimer()
        call setType(hjass_global_timer,"timeout")
        call TimerStart( hjass_global_timer, time , false, func )
        return hjass_global_timer
    endmethod

    /**
     * 设置计时器窗口
     */
    public static method setDialog takes timer t,string title returns timerdialog
        set hjass_global_timer_dialog = CreateTimerDialog(t)
        call TimerDialogSetTitle(hjass_global_timer_dialog, title)
        call TimerDialogDisplay(hjass_global_timer_dialog, true)
        call setTimerDialog( t , 9001 , hjass_global_timer_dialog )
        call thistype.setDialogTitle( hjass_global_timer_dialog , title )
        return hjass_global_timer_dialog
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
        set td = null
    endmethod

    /**
     * 删除计时器 | 窗口
     */
    public static method delTimer takes timer t returns nothing
        if(t != null) then
            call PauseTimer(t)
            //找找看哈希表，看看有没有窗口
            set hjass_global_timer_dialog = getDialog(t)
            if(hjass_global_timer_dialog != null) then
                call FlushChildHashtable(hash_time, GetHandleId(hjass_global_timer_dialog))
                call DestroyTimerDialog(hjass_global_timer_dialog)
                set hjass_global_timer_dialog = null
            endif
            call FlushChildHashtable(hash_time, GetHandleId(t))
            call DestroyTimer(t)
            set t = null
        endif
    endmethod

    /**
     * 设置循环计时器
     */
    public static method setInterval takes real time,code func returns timer
        set hjass_global_timer = CreateTimer()
        call setType(hjass_global_timer,"interval")
        call TimerStart( hjass_global_timer, time , true, func )
        return hjass_global_timer
    endmethod

    /**
     * 暂停计时器
     */
    public static method pause takes timer t returns nothing
        if(t==null)then
            return
        endif
        set hjass_global_timer = LoadTimerHandle(hash_time,GetHandleId(t),StringHash("pause_timer"))
        if(hjass_global_timer != null)then
            call delTimer(hjass_global_timer)
            set hjass_global_timer = null
        endif
        call SaveReal(hash_time,GetHandleId(t),StringHash("pause_settimeout"),TimerGetTimeout(t))
        call SaveReal(hash_time,GetHandleId(t),StringHash("pause_remaining"),TimerGetRemaining(t))
        call PauseTimer(t)
    endmethod

    /**
     * 重启计时器
     */
    public static method resume takes timer t,code func returns nothing
        local real settimeout = 0
        local real remaining = 0
        local string title = null
        if(t==null)then
            return
        endif
        if(getType(t)=="timeout")then
            call ResumeTimer(t)
        else
            set title = getDialogTitle(getDialog(t))
            set settimeout = LoadReal(hash_time,GetHandleId(t),StringHash("pause_settimeout"))
            set remaining = LoadReal(hash_time,GetHandleId(t),StringHash("pause_remaining"))
            call delTimer(t)
            set t = null
            set hjass_global_timer = setTimeout(settimeout,func)
            call setDialog(hjass_global_timer, title)
            set hjass_global_timer = null
            set title = null
        endif
    endmethod

endstruct
