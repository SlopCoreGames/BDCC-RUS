extends Attack

func _init():
	id = "AxisTaunt"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Насмешка Аксиса"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Ты чувствуешь возбуждение..."
	return {
		text = text,
		lust = RNG.randi_range(30, 40),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} вовсю играет {attacker.his} мышцами на виду у всех. Вау, {attacker.he} чертовски сексуальна!"

	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Да ладно, я же вижу, как ты этого хочешь.",
		"От твоего сопротивления мой член только сильнее встаёт.",
		"Иногда даже мне хочется, чтобы меня самого оттрахали.",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "LustStretchAttack"
