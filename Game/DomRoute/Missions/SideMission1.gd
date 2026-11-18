extends MissionBase

func _init():
	id = "SideMission1"
	name = "На мели"
	desc = "Avy needs your help with returning a debt."
	
	startScene = "DomSM1"
	requiredMissions = ["Mission1"]
	
	flags = {
		"avy": flag(FlagType.Text), # "allow", "stopped"
	}
	
	decisions = {
		"avy": {
			name = "Остановил Эви",
			outcomes = {
				"allow": {
					text = "No",
					effects = [
						DECISION_EFFECT_AVY_LOVE,
					],
					avyLine = "Thanks for the help. I didn't really need it but who knows.",
				},
				"stopped": {
					text = "Да",
					effects = [
						DECISION_EFFECT_AVY_OBEDIENCE,
					],
					avyLine = "You gotta break some fingers sometimes.. Otherwise people don't pay. It's also fun, you know? Oh well.",
				},
			},
		}
	}
	
	addAsAQuest = false
	sideMission = true
	
	rewardExp = 10
	rewardCredits = 10
	rewardRepeatRate = 0.0
