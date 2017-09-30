/* 算法 */
library hMath needs hSys

	//绝对值
	public function abs takes real value returns real
		return RAbsBJ(value)
	endfunction

	//两整型相除得到real
	public function II2R takes integer i1,integer i2 returns real
	    return ( I2R(i1) / I2R(i2) )
	endfunction

	//获取物品几率叠加几率
	//根据固定因子及增益因子计算几率因子
	public function oddsItem takes integer odds_stable,real odds_gain,integer timers returns real
	    return odds_stable + odds_stable*( I2R(timers-1) * odds_gain)
	endfunction

	//计算属性特效效果叠加
	public function oddsAttrEffect takes real value1,real value2 returns real
		if(abs(value1)>abs(value2))then
			return value2*0.15+value1
		else
			return value1*0.15+value2
		endif
	endfunction

	//计算属性特效持续时间叠加
	public function oddsAttrEffectDuring takes real value1,real value2 returns real
		if(abs(value1)>abs(value2))then
			return value2*0.10+value1
		else
			return value1*0.10+value2
		endif
	endfunction

endlibrary
