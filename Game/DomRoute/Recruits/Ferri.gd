extends RecruitBase

func _init():
	id = "Ferri"
	charID = "ferri"
	difficulty = RecruitDifficulty.Easy
	talkScene = id+"RecTalk"
	nextStoryScene = "DomM2s3"
	choices = [
		{
			id = "tone",
			name = "Тон",
			desc = "В каком тоне ты хочешь разговаривать с Ферри?",
			options = [
				["strict", "Строго", "Говорить с Ферри строгим тоном", RecruitChoiceResult.Green],
				["mean", "Злобность", "Говорить Ферри гадости и пошлости", RecruitChoiceResult.Yellow],
				["degrade", "Унижение", "Использовать унижающий тон с Ферри", RecruitChoiceResult.Red],
			],
		},
		{
			id = "main",
			name = "Основное действие",
			desc = "Каким должно быть основное действие?",
			options = [
				["petplay", "Петплей", "Устроить с Ферри петплей", RecruitChoiceResult.Yellow],
				["milking", "Дойка", "Заставить Ферри лактировать, а затем подоить её", RecruitChoiceResult.Green],
				["oralsex", "Оральный секс", "Заставить Ферри отсосать или облизать твою киску", RecruitChoiceResult.Red],
			],
		},
		{
			id = "special",
			name = "Особая фишка",
			desc = "Какой особый кинк ты хочешь добавить?",
			options = [
				["deny", "Запрет на оргазм", "Довести Ферри почти до оргазма, а затем отказать ей", RecruitChoiceResult.Red],
				["sadism", "Садизм", "Быть садистом с Ферри, заставлять её страдать", RecruitChoiceResult.Yellow],
				["overstim", "Перестимуляция", "Перестимулировать чувства Ферри или заставить её кончать много раз", RecruitChoiceResult.Green],
			],
		},
	]

func getExtraChoices(_choices:Array, _extrasRaw:Dictionary) -> Array:
	var result:Array = []
	if(_choices[1] == "oralsex"):
		var strapCheck:bool = false # A HAACK
		var variantsList:Array = []
		if(GM.pc.hasReachablePenis()):
			variantsList.append([
				"bj", "Отсосать", "Трахни Ферри в рот своим членом!",
			])
		else:
			variantsList.append([
				"strapon", "Blowjob (Strapon)", "Трахни Ферри в рот страпоном!",
			])
			strapCheck = true
		if(GM.pc.hasReachableVagina()):
			variantsList.append([
				"vaginal", "Лизание киски", "Заставь Ферри отсосать тебе!",
			])
		result.append({
				id = "variant",
				name = "Вариант",
				desc = "Выбери, какой именно минет ты хочешь",
				options = variantsList,
			})
		
		if(strapCheck && int(_extrasRaw.get("variant", -1)) == 0):
			result.append({
					id = "strapon",
					name = "Страпон",
					desc = "Выбери, какой страпон хочешь использовать.",
					options = getStraponOptions(),
				})
	return result

func isCombinationPossible(_choices:Array, _extras:Dictionary) -> Array:
	if(_extras.get("condom", "") in ["worst", "best"]):
		if(!GM.pc.hasCondoms()):
			return [false, "У тебя нет презервативов, чтобы это сделать"]
	
	return [true, ""]

func getSceneToPlay(_choices:Array, _extras:Dictionary) -> String:
	if(_choices[1] == "milking"):
		if(_choices[2] == "overstim"):
			return "FerriRecSceneMilkingOverstim"
		if(_choices[2] == "sadism"):
			return "FerriRecSceneMilkingSadism"
		if(_choices[2] == "deny"):
			return "FerriRecSceneMilkingDeny"
	if(_choices[1] == "petplay"):
		if(_choices[2] == "overstim"):
			return "FerriRecScenePetplayOverstim"
		if(_choices[2] == "sadism"):
			return "FerriRecScenePetplaySadism"
		if(_choices[2] == "deny"):
			return "FerriRecScenePetplayDeny"
	if(_choices[1] == "oralsex"):
		if(_choices[2] == "overstim"):
			return "FerriRecSceneOralOverstim"
		if(_choices[2] == "sadism"):
			return "FerriRecSceneOralSadism"
		if(_choices[2] == "deny"):
			return "FerriRecSceneOralDeny"
	return "PlaceholderRecruitScene"
