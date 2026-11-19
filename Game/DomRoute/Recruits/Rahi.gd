extends RecruitBase

func _init():
	id = "Rahi"
	charID = "rahi"
	difficulty = RecruitDifficulty.VeryEasy
	talkScene = id+"RecTalk"
	nextStoryScene = "DomM0RahiBreakAfterScene"
	choices = [
		{
			id = "tone",
			name = "Тон",
			desc = "В каком тоне ты хочешь общаться с Рахи?",
			options = [
				["gentle", "Нежный", "Говорить с Рахи очень добрым тоном", RecruitChoiceResult.Red],
				["strict", "Строго", "Говорить с Рахи строгим тоном", RecruitChoiceResult.Yellow],
				["mean", "Злобность", "Говорить Рахи гадости и пошлости", RecruitChoiceResult.Green],
			],
		},
		{
			id = "main",
			name = "Основное действие",
			desc = "Каким должно быть основное действие?",
			options = [
				["sex", "Секс", "Заняться сексом с Рахи", RecruitChoiceResult.Yellow],
				["petplay", "Петплей", "Устроить небольшой петплей с Рахи", RecruitChoiceResult.Green],
				["pain", "Плей с болью", "Сделать так, чтобы она почувствовала боль", RecruitChoiceResult.Red],
			],
		},
		{
			id = "special",
			name = "Особая фишка",
			desc = "Какой особый кинк ты хочешь добавить?",
			options = [
				["public", "На людях", "Сделать это на людях", RecruitChoiceResult.Yellow],
				["bondage", "Бондаж", "Добавить много бондажа", RecruitChoiceResult.Green],
				["anal", "Акцент на анал", "Сделать огромный упор на анал", RecruitChoiceResult.Red],
			],
		},
	]

func getExtraChoices(_choices:Array, _extras:Dictionary) -> Array:
	var result:Array = []
	if(_choices[1] == "sex"):
		if(GM.pc.hasReachablePenis()):
			result.append({
					id = "condom",
					name = "Презерватив",
					desc = "Выбери презерватив, если собираешься использовать",
					options = [
						["no", "Без презерватива", "Don't use a condom"],
						["worst", "Худший презерватив", "Используй самый хреновый презерватив, какой есть"],
						["best", "Лучший презерватив", "Используй самый лучший презерватив, какой есть"],
					],
				})
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
	if(_choices[1] == "sex"):
		if(_choices[2] == "public"):
			return "RahiRecSceneSex"
		if(_choices[2] == "bondage"):
			return "RahiRecSceneSexBondage"
		if(_choices[2] == "anal"):
			return "RahiRecSceneSexAnal"
	if(_choices[1] == "petplay"):
		if(_choices[2] == "public"):
			return "RahiRecScenePetplayPublic"
		if(_choices[2] == "bondage"):
			return "RahiRecScenePetplayBondage"
		if(_choices[2] == "anal"):
			return "RahiRecScenePetplayAnal"
	if(_choices[1] == "pain"):
		if(_choices[2] == "public"):
			return "RahiRecScenePainPublic"
		if(_choices[2] == "bondage"):
			return "RahiRecScenePainBondage"
		if(_choices[2] == "anal"):
			return "RahiRecScenePainAnal"
	return "PlaceholderRecruitScene"
