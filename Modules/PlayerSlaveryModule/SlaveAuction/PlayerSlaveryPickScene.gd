extends SceneBase


func _init():
	sceneID = "PlayerSlaveryPickScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand", {pc="pc"})
		
		saynn("Доступно "+str(GM.main.PSH.getPossibleSlaveriesAmount(false))+" возможных сценариев рабства игрока.")
		
		saynn("Вы можете либо позволить игре выбрать случайный вариант, либо выбрать сценарий самостоятельно.")
		
		saynn("Имейте в виду, что в случайно выбранном сценарии могут оказаться кинки, которые вам не понравятся.")
		
		addButton("Случайный сценарий", "Предоставить всё случаю", "startRandomSlavery")
		addButton("Выбрать сценарий", "Выберите вид рабства, который хотите испытать", "pick_menu")

	if(state == "pick_menu"):
		saynn("Какой сценарий рабства вы хотите испытать?")
		
		saynn("Открытые концовки:")
		sayn(GM.main.PSH.getEndingsInfo())
		
		for slaveryID in GlobalRegistry.getPlayerSlaveryDefs():
			var thePlayerSlaveryDef:PlayerSlaveryDef = GlobalRegistry.getPlayerSlaveryDef(slaveryID)
			
			if(!thePlayerSlaveryDef.isVisibleAtAll()):
				continue
			
			if(thePlayerSlaveryDef.canBeChosen()):
				addButton(thePlayerSlaveryDef.getVisibleName(), thePlayerSlaveryDef.getVisibleDesc(), "doStartSlavery", [slaveryID])
			else:
				var impossibleReasonText:String = thePlayerSlaveryDef.getImpossibleReason()
				if(impossibleReasonText == ""):
					impossibleReasonText = "В текущем состоянии невозможно"
				
				addDisabledButton(thePlayerSlaveryDef.getVisibleName(), "["+impossibleReasonText+"] "+thePlayerSlaveryDef.getVisibleDesc())

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "startRandomSlavery"):
		var theSlaveryID:String = GM.main.PSH.getRandomPossibleSlaveryID()
		if(theSlaveryID == ""):
			endScene()
			return
		endScene()
		GM.main.startPlayerSlavery(theSlaveryID)
		return

	if(_action == "doStartSlavery"):
		endScene()
		GM.main.startPlayerSlavery(_args[0])
		return

	setState(_action)

func saveData():
	var data = .saveData()

	#data["knowsMirri"] = knowsMirri

	return data

func loadData(data):
	.loadData(data)

	#knowsMirri = SAVE.loadVar(data, "knowsMirri", false)
