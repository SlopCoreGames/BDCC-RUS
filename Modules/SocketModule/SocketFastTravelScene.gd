extends SceneBase


func _init():
	sceneID = "SocketFastTravelScene"

func _run():
	if(state == ""):
		saynn("В какую одностороннюю вентиляцию хочешь залезть?")

		var ventData = getModule("SocketModule").getFastTravelData()
		
		for ventID in ventData:
			var ventInfo = ventData[ventID]
			var hasVent = getFlag("SocketModule."+ventID, false)
			
			if(hasVent):
				addButton(ventInfo["name"], "Забирайся в эту вентиляцию!", "tp_to", [ventInfo["location"]])

		addButton("Назад", "Вы передумали", "endthescene")

	if(state == "tp_to"):
		saynn("Ты пробираешься по лабиринту вентиляционных шахт и осторожно выбираешься, когда достигаешь цели, стараясь не привлекать лишнего внимания... Тебе совсем не хочется, чтобы кто-то заподозрил неладное...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "tp_to"):
		GM.pc.setLocation(_args[0])
		aimCameraAndSetLocName(_args[0])
		GM.pc.addStamina(-20)
		addMessage("Восхождение немного истощило вашу выносливость")
	
	setState(_action)
