extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _reactInit():
	npc.getNpcSlavery().addTired(1)
	if(!GM.pc.hasEffect(StatusEffect.Yoga)):
		npc.getNpcSlavery().addExperience(10)
	GM.pc.addEffect(StatusEffect.Yoga)

func _init():
	sceneID = "ActionSlaverySubMassageToPC"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Massage, "back", {pc=npcID, npc="pc"})
		
		saynn("Вы приказываете своей подчиненной сделать вам массаж спины, прежде чем лечь на тюремную койку.")
		
		saynn("[say=npc]Да, {npc.pcOwner}.[/say]")
		
		saynn("Без малейших колебаний {npc.he} послушно исполняет приказ и садится рядом. Когда {npc.heShe} начинает нежно разминать ваши плечи, вы чувствуете, как по телу разливается волна тепла.")
		
		saynn("[say=npc]"+RNG.pick([
			"Let's see.. Wow. Your shoulders feel so strong.. under my hands.",
			"Here we go. Hah.. Your shoulders can carry the world.. Let me lighten that load a bit.",
			"Let's start.. Your shoulders are my favorite place. I could get used to this..",
		])+"[/say]")
		
		saynn("Сняв напряжение с ваших плеч, руки вашей субки скользят по вашей {pc.masc} спине, медленно и расслабляюще поглаживая каждый изгиб.")
		
		saynn("[say=npc]"+RNG.pick([
			"These curves, they're intoxicating. I could drown in them, happily.",
			"Feels nice, eh? Your back could make anyone jealous. Lucky me, right here.",
			"Great back, lets get all the tension out of it..",
		])+"[/say]")
		
		saynn("Вы невольно тихонько стонете: нежные прикосновения в сочетании с {npc.his} словами чертовски приятны.")
		
		saynn("Этот массаж разогрел вашу спину так же эффективно, как сеанс йоги!")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		if(npc.getNpcSlavery().getSlaveSkill(SlaveType.Submissive) >= 11):
			addButton("Массаж ягодиц", "Приказать ей помассировать и задницу тоже", "butt_massage")
		else:
			addDisabledButton("Массаж ягодиц", "Требуется навык подчиненной не ниже A")

	if(state == "butt_massage"):
		playAnimation(StageScene.Massage, "butt", {pc=npcID, npc="pc"})
		
		saynn("Вы просите свою подчиненную продолжать. И вот {npc.his} опускает руки ниже, нежно лаская ваши ягодицы с такой чувственностью, что по спине пробегает дрожь.")
		
		saynn("[say=npc]"+RNG.pick([
			"Your butt's a real treat, you know that, {npc.pcOwner}?",
			"Feels good to give it a little love. So soft and firm at the same time.",
			"Thank you for letting me massage your butt, {npc.pcOwner}, it feels nice.",
		])+"[/say]")
		
		saynn("Пока {npc.he} старается снять напряжение в ваших мышцах, вы ловите себя на том, что полностью растворяетесь в этих ощущениях.")
		
		saynn("К концу массажа вы чувствуете небывалый прилив сил.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "butt_massage"):
		processTime(10*60)
		if(npc.getNpcSlavery().getSlaveSkill(SlaveType.Submissive) >= 15):
			GM.pc.addEffect(StatusEffect.WorkOut)
		else:
			GM.pc.addEffect(StatusEffect.WorkOutLight)
		GM.pc.addStamina(100)
		npc.getNpcSlavery().addTired(1)
		
	
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
