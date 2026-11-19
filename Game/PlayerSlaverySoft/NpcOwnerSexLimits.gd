extends Object
class_name NpcOwnerSexLimits

const LIMITS = {
	"condomsOnly": {
		name = "Только презервативы",
		desc = "Твой хозяин (и любой другой, кто тебя трахает) должен использовать презервативы",
	},
	"noPullout": {
		name = "Без прерванного акта",
		desc = "Твой хозяин (и любой другой, кто тебя трахает) должен кончать только внутрь",
	},
	"noRimming": {
		name = "Без римминга",
		desc = "Любой вид римминга запрещен!",
	},
	"noBondage": {
		name = "Без бондажа",
		desc = "Любой вид бондажа запрещен!",
	},
	"noFeetplay": {
		name = "Без футфетиша",
		desc = "Любой вид футплея запрещен!",
	},
	"noJoiners": {
		name = "Без джойнеров",
		desc = "Прохожим/зрителям запрещено присоединяться!",
	},
	"noMilking": {
		name = "Без милкинга",
		desc = "Тебя не будут доить никаким способом.",
	},
	"noBottom": {
		name = "Без роли снизу",
		desc = "Тебя не будут заставлять быть принимающей стороной.",
		bans = ["noTopping"],
	},
	"noTopping": {
		name = "Без роли сверху",
		desc = "Тебя не будут заставлять трахать других.",
		bans = ["noBottom"],
	},
}

static func getAgreeChance(_limitID:String, _ownerChar) -> float:
	var fetishHolder:FetishHolder = _ownerChar.getFetishHolder()
	
	if(_limitID == "condomsOnly"):
		return 70.0 + fetishHolder.getFetishValue(Fetish.Condoms)*30.0
	if(_limitID == "noPullout"):
		return 80.0 - fetishHolder.getFetishValue(Fetish.Breeding)*20.0
	if(_limitID == "noRimming"):
		return 70.0 - 0.5*(fetishHolder.getFetishValue(Fetish.RimmingGiving)+fetishHolder.getFetishValue(Fetish.RimmingReceiving))*30.0
	if(_limitID == "noBondage"):
		return 70.0 - fetishHolder.getFetishValue(Fetish.Rigging)*30.0
	if(_limitID == "noFeetplay"):
		return 70.0 - 0.5*(fetishHolder.getFetishValue(Fetish.FeetplayGiving)+fetishHolder.getFetishValue(Fetish.FeetplayReceiving))*30.0
	if(_limitID == "noMilking"):
		return 70.0 - 0.5*(fetishHolder.getFetishValue(Fetish.Lactation)+fetishHolder.getFetishValue(Fetish.SeedMilking))*30.0
	
	return 70.0
