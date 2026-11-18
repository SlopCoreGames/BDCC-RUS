extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter


func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func _reactInit():
	pass
	#processTime(10*60)
	#npc.afterTakingAShower()
	
	#var npcSlavery:NpcSlave = npc.getNpcSlavery()
	#if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
	#	npcSlavery.getActivity().satisfyWant("shower")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "SlaveryPetWalkiesCanteen"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})
		var npcSlavery:NpcSlave = npc.getNpcSlavery()

		saynn("Вы приводите своего питомца в столовую, привлекая немало взглядов заключенных вокруг.")
		
		saynn("Что вы хотите взять для {npc.name}? Вы замечаете, что на кухне также предлагают настоящий сухой корм... но только для животных и по цене 2 кредита... Ваш питомец, в каком-то смысле, тоже животное.")
		
		addButton("Еда для заключенных", "Бесплатный вариант, доступный всем", "feed_inmatefood")
		addButtonWithChecks("Собачий корм", "Заплатить 2 кредита, чтобы купить питомцу особое лакомство", "feed_dogfood", [], [[ButtonChecks.HasCredits, 2]])
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) >= 10):
			addButton("Вкусняшки для щенков", "Может, получится раздобыть бесплатные вкусняшки?", "feed_puppytreats")
		else:
			addDisabledButton("Вкусняшки для щенков", "Требуется навык питомца уровня A- или выше")
	
	if(state == "feed_inmatefood"):
		playAnimation(StageScene.PuppyDuo, "sit", {npc=npcID, npcAction="sad", flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})
		
		saynn("Вы решаете не шиковать и заказываете своему питомцу обычную тюремную еду.")
		
		saynn("Повар видит, кто у вас на поводке, и решает заменить стандартный поднос на пластиковую миску для животных, прежде чем наполнить её серой безвкусной пастой. Ну, по крайней мере, это бесплатно.")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) < 11):
			saynn("Вы садитесь на одну из скамей и ставите миску на пол. Ваш щенок подходит к ней и неловко роняет {npc.his} лицо прямо в еду. Пока {npc.he} {npc.isAre} занята этим, вы просто любуетесь видом.")
		
			saynn("Паста явно не деликатес... но её достаточно, чтобы утолить голод. Ваш питомец кажется чуть более довольным.")
		else:
			saynn("Вы садитесь на одну из скамей и ставите миску на пол. Ваш щенок подходит к ней, а затем осторожно опускает {npc.himself} на пол, {npc.his} подбородок на край миски. Пока {npc.he} {npc.isAre} занята этим, вы просто любуетесь видом.")
		
			saynn("Паста явно не деликатес... но её достаточно, чтобы утолить голод. Ваш питомец кажется счастливым. {npc.He} даже слегка виляет {npc.his} задницей.")
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "feed_dogfood"):
		playAnimation(StageScene.PuppyDuo, "sit", {npc=npcID, npcAction="sad", flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})
		
		saynn("Вы решаете потратить немного кредитов и берете миску, наполненную до краев собачьим кормом. Честно говоря... это даже не так уж плохо по сравнению с пастой, которую едят все остальные — там даже попадаются кусочки мяса.")
		
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery.getSlaveSkill(SlaveType.Pet) < 12):
			saynn("Вы садитесь на одну из скамей и ставите миску на пол. Ваш питомец видит содержимое... и смотрит на вас печальными глазами.")
			
			saynn("[say=pc]Эй, да ладно тебе. Может, тебе понравится.[/say]")
			
			saynn("{npc.He} вздыхает и принюхивается к корму... Вы отчетливо слышите, как {npc.him} сглатывает слюну. Какое унижение.")
			
			saynn("Похоже, голод взял верх: твой питомец зарывается {npc.his} мордой в миску и начинает уплетать еду. Чем больше {npc.he} чавкает, тем охотнее {npc.he} хрустит кормом. Тебя даже начинает пробирать зависть.")
			
			saynn("Твой питомец оставляет миску идеально чистой. Красавчик.")
		else:
			saynn("Ты садишься на одну из скамеек и ставишь миску на пол. Твой питомец видит содержимое... и с энтузиазмом зарывается в него {npc.his} мордой!")
			
			saynn("Слышно азартное хрустение, и ты видишь, как от счастья виляет {npc.his} задницей. Оставив миску идеально чистой, твой питомец подходит к тебе и благодарно тычется носом в твою ногу.")
			
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
	if(state == "feed_puppytreats"):
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, npcAction="sit", flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})
		
		saynn("Ты гадаешь, можно ли раздобыть что-нибудь получше тюремной баланды на халяву. Ты привлекаешь внимание своего питомца и велишь {npc.him} попробовать кое-что.")
		
		saynn("Твой питомец с энтузиазмом кивает и лает, чтобы привлечь внимание повара. Затем {npc.he} ловко отталкивает {npc.himself} от пола, чтобы сесть, и включает {npc.his} самый умоляющий взгляд.")
		
		saynn("Суровый взгляд повара смягчается, когда он видит, какой твой питомец милый и послушный. Но этого мало, поэтому твой питомец еще и дрыгает {npc.his} передними лапами, а затем пару раз перекатывается по полу.")
		
		saynn("И вскоре повар сдается и кидает твоему щенку несколько лакомств! Твой питомец жадно подхватывает их и начинает счастливо хрустеть. Какой хороший {npc.boy}.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "feed_inmatefood"):
		processTime(10*60)

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("food")

	if(_action == "feed_puppytreats"):
		processTime(10*60)

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("food")
		npcSlavery.addLove(0.05)
		npcSlavery.addSpoiling(0.03)

	if(_action == "feed_dogfood"):
		processTime(10*60)
		GM.pc.addCredits(-2)

		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery != null && npcSlavery.getActivityID()=="Walkies"):
			npcSlavery.getActivity().satisfyWant("food")
		npcSlavery.addObedience(0.05)
		npcSlavery.addLove(0.02)
		
		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
