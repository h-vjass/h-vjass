//天气
globals
    hWeather hweather
    hashtable hash_weather = null
    integer weatherHashCacheIndex = 0
    integer weatherHashCacheMax = 100
    weathereffect hjass_global_weathereffect
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
    public static real x = 0
    public static real y = 0
    public static integer id = 0
    public static real width = 0
    public static real height = 0
    public static real during = 0

    static method create takes nothing returns hWeatherBean
        local hWeatherBean x = 0
        set x = hWeatherBean.allocate()
        set x.x = 0
        set x.y = 0
        set x.id = 0
        set x.width = 0
        set x.height = 0
        set x.during = 0
        return x
    endmethod
    method destroy takes nothing returns nothing
        set x = 0
        set y = 0
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
        call EnableWeatherEffect(w, false )
        call RemoveWeatherEffect(w)
        set w = null
    endmethod

    private static method delCall takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = LoadInteger(hash_weather, GetHandleId(t), 0)
        call RemoveSavedInteger(hash_weather, GetHandleId(t), 0)
        call del(weatherHashCache[i])
        call htime.delTimer(t)
        set t = null
        set weatherHashCache[i] = null
    endmethod

	//创建天气
	private static method build takes hWeatherBean bean returns weathereffect
        local timer t = null
        local rect r = null
        if(bean.width<=0 or bean.height<=0)then
            call hconsole.error("hWeather.build -w-h")
            return null
        else
            set r = hrect.createInLoc(bean.x,bean.y,bean.width,bean.height)
            set hjass_global_weathereffect = AddWeatherEffect(r, bean.id )
            if(bean.during>0)then
                set t = htime.setTimeout(bean.during,function thistype.delCall)
                call saveWatherHashCache(t,hjass_global_weathereffect)
                set t = null
            endif
            call RemoveRect(r)
            set r = null
        endif
		call EnableWeatherEffect(hjass_global_weathereffect,true)
		return hjass_global_weathereffect
	endmethod

    public static method sun takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_sun
        return build(bean)
    endmethod
    public static method moon takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_moon
        return build(bean)
    endmethod
    public static method shield takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_shield
        return build(bean)
    endmethod
    public static method rain takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_rain
        return build(bean)
    endmethod
    public static method rainstorm takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_rainstorm
        return build(bean)
    endmethod
    public static method snow takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_snow
        return build(bean)
    endmethod
    public static method snowstorm takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_snowstorm
        return build(bean)
    endmethod
    public static method wind takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_wind
        return build(bean)
    endmethod
    public static method windstorm takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_windstorm
        return build(bean)
    endmethod
    public static method mistwhite takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_mistwhite
        return build(bean)
    endmethod
    public static method mistgreen takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_mistgreen
        return build(bean)
    endmethod
    public static method mistblue takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_mistblue
        return build(bean)
    endmethod
    public static method mistred takes hWeatherBean bean returns weathereffect
        set bean.id = hweather_id_mistred
        return build(bean)
    endmethod

endstruct