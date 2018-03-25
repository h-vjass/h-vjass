//特效字符串

#include "effectString.j"

globals
hEffect heffect
endglobals

struct hEffect

	//删除特效
	public method del takes effect e returns nothing
		call DestroyEffect(e)
	endmethod

	private static method duringDel takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local effect e = htime.getEffect(t,1)
		call htime.delTimer(t)
		call DestroyEffect(e)
		set e = null
	endmethod

	/**
	 * 特效 点
	 * during -1为固定存在（需要手动删除）0为删除型创建（但是有的模型用此方法不会播放，此时需要during>0）
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
	 * 特效 单位所处点
	 */
	public method toUnitLoc takes string effectModel,unit targetUnit,real during returns effect
		local effect e = null
		local timer t = null
		local location loc = null
		if(targetUnit == null)then
			return null
		endif
		set loc = GetUnitLoc(targetUnit)
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
		call RemoveLocation(loc)
		set loc = null
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
