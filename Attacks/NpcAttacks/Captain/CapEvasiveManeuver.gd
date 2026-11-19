extends Attack

func _init():
	id = "CapEvasiveManeuver"
	category = Category.Physical
	aiCategory = AICategory.DefensivePain
	aiScoreMultiplier = 0.5
	
func getVisibleName(_context = {}):
	return "Уклоняющийся маневр"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "{attacker.name} шире расставляет {attacker.his} ноги и руки, готовясь уклониться от любых входящих атак."
	
	_attacker.addEffect(StatusEffect.Evading, [2])
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_attacker.hasEffect(StatusEffect.Evading)):
		return false
	return true

#func getAttackSoloAnimation():
#	return "punch"

func getRequirements():
	return [[AttackRequirement.Stamina, 25]]#[AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func canBeDodgedByPlayer(_attacker, _receiver):
	return false

func getAttackSoloAnimation():
	return "DodgePrepare"
