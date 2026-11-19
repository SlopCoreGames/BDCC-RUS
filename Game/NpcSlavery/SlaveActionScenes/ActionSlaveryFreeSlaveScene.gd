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
	sceneID = "ActionSlaveryFreeSlaveScene"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		saynn("Вы уверены, что хотите освободить {npc.name}?")
		
		saynn("Пока {npc.he} {npc.isAre} достаточно в здравом уме, {npc.he} просто вернется к тому, чем {npc.he} занималась до того, как вы превратили её в рабыню. Но {npc.he} забудет всё, чему вы {npc.him} научили.")
		
		if(npcSlavery.isMindBroken()):
			saynn("Так как {npc.name} сломлена ментально, {npc.he} поместят в психиатрическое отделение на неопределенный срок, а это значит, что {npc.he} навсегда останется лишь воспоминанием для вас.")
		
		addButton("Освободить", "Отпустить рабыню", "release_slave")
		addButton("Отмена", "Вы передумали", "endthescene")

	if(state == "release_slave"):
		aimCameraAndSetLocName("hall_mainentrance")
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Вы хватаете {npc.name} за поводок и выводите {npc.him} в главный зал. После этого вы просто расстегиваете карабин.")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		
		if(npcSlavery.isActivelyResisting()):
			saynn("[say=pc]"+RNG.pick([
				"Ты свободна. Проваливай.",
				"Ты мне осточертела. Можешь идти.",
				"Ты свободна. Иди. Пока я не передумал.",
				"Уходи. Ты больше не рабыня.",
			])+"[/say]")
		else:
			saynn("[say=pc]"+RNG.pick([
				"Можешь идти. Теперь ты свободна.",
				"Я решил тебя отпустить. Свободна.",
			])+"[/say]")
		
		if(npcSlavery.isMindBroken()):
			saynn("{npc.He} ничего не говорит, просто стоит неподвижно. Взгляд {npc.His} расфокусирован.")
			
			saynn("Вы щелкаете пальцами перед лицом {npc.his}... никакой реакции. Ну и ладно.")
			
			saynn("После того как вы отходите от {npc.him}, к {npc.him} подходит один из сотрудников и о чем-то спрашивает.")
			
			saynn("Вскоре приходят несколько медсестер и уводят {npc.name} куда-то прочь...")
		elif(npcSlavery.isResistingSuperActively()):
			saynn("[say=npc]"+RNG.pick([
				"Серьезно? Не жди благодарности. Вообще-то, знаешь что? Пошел ты нахуй.",
				"Тебе вообще не стоило со мной связываться."
			])+"[/say]")
		
			saynn("{npc.name} показывает тебе средний палец.. и быстро уходит.")
		elif(npcSlavery.hasSubmittedToPC()):
			saynn("[say=npc]"+RNG.pick([
				"Эм... Но ведь я принадлежу тебе. Ты серьезно? Я даже не знаю, что теперь делать...",
				"Ты серьезно? Но... я ведь только начала привыкать... быть твоей...",
				"Ох... Но я... Что же мне делать, когда поводок, ведущий меня, исчезнет?",
				"Но... что, если мне, в каком-то смысле, даже нравилось быть на поводке?",
				"Я... я даже не знаю, что сказать. Спасибо? Но почему именно сейчас? Я ведь уже привыкла служить тебе. Мне понадобится время, чтобы снова научиться жить самостоятельно...",
				"Я... не думаю, что готова к этому. Жизнь с тобой стала для меня целым миром. И что мне теперь делать? Я буду скучать по тебе... Сильнее, чем ты можешь себе представить.",
			])+"[/say]")
			
			saynn("Твоя рабыня.. бывшая рабыня.. опускает {npc.his} голову.. когда ты отходишь.")
		elif(npcSlavery.getLove() > 0.95):
			saynn("[say=npc]"+RNG.pick([
				"Но... я ведь люблю тебя... Ты ведь не шутишь?..",
				"Серьезно?.. А ведь я чувствовала к тебе нечто особенное... И теперь ты вот так меня предаешь?",
				"Серьезно? Ты просто вот так меня отпускаешь? После всего, через что мы прошли? Даже не знаю, что чувствовать — облегчение или боль. Но, наверное, сейчас это уже не важно. Прощай.",
				"Ты даруешь мне свободу? Но как же наша связь? Наша близость? Я думала, между нами есть что-то особенное. Видимо, я ошибалась. Прощай.",
				"Ты и правда меня отпускаешь? Ну, не жди, что я буду тебе благодарна. С тебя хватит.",
			])+"[/say]")
			
			saynn("Твоя бывшая рабыня дрыгает задом и уходит прочь.")
		elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit()):
			saynn("[say=npc]"+RNG.pick([
				"Так вот и всё? Ты просто меня отпускаешь? После всего времени, что мы провели вместе? Не знаю, радоваться мне или сердце разрывается. Но, полагаю, теперь это уже не имеет значения. Прощай.",
				"Эм... Но ведь я принадлежу тебе. Ты серьезно? Даже не знаю, что теперь делать... Странно думать о жизни без тебя, но в глубине души я чувствую облегчение. Буду скучать, но также буду рада наконец-то снова стать самой собой.",
			])+"[/say]")
			
			saynn("Твоя бывшая рабыня оглядывается.. а затем уходит куда-то в сторону.")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Ого. Никогда не думала, что доживу до дня, когда ты меня отпустишь. Надеюсь, ты не врешь.",
				"Серьезно? Ты наконец-то меня освобождаешь? Давно пора. Но не жди, что я буду тебя благодарить. Я буду рада избавиться от твоего контроля, но даже не думай, что я забуду всё, что ты со мной сделал.",
				"Вау, спасибо, что наконец-то дал мне свободу. Но не надейся, что я останусь здесь и буду выслушивать твои оправдания.",
				"Ты меня отпускаешь? Только не делай вид, будто делаешь мне одолжение. Без роли твоей рабыни мне будет только лучше.",
			])+"[/say]")
			
			saynn("Твоя бывшая рабыня оглядывается.. а затем стремительно уходит куда-то в сторону.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "slave_released")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "slave_released"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		playAnimation(StageScene.Solo, "stand")
		
		if(npcSlavery.isMindBroken()):
			addMessage(npc.getName()+" была помещена в психиатрическую больницу... на неопределенный срок.")
			#GM.main.removeDynamicCharacter(npcID)
			getModule("NpcSlaveryModule").doFreeEnslavedCharacter(npcID)
			if(npc.isDynamicCharacter()):
				GM.main.removeDynamicCharacterFromAllPools(npcID)
				GM.main.addDynamicCharacterToPool(npcID, CharacterPool.MentalWard)
		else:
			addMessage(npc.getName()+" была освобождена и больше не является твоей рабыней.")
			getModule("NpcSlaveryModule").doFreeEnslavedCharacter(npcID)
		endScene()
		return
		
	if(_action == "release_slave"):
		#var npcSlavery:NpcSlave = npc.getNpcSlavery()
		#npcSlavery.setMainSkill(_args[0])
		#setState("")
		#addMessage("Main skill changed!")
		#return
		var returnedItems = npc.getInventory().getEquippedItemsWithTag(ItemTag.ReturnsToPCIfSlaveReleased)
		for theItem in returnedItems:
			npc.getInventory().removeEquippedItem(theItem)
			GM.pc.getInventory().addItem(theItem)
			addMessage("Вы восстановились "+theItem.getAStackName())
		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
