extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "PortalPantiesSleepTestsScene"

func _reactInit():
	var possible = [
		"sleeping_poke",
	]
	setState(RNG.pick(possible))
		
	#GM.pc.addCredits(1)

func _run():
	if(state == "sleeping_poke"):
		saynn("Даже во сне кажется, будто твои интимные места всегда на виду. Но, по крайней мере, их никто не трогает.")

		addButton("Продолжить", "Было не так уж и плохо", "endthescene")


func _react(_action: String, _args):
	if(_action in ["sleeping_poke"]):
		GM.pc.addLust(20)

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

