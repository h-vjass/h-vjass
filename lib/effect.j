//特效字符串

#include "effectString.j"

globals
hEffect heffect
effect hjass_global_effect
endglobals

struct hEffect

	//删除特效
	public static method del takes effect e returns nothing
		if(e != null)then
			call DestroyEffect(e)
			set e = null
		endif
	endmethod

	private static method duringDel takes nothing returns nothing
		local timer t = GetExpiredTimer()
		call del(htime.getEffect(t,1))
		call htime.delTimer(t)
		set t = null
	endmethod

	/**
	 * 特效 XY坐标
	 * during -1为固定存在（需要手动删除）0为删除型创建（但是有的模型用此方法不会播放，此时需要during>0）
	 */
	public static method toXY takes string effectModel,real x,real y,real during returns nothing
		local timer t = null
		if(during > 0)then
			set hjass_global_effect = AddSpecialEffect(effectModel, x,y)
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,hjass_global_effect)
			set t = null
		elseif(during < 0)then
			set hjass_global_effect = AddSpecialEffect(effectModel, x,y)
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,hjass_global_effect)
			set t = null
		else
			call DestroyEffect(AddSpecialEffect(effectModel, x,y))
		endif
	endmethod


	/**
	 * 特效 点
	 * during -1为固定存在（需要手动删除）0为删除型创建（但是有的模型用此方法不会播放，此时需要during>0）
	 */
	public static method toLoc takes string effectModel,location loc,real during returns nothing
		local timer t = null
		if(during > 0)then
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,AddSpecialEffectLoc(effectModel, loc))
			set t = null
		elseif(during < 0)then
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,AddSpecialEffectLoc(effectModel, loc))
			set t = null
		else
			call DestroyEffect(AddSpecialEffectLoc(effectModel, loc))
		endif
	endmethod

	/**
	 * 特效 单位所处点
	 */
	public static method toUnitLoc takes string effectModel,unit targetUnit,real during returns nothing
		local timer t = null
		local location loc = null
		if(targetUnit == null)then
			return
		endif
		set loc = GetUnitLoc(targetUnit)
		if(during > 0)then
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,AddSpecialEffectLoc(effectModel, loc))
			set t = null
		elseif(during < 0)then
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,AddSpecialEffectLoc(effectModel, loc))
			set t = null
		else
			call DestroyEffect(AddSpecialEffectLoc(effectModel, loc))
		endif
		call RemoveLocation(loc)
		set loc = null
	endmethod

	/**
	 * 特效 绑定单位
	 */
	public static method toUnit takes string effectModel,widget targetUnit,string attach,real during returns effect
		local timer t = null
		set hjass_global_effect = AddSpecialEffectTarget(effectModel, targetUnit , attach)
		if(during > 0)then
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,hjass_global_effect)
			set t = null
		elseif(during < 0)then
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,hjass_global_effect)
			set t = null
		else
			call DestroyEffect(hjass_global_effect)
		endif
		return hjass_global_effect
	endmethod

endstruct
