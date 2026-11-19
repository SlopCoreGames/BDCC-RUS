extends "res://Game/SexEngine/SexActivity/Tentacles/TentaclesSexVag.gd"

func _init():
	id = "TentaclesSexAnal"
	
	fuckHole = S_ANUS
	fuckFetish = Fetish.AnalSexGiving
	fuckHoleNames = [
		"tailhole",
		"asshole",
	]
	
	activityName = "Анальный"
	activityDesc = "Трахать задницу сабмиссива."
	activityCategory = ["Fuck"]

func getGoals():
	if(currentPose == POSE_CHOKEFUCK):
		return {
			SexGoal.ChokeSexAnal: 1.0,
			SexGoal.FuckAnal: 1.0,
		}
	return {
		SexGoal.FuckAnal: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.TentaclesSex: true,
	}
