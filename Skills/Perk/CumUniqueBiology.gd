extends PerkBase

func _init():
	id = Perk.CumUniqueBiology
	skillGroup = Skill.CumLover
	dungeonWeight = 0.0

func getVisibleName():
	return "Уникальная биология"

func getVisibleDescription():
	return "Твои дырки привыкли к самым разным членам, приобретя в процессе некоторые звериные черты. Теперь тебя легче узлить (и это приносит кайф), шиповатые члены могут вызывать овуляцию, а расширенные лошадиные члены вытесняют всю остальную сперму при проникновении."

func getSkillTier():
	return 1

func getPicture():
	return "res://Images/Perks/fortune-cookie.png"

func getBuffs():
	return [
	]

func onSexEvent(_event:SexEvent):
	if(_event.getTargetChar() != npc):
		return
	
	if(_event.getType() == SexEvent.HoleCreampied || _event.getType() == SexEvent.FilledCondomInside):
		var hole = _event.getField("hole", BodypartSlot.Vagina)
		var knotted = _event.getField("knotted", false)
		
		if(knotted && (hole in [BodypartSlot.Vagina, BodypartSlot.Anus])):
			_event.getTargetChar().addPain(-30)
			_event.getTargetChar().addStamina(30)
			if(npc.isPlayer()):
				GM.main.addMessage("Быть узлом — это так охеренно!")

	if(_event.getType() == SexEvent.HolePenetrated):
		var hasBarbs = _event.getSourceChar().bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisBarbs)
		var hasFlare = _event.getSourceChar().bodypartHasTrait(BodypartSlot.Penis, PartTrait.PenisFlare)
		var hole = _event.getField("hole", BodypartSlot.Vagina)
		
		if(hole in [BodypartSlot.Vagina, BodypartSlot.Anus]):
			if(hasBarbs && npc.hasWombIn(hole)):
				if(npc.forceOvulate()):
					if(npc.isPlayer()):
						GM.main.addMessage("Шипы скребут по твоим внутренним стенкам, вызывая овуляцию!")
			if(hasFlare):
				var bodypart:Bodypart = npc.getBodypart(hole)
				if(bodypart.isOrificeStuffed()):
					bodypart.clearOrificeFluids()
					if(npc.isPlayer()):
						GM.main.addMessage("Раздутая головка вытолкнула всё остальное семя из твоих "+BodypartSlot.getVisibleName(hole).to_lower()+"!")
