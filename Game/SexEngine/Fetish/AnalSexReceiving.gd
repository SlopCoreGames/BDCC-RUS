extends FetishBase

func _init():
	id = Fetish.AnalSexReceiving
	dynamicChangesPersonalityAffectors = {
		PersonalityStat.Subby: 0.25,
	}

func getVisibleName():
	return "Анальный секс (Принимающий)"

func getGoals(_sexEngine, _domFetishHolder, _dom, _sub):
	var possible = []
	
	possible.append(SexGoal.ReceiveAnal)
	
	return possible
