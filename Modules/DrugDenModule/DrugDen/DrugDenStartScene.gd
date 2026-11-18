extends SceneBase

func _init():
	sceneID = "DrugDenStartScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		
		saynn("Ты стоишь перед заброшенным вентиляционным люком, который ведет вниз, в подземный притон.")
		
		saynn("Тебе придется оставить здесь все свои вещи. Их вернут тебе после забега. Твои статы и перки также будут временно сброшены на время пребывания там.")
		
		var highestLevel:int = int(GM.main.getFlag("DrugDenModule.HighestDrugDenLevel", 0))
		sayn("Максимальный достигнутый уровень: "+str(highestLevel))
		
		var raidedLabsAmount:int = int(GM.main.getFlag("DrugDenModule.RaidedLabs", 0))
		saynn("Количество разграбленных/уничтоженных нарколабораторий: "+str(raidedLabsAmount))
		
		saynn("Хочешь начать новый забег?")
		
		if(GM.pc.isWearingPortalPanties()):
			addDisabledButton("Новый забег", "В твоих портальных трусиках есть технологии блюспейса, которые будут мешать наноботам Элизы. Сначала сними их!")
		else:
			addButton("Новый забег", "Начать исследование туннелей", "do_start")
		addButton("Отмена", "Ты передумал!", "endthescene")

	if(state == "do_start"):
		aimCameraAndSetLocName(GM.pc.getLocation())
		
		saynn("Ты прячешь свои вещи в специальном тайнике и протискиваешься в вентиляционную шахту...")
		
		saynn("Волна резкого, пропитанного химикатами воздуха наполняет твои легкие. Она обволакивает чувства, затуманивая разум и высасывая силы. К этому придется привыкнуть...")
		
		saynn("Вскоре ты начинаешь терять ориентацию. Все туннели становятся на одно лицо... да и темнота не помогает. Остается лишь надеяться, что наноботы Элизы справятся...")
		
		addButton("Продолжить", "Пора за дело", "endthescene_markfirst")
	
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "endthescene_markfirst"):
		endScene()
		setFlag("DrugDenModule.FirstTimeHappened", true)
		return
	if(_action == "do_start"):
		GM.main.DrugDenRun = DrugDen.new()
		GM.main.DrugDenRun.start()


	setState(_action)
