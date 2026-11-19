extends MissionBase

func _init():
	id = "Mission2"
	name = "Свирепый"
	desc = "Список имен у тебя на руках. Пора решить, кого ты завербуешь следующим!"
	
	startScene = "DomM2s1Intro"
	requiredMissions = ["Mission1"]
	
	flags = {
		"s2": flag(FlagType.Bool), # Did we catch Ferri
		"fight": flag(FlagType.Text), # "let", "stop"
	}
	
	decisions = {
		"fight": {
			name = "Разрешенная драка",
			outcomes = {
				"let": {
					text = "Да",
					effects = [
						DECISION_EFFECT_KAIT_OBEDIENCE,
					],
					kaitLine = "Какая же гребаная шлюха! Не Ферри, в смысле... она милашка. Я про Эви. Гррр...",
					avyLine = "Кейт такая мягкая, тебе стоит задирать её посильнее. Прямо как я.",
				},
				"stop": {
					text = "No",
					effects = [
						DECISION_EFFECT_AVY_OBEDIENCE,
					],
					kaitLine = "Ты показала этой сучке её место! Не Ферри, в смысле... она милашка. Я про Эви.",
					avyLine = "Знаю, надо было помочь, не обязательно напоминать об этом постоянно. У меня была веская причина, ясно?",
				},
			},
		}
	}
	
	rewardExp = 50
	rewardCredits = 5

func onMissionStart():
	setMissionMarker("cellblock_red_nearcell")

func getObjectives() -> Array:
	var result:Array = []
	
	result.append("Чтобы найти Ферри, встреться со своей командой в секторе камер высокого уровня безопасности!")
	if(getFlag("s2", false)):
		result.append("Ферри у тебя! Теперь тебе нужно её сломать.")
	
	return result

func getStartSceneButtonsLoc(_loc:String) -> Array:
	if(!getFlag("s2", false) && _loc == "cellblock_red_nearcell"): # Check flags
		return [startSceneButton("DomM2s2", [], "Миссия", "Встречайся здесь со своей командой и ищи Ферри!")]
	
	return []

func onSceneStart(_sceneID:String, _args:Array):
	if(_sceneID == "DomM2s2"):
		setFlag("s2", true)
