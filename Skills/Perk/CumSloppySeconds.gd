extends PerkBase

func _init():
	id = Perk.CumSloppySeconds
	skillGroup = Skill.CumLover

func getVisibleName():
	return "Второй сорт"

func getVisibleDescription():
	return "Тебе обожает, когда разные люди используют тебя как спермоприемник."

func getMoreDescription():
	return "Если в твоей киске или заднице находится сперма от 2 и более разных людей, ты получаешь +20% бонус к урону [color="+DamageType.getColorString(DamageType.Lust)+"]Похоти[/color]."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/heartburn.png"

func getBuffs():
	if(!npc.isPlayer()):
		return
	
	var uniqueUsersAss:int = 0
	if(npc.hasBodypart(BodypartSlot.Anus)):
		var ass = npc.getBodypart(BodypartSlot.Anus)
		var assOrifice = ass.getOrifice()
		uniqueUsersAss = assOrifice.getUniqueCharactersAmount()
		
	var uniqueUsersPussy:int = 0
	if(npc.hasBodypart(BodypartSlot.Vagina)):
		var pussy = npc.getBodypart(BodypartSlot.Vagina)
		var pussyOrifice = pussy.getOrifice()
		uniqueUsersPussy = pussyOrifice.getUniqueCharactersAmount()
		
	if(uniqueUsersAss > 1 || uniqueUsersPussy > 1):
		return [
			buff(Buff.LustDamageBuff, [20]),
		]
	return []
