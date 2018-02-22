/* 特效字符串 */

#include "effectString.j"

globals
hEffect heffect = 0
endglobals

struct hEffect

	//删除特效
	public method del takes effect e returns nothing
		call DestroyEffect(e)
	endmethod

	static method duringDel takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local effect e = htime.getEffect(t,1)
		call htime.delTimer(t)
		call DestroyEffect(e)
		set e = null
	endmethod

	/**
	 * 特效 点
	 */
	public method toLoc takes string effectModel,location loc,real during returns effect
		local effect e = null
		local timer t = null
		if(during > 0)then
			set e = AddSpecialEffectLoc(effectModel, loc)
			set t = htime.setTimeout(during,function hEffect.duringDel)
			call htime.setEffect(t,1,e)
		elseif(during < 0)then
			set e = AddSpecialEffectLoc(effectModel, loc)
		else
			set e = AddSpecialEffectLoc(effectModel, loc)
			call del(e)
		endif
		return e
	endmethod

	/**
	 * 特效 绑定单位
	 */
	public method toUnit takes string effectModel,widget targetUnit,string attach,real during returns effect
		local effect e = null
		local timer t = null
		if(during > 0)then
			set e = AddSpecialEffectTargetUnitBJ(attach, targetUnit , effectModel)
			set t = htime.setTimeout(during,function hEffect.duringDel)
			call htime.setEffect(t,1,e)
		elseif(during < 0)then
			set e = AddSpecialEffectTargetUnitBJ(attach, targetUnit , effectModel)
		else
			set e = AddSpecialEffectTargetUnitBJ(attach, targetUnit , effectModel)
			call del(e)
		endif
		return e
	endmethod

endstruct
