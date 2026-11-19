extends Bodypart
class_name BodypartVagina

var fluidType:String = "GirlCum"

func _init():
	limbSlot = null
	orifice = VaginaOrifice.new()
	orifice.bodypart = weakref(self)
	setupSensitiveZone()
	needsProcessing = true

func setupSensitiveZone():
	sensitiveZone = preload("res://Player/SensitiveZone/SensitiveVagina.gd").new()
	sensitiveZone.setBodypart(self)

func getSlot():
	return BodypartSlot.Vagina

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
			#text += "\n"+menstrualCycle.getDebugInfo()
	return text

func getOrificeName():
	return "pussy"

func safeWhenExposed():
	return false

func hasWomb():
	return true

func getRevealMessage():
	if(orifice == null):
		return .getRevealMessage()
	
	return Util.capitalizeFirstLetter(orifice.getLoosenessString()) + " киска обнажилась."

func supportsSkin():
	return false

func saveData():
	var data = .saveData()
	data["fluidType"] = fluidType
	
	return data

func loadData(_data):
	fluidType = SAVE.loadVar(_data, "fluidType", "GirlCum")
	
	.loadData(_data)

func applyTFData(_data):
	.applyTFData(_data)
	
	fluidType = loadTFVar(_data, "fluidType", fluidType)

func getFluidType(_fluidSource) -> String:
	return fluidType

func getTransformAwayMessage(_context:Dictionary) -> String:
	return "Тревожное тепло разливается по нижней части живота {npc.yourHis}, и {npc.youHe} {npc.youHeVerb('feel')} ощущается мягкая пульсация, когда вагина {npc.yourHis} начинает становиться всё меньше и меньше. Складки и изгибы постепенно разглаживаются и уходят внутрь, а влажные стенки втягиваются обратно в тело {npc.yourHis}. {npc.YouHe} {npc.youHeVerb('feel')} поток воздуха касается кожи {npc.yourHis}, когда последние остатки {npc.yourHis} киски исчезают, отверстие закрывается, оставляя {npc.youHim} с гладкой, плоской промежностью."

func getTransformGrowMessage(_context:Dictionary) -> String:
	return "По животу {npc.yourHis} разливается покалывание, и {npc.youHe} {npc.youHeVerb('sense')} внутри {npc.youHim} начинает формироваться что-то новое. Нежная кожа растягивается и меняет форму, словно что-то расцветает из самой глубины. Каждая пульсация посылает волны предвкушения через {npc.youHim}, обостряя {npc.yourHis} восприятие. Контуры {npc.yourHis} новой анатомии начинают обретать форму, пока последние следы трансформации не утихают. {npc.YouHe} {npc.youHeVerb('feel')} отчетливо проступает разрез {npc.yourHis} нового цветка — мягкие складки расходятся, обнажая влажную, жаждущую киску."

func getTransformMorphMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} {npc.youHeVerb('feel')} теплое ощущение в {npc.yourHis} нижней части тела, и внезапно {npc.yourHis} киска начинает трансформироваться. Форма меняется, становясь более выраженной и украшаясь новыми текстурами. Изменения значительны, но при этом сохранилась {npc.yourHis} нынешняя теснота. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
