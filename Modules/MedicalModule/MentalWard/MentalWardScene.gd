extends "res://Scenes/SceneBase.gd"

func getPossibleScenes():
	var newScenes = []
	var reusedScenes = []
	
	var tentacles = getModuleFlag("MedicalModule", "Mental_ExpTentacles", 0)
	if(tentacles >= 1):
		reusedScenes.append("MentalLatexParasite")
	else:
		newScenes.append("MentalLatexParasite")
	
	
	var obeyDrug = getModuleFlag("MedicalModule", "Mental_ExpObeyDrug", 0)
	if(obeyDrug >= 2):
		reusedScenes.append("MentalObedienceDrug2")
		reusedScenes.append("MentalObedienceDrug1")
	elif(obeyDrug == 1):
		newScenes.append("MentalObedienceDrug2")
		reusedScenes.append("MentalObedienceDrug1")
	else:
		newScenes.append("MentalObedienceDrug1")
		
	var ghostHands = getModuleFlag("MedicalModule", "Mental_ExpGhostHands", 0)
	if(ghostHands >= 3):
		reusedScenes.append("MentalGhostHands3")
		reusedScenes.append("MentalGhostHands2")
		reusedScenes.append("MentalGhostHands1")
	elif(ghostHands >= 2):
		newScenes.append("MentalGhostHands3")
		reusedScenes.append("MentalGhostHands2")
		reusedScenes.append("MentalGhostHands1")
	elif(ghostHands >= 1):
		newScenes.append("MentalGhostHands2")
		reusedScenes.append("MentalGhostHands1")
	else:
		newScenes.append("MentalGhostHands1")
		
	if(newScenes.size() > 0):
		return newScenes
	return reusedScenes

func _init():
	sceneID = "MentalWardScene"

func _reactInit():
	GM.pc.setLocation("medical_paddedcell_player")

func _run():
	#if(state == ""):
		#addCharacter("eliza")
		
	if(state == ""):
		aimCameraAndSetLocName("medical_paddedcell_player")
		playAnimation(StageScene.Solo, "kneel")
		GM.pc.setLocation("medical_paddedcell_player")
		
		saynn("Ты заперт в камере психиатрического отделения, и делать здесь совершенно нечего. Вокруг — мягкие стены, даже у массивной двери есть защитный слой. Единственное, что связывает тебя с внешним миром — это маленькое укрепленное окошко и вентиляционная решетка высоко под потолком, до которой не дотянуться.")
		
		if(GM.pc.hasBlockedHands()):
			saynn("Ты сидишь, прислонившись к стене, и постоянно обхватываешь себя руками. Может, это место не такое уж и плохое.")
		else:
			saynn("Ты сидишь, прислонившись к стене, и на этот раз не пытаешься постоянно обхватить себя руками.")
		#addButton("Продолжить", "Пора идти", "endthescene")
		
		var behavior = getModuleFlag("MedicalModule", "Mental_PCBehavior", 0.0)
		var sanity = getModuleFlag("MedicalModule", "Mental_PCSanity", 0.0)
		
		say("Твое поведение: ")
		if(behavior <= 0.1):
			sayn("Персонал считает твое поведение ужасным")
		elif(behavior <= 0.3):
			sayn("За тобой постоянно наблюдает персонал")
		elif(behavior <= 0.45):
			sayn("Персонал очень осторожен с тобой")
		elif(behavior <= 0.7):
			sayn("Персонал следит за тобой")
		elif(behavior <= 0.8):
			sayn("Персонал не особо следит за тобой")
		elif(behavior <= 0.9):
			sayn("Вы в очень хороших отношениях")
		else:
			sayn("Ты — идеальный подопытный")
			
		say("Твой рассудок: ")
		if(sanity <= 0.1):
			sayn("Полный аут")
		elif(sanity <= 0.4):
			sayn("Очень низкий")
		elif(sanity <= 0.6):
			sayn("Восстанавливается")
		elif(sanity <= 0.8):
			sayn("Почти восстановился")
		else:
			sayn("Ясный ум")
			
		addButton("Подождать", "Просто постоять без дела", "rest")
		addButton("Сопротивление", "Попытаться вырваться из пут", "struggle")
		if(getModuleFlag("MedicalModule", "Mental_HasKeycard", false)):
			addButton("Побег", "Используй ключ-карту, чтобы сбежать", "doescape")
	
	if(state == "sleeping"):
		saynn("Свет в камере погас, сигнализируя о том, что настала поздняя ночь. Ты ложишься на мягкий пол и пытаешься вздремнуть.")
		
		addButton("Спать", "Даже подушки нет", "dosleep")
		
	if(state == "dosleep"):
		saynn("Ты спишь в своей камере.")
		
		saynn("Добро пожаловать в "+str(GM.main.getDays())+" твоего срока")
		
		addButton("Продолжить", "Пора просыпаться", "")

	if(state == "resting"):
		saynn("Ты проводишь время в камере без дела...")
		
		addButton("Продолжить", "А разве эта камера не милашка?", "afterrest")

func _react(_action: String, _args):
	if(_action == "afterrest"):
		# Random scene checks
		if(!getModuleFlag("MedicalModule", "Mental_CheckupHappened", false) && GM.main.getTime() >= 9*60*60):
			setModuleFlag("MedicalModule", "Mental_CheckupHappened", true)
			
			if(isPCWearingAStraitjacket()):
				if(getModuleFlag("MedicalModule", "Mental_PCSanity", 0.0) >= 1.0):
					runScene("MentalCheckupFinal", [], "finalCheckup")
				else:
					# Random checkup scene
					var possibleScenes = ["MentalCheckup1", "MentalCheckup2"]
					
					runScene(RNG.pick(possibleScenes))
			else:
				runScene("MentalCheckupNoJacket", [], "mentalnojacketfight")
			
			setState("")
			return
		
		if(!getModuleFlag("MedicalModule", "Mental_ExperimentHappened", false) && GM.main.getTime() >= 14*60*60):
			setModuleFlag("MedicalModule", "Mental_ExperimentHappened", true)
			
			if(!isPCWearingAStraitjacket()):
				runScene("MentalCheckupNoJacket", [], "mentalnojacketfight")
			else:
				# Run random experiment scene
				var possibleScenes = getPossibleScenes()
				assert(possibleScenes.size() > 0)
				runScene(RNG.pick(possibleScenes))
			
			setState("")
			return
		
		if(!getModuleFlag("MedicalModule", "Mental_ShowerHappened", false) && GM.main.getTime() >= 19*60*60):
			setModuleFlag("MedicalModule", "Mental_ShowerHappened", true)
			
			if(isPCWearingAStraitjacket()):
				runScene("MentalShower")
			else:
				runScene("MentalCheckupNoJacket", [], "mentalnojacketfight")
			
			setState("")
			return
		
		setState("")
		return
		
	
	if(_action == "dosleep"):
		GM.main.startNewDay()
		GM.pc.afterSleepingInBed()
	
	if(_action == "rest"):
		if(GM.main.getTime() >= 21*60*60):
			setState("sleeping")
		else:
			setState("resting")
			processTime(60*60*2)
		MedicalModule.addPCSanity(RNG.randf_range(0.02, 0.04))
		GM.main.showLog()
		return

	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "struggle"):
		runScene("StrugglingScene", [], "struggle")
		setState("")
		return
		
	if(_action == "doescape"):
		runScene("MentalKeycardEscape")
		setState("")
		endScene()
		return
	
	setState(_action)

func isPCWearingAStraitjacket():
	if(GM.pc.getInventory().hasItemIDEquipped("LatexStraitjacket")):
		return true
	return false

func _react_scene_end(_tag, _result):
	if(_tag == "struggle"):
		_react("rest", [])
	
	if(_tag == "finalCheckup"):
		if(_result.size() > 0):
			var res = _result[0]
			
			if(res == "escape" || res == "good"):
				if(res == "good"):
					GM.pc.getInventory().unequipSlotRemoveIfRestraint(InventorySlot.Body)
				
				endScene()
				
			if(res == "sleep"):
				_react("dosleep", [])
	
	if(_tag == "mentalnojacketfight"):
		if(_result.size() > 0):
			var shouldStop = _result[0]
			if(shouldStop):
				endScene()

func getDebugActions():
	return [
		{
			"id": "instantEscape",
			"name": "Мгновенный побег",
			"args": [
			],
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "instantEscape"):
		endScene()
		GM.pc.setLocation("med_lobbymain")
		GM.main.reRun()
