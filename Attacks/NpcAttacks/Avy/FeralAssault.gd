extends Attack

func _init():
	id = "FeralAssault"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Дикая атака"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		if(RNG.chance(50)):
			var text = "{attacker.name} замечает, как {receiver.name} уворачивается от атаки {receiver.his}, и резко вытягивает {attacker.his} когти, чтобы полоснуть {receiver.him}!"
			
			_receiver.addEffect(StatusEffect.Bleeding)
			return {
				text = text,
				pain = RNG.randi_range(5, 10),
			}
		
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} яростно бросается вперед, обрушивая на {receiver.him} беспощадный шквал диких ударов, от которых {receiver.him} остается избитым и покрытым синяками."
	
	if(RNG.chance(30) && !_receiver.hasEffect(StatusEffect.Collapsed)):
		if(_receiver.addEffect(StatusEffect.Collapsed)):
			text += " Яростная атака заставила {receiver.name} [b]пошатнуться[/b]."
	return {
		text = text,
		pain = RNG.randi_range(30, 50),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "Глаза {attacker.name} дичают, когда волна неудержимой ярости поглощает {attacker.him}."

func getAttackSoloAnimation():
	return "punch"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
