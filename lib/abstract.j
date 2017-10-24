
/*
	lib继承关系
	下一级可以调用上级或上级的平级方法
	如[attributeExt]可以调用[ability]也可以调用[event]
	但[ability]不可以调用[event]
*/
#include "system.j"
	#include "ability.j"
	#include "event.j"
		#include "attributeExt.j"
			#include "attribute.j"
				#include "attributeEffect.j"
					#include "attributeNatural.j"
						#include "attributeHunt.j"
							#include "attributeUnit.j"
								#include "award.j"
								//#include "items.j"
									//#include "skills.j"
									#include "weather.j"
										#include "multiboard.j"
