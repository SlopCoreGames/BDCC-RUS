extends PerkBase

func _init():
	id = Perk.BDSMBondageSlut
	skillGroup = Skill.BDSM

func getVisibleName():
	return "Бондаж-сучка"

func getVisibleDescription():
	return "Ты обожаешь любые наручники, повязки на глаза, верёвки и кляпы! Свобода обретается через ограничение: если на тебе надето хотя бы одно изделие из BDSM-атрибутики, ты получаешь на 15% меньше физического урона в бою."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/chained-heart.png"

func getBuffs():
	if(!npc.isPlayer()):
		return []
	
	var pc = npc
	var bdsmItems = pc.getInventory().getEquippedItemsWithTag(ItemTag.BDSMRestraint)
	if(bdsmItems.size() > 0):
		return [
			buff(Buff.ReceivedPhysicalDamageBuff, [-15])
		]
	return []

