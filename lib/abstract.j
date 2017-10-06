
/*
	lib继承关系
	下一级可以调用上级或上级的平级方法
	如[filter]可以调用[is]也可以调用[effect]
	但[message]不可以调用[filter]
*/
#include "system.j"
	#include "is.j"
	#include "math.j"
	#include "effect.j"
	#include "timer.j"
	#include "player.j"
		#include "filter.j"
		#include "message.j"
		#include "unit.j"
		#include "group.j"
			#include "ability.j"
			#include "event.j"
				#include "attribute.j"
					#include "attributeEffect.j"
						#include "attributeHunt.j"
							#include "attributeUnit.j"
								#include "award.j"
								//#include "items.j"
									//#include "skills.j"
										//#include "multiboard.j"