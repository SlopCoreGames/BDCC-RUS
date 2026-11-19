extends RecruitBase

func _init():
	id = "Eliza"
	charID = "eliza"
	difficulty = RecruitDifficulty.Medium
	talkScene = id+"RecTalk"
	nextStoryScene = "DomM4s4End"
	choices = [
		{
			id = "tone",
			name = "Тон",
			desc = "В каком тоне ты хочешь общаться с Элизой?",
			options = [
				["silent", "Молчание", "Устроить Элизе почти полное игнорирование", RecruitChoiceResult.Red],
				["mean", "Злобность", "Говорить Элизе гадости и пошлости", RecruitChoiceResult.Yellow],
				["degrade", "Унижение", "Разговаривать с Элизой уничижительным тоном", RecruitChoiceResult.Green],
			],
		},
		{
			id = "main",
			name = "Основное действие",
			desc = "Каким должно быть основное действие?",
			options = [
				["bloodplay", "Бладплей", "Использовать что-то острое, чтобы пустить Элизе кровь", RecruitChoiceResult.Green],
				["cuddling", "Объятия", "Обниматься с Элизой", RecruitChoiceResult.Red],
				["sex", "Секс", "Трахать Элизу всухую", RecruitChoiceResult.Yellow],
			],
		},
		{
			id = "special",
			name = "Особая фишка",
			desc = "Какой особый кинк ты хочешь добавить?",
			options = [
				["druguse", "Употребление наркотиков", "Использовать наркотики Элизы против неё самой", RecruitChoiceResult.Green],
				["choke", "Удушение", "Поиграть с её способностью дышать", RecruitChoiceResult.Yellow],
				["deny", "Запрет на оргазм", "Довести Элизу до пика, а затем полностью лишить её оргазма", RecruitChoiceResult.Red],
			],
		},
	]

func getExtraChoices(_choices:Array, _extras:Dictionary) -> Array:
	var result:Array = []
	if(_choices[1] == "sex"):
		if(GM.pc.hasReachablePenis()):
			pass
#			result.append({
#					id = "condom",
#					name = "Condom",
#					desc = "Pick which condom you want to use, if any",
#					options = [
#						["no", "No condom", "Don't use a condom"],
#						["worst", "Worst condom", "Use the worst condom you have"],
#						["best", "Best condom", "Use the best condom you have"],
#					],
#				})
		else:
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
	if(_choices[1] == "bloodplay"):
		if(_choices[2] == "druguse"):
			return "ElizaRecSceneBloodplayDruguse"
		if(_choices[2] == "choke"):
			return "ElizaRecSceneBloodplayBreathplay"
		if(_choices[2] == "deny"):
			return "ElizaRecSceneBloodplayOrgasmDenial"
	if(_choices[1] == "cuddling"):
		if(_choices[2] == "druguse"):
			return "ElizaRecSceneCuddlingDruguse"
		if(_choices[2] == "choke"):
			return "ElizaRecSceneCuddlingBreathplay"
		if(_choices[2] == "deny"):
			return "ElizaRecSceneCuddlingOrgasmDenial"
	if(_choices[1] == "sex"):
		if(_choices[2] == "druguse"):
			return "ElizaRecSceneSexDrugUse"
		if(_choices[2] == "choke"):
			return "ElizaRecSceneSexBreathplay"
		if(_choices[2] == "deny"):
			return "ElizaRecSceneSexOrgasmDenial"
	return "PlaceholderRecruitScene"

func getPresenterCharID() -> String:
	return "avy"

func getPresenterDialogue() -> String:
	return "Может, сломать эту задротку?"
