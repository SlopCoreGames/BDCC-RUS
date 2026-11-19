extends Attack

func _init():
	id = "FerriTaunt"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Насмешка Ферри"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
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
		"I won’t stop biting, give up!",
		"My claws are gonna leave some nice scratch marks on your back.",
		"You won’t break me!",
		"You are a brat! Not me!",
		"I won’t stop resisting even if you tie me up and put a vibe to my crotch! Well, maybe I will.. Mew..",
	])+"[/say]"

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "TauntPoint"
