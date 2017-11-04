/* 天气 */

struct hWeatherBean
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
    method destroy takes nothing returns nothing
        if(loc!=null)then
            call RemoveLocation(loc)
            set loc = null
        endif
    endmethod
endstruct

library hWeather initializer init needs hAward

    globals
        private hashtable hash = null
        private integer weatherHashCacheIndex = 0
        private integer weatherHashCacheMax = 100
        private weathereffect array weatherHashCache
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

    private function saveWatherHashCache takes timer t,weathereffect w returns nothing
        local integer i = 0
        loop
            exitwhen i>weatherHashCacheMax
                if(weatherHashCache[i]==null)then
                    set weatherHashCache[i] = w
                    call SaveInteger(hash, GetHandleId(t), 0, i)
                    call DoNothing() YDNL exitwhen true//()
                endif
            set i=i+1
        endloop
        if(i>100)then
            call console.error("weatherHashCacheMax too small")
        endif
    endfunction

    //删除天气
    public function del takes weathereffect w returns nothing
        call RemoveWeatherEffect(w)
        set w = null
    endfunction

    private function delCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = LoadInteger(hash, GetHandleId(t), 0)
        local weathereffect w = weatherHashCache[i]
        call del(w)
        call time.delTimer(t)
        set weatherHashCache[i] = null
    endfunction

	//创建天气
	private function build takes hWeatherBean bean returns weathereffect
		local weathereffect w = null
        local rect area = null
        local timer t = null
        if(bean.loc==null)then
            call console.error("hWeather.build")
            return null
        endif
        if(bean.loc!=null)then
            if(bean.width<=0 or bean.height<=0)then
                call console.error("hWeather.build -w-h")
                return null
            else
                set area = hrect.createInLoc(GetLocationX(bean.loc),GetLocationY(bean.loc),bean.width,bean.height)
                set w = AddWeatherEffect( area , bean.id )
                if(bean.during>0)then
                    set t = time.setTimeout(bean.during,function delCall)
                    call saveWatherHashCache(t,w)
                endif
                call RemoveRect(area)
                set area = null
            endif
        endif
		call EnableWeatherEffect( w , true )
		return w
	endfunction

    //阳光
    //! textmacro hWeatherEcho takes FNAME
    public function $FNAME$ takes hWeatherBean bean returns weathereffect
        set bean.id = id_$FNAME$
        return build(bean)
    endfunction
    //! endtextmacro

    //! runtextmacro hWeatherEcho("sun")
    //! runtextmacro hWeatherEcho("moon")
    //! runtextmacro hWeatherEcho("shield")
    //! runtextmacro hWeatherEcho("rain")
    //! runtextmacro hWeatherEcho("rainstorm")
    //! runtextmacro hWeatherEcho("snow")
    //! runtextmacro hWeatherEcho("snowstorm")
    //! runtextmacro hWeatherEcho("wind")
    //! runtextmacro hWeatherEcho("windstorm")
    //! runtextmacro hWeatherEcho("mistwhite")
    //! runtextmacro hWeatherEcho("mistgreen")
    //! runtextmacro hWeatherEcho("mistblue")
    //! runtextmacro hWeatherEcho("mistred")

	private function init takes nothing returns nothing
        set hash = InitHashtable()
	endfunction

endlibrary