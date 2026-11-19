extends MissionBase

func _init():
	id = "SideMission4"
	name = "Лабораторная крыса"
	desc = "Кажется, Эви и Ферри о чем-то спорят."
	
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
					avyLine = "Эта дрянь получила по заслугам! Она всего лишь наша рабыня.",
				},
				"avy": {
					text = "Эви",
					effects = [
						DECISION_EFFECT_AVY_OBEDIENCE,
					],
					avyLine = "Не смотри на меня так. Заткнись. Гррр.",
				},
			},
		}
	}
	
	addAsAQuest = false
	sideMission = true
	
	rewardExp = 150
	rewardCredits = 0
	rewardRepeatRate = 0.0
