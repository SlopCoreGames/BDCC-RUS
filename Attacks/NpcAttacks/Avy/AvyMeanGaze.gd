extends Attack

func _init():
	id = "AvyMeanGaze"
	category = Category.Physical
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Злобный взгляд"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "{attacker.name} выпрямляет {attacker.his} осанку и широко разводит {attacker.his} руки. {attacker.His} голос звучит соблазнительно, но в то же время невероятно злобно."
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Ты — моя игрушка. МОЯ. Я оттрахаю тебя до полусмерти.",
		"Да, сучка, я ТЕБЯ РАЗМАЖУ.",
		"Ты такая жалкая. Я буду в диком восторге, ЛОМАЯ тебя.",
		"Тупая гребаная шлюха, я тебя просто уничтожу."
		])+"[/say]"
	
	return {
		text = text,
		lust = RNG.randi_range(10, 20),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} встречается взглядом с {receiver.name}, и в глазах {attacker.his} вспыхивает садистское наслаждение."

func getRequirements():
	return [AttackRequirement.CanTalk]

func getAttackSoloAnimation():
	return "TauntPoint"
