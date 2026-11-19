extends StatusEffectBase

func _init():
	id = StatusEffect.Pregnant
	isBattleOnly = false

	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 90
	
func shouldApplyTo(_npc):
	if(_npc.isVisiblyPregnant() && _npc.isPregnant(true, false)):
		return true
	return false

func getEffectName():
	return "Беременная"

func getEffectDesc():
	var progress:float = character.getPregnancyProgress()
	
	var timeLeftText:String = ""
	if(character.getMenstrualCycle() != null):
		timeLeftText = " "+Util.getTimeStringHumanReadable(character.getMenstrualCycle().getTimeUntilReadyForBirth())+" пока не придет время родов."
	
	var addText:String = ""
	if(progress <= 0.33):
		addText = "Первый триместр. Живот лишь слегка округлился, тело медленно привыкает к изменениям."+timeLeftText
	elif(progress <= 0.66):
		addText = "Второй триместр. Грудь набухла, живот стал очень заметным."+timeLeftText
	elif(character.isReadyToGiveBirth()):
		addText = "Третий триместр. У вас появляется одышка, и кажется, что вы вот-вот родите."
	else:
		addText = "Третий триместр. Лактация. Вы чувствуете одышку, а тяжелый живот буквально тянет вас к земле."+timeLeftText
	
	var hasFirstPerk:bool = GM.pc.hasPerk(Perk.FertilityBellySize)
	var hasSecondPerk:bool = GM.pc.hasPerk(Perk.BreedExtraTooltipInfo)
	if((hasFirstPerk || hasSecondPerk) && character.getMenstrualCycle() != null):
		var kidAmount:String = character.getMenstrualCycle().getRoughLitterEstimateString(hasFirstPerk && hasSecondPerk)
		addText += "\n\nВам кажется, что внутри этого живота "+str(kidAmount)+" есть"
	
	return "У тебя заметно округлился живот. "+addText

func getEffectImage():
	var progress:float = character.getPregnancyProgress()
	if(progress <= 0.33):
		return "res://Images/StatusEffects/impregnation.png"
	
	return "res://Images/StatusEffects/mother.png"

func getIconColor():
	return IconColorDarkPurple

func getBuffs():
	var progress:float = character.getPregnancyProgress()
	var modifier:float = 1
	if(character.hasPerk(Perk.FertilityBroodmother)): 
		modifier = 0.5
		
	if(progress <= 0.0):
		return []
	
	if(progress <= 0.33):
		return [
			
		]
	elif(progress <= 0.66):
		return [
			buff(Buff.MaxStaminaBuff, [int(-10 * modifier)]),
		]
	else:
		return [
			buff(Buff.MaxStaminaBuff, [int(-30 * modifier)]),
			buff(Buff.DodgeChanceBuff, [int(-20 * modifier)]),
		]
