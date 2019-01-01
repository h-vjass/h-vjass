globals
	hDzapi hdzapi
	hashtable hash_dzapi = null
endglobals

struct hDzapi

	private static integer hdz_map_lv = 10001

	public static method create takes nothing returns hDzapi
		local hDzapi x = 0
        set x = hDzapi.allocate()
	    return x
	endmethod

	public static method mapLv takes player whichPlayer returns integer
		return DzAPI_Map_GetMapLevel(whichPlayer)
	endmethod


endstruct
