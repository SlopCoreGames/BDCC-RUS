extends PerkBase

func _init():
	id = Perk.BreedCumInflationHeat
	skillGroup = Skill.Breeder
	dungeonWeight = 0.0

func getVisibleName():
	return "Принудительная овуляция"

func getVisibleDescription():
	return "Возможно, сперма достигнет их яичников, если ты продолжишь набивать их утробу. Конча в кого-то, кто уже раздут от спермы, дает шанс спровоцировать течку и, как следствие, овуляцию."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/forcedovulation.png"

func getBuffs():
	return [
	]

func onSexEvent(_event:SexEvent):
	if(_event.getType() == SexEvent.HoleCreampied || _event.getType() == SexEvent.StraponCreampied):
		var hole = _event.getField("hole", BodypartSlot.Vagina)
		var targetChar = _event.getTargetChar()
		if(_event.getSourceChar() == npc && RNG.chance(30) && _event.getTargetChar().hasWombIn(hole)):
			if(targetChar.hasEffect(StatusEffect.CumInflated) || targetChar.getCumInflationLevel(false) > 0.01):
				var isOvul = false
				if(targetChar.isInHeat() && RNG.chance(50) && targetChar.forceOvulate()):
					isOvul = true
				else:
					targetChar.forceIntoHeat()
				if(_event.getSourceChar().isPlayer()):
					if(RNG.chance(1)):
						GM.main.addMessage("ШЛЁП ШЛЁП ШЛЁП ШЛЁП")
					elif(RNG.chance(5)):
						GM.main.addMessage("ЗАБЕРЕМЕНЕЙ ЗАБЕРЕМЕНЕЙ ЗАБЕРЕМЕНЕЙ ЗАБЕРЕМЕНЕЙ")
					else:
						if(isOvul):
							GM.main.addMessage("Ты вызываешь у них овуляцию!")
						else:
							GM.main.addMessage("Ты провоцируешь у них течку!")
