extends SceneBase

func _init():
	sceneID = "AlexTrustExercisesMenuScene"

func _run():
	if(state == ""):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})
		saynn("Какое упражнение на доверие хочешь попробовать?")

		addButton("Упражнение на доверие 1", "Выполнить первое", "do_first")
		var howManyCh2 = getFlag("AlexRynardModule.ch2SceneNum", 0)
		if (howManyCh2 >= 3):
			addButton("Упражнение на доверие 2", "Выполнить второе", "do_second")
		if (howManyCh2 >= 7):
			addButton("Упражнение на доверие 3", "Выполнить третье", "do_third")
		if (getFlag("AlexRynardModule.ch2FinalSceneHappened")):
			addButton("Упражнение на доверие 4", "Выполнить последнее", "do_fourth")
		addButton("Проехали", "Вы передумали", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_first"):
		endScene()
		runScene("AlexTrustExercise1Scene")
		return

	if(_action == "do_second"):
		endScene()
		runScene("AlexTrustExercise2Scene")
		return

	if(_action == "do_third"):
		endScene()
		runScene("AlexTrustExercise3Scene")
		return

	if(_action == "do_fourth"):
		endScene()
		runScene("AlexTrustExercise4Scene")
		return

	setState(_action)
