extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "UnconToStocksScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})

		saynn("Пока ты... крепко спишь... кто-то подошел к тебе... и начал утаскивать куда-то прочь...")
		
		addButton("Продолжить", "Смотри, что будет дальше...", "do_drag_pc_off")
	
	if(state == "do_drag_pc_off"):
		aimCameraAndSetLocName(GM.pc.getLocation())
		playAnimation(StageScene.Stocks, "idle", {pc="pc"})
		
		saynn("После довольно неуютного сна ты наконец открываешь глаза... и понимаешь, что ты уже в другом месте...")

		saynn("Вообще-то... ты прекрасно понимаешь, где находишься... на главной платформе для наказаний... зажатая в колодках...")

		addButton("О нет...", "Пора выбираться...", "start_stocks")


func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "start_stocks"):
		endScene()
		GM.main.IS.startInteraction("InStocks", {inmate="pc"})
		return
	
	if(_action == "do_drag_pc_off"):
		GM.pc.setLocation("main_punishment_spot")
		processTime(RNG.randi_range(120, 300)*60)

			
	
	setState(_action)

