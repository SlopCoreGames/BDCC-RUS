extends SceneBase

var selectedRahiState = "rahi_is_sleeping"

func _init():
	sceneID = "rahiSlaveryMorningScene"

func _reactInit():
	if(getModule("RahiModule").canAdvanceStage()):
		setState("ask_if_advance")
		return
	var possible = []
	
	var slaveryStage = getModule("RahiModule").getSlaveryStage()
	
	if(slaveryStage <= 1):
		possible.append("rahi_is_sleeping")
		possible.append("rahi_is_sad")
	else:	
		possible.append("rahi_default")
	
	selectedRahiState = RNG.pick(possible)
	setState(selectedRahiState)
	playAnimation(StageScene.Duo, "stand", {npc="rahi"})
	addCharacter("rahi")

func _run():
	if(state == ""):
		saynn("Тебе не стоит этого видеть")

	if(state == "rahi_is_sleeping"):
		saynn("Вы входите в камеру Рахи. Кажется, она спит, поэтому вы даете о себе знать, пару раз кашлянув.")

		saynn("Уши Рахи дергаются, и она открывает глаза. Кошка быстро вскакивает и принимает покорную позу: спина прямая, голова наклонена вниз, руки по швам.")

		saynn("[say=rahi]Привет, {rahiMaster}..[/say]")

		saynn("[say=pc]Ты не пила алкоголь, пока меня не было?[/say]")

		saynn("Рахи едва заметно качает головой.")

		saynn("[say=pc]Верю, что ты не лжешь, киска.[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "pick_task_scene")
	if(state == "rahi_is_sad"):
		saynn("Зайдя в камеру к Рахи, вы застаете её свернувшейся на кровати: уши поникли, а хвост обернут вокруг тела.")

		saynn("Вы медленно приближаетесь к ней.")

		saynn("[say=pc]Эй, киска.[/say]")

		saynn("Рахи смотрит на вас своими печальными глазами и едва заметно кивает.")

		saynn("[say=rahi]Она держится.. неплохо.[/say]")

		saynn("Вы садитесь рядом с ней на кровать и кладете руку ей на плечо, пытаясь подбодрить. Уши Рахи слегка дергаются, когда она медленно поднимается, готовясь к выполнению своего задания.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pick_task_scene")
	if(state == "rahi_default"):
		saynn("Вы входите в камеру Рахи. Она, как обычно, ведет себя как ленивая кошечка, дремля в своей постели. Когда вы осторожно будите её, она быстро сползает с кровати и выпрямляется перед вами.")

		saynn("[say=rahi]Привет, {rahiMaster}..[/say]")

		saynn("Она потирает носик и терпеливо ждет своего задания.")

		saynn("[say=pc]Так, посмотрим..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "pick_task_scene")
	if(state == "ask_if_advance"):
		saynn("Вы готовы развить свои отношения с Рахи.")

		saynn("Хотите заняться этим прямо сейчас?")

		addButton("Да", "Улучшить отношения", "advance_stage")
		addButton("Не сегодня", "У вас есть дела поважнее", "no_advance")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "pick_task_scene"):
		endScene()
		runScene("rahiSlaveryPickTaskScene")
		return

	if(_action == "advance_stage"):
		var sceneToRun = getModule("RahiModule").getAdvanceStageScene()
		
		if(sceneToRun == null):
			setState("")
			return
		
		endScene()
		setFlag("RahiModule.rahiCommentedOnTask", true)
		setFlag("RahiModule.rahiTaskSuceeded", true)
		setFlag("RahiModule.rahiNeedsPunishment", false)
		setFlag("RahiModule.rahiTaskSuceeded", false)
		setFlag("RahiModule.rahiTired", 2)
		
		increaseFlag("RahiModule.rahiSlaveryStage", 1)
		setFlag("RahiModule.rahiSlaveryShowNewSkill", true)
		runScene(sceneToRun)
		return

	if(_action == "no_advance"):
		setState(selectedRahiState)
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["selectedRahiState"] = selectedRahiState

	return data

func loadData(data):
	.loadData(data)

	selectedRahiState = SAVE.loadVar(data, "selectedRahiState", "rahi_is_sleeping")
