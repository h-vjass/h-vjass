/* 消息 */
globals
    hMsg hmsg = 0
    hashtable hash_hmsg = null
endglobals
struct hMsg

    static method create takes nothing returns hMsg
        local hMsg x = 0
        set x = hMsg.allocate()
        if(hash_hmsg==null)then
            set hash_hmsg = InitHashtable()
        endif
        return x
    endmethod
    method onDestroy takes nothing returns nothing
    endmethod


    //在屏幕打印信息给所有玩家
    public static method echo takes string msg returns nothing
        call DisplayTextToForce( GetPlayersAll(), msg)
    endmethod
    public static method print takes string msg returns nothing
        call echo(msg)
    endmethod


    //在屏幕(x.y)处打印信息给某玩家
    public static method echoTo takes player whichPlayer,string msg,real x,real y,real duration returns nothing
        if(duration<5)then
            call DisplayTextToPlayer( whichPlayer, x, y, msg)
        else
            call DisplayTimedTextToPlayer( whichPlayer, x, y, duration, msg)
        endif
    endmethod
    public static method printTo takes player whichPlayer,string msg,real x,real y,real duration returns nothing
        call echoTo( whichPlayer, msg , x, y, duration)
    endmethod



    //删除漂浮字
    public static method delttg takes texttag ttg returns nothing
        call DestroyTextTag( ttg )
    endmethod
    //创建漂浮字
    //*设置during为0则永久显示
    //*color为6位颜色代码
    private static method createttg takes string msg,real size,string color,real opacity,real during returns texttag
        local texttag ttg = CreateTextTag()
        if( size<0 or opacity>=100 or opacity<0 or during<0)then
            return null
        endif
        if(StringLength(color)==6)then
            set msg = "|cff"+color+msg+"|r"
        endif
        call SetTextTagTextBJ(ttg, msg, size)
        call SaveStr(hash_hmsg, GetHandleId(ttg), 1, msg)
        call SaveReal(hash_hmsg, GetHandleId(ttg), 2, size)
        call SaveStr(hash_hmsg, GetHandleId(ttg), 3, color)
        call SetTextTagColorBJ(ttg, 100.00, 100.00, 100.00, opacity)
        if(during==0)then
            call SetTextTagPermanent( ttg, true )
        else
            call SetTextTagPermanent( ttg, false )
            call SetTextTagLifespan( ttg, during)
            call SetTextTagFadepoint( ttg, during)
        endif
        return ttg
    endmethod

    //获取漂浮字大小
    public static method getTtgSize takes texttag ttg returns real
        return LoadReal(hash_hmsg, GetHandleId(ttg), 2)
    endmethod
    //获取漂浮字颜色
    public static method getTtgColor takes texttag ttg returns string
        return LoadStr(hash_hmsg, GetHandleId(ttg), 3)
    endmethod
    //设置漂浮字内容
    public static method setTtgMsg takes texttag ttg,string msg,real size returns nothing
        if(size<=0)then
            set size = getTtgSize(ttg)
        endif
        call SaveStr(hash_hmsg, GetHandleId(ttg), 1 , msg)
        call SetTextTagTextBJ(  ttg , msg , size )
    endmethod
    //获取漂浮字内容
    public static method getTtgMsg takes texttag ttg returns string
        return LoadStr(hash_hmsg, GetHandleId(ttg), 1)
    endmethod
    //设置漂浮字弹出样式
    private static method ttgshowScale takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = time.getTexttag(t,1)
        local string msg = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        local real tnow = time.getReal(t,2)
        local real tend = time.getReal(t,3)
        if(tnow>=tend)then
            call time.delTimer(t)
        endif
        set tnow = tnow + TimerGetTimeout(t)
        call SetTextTagTextBJ(ttg, msg, size*(1+tnow*0.5/tend))
        call time.setReal(t,2,tnow)
    endmethod
    private static method ttgshowShrink takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = time.getTexttag(t,1)
        local string msg = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        local real tnow = time.getReal(t,2)
        local real tend = time.getReal(t,3)
        if(tnow>=tend)then
            call time.delTimer(t)
        endif
        set tnow = tnow + TimerGetTimeout(t)
        call SetTextTagTextBJ(ttg, msg, size*(1-tnow*0.5/tend))
        call time.setReal(t,2,tnow)
    endmethod
    private static method ttgshowToggle takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = time.getTexttag(t,1)
        local string msg = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        local real tnow = time.getReal(t,2)
        local real tend1 = time.getReal(t,3)
        local real tend2 = time.getReal(t,4)
        if(tnow>=tend1+tend2+0.3)then
            call time.delTimer(t)
        endif
        set tnow = tnow + TimerGetTimeout(t)
        if(tnow<=tend1)then
            call SetTextTagTextBJ(ttg, msg, size*(1+tnow/tend1))
        elseif(tnow>tend1+0.3)then
            call SetTextTagTextBJ(ttg, msg, size*2-(3*(tnow-tend1-0.3)/tend2))
        endif
        call time.setReal(t,2,tnow)
    endmethod
    public static method style takes texttag ttg,string showtype,real xspeed,real yspeed returns nothing
        local timer t = null
        call SetTextTagVelocity( ttg, xspeed, yspeed )
        if(showtype == "scale")then //放大
            set t = time.setInterval(0.03,function hMsg.ttgshowScale)
            call time.setTexttag(t,1,ttg)
            call time.setReal(t,2,0)
            call time.setReal(t,3,0.5)
        elseif(showtype == "shrink")then //缩小
            set t = time.setInterval(0.03,function hMsg.ttgshowShrink)
            call time.setTexttag(t,1,ttg)
            call time.setReal(t,2,0)
            call time.setReal(t,3,0.5)
        elseif(showtype == "toggle")then //放大再缩小
            set t = time.setInterval(0.03,function hMsg.ttgshowToggle)
            call time.setTexttag(t,1,ttg)
            call time.setReal(t,2,0)
            call time.setReal(t,3,0.3)
            call time.setReal(t,4,0.3)
        endif
    endmethod
    //漂浮文字 - 默认 (在某单位头上)
    public static method ttg2Unit takes unit u,string msg,real size,string color,real opacity,real during,real zOffset returns texttag
        local texttag ttg = createttg(msg,size,color,opacity,during)
        call SetTextTagPos( ttg , GetUnitX(u)-I2R(StringLength(msg))*size*0.5 , GetUnitY(u) , zOffset )
        return ttg
    endmethod
    //漂浮文字 - 默认 (在某点上)
    public static method ttg2Loc takes location loc,string msg,real size,string color,real opacity,real during,real zOffset returns texttag
        local texttag ttg = createttg(msg,size,color,opacity,during)
        call SetTextTagPos( ttg , GetLocationX(loc)-I2R(StringLength(msg))*size*0.5 , GetLocationY(loc) , zOffset )
        return ttg
    endmethod
    //漂浮文字 - 绑定在某单位头上，跟随移动(动作)
    private static method ttgBindUnitCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = time.getUnit( t , 1 )
        local texttag ttg = time.getTexttag( t , 2 )
        local real zOffset = time.getReal( t , 3 )
        local string msg = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        if( ttg==null )then
            call time.delTimer(t)
        endif
        call SetTextTagPos( ttg , GetUnitX(u)-25.0*size*0.5 , GetUnitY(u) , zOffset )
        if( is.alive(u) == true ) then
            call SetTextTagVisibility( ttg , true )
        else
            call SetTextTagVisibility( ttg , false )
        endif
    endmethod
    //漂浮文字 - 绑定在某单位头上，跟随移动
    public static method ttgBindUnit takes unit u,string msg,real size,string color,real opacity,real zOffset returns texttag
        local texttag ttg =  ttg2Unit(u,msg,size,color,opacity,0,zOffset)
        local timer t = time.setInterval( 0.03 , function hMsg.ttgBindUnitCall )
        call time.setUnit( t , 1 , u )
        call time.setTexttag( t , 2 , ttg )
        call time.setReal( t , 3 , zOffset )
        return ttg
    endmethod

endstruct
