extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "AlexRynardTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["alexrynard"])):
		endScene()
		return

func _run():
	if(state == ""):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})

	if(state == ""):
		saynn("Вы подходите к чертовски привлекательному инженеру. На его рабочем месте есть стул, но Алекс стоит — похоже, он чем-то занят. Вы садитесь на край рабочего стола, привлекая его внимание.")
		
		if(getFlag("AlexRynardModule.ch2CanEnterEngineering")):
			saynn("[say=alexrynard]О, привет.[/say]")
		else:
			saynn("[say=alexrynard]Ну, чего тебе?[/say]")

		addButton("Поговорить", "Поболтать о всяком", "talk")
		addButton("Внешность", "Рассматривать инженера", "appearance")
		if(GlobalRegistry.getItemIDsByTagSlow(ItemTag.SoldByAlexRynard).size() > 0):
			addButton("Купить", "Посмотреть, что можно купить у Алекса", "buyscene")
		if(getFlag("AlexRynardModule.ch2FinalSceneHappened", false)):
			addButton("Покормить", "Покормить Алекса", "feedmenu")
		addButton("Уйти", "Разговоров было достаточно", "endthescene")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["alexrynard"])
		

	if(state == "talk"):
		# (if before portal stuff)
		if(!getFlag("PortalPantiesModule.Panties_AskedAlex")):
			saynn("[say=pc]Просто хотел кое-о-чем спросить.[/say]")

			saynn("[say=alexrynard]Опять собираешься тратить мое время?[/say]")

			saynn("Похоже, этот красавчик не в духе. А может, он просто занят — на столе всё еще лежит тот прототип.")

			addButton("Продолжить", "Ну и ладно", "")
		# (if portal stuff happened)
		else:
			saynn("[say=pc]Просто хотел кое-о-чем спросить.[/say]")

			saynn("[say=alexrynard]Стреляй.[/say]")

			addButton("Инженер", "Спросить о его роли", "engineer")
			addButton("Блюспейс", "Что такое блюспейс?", "bluespace")
			addButton("О нём", "Почему он здесь?", "him")
#ACEPREGEXPAC - New Talk scene about preg
			if(getFlag("AlexRynardModule.ch2FinalSceneHappened") && GM.pc.isVisiblyPregnant() || (getCharacter("alexrynard").isVisiblyPregnant())):
				addButton("Беременность", "Все, что связано с беременностью", "pregnancytalk")
			else:
				addDisabledButton("Беременность", "Алекс должен начать тебе доверять... и ты, очевидно, должна быть беременна")
			addButton("Назад", "Хватит болтать", "")
			
	if(state == "engineer"):
		saynn("[say=pc]Чем здесь занимаются инженеры?[/say]")

		saynn("Фокси расслабленно откинулся в кресле.")

		saynn("[say=alexrynard]Много чего. Очевидно, мы чиним всё, что сломано. Будь то вещи заключенных или что-то другое. Также мы обеспечиваем энергией главный реактор станции. Заключенные добывают достаточно урана, чтобы станция была полностью автономной.[/say]")

		saynn("Уран, значит.")

		saynn("[say=pc]А что, если не будут?[/say]")

		saynn("Фокси одаривает тебя холодной улыбкой и слегка постукивает пальцем по твоему ошейнику.")

		saynn("[say=alexrynard]Это и наша работа тоже. Симпатично, правда? Стандартные версии — просто жалкое зрелище, они едва удерживают замок. Наши же могут отслеживать владельца с другого конца галактики, а заодно и убить тебя током.[/say]")

		saynn("Ты слегка потягиваешь за ошейник; от кучи дополнительных функций удобнее он точно не стал.")

		saynn("[say=pc]Как им это удается?[/say]")

		saynn("[say=alexrynard]Блюспейс.[/say]")
		
		addButton("Продолжить", "Спросить о чем-то другом", "talk")

	if(state == "bluespace"):
		saynn("[say=pc]Э-э, а что именно представляет собой Блюспейс?[/say]")

		saynn("Этот лис показывает тебе какой-то темно-синий кристалл.")

		saynn("[say=alexrynard]Это другое измерение, связанное с нашим. Теоретически, с помощью этих кристаллов мы можем передавать через него энергию, электромагнитные волны и даже материю.[/say]")

		saynn("Хм. Он говорит о телепортации. Может, это твой способ выбраться?")

		saynn("[say=pc]Неужели всё так просто?[/say]")

		saynn("[say=alexrynard]Нет, не «так» просто. Нужно настроить два кристалла на одну и ту же частоту. И если ты всё просрёшь, вместо выхода получишь сингулярность.[/say]")

		saynn("Завораживающе. И пугающе.")
		
		addButton("Продолжить", "Спросить о чем-то другом", "talk")

	if(state == "him"):
		saynn("[say=pc]Ты кажешься умной. Как ты оказалась здесь, в космической тюрьме?[/say]")

		saynn("Лис на секунду отводит взгляд, ты замечаешь его бесстрастное лицо.")

		saynn("[say=alexrynard]Меня прислала АльфаКорп, а здесь выбор есть не всегда.[/say]")

		saynn("[say=pc]Похоже, ты не в восторге от этого.[/say]")

		saynn("Он хмурится.")

		saynn("[say=alexrynard]Я в порядке.[/say]")

		saynn("Он бросает на тебя холодный взгляд. Если расспрашивать его дальше, это наверняка только разозлит его.")

		addButton("Продолжить", "Спросить о чем-то другом", "talk")

	if(state == "appearance"):
		saynn("Первое, что бросается в глаза при взгляде на лицо Алекса Ринарда, — это два черных квадрата под каждым глазом, замысловатый узор, который выглядит весьма неестественно. В остальном же в нем нет ничего особенного: средний рост, крепкое телосложение, изумрудные глаза и длинная заостренная собачья морда с черной отметиной, которая есть почти у всех лис. Мех не слишком уникальный: белый на животе, щеках, ладонях и пальцах, и оранжевый на остальном теле. Ближе к лапам и подушечкам пальцев мех заметно темнее, почти теряя насыщенность. Его длинные черные волосы собраны в аккуратный хвост.")

		saynn("Алекс одет в инженерную форму: темная рубашка и брюки из какого-то плотного материала с желтой окантовкой. Единственный элемент защиты — наплечники, придающие его наряду чуть более решительный вид. На нем пояс с множеством подсумков, но инструментов там немного.")

		saynn("Трудно сказать наверняка, но ты замечаешь, что в районе паха его штаны слегка выпирают — похоже, там прячется ножны с собачьим членом, так что в этом плане всё отлично.")

		saynn("Когда он двигается, ты замечаешь исходящее от него тихое механическое гудение.")

		# (scene ends)
		addButton("Продолжить", "Хватит пялиться!", "")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		
	if(_action == "buyscene"):
		endScene()
		runScene("AlexBuySellScene", ["buymenu"])
		return
	if(_action == "pregnancytalk"):
		endScene()
		runScene("AlexPregTalkSceneAPE")
		
	if(_action == "feedmenu"):
		runScene("FeedSomethingScene", ["alexrynard"])
		return
		
	setState(_action)

