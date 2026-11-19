extends SceneBase

var canEscape = true

func _init():
	sceneID = "TryStocksScene"

func _reactInit():
	if(RNG.chance(50)):
		canEscape = false

func _run():
	if(state == ""):
		saynn("Ты осматриваешь колодки посреди платформы. Похоже, они не заперты, и верхнюю часть можно свободно поднять. Любопытство берет верх, и ты задаешься вопросом, как бы ты в них смотрелся. Ты опускаешь голову в центральный слот и просовываешь руки в два других отверстия. Теперь тебе приходится стоять, наклонившись вперед.")

		saynn("На самом деле, ощущения довольно приятные, но ты понимаешь, что долго простоять в такой позе будет весьма неудобно.")

		# (if okay)
		if(canEscape):
			saynn("Ты освобождаешься и выпрямляешься.")
			
			addButton("Уйти", "Приятно", "endthescene")

		# (if not okay)
		else:
			saynn("Ты пытаешься выбраться, но из-за одного неосторожного движения верхняя часть захлопывается и защелкивается на тебе. Кажется, ты застрял. О нет... Ты пытаешься вырваться, но колодки не поддаются.")
			
			addButton("Ой", "О нет", "getCaptured")
		


func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "getCaptured"):
		#runScene("StocksPunishmentScene")
		endScene()
		GM.main.IS.startInteraction("InStocks", {inmate="pc"})
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["canEscape"] = canEscape
	
	return data
	
func loadData(data):
	.loadData(data)
	
	canEscape = SAVE.loadVar(data, "canEscape", false)

func supportsShowingPawns() -> bool:
	return true
