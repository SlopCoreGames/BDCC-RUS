extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter


func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func _reactInit():
	processTime(10*60)
	npc.afterTakingAShower()
	
	var npcSlavery:NpcSlave = npc.getNpcSlavery()
	if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
		npcSlavery.getActivity().satisfyWant("pee")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "SlaveryPetWalkiesPee"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcBodyState={naked=true, leashedBy="pc"}})

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(GM.pc.getLocation() in ["main_bathroom1", "main_bathroom2"]):
			saynn("Твой питомец смотрит на тебя грустными глазами и переминается с ноги на ногу, явно нуждаясь в облегчении. Сажать его на унитаз слишком хлопотно, поэтому ты ведешь {npc.him} к писсуарам.")
			
			if(npc.isWearingChastityCage() || npc.hasReachablePenis()):
				if(npcSlavery.getSlaveSkill(SlaveType.Pet) < 10):
					saynn("Твоему питомцу приходится писать в него, как собаке, задрав {npc.his} заднюю лапу. В итоге {npc.He} все равно разбрызгивает мочу повсюду; похоже, твоему питомцу нужно еще поучиться.")
				else:
					saynn("Твой питомец охотно подчиняется и писает как настоящая собака, задрав {npc.his} заднюю лапу.")
			else:
				if(npcSlavery.getSlaveSkill(SlaveType.Pet) < 10):
					saynn("Твоему питомцу приходится писать в него, как собаке, повернувшись к нему {npc.his} задом. В итоге {npc.He} все равно разбрызгивает мочу повсюду; похоже, твоему питомцу нужно еще поучиться.")
				else:
					saynn("Твой питомец охотно подчиняется и писает как настоящая собака, повернувшись к нему {npc.his} задом.")
		else:
			saynn("Твой питомец смотрит на тебя грустными глазами и неудобно ерзает, явно нуждаясь в облегчении.")
			
			saynn("Ты оглядываешься по сторонам и находишь несколько кустов, за которые уводишь своего питомца. На твоем лице появляется игривая ухмылка.")
			
			saynn("[say=pc]Давай, вперед.[/say]")
			
			if(npc.isWearingChastityCage() || npc.hasReachablePenis()):
				if(npcSlavery.getSlaveSkill(SlaveType.Pet) < 10):
					saynn("Неохотно {npc.he} подчиняется, движения {npc.his} неуклюжие и скованные. {npc.He} задирает {npc.his} заднюю лапу, пытаясь подражать настоящей собаке... но в итоге все равно писает во все стороны.")
					
					saynn("{npc.He} быстро заканчивает дело, изо всех сил стараясь, чтобы {npc.his} не встречался с твоим взглядом.")
				else:
					saynn("Послушно, словно натренированный щенок, {npc.name} подходит к кусту и справляет нужду, задрав {npc.his} ногу, точь-в-точь как настоящий питомец.")
			else:
				if(npcSlavery.getSlaveSkill(SlaveType.Pet) < 10):
					saynn("Неохотно, {npc.he} подчиняется, {npc.his} движения неуклюжие и неловкие. {npc.He} пытается широко расставить {npc.his} задние лапы, имитируя настоящую суку... но в итоге всё равно ссыт куда попало.")
					
					saynn("{npc.He} быстро заканчивает дело, изо всех сил стараясь, чтобы {npc.his} не встречался с твоим взглядом.")
				else:
					saynn("Послушно, словно дрессированный щенок, {npc.name} подходит к кусту и справляет нужду, широко расставив {npc.his} задние лапы и пригибая {npc.himself}, точь-в-точь как настоящая сучка.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
