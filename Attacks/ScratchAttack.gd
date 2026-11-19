extends Attack

func _init():
	id = "scratchattack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Царапанье"
	
func getVisibleDesc(_context = {}):
	return "Вы царапаете врага на "+scaledDmgRangeStr(DamageType.Physical, 5, 15)+" ед. урона. С вероятностью 50% вызывает кровотечение"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver, "scratch")
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "scratch")
	
	var texts = [
		"{attacker.name} вонзает {attacker.his} когти в {receiver.name}, оставляя глубокие царапины",
		"{attacker.name} царапает {receiver.name}, используя {attacker.his} когти",
	]
	var text = RNG.pick(texts)
	if(RNG.chance(50) && !_receiver.hasEffect(StatusEffect.Bleeding) && _receiver.addEffect(StatusEffect.Bleeding)):
		text += " из-за чего у {receiver.him} начинается [color=red]кровотечение[/color]"
	
	return {
		text = text,
		pain = RNG.randi_range(5, 15),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAttackSoloAnimation():
	return "punch"

func getExperience():
	return [[Skill.Combat, 10]]

func getRequirements():
	return [AttackRequirement.FreeArms]
