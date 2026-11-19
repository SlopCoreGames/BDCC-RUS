extends Attack

func _init():
	id = "HeatGrenade"
	category = Category.Lust
	aiCategory = AICategory.Lust
	aiScoreMultiplier = 0.8
	
func getVisibleName(_context = {}):
	return "Тепловая граната"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Lust)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Lust)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "Вдыхая розовый туман, ты чувствуешь, как возбуждение нарастает, а в голове роятся грязные мысли. Возможно, сдаться — не такая уж плохая идея..."
	return {
		text = text,
		lust = 30,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} достает какую-то гранату и выдергивает чеку. Затем {attacker.he} бросает ее в твою сторону. Ты видишь, как в воздухе за ней тянется [b]розовый дымный[/b] шлейф!"

func getAttackSoloAnimation():
	return "throw"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
