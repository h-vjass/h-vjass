library hSpeed

	globals
		private constant real PERIOD = 0.03125000
	endglobals


	private module O 
		private static method onInit takes nothing returns nothing
			call TimerStart(CreateTimer(), PERIOD, true, function thistype.iterate)
		endmethod
	endmodule


	struct ModSpeed extends array
		private thistype recycle
		private static integer ic = 0 //instance count
		readonly thistype next
		readonly thistype prev
		readonly unit u
		private real x
		private real y
		readonly real setspeed
		private real bonus


		private static real tempx
		private static real tempy
		private static real Incx
		private static real Incy
		private static real IncDist

		method modifyAmount takes real amount returns nothing
			if amount<=522 then
				call SetUnitTimeScale(this.u,1)
				call this.destroy()
			else 
				set this.bonus=(amount-522)*PERIOD
			endif
			set this.setspeed=amount
		endmethod

		static method register takes unit u returns thistype
			local thistype this = thistype(0).recycle
			if (0 == this) then
				set this = ic + 1
				set ic = this
			else
				set thistype(0).recycle = recycle
			endif
				set thistype(0).next.prev = this
				set this.next = thistype(0).next
				set thistype(0).next = this
				set this.prev = thistype(0)
				set this.u=u
				set this.bonus=0.
				set this.x=GetUnitX(u)
				set this.y=GetUnitY(u)
			return this
		endmethod


		static method operator [] takes unit u returns thistype
			local thistype this = thistype(0)
			loop
				set this = this.next
				exitwhen this == 0
				if this.u==u then
					return this
				endif
			endloop
			return thistype.register(u)
		endmethod


		private static method move takes thistype t returns nothing
			local thistype this=t
			if(IsUnitType(this.u, UNIT_TYPE_DEAD))then
				call this.destroy()
			else
				set thistype.tempx=GetUnitX(this.u)
				set thistype.tempy=GetUnitY(this.u)
				set thistype.Incx=thistype.tempx-this.x
				set thistype.Incy=thistype.tempy-this.y
				set thistype.IncDist=SquareRoot(thistype.Incx*thistype.Incx+thistype.Incy*thistype.Incy)
				if(thistype.IncDist>this.setspeed*0.001 and GetUnitAbilityLevel(this.u,'BSTN')<1 and GetUnitAbilityLevel(this.u,'BPSE')<1 and not IsUnitPaused(this.u) and this.setspeed>522)then
					call SetUnitTimeScale(this.u,1+this.bonus/300.)
					set thistype.IncDist=this.bonus/thistype.IncDist
					set thistype.tempx=thistype.tempx+thistype.Incx*thistype.IncDist
					set thistype.tempy=thistype.tempy+thistype.Incy*thistype.IncDist
					call SetUnitX(this.u,thistype.tempx)
					call SetUnitY(this.u,thistype.tempy)
					set this.x=thistype.tempx
					set this.y=thistype.tempy
					debug call DisplayTimedTextToPlayer(Player(0),0,0,1,R2S(thistype.IncDist))
				endif
			endif
		endmethod


		private static method iterate takes nothing returns nothing
			local thistype this = thistype(0)
			loop
				set this = this.next
				exitwhen this == 0
				if IsUnitType(this.u, UNIT_TYPE_DEAD) then
					call this.destroy()
				else
					call move(this)
				endif
			endloop
		endmethod


		method destroy takes nothing returns nothing
			set this.prev.next = this.next
			set this.next.prev = this.prev
			set this.recycle = thistype(0).recycle
			set this.setspeed=0.
			set thistype(0).recycle = this
		endmethod

		implement O
	endstruct


	function GetUnitMoveSpeedEx takes unit u returns real
		return RMaxBJ(GetUnitMoveSpeed(u),ModSpeed[u].setspeed)
	endfunction


	function SetUnitMoveSpeedEx takes unit u,real speed returns nothing
		call ModSpeed[u].modifyAmount(speed)
	endfunction

	hook SetUnitMoveSpeed SetUnitMoveSpeedEx
endlibrary