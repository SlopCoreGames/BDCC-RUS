extends Attack

func _init():
	id = "stretchingAttack"
	category = Category.Lust
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.5
	
func getVisibleName(_context = {}):
	return "Растяжка"
	
func getVisibleDesc(_context = {}):
	return "Тебе не стоит этого видеть"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var texts = [
		"{attacker.name} тратит {attacker.his}, прогибаясь в {attacker.his} и потягиваясь. Пока {attacker.he} это делает, от {attacker.name} слышны несколько милых стонов."
	]
	var text = RNG.pick(texts)
	
	_attacker.addPain(-30)
	
	text += " {attacker.name} чувствует себя лучше!"
	
	return {
		text = text,
		lust = RNG.randi_range(20, 20),
	}

func canBeDodgedByPlayer(_attacker, _receiver):
	return true

func getAnticipationText(_attacker, _receiver):
	return RNG.pick([
		"Похоже, {attacker.name} сейчас начнет потягиваться!",
	])

func getRequirements():
	return [[AttackRequirement.Stamina, 20]]

func getAttackSoloAnimation():
	return "LustStretchAttack"
