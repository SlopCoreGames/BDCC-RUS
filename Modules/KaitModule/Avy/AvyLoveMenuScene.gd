extends SceneBase

var avyLove = 0
var avyDebug = false

func _init():
	sceneID = "AvyLoveMenuScene"

func _run():
	if(state == ""):
		addCharacter("avy")
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		saynn("Вы спрашиваете Эви, не хочет ли она немного развлечься вместе.")

		saynn("[say=avy]Возможно. Только имей в виду, я не снизу.[/say]")

		avyLove = GM.main.MS.getAvyLove()
		if (avyDebug):
			saynn("avyLove = 99")

		saynn("Любовь Эви: "+str(avyLove)+"")

		addButton("Проехали", "Вы передумали", "never_mind")
		if (avyLove >= 2):
			addButton("Дай себя оттрахать!", "(Любовь 2+) Позволь Эви трахнуть тебя без презерватива!", "get_fucked")
			addButton("Отсосать ей", "(Любовь 2+) Отсосать член Эви!", "oral_sex")
		if (avyLove >= 3):
			addButton("Помпа для пениса", "(Любовь 3+) Надеть на член Эви помпу! Требуется помпа для члена", "love_penispump")
		else:
			addDisabledButton("Любовь 3+", "Требуется уровень любви Эви 3 или выше")
	if(state == "never_mind"):
		aimCameraAndSetLocName(GM.pc.getLocation())
		saynn("[say=pc]Я передумала.[/say]")

		saynn("Эви пожимает плечами.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "get_fucked"):
		endScene()
		runScene("AvyLoveSexScene")

	if(_action == "oral_sex"):
		endScene()
		runScene("AvyLoveOralSexScene")

	if(_action == "love_penispump"):
		endScene()
		runScene("AvyLovePenisPumpScene")

	setState(_action)

func saveData():
	var data = .saveData()

	data["avyLove"] = avyLove
	data["avyDebug"] = avyDebug

	return data

func loadData(data):
	.loadData(data)

	avyLove = SAVE.loadVar(data, "avyLove", 0)
	avyDebug = SAVE.loadVar(data, "avyDebug", false)
