extends Attack

func _init():
	id = "lickWounds"
	category = Category.Lust
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.4
	
func getVisibleName(_context = {}):
	return "лизать раны"
	
func getVisibleDesc(_context = {}):
	return "Тебе не стоит этого видеть"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var texts = [
		"{attacker.name} вылизывает синяки {attacker.his}, что заметно облегчает боль."
	]
	var text = RNG.pick(texts)
	
	_attacker.addPain(-30)
	
	text += " {attacker.name} чувствует себя лучше!"
	
	return {
		text = text,
	}

func canBeDodgedByPlayer(_attacker, _receiver):
	return false

func getRequirements():
	return [[AttackRequirement.Stamina, 50], AttackRequirement.CanBite]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "LickWounds"
