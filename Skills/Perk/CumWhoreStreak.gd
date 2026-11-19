extends PerkBase

func _init():
	id = Perk.CumWhoreStreak
	skillGroup = Skill.CumLover
	dungeonWeight = 0.0

func getVisibleName():
	return "Серия куннилингусных забегов"

func getVisibleDescription():
	return "Позволяй партнерам кончать в тебя, чтобы начать серию! Каждый новый уникальный партнер продлевает твою серию. Чем выше серия, тем сильнее ты становишься. Но серия прерывается, если в течение 6 часов в тебя никто новый не кончал."

func getSkillTier():
	return 2

func getPicture():
	return "res://Images/Perks/lovedice.png"

func getBuffs():
	return [
	]

func onSexEvent(_event:SexEvent):
	if(_event.getType() == SexEvent.HoleCreampied || _event.getType() == SexEvent.StraponCreampied):
		if(_event.getTargetChar() == npc):
			npc.addEffect(StatusEffect.CumWhoreStreak, [_event.sourceCharID])
