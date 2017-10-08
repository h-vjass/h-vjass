/* is.j */
globals
    hIs is = 0
endglobals

struct hIs
    
    /**
     * 是否夜晚
     */
    public method night takes nothing returns boolean
        return (GetTimeOfDay()<=6.00 or GetTimeOfDay()>=18.00)
    endmethod

    /**
     * 是否白天
     */
    public method day takes nothing returns boolean
        return (GetTimeOfDay()>6.00 and GetTimeOfDay()<18.00)
    endmethod

    /**
     * 是否敌人
     */
    public method enemy takes unit whichUnit,unit otherUnit returns boolean
        return IsUnitEnemy(whichUnit, GetOwningPlayer(otherUnit))
    endmethod
    /**
     * 是否友军
     */
    public method ally takes unit whichUnit,unit otherUnit returns boolean
        return IsUnitAlly(whichUnit, GetOwningPlayer(otherUnit))
    endmethod
    /**
     * 是否死亡
     */
    public method death takes unit whichUnit returns boolean
        return IsUnitDeadBJ(whichUnit)
    endmethod
    /**
     * 是否生存
     */
    public method alive takes unit whichUnit returns boolean
        return not IsUnitDeadBJ(whichUnit)
    endmethod
    /*
     * 是否无敌
     */
    public method invincible takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, 'Avul')>0
    endmethod
    /**
     * 是否英雄
     */
    public method hero takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_HERO)
    endmethod
    /**
     * 是否建筑
     */
    public method building takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_STRUCTURE)
    endmethod
    /**
     * 是否镜像
     */
    public method illusion takes unit whichUnit returns boolean
        return IsUnitIllusion(whichUnit)
    endmethod
    /*
     * 是否地面单位
     */
    public method ground takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_GROUND)
    endmethod
    /*
     * 是否空中单位
     */
    public method flying takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_FLYING)
    endmethod
    /*
     * 是否近战
     */
    public method melee takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_MELEE_ATTACKER)
    endmethod
    /*
     * 是否远程
     */
    public method ranged takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_MELEE_ATTACKER)
    endmethod
    /*
     * 是否召唤
     */
    public method summoned takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_SUMMONED)
    endmethod
    /*
     * 是否机械
     */
    public method mechanical takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_MECHANICAL)
    endmethod
    /*
     * 是否古树
     */
    public method ancient takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_ANCIENT)
    endmethod
    /**
     * 判断是否水面
     */
    public method water takes unit whichUnit returns boolean
        local location loc = GetUnitLoc(whichUnit)
        local boolean status = IsTerrainPathableBJ(loc, PATHING_TYPE_FLOATABILITY) == false
        call RemoveLocation(loc)
        set loc = null
        return status
    endmethod
    /**
     * 判断是否地面
     */
    public method floor takes unit whichUnit returns boolean
        local location loc = GetUnitLoc(whichUnit)
        local boolean status = IsTerrainPathableBJ(loc, PATHING_TYPE_FLOATABILITY) == true
        call RemoveLocation(loc)
        set loc = null
        return status
    endmethod

    /**
     * 是否地图边界
     */
    public method border takes real x,real y returns boolean
        local boolean flag = false
        if( x >= GetRectMaxX(GetPlayableMapRect()) or x <= GetRectMinX(GetPlayableMapRect()) )then
            set flag = true
        endif
        if( y >= GetRectMaxY(GetPlayableMapRect()) or y <= GetRectMinY(GetPlayableMapRect()) )then
            return true
        endif
        return flag
    endmethod

    /**
     * 单位身上是否有某物品
     */
    public method ownItem takes unit u,integer itemId returns boolean
        return (GetItemTypeId(GetItemOfTypeFromUnitBJ(u, itemId)) == itemId)
    endmethod

endstruct
