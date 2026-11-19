extends PerkBase

func _init():
	id = Perk.CumBreath
	skillGroup = Skill.CumLover

func getVisibleName():
	return "Запах спермы"

func getVisibleDescription():
	return "Ты уже привыкла к вкусу спермы и даже почти наслаждаешься им. Сражение, когда внутри тебя полно спермы, будет снимать [color="+DamageType.getColorString(DamageType.Physical)+"]1 единицу боли[/color] каждый ход"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/mouth-watering.png"

func processBattleTurn():
	if(!npc.isPlayer()):
		return
	
	var head: BodypartHead = npc.getBodypart(BodypartSlot.Head)
	if(head.isOrificeStuffed()):
		npc.addPain(-1)
