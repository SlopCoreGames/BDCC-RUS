extends "res://Scenes/SceneBase.gd"

var minigameScene = preload("res://Game/Minigames/ClickAtTheRightTime/ClickAtTheRightTime.tscn")
#var minigameScene = preload("res://Game/Minigames/Struggling/StrugglingGame.tscn")

func _init():
	sceneID = "MeScene"

func _run():
	if(state == ""):
		#GM.pc.cummedInVaginaBy("nova")
		if(GM.main.getFlag("Game_CompletedPrologue")):
			var genderSTR = "a male"
			if(GM.pc.getGender() == Gender.Female):
				genderSTR = "a female"
			if(GM.pc.getGender() == Gender.Androgynous):
				genderSTR = "an androgynous"
			if(GM.pc.getGender() == Gender.Other):
				genderSTR = "a non-gender"
			var badThingName = "was imprisoned for the crime of theft"
			if(GM.main.getFlag("Player_Crime_Type") == Flag.Crime_Type.Innocent):
				badThingName = "was wrongly imprisoned"
			if(GM.main.getFlag("Player_Crime_Type") == Flag.Crime_Type.Murder):
				badThingName = "was imprisoned for the crime of murder"
			if(GM.main.getFlag("Player_Crime_Type") == Flag.Crime_Type.Prostitution):
				badThingName = "was imprisoned for the crime of prostitution"
			saynn(GM.pc.getName() +" is "+genderSTR+" "+GM.pc.getSpeciesFullName() + " that "+badThingName+". Длина предложения неопределена")
		
		sayn("[b]Личная информация:[/b]")
		sayn("Имя: "+GM.pc.getName())
		sayn("Вид: "+GM.pc.getSpeciesFullName())
		sayn("Пол: "+Gender.genderToString(GM.pc.getGender()).capitalize())
		sayn("Местоимения: "+Gender.genderToPronouns(GM.pc.getPronounGender()))
		
		sayn("Женственность: "+str(GM.pc.getFemininity())+"%")
		sayn("Объем: "+str(GM.pc.getThickness())+"%")
		
		sayn("")
		
		sayn("[b]Биографическая информация:[/b]")
		sayn("Опьянение: "+str(round(GM.pc.getIntoxicationLevel()*100.0))+"%")
		sayn("Толерантность к опьянению: "+str(round(GM.pc.getIntoxicationTolerance()*100.0))+"%")
		var menstrualCycle: MenstrualCycle = GM.pc.getMenstrualCycle()
		if(menstrualCycle != null && menstrualCycle.hasAnyWomb()):
			sayn("Менструальный цикл: "+str(CycleStage.getVisibleActionName(menstrualCycle.getCurrentStage())))
			sayn("Длительность цикла: "+str(Util.roundF(menstrualCycle.getCycleLength()/60.0/60.0/24.0, 1))+" days")
			sayn("Заметная беременность: "+str(menstrualCycle.isVisiblyPregnant()))
			sayn("В состоянии течки: "+str(menstrualCycle.isInHeat()))
			sayn("Примерный шанс забеременеть после секса: "+str(Util.roundF(menstrualCycle.getRoughChanceOfBecomingPregnant(), 1))+"%")
			sayn("Фертильность: "+str(Util.roundF(GM.pc.getFertility()*100.0, 1))+"%")
		if(GM.pc.hasPenis()):
			sayn("Вирильность: "+str(Util.roundF(GM.pc.getVirility()*100.0, 1))+"%")
		sayn("")
		
		var bodyparts = GM.pc.getBodyparts()
		for bodypartSlot in bodyparts:
			var slotName = BodypartSlot.getVisibleName(bodypartSlot)
			var bodypart: Bodypart = bodyparts[bodypartSlot]
			sayn("[b]"+slotName+"[/b]")
			
			if(bodypart == null):
				sayn("Ничего")
				continue
				
			sayn("Тип: "+bodypart.getName())
			for attribData in bodypart.getAttributesText():
				sayn(attribData[0]+": "+str(attribData[1]))
			if(bodypart.getOrifice() != null):
				sayn("Тип отверстия: "+bodypart.getOrificeName())
				for attribData in bodypart.getOrifice().getAttributesText():
					sayn(attribData[0]+": "+str(attribData[1]))
			if(bodypart.getFluidProduction() != null):
				for attribData in bodypart.getFluidProduction().getAttributesText():
					sayn(attribData[0]+": "+str(attribData[1]))
			if(bodypart.getSensitiveZone() != null):
				for infoLine in bodypart.getSensitiveZone().getMeInfo():
					sayn(infoLine)
		
		sayn("")
		
		sayn("[b]Характеристики:[/b]")
		for statID in Stat.getAll():
			var howmuch = GM.pc.getStat(statID)
			var howMuchExtra = GM.pc.getBuffsHolder().getExtraStat(statID)
			var howMuchExtraStr = (str(howMuchExtra) if howMuchExtra < 0 else "+"+str(howMuchExtra))
			var statObject:StatBase = GlobalRegistry.getStat(statID)
			sayn(statObject.getVisibleName()+": "+str(howmuch)+(" ("+howMuchExtraStr+")" if howMuchExtra != 0 else ""))
				
		sayn("")
		sayn("[b]Навыки:[/b]")
		var skills = GM.pc.getSkillsHolder().getSkills()
		if(skills.size() == 0):
			sayn("Нет изученных навыков")
		for skillID in skills:
			var skill: SkillBase = skills[skillID]
			sayn(skill.getVisibleName()+": уровень "+str(skill.getLevel()))
		
		sayn("")
		sayn("[b]Репутация:[/b]")
		for line in GM.pc.getReputation().getInfoLines():
			sayn(line)
				
		addButton("Закрыть", "Продолжить путь", "endthescene")
		addButtonUnlessLate("Wait here", "Spend some time idling", "wait")
		if(GM.main.isInDungeon()):
			addDisabledButton("Подрочить", "Здесь слишком темно и мерзко, чтобы мастурбировать. Найди место для отдыха!")
		else:
			addButton("Подрочить", "Сделать это", "domasturbate")
		addButton("Пол", "Выбери свой пол", "pickgender")
		addButton("Местоимения", "Выберите местоимения", "pickpronouns")
		addButton("Встречи", "Информация о ваших прошлых встречах", "encountersMenu")
		addButton("Репутация", "Посмотреть на свою репутацию", "reputationMenu")
		if(!GM.main.isInDungeon()):
			addButton("Найти неприятности", "Попытаться найти встречу", "lookfortrouble")
		if(!getFlag("Game_PickedStartingPerks", false)):
			addButton("Выбирайте перки!", "Выберите стартовые перки. Это можно сделать только один раз", "pickstartingperks")
		#addButton("[debug] Борьба", "Протестировать мини-игру «Борьба»", "teststruggle")
		if(GM.main.RS.special.empty()):
			addDisabledButton("Отношения", "У вас пока нет особых отношений с другими")
		else:
			addButton("Отношения", "Посмотреть на все ваши особые отношения", "specialMenu")
		if(GM.main.isInDungeon()):
			addButton("Задания", "Посмотреть свои задания", "tasks")
		
		
	if(state == "domasturbate"):
		saynn("Вы немного снимаете стресс с помощью мастурбации (временный текст)")
		
		addButton("Продолжить", "Хорошо", "")
		
	if(state == "teststruggle"):
		var game = minigameScene.instance()
		GM.ui.addFullScreenCustomControl("minigame", game)
		game.setDifficulty(4)
		game.connect("minigameCompleted", self, "onMinigameTest")

		addButton("Продолжить", "Хорошо", "")

	if(state == "pickgender"):
		saynn("Выберите пол вашего персонажа. Это повлияет на цвет ваших реплик и на то, как к вам будут относиться окружающие.")
		saynn("Текущий пол: [color="+GM.pc.getChatColor()+"]"+Gender.genderToString(GM.pc.getGender()).capitalize()+"[/color]")

		addButton("Мужской", "Вы — парень", "setgender", [Gender.Male])
		addButton("Женский", "Вы — девушка", "setgender", [Gender.Female])
		addButton("Андрогинный", "Что-то среднее", "setgender", [Gender.Androgynous])
		addButton("Другой", "Что-то иное", "setgender", [Gender.Other])
		addButton("back", "Оставить текущий пол", "")

	if(state == "pickpronouns"):
		saynn("Выберите местоимения вашего персонажа.")
		saynn("Текущие местоимения: "+GM.pc.heShe()+"/"+GM.pc.hisHer()+(" (derived from gender)" if(GM.pc.pronounsGender == null) else ""))

		addButton("Производное от пола", "Автоматически подбирать местоимения в зависимости от пола", "setpronouns", [null])
		addButton("he/his", "Выбрать мужские местоимения", "setpronouns", [Gender.Male])
		addButton("she/her", "Выбрать женские местоимения", "setpronouns", [Gender.Female])
		addButton("they/their", "Выбрать андрогинные или нейтральные местоимения", "setpronouns", [Gender.Androgynous])
		addButton("it/its", "Выбрать нейтральные местоимения", "setpronouns", [Gender.Other])
		addButton("back", "Оставить текущие местоимения", "")
	
	if(state == "wait"):
		saynn("Выберите, сколько вы готовы ждать.")
		
		addButton("5 минут", "Ждать столько", "dowait", [5*60])
		addButton("15 минут", "Ждать столько", "dowait", [15*60])
		addButton("30 минут", "Ждать столько", "dowait", [30*60])
		addButton("1 час", "Ждать столько", "dowait", [1*60*60])
		addButton("2 часа", "Ждать столько", "dowait", [2*60*60])
		addButton("3 часа", "Ждать столько", "dowait", [3*60*60])
		addButton("back", "Не ждите", "")

	if(state == "failedtofindtrouble"):
		saynn("Вы пытаетесь оглядеться в поисках неприятностей, но здесь всё спокойно.")
		
		saynn("Попробуйте другое место.")
		
		addButton("Продолжить", "Ну и ладно", "")
	
	if(state == "reputationMenu"):
		var reputation:Reputation = GM.pc.getReputation()
		
		saynn("Ваша текущая репутация в тюрьме:")
		for repID in GlobalRegistry.getRepStats():
			var repStat:RepStatBase = GlobalRegistry.getRepStat(repID)
			
			var repLevel:int = reputation.getRepLevel(repID)
			var repScore:float = reputation.getRepScore(repID)
			var nextScore:float = repStat.getNeededScoreForLevel(repLevel+1, repLevel)
			var prevScore:float = -repStat.getNeededScoreForLevel(repLevel-1, repLevel)
			
			var normScore:float = (repScore - prevScore) / (nextScore - prevScore)
			
			sayn("[b]"+repStat.getVisibleName()+"[/b]")
			sayn("Ваш текущий уровень: '"+repStat.getTextForLevel(repLevel, reputation)+"' (уровень "+str(repLevel)+"/"+(str(repStat.getMaxLevel()) if repLevel >= 0 else str(repStat.getMinLevel()))+")")
			sayn("Прогресс: [font=res://Fonts/smallconsolefont.tres]"+Util.textProgressBar(normScore, 40)+"[/font]")
			#sayn("ПРЕДЫД = "+str(prevScore)+" СЛЕД = "+str(nextScore))
			var specialReq = repStat.getSpecialRequirementToReachLevel(repLevel+1, reputation)
			if(specialReq != null && repScore>=nextScore):
				sayn("ДЛЯ ПОВЫШЕНИЯ УРОВНЯ НУЖНО: "+str(specialReq[1]))
			
			sayn("Текущие эффекты:")
			var repEffects:Array = repStat.getEffectsInfoForLevel(repLevel, reputation)
			if(repEffects.size() <= 0):
				sayn("- ОТСУТСТВУЮТ")
			else:
				for line in repEffects:
					sayn("- "+line)
			
			var maxLevel:int = repStat.getMaxLevel()
			var minLevel:int = repStat.getMinLevel()
			if(repLevel >= maxLevel):
				sayn("(Вы достигли максимально возможного уровня репутации)")
			if(repLevel <= minLevel):
				sayn("(Вы достигли минимально возможного уровня репутации)")
			sayn("")
		
		addButton("Назад", "Назад в предыдущее меню", "")

func onMinigameTest(_score:MinigameResult):
	Log.print("SCORE: "+str(_score.score))
	Log.print("INSTANT UNLOCK: "+str(_score.instantUnlock))
	Log.print("FAILED HARD: "+str(_score.failedHard))
	GM.main.pickOption("", [])

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "lookfortrouble"):
		if(GM.ES.triggerReact(Trigger.PCLookingForTrouble)):
			endScene()
		else:
			setState("failedtofindtrouble")
		return
	
	if(_action == "encountersMenu"):
		runScene("EncountersMenuScene", [], "encountersMenu")
		return
	
	if(_action == "setgender"):
		GM.pc.setGender(_args[0])
		setState("")
		return
		
	if(_action == "setpronouns"):
		GM.pc.setPronounGender(_args[0])
		setState("")
		return
	if(_action == "tasks"):
		runScene("QuestLogScene")
		setState("")
		return
	
	if(_action == "domasturbate"):
		runScene("MasturbationScene")
		endScene()
		return
		#processTime(5*60)
		#GM.pc.orgasmFrom("pc")
	
	if(_action == "dowait"):
		var newt = _args[0]
		
		GM.main.processTime(newt)
		
		if(GM.ES.triggerReact(Trigger.Waiting, [newt])):
			endScene()
			return
		
		setState("")
		return
	
	if(_action == "pickstartingperks"):
		setFlag("Game_PickedStartingPerks", true)
		runScene("PickStartingPerksScene")
		setState("")
		return
	if(_action == "specialMenu"):
		endScene()
		runScene("SpecialRelationshipsScene")
		return
	
	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "encountersMenu"):
		# If we press the Meet npc button inside the Encounters menu, we also end this scene
		if(_result is Array && _result.size() > 0 && _result[0]):
			endScene()
		
func supportsShowingPawns() -> bool:
	return true
