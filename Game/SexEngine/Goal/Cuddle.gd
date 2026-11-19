extends SexGoalBase

func _init():
	id = SexGoal.Cuddle

func getVisibleName():
	return "Обнимашки"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_subInfo.isUnconscious()):
		return false
	
	return true

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
	}

func getGoalDefaultWeight():
	return 1.0

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Cuddle"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Умоляй домина, чтобы тебя обняли!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you}, чтобы обниматься с {sub.youHim}."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Может, пообнимаемся?",
		"Как насчет того, чтобы просто немного пообниматься?",
		"Может, ты хочешь пообниматься со мной?",
		"Хочешь обнимашек?",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Exhibitionism: 1.0,
	}
