extends MissionBase

func _init():
	id = "SideMission3"
	name = "Приземление на Землю"
	desc = "Анс хотела немного с тобой поболтать."
	
	startScene = "DomSM3"
	requiredMissions = ["Миссия 3"]
	
	flags = {
		#"kait": flag(FlagType.Text), # "pat", "strict"
	}
	
	decisions = {
#		"kait": {
#			name = "Your reaction",
#			outcomes = {
#				"pat": {
#					text = "Praised Kait",
#					effects = [
#						DECISION_EFFECT_KAIT_LOVE,
#					],
#					kaitLine = "Can't believe I somehow walked around the whole prison naked. You could have stopped me!",
#				},
#				"strict": {
#					text = "Had a strict talk with Kait",
#					effects = [
#						DECISION_EFFECT_KAIT_OBEDIENCE,
#					],
#					kaitLine = "Can't believe I somehow walked around the whole prison naked. I guess it was worth it in the end.",
#				},
#			},
#		}
	}
	
	addAsAQuest = false
	sideMission = true
	
	rewardExp = 100
	rewardCredits = 0
	rewardRepeatRate = 0.0
