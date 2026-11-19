extends MissionBase

func _init():
	id = "SideMission1"
	name = "На мели"
	desc = "Ави нужна твоя помощь с возвратом долга."
	
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
					avyLine = "Спасибо за помощь. На самом деле она была не особо нужна, но кто знает.",
				},
				"stopped": {
					text = "Да",
					effects = [
						DECISION_EFFECT_AVY_OBEDIENCE,
					],
					avyLine = "Иногда приходится переломать пару пальцев... Иначе люди не платят. Да и само по себе это весело, понимаешь? Ну да ладно.",
				},
			},
		}
	}
	
	addAsAQuest = false
	sideMission = true
	
	rewardExp = 10
	rewardCredits = 10
	rewardRepeatRate = 0.0
