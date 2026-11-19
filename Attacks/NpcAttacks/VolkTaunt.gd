extends Attack

func _init():
	id = "VolkTaunt"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Насмешка Волка"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(RNG.chance(60)):
		var text = "Это странно, но мысли о том, что сказал Волк, почему-то вызывают у тебя возбуждение..."
		return {
			text = text,
			lust = 20,
		}
	else:
		var text = "Странные выходки Волка только оттолкнули тебя"
		return {
			text = text,
			lust = -10,
		}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "Волк облизывает острое лезвие своего оружия и смеется хриплым, прокуренным голосом."

	text += "\n\n"
	text += "[say=volk]"+RNG.pick([
		"Volk will be gentle with prey.",
		"Wanna know about the scars? I can show you.",
		"You’re stuck here. With me. Afraid yet? Well you should.",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true
