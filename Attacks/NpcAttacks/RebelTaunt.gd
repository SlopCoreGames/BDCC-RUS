extends Attack

func _init():
	id = "RebelTaunt"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Насмешка повстанца"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Насмешки повстанца никак не задели вас"
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} напрягает {attacker.his} мышцы и издает яростный рев."

	text += "\n\n"
	text += "[say=rebel]"+RNG.pick([
		"Гляньте на них. Вам крышка.",
		"Сучка, я тебя раздавлю.",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "LustStretchAttack"
