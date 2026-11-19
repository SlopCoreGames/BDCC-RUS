extends Bodypart
class_name BodypartAnus

func _init():
	limbSlot = null
	orifice = AnusOrifice.new()
	orifice.bodypart = weakref(self)
	setupSensitiveZone()
	needsProcessing = true

func setupSensitiveZone():
	sensitiveZone = preload("res://Player/SensitiveZone/SensitiveAnus.gd").new()
	sensitiveZone.setBodypart(self)

func getSlot():
	return BodypartSlot.Anus

func getCompatibleSpecies():
	return [Species.Any]
	
func getTooltipInfo():
	var text = ""
	if(orifice != null):
		text += orifice.getTooltipInfo()
	if(sensitiveZone != null):
		if(text != ""):
			text += "\n"
		text += sensitiveZone.getInfoString()
	var theChar = getCharacter()
	if(GM.pc != null && GM.pc.hasPerk(Perk.BreedExtraTooltipInfo) && theChar != null && theChar.hasWombIn(getSlot())):
		var menstrualCycle = theChar.getMenstrualCycle()
		if(menstrualCycle != null):
			if(text != ""):
				text += "\n"
			text += "Фаза цикла: "+str(CycleStage.getVisibleActionName(menstrualCycle.getCurrentStage()))
			text += "\nШанс размножения: "+str(Util.roundF(menstrualCycle.getRoughChanceOfBecomingPregnant(), 1))+"%"
			text += "\nFertility: "+str(Util.roundF(theChar.getFertility()*100.0, 1))+"%"
	return text

func getOrificeName():
	return "anus"

func safeWhenExposed():
	return false

func getRevealMessage():
	if(orifice == null):
		return .getRevealMessage()
	
	return Util.capitalizeFirstLetter(orifice.getLoosenessString()) + " анус обнажился."

func supportsSkin():
	return false

func getTransformMorphMessage(_context:Dictionary) -> String:
	var theChar = getCharacter()
	var hasVag:bool = false
	if(theChar != null && theChar.hasVagina()):
		hasVag = true
	var hasWomb:bool = hasTrait(PartTrait.AnusWomb)
	if(hasWomb):
		if(hasVag):
			return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание в районе {npc.yourHis} задницы, и внезапно {npc.yourHis} анус начинает меняться. Его форма трансформируется, становясь более выраженной и покрываясь новыми текстурами. Перемены куда масштабнее, чем кажется снаружи... Это новое отверстие хвоста теперь делит матку с {npc.yourHis} киской, переплетая их функции воедино."
		return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание в районе {npc.yourHis} задницы, и вдруг {npc.yourHis} анус начинает меняться. Его форма трансформируется, становясь более выраженной и покрываясь новыми текстурами. Перемены куда масштабнее, чем кажется снаружи... Внутри {npc.youHim} формируется матка, соединенная с твоим хвостовым отверстием."
	return "{npc.YouHe} {npc.youHeVerb('feel')} чувствует покалывание в области {npc.yourHis} задницы, и внезапно {npc.yourHis} анус начинает меняться. Форма трансформируется, становясь более выраженной и покрываясь новыми текстурами. Изменения значительны, но при этом сохранилась {npc.yourHis} прежняя тугость. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
