/* 天气 */

library hWeather initializer init requires hAward

	private integer SUN 			= 'LRaa'	//日光
    private integer MOON			= 'LRma'	//月光
    private integer SHIELD 			= 'MEds'	//紫光盾
    private integer RAIN			= 'RAlr'	//雨
    private integer RAINSTORM 		= 'RAhr'	//大雨
    private integer SNOW 			= 'SNls'	//雪
    private integer SNOWSTORM 		= 'SNhs'	//大雪
    private integer WIND 			= 'WOlw'	//风
    private integer WINDSTORM 		= 'WNcw'	//大风
    private integer MISTWHITE 		= 'FDwh'	//白雾
    private integer MISTGREEN 		= 'FDgh'	//绿雾
    private integer MISTBLUE 		= 'FDbh'	//蓝雾
    private integer MISTRED 		= 'FDrh'	//红雾

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