extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "AlexRynardStartPantiesQuestScene"

func _run():
	if(state == ""):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})

	if(state == ""):
		# (You say that the mining stuff is boring and if you can somehow help and earn credits other ways)

		# (Foxy hmms and comes up with a thing while looking at the prototype)

		# (Foxy asks you to bring female panties, normal ones)

		saynn("Ты издаешь отчетливый вздох, пытаясь привлечь внимание Фокси. Похоже, он по уши погряз в своем текущем проекте.")

		saynn("[say=pc]Эй. Просто хотела спросить, есть ли какой-то другой способ заработать кредиты?[/say]")

		saynn("Фокси несколько раз кивает, делая вид, что слушает, но его глаза прикованы к какому-то руководству. Ты решаешь немного попозировать — может, ему просто нужно капельку соблазна?")

		saynn("[say=pc]Знаешь, вкалывать в шахтах целыми днями — то еще удовольствие.[/say]")

		saynn("Теперь настала его очередь вздыхать. Он окинул тебя взглядом, задержавшись на твоем теле, а затем резко бросил фразу саркастичным тоном.")

		saynn("[say=alexrynard]Ты что, хочешь трахнуться со мной в обмен на кредиты?[/say]")

		saynn("Ты ахаешь от неожиданности.")

		saynn("[say=pc]Нет-нет, ты о чем вообще? Конечно нет... Если только?..[/say]")

		saynn("Он закатывает глаза и качает головой.")

		saynn("[say=alexrynard]Не видишь, что я занят? Мне нужно протестировать этот последний прототип.[/say]")

		saynn("[say=pc]Ну... Чем могу помочь?[/say]")

		saynn("[say=alexrynard]Как какая-то шлюшливая заключенная вообще может помочь мне тестировать этот аппарат для переноса материи через блюспейс... погоди... хмм...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "continue")

	if(state == "continue"):
		saynn("Этот чертяка держит в руках одно из устройств; оно похоже на плоское кольцо с каким-то отверстием посередине и пазом для кристалла.")

		saynn("[say=alexrynard]У меня есть идея. Принеси мне трусиков. Женских.[/say]")

		saynn("Ты удивленно вскидываешь бровь от такой внезапной странной просьбы. Неужели этот чертяка втайне нюхальщик трусиков?")

		saynn("[say=pc]Э-э. Типа, б/у?[/say]")

		saynn("[say=alexrynard]Они нужны мне для тестов, чудик. Новые, старые — мне плевать. Просто принеси мне какие-нибудь обычные трусики. Загляни в прачечную.[/say]")

		saynn("Ты пожимаешь плечами.")

		saynn("[say=pc]Ладно. Я что-нибудь найду.[/say]")

		addButton("Продолжить", "Это было легко", "endthescene")


func _react(_action: String, _args):
	if(_action == "continue"):
		addMessage("Добавлено новое задание")
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

