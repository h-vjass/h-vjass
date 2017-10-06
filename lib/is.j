/* is.j */

library hIs needs hSys

    /**
     * 是否夜晚
     */
    public function night takes nothing returns boolean
        return (GetTimeOfDay()<=6.00 or GetTimeOfDay()>=18.00)
    endfunction

    /**
     * 是否白天
     */
    public function day takes nothing returns boolean
        return (GetTimeOfDay()>6.00 and GetTimeOfDay()<18.00)
    endfunction

    /**
     * 是否敌人
     */
    public function enemy takes unit whichUnit,unit otherUnit returns boolean
        return IsUnitEnemy(whichUnit, GetOwningPlayer(otherUnit))
    endfunction
    /**
     * 是否友军
     */
    public function ally takes unit whichUnit,unit otherUnit returns boolean
        return IsUnitAlly(whichUnit, GetOwningPlayer(otherUnit))
    endfunction
    /**
     * 是否死亡
     */
    public function death takes unit whichUnit returns boolean
        return IsUnitDeadBJ(whichUnit)
    endfunction
    /**
     * 是否生存
     */
    public function alive takes unit whichUnit returns boolean
        return not IsUnitDeadBJ(whichUnit)
    endfunction
    /*
     * 是否无敌
     */
    public function invincible takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, 'Avul')>0
    endfunction
    /**
     * 是否英雄
     */
    public function hero takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_HERO)
    endfunction
    /**
     * 是否建筑
     */
    public function building takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_STRUCTURE)
    endfunction
    /**
     * 是否镜像
     */
    public function illusion takes unit whichUnit returns boolean
        return IsUnitIllusion(whichUnit)
    endfunction
    /*
     * 是否地面单位
     */
    public function ground takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_GROUND)
    endfunction
    /*
     * 是否空中单位
     */
    public function flying takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_FLYING)
    endfunction
    /*
     * 是否近战
     */
    public function melee takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_MELEE_ATTACKER)
    endfunction
    /*
     * 是否远程
     */
    public function ranged takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_MELEE_ATTACKER)
    endfunction
    /*
     * 是否召唤
     */
    public function summoned takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_SUMMONED)
    endfunction
    /*
     * 是否机械
     */
    public function mechanical takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_MECHANICAL)
    endfunction
    /*
     * 是否古树
     */
    public function ancient takes unit whichUnit returns boolean
        return IsUnitType( whichUnit , UNIT_TYPE_ANCIENT)
    endfunction
    /**
     * 判断是否水面
     */
    public function water takes unit whichUnit returns boolean
        local location loc = GetUnitLoc(whichUnit)
        local boolean status = IsTerrainPathableBJ(loc, PATHING_TYPE_FLOATABILITY) == false
        call RemoveLocation(loc)
        set loc = null
        return status
    endfunction
    /**
     * 判断是否地面
     */
    public function floor takes unit whichUnit returns boolean
        local location loc = GetUnitLoc(whichUnit)
        local boolean status = IsTerrainPathableBJ(loc, PATHING_TYPE_FLOATABILITY) == true
        call RemoveLocation(loc)
        set loc = null
        return status
    endfunction

    /**
     * 是否地图边界
     */
    public function border takes real x,real y returns boolean
        local boolean flag = false
        if( x >= GetRectMaxX(GetPlayableMapRect()) or x <= GetRectMinX(GetPlayableMapRect()) )then
            set flag = true
        endif
        if( y >= GetRectMaxY(GetPlayableMapRect()) or y <= GetRectMinY(GetPlayableMapRect()) )then
            return true
        endif
        return flag
    endfunction

    /**
     * 单位身上是否有某物品
     */
    public function ownItem takes unit u,integer itemId returns boolean
        return (GetItemTypeId(GetItemOfTypeFromUnitBJ(u, itemId)) == itemId)
    endfunction

endlibrary
