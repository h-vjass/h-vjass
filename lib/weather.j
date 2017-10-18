/* 天气 */

library hWeather initializer init needs hAward

    globals
    	private integer sun             = 'LRaa'	//日光
        private integer moon            = 'LRma'	//月光
        private integer shield 			= 'MEds'	//紫光盾
        private integer rain            = 'RAlr'	//雨
        private integer rainstorm   	= 'RAhr'	//大雨
        private integer snow        	= 'SNls'	//雪
        private integer snowstorm 		= 'SNhs'	//大雪
        private integer wind        	= 'WOlw'	//风
        private integer windstorm 		= 'WNcw'	//大风
        private integer mistwhite 		= 'FDwh'	//白雾
        private integer mistgreen 		= 'FDgh'	//绿雾
        private integer mistblue 		= 'FDbh'	//蓝雾
        private integer mistred 		= 'FDrh'	//红雾
    endglobals
    
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