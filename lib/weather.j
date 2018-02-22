/* 天气 */
globals
    hWeather hweather = 0
    hashtable hash_weather = InitHashtable()
    integer weatherHashCacheIndex = 0
    integer weatherHashCacheMax = 100
    weathereffect array weatherHashCache
    integer hweather_id_sun = 'LRaa' //日光
    integer hweather_id_moon = 'LRma' //月光
    integer hweather_id_shield = 'MEds' //紫光盾
    integer hweather_id_rain = 'RAlr' //雨
    integer hweather_id_rainstorm = 'RAhr' //大雨
    integer hweather_id_snow = 'SNls' //雪
    integer hweather_id_snowstorm = 'SNhs' //大雪
    integer hweather_id_wind = 'WOlw' //风
    integer hweather_id_windstorm = 'WNcw' //大风
    integer hweather_id_mistwhite = 'FDwh' //白雾
    integer hweather_id_mistgreen = 'FDgh' //绿雾
    integer hweather_id_mistblue = 'FDbh' //蓝雾
    integer hweather_id_mistred = 'FDrh' //红雾
endglobals

struct hWeatherBean
    public static location loc = null
    public static integer id = 0
    public static real width = 0
    public static real height = 0
    public static real during = 0

    static method create takes nothing returns hWeatherBean
        local hWeatherBean x = 0
        set x = hWeatherBean.allocate()
        set x.loc = null
        set x.id = 0
        set x.width = 0
        set x.height = 0
        set x.during = 0
        return x
    endmethod
    method destroy takes nothing returns nothing
        if(loc!=null)then
            call RemoveLocation(loc)
            set loc = null
        endif
        set id = 0
        set width = 0
        set height = 0
        set during = 0
    endmethod
endstruct

struct hWeather

    private static method saveWatherHashCache takes timer t,weathereffect w returns nothing
        local integer i = 0
        loop
            exitwhen i>weatherHashCacheMax
                if(weatherHashCache[i]==null)then
                    set weatherHashCache[i] = w
                    call SaveInteger(hash_weather, GetHandleId(t), 0, i)
                    call DoNothing() YDNL exitwhen true//()
                endif
            set i=i+1
        endloop
        if(i>100)then
            call hconsole.error("weatherHashCacheMax too small")
        endif
    endmethod

    //删除天气
    public static method del takes weathereffect w returns nothing
        call RemoveWeatherEffect(w)
        set w = null
    endmethod

    private static method delCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = LoadInteger(hash_weather, GetHandleId(t), 0)
        local weathereffect w = weatherHashCache[i]
        call del(w)
        call htime.delTimer(t)
        set weatherHashCache[i] = null
    endmethod

	//创建天气
	private static method build takes hWeatherBean bean returns weathereffect
		local weathereffect w = null
        local rect area = null
        local timer t = null
        if(bean.loc==null)then
            call hconsole.error("hWeather.build")
            return null
        endif
        if(bean.loc!=null)then
            if(bean.width<=0 or bean.height<=0)then
                call hconsole.error("hWeather.build -w-h")
                return null
            else
                set area = hrect.createInLoc(GetLocationX(bean.loc),GetLocationY(bean.loc),bean.width,bean.height)
                set w = AddWeatherEffect( area , bean.id )
                if(bean.during>0)then
                    set t = htime.setTimeout(bean.during,function thistype.delCall)
                    call saveWatherHashCache(t,w)
                endif
                call RemoveRect(area)
                set area = null
            endif
        endif
		call EnableWeatherEffect( w , true )
		return w
	endmethod

    //阳光
    //! textmacro hWeatherEcho takes FNAME
    public static method $FNAME$ takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_$FNAME$
        return build(bean)
    endmethod
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

endstruct