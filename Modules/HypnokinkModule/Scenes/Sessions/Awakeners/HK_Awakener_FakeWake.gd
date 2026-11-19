extends "res://Modules/HypnokinkModule/Scenes/Sessions/HK_SessionAwakenerBase.gd"

func _init():
	sceneID = HK_Sessions.AwakenerFakeWake

func _initScene(_args = []):
	onAwakener()
	
func _run():
	if(state == ""):
		addCharacter("vion")
		playAnimation(StageScene.Duo, "stand", {npc="vion", npcAction="stand"})

		saynn("[say=vion]Ну, раз с этим покончено...[/say]")

		saynn("Вион подцепляет когтем твой воротник.")

		saynn("[say=vion]Вставай. Медленно, не спеши. Поднимайся на ноги.[/say]")

		saynn("Ты поднимаешься, а Вион помогает тебе, потягивая за воротник.")

		saynn("[say=vion]Наверное, мне стоит тебя разбудить, но...[/say]")

		saynn("[say=pc]Ммм?[/say]")

		saynn("Ты стоишь, слегка покачиваясь из стороны в сторону, пока он размышляет.")

		saynn("[say=vion]Думаю, тебе будет веселее, если я не стану тебя беспокоить, а? Открой глаза, но при этом оставайся в трансе~[/say]")

		saynn("Твои веки дрожат и открываются, и ты упираешься взглядом в властные глаза Виона.")

		saynn("[say=vion]Вот так. Со стороны будет казаться, будто ты просто устала, ну, знаешь, будто ты слишком много [i]развлекалась[/i]. Но внутри... твой разум останется такой же уютной, бездумной кашей, какой он и является сейчас. Приятно, правда? Кивни мне.[/say]")

		saynn("Ты киваешь...")
		
		addButton("Продолжить", "", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		afterAwakener()
		return

	setState(_action)
