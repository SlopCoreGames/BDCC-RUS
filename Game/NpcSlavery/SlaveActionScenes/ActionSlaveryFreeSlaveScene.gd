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
				"You're free. Go away.",
				"I'm fed up with you. You can leave.",
				"You're free. Go. Before I change my mind.",
				"Go away. You're no longer a slave.",
			])+"[/say]")
		else:
			saynn("[say=pc]"+RNG.pick([
				"You can go. You are now free.",
				"I decided to release you. You can go.",
			])+"[/say]")
		
		if(npcSlavery.isMindBroken()):
			saynn("{npc.He} ничего не говорит, просто стоит неподвижно. Взгляд {npc.His} расфокусирован.")
			
			saynn("Вы щелкаете пальцами перед лицом {npc.his}... никакой реакции. Ну и ладно.")
			
			saynn("После того как вы отходите от {npc.him}, к {npc.him} подходит один из сотрудников и о чем-то спрашивает.")
			
			saynn("Вскоре приходят несколько медсестер и уводят {npc.name} куда-то прочь...")
		elif(npcSlavery.isResistingSuperActively()):
			saynn("[say=npc]"+RNG.pick([
				"Really? I won't thank you. In fact, you know what? Fuck you.",
				"You shouldn't messed with me in the first place."
			])+"[/say]")
		
			saynn("{npc.name} показывает тебе средний палец.. и быстро уходит.")
		elif(npcSlavery.hasSubmittedToPC()):
			saynn("[say=npc]"+RNG.pick([
				"Um. But I belong to you. You're serious? I'm not sure what to do now..",
				"Are you serious? But.. I was just getting used.. to being yours..",
				"Oh. But I.. What am I gonna do when there is no longer a leash to guide me?",
				"But.. what if I kinda liked being on a leash?",
				"I.. I don't know what to say. Thank you? But also, why now? I got kinda used to serving you. It's going to take some time to adjust back to living on my own..",
				"I.. I don't think I'm ready for this. Being with you has become my whole world. What am I supposed to do now? I'll miss you.. More than you'll ever know.",
			])+"[/say]")
			
			saynn("Твоя рабыня.. бывшая рабыня.. опускает {npc.his} голову.. когда ты отходишь.")
		elif(npcSlavery.getLove() > 0.95):
			saynn("[say=npc]"+RNG.pick([
				"But.. I love you.. You can't be serious..",
				"Really?.. I had feeling for you, you know.. And now you betray me like that?",
				"Seriously? You're just letting me go like that? After all we've been through? I don't know whether to feel relieved or hurt. But I guess it doesn't matter now. Goodbye.",
				"You're setting me free? But what about our bond? Our connection? I thought we had something special. I guess I was wrong. Farewell.",
				"You're actually letting me go? Well, don't expect me to be grateful. I'm done with you",
			])+"[/say]")
			
			saynn("Твоя бывшая рабыня дрыгает задом и уходит прочь.")
		elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit()):
			saynn("[say=npc]"+RNG.pick([
				"So this is it, then? You're just letting me go? After all the time we've spent together? I don't know whether to be relieved or heartbroken. But I suppose it doesn't matter now. Farewell",
				"Um. But I belong to you. You're serious? I'm not sure what to do now.. It's strange to think of life without you, but part of me is relieved. I'll miss you, but I'll also be glad to finally be my own person again",
			])+"[/say]")
			
			saynn("Твоя бывшая рабыня оглядывается.. а затем уходит куда-то в сторону.")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Wow. I never thought I'd see the day when you'd release me. I hope you're not lying.",
				"Really? You're finally releasing me? About time. Don't expect me to thank you though. I'll be glad to be free of your control, but don't think for a second that I'll forget what you did to me.",
				"Wow, thanks for finally setting me free. Don't expect me to stick around and listen to your excuses.",
				"You're letting me go? Don't act like you're doing me a favor. I'll be just fine without being your slave.",
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
			addMessage(npc.getName()+" was committed to the mental ward.. indefinitely.")
			#GM.main.removeDynamicCharacter(npcID)
			getModule("NpcSlaveryModule").doFreeEnslavedCharacter(npcID)
			if(npc.isDynamicCharacter()):
				GM.main.removeDynamicCharacterFromAllPools(npcID)
				GM.main.addDynamicCharacterToPool(npcID, CharacterPool.MentalWard)
		else:
			addMessage(npc.getName()+" was freed and is no longer your slave.")
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
			addMessage("You recovered "+theItem.getAStackName())
		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
