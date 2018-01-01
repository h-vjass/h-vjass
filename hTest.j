
library hTest

	private function inRect takes nothing returns nothing
		local string music = ""
		local integer i = GetRandomInt(1, 4)
		call hmsg.echo("getTriggerUnit=="+GetUnitName(evt.getTriggerUnit())+"进入了"+hrect.getName(evt.getTriggerRect()))
		if(i==1)then
			set music = gg_snd_Credits
		elseif(i==2)then
			set music = gg_snd_Credits
		elseif(i==3)then
			set music = gg_snd_Credits
		elseif(i==4)then
			set music = gg_snd_Credits
		endif
		call media.bgm2Player(music,GetOwningPlayer(evt.getTriggerUnit()))
	endfunction
	private function outRect takes nothing returns nothing
		call hmsg.echo("getTriggerUnit=="+GetUnitName(evt.getTriggerUnit())+"离开了"+hrect.getName(evt.getTriggerRect()))
	endfunction

	private function onattackready takes nothing returns nothing
		local unit u = evt.getTriggerUnit()
		call hmsg.echo(GetUnitName(u)+"发动了攻击")
	endfunction
	private function ondamage takes nothing returns nothing
		call hmsg.echo(GetUnitName(evt.getSourceUnit())+"造成了攻击伤害")
		call hmsg.echo("对"+GetUnitName(evt.getTargetUnit())+"造成1:"+R2S(evt.getDamage()))
		call hmsg.echo("对"+GetUnitName(evt.getTargetUnit())+"造成2:"+R2S(evt.getRealDamage()))
		call hmsg.echo(evt.getDamageKind())
		call hmsg.echo(evt.getDamageType())
	endfunction
	private function enteru takes nothing returns nothing
		local unit u = evt.getTriggerUnit()
		local unit eu = evt.getTriggerEnterUnit()
		local real range = evt.getRange()
		call hmsg.echo(GetUnitName(u)+"被进去了！")
		call hmsg.echo(GetUnitName(eu)+"进去了！")
		call hmsg.echo("range=="+R2S(range))
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

		//TODO TEST
		set u = hunit.createUnit(players[1],'H00B',Location(0,0))
		call attrExt.addHemophagia(u,25,0)
		//call attrExt.addSplit(u,50,0)
		//call attrExt.addHuntRebound(u,50,0)
		call attrExt.addCure(u,50,0)
		call attrExt.addAvoid(u,100,0)
		call attrExt.subKnocking(u,15000,0)
		call attr.addMove(u,500,60)
		//call attrEffect.coverSwim(u,10,0)
		//call attrEffect.coverSwimDuring(u,1.00,0)
		call hplayer.setHero(players[1],u)
		//call attr.addAttackSpeed(u,150,0)
		call attrExt.addPunishOppose(u,90,0)
		call evt.onAttackReady(u,function onattackready)
		call evt.onDamage(u,function ondamage)

		set u2 = hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		call SetUnitVertexColor( u2, 100, 45, 50, 255 )
		
		//call hunit.createUnits(10,Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,900))
		//call PanCameraToTimedLocForPlayer( players[1] , Location(0,0), 0 )
		
		call attrExt.addAvoid(u2,10,0)
		//call attrExt.addAim(u2,100,15)
		call attr.addDefend(u2,-19,0)
		//call attr.addAttackSpeed(u2,50,0)
		//call attr.addAttackPhysical(u2,1500,0)
		call attrEffect.coverBreak(u2,15,0)
		call attrEffect.coverBreakDuring(u2,0.300,0)

		call evt.onEnterUnitRange(u2,300,function enteru)

		//rect
		call wbean.create()
		set i=0
		loop
			exitwhen i>=3
				set j=0
				loop
					exitwhen j>=5
						set r = hrect.createInLoc(rx+1152*j,ry-1152*i,1152,1152)
						call hrect.setName(r,"平原"+I2S(i*j))
						call evt.onEnterRect(r,function inRect)
						call evt.onLeaveRect(r,function outRect)
						set wbean.loc = GetRectCenter(r)
						set wbean.width = 1152
						set wbean.height = 1152
						set rand = GetRandomInt(1,13)
						if(rand==1)then
 							call hweather.sun(wbean)
						elseif(rand==2)then
 							call hweather.moon(wbean)
						elseif(rand==3)then
 							call hweather.shield(wbean)
						elseif(rand==4)then
 							call hweather.rain(wbean)
						elseif(rand==5)then
 							call hweather.rainstorm(wbean)
						elseif(rand==6)then
 							call hweather.snow(wbean)
 						elseif(rand==7)then
 							call hweather.snowstorm(wbean)
						elseif(rand==8)then
 							call hweather.wind(wbean)
 						elseif(rand==9)then
 							call hweather.windstorm(wbean)
 						elseif(rand==10)then
 							call hweather.mistwhite(wbean)
 						elseif(rand==11)then
 							call hweather.mistgreen(wbean)
 						elseif(rand==12)then
 							call hweather.mistblue(wbean)
 						elseif(rand==13)then
 							call hweather.mistred(wbean)
						endif
					set j=j+1
				endloop
			set i=i+1
		endloop
		call wbean.destroy()

	endfunction

endlibrary