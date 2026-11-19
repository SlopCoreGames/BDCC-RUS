extends ContentBoardEntryBase

func _init():
	id = "Artica"
	
func getName() -> String:
	return "Артика"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Развратите очень застенчивую пушистую герме Артику Спаркл. В этом контенте основной упор сделан на развращение, ласки лапками, разведение, целомудрие и тентакли."
	return "Разврати очень скромного пушистого герма."

func getKinks() -> Array:
	return [
		"Игрок доминирует",
		"Развращение",
		"Pawplay/Pawjobs",
		"Бридинг",
		"Chastity (optional)",
		"Гипноз",
		"Тентакли",
		"Растяжка",
		"Автофелляция",
		"Дойка",
		"Noncon (optional)",
	]

func getCompletedDesc() -> String:
	if(getFlag("ArticaModule.LQArticaGotDreamCatcher")):
		return "Артика счастлива, ведь вы нашли её ловца снов! Теперь она ваша!"
	if(getFlag("ArticaModule.LQArticaGotBrainwashed", false)):
		if(getFlag("ArticaModule.CurvyForm", false)):
			return "Теперь Артика — ваша счастливая шлюшка! Вы даже сделали её тело ещё более изгибистым!"
		return "Теперь Артика — ваша счастливая шлюшка!"
	return ""

func getStatus() -> int:
	if(getFlag("ArticaModule.LQArticaGotDreamCatcher", false) || getFlag("ArticaModule.LQArticaGotBrainwashed", false)):
		return ContentBoardStatus.Completed
	if(getFlag("ArticaModule.corruptionBegan", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIfBool(GM.pc.getSkillsHolder().getLevel() >= 10), "Достигните 10 уровня."],
		[completeIf("ArticaModule.s0happened"), "Посмотрите на прибытие Артики, находясь рядом с контрольно-пропускным пунктом."],
		[completeIf("ArticaModule.s1happened"), "Сначала найдите Артику в сиреневом блоке камер."],
		[completeIf("ArticaModule.s2happened"), "Следующим делом найди Артику в столовой."],
		[completeIf("ArticaModule.corruptionBegan"), "Заходи к Артике в столовую каждый день."],
	]

func getProgressText() -> String:
	return "Заведи Артику, подразни её, а затем постой неподалеку и посмотри, что она будет делать."
