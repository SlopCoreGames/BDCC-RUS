extends NpcOwnerEventBase

var walkiesEvent:String = ""
var npcWantsSex:bool = false
var ownerProtectedPC:bool = false

func _init():
	id = "WalkiesSmallEvent"
	reactsToTags = [E_WALKIES_TO]
	eventWeight = 0.1

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	if(_args.empty()):
		return false
	var thePawns:Array = _args[0]
	if(thePawns.empty()):
		return false
	involveCharID(C_EXTRA1, RNG.pick(thePawns).getCharID())
	walkiesEvent = RNG.pick([
		"bark", "pet",
	])
	return true
	
func start():
	playAnimation(StageScene.PuppySexStart, "start", {pc=getRoleID(C_EXTRA1), npcBodyState={naked=true}})
	sayPretext()
	saynn("{npc1.name} подходит к вам двоим и приседает перед вами.")

	var biteName:String = RNG.pick([
		"Bite", "Nom", "Grrr", "Grr", "Chomp",
	])
	
	if(walkiesEvent == "bark"):
		talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesBark") # What a cute puppy. Can you bark for me?
		
		var barkName:String = RNG.pick([
			"Bark", "Woof", "Bork", "Arf", "Ruff", "Yap",
		])
		
		if(RNG.chance(50)):
			addButton(barkName, "Сделать это", "doObey")
			addButton(biteName, "Сделать это", "doBite")
		else:
			addButton(biteName, "Сделать это", "doBite")
			addButton(barkName, "Сделать это", "doObey")
	else:
		talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesPet") # What a cute puppy. Can I pat you?
		if(RNG.chance(50)):
			addButton("Разрешить", "Сделать это", "doObey")
			addButton(biteName, "Сделать это", "doBite")
		else:
			addButton(biteName, "Сделать это", "doBite")
			addButton("Разрешить", "Сделать это", "doObey")
	
func start_do(_id:String, _args:Array):
	if(_id == "doObey"):
		var sexAskChance:float = 50.0
		if(RNG.chance(sexAskChance)):
			npcWantsSex = true
			var ownerNopeChance:float = 50.0 - getOwnerNOM(NOM.Sharing)*50.0 + getOwnerNOM(NOM.NoSharing)*100.0
			if(RNG.chance(ownerNopeChance)):
				ownerProtectedPC = true
			
		setState("youObey")
		setSubResult(SUB_CONTINUE)
	if(_id == "doBite"):
		doTheBite()
	if(_id == "fight"):
		runNpcFight(getRoleID(C_OWNER), getRoleID(C_EXTRA1))

func doTheBite():
	var chanceFight:float = 30.0
	if(RNG.chance(chanceFight)):
		setState("biteFight")
	else:
		setState("biteWhatever")
		setSubResult(SUB_CONTINUE)

func youObey():
	playAnimation(StageScene.PuppySexStart, "pet", {pc=getRoleID(C_EXTRA1), npcBodyState={naked=true}})
	if(walkiesEvent == "bark"):
		saynn("Ты радостно тявкаешь!")
		talk(C_PC, RNG.pick([
			"Bark! Bark!",
			"Woof! Bark! Arff-f.",
		]))
		saynn("В ответ человек начинает тебя гладить!")
		talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesGoodPuppy") # Good puppy.
		addInfluenceObey(0.2)
	else:
		saynn("Ты замираешь и подставляешь голову, позволяя человеку начать поглаживания!")
		talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesGoodPuppy") # Good puppy.
		saynn("Приятно...")
		addInfluenceObey(0.2)
	
	if(npcWantsSex):
		saynn("Похоже, человек хочет не только гладить тебя...")
		talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesGoodPuppySex") # Are you gonna be a good puppy and let me fuck you?
		if(ownerProtectedPC):
			saynn("Вскоре вмешивается твой хозяин и отталкивает {npc1.him} назад.")
			talkModularOwnerToPC("SoftSlaveryWalkiesBiteProtect") # This is my {npc.npcSlave}. Fuck off.
			saynn("Человек закатывает {npc1.his} глаза и уходит.")
			addContinue("endEvent")
		else:
			saynn("Похоже, твоему хозяину не против...")
			addButton("Секс", "Дай им трахнуть тебя", "startSex", [getRoleID(C_EXTRA1), "pc", SexType.BitchsuitSex, {SexMod.DisableDynamicJoiners:true,SexMod.BondageDisabled:true,SexMod.SubsStartNaked:true}])
			addButton("Кусь!", "Укуси их за попытку сделать это", "bite")
	else:
		saynn("После этой короткой стычки ты продолжаешь свой путь...")
		addContinue("endEvent")

func youObey_sexResult(_sex:SexEngineResult):
	setState("afterSex")

func youObey_do(_id:String, _args:Array):
	if(_id == "bite"):
		doTheBite()

func biteWhatever():
	playAnimation(StageScene.PuppyDuo, "hurt", {pc=getRoleID(C_EXTRA1), npcBodyState={naked=true}})
	saynn("Внезапно ты подаешься вперед и кусаешь человека!")
	talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesBiteBad") # Ow. Control your mut better.
	saynn("{npc1.He} {npc1.verb('grumble')}... но решаешь ничего не предпринимать в ответ.")
	saynn("С этими мыслями ты продолжаешь свой путь...")
	addContinue("endEvent")

func biteFight():
	playAnimation(StageScene.PuppyDuo, "hurt", {pc=getRoleID(C_EXTRA1), npcBodyState={naked=true}})
	saynn("Внезапно ты подаешься вперед и кусаешь человека!")
	talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesBiteAttack") # Ow. I will make you suffer for this.
	saynn("Ой... Человек дергает тебя за воротник... но тут твой хозяин отталкивает {npc1.him} назад!")
	talkModularOwnerToPC("SoftSlaveryWalkiesBiteProtect") # This is my {npc.npcSlave}. Fuck off.
	saynn("Похоже, из-за тебя они сейчас вцепятся друг другу в глотки!")
	addContinue("fight")

func biteFight_do(_id:String, _args:Array):
	if(_id == "fight"):
		runNpcFight(getRoleID(C_OWNER), getRoleID(C_EXTRA1))

#func start_sexResult(_sex:SexEngineResult):
#	setState("afterSex")

func biteFight_eventResult(_event, _tag:String, _args:Array):
	if(_event.didWin()):
		setSubResult(SUB_CONTINUE)
		setState("ownerWon")
	else:
		setSubResult(SUB_CONTINUE)
		setState("ownerLost")

func afterSex():
	playAnimation(StageScene.PuppySexStart, "start", {pc=getOwnerID(), npcBodyState={naked=true,leashedBy=getOwnerID()}})
	saynn("После секса ваш хозяин снова пристегивает поводок к вашему ошейнику.")
	talkModularOwnerToPC("SoftSlaveryParadeFuckOfferGood")
	addInfluenceObey(0.1)
	addContinue("endEvent")

func ownerWon():
	playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), bodyState={leashedBy=getOwnerID()}})
	
	saynn("Ваш хозяин снова пристегивает поводок к вашему ошейнику.")
	talkModularOwnerToPC("SoftSlaveryParadeFuckOfferWon")
	addInfluenceObey(0.2)
	addContinue("endEvent")

func ownerLost():
	
	var theSexChance:float = 50.0 - personality(C_EXTRA1, PersonalityStat.Subby)*40.0
	
	if(smartChance(theSexChance)):
		playAnimation(StageScene.PuppySexStart, "sad", {pc=getRoleID(C_EXTRA1), npcBodyState={naked=true}})
		saynn("После драки к тебе подходит {npc1.name}. Похоже, {npc1.he} {npc1.verb('want')}, чтобы трахнуть тебя...")
		addContinue("startSex", [getRoleID(C_EXTRA1), "pc", SexType.BitchsuitSex, {SexMod.DisableDynamicJoiners:true,SexMod.BondageDisabled:true,SexMod.SubsStartNaked:true}])
	else:
		playAnimation(StageScene.PuppySexStart, "sad", {pc=getOwnerID(), npcBodyState={naked=true}})
		saynn("После драки к тебе подходит {npc1.name}. {npc1.He} {npc1.verb('grab')} тебя за воротник и дает пощечину! Ай.")
		talkModular(C_EXTRA1, C_PC, "SoftSlaveryWalkiesBadPuppy") #Stupid mut.
		saynn("После этого человек оставляет тебя в покое.")
		saynn("Твой хозяин снова защелкивает поводок на твоем ошейнике.")
		talkModularOwnerToPC("SoftSlaveryWalkiesBadPuppyObey") #You need to obey more, {npc.npcSlave}
		addInfluenceResist(0.5)
		addContinue("endEvent")
	
func ownerLost_sexResult(_sex:SexEngineResult):
	setState("afterLostSex")

func afterLostSex():
	playAnimation(StageScene.PuppySexStart, "start", {pc=getOwnerID(), npcBodyState={naked=true,leashedBy=getOwnerID()}})
	
	saynn("{npc.name} снова защелкивает поводок на твоем ошейнике.")
	addInfluenceResist(0.8)
	talkModularOwnerToPC("SoftSlaveryWalkiesLostNotDone") #Whatever. We're not done walking around yet.
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	data["walkiesEvent"] = walkiesEvent
	data["npcWantsSex"] = npcWantsSex
	data["ownerProtectedPC"] = ownerProtectedPC
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	walkiesEvent = SAVE.loadVar(_data, "walkiesEvent", "pet")
	npcWantsSex = SAVE.loadVar(_data, "npcWantsSex", false)
	ownerProtectedPC = SAVE.loadVar(_data, "ownerProtectedPC", false)
