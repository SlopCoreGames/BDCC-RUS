extends SceneBase

var avyObedience = 0
var avyDebug = false

func _init():
	sceneID = "AvyObedienceMenuScene"

func _run():
	if(state == ""):
		aimCameraAndSetLocName("hideout_chill")
		addCharacter("avy")
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		saynn("Вы просите Эви пойти за вами, потому что хотите заняться чем-то вместе. Похоже, она не против.")

		saynn("Комната отдыха кажется подходящим местом для этого.")

		saynn("[say=avy]Да?[/say]")

		avyObedience = GM.main.MS.getAvyObedience()
		if (avyDebug):
			saynn("avyObedience = 99")

		saynn("Послушание Эви: "+str(avyObedience)+"")

		addButton("Проехали", "Вы передумали", "never_mind")
		if (avyObedience >= 2):
			addButton("Легкое доминирование", "(Послушание 2+) Попробуйте подчинить Эви и посмотреть, что из этого выйдет", "light_dom")
		if (!getFlag("KaitModule.didAvyDomIntro")):
			addDisabledButton("Оральный секс", "Прежде чем это сделать, вам нужно сначала подчинить Эви!")
		else:
			if (avyObedience >= 2):
				addButton("Оральный секс", "(Послушание 2+) Доминировать над Эви еще сильнее: заставить её сосать твой член или лизать твою киску", "oral_sex")
			if (avyObedience >= 3):
				addButton("Доение простаты", "(Послушание 3+) Поиграть с задницей и простатой Эви!", "obey_prostatemilk")
			else:
				addDisabledButton("Послушание 3+", "Требуется послушание Эви 3 или выше")
	if(state == "never_mind"):
		aimCameraAndSetLocName(GM.pc.getLocation())
		saynn("[say=pc]Я передумала.[/say]")

		saynn("Эви пожимает плечами. И ты возвращаешься назад.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "light_dom"):
		endScene()
		setFlag("KaitModule.didAvyDomIntro", true)
		runScene("AvyObedienceLightDomScene")

	if(_action == "oral_sex"):
		endScene()
		runScene("AvyObedienceOralScene")

	if(_action == "obey_prostatemilk"):
		endScene()
		runScene("AvyObedienceProstateMilkingScene")

	setState(_action)

func saveData():
	var data = .saveData()

	data["avyObedience"] = avyObedience
	data["avyDebug"] = avyDebug

	return data

func loadData(data):
	.loadData(data)

	avyObedience = SAVE.loadVar(data, "avyObedience", 0)
	avyDebug = SAVE.loadVar(data, "avyDebug", false)
