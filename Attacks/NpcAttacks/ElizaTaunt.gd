extends Attack

func _init():
	id = "ElizaTaunt"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Насмешка Элизы"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Мысли о том, что сказала Элиза, вызывают у вас возбуждение..."
	return {
		text = text,
		lust = 20,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} на мгновение перестает сражаться и вместо этого одаривает вас лукавой улыбкой."

	text += "\n\n"
	text += "[say=eliza]"+RNG.pick([
		"I can make you feel pleasure like you never did, you gonna cum so much that you will forget everything else~",
		"I see that you don’t like this place, I can turn it into a better one with a gas mask and one special gas, just quit fighting~",
		"So many prototypes to try, don’t deny yourself the opportunity to feel good, raise your hands up~.",
		"I can give you a true purpose, to produce milk, like a good cow. It will feel so-o good, I promise~. And I get better coffee in the mornings~.",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "LustButt"
