extends SceneBase

func _init():
	sceneID = "DomM2s3"

func _reactInit():
	putOff("ferri", "inmatewristcuffs")
	putOff("ferri", "basketmuzzle")

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		addCharacter("kait")
		saynn("Кейт радостно подпрыгивает.")

		saynn("[say=kait]Наконец-то! Эта дрянь получила по заслугам.[/say]")

		saynn("И это та самая девчонка, которую считали просто тряпкой?")

		saynn("[say=pc]Нет смысла больше держать её в камере.[/say]")

		saynn("[say=kait]Ага. Посмотрим, насколько она теперь покорная~.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "player_brings_ferri_out")
	if(state == "player_brings_ferri_out"):
		addCharacter("ferri")
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcBodyState={leashedBy="pc"}, npcAction="kneel"})
		saynn("Ты выводишь Ферри, держа её на поводке. Ты также сняла с неё все остальные оковы.")

		saynn("[say=ferri]Мяу..[/say]")

		saynn("Кейт наклоняется к самому её лицу.")

		saynn("[say=kait]Ты ведь будешь делать всё, что мы скажем, а, дрянь~?[/say]")

		saynn("[say=ferri]Да, госпожа.. м-мяу..[/say]")

		saynn("Что ж, стоит это проверить.")

		saynn("[say=pc]Встань предо мной на колени.[/say]")

		saynn("Услышав твои слова, Ферри навострила ушки. Она тут же пристроилась перед тобой и, повинуясь приказу, опустилась на колени. Её голубые глаза смотрят на тебя снизу вверх, а хвост расслабленно лежит на полу.")

		saynn("[say=ferri]Вот..[/say]")

		saynn("Кейт широко ухмыляется.")

		saynn("[say=kait]Прелестно![/say]")

		saynn("Щёки Ферри слегка розовеют.")

		saynn("[say=ferri]Нет, это ты..[/say]")

		saynn("[say=pc]Признай, что ты само очарование.[/say]")

		saynn("[say=ferri]Не-е-ет..[/say]")

		saynn("Она пытается отвести взгляд, но ты подхватываешь её за подбородок, заставляя снова посмотреть на тебя.")

		saynn("[say=pc]Ферри.[/say]")

		saynn("Её губы подрагивают.")

		saynn("[say=ferri]Хмф.. А ведь я довольно милая..[/say]")

		saynn("Ты гладишь её по голове.")

		saynn("[say=pc]Хорошая девочка. Ты будешь нашим химиком.[/say]")

		saynn("[say=ferri]Мяу.. А у вас есть.. ну, химическая лаборатория?..[/say]")

		saynn("Точно. Такое бывает. Вы с Кейт переглядываетесь.")

		saynn("[say=pc]Мы что-нибудь придумаем.[/say]")

		saynn("Ты тянешь за поводок, заставляя её подняться.")

		saynn("[say=pc]Пока ты на свободе. Мы найдем тебя, когда ты нам понадобишься.[/say]")

		saynn("[say=ferri]Ладно..[/say]")

		saynn("Ты расстегиваешь карабин на поводке и отпускаешь её.")

		addButton("Продолжить", "Смотреть, что будет дальше", "last_mission_complete")
	if(state == "last_mission_complete"):
		setCharacters(["kait"])
		playAnimation(StageScene.Duo, "stand", {npc="kait"})
		saynn("[say=kait]Думаю, в целом всё могло пройти и лучше. Но мы это сделали.[/say]")

		saynn("[say=pc]Полагаю, теперь нам нужно найти лабораторию для Ферри.[/say]")

		saynn("[say=kait]Ну да, кто бы мог подумать... химикам нужны химические лаборатории... Пора бы нам заглянуть в медблок.[/say]")

		saynn("Но это будет в другой раз. А пока — просто наслаждайся своей сладкой победой.")

		saynn("Миссия выполнена!")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "player_brings_ferri_out"):
		processTime(3*60)

	if(_action == "last_mission_complete"):
		GM.main.MS.completeMission()

	setState(_action)
