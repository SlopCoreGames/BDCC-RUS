extends Attack

func _init():
	id = "DestroyRestraintsAttack"
	category = Category.Physical
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 2.0
	
func getVisibleName(_context = {}):
	return "Разрушение оков"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "С сокрушительной мощью, {attacker.name} [b] вырывается из всех БДСМ-оков[/b], сковывавших тело {attacker.his}. Цепи разлетаются вдребезги, а путы рассыпаются под непреклонной силой {attacker.his}, оставляя {attacker.name} на свободе и без всяких преград."
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick(["Fuck your shit.", "You think this will stop me? You're so stupid.", "HAHAHA, PATHETIC."])+"[/say]"
	text += "\n\n"
	text += "{attacker.name} prepares to avoid any other attack."
	
	_attacker.removeAllRestraints()
	_attacker.addEffect(StatusEffect.Evading, [1])
	_attacker.addEffect(StatusEffect.Defocussing, [1])
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_attacker.getInventory().getEquippedItemsWithTag(ItemTag.BDSMRestraint).size() < 2):
		return false
	return true

func getAttackSoloAnimation():
	return "RemoveAllRestraints"

func getRequirements():
	return [[AttackRequirement.Stamina, 100]]#[AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func canBeDodgedByPlayer(_attacker, _receiver):
	return false
