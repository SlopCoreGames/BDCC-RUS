extends MissionBase

func _init():
	id = "SideMission4"
	name = "Лабораторная крыса"
	desc = "Avy and Ferri seem to be having some kind of argument."
	
	startScene = "DomSM4"
	requiredMissions = ["Mission4"]
	
	flags = {
		"punish": flag(FlagType.Text), # "ferri" "avy"
	}
	
	decisions = {
		"punish": {
			name = "Кто наказан",
			outcomes = {
				"ferri": {
					text = "Ферри",
					effects = [
						DECISION_EFFECT_AVY_LOVE,
					],
					avyLine = "That brat got what she deserved! She is just our slave.",
				},
				"avy": {
					text = "Эви",
					effects = [
						DECISION_EFFECT_AVY_OBEDIENCE,
					],
					avyLine = "Don't look at me like that. Shut up. Grr-r.",
				},
			},
		}
	}
	
	addAsAQuest = false
	sideMission = true
	
	rewardExp = 150
	rewardCredits = 0
	rewardRepeatRate = 0.0
