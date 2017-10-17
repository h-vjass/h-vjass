/* 天气 */

library hWeather initializer init requires hAward

	/**
	 * 创建天气给区域
	 */
	public function toRect takes rect whichRect,integer whichWeather returns weathereffect
		local weathereffect w = AddWeatherEffect( whichRect , whichWeather )
		call EnableWeatherEffect( w , true )
		return w
	endfunction

	private function init takes nothing returns nothing
		
	endfunction

endlibrary