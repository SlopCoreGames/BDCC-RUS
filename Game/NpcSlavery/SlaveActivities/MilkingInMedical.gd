extends SlaveActivityBase

var lastReport:String = ""

func _init():
	id = "MilkingInMedical"
	
func getVisibleName():
	return "Дойка в медпункте"

func getActivityText():
	var theText:String = "{npc.name} доят в медицинском отсеке!"

	if(lastReport != ""):
		theText += "\n\nСегодня {npc.he} произвела вот это:\n"+lastReport

	return theText

func onStart(_args = []):
	pass

func onNewDay():
	var fluidsGot:Dictionary = GM.main.SCI.doMilkCharacter(getChar())
	
	if(fluidsGot.empty()):
		lastReport = " - Nothing"
		return
	lastReport = ""
	for fluidID in fluidsGot:
		var theFluidOBJ:FluidBase = GlobalRegistry.getFluid(fluidID)
		var fluidName:String = theFluidOBJ.getVisibleName() if theFluidOBJ != null else fluidID
		
		lastReport += " - "+fluidName+": "+str(Util.roundF(fluidsGot[fluidID], 1))+" ml"

func preventsStatsDecay():
	return true

func preventsNormalInteractions():
	return true

func hoursPassed(_howMuch):
	pass

func getInteractActions():
	return [
		{
			name = "Отмена",
			desc = "Верни свою рабыню обратно.",
			sceneID = "SlaveryCancelActivity",
			args = ["Вы находите {npc.name} в медпункте и приводите {npc.him} обратно."],
			buttonChecks = [],
		}
	]

func getCustomInteractAnimInfo():
	# Different anim here
	return [StageScene.Duo, "stand", {pc="pc", npc=getCharID()}]

func saveData():
	var data = .saveData()
	
	data["lastReport"] = lastReport
	
	return data

func loadData(_data):
	.loadData(_data)
	
	lastReport = SAVE.loadVar(_data, "lastReport", "")
