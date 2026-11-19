extends Attack

func _init():
	id = "AvyDrugHeal"
	category = Category.Physical
	aiCategory = AICategory.DefensivePain
	aiScoreMultiplier = 0.3
	
func getVisibleName(_context = {}):
	return "Лечебный препарат"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Глаза {attacker.name} ярко вспыхивают красным, когда {attacker.he} черпает силу из наркотика, в результате чего {attacker.him} становится сильнее."
	
	_attacker.addPain(-50)
	_attacker.addStamina(50)
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAttackSoloAnimation():
	return "UseSyringe"

func getRequirements():
	return [AttackRequirement.CanSee] # Dis is the weakness

func canBeDodgedByPlayer(_attacker, _receiver):
	return false

func getAIScore(_attacker, _receiver):
	if(_attacker.getInventory().getEquippedItemsWithTag(ItemTag.BDSMRestraint).size() > 2):
		return 1.0
	else:
		return .getAIScore(_attacker, _receiver)
