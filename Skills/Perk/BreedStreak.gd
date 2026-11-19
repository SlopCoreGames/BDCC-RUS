extends PerkBase

func _init():
	id = Perk.BreedStreak
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Серия заводчика"

func getVisibleDescription():
	return "Кончай в любого партнера, чтобы начать серию! Каждый новый уникальный партнер продлевает твою серию. Чем выше серия, тем ты сильнее. Но серия прерывается, если ты не кончил в кого-то нового в течение 6 часов."

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/badge.png"

func getBuffs():
	return [
	]

func onSexEvent(_event:SexEvent):
	if(_event.getType() == SexEvent.HoleCreampied || _event.getType() == SexEvent.StraponCreampied):
		if(_event.getSourceChar() == npc):
			npc.addEffect(StatusEffect.BreedersStreak, [_event.targetCharID])
