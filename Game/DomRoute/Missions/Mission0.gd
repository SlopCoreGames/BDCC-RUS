extends MissionBase

func _init():
	id = "Mission0"
	name = "Рахи — воровка"
	desc = "Вербуй Рахи!"
	
	startScene = "DomM0RahiBreakIntroScene"
	
	flags = {
		"kait": flag(FlagType.Text), # "assert", "allow"
	}
	
	decisions = {
		"kait": {
			name = "Кейт отобрала поводок у Рахи",
			outcomes = {
				"assert": {
					text = "Проявил характер",
					effects = [
						DECISION_EFFECT_KAIT_OBEDIENCE,
					],
					kaitLine = "Эй.. эм.. тебе стоит была сказать, прежде чем я взял поводок Рахи, ты права.",
				},
				"allow": {
					text = "Позволил это сделать",
					effects = [
						DECISION_EFFECT_KAIT_LOVE,
					],
					kaitLine = "Теперь у нас есть личная воровка. И довольно миленькая. Не терпится увидеть её в деле.",
				},
			},
		}
	}
	
	rewardExp = 20
	rewardCredits = 0
	addAsAQuest = false

func getObjectives() -> Array:
	var result:Array = []
	
	return result
