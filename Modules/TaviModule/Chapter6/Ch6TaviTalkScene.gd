extends SceneBase

func _init():
	sceneID = "Ch6TaviTalkScene"

func _run():
	var taviModule = getModule("TaviModule")
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		addCharacter("tavi")
		aimCameraAndSetLocName("cellblock_red_nearcell")
		
		saynn("Тави неподвижно стоит у своей кровати. Кажется, сегодня её желания удовлетворены.")
		
		if(taviModule.isVirgin()):
			if(getFlag("TaviModule.Ch6TaviRegrewHymen")):
				saynn("У Тави всё ещё восстановленная девственность.")
			else:
				saynn("Тави всё ещё девственница.")
			
		sayn("Развращённость Тави: {taviCorruption}")
		saynn("Усталость Тави: "+str(getFlag("TaviModule.Ch6Tiredness", 0)))
		
		sayn("Навыки Тави:")
		for skillID in taviModule.getAllSkills():
			var skillInfo = taviModule.getSkillInfo(skillID)
			if(skillInfo == null):
				continue
			if(!taviModule.canTrainSkill(skillID)):
				continue
			
			sayn(skillInfo["name"]+": "+str(taviModule.getSkillScoreText(skillID)))
		sayn("")
		
		
		if(!getFlag("TaviModule.Ch7CaptainSceneHappened")):
			if(getFlag("TaviModule.Ch7PlanningSceneHappened")):
				if(taviModule.hasAllSkillsLearnedFully() && (taviModule.getCorruption() <= 0.0 || taviModule.getCorruption() >= 2.0)):
					addButtonUnlessLate("Final Attack", "Use everything that you and Tavi learned to carry out the last attack.\n\nTo let Tavi help you during the final attack, she needs to be fully trained on all skills and her corruption needs to be either 0% or 200%", "start_final_attack")
				else:
					addDisabledButton("Финальная атака", "Чтобы Тави помогла вам в финальной атаке, она должна быть полностью обучена всем навыкам, а уровень её развращённости должен составлять либо 0%, либо 200%")
			else:
				if(taviModule.getCorruption() <= 0.0 || taviModule.getCorruption() >= 2.0):
					addButtonUnlessLate("Final Attack", "Use everything that you and Tavi learned to prepare the last attack.\n\nTavi's corruption needs to be either 0% or 200%", "start_plan_scene")
				else:
					addDisabledButton("Финальная атака", "Используйте всё, чему научились вы и Тави, чтобы подготовить решающий удар.\n\nРазвращённость Тави должна быть либо 0%, либо 200%")
				
		if(getFlag("TaviModule.Ch6Tiredness", 0) >= 3):
			addDisabledButton("Тренировать", "Тави слишком устала")
			addDisabledButton("Занятия", "Тави слишком устала")
		else:
			addButton("Тренировать", "Потренировать один из навыков Тави", "train_menu")
			addButton("Занятия", "Посмотреть, на что способна Тави", "activities_menu")
		
		
		addButton("Покормить", "Покормить Тави", "feedmenu")
		addButton("Уйти", "Хватит болтать", "endthescene")
		
	if(state == "activities_menu"):
		saynn("Что ты хочешь сделать с Тави?")
		
		addButton("Душ", "Пойти в душ вместе с Тави", "do_activity", ["Ch6TaviShowerScene"])
		if(taviModule.getOverallCorruptStage() >= 1):
			addButton("Дойка", "Попытаться подоить грудь Тави", "do_activity", ["Ch6TaviMilkingScene"])
		else:
			addDisabledButton("Дойка", "Тави еще не готова к этому")
		if(taviModule.getOverallCorruptStage() >= 2):
			addButton("Переспать с тобой", "Обсудить то, что Тави спит в твоей камере", "do_sleepscene")
		if(getFlag("TaviModule.Ch6TaviAndRahiStackSceneHappened")):
			addButton("Тави + Рахи", "Попросить Тави привести Рахи", "do_activity", ["Ch6TaviRahiButtstackScene"])
		if(getFlag("TaviModule.Ch6CorruptionStage", 0) >= 1):
			if(taviModule.hasAllSkillsLearnedFully() && getFlag("TaviModule.Ch6CorruptionStage", 0) >= 4):
				addButton("Фокусы", "Новая форма Тави позволяет ей творить крутые магические фокусы...", "do_activity", ["Ch6TaviDemonScene"])
			else:
				addDisabledButton("Фокусы", "Чтобы сделать это, уровень разврата Тави должен достичь 200%, а все навыки должны быть полностью прокачаны")
			
		addButton("Назад", "Назад в предыдущее меню", "")
		
	if(state == "train_menu"):
		saynn("Какой навык хочешь прокачать?")
		
		sayn("Навыки Тави:")
		for skillID in taviModule.getAllSkills():
			var skillInfo = taviModule.getSkillInfo(skillID)
			if(skillInfo == null):
				continue
			if(!taviModule.canTrainSkill(skillID)):
				continue
			sayn(" - "+skillInfo["name"]+": "+str(taviModule.getSkillScoreText(skillID)))
			sayn(skillInfo["desc"])
		sayn("")
		
		for skillID in taviModule.getAllSkills():
			var skillInfo = taviModule.getSkillInfo(skillID)
			if(skillInfo == null):
				continue
			if(!taviModule.canTrainSkill(skillID)):
				continue
			addButton(skillInfo["name"], skillInfo["desc"], "do_skill", [skillInfo])
		
		addButton("Назад", "Назад", "")
	
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "do_skill"):
		setState("")
		increaseFlag("TaviModule.Ch6Tiredness", 1)
		runScene(_args[0]["scene"])
		return

	if(_action == "do_activity"):
		setState("")
		increaseFlag("TaviModule.Ch6Tiredness", 1)
		runScene(_args[0])
		return
	
	if(_action == "do_sleepscene"):
		setState("")
		runScene("Ch6TaviAllowSleepInCellScene")
		return
	
	if(_action == "start_plan_scene"):
		setFlag("TaviModule.Ch7PlanningSceneHappened", true)
		runScene("Ch7s1PlanningScene")
		endScene()
		return
		
	if(_action == "start_final_attack"):
		runScene("Ch7s2bTaviScene")
		endScene()
		return

	if(_action == "feedmenu"):
		runScene("FeedSomethingScene", ["tavi"])
		return

	setState(_action)

func getDebugActions():
	return [
		{
			"id": "setCorruption",
			"name": "Set Corruption",
			"args": [
				{
					"id": "newcorruption",
					"name": "0-200%",
					"type": "number",
					"value": 100,
				},
			]
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "setCorruption"):
		setFlag("TaviModule.Ch6Corruption", clamp(_args["newcorruption"] / 100.0, 0.0, 2.0))
