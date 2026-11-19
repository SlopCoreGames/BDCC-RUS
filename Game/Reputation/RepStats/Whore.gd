extends RepStatBase

func _init():
	id = RepStat.Whore

func getVisibleName():
	return "Репутация шлюхи"

func getMaxLevel() -> int:
	return 9

func getMinLevel() -> int:
	return -1

# Opposite of Alpha is Doormat
func getTextForLevel(_level:int, _rep):
	if(_level <= -1):
		return "Unstained"
	if(_level == 0):
		return "Unknown"
	if(_level == 1):
		return "Tease"
	if(_level == 2):
		return "Мелкая шлюшка"
	if(_level == 3):
		return "Slut-in-Training"
	if(_level == 4):
		return "Местная шлюха"
	if(_level == 5):
		return "Prison's Bicycle"
	if(_level == 6):
		return "Заправская шлюха"
	if(_level == 7):
		return "Cumdump"
	if(_level == 8):
		return "Prison's Whore"
	if(_level >= 9):
		return "Знаменитая тюремная шлюха"
	return "WHORE"

func getSpecialRequirementToReachLevel(_level:int, _rep):
	if(_level == 3):
		return ["befuckedstocks", "Трахаться в колодках"]
	if(_level == 5):
		return ["whoreany", "Ублажать клиента, как настоящая шлюха"]
	if(_level == 7):
		return ["befuckedslutwall", "Быть частью стены из шлюх"]
	if(_level == 9):
		return ["whorelot", "Заработать минимум 30 кредитов с одного клиента в роли шлюхи"]
	
	return null

func getEffectsInfoForLevel(_level:int, _rep) -> Array:
	if(_level <= 1):
		return []
	if(_level <= 2):
		return [
			"Другие с чуть большей вероятностью согласятся трахнуть вас.",
		]
	if(_level <= 3):
		return [
			"Другие с чуть большей вероятностью согласятся трахнуть вас.",
			"В статусе шлюхи вы получаете чуть больше кредитов.",
		]
	if(_level <= 4):
		return [
			"Другие с чуть большей вероятностью согласятся трахнуть вас.",
			"В статусе шлюхи вы получаете чуть больше кредитов.",
			"Вы можете предлагать клиентам услуги доминантной шлюхи.",
		]
	if(_level <= 7):
		return [
			"Другие охотнее соглашаются трахнуть вас.",
			"В статусе шлюхи вы получаете чуть больше кредитов.",
			"Вы можете предлагать клиентам услуги доминантной шлюхи.",
		]
	if(_level <= 8):
		return [
			"Другие охотнее соглашаются трахнуть вас.",
			"В статусе шлюхи вы получаете чуть больше кредитов.",
			"Вы можете предлагать клиентам услуги доминантной шлюхи.",
			"В проституции для вас разблокирована опция «Дорогая шлюха».",
		]
	return [
		"Люди так и жаждут трахнуть тебя.",
		"Чем больше ты шлюха, тем больше кредитов получаешь.",
		"Вы можете предлагать клиентам услуги доминантной шлюхи.",
		"В проституции для вас разблокирована опция «Дорогая шлюха».",
	]
