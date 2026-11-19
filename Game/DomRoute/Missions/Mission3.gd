extends MissionBase

func _init():
	id = "Mission3"
	name = "Просто лабораторная рутина"
	desc = "Вы завербовали Ферри, химика-драката. Но теперь вам нужно обустроить для неё химическую лабораторию."
	
	startScene = "DomM3s1Intro"
	requiredMissions = ["Mission2"]
	
	flags = {
		"s1": flag(FlagType.Bool), # Did we start the first search for the storage room
		"s2": flag(FlagType.Bool), # Found the room. But now we need to find a badge in the showers room
		"s3": flag(FlagType.Bool), # Got the badge, gotta return back
		"nurse": flag(FlagType.Text), # "letgo", "reward", "break"
		"scarlet": flag(FlagType.Text), # "nothing", "nothingpeek", "shower", "finger", "fuck", "fuckpullout"
	}
	
	decisions = {
		"nurse": {
			name = "Исход для медсестры",
			outcomes = {
				"letgo": {
					text = "Отпустить",
					effects = [
						#DECISION_EFFECT_KAIT_OBEDIENCE,
					],
					kaitLine = "Отпустить её было глупо. Я не хочу врать людям. Если я обещал той медсестре награду, значит, мы должны были её получить.",
					avyLine = "Отпустить эту сучку было тупо. Если она заговорит, клянусь...",
				},
				"reward": {
					text = "Награда",
					effects = [
						DECISION_EFFECT_KAIT_LOVE,
					],
					kaitLine = "Я уверен, что медсестра теперь не проболтается. Не после того, что мы с ней сотворили~.",
					avyLine = "Надеюсь, ты повеселился с той сучкой. И со второй тоже.",
				},
				"break": {
					text = "Сломленная",
					effects = [
						DECISION_EFFECT_AVY_LOVE,
					],
					kaitLine = "Надеюсь, ты не прикончил девчонку. Я не хочу врать людям. Если я обещал той медсестре награду, значит, мы должны были её получить.",
					avyLine = "Знаешь что, это было весело. Нам стоит ломать людей чаще.",
				},
			},
		}
	}
	
	rewardExp = 100
	rewardCredits = 10

func onMissionStart():
	setMissionMarker("med_lobby_start")

func getObjectives() -> Array:
	var result:Array = []
	
	result.append("Встреть свою команду в медицинском лобби. Используй лифт, чтобы спуститься в медицинское крыло.")
	if(getFlag("s1", false)):
		result.append("Найди медицинский склад. Он должен быть где-то в зоне для персонала.")
	if(getFlag("s2", false)):
		result.append("Склад заперт! Тебе нужно найти рабочий пропуск где-нибудь рядом с душевыми в медицинском крыле!")
	if(getFlag("s3", false)):
		result.append("Пропуск у тебя, возвращайся к складу!")
	
	return result

func getStartSceneButtonsLoc(_loc:String) -> Array:
	#if(!getFlag("s2", false) && _loc == "cellblock_red_nearcell"): # Check flags
	#	return [startSceneButton("DomM2s2", [], "Mission", "Meet your team here and look for Ferri!")]
	
	return []

func onSceneStart(_sceneID:String, _args:Array):
	if(_sceneID == "DomM3s2Lobby"):
		setFlag("s1", true)
		setMissionMarker("med_near_storage")
		GM.main.IS.spawnPawnWithTypeAt(CharacterType.Nurse, "med_corridor5")
		GM.main.IS.spawnPawnWithTypeAt(CharacterType.Nurse, "med_corridor_split2")
	if(_sceneID == "DomM3s3StorageLocked"):
		setFlag("s2", true)
		setMissionMarker("med_nearshower")
		GM.main.IS.spawnPawnWithTypeAt(CharacterType.Nurse, "med_corridor4")
	if(_sceneID == "DomM3s4Shower"):
		setFlag("s3", true)
		setMissionMarker("med_near_storage")
		GM.main.IS.spawnPawnWithTypeAt(CharacterType.Nurse, "med_corridor4")
		GM.main.IS.spawnPawnWithTypeAt(CharacterType.Nurse, "med_corridor6")
	if(_sceneID == "DomM3s5Return"):
		clearMissionMarkers()
	pass

func onSimpleScene(_eventID:String, _args:Array, _scene):
	if(_eventID == "roomlocked"):
		GM.pc.setLocation("med_near_storage")
	if(_eventID == "roomleaveleft"):
		GM.pc.setLocation("med_nearlab")
	if(_eventID == "roomleaveright"):
		GM.pc.setLocation("medical_nearconfessionary")

func getEventSceneLoc(_loc:String) -> Array:
	if(_loc == "medical_storage"):
		return ["MissionSimpleScene", ["Ты пытаешься войти на склад, но он заперт! И тогда ты возвращаешься назад...", "roomlocked", []]]
	if(getFlag("s1", false)):
		if(_loc == "med_staffonly_door1"):
			return ["MissionSimpleScene", ["Если ты уйдешь, то больше не сможешь попасть в эту зону. Так что ты остаешься.", "roomleaveleft", []]]
		if(_loc == "med_staffonly_door2"):
			return ["MissionSimpleScene", ["Если ты уйдешь, то больше не сможешь попасть в эту зону. Так что ты остаешься.", "roomleaveright", []]]
		
	if(!getFlag("s1", false)):
		if(_loc == "med_lobby_start"):
			return ["DomM3s2Lobby", []]
	elif(!getFlag("s2", false)):
		if(_loc == "med_near_storage"):
			return ["Склад_Доминант_Миссия3_Заперт", []]
	elif(!getFlag("s3", false)):
		if(_loc == "med_nearshower"):
			return ["Доминант_Миссия4_Душ", []]
	else:
		if(_loc == "med_near_storage"):
			return ["Доминант_Миссия5_Возвращение", []]
	return [] # [sceneid, args]
