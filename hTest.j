
struct hTest

	private static method inRect takes nothing returns nothing
		local string music = ""
		local integer i = GetRandomInt(1, 4)
		call hmsg.echo("getTriggerUnit=="+GetUnitName(hevt.getTriggerUnit())+"进入了"+hrect.getName(hevt.getTriggerRect()))
		if(i==1)then
			set music = gg_snd_Credits
		elseif(i==2)then
			set music = gg_snd_Credits
		elseif(i==3)then
			set music = gg_snd_Credits
		elseif(i==4)then
			set music = gg_snd_Credits
		endif
		call hmedia.bgm2Player(music,GetOwningPlayer(hevt.getTriggerUnit()))
	endmethod
	private static method outRect takes nothing returns nothing
		call hmsg.echo("getTriggerUnit=="+GetUnitName(hevt.getTriggerUnit())+"离开了"+hrect.getName(hevt.getTriggerRect()))
	endmethod

	private static method onattackready takes nothing returns nothing
		local unit u = hevt.getTriggerUnit()
		call hmsg.echo(GetUnitName(u)+"发动了攻击")
	endmethod
	private static method ondamage takes nothing returns nothing
		call hmsg.echo(GetUnitName(hevt.getSourceUnit())+"造成了攻击伤害")
		call hmsg.echo("对"+GetUnitName(hevt.getTargetUnit())+"进入伤害"+R2S(hevt.getDamage()))
		call hmsg.echo("对"+GetUnitName(hevt.getTargetUnit())+"真实伤害:"+R2S(hevt.getRealDamage()))
		call hmsg.echo(hevt.getDamageKind())
		call hmsg.echo(hevt.getDamageType())
	endmethod
	private static method enteru takes nothing returns nothing
		local unit u = hevt.getTriggerUnit()
		local unit eu = hevt.getTriggerEnterUnit()
		local real range = hevt.getRange()
		call hmsg.echo(GetUnitName(u)+"被进去了！")
		call hmsg.echo(GetUnitName(eu)+"进去了！")
		call hmsg.echo("range=="+R2S(range))
	endmethod

	public static method run takes nothing returns nothing

		local unit u = null
		local unit u2 = null
		local rect r = null
		local real rx = -256
		local real ry = 6016
		local hWeatherBean wbean = hWeatherBean.create()
		local integer i=0
		local integer j=0
		local integer rand=0

		//TODO TEST
		set u = hunit.createUnit(players[1],'H00B',Location(0,0))
		call hplayer.setHero(players[1],u,"")
		//测试吸血
		//call hattr.addHemophagia(u,25,0)
		//测试眩晕
		//call hattrEffect.setSwimOdds(u,30,0)
		//call hattrEffect.setSwimDuring(u,1.00,0)
		//测试攻击特效
		call hattr.addAttackHuntType(u,"fire",10)
		call hattr.addAttackHuntType(u,"water",20)
		call hattr.addAttackHuntType(u,"thunder",30)
		call hattr.addSplit(u,25,0)
		call hattr.addSplitRange(u,500,0)
		call hattr.addMana(u,10000,0)
		call hattr.addManaBack(u,1000,0)
		call hattrEffect.setLifeBackVal(u,1.10,0)
		call hattrEffect.setLifeBackDuring(u,10.00,0)
		call hattrEffect.setManaBackVal(u,1.20,0)
		call hattrEffect.setManaBackDuring(u,10.00,0)
		call hattrEffect.setAttackSpeedVal(u,1.30,0)
		call hattrEffect.setAttackSpeedDuring(u,10.00,0)
		call hattrEffect.setPoisonVal(u,1.30,0)
		call hattrEffect.setPoisonDuring(u,10.00,0)
		call hattrEffect.setFireVal(u,1.30,0)
		call hattrEffect.setFireDuring(u,10.00,0)
		call hattrEffect.setBombVal(u,50,0)
		call hattrEffect.setBombRange(u,300.00,0)
		//call hattrEffect.setFetterOdds(u,50,0)
		//call hattrEffect.setFetterDuring(u,10.00,0)
		//call hattrEffect.setFreezeVal(u,50,0)
		//call hattrEffect.setFreezeDuring(u,10,0)
		//call hattrEffect.setColdVal(u,50,0)
		//call hattrEffect.setColdDuring(u,10,0)
		call hAttrNatural.setFire(u,300,0)

		call hevt.onAttackReady(u,function thistype.onattackready)
		call hevt.onDamage(u,function thistype.ondamage)

		call hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		call hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		call hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		call hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		set u2 = hunit.createUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'n00F',Location(0,0))
		call SetUnitVertexColor( u2, 100, 45, 50, 255 )
		call hattr.addLife(u2,50000,0)
		call hattr.addAvoid(u2,30,0)
		call hattr.addDefend(u2,-19,0)
		//call hattrEffect.setSilentOdds(u2,5,0)
		//call hattrEffect.setSilentDuring(u2,5.00,0)
		//call hattrEffect.setUnarmOdds(u2,5,0)
		//call hattrEffect.setUnarmDuring(u2,10.00,0)

		call hevt.onEnterUnitRange(u2,300,function thistype.enteru)

		//rect
		set i=0
		loop
			exitwhen i>=3
				set j=0
				loop
					exitwhen j>=5
						set r = hrect.createInLoc(rx+1152*j,ry-1152*i,1152,1152)
						call hrect.setName(r,"平原"+I2S(i*j))
						call hevt.onEnterRect(r,function thistype.inRect)
						call hevt.onLeaveRect(r,function thistype.outRect)
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

	endmethod

endstruct