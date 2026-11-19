extends PerkBase

func _init():
	id = Perk.BreedBreedersBliss
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Блаженство заводчицы"

func getVisibleDescription():
	return "Течка — идеальное состояние для размножения. Кончая в течку, ты снимаешь 20 единиц боли и восстанавливаешь 20 единиц выносливости!"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/insemination.png"

func getBuffs():
	return [
	]

func onSexEvent(_event:SexEvent):
	if(_event.getType() == SexEvent.HoleCreampied || _event.getType() == SexEvent.StraponCreampied):
		if(_event.getSourceChar() == npc && _event.getTargetChar().isInHeat()):
			var hole = _event.getField("hole", BodypartSlot.Vagina)
			if(_event.getTargetChar().hasWombIn(hole)):
				_event.getSourceChar().addPain(-20)
				_event.getSourceChar().addStamina(20)
				if(_event.getSourceChar().isPlayer()):
					GM.main.addMessage("Как же охеренно кончать в ту, у которой течка!")
