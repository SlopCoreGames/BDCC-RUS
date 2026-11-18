extends SceneBase

var npcID:String = ""
var wonState:String = ""
var expWin:int = 50

func _init():
	sceneID = "DrugDenEncounterTemplateScene"

func generateJunkieNPCID(_isBoss:bool = false) -> String:
	var theGenerator := DrugDenJunkieGenerator.new()
	var theChar:BaseCharacter = theGenerator.generate({
		NpcGen.Temporary: true,
		NpcGen.IsBoss: _isBoss,
	})
	var theID:String = theChar.id
	
	return theID

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func startFightWithNPC(theBattleName:String = "DrugDenEncounter"):
	runScene("FightScene", [npcID, theBattleName], "encounterFight")

func _react_scene_end(_tag, _result):
	if(_tag == "encounterFight"):
		processTime(10 * 60)
		var battlestate = _result[0]
		
		if(GM.main.DrugDenRun != null):
			GM.main.DrugDenRun.markEncounterAsCompleted(GM.pc.getLocation())
		
		if(battlestate == "win"):
			#setState("won_encounter")
			if(wonState == ""):
				playAnimation(StageScene.Solo, "stand")
				endScene()
			else:
				setState(wonState)
			addExperienceToPlayer(expWin)
			
			if(GM.main.DrugDenRun.shouldShowLevelUpScreen()):
				runScene("DungeonLevelUpScene")
		else:
			setState("lost_encounter")

	if(_tag == "defeated_sex"):
		var sexResult:SexEngineResult = _result[0]
		var gotUncon:bool = sexResult.isSubUnconscious("pc")
		
		if(gotUncon):
			setState("encounter_fully_rekt")
		else:
			setState("encounter_survived_sex")
		return

func encounter_run():
	if(state == "lost_encounter"):
		playAnimation(StageScene.Duo, "defeat", {npc=npcID})
		
		saynn("Ты проиграл! Похоже, торчу очень хочется тебя оттрахать.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "start_defeated_sex")
	
	if(state == "encounter_survived_sex"):
		removeCharacter(npcID)
		saynn("Тебе удалось выдержать этот натиск! Пора валить!")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "encounter_fully_rekt"):
		removeCharacter(npcID)
		playAnimation(StageScene.Sleeping, "sleep")
		
		saynn("Тебя вырубили наглухо...")
		
		saynn("Перед глазами лишь кромешная тьма...")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "encounter_endrun")
	
	if(state == "encounter_medical"):
		clearCharacter()
		playAnimation(StageScene.Sleeping, "sleep")
		addCharacter("eliza")
		aimCameraAndSetLocName("medical_hospitalwards")
	
		saynn("[say=eliza]Просыпайся, соня![/say]")
		
		saynn("Ты открываешь глаза... и понимаешь, что находишься где-то в медблоке.")
		
		saynn("[say=eliza]Наноботы сработали на ура! Пока ты дрых, я подлатала твои раны. И вот тебе маффин, ты же голодный как волк![/say]")
	
		saynn("Она протягивает тебе маффин. Ты съедаешь его мгновенно. На вкус это лучшее, что ты когда-либо пробовал в своей жизни.")
	
		saynn("[say=pc]Спасибо..[/say]")
		
		saynn("Она указывает на ящик тумбочки рядом с твоей больничной койкой.")
		
		saynn("[say=eliza]Все твои вещи там.[/say]")
		
		saynn("Вы встаете, хватаете свои вещи и готовитесь следовать за Элизой.")
		
		addButton("Следовать", "Посмотреть, куда она вас приведет", "encounter_back_to_lobby")
		
	if(state == "encounter_back_to_lobby"):
		GM.pc.setLocation("med_lobbymain")
		aimCameraAndSetLocName("med_lobbymain")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		
		saynn("Элиза выводит вас в вестибюль.")
		
		saynn("[say=eliza]Береги себя![/say]")
		
		addButton("Продолжить", "Пора идти!", "endthescene")
		addButton("Бежать назад", "Спешно вернуться к скрытому входу в притон", "encounter_endthescene_rushback")
	
func encounter_react(_action: String, _args):
	if(_action == "start_defeated_sex"):
		getCharacter(npcID).prepareForSexAsDom()
		runScene("GenericSexScene", [npcID, "pc", SexType.DefaultSex, {SexMod.SubMustGoUnconscious:true, SexMod.DisableDynamicJoiners:true}], "defeated_sex")
		return true
	if(_action == "encounter_endrun"):
		GM.main.processTime(2*60*60)
		GM.pc.setLocation("medical_hospitalwards")
		GM.main.stopDungeonRun()
		GM.pc.addPain(-GM.pc.getPain())
		GM.pc.addLust(-GM.pc.getLust())
		GM.pc.addStamina(GM.pc.getMaxStamina())
		setState("encounter_medical")
		return true
	if(_action == "encounter_back_to_lobby"):
		setState("encounter_back_to_lobby")
		return true
	if(_action == "encounter_endthescene_rushback"):
		GM.pc.setLocation("yard_deadend2")
		endScene()
		return true
	
	return false

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
