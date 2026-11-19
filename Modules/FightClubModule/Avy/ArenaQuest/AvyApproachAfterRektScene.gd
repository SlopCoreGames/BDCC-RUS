extends SceneBase

func _init():
	sceneID = "AvyApproachAfterRektScene"

func _run():
	if(state == ""):
		addCharacter("avy")
		playAnimation(StageScene.Duo, "stand", {npc="avy"})
		saynn("Когда ты подходишь к ней, Эви с любопытством тебя разглядывает.")

		saynn("[say=avy]Снова пришел за добавкой?[/say]")

		saynn("Фокси разглядывает свои когти.")

		saynn("[say=avy]Знаешь, на самом деле я не пыталась тебя убить.[/say]")

		saynn("Её взгляд снова устремляется на тебя.")

		saynn("[say=avy]Ты просто слишком мягкотелый, наверное. Ладно. Чего тебе?[/say]")

		addButton("Продолжить", "Это было грубо", "do_talk")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_talk"):
		runScene("AvyTalkScene")
		endScene()
		return

	setState(_action)
