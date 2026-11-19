extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "TaviStocksEscape"

func _run():
	if(state == ""):
		addCharacter("tavi")
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		
		saynn("Позади раздается чей-то голос.")

		saynn("[say=tavi]О, эй, эта задница выглядит знакомо![/say]")

		saynn("Ты пытаешься оглянуться, но угол поворота шеи слишком мал. Ты чувствуешь, как тебя шлепают по заднице, и невольно издаешь тихий стон.")

		saynn("[say=tavi]Мой питомец сегодня разбаловался, да~?[/say]")

		saynn("Тави входит в поле твоего зрения и приседает перед тобой; её лапа скользит по твоей щеке, несколько раз слегка постукивая.")

		saynn("[say=tavi]Ты так мило выглядишь, может, мне и не стоит тебя отпускать? Но ладно, так и быть.[/say]")

		saynn("Высокая кошка снимает цепи с твоих ног, а затем отпирает колодки, позволяя тебе наконец встать.")

		saynn("[say=tavi]Не привыкай к такому~[/say]")

		saynn("Она слегка похлопывает тебя по голове и уходит.")

		addButton("Уйти", "Тебя спасли!", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
