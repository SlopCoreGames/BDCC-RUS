extends "res://Scenes/SceneBase.gd"

var pickedZone:int = BodyWritingsZone.ArmLeft

func _init():
	sceneID = "PermanentMarkerScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand", {bodystate={naked=true}})
		
		saynn("В руке вы держите черный [b]перманентный[/b] маркер.")

		saynn("Что будете делать?")

		if(!GM.pc.hasBlockedHands() && !GM.pc.hasBoundArms()):
			addButton("Нарисовать на себе", "Вы передумали", "pickzonemenu")
		else:
			addDisabledButton("Нарисовать на себе", "Ваши руки или кисти связаны!")
		addButton("Оставить как есть", "Вы передумали", "endthescene")
	
	if(state == "pickzonemenu"):
		saynn("Где именно вы хотите оставить надпись?")
		
		addButton("Отмена", "Вы передумали", "")
		for zone in BodyWritingsZone.ALL:
			var zoneName:String = BodyWritingsZone.getZoneVisibleName(zone)
			addButton(zoneName, "Выбрать эту зону", "pickzone", [zone])
	
	if(state == "pickwritingmenu"):
		saynn("Что вы хотите написать на своем "+str(BodyWritingsZone.getZoneVisibleName(pickedZone))+"?")
		
		var theEffect
		if(GM.pc.hasEffect(StatusEffect.HasBodyWritings)):
			theEffect = GM.pc.getEffect(StatusEffect.HasBodyWritings)
		
		addButton("Назад", "Вы передумали", "pickzonemenu")
		for writingID in BodyWritings.getWritingIDsForZone(pickedZone):
			var writingInfo:Dictionary = BodyWritings.getWritingInfo(writingID)
			
			var writingName:String = writingInfo[BodyWritingsDB.DBText]
			if(theEffect && theEffect.hasPermanentWritingIDAtZone(pickedZone, writingID)):
				addDisabledButton(writingName, "В этой зоне уже есть надпись, сделанная перманентным маркером!")
			else:
				addButton(writingName, "Написать это перманентным маркером!", "doWrite", [writingID])
	
	if(state == "afterwrite"):
		playAnimation(StageScene.Solo, "stand", {bodystate={naked=true}})
		
		saynn("Вы закончили разрисовывать свою кожу перманентным маркером!")
		
		saynn("Чернила в маркере закончились, поэтому ты его выбрасываешь.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "pickzone"):
		pickedZone = _args[0]
		setState("pickwritingmenu")
		return
	if(_action == "doWrite"):
		var writingID:String = _args[0]
		GM.pc.addBodywriting(pickedZone, writingID, true, "pc")
		GM.pc.getInventory().removeXOfOrDestroy("PermanentMarker", 1)
		setState("afterwrite")
		return
	
	setState(_action)

func saveData():
	var data = .saveData()

	data["pickedZone"] = pickedZone

	return data

func loadData(data):
	.loadData(data)

	pickedZone = SAVE.loadVar(data, "pickedZone", BodyWritingsZone.ArmLeft)
