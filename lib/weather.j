/* 天气 */

struct hWeatherBean
    
    public static rect area = null
    public static location loc = null
    public static integer id = 0
    public static real width = 0
    public static real height = 0
    public static real during = 0

    static method create takes nothing returns hWeatherBean
        local hWeatherBean x = 0
        set x = hWeatherBean.allocate()
        return x
    endmethod
    method onDestroy takes nothing returns nothing
        if(loc!=null)then
            call RemoveLocation(loc)
            set loc = null
        endif
        if(area!=null)then
            call RemoveRect(area)
            set area = null
        endif
    endmethod

endstruct

library hWeather initializer init needs hAward

    globals
    	private integer id_sun = 'LRaa' //日光
        private integer id_moon = 'LRma' //月光
        private integer id_shield = 'MEds' //紫光盾
        private integer id_rain = 'RAlr' //雨
        private integer id_rainstorm = 'RAhr' //大雨
        private integer id_snow = 'SNls' //雪
        private integer id_snowstorm = 'SNhs' //大雪
        private integer id_wind = 'WOlw' //风
        private integer id_windstorm = 'WNcw' //大风
        private integer id_mistwhite = 'FDwh' //白雾
        private integer id_mistgreen = 'FDgh' //绿雾
        private integer id_mistblue = 'FDbh' //蓝雾
        private integer id_mistred = 'FDrh' //红雾
    endglobals
    
	/**
	 * 创建天气
	 */
	private function build takes hWeatherBean bean returns weathereffect
		local weathereffect w = null
        if(bean.area==null and bean.loc==null)then
            call console.error("hWeather.build")
            return null
        endif
        if(bean.area!=null)then
            set w = AddWeatherEffect( bean.area , bean.id )
        elseif(bean.loc!=null)then
            if(bean.width<=0 or bean.height<=0)then
                call console.error("hWeather.build -w-h")
                return null
            else
                set bean.area = hrect.createInLoc(GetLocationX(bean.loc),GetLocationY(bean.loc),bean.width,bean.height)
                set w = AddWeatherEffect( bean.area , bean.id )
            endif
        endif
		call EnableWeatherEffect( w , true )
		return w
	endfunction

    public function sun takes hWeatherBean bean returns weathereffect
        set bean.id = id_sun
        return build(bean)
    endfunction

	private function init takes nothing returns nothing

	endfunction

endlibrary