extends "res://Game/SexEngine/SexActivity/ThreeDDS_SpitroastVag.gd"

func _init():
	id = "ThreeDDS_SpitroastAnal"
	
	usedBodypart = S_ANUS
	usedFetish = Fetish.AnalSexGiving
	
	activityName = "Спитройст (анальный)"
	activityDesc = "Трахать задницу и рот сабмиссива другим доминантом одновременно"
	activityCategory = ["Fuck", "Threesome"]

func getGoals():
	return {
		SexGoal.FuckAnal: 1.0,
		SexGoal.StraponAnal: 1.0,
	}

func getGoalsFor(_indx:int, _args:Array) -> Dictionary:
	if(_indx == DOM_0):
		return {
			SexGoal.FuckAnal: 1.0,
			SexGoal.StraponAnal: 1.0,
		}
	if(_indx == DOM_1):
		return {
			SexGoal.FuckOral: 1.0,
		}
	return {}
