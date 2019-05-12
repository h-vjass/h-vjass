//消息
globals
    hMsg hmsg
    texttag hjass_global_texttag
    hashtable hash_hmsg = null
endglobals
struct hMsg

    static method create takes nothing returns hMsg
        local hMsg x = 0
        set x = hMsg.allocate()
        return x
    endmethod

    //在屏幕打印信息给所有玩家
    public static method echo takes string msg returns nothing
        call DisplayTextToForce( GetPlayersAll(), msg)
        set msg = null
    endmethod
    public static method print takes string msg returns nothing
        call echo(msg)
        set msg = null
    endmethod


    //在屏幕(x.y)处打印信息给某玩家
    public static method echoToXY takes player whichPlayer,string msg,real x,real y,real duration returns nothing
        if(duration<5)then
            call DisplayTextToPlayer( whichPlayer, x, y, msg)
        else
            call DisplayTimedTextToPlayer( whichPlayer, x, y, duration, msg)
        endif
        set whichPlayer = null
        set msg = null
    endmethod
    public static method printToXY takes player whichPlayer,string msg,real x,real y,real duration returns nothing
        call echoToXY( whichPlayer, msg , x, y, duration)
        set whichPlayer = null
        set msg = null
    endmethod

    //在屏幕(0,0)处打印信息给某玩家
    public static method echoTo takes player whichPlayer,string msg,real duration returns nothing
        if(duration<5)then
            call DisplayTextToPlayer( whichPlayer, 0, 0, msg)
        else
            call DisplayTimedTextToPlayer( whichPlayer, 0, 0, duration, msg)
        endif
        set whichPlayer = null
        set msg = null
    endmethod
    public static method printTo takes player whichPlayer,string msg,real duration returns nothing
        call echoTo( whichPlayer, msg, duration)
        set whichPlayer = null
        set msg = null
    endmethod



    //删除漂浮字
    public static method delttg takes texttag ttg returns nothing
        call FlushChildHashtable(hash_hmsg,GetHandleId(ttg))
        call DestroyTextTag( ttg )
        set ttg = null
    endmethod
    //创建漂浮字
    //*设置during为0则永久显示
    //*color为6位颜色代码
    private static method createttg takes string msg,real size,string color,real opacity,real during returns texttag
        set hjass_global_texttag = CreateTextTag()
        if( size<0 or opacity>=100 or opacity<0 or during<0)then
            set msg = null
            set color = null
            return null
        endif
        if(StringLength(color)==6)then
            set msg = "|cff"+color+msg+"|r"
        endif
        call SetTextTagTextBJ(hjass_global_texttag, msg, size)
        call SaveStr(hash_hmsg, GetHandleId(hjass_global_texttag), 1, msg)
        call SaveReal(hash_hmsg, GetHandleId(hjass_global_texttag), 2, size)
        call SaveStr(hash_hmsg, GetHandleId(hjass_global_texttag), 3, color)
        call SetTextTagColorBJ(hjass_global_texttag, 100.00, 100.00, 100.00, opacity)
        if(during==0)then
            call SetTextTagPermanent( hjass_global_texttag, true )
        else
            call SetTextTagPermanent( hjass_global_texttag, false )
            call SetTextTagLifespan( hjass_global_texttag, during)
            call SetTextTagFadepoint( hjass_global_texttag, during)
        endif
        set msg = null
        set color = null
        return hjass_global_texttag
    endmethod

    //获取漂浮字大小
    public static method getTtgSize takes texttag ttg returns real
        local integer hid = GetHandleId(ttg)
        set ttg = null
        return LoadReal(hash_hmsg, hid, 2)
    endmethod
    //获取漂浮字颜色
    public static method getTtgColor takes texttag ttg returns string
        local integer hid = GetHandleId(ttg)
        set ttg = null
        return LoadStr(hash_hmsg, hid, 3)
    endmethod
    //设置漂浮字内容
    public static method setTtgMsg takes texttag ttg,string msg,real size returns nothing
        if(size<=0)then
            set size = getTtgSize(ttg)
        endif
        call SaveStr(hash_hmsg, GetHandleId(ttg), 1 , msg)
        call SetTextTagTextBJ(  ttg , msg , size )
        set ttg = null
        set msg = null
    endmethod
    //获取漂浮字内容
    public static method getTtgMsg takes texttag ttg returns string
        local integer hid = GetHandleId(ttg)
        set ttg = null
        return LoadStr(hash_hmsg, hid, 1)
    endmethod
    //设置漂浮字弹出样式
    private static method ttgshowScale takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = htime.getTexttag(t,1)
        local real size = getTtgSize(ttg)
        local real tnow = htime.getReal(t,2)
        local real tend = htime.getReal(t,3)
        if(tnow>=tend)then
            call htime.delTimer(t)
            set t = null
            set ttg = null
            return
        endif
        set tnow = tnow + TimerGetTimeout(t)
        call SetTextTagTextBJ(ttg, getTtgMsg(ttg), size*(1+tnow*0.5/tend))
        call htime.setReal(t,2,tnow)
        set t = null
        set ttg = null
    endmethod
    private static method ttgshowShrink takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = htime.getTexttag(t,1)
        local real size = getTtgSize(ttg)
        local real tnow = htime.getReal(t,2)
        local real tend = htime.getReal(t,3)
        if(tnow>=tend)then
            call htime.delTimer(t)
            set t = null
            set ttg = null
            return
        endif
        set tnow = tnow + TimerGetTimeout(t)
        call SetTextTagTextBJ(ttg, getTtgMsg(ttg), size*(1-tnow*0.5/tend))
        call htime.setReal(t,2,tnow)
        set t = null
        set ttg = null
    endmethod
    private static method ttgshowToggle takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = htime.getTexttag(t,1)
        local real size = getTtgSize(ttg)
        local real tnow = htime.getReal(t,2)
        local real tend1 = htime.getReal(t,3)
        local real tend2 = htime.getReal(t,4)
        local real during = 0.7
        if(tnow>=tend1+tend2+during)then
            call htime.delTimer(t)
            set t = null
            set ttg = null
            return
        endif
        set tnow = tnow + TimerGetTimeout(t)
        if(tnow<=tend1)then
            call SetTextTagTextBJ(ttg, getTtgMsg(ttg), size*(1+tnow/tend1))
        elseif(tnow>tend1+during)then
            call SetTextTagTextBJ(ttg, getTtgMsg(ttg), size*2-(5*(tnow-tend1-during)/tend2))
        endif
        call htime.setReal(t,2,tnow)
        set t = null
        set ttg = null
    endmethod

    //执行风格展示
    public static method style takes texttag ttg,string showtype,real xspeed,real yspeed returns nothing
        local timer t = null
        call SetTextTagVelocity( ttg, xspeed, yspeed )
        if(showtype == "scale")then //放大
            set t = htime.setInterval(0.03,function thistype.ttgshowScale)
            call htime.setTexttag(t,1,ttg)
            call htime.setReal(t,2,0)
            call htime.setReal(t,3,0.5)
            set t = null
        elseif(showtype == "shrink")then //缩小
            set t = htime.setInterval(0.03,function thistype.ttgshowShrink)
            call htime.setTexttag(t,1,ttg)
            call htime.setReal(t,2,0)
            call htime.setReal(t,3,0.5)
            set t = null
        elseif(showtype == "toggle")then //放大再缩小
            set t = htime.setInterval(0.03,function thistype.ttgshowToggle)
            call htime.setTexttag(t,1,ttg)
            call htime.setReal(t,2,0)
            call htime.setReal(t,3,0.2)
            call htime.setReal(t,4,0.2)
            set t = null
        endif
        set ttg = null
        set showtype = null
    endmethod
    //漂浮文字 - 默认 (在某单位头上)
    public static method ttg2Unit takes unit u,string msg,real size,string color,real opacity,real during,real zOffset returns texttag
        set hjass_global_texttag = createttg(msg,size,color,opacity,during)
        call SetTextTagPos( hjass_global_texttag , GetUnitX(u)-I2R(StringLength(msg))*size*0.5 , GetUnitY(u) , zOffset )
        set u = null
        set msg = null
        set color = null
        return hjass_global_texttag
    endmethod
    //漂浮文字 - 默认 (在某点上)
    public static method ttg2Loc takes location loc,string msg,real size,string color,real opacity,real during,real zOffset returns texttag
        set hjass_global_texttag = createttg(msg,size,color,opacity,during)
        call SetTextTagPos( hjass_global_texttag , GetLocationX(loc)-I2R(StringLength(msg))*size*0.5 , GetLocationY(loc) , zOffset )
        set loc = null
        set msg = null
        set color = null
        return hjass_global_texttag
    endmethod

    //漂浮文字 - 绑定在某单位头上，跟随移动(动作)
    private static method ttgBindUnitCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = htime.getUnit(t,1)
        local texttag ttg = htime.getTexttag(t,2)
        local real zOffset = htime.getReal(t,3)
        local string txt = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        local real scale = 0.5
        if(ttg==null)then
            call htime.delTimer(t)
            set t = null
            set u = null
            set ttg = null
            return
        endif
        if(hcamera.model=="zoomin")then
            set scale = 0.25
        elseif(hcamera.model=="zoomout")then
            set scale = 1
        endif
        call SetTextTagPos(ttg , GetUnitX(u)-StringLength(txt)*size*scale , GetUnitY(u) , zOffset )
        if( his.alive(u) == true ) then
            call SetTextTagVisibility( ttg , true )
        else
            call SetTextTagVisibility( ttg , false )
        endif
        set t = null
        set u = null
        set ttg = null
    endmethod
    //漂浮文字 - 绑定在某单位头上，跟随移动
    public static method ttgBindUnit takes unit u,string msg,real size,string color,real opacity,real zOffset returns texttag
        local timer t = null
        set hjass_global_texttag = ttg2Unit(u,msg,size,color,opacity,0,zOffset)
        set t = htime.setInterval( 0.03 , function thistype.ttgBindUnitCall )
        call htime.setUnit( t , 1 , u )
        call htime.setTexttag( t , 2 , hjass_global_texttag )
        call htime.setReal( t , 3 , zOffset )
        set t = null
        set u = null
        set msg = null
        set color = null
        return hjass_global_texttag
    endmethod

endstruct
