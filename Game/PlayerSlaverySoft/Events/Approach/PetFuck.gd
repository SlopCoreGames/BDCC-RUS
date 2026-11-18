extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0

func _init():
	id = "PetFuck"
	reactsToTags = [E_APPROACH]
	eventWeight = 0.3
	eventMinLevel = 0
	eventTagWeightOverrides = {NOET.OwnerSex: 0.4, NOET.Petplay: 2.0}

func start():
	playAnimation(StageScene.Grope, "tease", {npc=getOwnerID()})
	saynn("{npc.name} подходит к тебе, сжимая в {npc.his} щенячьи поводки!")
	talkModularOwnerToPC("SoftSlaveryPetFuck") # I wanna have some fun with my {npc.npcSlave}. Hold this while I secure this bitchsuit on you.
	saynn("Похоже, {npc.he} {npc.verb('want')} заставить тебя надеть костюм сучки!")
	
	addButton("Повиноваться", "Позволить им это", "obey")
	addButton("Сопротивляться!", "Ты не собираешься позволять им это делать", "resist")
	if(canSetLimits()):
		addButton("Да, но..", "Повиноваться, но установить границы того, что хозяин может с вами делать во время секса", "yesbut")
	else:
		addDisabledButton("Да, но..", "Ваши отношения еще недостаточно развиты, чтобы вы могли устанавливать границы")

func start_do(_id:String, _args:Array):
	if(_id == "obey"):
		setState("obey")
		#checkSubEvent("fuck", "You were about to be restrained by {npc.name}..", [])
	if(_id == "resist"):
		runResist()
	if(_id == "yesbut"):
		runEvent("yesbut", "SetOwnerLimits")
		setState("obey")
	
func obey():
	playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcBodyState={naked=true}})
	
	saynn("Ты покорно подчиняешься хозяину, позволяя {npc.him} надеть на тебя щенячью экипировку!")
	saynn("И теперь ты совершенно беспомощна...")
	addInfluenceObey(RNG.randf_range(0.05, 0.1))
	addButton("Продолжить", "Смотреть, что будет дальше", "startSex", [getOwnerID(), "pc", SexType.BitchsuitSex, {SexMod.DisableDynamicJoiners:true,SexMod.SubsStartNaked:true}])
	
func obey_sexResult(_sexResult:SexEngineResult):
	sexSatisfaction = _sexResult.getAverageDomSatisfaction()
	setState("afterSex")

func afterSex():
	playAnimation(StageScene.PuppyDuo, "stand", {pc=getOwnerID(), npcBodyState={naked=true}})
	saynn("Секс окончен!")
	if(sexSatisfaction < 0.5):
		talkModularOwnerToPC("SoftSlaveryFuckResultBad") #"That was awful. Are you trying to make me mad, {npc.npcSlave}? Whatever, I will be back soon."
	elif(sexSatisfaction < 0.8):
		talkModularOwnerToPC("SoftSlaveryFuckResultOkay") #"That was okay. Can't you moan a little louder, {npc.npcSlave}? I will be back when I'm horny again."
	else:
		talkModularOwnerToPC("SoftSlaveryFuckResultGood") #"Not bad for a {npc.npcSlave}. I will be back when I'm horny again."
	if(sexSatisfaction > 0.4):
		addInfluenceObey(sexSatisfaction)
	else:
		addInfluenceResist(1.0-sexSatisfaction)
	saynn("Твой хозяин начинает снимать с тебя щенячью экипировку...")
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["sexSatisfaction"] = sexSatisfaction
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	sexSatisfaction = SAVE.loadVar(_data, "sexSatisfaction", 1.0)
