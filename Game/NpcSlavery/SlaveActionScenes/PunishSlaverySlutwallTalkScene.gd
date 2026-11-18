extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "PunishSlaverySlutwallTalkScene"

func _run():
	if(state == ""):
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		addCharacter(npcID)
		aimCameraAndSetLocName("fight_slutwall")
		GM.pc.setLocation("fight_slutwall")
		playAnimation(StageScene.SlutwallSex, "idle", {pc=npcID, npc="pc", bodyState={naked=true}})
		
		saynn("{npc.name} застряла в стене для шлюх. Можно подождать, пока кто-нибудь воспользуется {npc.him}, или заняться этим самому.")
		
		if(npcSlave != null):
			if(npcSlave.getWorkEfficiency() <= 0.1):
				saynn("Твоя рабыня очень устала. Если использовать {npc.him} прямо сейчас, {npc.him} впадет в еще большую депрессию.")
				
			if(npcSlave.getDespair() >= 0.8):
				saynn("{npc.He} выглядит очень подавленной, рассудок {npc.his} может пошатнуться в любой момент.")
			elif(npcSlave.getDespair() >= 0.5):
				if(npcSlave.getBrokenSpirit() >= 0.9):
					saynn("{npc.He} выглядит подавленной. Но {npc.he} совсем не сопротивляется — похоже, дух {npc.his} уже окончательно сломлен!")
				elif(npcSlave.getBrokenSpirit() > 0.5):
					saynn("{npc.He} выглядит подавленной. Но {npc.he} почти не сопротивляется, что говорит о надломленном духе {npc.his}.")
				else:
					saynn("{npc.He} выглядит подавленной. Но {npc.he} время от времени пытается вырваться, так что дух {npc.his} явно еще держится.")
			else:
				if(npcSlave.getBrokenSpirit() >= 0.9):
					saynn("{npc.He} совсем не сопротивляется, дух {npc.his} наверняка уже сломлен!")
				elif(npcSlave.getBrokenSpirit() > 0.5):
					saynn("{npc.He} почти не сопротивляется, это признак того, что дух {npc.his} ломается.")
			
		if(npc.hasEffect(StatusEffect.HasTallyMarks)):
			var tallyMarks = npc.getEffect(StatusEffect.HasTallyMarks)
			var tallyAmount = tallyMarks.totalAmount
			
			if(tallyAmount > 0):
				saynn("На теле {npc.His} есть "+str(tallyAmount)+" tallymark"+("s" if tallyAmount != 1 else "")+" штук, а это значит, что {npc.he} использовали так грубо столько раз.")
		
		addButton("Смотреть", "Посмотреть, что другие делают с твоей рабыней", "do_watch")
		addButtonWithChecks("Использовать", "Трахнуть свою рабыню самому", "do_use", [], [ButtonChecks.CanStartSex])
		
		addButton("Освободить рабыню", "Хватит колодок", "do_free_slave")
		addButton("Уйти", "Пора идти", "endthescene")

	if(state == "do_free_slave"):
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		
		saynn("Хватит с этих стен, освобождай {npc.name} и тащи {npc.him} обратно в камеру.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "do_free_slave"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery == null):
			return
		npcSlavery.stopActivity()
	
	if(_action == "do_watch"):
		processTime(60*RNG.randi_range(10, 30))
		var characterPool = RNG.pick([CharacterPool.Guards, CharacterPool.Inmates])
		var generator = null
		if(characterPool == CharacterPool.Guards):
			generator = GuardGenerator.new()
		else:
			generator = InmateGenerator.new()
		
		var idToUse = NpcFinder.grabNpcIDFromPoolOrGenerate(characterPool, [], generator, {})
		if(idToUse == null):
			return
		getCharacter(idToUse).prepareForSexAsDom()
		npc.lustStateFullyUndress()
		runScene("GenericSexScene", [idToUse, npcID, SexType.SlutwallSex, {SexMod.DisableDynamicJoiners:true}], "watchsex")
		return
		
	if(_action == "do_use"):
		npc.lustStateFullyUndress()
		runScene("GenericSexScene", ["pc", npcID, SexType.SlutwallSex, {SexMod.DisableDynamicJoiners:true}], "usesex")
		return
		
	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag in ["usesex", "watchsex"]):
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		if(npcSlave != null):
			npcSlave.addTired(1)
			if(npcSlave.getTiredEffect() >= 0.9):
				npcSlave.addDespair(0.06)
			else:
				npcSlave.addDespair(0.01)
				npcSlave.addBrokenSpirit(0.05 * npcSlave.getWorkEfficiency())
		
		setState("")

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
