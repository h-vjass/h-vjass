//闪电特效

globals
hLightning hlightning
string lightningCode_shandianlian_zhu = "CLPB" 		//闪电效果 - 闪电链主
string lightningCode_shandianlian_ci = "CLSB" 		//闪电效果 - 闪电链次
string lightningCode_jiqu = "DRAB" 					//闪电效果 - 汲取
string lightningCode_shengming_jiqu = "DRAL" 		//闪电效果 - 生命汲取
string lightningCode_mofa_jiqu = "DRAM" 			//闪电效果 - 魔法汲取
string lightningCode_siwangzhizhi = "AFOD" 			//闪电效果 - 死亡之指
string lightningCode_chazhuangshandian = "FORK"		//闪电效果 - 叉状闪电
string lightningCode_yiliaobo_zhu = "HWPB" 			//闪电效果 - 医疗波主
string lightningCode_yiliaobo_ci = "HWSB" 			//闪电效果 - 医疗波次
string lightningCode_shandian_gongji = "CHIM" 		//闪电效果 - 闪电攻击
string lightningCode_mafa_liaokao = "LEAS" 			//闪电效果 - 魔法镣铐
string lightningCode_fali_ranshao = "MBUR" 			//闪电效果 - 法力燃烧
string lightningCode_molizhiyan = "MFPB" 			//闪电效果 - 魔力之焰
string lightningCode_linghun_suolian = "SPLK" 		//闪电效果 - 灵魂锁链
endglobals

struct hLightning

	//删除闪电
	public method del takes lightning l returns nothing
		call DestroyLightning(l)
	endmethod

	private static method duringDel takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local lightning l = htime.getLightning(t,1)
		call htime.delTimer(t)
		call DestroyLightning(l)
		set t = null
		set l = null
	endmethod

	/**
	 * 闪电 坐标对坐标
	 * during <=0时 永久存在
	 */
	public method xyz2xyz takes string codename,real x1,real y1,real z1,real x2,real y2,real z2,real during returns lightning
		local lightning l = AddLightningEx(codename, true, x1, y1, z1, x2, y2, z2)
		local timer t = null
		if(during > 0)then
			set t = htime.setTimeout(during,function thistype.duringDel)
			call htime.setLightning(t,1,l)
		endif
		return l
	endmethod

	/**
	 * 闪电 点对点
	 * during <=0时 永久存在
	 */
	public method loc2loc takes string codename,location loc1,location loc2,real during returns lightning
		return xyz2xyz(codename, GetLocationX(loc1), GetLocationY(loc1), GetLocationZ(loc1), GetLocationX(loc2), GetLocationY(loc2), GetLocationZ(loc2),during)
	endmethod

	/**
	 * 闪电 单位对单位
	 * during <=0时 永久存在
	 */
	public method unit2unit takes string codename,unit unit1,unit unit2,real during returns lightning
		return xyz2xyz(codename, GetUnitX(unit1), GetUnitY(unit1), GetUnitFlyHeight(unit1), GetUnitX(unit2), GetUnitY(unit2), GetUnitFlyHeight(unit2),during)
	endmethod

endstruct
