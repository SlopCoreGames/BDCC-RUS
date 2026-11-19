extends Attack

func _init():
	id = "TaviSeductiveWhispers"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Соблазнительный шепот"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "whispers")
	
	var text = "{attacker.name} шепчет нежные слова на ухо {receiver.name}, отчего у {receiver.his} пробегает дрожь по спине, а сама {receiver.him} чувствует возбуждение и теряет концентрацию."
	return {
		text = text,
		lust = RNG.randi_range(30, 40),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} наклоняется ближе, и голос {attacker.his} звучит как соблазнительный шепот"

	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Let me show you pleasure you've never known..",
		"No need to be shy..",
		"Imagine the ecstasy that awaits if you surrender to me, body and soul..",
		"Why resist me? Let go and lets embrace these sensations together..",
		"Wanna touch me? Just promise that you're gonna be a good {receiver.boy}.."
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "TauntLustLeanIn"
