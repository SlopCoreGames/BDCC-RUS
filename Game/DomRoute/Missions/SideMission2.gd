extends MissionBase

func _init():
	id = "SideMission2"
	name = "Перепрошитая"
	desc = "Кейт пытается починить телевизор в соседней комнате."
	
	startScene = "DomSM2"
	requiredMissions = ["Mission2"]
	
	flags = {
		"kait": flag(FlagType.Text), # "pat", "strict"
	}
	
	decisions = {
		"kait": {
			name = "Твоя реакция",
			outcomes = {
				"pat": {
					text = "Похвалил Кейт",
					effects = [
						DECISION_EFFECT_KAIT_LOVE,
					],
					kaitLine = "Поверить не могу, что я умудрилась пройти через всю тюрьму голышом. Мог бы и остановить меня!",
				},
				"strict": {
					text = "Провел с Кейт строгий разговор",
					effects = [
						DECISION_EFFECT_KAIT_OBEDIENCE,
					],
					kaitLine = "Поверить не могу, что я умудрилась пройти через всю тюрьму голышом. Но, думаю, в итоге оно того стоило.",
				},
			},
		}
	}
	
	addAsAQuest = false
	sideMission = true
	
	rewardExp = 20
	rewardCredits = 0
	rewardRepeatRate = 0.0
