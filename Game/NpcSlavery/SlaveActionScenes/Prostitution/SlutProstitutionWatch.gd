extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter
var npc2ID = ""
var npc2:DynamicCharacter
var slutIsDom = false

var intimidateReason = ""
var instantConflict = false

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)
	if(_args.size() > 1):
		instantConflict = _args[1]

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID
	if(_charID == "npc2"):
		return npc2ID

func _reactInit():
	if(RNG.chance(50)):
		npc2ID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Guards, [], GuardGenerator.new(), {})
	else:
		npc2ID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [], InmateGenerator.new(), {})
	if(npc2ID == null || npc2ID == ""):
		addMessage("Не удалось найти хорошего клиента :(")
		endScene()
		return
	npc2 = getCharacter(npc2ID)
	
	var npcSlave:NpcSlave = npc.getNpcSlavery()
	
	var subStat = npcSlave.personalityScore({PersonalityStat.Subby:1.0})
	var subbyness = RNG.randf_range(-1.0, 1.0) + subStat
	slutIsDom = (subbyness < 0.0)
	
	if(instantConflict):
		setState(RNG.pick(["skipped_client_rude", "skipped_client_rob"]))
		addCharacter(npcID)
		addCharacter(npc2ID)

func _init():
	sceneID = "SlutProstitutionWatch"

func _run():
	if(state == ""):
		addCharacter(npcID)
		addCharacter(npc2ID)
		playAnimation(StageScene.Duo, "stand", {pc=npcID, npc=npc2ID})
		
		#var npcSlave:NpcSlave = npc.getNpcSlavery()
		#var prostitution = npcSlave.getActivity()
		
		saynn("Вы замечаете, как ваша шлюшка {npc.name} предлагает {npc.himself} кому-то.")
		
		if(slutIsDom):
			saynn("Похоже, предложение твоей шлюхи включает в себя {npc.him} взятие инициативы на себя.")
		else:
			saynn("Похоже, предложение твоей шлюхи включает в себя {npc.him} роль принимающей стороны.")
		
		saynn("Хочешь на них посмотреть?")
		
		addButton("Смотреть", "Посмотри, как они трахаются", "do_watch")
		addButton("Уйти", "Ты бы предпочел этого не делать", "rude_check")
	
	if(state == "after_sex"):
		playAnimation(StageScene.Duo, "stand", {pc=npcID, npc=npc2ID})
		
		saynn("Твою шлюху расплачивают после секса, и она начинает искать нового клиента.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

	if(state == "skipped_client_rude"):
		playAnimation(StageScene.Duo, "hurt", {pc=npcID, npcAction="shove", npc=npc2ID})
		
		if(instantConflict):
			saynn("Ты куда-то направлялась... но тут замечаешь, что у одной из твоих шлюх, {npc.name}, и {npc.his} клиента разгорелся нешуточный словесный конфликт.")
		else:
			saynn("Ты уже собирался куда-то пойти... но тут замечаешь, что клиент ведет себя невероятно грубо с твоей шлюхой.")

		saynn("{npc.name} пытается уйти.. но клиент превращается в настоящего мудака и начинает толкать {npc.him}.")
		
		addButton("Защитить", "Ты не позволишь этому случиться", "do_intimidate", ["rude"])
		addButton("Уйти", "Да пофиг, твоя шлюшка сама справится", "do_walkaway", ["rude"])
		
	if(state == "skipped_client_rob"):
		playAnimation(StageScene.Duo, "hurt", {pc=npcID, npcAction="shove", npc=npc2ID})

		if(instantConflict):
			saynn("Ты уже собирался куда-то идти... но вдруг замечаешь, что одна из твоих шлюх, {npc.name}, и {npc.his} клиент устроили потасовку.")
		else:
			saynn("Ты уже собирался куда-то идти... но вдруг замечаешь, что клиент что-то вытворяет с твоей шлюхой.")

		saynn("Да клиент вовсе не секса ищет, {npc2.he} {npc2.isAre} на самом деле пытается ограбить {npc.name}!")
		
		addButton("Защитить", "Ты не позволишь этому случиться", "do_intimidate", ["rob"])
		addButton("Уйти", "Да пофиг, твоя шлюха сама справится", "do_walkaway", ["rob"])
		
	if(state == "aftersex_rob"):
		playAnimation(StageScene.Duo, "hurt", {pc=npcID, npcAction="shove", npc=npc2ID})

		saynn("Секс закончился... но клиент, кажется, остался не удовлетворен.")

		saynn("{npc2.He} {npc2.isAre} пытается ограбить твою шлюху!")
		
		addButton("Защитить", "Ты не позволишь этому случиться", "do_intimidate", ["rob"])
		addButton("Уйти", "Да пофиг, твоя шлюха сама справится", "do_walkaway", ["rob"])
		
	if(state == "aftersex_notsatisfied"):
		playAnimation(StageScene.Duo, "hurt", {pc=npcID, npcAction="shove", npc=npc2ID})

		saynn("Секс закончился... но клиент, кажется, остался не удовлетворен.")

		saynn("{npc2.He} {npc2.isAre} ведет себя невероятно грубо с твоей шлюхой!")
		
		addButton("Защитить", "Ты не позволишь этому случиться", "do_intimidate", ["rude"])
		addButton("Уйти", "Да пофиг, твоя шлюха сама справится", "do_walkaway", ["rude"])
		
	if(state == "do_intimidate"):
		playAnimation(StageScene.Duo, "stand", {pc="pc", npc=npc2ID})
		
		saynn("Ты не можешь этого допустить, поэтому вмешиваешься и оттаскиваешь этого мудака от своей бляди.")
		
		saynn("[say=npc2]"+RNG.pick([
			"О, ты что, типа сутенер? Ну, я тебя сейчас отъебу.",
			"Ого, какой смелый. Ты что, влюбился в эту шлюху?",
			"Какой храбрый. Это твоя сучка, да? Будет жаль, если с ней что-нибудь случится.",
			"Ублюдок, я еще не закончил с этой шлюхой.",
		])+"[/say]")
		
		saynn("Похоже, назревает драка...")
		addButton("Драться", "Начать бой", "do_fight")
		
	if(state == "do_walkaway"):
		playAnimation(StageScene.Solo, "stand")
		
		saynn("У тебя нет на это времени, поэтому ты просто уходишь.")
		
		if(intimidateReason == "rude"):
			saynn("Твоя шлюха, {npc.name}, впала в еще большую депрессию после того, как {npc.he} подверглась словесному и физическому насилию.")
		
		if(intimidateReason == "rob"):
			saynn("Твою шлюху, {npc.name}, ограбили, а значит, {npc.he} лишилась всех кредитов, которые {npc.he} заработала сегодня.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "lost_fight"):
		playAnimation(StageScene.Solo, "defeat")
		
		saynn("Ты проиграл драку. Твоя шлюха видела, что ты проигрываешь, и ей удалось вовремя сбежать... Но {npc.he} теперь точно будет доверять тебе меньше.")

		addButton("Продолжить", "Ну и ладно", "endthescene")

	if(state == "won_fight"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ты выиграл драку. Побежденный мудак уползает прочь, нет смысла истязать {npc2.him} дальше.")
		
		saynn("Похоже, твоя шлюха теперь доверяет тебе больше.")

		addButton("Продолжить", "Отличная работа", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "do_intimidate"):
		intimidateReason = _args[0]
		
	if(_action == "do_walkaway"):
		intimidateReason = _args[0]
		
		if(intimidateReason == "rude"):
			var npcSlave:NpcSlave = npc.getNpcSlavery()
			npcSlave.addDespair(0.1)
		if(intimidateReason == "rob"):
			var npcSlave:NpcSlave = npc.getNpcSlavery()
			var prostitution = npcSlave.getActivity()
			prostitution.earnedCreds = 0
		
	if(_action == "rude_check"):
		if(RNG.chance(70)):
			endScene()
			return
		else:
			setState(RNG.pick(["skipped_client_rude", "skipped_client_rob"]))
			return
	
	if(_action == "do_watch"):
		if(slutIsDom):
			runScene("GenericSexScene", [npcID, npc2ID, SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}], "prostitutionsex")
		else:
			runScene("GenericSexScene", [npc2ID, npcID, SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true}], "prostitutionsex")
		
		setState("after_sex")
		return

	if(_action == "do_fight"):
		runScene("FightScene", [npc2ID], "fight_rude_client")
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "prostitutionsex"):
		if(RNG.chance(70)):
			npc.getNpcSlavery().addExperience(10)
			setState("after_sex")
			return
		else:
			setState(RNG.pick(["aftersex_rob", "aftersex_notsatisfied"]))
			return
	
	if(_tag == "fight_rude_client"):
		processTime(10 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("won_fight")
			addExperienceToPlayer(10)
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			npcSlavery.addTrust(0.1)
			#npcSlavery.afterBeatenUp()
			#npcSlavery.handlePunishment(2)
		else:
			setState("lost_fight")
			var npcSlavery:NpcSlave = npc.getNpcSlavery()
			npcSlavery.addTrust(-0.2)

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["npc2ID"] = npc2ID
	data["slutIsDom"] = slutIsDom
	data["intimidateReason"] = intimidateReason
	data["instantConflict"] = instantConflict

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
	npc2ID = SAVE.loadVar(data, "npc2ID", "")
	npc2 = GlobalRegistry.getCharacter(npc2ID)
	slutIsDom = SAVE.loadVar(data, "slutIsDom", false)
	intimidateReason = SAVE.loadVar(data, "intimidateReason", "")
	instantConflict = SAVE.loadVar(data, "instantConflict", false)
	
