extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "Ch2e2ElizaReactionToRoughness"


func _run():
	if(state == ""):
		addCharacter("eliza")
		
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})

		saynn("Вы подходите к стойке, за которой обычно сидит Элиза. Она на месте, как обычно, потягивает кофе. Но когда она видит вас, выражение её лица резко меняется на мрачное, и она хмурится.")

		saynn("[say=eliza]Это ты. Я помню, что ты со мной сделал.[/say]")

		saynn("Вы не совсем понимаете, как реагировать. Элиза рычит на вас, но затем внезапно замолкает.")

		saynn("[say=eliza]Тебе повезло, что я не доложила капитану. Он бы отправил тебя в открытый космос в ту же секунду.[/say]")

		saynn("Она делает глоток кофе и немного успокаивается.")

		saynn("[say=eliza]В общем, чего тебе?[/say]")

		# (scene ends, starts talking scene again?)

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		runScene("ElizaTalkScene")
		return

	setState(_action)

