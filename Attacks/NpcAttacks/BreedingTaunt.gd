extends Attack

func _init():
	id = "BreedingTaunt"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Брачный насмешливый выпад"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Ты чувствуешь возбуждение, вспоминая то, что сказал(а) {attacker.name}..."
	return {
		text = text,
		lust = RNG.randi_range(40, 50),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} сжимает и ласкает {attacker.his}, демонстрируя это {receiver.name}."

	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Если хочешь, чтобы тебя оттрахали, просто попроси.",
		"Просто наклонись, тебе понравится.",
		"Видишь это? Хватит лишать себя удовольствия.",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "LustCockTaunt"
