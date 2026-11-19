extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "MentalKeycardEscape"

func _run():
	#if(state == ""):
		#addCharacter("eliza")
		
	if(state == ""):
		# (if no hands)
		if(GM.pc.hasBlockedHands()):
			saynn("Руки совсем не слушаются, так что приходится... дрыгаться... пока ключ-карта не вывалится. Ты подхватываешь её ртом. Хм. Оглядываешься. Мягкие стены, пол... Похоже, приложить карту некуда. Неужели всё было зря?")

		# (if hands)
		else:
			saynn("Ты вытаскиваешь ключ-карту и оглядываешься. Хм. Вокруг только мягкие стены и пол... Ты не видишь ни одного места, куда можно было бы приложить карту. Неужели всё было зря?")

		saynn("Ты вздыхаешь и прислоняешься к мягкой двери. Пытаешься просунуть карту в щель между дверью и рамой, но ничего не выходит.")

		saynn("В отчаянии ты начинаешь тыкать картой во все попавшиеся места. Вдруг раздается писк. И дверь начинает открываться. Похоже, под одной из плиток всё-таки был считыватель.")

		addButton("Выскользнуть наружу", "Пора валить", "slip_out")

	if(state == "slip_out"):
		aimCamera("medical_firstcorridorcross")
		playAnimation(StageScene.Solo, "walk")
		setLocationName("Corridors")
		
		saynn("Похоже, тебя пока никто не заметил. Ты выбираешься из камеры и оглядываешься: психиатрическое отделение состоит из множества коридоров и комнат. Ты выглядываешь из-за угла и замечаешь патрулирующих медсестер и охранников.")

		saynn("Дождавшись подходящего момента, ты рвешь к выходу. Или туда, где, как тебе кажется, находится выход.")

		addButton("Продолжить", "Посмотрим, куда вы в итоге попадете", "continue")

	if(state == "continue"):
		aimCamera("med_lobbyne")
		playAnimation(StageScene.Solo, "walk")
		setLocationName("Medical lobby")
		GM.pc.setLocation("med_lobbyne")
		setModuleFlag("MedicalModule", "Mental_PlayerEscaped", true)
		
		# (if no hands)
		if(GM.pc.hasBlockedHands()):
			saynn("К счастью, ты, кажется, нашел шлюз, ведущий в вестибюль. На стене есть кнопка, которую не нажать руками, так что тебе приходится наклониться и ткнуть в неё лицом. Шлюз открывается.")

		# (if hands)
		else:
			saynn("К счастью, ты, кажется, нашел шлюз, ведущий в вестибюль. На стене есть кнопка, ты нажимаешь её. Шлюз открывается.")

		saynn("Сладкая свобода. Ну, почти.")

		addButton("Ура", "Вы сбежали", "endthescene")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
