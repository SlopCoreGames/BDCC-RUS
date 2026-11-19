extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "AlexRynardPantiesQuestWTFScene"

func _run():
	if(state == ""):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})

	if(state == ""):
		# (You yell angery at the foxy asking why are people using you through the panties)

		# (He shrugs and says someone must have stolen the fleshlighs. And that the inmates have them)

		# (Return them and you will get more coins and the ability to take off panties?)

		saynn("Вы внезапно срываетесь на инженера и орете.")

		saynn("[say=pc]Какого хуя?![/say]")

		saynn("Фокси смотрит вам прямо в глаза, прищурившись.")

		saynn("[say=alexrynard]В каком смысле «какого хуя»?[/say]")

		saynn("Вы выставляете напоказ свои портальные трусики и демонстрируете их ему.")

		saynn("[say=pc]Ты говорил, что будут только тесты, но теперь меня через них трахают! Это твоя идея?![/say]")

		saynn("Фокси открывает рот, выглядя крайне, крайне удивленным.")

		saynn("[say=alexrynard]А, точно. Забыл тебе сказать. Кто-то спер прототипы.[/say]")

		addButton("WHAT", "Пиздец", "what")

	if(state == "what"):
		# (if has pussy)
		if(GM.pc.hasVagina()):
			saynn("[say=pc]В каком смысле?! Где моя гребаная киска?![/say]")

		# (else)
		else:
			saynn("[say=pc]В смысле, где моя гребаная задница?![/say]")

		saynn("Фокси ухмыляется, но вовремя берет себя в руки и просто несколько раз пожимает плечами.")

		saynn("[say=alexrynard]Без понятия, наверное, какие-то зэки ее нашли.[/say]")

		saynn("Это злит тебя еще сильнее — ты словно бомба, готовая вот-вот взорваться. Заметив это, Фокси добавляет:")

		saynn("[say=alexrynard]Давай так. Если найдешь прототипы и вернешь их мне, я отсыплю тебе кредитов. Как тебе такое предложение?[/say]")

		saynn("Ты даже не знаешь, как реагировать на это внезапное предложение.")

		saynn("[say=pc]Разве ты не можешь... просто выключить эти трусы?[/say]")

		saynn("Фокси снова пожимает плечами и одаривает тебя невинной улыбкой.")

		saynn("[say=alexrynard]Нельзя. Магнитные замки можно отключить только с другой стороны. И тебе очень не хочется, чтобы я создала сингулярность, ковыряясь в них прямо сейчас.[/say]")

		saynn("[say=pc]Великолепная инженерная мысль...[/say]")

		saynn("Он хватает тебя за воротник и притягивает лицо ближе к своему. Он хмурится.")

		saynn("[say=alexrynard]Эй. На тебе надето произведение технологического искусства, самая передовая разработка. Прояви хоть каплю уважения к мастерству. Камера только что зафиксировала в блоке несколько заключенных, у которых в руках что-то похожее на мастурбатор. Иди и забери это.[/say]")

		addButton("Ладно", "Будто у тебя есть выбор", "fine")

	if(state == "fine"):
		saynn("Ты соглашаешься на его предложение и уходишь. Он упомянул блок с камерами. Пожалуй, стоит начать поиски оттуда.")

		# (scene ends)

		addButton("Продолжить", "Что тут поделаешь", "endthescene")


func _react(_action: String, _args):
	if(_action == "fine"):
		addMessage("Задача обновлена")
		addExperienceToPlayer(30)
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

