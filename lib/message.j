/* 消息 */
library hMsg initializer init needs hPlayer

    globals

        hashtable hash = null

    endglobals

    //在屏幕打印信息给所有玩家
    public function echo takes string msg returns nothing
        call DisplayTextToForce( GetPlayersAll(), msg)
    endfunction
    public function print takes string msg returns nothing
        call echo(msg)
    endfunction


    //在屏幕(x.y)处打印信息给某玩家
    public function echoTo takes player whichPlayer,string msg,real x,real y,real duration returns nothing
        if(duration<5)then
            call DisplayTextToPlayer( whichPlayer, x, y, msg)
        else
            call DisplayTimedTextToPlayer( whichPlayer, x, y, duration, msg)
        endif
    endfunction
    public function printTo takes player whichPlayer,string msg,real x,real y,real duration returns nothing
        call echoTo( whichPlayer, msg , x, y, duration)
    endfunction



    //删除漂浮字
    public function delttg takes texttag ttg returns nothing
        call DestroyTextTag( ttg )
    endfunction
    //创建漂浮字
    //*设置during为0则永久显示
    //*color为6位颜色代码
    private function createttg takes string msg,real size,string color,real opacity,real during returns texttag
        local texttag ttg = CreateTextTag()
        if(msg==null or msg == "" or size<0 or opacity>=100 or opacity<0 or during<=0)then
            return null
        endif
        if(StringLength(color)==6)then
            call SetTextTagTextBJ(ttg, "|cff"+color+msg+"|r", size)
        else
            call SetTextTagTextBJ(ttg, msg, size)
        endif
        call SetTextTagTextBJ(ttg, msg, size)
        call SaveStr(hash, GetHandleId(ttg), 1, msg)
        call SaveReal(hash, GetHandleId(ttg), 2, size)
        call SaveStr(hash, GetHandleId(ttg), 3, color)
        call SetTextTagColorBJ(ttg, 100.00, 100.00, 100.00, opacity)
        if(during==0)then
            call SetTextTagPermanent( ttg, true )
        else
            call SetTextTagPermanent( ttg, false )
            call SetTextTagLifespan( ttg, during)
            call SetTextTagFadepoint( ttg, during)
        endif
        return ttg
    endfunction
    //获取漂浮字初始文本
    public function getTtgMsg takes texttag ttg returns string
        return LoadStr(hash, GetHandleId(ttg), 1)
    endfunction
    //获取漂浮字大小
    public function getTtgSize takes texttag ttg returns real
        return LoadReal(hash, GetHandleId(ttg), 2)
    endfunction
    //获取漂浮字颜色
    public function getTtgColor takes texttag ttg returns string
        return LoadStr(hash, GetHandleId(ttg), 3)
    endfunction
    //设置漂浮字弹出样式
    private function ttgshowScale takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = hTimer_getTexttag(t,1)
        local string msg = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        local real tnow = hTimer_getReal(t,2)
        local real tend = hTimer_getReal(t,3)
        if(tnow>=tend)then
            call hTimer_delTimer(t,null)
        endif
        set tnow = tnow + TimerGetTimeout(t)
        call SetTextTagTextBJ(ttg, msg, size*(1+tnow/tend))
        call hTimer_setReal(t,2,tnow)
    endfunction
    private function ttgshowToggle takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local texttag ttg = hTimer_getTexttag(t,1)
        local string msg = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        local real tnow = hTimer_getReal(t,2)
        local real tend1 = hTimer_getReal(t,3)
        local real tend2 = hTimer_getReal(t,4)
        if(tnow>=tend2)then
            call hTimer_delTimer(t,null)
        endif
        set tnow = tnow + TimerGetTimeout(t)
        if(tnow<=tend1)then
            call SetTextTagTextBJ(ttg, msg, size*(1+tnow/(tend1+tend2)*(1/(tend1/(tend1+tend2)))))
        else
            call SetTextTagTextBJ(ttg, msg, size*(1-tnow/(tend1+tend2)*(1/(tend2/(tend1+tend2)))))
        endif
        call hTimer_setReal(t,2,tnow)
    endfunction
    public function style takes texttag ttg,string showtype,real xspeed,real yspeed returns nothing
        local timer t = null
        call SetTextTagVelocity( ttg, xspeed, yspeed )
        if(showtype == "scale")then //瞬间放大
            set t = hTimer_setInterval(0.03,function ttgshowScale)
            call hTimer_setTexttag(t,1,ttg)
            call hTimer_setReal(t,2,0)
            call hTimer_setReal(t,3,0.5)
        elseif(showtype == "toggle")then //放大再缩小
            set t = hTimer_setInterval(0.03,function ttgshowToggle)
            call hTimer_setTexttag(t,1,ttg)
            call hTimer_setReal(t,2,0)
            call hTimer_setReal(t,3,0.2)
            call hTimer_setReal(t,4,0.3)
        endif
    endfunction
    //漂浮文字 - 默认 (在某单位头上)
    public function ttg2Unit takes unit u,string msg,real size,string color,real opacity,real during,real zOffset returns texttag
        local texttag ttg = createttg(msg,size,color,opacity,during)
        call SetTextTagPos( ttg , GetUnitX(u)-I2R(StringLength(msg))*size*0.5 , GetUnitY(u) , zOffset )
        return ttg
    endfunction
    //漂浮文字 - 默认 (在某点上)
    public function ttg2Loc takes location loc,string msg,real size,string color,real opacity,real during,real zOffset returns texttag
        local texttag ttg = createttg(msg,size,color,opacity,during)
        call SetTextTagPos( ttg , GetLocationX(loc)-I2R(StringLength(msg))*size*0.5 , GetLocationY(loc) , zOffset )
        return ttg
    endfunction
    //漂浮文字 - 绑定在某单位头上，跟随移动(动作)
    private function ttgBindUnitCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = hTimer_getUnit( t , 1 )
        local texttag ttg = hTimer_getTexttag( t , 2 )
        local real zOffset = hTimer_getReal( t , 3 )
        local string msg = getTtgMsg(ttg)
        local real size = getTtgSize(ttg)
        if( hIs_alive(u) == true ) then
            call SetTextTagPos( ttg , GetUnitX(u)-I2R(StringLength(msg))*size*0.5 , GetUnitY(u) , zOffset )
            call SetTextTagVisibility( ttg , true )
        else
            call SetTextTagVisibility( ttg , false )
        endif
    endfunction
    //漂浮文字 - 绑定在某单位头上，跟随移动
    public function ttgBindUnit takes unit u,string msg,real size,string color,real opacity,real zOffset returns texttag
        local texttag ttg =  ttg2Unit(u,msg,size,color,opacity,0,zOffset)
        local timer t = hTimer_setInterval( 0.05 , function ttgBindUnitCall )
        call hTimer_setUnit( t , 1 , u )
        call hTimer_setTexttag( t , 2 , ttg )
        call hTimer_setReal( t , 3 , zOffset )
        return ttg
    endfunction
    
    private function init takes nothing returns nothing
        set hash = InitHashtable()
    endfunction

endlibrary

