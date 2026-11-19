extends Attack

func _init():
	id = "TaviAlluringGaze"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Пленительный взгляд"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "Завораживающий взгляд {attacker.name} вызывает прилив похотливого желания у {receiver.name}."
	if(!_receiver.isDefocusing() && _receiver.addEffect(StatusEffect.Weakness, [1])):
		text += " {receiver.name} чувствует себя [b]слабо[/b]."
		
	return {
		text = text,
		lust = RNG.randi_range(30, 40),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} встречается взглядом с {receiver.name}, и взгляд {attacker.his} становится напряженным и соблазнительным."

	return text

func getRequirements():
	return [AttackRequirement.CanSee]

func canSeeAnticipationTextWhenBlind():
	return true

func getAttackSoloAnimation():
	return "TauntLustComeHere"
