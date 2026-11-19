extends "res://Scenes/SceneBase.gd"

var savedFighterID = ""

func _init():
	sceneID = "AvyTalkScene"

func _reactInit():
	if(GM.ES.triggerReact(Trigger.TalkingToNPC, ["avy"])):
		endScene()
		return

func _run():
	if(state == ""):
		addCharacter("avy")
		playAnimation(StageScene.Duo, "stand", {npc="avy"})

	if(state == ""):
		var pcRank = FightClubModule.getPCRank()
		
		var theUniqieLine:String = getFlag("KaitModule.avyApproach", "")
		if (!theUniqieLine.empty()):
			saynn("[say=avy]"+str(theUniqieLine)+"[/say]")

			setFlag("KaitModule.avyApproach", "")
		# (if fuck meat rank)
		elif(pcRank == FightClubRank.FuckMeat):
			saynn("[say=avy]Ну что, готов доказать, на что способен, кусок мяса?[/say]")

		# (if failed hero rank)
		elif(pcRank == FightClubRank.FailedHero):
			saynn("[say=avy]А ты шуму наделал, неудачливый герой. Думаешь, вывезешь жару?[/say]")

		# (if play toy rank)
		elif(pcRank == FightClubRank.PlayToy):
			saynn("[say=avy]Людям нравится, как ты дерешься. Но не обольщайся, ты всё еще просто игрушка.[/say]")

		# (if attention whore)
		elif(pcRank == FightClubRank.AttentionWhore):
			saynn("[say=avy]Думаешь, почти добрался до вершины? Подумай дважды, сучка жадная до внимания.[/say]")

		# (if grand champion)
		elif(pcRank == FightClubRank.GrandChampion):
			saynn("[say=avy]Никто не задерживался на вершине надолго, кроме меня. Наслаждайся, пока можешь.[/say]")

		if (getModule("KaitModule").hasHideoutAccess()):
			var theLove:int = GM.main.MS.getAvyLove()
			var theObedience:int = GM.main.MS.getAvyObedience()
			saynn("Любовь Эви: "+str(theLove)+"\nПослушание Эви: "+str(theObedience))
			addButton("Поговорить", "Поболтать с ней", "do_talk")

		saynn("Она показывает тебе свои записи:")

		var showedPC = false
		var i = 1
		var avyRekt = getFlag("FightClubModule.AvyGotRekt", false)
		
		for rankID in FightClubRank.getAll():
			var rankName = FightClubRank.getVisibleName(rankID)
			
			sayn(rankName+":")
			
			for fighterID in GlobalRegistry.getFightClubFightersIDsByRank(rankID):
				if(!showedPC && pcRank == rankID && FightClubModule.isFighterDefeated(fighterID)):
					showedPC = true
					sayn(str(i)+" - {pc.name}")
					i+=1
				
				if(fighterID == "avy" && avyRekt):
					continue
				var fighter:FightClubFighter = GlobalRegistry.getFightClubFighter(fighterID)
				
				if(FightClubModule.isFighterDefeated(fighterID)):
					sayn(str(i)+" - "+fighter.getNameAndNickname()+" (побежден)")
				else:
					sayn(str(i)+" - "+fighter.getNameAndNickname())
				i+=1
			
			if(rankID == FightClubRank.FuckMeat && !showedPC):
				sayn(str(i)+" - {pc.name}")
				i+=1
			if(rankID == FightClubRank.FuckMeat && avyRekt):
				sayn(str(i)+" - Эви, Падший Герой (побеждена)")
			
			sayn("")
		
		var nextFighter = FightClubModule.getNextFighter()
		if(nextFighter != null):
			addButton("Арена", "Скажи ей, что готов сразиться со следующим противником", "fightnext")
		else:
			addDisabledButton("Арена", "Больше сражаться не с кем :(")
			
		if(!getFlag("FightClubModule.GotTaskToStealPlant")):
			if(getModule("FightClubModule").isReadyToFightAvy()):
				addButton("Сразиться с Эви", "Пора за дело", "do_fight_avy")
			else:
				addDisabledButton("Сразиться с Эви", "Ты должен победить всех остальных противников, прежде чем бросить вызов Эви")
		else:
			if(getFlag("FightClubModule.AvyGotRekt")):
				addButton("Реванш с Эви", "Переиграть финальный бой", "do_fight_avy_second_time") # Maybe a choice between two fights
			else:
				if(getFlag("FightClubModule.ReturnedPlantToEliza")):
					addButton("Сразиться с Эви", "Пора повторить это снова", "do_fight_avy_second_time")
				else:
					addDisabledButton("Сразиться с Эви", "Ты ещё не готов! Ты же знаешь, что опять проиграешь.")
			
		addButton("Реванш", "Снова сразиться с одним из тех, кого ты уже победил", "rematchmenu")
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["avy"])
		addButton("Уйти", "Пора идти", "endthescene")

	if(state == "rematchmenu"):
		saynn("С кем хочешь устроить реванш?")
		
		for rankID in FightClubRank.getAll():
			for fighterID in GlobalRegistry.getFightClubFightersIDsByRank(rankID):
				if(fighterID == "avy"):
					continue
				if(!FightClubModule.isFighterDefeated(fighterID)):
					continue
				var fighter: FightClubFighter = GlobalRegistry.getFightClubFighter(fighterID)
				
				addButton(fighter.getVisibleName(), fighter.getNameAndNickname(), "rematch", [fighterID])
		
		addButton("Назад", "Ты не хочешь ни с кем драться", "")

	if(state == "fight"):
		var arenaFighter:FightClubFighter = GlobalRegistry.getFightClubFighter(savedFighterID)
		# (if first time)
		if(!getFlag("FightClubModule.FightClubFirstArenaIntroduction")):
			saynn("[say=pc]Я готов.[/say]")

			saynn("[say=avy]Первый раз — это всегда особенное чувство, правда, сладкий?[/say]")

			saynn("Эви опирается на забор и быстро пробегает глазами по своим записям.")

			saynn("[say=avy]"+arenaFighter.getAvyIntroduction()+"[/say]")

		# (if not first time)
		else:
			saynn("[say=pc]Кто следующий?[/say]")

			saynn("Эви опирается на забор и быстро пробегает глазами по своим записям.")

			saynn("[say=avy]"+arenaFighter.getAvyIntroduction()+"[/say]")

		# (can start fight or leave)

		addButton("Погнали", "Перелезть через забор и начать бой", "fight1")
		addButton("Отмена", "Тебе нужно время, чтобы подумать", "endthescene")

	if(state == "fight1"):
		aimCameraAndSetLocName("fight_arena")
		removeCharacter("avy")
		
		var arenaFighter:FightClubFighter = GlobalRegistry.getFightClubFighter(savedFighterID)
		
		playAnimation(StageScene.Duo, "stand", {npc=arenaFighter.getFightCharacter()})
		addCharacter(arenaFighter.getFightCharacter())
		addCharacter("announcer")
		
		saynn("Ты киваешь и, перелезши через забор, входишь на арену. Сама арена представляет собой огромное пустое квадратное пространство, отделенное от толпы высоким сетчатым забором. С одной из сторон есть балкон, где стоит комментатор.")

		saynn("[say=announcer]Добро пожаловать, дамы и господа! Готовы к зрелищу?[/say]")

		saynn("Толпа сходит с ума, ты слышишь крики восторга и то, как люди бьются о забор.")

		# (if player first time)
		if(!getFlag("FightClubModule.FightClubFirstArenaIntroduction")):
			setFlag("FightClubModule.FightClubFirstArenaIntroduction", true)
			saynn("[say=announcer]Тогда приступим! В наших рядах пополнение! В левом углу у нас {pc.name}! Давайте шумом поприветствуем свежее мясо![/say]")

			saynn("Ликование становится только громче. Хотя некоторые заключенные выкрикивают всякую дичь вроде: «Мясо, вперед!», «Лошадка для разводки!», «Шлюха!».")

		# (if fuck meat rank)
		else:
			saynn("[say=announcer]Тогда приступим! В левом углу у нас {pc.name}, гордый воин с " +FightClubRank.getVisibleName(FightClubModule.getPCRank())+ " рангом! Пошумите![/say]")

			saynn("Ликование толпы становится только громче.")

		saynn("[say=announcer]"+arenaFighter.getAnnouncerIntroduction()+"[/say]")

		saynn("[say=announcer]И помните: победитель волен делать с проигравшим всё, что пожелает. Пусть начнется бой![/say]")

		addButton("Драться", "Пора драться", "startfight")



func _react(_action: String, _args):
	if(_action in ["fight1", "startfight"]):
		processTime(RNG.randi_range(5, 10) * 60)
	
	if(_action == "startfight"):
		var arenaFighter:FightClubFighter = GlobalRegistry.getFightClubFighter(savedFighterID)
		
		runScene("FightScene", [arenaFighter.getFightCharacter(), "arenafight"], "arenafight")
	
	if(_action == "fightnext"):
		savedFighterID = FightClubModule.getNextFighter()
		setState("fight")
		return
		
	if(_action == "rematch"):
		savedFighterID = _args[0]
		setState("fight")
		return
		
	if(_action == "do_fight_avy"):
		runScene("AvyFirstArenaBattleScene")
		endScene()
		return
		
	if(_action == "do_fight_avy_second_time"):
		runScene("AvyFinalArenaBattleScene")
		endScene()
		return
		
	if(_action == "do_talk"):
		runScene("AvyDomRouteChatScene")
		return
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)


func saveData():
	var data = .saveData()
	
	data["savedFighterID"] = savedFighterID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	savedFighterID = SAVE.loadVar(data, "savedFighterID", "")

func _react_scene_end(_tag, _result):
	if(_tag == "arenafight"):
		processTime(RNG.randi_range(30, 60) * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		var arenaFighter:FightClubFighter = GlobalRegistry.getFightClubFighter(savedFighterID)
		
		if(battlestate == "win"):
			#setState("if_won")
			
			# first time
			if(!FightClubModule.isFighterDefeated(savedFighterID)):
				addExperienceToPlayer(arenaFighter.getWinExperience())
				var addCredits = arenaFighter.getWinCredits()
				GM.pc.addCredits(addCredits)
				addMessage("You received "+str(addCredits)+" "+Util.multipleOrSingularEnding(addCredits, "credit"))
			else:
				addExperienceToPlayer(arenaFighter.getRepeatWinExperience())
				var addCredits = arenaFighter.getRepeatWinCredits()
				GM.pc.addCredits(addCredits)
				addMessage("You received "+str(addCredits)+" "+Util.multipleOrSingularEnding(addCredits, "credit")+" for a rematch")
				
			FightClubModule.markFighterAsDefeated(savedFighterID)
			FightClubModule.raisePCRankTo(arenaFighter.getRank())
			
			var winScene = arenaFighter.getWinScene()
			if(winScene != null):
				playAnimation(StageScene.Duo, "stand", {npc=arenaFighter.getFightCharacter(), npcAction="kneel"})
				runScene(winScene)
			endScene()
		else:
			#setState("if_lost")
			var lostScene = arenaFighter.getLoseScene()
			if(lostScene != null):
				playAnimation(StageScene.Duo, "kneel", {npc=arenaFighter.getFightCharacter()})
				runScene(lostScene)
			
			endScene()

func getDebugActions():
	return [
		{
			"id": "instantWin",
			"name": "Win all fights",
			"args": [
			],
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "instantWin"):
		getModule("FightClubModule").forceWinEveryoneExpectAvy()

func getDevCommentary():
	return "Avy.. Avy, Avy, Avy.. Is that even a good name for her? x3\n\nAvy is.. a bitch. Like Risha x3. But Avy is sliiiiightly more complex than that. Avy is the only shemale static character currently ^^. Is she suffering from that somehow? Nah, this is the future where everyone just accepted -all- the genders, utopia if you will x3. And if you don't like your gender/private bits then there are ways to change that. If you look at real life, I think that's where it's all heading. At some point everyone will just.. stop giving a fuck about what's between your legs or how you identify as. Personality > Body. Hopefully ^^. People are still allowed to have preferences obviously, straight/gay/bi/pan is an entirely different thing..\n\nWhy did I write that.. Right, Avy is a dickgirl x3. Why is she a dickgirl? Because its more fun to have someone with a dick at the top of the chain. They think they will always be at the top and dick others ^^.\n\nRisha is mean because she is horny. Avy is.. more of a bully I guess? She wants power over you. What would she do with that power? She doesn't know. But she needs to see -everyone- be her sub"

func hasDevCommentary():
	return true
