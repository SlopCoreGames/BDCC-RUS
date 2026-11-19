extends Attack

func _init():
	id = "FerriTaunt"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Насмешка Ферри"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Насмешки Ферри на тебя никак не подействовали"
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "Ферри рычит на тебя и полосует воздух когтями."

	text += "\n\n"
	text += "[say=ferri]"+RNG.pick([
		"Я не перестану кусаться, сдавайся!",
		"Мои когти оставят на твоей спине отличные царапины.",
		"Тебе меня не сломить!",
		"Это ты ещё сопляк! А не я!",
		"Я не перестану сопротивляться, даже если ты свяжешь меня и засунешь вибратор мне в промежность! Ну, может, и перестану... Мяу...",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "TauntPoint"
