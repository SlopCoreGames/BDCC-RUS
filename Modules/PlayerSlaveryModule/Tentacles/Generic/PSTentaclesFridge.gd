extends SceneBase

func _init():
	sceneID = "PSTentaclesFridge"

func _reactInit():
	#addCharacter(GM.main.PS.getTentaclesCharID())
	pass

func resolveCustomCharacterName(_charID):
	if(_charID == "ten"):
		return GM.main.PS.getTentaclesCharID()
	if(_charID == "sci1"):
		return GM.main.PS.getScientist1CharID()
	if(_charID == "sci2"):
		return GM.main.PS.getScientist2CharID()

func _run():
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(state == ""):
		saynn("Ты открываешь холодильник и видишь, что он забит до отказа. Мясо, овощи, фрукты, закуски... от одного вида у тебя текут слюнки.")

		saynn("Вся еда максимально свежая... похоже, её пополняют каждый божий день.")

		addButton("Закуска", "Перекусить!", "doEatSnack")
		addButton("Уйти", "Проехали", "endthescene")
	if(state == "doEatSnack"):
		saynn("Ты хватаешь пачку чипсов и открываешь её. Пахнет чертовски вкусно.")

		saynn("Закончив перекус, ты выбрасываешь пустую пачку в стоящую неподалеку мусорку.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "doEatSnack"):
		_tentacles.doTurn()
		GM.pc.addPain(-50)
		GM.pc.addStamina(50)

	setState(_action)
