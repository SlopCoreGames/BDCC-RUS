extends Attack

func _init():
	id = "LuxeEnragedSlam"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Яростный удар"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.5)
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.5)
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "С яростным ревом {attacker.name} хватает тебя за руку и швыряет в ближайшую стену. От удара по поверхности разлетаются трещины, а по твоему телу проносится взрыв боли, заставляя тебя задыхаться и терять ориентацию."
	
	if(_receiver.addEffect(StatusEffect.Stunned, [1])):
		text += " [b]Ты оглушен![/b]"
		
	return {
		text = text,
		pain = 55,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(getLuxeRage(_attacker) < 1.0):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "Свечение меха {attacker.name} становится интенсивнее, угли разгораются ярче, пока {attacker.he} теряет контроль от ярости. Кулаки {attacker.His} сжимаются, а грудь {attacker.his} тяжело вздымается от гнева. Это будет чертовски больно..."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms]
	

func getAttackSoloAnimation():
	return "charge"

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 1.0

func addLuxeRage(_attacker, howMuch:float):
	if(_attacker.hasEffect("LuxeRage")):
		_attacker.getEffect("LuxeRage").addRage(howMuch)

func getLuxeRage(_attacker) -> float:
	if(_attacker.hasEffect("LuxeRage")):
		return _attacker.getEffect("LuxeRage").rage
	return 0.0
