extends Object
class_name MainRouteEnding

const NoEnding := 0
const Generic := 1

const TaviNoEnding := 5
const TaviYesEnding := 6
const TaviKillEnding := 7

static func getName(_ending:int) -> String:
	if(_ending == NoEnding):
		return "Нет концовки"
	if(_ending == Generic):
		return "Обычная концовка"

	if(_ending == TaviNoEnding):
		return "Рут Тави: концовка «Нет»"
	if(_ending == TaviYesEnding):
		return "Рут Тави: концовка «Да»"
	if(_ending == TaviKillEnding):
		return "Рут Тави: концовка «Убить»"
	
	return "Unknown:"+str(_ending)

static func getCurrentEnding() -> int:
	if(GM.main.getFlag("TaviModule.Ch7NoEnding", false)):
		return TaviNoEnding
	if(GM.main.getFlag("TaviModule.Ch7YesEnding", false)):
		return TaviYesEnding
	if(GM.main.getFlag("TaviModule.Ch7KillEnding", false)):
		return TaviKillEnding
	
	return NoEnding
