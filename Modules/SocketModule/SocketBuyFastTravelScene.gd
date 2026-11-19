extends SceneBase

var selectedVent = ""

func _init():
	sceneID = "SocketBuyFastTravelScene"

func _reactInit():
	return



func _run():
	if(state == ""):
		saynn("Какое одностороннее вентиляционное отверстие должен открыть для тебя Сокет?")

		var ventData = getModule("SocketModule").getFastTravelData()
		
		for ventID in ventData:
			var ventInfo = ventData[ventID]
			var hasVent = getFlag("SocketModule."+ventID, false)
			
			if(hasVent):
				addDisabledButton(ventInfo["name"], "Это отверстие у тебя уже есть!")
			else:
				addButton(ventInfo["name"], "Посмотреть информацию об этом отверстии", "look_vent", [ventID])

		addButton("Закрыть", "Вы передумали", "endthescene")

	if(state == "look_vent"):
		var ventData = getModule("SocketModule").getFastTravelData()
		var ventInfo = ventData[selectedVent]
		
		saynn(ventInfo["buydesc"])
		saynn("Цена: "+str(ventInfo["cost"])+" credits")
		saynn("Хочешь попросить Сокета открыть это отверстие?")
		
		addButtonWithChecks("Разблокировать", "Оплатить и запустить это отверстие", "buy_vent", [ventInfo["cost"]], [[ButtonChecks.HasCredits, ventInfo["cost"]]])
		addButton("Назад", "Вы передумали", "")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "look_vent"):
		selectedVent = _args[0]
	
	if(_action == "buy_vent"):
		setFlag("SocketModule."+selectedVent, true)
		GM.pc.addCredits(-_args[0])
		addMessage("Этот сокет открыл вентиляцию! Проверь свой личный терминал.")
		setState("")
		return
		
	setState(_action)

func saveData():
	var data = .saveData()

	data["selectedVent"] = selectedVent

	return data

func loadData(data):
	.loadData(data)

	selectedVent = SAVE.loadVar(data, "selectedVent", "")
