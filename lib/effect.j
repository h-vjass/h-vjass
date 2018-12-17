//特效字符串

#include "effectString.j"

globals
hEffect heffect
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
	endmethod

	/**
	 * 特效 XY坐标
	 * during -1为固定存在（需要手动删除）0为删除型创建（但是有的模型用此方法不会播放，此时需要during>0）
	 */
	public static method toXY takes string effectModel,real x,real y,real during returns effect
		local effect e = null
		local timer t = null
		if(during > 0)then
			set e = AddSpecialEffect(effectModel, x,y)
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		elseif(during < 0)then
			set e = AddSpecialEffect(effectModel, x,y)
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		else
			call DestroyEffect(AddSpecialEffect(effectModel, x,y))
		endif
		return e
	endmethod


	/**
	 * 特效 点
	 * during -1为固定存在（需要手动删除）0为删除型创建（但是有的模型用此方法不会播放，此时需要during>0）
	 */
	public static method toLoc takes string effectModel,location loc,real during returns effect
		local effect e = null
		local timer t = null
		if(during > 0)then
			set e = AddSpecialEffectLoc(effectModel, loc)
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		elseif(during < 0)then
			set e = AddSpecialEffectLoc(effectModel, loc)
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		else
			call DestroyEffect(AddSpecialEffectLoc(effectModel, loc))
		endif
		return e
	endmethod

	/**
	 * 特效 单位所处点
	 */
	public static method toUnitLoc takes string effectModel,unit targetUnit,real during returns effect
		local effect e = null
		local timer t = null
		local location loc = null
		if(targetUnit == null)then
			return null
		endif
		set loc = GetUnitLoc(targetUnit)
		if(during > 0)then
			set e = AddSpecialEffectLoc(effectModel, loc)
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		elseif(during < 0)then
			set e = AddSpecialEffectLoc(effectModel, loc)
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		else
			call DestroyEffect(AddSpecialEffectLoc(effectModel, loc))
		endif
		call RemoveLocation(loc)
		set loc = null
		return e
	endmethod

	/**
	 * 特效 绑定单位
	 */
	public static method toUnit takes string effectModel,widget targetUnit,string attach,real during returns effect
		local effect e = null
		local timer t = null
		if(during > 0)then
			set e = AddSpecialEffectTarget(effectModel, targetUnit , attach)
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		elseif(during < 0)then
			set e = AddSpecialEffectTarget(effectModel, targetUnit , attach)
			set t = htime.setTimeout(60,function thistype.duringDel)
			call htime.setEffect(t,1,e)
		else
			call DestroyEffect(AddSpecialEffectTarget(effectModel, targetUnit , attach))
		endif
		return e
	endmethod

endstruct
