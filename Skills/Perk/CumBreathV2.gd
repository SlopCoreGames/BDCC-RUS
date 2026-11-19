extends PerkBase

func _init():
	id = Perk.CumBreathV2
	skillGroup = Skill.CumLover

func getVisibleName():
	return "Спермозависимый"

func getVisibleDescription():
	return "Ваше тело адаптировалось к использованию спермы в качестве источника белка. Сражение, когда внутри вашего живота ИЛИ задницы находится сперма, будет дополнительно снимать [color="+DamageType.getColorString(DamageType.Physical)+"]4 ед. боли[/color] каждый ход"

func getRequiredPerks():
	return [Perk.CumBreath]

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/addiction.png"

func processBattleTurn():
	if(!npc.isPlayer()):
		return
	
	var head: BodypartHead = npc.getBodypart(BodypartSlot.Head)
	if(head.isOrificeStuffed()):
		npc.addPain(-4)
	var anus: BodypartAnus = npc.getBodypart(BodypartSlot.Anus)
	if(anus.isOrificeStuffed()):
		npc.addPain(-4)
