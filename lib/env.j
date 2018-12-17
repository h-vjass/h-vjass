//单位组
globals
hEnv henv
integer env_block = 'LTba'
integer env_cage = 'LOcg'
integer env_bucket1 = 'LTbr'
integer env_bucket2 = 'LTbx'
integer env_bucket3 = 'LTbs'
integer env_box = 'LTcr'
integer env_brust_bucket = 'LTex'
integer env_support_column = 'BTsc'
integer env_stone = 'LTrc'
integer env_stone_red = 'DTrc'
integer env_stone_ice = 'ITcr'
integer env_ice1 = 'ITf1'
integer env_ice2 = 'ITf2'
integer env_ice3 = 'ITf3'
integer env_ice4 = 'ITf4'
integer env_spider_eggs = 'DTes'
integer env_volcano = 'Volc' // 火山
integer env_tree_summer = 'LTlt'
integer env_tree_autumn = 'FTtw'
integer env_tree_winter = 'WTtw'
integer env_tree_winter_show = 'WTst'
integer env_tree_dark = 'NTtw' // 枯枝
integer env_tree_dark_umbrella = 'NTtc' // 伞
integer env_tree_poor = 'BTtw' // 贫瘠
integer env_tree_poor_umbrella = 'BTtc' // 伞
integer env_tree_ruins = 'ZTtw' // 遗迹
integer env_tree_ruins_umbrella = 'ZTtc' // 伞
integer env_tree_fire = 'ZTtw' // 炼狱
integer env_tree_underground1 = 'DTsh' // 地下城
integer env_tree_underground2 = 'GTsh' // 地下城

integer env_ground_summer = 'Adrg'
integer env_ground_autumn = 'Ydtr'
integer env_ground_winter = 'Agrs'
integer env_ground_winter_show = 'Agrs'
integer env_ground_dark = 'Xblm'
integer env_ground_poor = 'Adrd'
integer env_ground_ruins = 'Xhdg'
integer env_ground_fire = 'Yblm'
integer env_ground_underground = 'Yrtl'

group env_u_group = CreateGroup()
integer env_u_ice1 = 'n00K'
integer env_u_ice2 = 'n00J'
integer env_u_ice3 = 'n00H'
integer env_u_ice4 = 'n00I'
integer env_u_fire_hole = 'n00U'
integer env_u_break_column1 = 'n00L'
integer env_u_break_column2 = 'n00M'
integer env_u_burn_build = 'n00T'
integer env_u_burn_body = 'n00V'
integer env_u_rune1 = 'n00O'
integer env_u_rune2 = 'n00P'
integer env_u_rune3 = 'n00Q'
integer env_u_bone1 = 'n00R'
integer env_u_bone2 = 'n00S'
integer env_u_fire = 'n00N'
integer env_u_stone_show1 = 'n00D'
integer env_u_stone_show2 = 'n00E'
integer env_u_stone_show3 = 'n00G'
integer env_u_mushroom1 = 'n00W'
integer env_u_mushroom2 = 'n00X'
integer env_u_mushroom3 = 'n00Y'
integer env_u_flower1 = 'n005'
integer env_u_flower2 = 'n007'
integer env_u_flower3 = 'n008'
integer env_u_flower4 = 'n009'
integer env_u_flower5 = 'n00A'
integer env_u_typha1 = 'n00B'
integer env_u_typha2 = 'n00C'

endglobals

type EnvUnit extends integer array[20] // 最大支持20种单位
type EnvDestructable extends integer array[10] // 最大支持10种可破坏物

struct hEnv

	private static method removeEnumDestructable takes nothing returns nothing
		call RemoveDestructable( GetEnumDestructable() )
	endmethod

	private static method build takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local real rectStartX = htime.getReal(t,1)
		local real rectStartY = htime.getReal(t,2)
		local real rectEndX = htime.getReal(t,3)
		local real rectEndY = htime.getReal(t,4)
		local real excludeX = htime.getReal(t,5)
		local real excludeY = htime.getReal(t,6)
		local integer euQty = htime.getInteger(t,7)
		local integer edQty = htime.getInteger(t,8)
		local integer indexX = htime.getInteger(t,9)
		local integer indexY = htime.getInteger(t,10)
		local boolean clear = htime.getBoolean(t,11)
		local rect whichRect = htime.getRect(t,12)
		local integer whichGround = htime.getInteger(t,13)
		local integer uid = htime.getInteger(t,100+GetRandomInt(1,euQty))
		local integer did = htime.getInteger(t,200+GetRandomInt(1,edQty))
		local real midX = (rectEndX-rectStartX) * 0.5
		local real midY = (rectEndY-rectStartY) * 0.5
		local real x = rectStartX + indexX * 80
		local real y = rectStartY + indexY * 80
		local integer buildType = GetRandomInt(1,4)

		if(x >= rectEndX and y >= rectEndY) then
			call htime.delTimer(t)
			if (clear) then
				call RemoveRect( whichRect )
				set whichRect = null
			endif
			return
		endif
		if(uid <= 0 and did <= 0) then
			call htime.delTimer(t)
			if (clear) then
				call RemoveRect( whichRect )
				set whichRect = null
			endif
			return
		endif

		if(x >= rectEndX ) then
			call htime.setInteger(t,10,1+indexY)
			set indexX = -1
		endif
		if(y >= rectEndY ) then
			set indexY = -1
		endif
		call htime.setInteger(t,9,1+indexX)
		if(hlogic.rabs(x-midX) < (excludeX*0.5) and hlogic.rabs(y-midY) < (excludeY*0.5))then
			return
		endif
		//
		if(buildType == 1 and uid <= 0)then
			set buildType = 2
		endif
		if(buildType == 2 and did <= 0)then
			set buildType = -1
		endif
		if(buildType == -1)then
			return
		endif
		//
		if(buildType == 1)then
			call GroupAddUnit(env_u_group,hunit.createUnitXY(players[12], uid, x,y))
		elseif(buildType == 2)then
			call SetDestructableInvulnerable( CreateDestructable(did, x , y, GetRandomDirectionDeg(), GetRandomReal(0.5,1.1), 0 ), true )
			if(whichGround > 0)then
				call SetTerrainType( x , y, whichGround, -1, 1, 0 )
			endif
		endif
	endmethod

	public static method clearUnits takes nothing returns nothing
		local unit tempUnit = null
		loop
			exitwhen(hgroup.isEmpty(env_u_group) == true)
				set tempUnit = FirstOfGroup(env_u_group)
				call hunit.del(tempUnit,0)
				call GroupRemoveUnit( env_u_group , tempUnit )
		endloop
		call GroupClear( env_u_group )
	endmethod

	public static method removeInRect takes rect whichRect returns nothing
		if(whichRect != null)then
			call EnumDestructablesInRectAll(whichRect, function thistype.removeEnumDestructable )
		endif
	endmethod

	public static method removeInRange takes real x,real y,real width,real height returns nothing
		local rect whichRect = hrect.createInLoc(x,y,width,height)
		call EnumDestructablesInRectAll(whichRect, function thistype.removeEnumDestructable )
		call hrect.del(whichRect)
	endmethod

	public static method random takes rect whichRect,EnvUnit whichUnit,EnvDestructable whichDestructable,integer whichGround,real excludeX,real excludeY,boolean clear returns nothing
		local integer i = 0
		local real rectStartX = hrect.getStartX(whichRect)
		local real rectStartY = hrect.getStartY(whichRect)
		local real rectEndX = hrect.getEndX(whichRect)
		local real rectEndY = hrect.getEndY(whichRect)
		local integer euQty = 0
		local integer edQty = 0
		local timer t = null
		call EnumDestructablesInRectAll(whichRect, function thistype.removeEnumDestructable )
		set i = 1
	    loop
	        exitwhen i > 10
	        	if( whichUnit[i] <= 0 ) then
					call DoNothing() YDNL exitwhen true
	        	else
					set euQty = euQty+1
	        	endif
	        set i = i + 1
	    endloop
		set i = 1
	    loop
	        exitwhen i > 10
	        	if( whichDestructable[i] <= 0 ) then
					call DoNothing() YDNL exitwhen true
	        	else
					set edQty = edQty+1
	        	endif
	        set i = i + 1
	    endloop
		if(euQty>0 or edQty>0)then
			set t = htime.setInterval(0.01,function thistype.build)
			call htime.setReal(t,1,rectStartX)
			call htime.setReal(t,2,rectStartY)
			call htime.setReal(t,3,rectEndX)
			call htime.setReal(t,4,rectEndY)
			call htime.setReal(t,5,excludeX)
			call htime.setReal(t,6,excludeY)
			call htime.setInteger(t,7,euQty)
			call htime.setInteger(t,8,edQty)
			call htime.setInteger(t,9,-1)
			call htime.setInteger(t,10,-1)
			call htime.setBoolean(t,11,clear)
			call htime.setRect(t,12,whichRect)
			call htime.setInteger(t,13,whichGround)
			set i = euQty
			loop
				exitwhen i <= 0
					call htime.setInteger(t,100+i,whichUnit[i])
				set i = i - 1
			endloop
			set i = edQty
			loop
				exitwhen i <= 0
					call htime.setInteger(t,200+i,whichDestructable[i])
				set i = i - 1
			endloop
		endif
		call whichUnit.destroy()
		call whichDestructable.destroy()
	endmethod

	private static method randomDefault takes rect whichRect,string typeStr,real excludeX,real excludeY,boolean clear returns nothing
		local EnvUnit whichUnit = EnvUnit.create()
		local EnvDestructable whichDestructable = EnvDestructable.create()
		local integer whichGround = 0
		if(typeStr == "summer")then
			set whichGround = env_ground_summer
			set whichUnit[1] = env_u_flower1
			set whichUnit[2] = env_u_flower2
			set whichUnit[3] = env_u_flower3
			set whichUnit[4] = env_u_flower4
			set whichUnit[5] = env_u_flower5
			set whichUnit[6] = 0
			set whichDestructable[1] = env_tree_summer
			set whichDestructable[2] = env_block
			set whichDestructable[3] = env_bucket1
			set whichDestructable[4] = env_bucket2
			set whichDestructable[5] = env_bucket3
			set whichDestructable[6] = env_stone
			set whichDestructable[7] = 0
		elseif(typeStr == "autumn")then
			set whichGround = env_ground_autumn
			set whichUnit[1] = env_u_flower1
			set whichUnit[2] = env_u_typha1
			set whichUnit[3] = env_u_typha2
			set whichUnit[4] = 0
			set whichDestructable[1] = env_tree_autumn
			set whichDestructable[2] = env_box
			set whichDestructable[3] = env_bucket1
			set whichDestructable[4] = env_bucket2
			set whichDestructable[5] = env_stone_red
			set whichDestructable[6] = env_cage
			set whichDestructable[7] = env_support_column
			set whichDestructable[8] = 0
		elseif(typeStr == "winter")then
			set whichGround = env_ground_winter
			set whichUnit[1] = env_u_stone_show1
			set whichUnit[2] = env_u_stone_show2
			set whichUnit[3] = env_u_stone_show3
			set whichUnit[4] = 0
			set whichDestructable[1] = env_tree_winter
			set whichDestructable[2] = env_tree_winter_show
			set whichDestructable[3] = env_cage
			set whichDestructable[4] = env_stone_ice
			set whichDestructable[5] = 0
		elseif(typeStr == "winterShow")then
			set whichGround = env_ground_winter
			set whichUnit[1] = env_u_ice1
			set whichUnit[2] = env_u_ice2
			set whichUnit[3] = env_u_ice3
			set whichUnit[4] = env_u_ice4
			set whichUnit[5] = 0
			set whichDestructable[1] = env_tree_winter_show
			set whichDestructable[2] = env_cage
			set whichDestructable[3] = env_stone_ice
			set whichDestructable[4] = 0
		elseif(typeStr == "dark")then
			set whichGround = env_ground_dark
			set whichUnit[1] = env_u_rune1
			set whichUnit[2] = env_u_rune2
			set whichUnit[3] = env_u_rune3
			set whichUnit[4] = 0
			set whichDestructable[1] = env_tree_dark
			set whichDestructable[2] = env_tree_dark_umbrella
			set whichDestructable[3] = env_cage
			set whichDestructable[4] = 0
		elseif(typeStr == "poor")then
			set whichGround = env_ground_poor
			set whichUnit[1] = env_u_bone1
			set whichUnit[2] = env_u_bone2
			set whichUnit[3] = 0
			set whichDestructable[1] = env_tree_poor
			set whichDestructable[2] = env_tree_poor_umbrella
			set whichDestructable[3] = env_cage
			set whichDestructable[4] = env_box
			set whichDestructable[5] = 0
		elseif(typeStr == "ruins")then
			set whichGround = env_ground_ruins
			set whichUnit[1] = env_u_break_column1
			set whichUnit[2] = env_u_break_column2
			set whichUnit[3] = 0
			set whichDestructable[1] = env_tree_ruins
			set whichDestructable[2] = env_tree_ruins_umbrella
			set whichDestructable[3] = env_cage
			set whichDestructable[4] = 0
		elseif(typeStr == "fire")then
			set whichGround = env_ground_fire
			set whichUnit[1] = env_u_burn_body
			set whichUnit[2] = env_u_burn_build
			set whichUnit[3] = 0
			set whichDestructable[1] = env_tree_fire
			set whichDestructable[2] = env_volcano
			set whichDestructable[3] = env_stone_red
			set whichDestructable[4] = 0
		elseif(typeStr == "underground")then
			set whichGround = env_ground_underground
			set whichUnit[1] = env_u_mushroom1
			set whichUnit[2] = env_u_mushroom2
			set whichUnit[3] = env_u_mushroom3
			set whichUnit[4] = 0
			set whichDestructable[1] = env_tree_underground1
			set whichDestructable[2] = env_tree_underground2
			set whichDestructable[3] = env_spider_eggs
			set whichDestructable[4] = 0
		endif
		call thistype.random(whichRect,whichUnit,whichDestructable,whichGround,excludeX,excludeY,clear)
		call whichUnit.destroy()
		call whichDestructable.destroy()
	endmethod

	public static method randomSummer takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "summer", excludeX, excludeY, clear)
	endmethod

	public static method randomAutumn takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "autumn", excludeX, excludeY, clear)
	endmethod

	public static method randomWinter takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "winter", excludeX, excludeY, clear)
	endmethod

	public static method randomWinterShow takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "winterShow", excludeX, excludeY, clear)
	endmethod

	public static method randomDark takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "dark", excludeX, excludeY, clear)
	endmethod

	public static method randomPoor takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "poor", excludeX, excludeY, clear)
	endmethod

	public static method randomRuins takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "ruins", excludeX, excludeY, clear)
	endmethod

	public static method randomFire takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "fire", excludeX, excludeY, clear)
	endmethod

	public static method randomUnderground takes rect whichRect,real excludeX,real excludeY,boolean clear returns nothing
		call randomDefault(whichRect, "underground", excludeX, excludeY, clear)
	endmethod

endstruct
