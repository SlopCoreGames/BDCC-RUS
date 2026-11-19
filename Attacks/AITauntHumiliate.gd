extends Attack

func _init():
	id = "aitaunthumiliate"
	category = Category.Humiliation
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Насмешка (Унижение)"
	
func getVisibleDesc(_context = {}):
	return "Тебе не стоит этого видеть"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var attackerName = _attacker.getName()
	var receiverName = _receiver.getName()
	
	var texts = [
		attackerName + " смеется над " + receiverName +" и издевается над "+_attacker.formatSay("Да ладно тебе, ты слишком слабенькая, чтобы победить меня!"),
		attackerName + " rubs " + _attacker.hisHer() +" хлопает в ладоши и говорит "+_attacker.formatSay("Ты будешь стоять передо мной на коленях и умолять, чтобы я тебя коснулась~"),
		attackerName + " тычет пальцем в " + receiverName +" и издевается над "+_attacker.formatSay("Ты такая милашка, зачем ты вообще пытаешься драться?"),
		attackerName + " says "+_attacker.formatSay("Ну же, ударь меня! Ты такая прелесть, когда злишься"),
	]
	var text = RNG.pick(texts)
	
	return {
		text = text,
	}

func canBeDodgedByPlayer(_attacker, _receiver):
	return false

func getAIScore(_attacker, _receiver):
	if(_attacker.hasEffect(StatusEffect.Collapsed)):
		return 0.0
	return min(0.5, .getAIScore(_attacker, _receiver) * 0.8)

func getRequirements():
	return [AttackRequirement.CanTalk]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "TauntLustComeHere"
