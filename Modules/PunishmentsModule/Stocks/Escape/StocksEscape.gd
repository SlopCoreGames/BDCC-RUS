extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "StocksEscape"


func _run():
	if(state == ""):
		addCharacter("rahi")
		playAnimation(StageScene.Duo, "stand", {npc="rahi"})
		
		saynn("Краем глаза вы замечаете какое-то движение: коричневошерстная кошка, сидевшая на скамье, поднялась на ноги. Она не очень крупная и одета в униформу общего блока.")

		saynn("Она немного озирается по сторонам, а затем осторожно подходит к вам. Сначала она освобождает ваши ноги от цепей, а затем отпирает верхнюю часть колодок, позволяя вам наконец-то выбраться. Вы встаете и потягиваетесь.")

		saynn("[say=rahi]Прости, что она не сделала этого раньше, когда на тебя смотрят другие — это страшно..[/say]")

		if(!GM.main.getModuleFlag("RahiModule", "Rahi_Introduced")):
			saynn("Хм, она что, говорит о себе в третьем лице?")

			saynn("[say=pc]Эм.. в любом случае, спасибо.[/say]")

			saynn("[say=rahi]Не стоит благодарности..[/say]")
		else:
			saynn("[say=pc]Спасибо, киса.[/say]")

			saynn("Она одаривает вас улыбкой и кивает.")

			saynn("[say=rahi]Все в порядке.[/say]")

		saynn("Коричневошерстная кошка убеждается, что с вами все хорошо, и возвращается на скамью в углу, чтобы продолжить отдых.")

		addButton("Уйти", "Тебя спасли!", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
