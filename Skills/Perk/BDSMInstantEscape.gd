extends PerkBase

func _init():
	id = Perk.BDSMInstantEscape
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Мгновенное удовлетворение"

func getVisibleDescription():
	return "Ты точно знаешь, за какой край дернуть, чтобы снять этот чертов кляп. В мини-игре с сопротивлением появится крошечная зона: если попасть в нее, путы расстегнутся мгновенно."

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/slavery.png"

