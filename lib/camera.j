
globals
    hCamera hcamera
endglobals

struct hCamera

	public static string model = "normal"

	//重置镜头
	public static method reset takes player whichPlayer,real during returns nothing
		if(whichPlayer==null or GetLocalPlayer()==whichPlayer)then
			call ResetToGameCamera(during)
		endif
	endmethod

	//应用镜头
	public static method apply takes camerasetup cs,player whichPlayer,real during returns nothing
		if(whichPlayer==null or GetLocalPlayer()==whichPlayer)then
			call CameraSetupApplyForceDuration( cs , true, during )
		endif
	endmethod

	//移动到XY
	public static method toXY takes real x,real y,player whichPlayer,real during returns nothing
		if(whichPlayer==null or GetLocalPlayer()==whichPlayer)then
			call PanCameraToTimed(x, y, during)
		endif
	endmethod

	//移动到点
	public static method toLoc takes location loc,player whichPlayer,real during returns nothing
		call toXY(GetLocationX(loc),GetLocationY(loc),whichPlayer,during)
	endmethod

	//锁定镜头
	public static method lock takes player whichPlayer,unit whichUnit returns nothing
		if(whichPlayer==null or GetLocalPlayer()==whichPlayer)then
			call SetCameraTargetController(whichUnit, 0, 0, false)
		endif
	endmethod

	//设定镜头距离
	public static method zoom takes real distance returns nothing
		call SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, distance, 0 )
	endmethod

	/**
     * 玩家镜头摇晃回调
     * 镜头源
     */
    private static method shakeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local player whichPlayer = htime.getPlayer(t,1)
        if (GetLocalPlayer() == whichPlayer) then
            call CameraSetTargetNoise(0, 0)
        endif
		call SaveBoolean( hash_player, GetHandleId(whichPlayer) , 15222 ,false )
        call htime.delTimer(t)
    endmethod

    /**
     * 玩家镜头摇晃
     * @param scale 振幅 - 摇晃
     */
    public static method shake takes player whichPlayer,real during,real scale returns nothing
        local timer t
        if(whichPlayer==null) then
            return
        endif
        if( during == null ) then
            set during = 0.10   //假如没有设置时间，默认0.10秒意思意思一下
        endif
        if( scale == null ) then
            set scale = 5.00   //假如没有振幅，默认5.00意思意思一下
        endif
        //镜头动作降噪
        if( LoadBoolean( hash_player, GetHandleId(whichPlayer) , 15222 ) == true ) then
            return
        else
			call SaveBoolean( hash_player, GetHandleId(whichPlayer) , 15222 ,true )
        endif
        call CameraSetTargetNoiseForPlayer( whichPlayer , scale , 1.00 )    //0.50为速率
        set t = htime.setTimeout( during ,function thistype.shakeCall)
        call htime.setPlayer(t,1,whichPlayer)
    endmethod

    /**
     * 玩家镜头震动回调（其实这个函数应该写在funcs里，理由同摇晃）
     */
    private static method quakeCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local player whichPlayer = htime.getPlayer(t,1)
        call CameraClearNoiseForPlayer( whichPlayer )
        call SaveBoolean( hash_player, GetHandleId(whichPlayer) , 15222 ,false )
        call htime.delTimer(t)
    endmethod

    /**
     * 玩家镜头震动
     * @param scale 振幅 - 震动
     */
    public static method quake takes player whichPlayer,real during,real scale returns nothing
        local timer t
        if(whichPlayer==null) then
            return
        endif
        if( during == null ) then
            set during = 0.10   //假如没有设置时间，默认0.10秒意思意思一下
        endif
        if( scale == null ) then
            set scale = 5.00   //假如没有振幅，默认5.00意思意思一下
        endif
        //镜头动作降噪
		if( LoadBoolean( hash_player, GetHandleId(whichPlayer) , 15222 ) == true ) then
            return
        else
			call SaveBoolean( hash_player, GetHandleId(whichPlayer) , 15222 ,true )
        endif
        call CameraSetEQNoiseForPlayer( whichPlayer , scale )
        set t = htime.setTimeout( during ,function thistype.quakeCall)
        call htime.setPlayer(t,1,whichPlayer)
    endmethod

	//镜头模式集
	private static method modelLock takes nothing returns nothing
		local integer i = 1
		local integer j = 0
		local integer jmax = 0
		local unit firstHero = null
		loop
			exitwhen i>player_max_qty
				set j = 1
				set jmax = hhero.getPlayerUnitQty(players[i])
				loop
					exitwhen j>jmax or firstHero!=null
						set firstHero = hhero.getPlayerUnit(players[i],j)
					set j=j+1
				endloop
				if(firstHero!=null and his.alive(firstHero)==true and GetLocalPlayer()==players[i])then
					call lock(players[i],firstHero)
				else
					call reset(players[i],0)
				endif
				set firstHero = null
			set i=i+1
		endloop
	endmethod
	private static method zoomModel takes nothing returns nothing
		local timer t = GetExpiredTimer()
		call SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, htime.getReal(t,1), 0 )
	endmethod
	//镜头模式
	public static method setModel takes string model returns nothing
		local timer t = null
		if(model=="normal")then
			//nothing
		elseif(model=="lock")then
			set t = htime.setInterval(0.1,function thistype.modelLock)
		elseif(model=="zoomin")then
			set t = htime.setInterval(0.1,function thistype.zoomModel)
			call htime.setReal(t,1,825)
			set MAX_MOVE_SPEED = MAX_MOVE_SPEED*2
		elseif(model=="zoomout")then
			set t = htime.setInterval(0.1,function thistype.zoomModel)
			call htime.setReal(t,1,3300)
		else
			return
		endif
		set thistype.model = model
	endmethod
	//获取当前镜头模式
	public static method getModel takes nothing returns string
		return thistype.model
	endmethod

endstruct
