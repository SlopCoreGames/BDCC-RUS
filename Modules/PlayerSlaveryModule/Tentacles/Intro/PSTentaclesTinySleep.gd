extends SceneBase

func _init():
	sceneID = "PSTentaclesTinySleep"

func _reactInit():
	addCharacter(GM.main.PS.getTentaclesCharID())

func resolveCustomCharacterName(_charID):
	if(_charID == "ten"):
		return GM.main.PS.getTentaclesCharID()
	if(_charID == "sci1"):
		return GM.main.PS.getScientist1CharID()
	if(_charID == "sci2"):
		return GM.main.PS.getScientist2CharID()

func _run():
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(state == ""):
		playAnimation(StageScene.Sleeping, "sleep")
		var theBiggestStat = _tentacles.getBiggestStat()
		saynn("Пришло время вздремнуть...")

		if (theBiggestStat == _tentacles.STAT_ANGER):
			saynn("Щупальца всё ещё кажутся довольно... рассерженными. Они вымещают свой гнев на холодном полу, постукивая по нему.")

			saynn("Ты не слишком боишься... ведь они всё ещё слишком слабы, чтобы активно двигаться. Ты просто заглушаешь шум, сильнее вжимаясь лицом в уютную подушку.")

		elif (theBiggestStat == _tentacles.STAT_AGILITY):
			saynn("Щупальца уже крепко спят... По крайней мере, так кажется. Они отдыхают, свернувшись друг на друге... Это даже мило.")

			saynn("Ты не боишься, что они внезапно на тебя набросятся... ведь они всё ещё слишком слабы, чтобы куда-то перемещаться.")

		elif (theBiggestStat == _tentacles.STAT_MIND):
			saynn("Щупальца уже крепко спят... По крайней мере, так кажется. Они отдыхают, свернувшись друг на друге... Это даже мило.")

			saynn("Каким-то образом их присутствие заставляет тебя чувствовать себя в большей безопасности.")

		elif (theBiggestStat == _tentacles.STAT_LUST):
			saynn("Щупальца уже крепко спят... По крайней мере, так кажется. Они отдыхают, свернувшись друг на друге... Это даже мило.")

			saynn("Ты гадаешь, можно ли затащить их к себе в кровать... спрятать под одеяло... Эх, а почему бы и нет.")

			saynn("В предвкушении ты встаёшь и осторожно подхватываешь сбитых с толку щупалец. Они не слишком тяжёлые.")

			saynn("[say=pc]Тссс.. всё хорошо..[/say]")

			saynn("Вы притягиваете их к себе в постель и позволяете им устроиться рядом с вашей грудью.")

			saynn("[say=pc]Вот так..[/say]")

			saynn("И теперь.. вы пытаетесь уснуть.")

			saynn("Как выяснилось.. щупальца очень.. щекотные.. Их постоянные прикосновения в самых разных местах заставляют вас слегка ерзать.")

			saynn("И всё же.. приятно чувствовать, что ты не один.")

		else:
			saynn("Щупальца уже крепко спят.. По крайней мере, так кажется. Каждое из них нашло себе уютный уголок в гнезде.")

			saynn("Теперь можно спокойно спать.")

		addButton("Спать", "Смотреть, что будет дальше", "newday")
	if(state == "newday"):
		# (( small idle anim
		playAnimation(StageScene.TentaclesDuo, "idle", {tentaclesSizeSmall=true, plant=true})
		aimCameraAndSetLocName("pstent_left")
		GM.pc.setLocation("pstent_left")
		saynn("Наступил новый день..")

		saynn("И первое, что вы замечаете после пробуждения.. это то, что щупалец нет в гнезде!")

		saynn("О.. Они подросли достаточно, чтобы передвигаться самостоятельно.")

		saynn("У щупальцевого монстра выросло еще немало новых отростков... а те, что были раньше, стали массивнее и сильнее... теперь он способен выбраться из своего гнезда.")

		saynn("[say=sci2]Проснулась, подопытная? Хорошо.[/say]")

		saynn("[say=pc]Ты была здесь? Почему не разбудила меня раньше?[/say]")

		saynn("[say=sci2]Нам хотелось посмотреть, что оно с тобой сделает.[/say]")

		saynn("[say=sci1]Твоя работа — быть манекеном для тестов. Манекеном.[/say]")

		saynn("Понятно...")

		saynn("[say=pc]И что теперь?[/say]")

		saynn("[say=sci2]Нам понадобится несколько дней, чтобы обработать все собранные данные. А пока твоя задача — присматривать за ним.[/say]")

		saynn("[say=sci1]Ага. Если дашь растению сдохнуть, у нас не будет причин тебя держать.[/say]")

		saynn("Тебя не покидает предчувствие, что это вовсе не означает твое освобождение.")

		saynn("Ты пожимаешь плечами.")

		saynn("[say=sci1]Корми его, дрессируй, развлекай. Ты уже знаешь правила.[/say]")

		saynn("Должно быть достаточно просто.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	var _tentacles:PlayerSlaveryTentacles = GM.main.PS

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "newday"):
		GM.main.startNewDay()
		_tentacles.setStage(_tentacles.STAGE_SMALL)
		_tentacles.setMonsterLoc("pstent_left")

	setState(_action)
