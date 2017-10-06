
library hMissile initializer init

    globals

        boolean MissileTimerPause=false
        private real array SP
        private real array RA
        private real array DM
        private real array DI
        private real array AN
        private real array ANZ
        private real array HE
        private real array HEMax     
        private real array SH
        private real array US
        private real array MX
        private real array MY
        private real array MZ
        private real array ARC
        private real array HP  
        private real array OF
        private real array OS
        private real array TIM
        private real array LT
        private real array SZ
        private real array RI
        private real array R01
        private real array R02
        private real array MGra
        private real array LOC
        private real array OH
        private real Gravity=0.40
        private unit array MU
        private unit array MT
        private unit DamageUnit 
        private string array EF
        private effect array EFL
        private real array ACC
        private real array MaxS
        private real array SPX
        private real array SPY
        private real array LastX
        private real array LastY
        private real array MKs   
        private integer array IN
        private integer Top=-1
        private real TIMOut=0.03
        private group DamageGroup 
        private timer TIMr
        private location HeroLoc
        private location array MLoc
        private player array LastOwner
        private real map_max_X 
        private real map_max_Y 
        private real map_min_X 
        private real map_min_Y 
    endglobals

    private function DistanceBetweenXY takes real x1,real x2,real y1,real y2 returns real
        return SquareRoot((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
    endfunction

    private function AngleBetweenXY takes real x1, real x2, real y1, real y2 returns real
        return bj_RADTODEG*Atan2(y2-y1,x2-x1)
    endfunction

    private function GetAngleBetweenUnits takes unit A,unit B returns real
        return Atan2(GetUnitY(B)-GetUnitY(A),GetUnitX(B)-GetUnitX(A))
    endfunction

    private function DistanceBetweenUnits takes unit A,unit B returns real
        local real x1=GetUnitX(A)
        local real x2=GetUnitX(B)
        local real y1=GetUnitY(A)
        local real y2=GetUnitY(B)
        return SquareRoot((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
    endfunction

    private function GetAcceleratedTime takes real dis, real originspeed, real accel returns real
        local real t1=0.0
        local real t2=0.0
        set t1=(-1*originspeed+SquareRoot(Pow(originspeed,2.0)+2*accel*dis))/accel
        set t2=(-1*originspeed-SquareRoot(Pow(originspeed,2.0)+2*accel*dis))/accel
        if t1==0. then
            set t1=0.01
        endif
        if t2==0. then
            set t2=0.01
        endif    
        if t1>t2 then
            return t1
        endif   
        return t2
    endfunction

    private function MRegister takes unit missile returns nothing
        call UnitAddAbility(missile,'Arav')
        call UnitRemoveAbility(missile,'Arav')
        call SetUnitPosition(missile,GetUnitX(missile),GetUnitY(missile))
        call SetUnitAnimationByIndex(missile, 90 )
    endfunction

    private function MPop takes integer i returns nothing
        if GetUnitState(MU[i],UNIT_STATE_LIFE)>0.4 then
            call KillUnit(MU[i])
        endif
        call DestroyEffect(EFL[i])
        set MU[i]=MU[Top]
        set SP[i]=SP[Top]
        set RA[i]=RA[Top]
        set DM[i]=DM[Top]
        set DI[i]=DI[Top]
        set AN[i]=AN[Top]
        set HE[i]=HE[Top]
        set HEMax[i]=HEMax[Top]     
        set US[i]=US[Top]
        set ARC[i]=ARC[Top]
        set HP[i]=HP[Top] 
        set EF[i]=EF[Top]
        set EFL[i]=EFL[Top]
        set SH[i]=SH[Top]
        set MGra[i]=MGra[Top]
        set LOC[i]=LOC[Top]
        set TIM[i]=TIM[Top]
        set LT[i]=LT[Top]
        set SZ[i]=SZ[Top]
        set RI[i]=RI[Top]
        set R01[i]=R01[Top]
        set R02[i]=R02[Top]
        set MT[i]=MT[Top]
        set OH[i]=OH[Top]
        set OS[i]=OS[Top]
        set OF[i]=OF[Top]
        set ACC[i]=ACC[Top]
        set MaxS[i]=MaxS[Top]
        set MKs[i]=MKs[Top]
        set SPX[i]=SPX[Top]
        set SPY[i]=SPY[Top]
        set LastX[i]=LastX[Top]
        set LastY[i]=LastY[Top]
        set IN[i]=IN[Top]
        set LastOwner[i]=LastOwner[Top]
        set MU[Top]=null
        set MT[Top]=null
        set Top=Top-1
    endfunction

    private function MLimit takes real x, real y returns boolean
        if x>map_max_X or x<map_min_X or y>map_max_Y or y<map_min_Y then//边界判定
            return true
        else
            return false
        endif   
    endfunction

    private function MLoop takes nothing returns nothing
        local integer i=Top
        local real array x
        local real array y
        local real array z
        local real h=0.00
        local real h2=0.0
        local real time=0.0
        local real ttime=0.0
        local real ang=0.0
        local real height=0.0
        local real lastheight=0.0    
        local real addxy=0.0
        local real addz=0.0
        local real anglez=0.0  
        local real tanZ=0.0  
        local real addh=0.0         
        local real udis=0.0
        local real targetheight=0.0     
        local integer aniI=0
        if MissileTimerPause==true then
            return
        endif
        loop
            exitwhen i<0
            set addh=0.0     
            set udis=0.0
            set x[1]=GetUnitX(MU[i])
            set y[1]=GetUnitY(MU[i])
            set height=GetUnitFlyHeight(MU[i])
            if DI[i]<=0.0 or GetUnitState(MU[i],UNIT_STATE_LIFE)<0.4 or height<=0.1 or HP[i]<=0.0 or MLimit(x[1],y[1])==true or height>=9999.1 then
                call MPop(i)
            else
                if MT[i]!=null then
                    set AN[i]=AngleBetweenXY(x[1],GetUnitX(MT[i]),y[1],GetUnitY(MT[i]))
                    set ang=AN[i]*bj_DEGTORAD
                    if IN[i]==0 then
                        set SPX[i]=SP[i]*Cos(ang)
                        set SPY[i]=SP[i]*Sin(ang)
                    else
                        set ang=ang+OF[i]
                        set SPX[i]=SPX[i]*MKs[i]+ACC[i]*Cos(ang)
                        set SPY[i]=SPY[i]*MKs[i]+ACC[i]*Sin(ang)
                    endif
                    if IsUnitType(MT[i],UNIT_TYPE_DEAD)==true then
                        set MT[i]=null
                    endif
                    set udis=DistanceBetweenUnits(MT[i],MU[i])/100.
                if udis==0. then
                    set udis=0.01
                endif
                set targetheight=GetUnitFlyHeight(MT[i])
                if RAbsBJ(height-targetheight)>RA[i] then
                if targetheight>height then
                    set addh=RAbsBJ(SP[i])/udis
                if addh+height>targetheight then
                set addh=addh/10.
                call SetUnitFlyHeight(MU[i],targetheight,0.0)
                set height=targetheight
                endif
                elseif targetheight<height then
                set addh=RAbsBJ(SP[i])*(-1.)/udis
                if addh+height<targetheight then
     call SetUnitFlyHeight(MU[i],targetheight,0.0)
     set height=targetheight
     endif
     endif
     endif
     else
     set ang=AN[i]*bj_DEGTORAD
     set SPX[i]=SP[i]*Cos(ang)
     set SPY[i]=SP[i]*Sin(ang)
     if LOC[i]==0.0 then
     set SP[i]=SP[i]+ACC[i]
     else     
     if SP[i]<=MaxS[i] then
     set SP[i]=SP[i]+ACC[i]
     else
     set SP[i]=MaxS[i]
     endif  
     endif  
     endif
     set x[2]=x[1]+SPX[i]
     set y[2]=y[1]+SPY[i]
     set MLoc[1]=Location(x[1],y[1])
     set MLoc[2]=Location(x[2],y[2])
     set z[1]=GetLocationZ(MLoc[1])
     set z[2]=GetLocationZ(MLoc[2])
     call SetUnitX(MU[i],x[2])
     call SetUnitY(MU[i],y[2])
     set LastX[i]=x[2]
     set LastY[i]=y[2]
     set addxy=DistanceBetweenXY(x[2],x[1],y[2],y[1])
     call SetUnitFacing(MU[i],AN[i])
     call GroupEnumUnitsInRange(DamageGroup,x[2],y[2],RA[i],null)
     loop
     set DamageUnit=FirstOfGroup(DamageGroup)
     if GetUnitState(DamageUnit,UNIT_STATE_LIFE)>0.4 and (MT[i]==DamageUnit or IsUnitEnemy(DamageUnit,GetOwningPlayer(MU[i]))) then
     if RAbsBJ(height-GetUnitFlyHeight(DamageUnit))<=RA[i] then
     call UnitDamageTarget(MU[i],DamageUnit,DM[i],true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
     set HP[i]=HP[i]-1.
     set DM[i]=DM[i]*0.5
     endif   
     endif
     call GroupRemoveUnit(DamageGroup,DamageUnit)
     exitwhen DamageUnit==null
     endloop
     call GroupClear(DamageGroup)
     set TIM[i]=TIM[i]+TIMOut
     if MGra[i]==0.0 then
     set h=0.11+SZ[i]-z[2]
     endif
     if LOC[i]==0.0 then
     if MGra[i]==0.0 then
     else
     set h=HEMax[i]-R01[i]*(TIM[i]-LT[i]/2)*(TIM[i]-LT[i]/2)+TIM[i]*R02[i]+SZ[i]-z[2]
     endif
     else
     set US[i]=US[i]-MGra[i]
     endif
     set lastheight=height
     set HE[i]=HE[i]*LOC[i]+SH[i]+US[i]*LOC[i]+h*(1-LOC[i])+addh
     set height=HE[i]-z[2]*LOC[i]
     call SetUnitFlyHeight(MU[i],height,0.0)
     set addz=height-lastheight
     if addxy==0. then
     set addxy=1.
     endif
     set tanZ=addz/addxy
     set anglez=AtanBJ(tanZ)
     set anglez=anglez*(1.)+90.
     set aniI=R2I(anglez)
     if aniI<0 then
     set aniI=0
     elseif aniI>181 then
     set aniI=181
     endif   
     call SetUnitAnimationByIndex(MU[i], aniI )
     set DI[i]=DI[i]-SP[i]*LOC[i]
     set US[i]=US[i]-MGra[i]
     call RemoveLocation(MLoc[1])
     call RemoveLocation(MLoc[2])
     endif
     set i=i-1
     endloop
     endfunction

     function MissileCast takes unit caster,unit missile,real originspeed,real maxspeed,real accel,real angle,real distance,real arc,real range,real damage,location loc,unit target,real height,real hp,string Effect,boolean gravity returns nothing
     local integer i=0
     local integer n=0
     local real tanA=0.01
     local real speed=600
     local real dis=0.01
     local real ang=0.01
     local real x=0.01
     local real y=0.01
     local boolean inertia=true
     if loc==null then
     return
     endif
     set Top=Top+1
     set i=Top
     set HeroLoc=GetUnitLoc(caster)
     if speed==0. then
     set speed=0.01
     endif
     if originspeed==0. then
     set originspeed=0.01
     endif 
     if maxspeed==0. then
     set maxspeed=0.01
     endif      
     if distance==0. then
     set distance=0.01
     endif  
     if height==0. then
     set height=0.1
     endif     
     if GetLocationX(loc)!=GetLocationX(HeroLoc) or GetLocationY(loc)!=GetLocationY(HeroLoc) then
     set x=GetLocationX(loc)
     set y=GetLocationY(loc)
     set ang=AngleBetweenXY(GetUnitX(caster),x,GetUnitY(caster),y)
     set dis=DistanceBetweenXY(x,GetUnitX(caster),y,GetUnitY(caster))
     set LOC[i]=0.0
     else
     set ang=angle
     set dis=distance
     set LOC[i]=1.0
     endif   
     if gravity==true then
     set MGra[i]=Gravity
     else
     set MGra[i]=0.0
     endif   
     set MU[i]=missile
     call MRegister(MU[i])
     set OH[i]=GetUnitFlyHeight(caster)+height
     set SZ[i]=GetLocationZ(HeroLoc)+OH[i]
     if originspeed==maxspeed then
     set speed=originspeed
     set accel=0.0
     set inertia=false
     set LT[i]=dis/speed
     else   
     set inertia=true
     set LT[i]=GetAcceleratedTime(dis,originspeed,accel)
     endif
     set SP[i]=originspeed*TIMOut
     set MaxS[i]=maxspeed
     set RI[i]=(GetLocationZ(loc)-SZ[i])/dis
     set TIM[i]=0
     set IN[i]=0
     if target!=null then
     if GetUnitState(target,UNIT_STATE_LIFE)>0.4 then
     set MT[i]=target
     if inertia==true then
     set OS[i]=originspeed*TIMOut
     set OF[i]=Deg2Rad(50)
     set SPX[i]=OS[i]*Cos(ang)
     set SPY[i]=OS[i]*Sin(ang)
     set MKs[i]=1-accel*TIMOut/maxspeed
     endif
     endif
     endif  
     set ACC[i]=accel*TIMOut*TIMOut
     if inertia==true then
     set IN[i]=1
     endif
     set RA[i]=range
     set DM[i]=damage
     set AN[i]=ang   
     set ARC[i]=arc
     set MaxS[i]=maxspeed*TIMOut
     if arc!=0.0 then
     set HEMax[i]=dis*ARC[i]
     else
     set HEMax[i]=height
     endif   
     if GetLocationX(loc)==GetLocationX(HeroLoc) and GetLocationY(loc)==GetLocationY(HeroLoc) then
     set ANZ[i]=AtanBJ(arc)
     set US[i]=arc*SP[i]  
     set DI[i]=distance
     else
     set US[i]=0
     set DI[i]=dis
     endif
     call SetUnitX(MU[i],GetLocationX(HeroLoc))
     call SetUnitY(MU[i],GetLocationY(HeroLoc))
     call SetUnitOwner(MU[i], GetOwningPlayer(caster), true )
     call SetUnitFacing(MU[i],AN[i])
     set HE[i]=OH[i]+GetLocationZ(HeroLoc)+0.11
     set SH[i]=0*speed
     set LastX[i]=0.0
     set LastY[i]=0.0
     set R01[i]=HEMax[i]/LT[i]/LT[i]*4
     set R02[i]=SP[i]*RI[i]/TIMOut
     set HP[i]=hp
     set DM[i]=damage
     set EF[i]=Effect
     call SetUnitFlyHeight(MU[i],HE[i]-GetLocationZ(HeroLoc),0.0)
     set EFL[i]=AddSpecialEffectTarget( EF[i], MU[i], "chest" )
     set LastOwner[i]=GetOwningPlayer(caster)
     call RemoveLocation(HeroLoc)
     set HeroLoc=null
     endfunction

     private function init takes nothing returns nothing
         set map_max_X = GetRectMaxX(bj_mapInitialPlayableArea)
         set map_max_Y = GetRectMaxY(bj_mapInitialPlayableArea)
         set map_min_X = GetRectMinX(bj_mapInitialPlayableArea)
         set map_min_Y = GetRectMinY(bj_mapInitialPlayableArea)
         set DamageGroup=CreateGroup()
         set TIMr=CreateTimer()
         call TimerStart(TIMr,TIMOut,true,function MLoop)
     endfunction

endlibrary

