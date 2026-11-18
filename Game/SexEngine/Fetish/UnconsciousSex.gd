extends FetishBase

func _init():
	id = Fetish.UnconsciousSex
	dynamicChangesPersonalityAffectors = {
		PersonalityStat.Mean: 0.3,
		PersonalityStat.Coward: -0.2,
	}

func getVisibleName():
	return "Секс в бессознательном состоянии"

func getGoals(_sexEngine, _domFetishHolder, _dom, _sub):
	var possible = []
	
	return possible
