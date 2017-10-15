/* 算法 */
globals
    hMath math = 0
endglobals
struct hMath

	//绝对值
	public method abs takes real value returns real
		return RAbsBJ(value)
	endmethod

	//两整型相除得到real
	public method II2R takes integer i1,integer i2 returns real
	    return ( I2R(i1) / I2R(i2) )
	endmethod

	//获取物品几率叠加几率
	//根据固定因子及增益因子计算几率因子
	public method oddsItem takes integer odds_stable,real odds_gain,integer timers returns real
	    return odds_stable + odds_stable*( I2R(timers-1) * odds_gain)
	endmethod

	//计算属性特效效果叠加
	public method oddsAttrEffect takes real value1,real value2 returns real
		if(abs(value1)>abs(value2))then
			return value2*0.15+value1
		else
			return value1*0.15+value2
		endif
	endmethod

	//计算属性特效持续时间叠加
	public method oddsAttrEffectDuring takes real value1,real value2 returns real
		if(abs(value1)>abs(value2))then
			return value2*0.10+value1
		else
			return value1*0.10+value2
		endif
	endmethod

	//实数格式化
	public method realformat takes real value returns string
		local string s = ""
		if(value>100000000)then
			set s = R2SW(value/100000000, 1, 3)+"Y"
		elseif(value>10000)then
			set s = R2SW(value/10000, 1, 3)+"W"
		else
			set s = R2S(value)
		endif
		return s
	endmethod

	//整型格式化
	public method integerformat takes integer value returns string
		local string s = ""
		if(value>100000000)then
			set s = I2S(value/100000000)+"Y"
		elseif(value>10000)then
			set s = I2S(value/10000)+"W"
		else
			set s = I2S(value)
		endif
		return s
	endmethod

endstruct
