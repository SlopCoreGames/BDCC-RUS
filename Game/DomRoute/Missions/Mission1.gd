extends MissionBase

func _init():
	id = "Mission1"
	name = "Бумажный след"
	desc = "Тебе нужно раздобыть личные дела персонала и заключенных, чтобы вычислить лучших кандидатов для вербовки."
	
	startScene = "DomM1s1Intro"
	
	flags = {
		"check": flag(FlagType.Bool), # Arrived to the checkpoint
		"c1": flag(FlagType.Bool), # Checked cd_office1
		"c2": flag(FlagType.Bool), # Checked cd_office2
		"c3": flag(FlagType.Bool), # Checked cd_office3
		"c4": flag(FlagType.Bool), # Checked cd_office4
		"skar": flag(FlagType.Bool), # Went into cd_near_captain_office
		"skarOutcome": flag(FlagType.Text), # "", "lost", "won", "ridevag", "rideanal", "fuckhim", "ridevagout", "rideanalout"
		"risha": flag(FlagType.Text), # "no", "kiss", "bite", "pp", "vag". How did player punish Risha
		"helped": flag(FlagType.Text), # "avy", "kait"
	}
	
	decisions = {
		"helped": {
			name = "Помогла Кейт",
			outcomes = {
				"avy": {
					text = "No",
					effects = [
						DECISION_EFFECT_AVY_LOVE,
					],
					kaitLine = "Я просил Авю не помогать мне... но она всё равно могла бы что-нибудь придумать!",
					avyLine = "Было довольно весело смотреть, как эту размазню размазали по стенке.",
				},
				"kait": {
					text = "Да",
					effects = [
						DECISION_EFFECT_KAIT_LOVE,
					],
					kaitLine = "Ты спас меня там, в глубине. Спасибо.",
					avyLine = "Было бы куда веселее посмотреть, как эту шлюху размазали по стенке. Ну да ладно.",
				},
			},
		}
	}
	
	rewardExp = 50
	rewardCredits = 3

func onMissionStart():
	setMissionMarker("hall_mainentrance")

func getObjectives() -> Array:
	var result:Array = []
	
	result.append("Встреться со своей командой перед контрольно-пропускным пунктом рядом с лифтом.")
	if(getFlag("check", false)):
		result.append("Обыскивай кабинеты, пока не найдешь нужный!")
	
	return result

func getStartSceneButtonsLoc(_loc:String) -> Array:
	if(!getFlag("check", false) && _loc == "hall_mainentrance"): # Check flags
		return [startSceneButton("DomM1s2Checkpoint", [], "Миссия", "Встречайся с командой здесь и начинай налет!")]
	
	if(getFlag("check", false)):
		for _i in 4:
			var _indx:int = _i + 1 # [1, 2, 3, 4]
			var theStuff:Array = checkOfficeStuff("c"+str(_indx), _loc, "cd_office"+str(_indx))
			if(theStuff):
				return theStuff
		
	return []

func checkOfficeStuff(_flagID:String, _loc:String, _officeLoc:String) -> Array:
	if(_loc != _officeLoc || getFlag(_flagID, false)):
		return []
	if(getAmountOfOfficesChecked() >= 3):
		return [startSceneButton("DomM1s3Office", [], "Кабинет", "Осмотри этот кабинет!")]
	
	return [startSimpleSceneButton(getCheckOfficeText(), "check", [_flagID], "Кабинет", "Осмотри этот кабинет!")]

func onSceneStart(_sceneID:String, _args:Array):
	if(_sceneID == "DomM1s2Checkpoint"):
		setFlag("check", true)
		updateOfficeMarkers()
	if(_sceneID == "DomM1OptionalSkar"):
		setFlag("skar", true)

func updateOfficeMarkers():
	var theMarkers:Array = []
	for _i in 4:
		var _index:int = _i + 1
		if(!getFlag("c"+str(_index), false)):
			theMarkers.append("cd_office"+str(_index))
	setMissionMarkers(theMarkers)

func onSimpleScene(_eventID:String, _args:Array, _scene):
	if(_eventID == "check"):
		setFlag(_args[0], true)
		updateOfficeMarkers()
	if(_eventID == "skarNope"):
		GM.pc.setLocation("cd_last_intersection")

func getEventSceneLoc(_loc:String) -> Array:
	if(_loc == "cd_near_captain_office" && !getFlag("skar", false)):
		return ["DomM1OptionalSkar", []]
	if(_loc == "cd_near_captain_office" && getFlag("skar", false) && getFlag("skarOutcome", "") == ""):
		return ["DomM1OptionalSkarFight", []]
	if(_loc == "cd_near_captain_office" && getFlag("skarOutcome", "") != ""):
		return ["MissionSimpleScene", ["Сюда лучше больше не соваться... и ты разворачиваешься.", "skarNope", []]]
	return [] # [sceneid, args]

func getStartSceneButtonsCharacter(_char:String) -> Array:
	return [
		#startSceneButton("DomM1s2Checkpoint"),
	]

func getAmountOfOfficesChecked() -> int:
	var result:int = 0
	if(getFlag("c1", false)):
		result += 1
	if(getFlag("c2", false)):
		result += 1
	if(getFlag("c3", false)):
		result += 1
	if(getFlag("c4", false)):
		result += 1
	return result

func getCheckOfficeText() -> String:
	var theAm:int = getAmountOfOfficesChecked()
	
	if(theAm == 0):
		return "Ты осматриваешь первый кабинет. Там есть консоль, которой можно воспользоваться, но принтера нет!\n\nПридется проверить остальные кабинеты."
	if(theAm == 1):
		return "Ты осматриваешь второй кабинет. К сожалению, консолей здесь нет.\n\nПридется поискать другую."
	if(theAm == 2):
		return "Ты осматриваешь третий кабинет. Здесь есть и консоль, и принтер! Но, к сожалению, для консоли нужен пароль.\n\nПридется поискать другую."
	return "Ты проверяешь еще один кабинет. В нем есть консоль и принтер! К сожалению, для консоли требуется пароль.\n\nПридется искать другую."
