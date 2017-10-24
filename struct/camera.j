
globals
    hCamera camera = 0
endglobals

struct hCamera

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

	/* 镜头模式集 */
	private static method modelLock takes nothing returns nothing
		local integer i = 1
		local unit whichUnit = null
		loop
			exitwhen i>player_max_qty
				set whichUnit = hplayer.getHero(players[i])
				if(whichUnit!=null and is.alive(whichUnit)==true and GetLocalPlayer()==players[i])then
					call lock(players[i],whichUnit)
				else
					call reset(players[i],0)
				endif
				set whichUnit = null
			set i=i+1
		endloop
	endmethod
	private static method zoomModel takes nothing returns nothing
		local timer t = GetExpiredTimer()
		call SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, time.getReal(t,1), 0 )
	endmethod
	//镜头模式
	public static method setModel takes string model returns nothing
		local timer t = null
		if(model=="lock")then
			set t = time.setInterval(0.1,function hCamera.modelLock)
		elseif(model=="zoomin")then
			set t = time.setInterval(0.1,function hCamera.zoomModel)
			call time.setReal(t,1,825)
		elseif(model=="zoomout")then
			set t = time.setInterval(0.1,function hCamera.zoomModel)
			call time.setReal(t,1,3300)
		endif
	endmethod


endstruct
