
library hTest needs hmb

	private function inRect takes nothing returns nothing
		local string music = ""
		local integer i = GetRandomInt(1, 4)
		if(i==1)then
			set music = gg_snd_Credits
		elseif(i==2)then
			set music = gg_snd_Credits
		elseif(i==3)then
			set music = gg_snd_Credits
		elseif(i==4)then
			set music = gg_snd_Credits
		endif
		call media.bgmPlay(music)
	endfunction

	public function run takes nothing returns nothing

		local unit u = null
		local unit u2 = null
		local rect r = null
		local real rx = -256
		local real ry = 6016
		local hWeatherBean wbean = 0
		local integer i=0
		local integer j=0
		local integer rand=0
		local trigger tger = CreateTrigger()
		call TriggerAddAction(tger, function inRect)

		//TODO TEST
		set u = hunit.createUnit(players[1],'H00B',Location(0,0))
		call hAttrExt_addHemophagia(u,25,0)
		call hAttrExt_addSplit(u,50,0)
		call hAttrExt_addHuntRebound(u,50,0)
		call hAttrExt_addCure(u,50,0)
		call hAttrExt_addAvoid(u,80,30)
		call hAttrEffect_coverSwim(u,80,0)
		call hAttrEffect_coverSwimDuring(u,5.00,0)
		call hplayer.setHero(players[1],u)
		call hAttr_addAttackSpeed(u,100,0)

		set u2 = hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		call SetUnitVertexColor( u2, 100, 45, 50, 255 )
		/*
		call hunit.createUnits(10,Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,900))
		call PanCameraToTimedLocForPlayer( players[1] , Location(0,0), 0 )
		*/
		call hAttrExt_addAvoid(u2,50,0)
		call hAttrExt_addAim(u2,100,15)

		//rect
		call wbean.create()
		set i=0
		loop
			exitwhen i>=3
				set j=0
				loop
					exitwhen j>=5
						set r = hrect.createInLoc(rx+1152*j,ry-1152*i,1152,1152)
						call TriggerRegisterEnterRectSimple( tger, r )
						set wbean.loc = GetRectCenter(r)
						set wbean.width = 1152
						set wbean.height = 1152
						set rand = GetRandomInt(1,13)
						if(rand==1)then
 							call hWeather_sun(wbean)
						elseif(rand==2)then
 							call hWeather_moon(wbean)
						elseif(rand==3)then
 							call hWeather_shield(wbean)
						elseif(rand==4)then
 							call hWeather_rain(wbean)
						elseif(rand==5)then
 							call hWeather_rainstorm(wbean)
						elseif(rand==6)then
 							call hWeather_snow(wbean)
 						elseif(rand==7)then
 							call hWeather_snowstorm(wbean)
						elseif(rand==8)then
 							call hWeather_wind(wbean)
 						elseif(rand==9)then
 							call hWeather_windstorm(wbean)
 						elseif(rand==10)then
 							call hWeather_mistwhite(wbean)
 						elseif(rand==11)then
 							call hWeather_mistgreen(wbean)
 						elseif(rand==12)then
 							call hWeather_mistblue(wbean)
 						elseif(rand==13)then
 							call hWeather_mistred(wbean)
						endif
					set j=j+1
				endloop
			set i=i+1
		endloop
		call wbean.destroy()

	endfunction

endlibrary