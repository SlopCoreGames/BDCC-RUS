extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter
var npc2ID = ""
var npc2:DynamicCharacter

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)
	npc2ID = _args[1]["dom"]
	npc2 = GlobalRegistry.getCharacter(npc2ID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID
	if(_charID == "npc2"):
		return npc2ID

func _init():
	sceneID = "ActionSlutFuckByAnotherSlaveScene"

func _run():
	if(state == ""):
		addCharacter(npcID)
		addCharacter(npc2ID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID, pc=npc2ID, bodyState={chains=[["normal", "neck", "scene", "floor"]]}, npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		var npc2Slavery:NpcSlave = npc2.getNpcSlavery()
		
		saynn("Ты приказываешь своей шлюхе по имени {npc.name} подчиниться {npc2.name} и позволить {npc2.him} делать с {npc.his} телом всё, что пожелает {npc.he}, чтобы та стала {npc2.his} игрушкой для снятия стресса.")
		
		saynn("Поскольку все твои рабы сидят на короткой цепи, у твоей шлюхи всё равно особо нет выбора."+(" Ты замечаешь, что твоя шлюшка довольно сильно устала, а значит, {npc.he} точно не получит удовольствия." if npcSlavery.getWorkEfficiency() <= 0.15 else ""))
		
		if(npc2Slavery.isMindBroken()):
			saynn("Твой второй раб слышит твой приказ... и выглядит таким же отрешённым, как и прежде.")
			
			saynn("Похоже, {npc2.he} не сможет этого сделать в {npc2.his} нынешнем состоянии... если только ты не заставишь {npc2.him}.")
			
			addButton("Заставить", "Заставить своего сломленного раба трахнуть твою шлюху", "do_force_sex")
			addButton("Отмена", "Вы передумали", "endthescene")
		elif(npc2Slavery.personalityScore({PersonalityStat.Subby:1.0}) > 0.0):
			saynn("Твой второй раб слышит твой приказ... и опускает взгляд {npc2.his}.")
			
			saynn("[say=npc2]"+RNG.pick([
				"Я не особо склонна доминировать... понимаешь?..",
				"Мне безумно нравится доминировать над другими.",
				"А я сама довольно субмиссивная особа...",
			])+"[/say]")
			
			saynn("Если заставить {npc2.name} сделать это, {npc2.him} на самом деле будет чувствовать ещё больший стресс, чем раньше...")
			
			addButton("Заставить", "Заставить своего покорного раба трахнуть твою шлюху", "do_force_sex")
			addButton("Отмена", "Вы передумали", "endthescene")
		else:
			saynn("Твоя вторая рабыня слышит это... и, похоже, готова к хорошей жаре.")
		
			saynn("[say=npc2]"+RNG.pick([
				"Давай повеселимся.",
				"Шлюшка? Для меня? Ого.",
				"Посмотрим, сколько ты сможешь вытерпеть.",
			])+"[/say]")
			
			addButton("Смотреть", "Посмотри, что твоя рабыня сделает с твоей шлюхой", "do_watch_sex")
	if(state == "after_sex"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID, pc=npc2ID, bodyState={chains=[["normal", "neck", "scene", "floor"]]}, npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
		
		saynn("Когда секс заканчивается, ты приказываешь рабыням встать. Ты убеждаешься, что обе они всё ещё прикованы цепями к полу.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action in ["do_force_sex", "do_watch_sex"]):
		var npc2Slavery:NpcSlave = npc2.getNpcSlavery()
		if(_action == "do_force_sex"):
			npc2Slavery.addDespair(0.05)
		else:
			npc2Slavery.addDespair(-0.1)
		
		runScene("GenericSexScene", [npc2ID, npcID, SexType.DefaultSex, {SexMod.DisableDynamicJoiners: true}], "slavesfuck")
		setState("after_sex")
		return
		
	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "slavesfuck"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.getWorkEfficiency() > 0.15):
			npcSlavery.addExperience(20)
			npcSlavery.addAwareness(0.05)
		else:
			npcSlavery.addDespair(0.05)
		npcSlavery.addTired(1)
		
		var npc2Slavery:NpcSlave = npc2.getNpcSlavery()
		if(npc2Slavery.getWorkEfficiency() > 0.15):
			npc2Slavery.addTrust(0.04)
			npc2Slavery.addExperience(10)
			npc2Slavery.addUnhappiness(-5 * sqrt(npcSlavery.getSlaveSkill(SlaveType.Slut)+1)) # Why would I leave if I get to fuck stuff for free!
		npc2Slavery.addTired(1)
		
		endScene()
		return

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["npc2ID"] = npc2ID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
	npc2ID = SAVE.loadVar(data, "npc2ID", "")
	npc2 = GlobalRegistry.getCharacter(npc2ID)
