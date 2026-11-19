extends StatusEffectBase

func _init():
	id = StatusEffect.Naked
	isBattleOnly = false
	
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 95
	
func shouldApplyTo(_npc):
	if(_npc.isFullyNaked() || _npc.getExposedPrivates().size() > 0):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	if(!character.isPlayer()):
		return "Голая"
	
	if(character.isFullyNaked()):
		return "Голый"
	return "Обнаженность"

func getEffectDesc():
	if(!character.isPlayer()):
		return "Ничего не надето"
	
	

	
	var exposedBodyparts = character.getExposedPrivates()
	var visiblePartsNames = []
	for bodypartID in exposedBodyparts:
		if(!character.hasBodypart(bodypartID)):
			continue
		var bodypart = character.getBodypart(bodypartID)
		visiblePartsNames.append(bodypart.getName())
		
	if(visiblePartsNames.size() > 0):
		if(character.isFullyNaked()):
			if(character.hasPerk(Perk.NakedNoShame)):
				return "Ты абсолютно голая, и это чертовски приятно\n[color=red]Обнаженность: "+Util.humanReadableList(visiblePartsNames)+"[/color]"
			
			return "Ты абсолютно голая, так что готовься к повышенному вниманию\n[color=red]Обнаженность: "+Util.humanReadableList(visiblePartsNames)+"[/color]"
		else:
			return "Твои интимные места приоткрыты и видны каждому, кто на тебя взглянет. Готовься к повышенному вниманию\n[color=red]Обнаженность: "+Util.humanReadableList(visiblePartsNames)+"[/color]"
	
	if(character.hasPerk(Perk.NakedNoShame)):
		return "Ты абсолютно голая, и это чертовски приятно"
	return "Ты абсолютно голая, так что готовься к повышенному вниманию"

func getEffectImage():
	return "res://Images/StatusEffects/nudity.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass

func getBuffs():
	if(character.hasPerk(Perk.NakedNoShame)):
		return [
			buff(Buff.LustDamageBuff, [10]),
			buff(Buff.ExposureBuff, [50]),
		]
	
	return [
		buff(Buff.LustDamageBuff, [10]),
		buff(Buff.ReceivedLustDamageBuff, [10]),
		buff(Buff.ExposureBuff, [50]),
	]
