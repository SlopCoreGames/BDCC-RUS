extends PerkBase

func _init():
	id = Perk.BreedRapidConception
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Быстрое зачатие"

func getVisibleDescription():
	return "Ваше семя обладает невероятными свойствами. Если кончить в киску, когда у вас полная выносливость, а яйца [b]полны[/b], это даст им мощный толчок к фертильности и ускорит любое зачатие!"

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/nested-hearts2.png"

func getBuffs():
	return [
	]

func onSexEvent(_event:SexEvent):
	if(_event.getType() == SexEvent.HoleCreampied):
		var hole = _event.getField("hole", BodypartSlot.Vagina)
		if(_event.getSourceChar() == npc && _event.getTargetChar().hasWombIn(hole)):
			var loadSize = _event.getField("loadSize", 0.0)
			var sourceChar = _event.getSourceChar()
			if(sourceChar.hasPenis() && sourceChar.getStaminaLevel() >= 1.0):
				var penis = sourceChar.getBodypart(BodypartSlot.Penis)
				var cumProduction = penis.getFluidProduction()
				if(cumProduction != null):
					if(loadSize >= cumProduction.getCapacity()):
						_event.getTargetChar().addEffect(StatusEffect.RapidConception)
						if(_event.getSourceChar().isPlayer()):
							GM.main.addMessage("Ваше качественное семя делает их более плодовитыми!")
