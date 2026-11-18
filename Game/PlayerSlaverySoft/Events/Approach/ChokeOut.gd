extends NpcOwnerEventBase

var sexSatisfaction:float = 1.0

func _init():
	id = "ChokeOut"
	reactsToTags = [E_APPROACH]
	eventWeight = 1.0
	eventMinLevel = 1
	eventTagWeightOverrides = {NOET.Mean: 3.0, NOET.OwnerSex: 1.0}

func start():
	playAnimation(StageScene.Choking, "idle", {pc=getRoleID(C_OWNER)})
	saynn("Твой хозяин {npc.name} вцепляется тебе в горло, как только {npc.he} {npc.verb('approach', 'approaches')} тебя!")
	talkModularOwnerToPC("SoftSlaveryChokeOutStart") #I'm so fucking mad. I need a toy to abuse and you seem good enough, {npc.npcSlave}.
	saynn("Похоже, {npc.he} {npc.isAre} сегодня не в духе...")
	
	var theChar = GlobalRegistry.getCharacter(getOwnerID())
	if(theChar):
		theChar.addEffect("SexAngry", [100])
	addContinue("startSex", [getOwnerID(), "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true, SexMod.BondageDisabled:true, SexMod.SubMustGoUnconscious:true}])

func start_sexResult(_sex:SexEngineResult):
	sexSatisfaction = _sex.getAverageDomSatisfaction()
	if(!_sex.didSubsWin()):
		setState("afterSex")
	else:
		setState("afterSexWon")

func start_sexResultUncon(_sex:SexEngineResult):
	sexSatisfaction = _sex.getAverageDomSatisfaction()
	setState("afterSexUncon")

func afterSex():
	playAnimation(StageScene.SexStart, "start", {pc=getOwnerID()})
	saynn("Тебе удалось выдержать этот натиск!")
	saynn("Твой хозяин уже не так сильно злится.")
	talkModularOwnerToPC("SoftSlaveryChokeOutEndured") #"I feel so much better. Thanks, {npc.npcSlave}."
	addInfluenceObey()
	addContinue("endEvent")

func afterSexWon():
	playAnimation(StageScene.GivingBirth, "idle", {pc=getOwnerID()})
	saynn("Тебе удалось дать отпор хозяину, прежде чем он придушил тебя!")
	talkModularOwnerToPC("SoftSlaveryChokeOutPCWon") #Ugh. Why are you such a bitch
	addInfluenceResist()
	saynn("{npc.He} {npc.isAre} всё ещё занят восстановлением, что дает тебе шанс сбежать.")
	addContinue("endEvent")

func afterSexUncon():
	playAnimation(StageScene.SexStart, "defeated", {pc=getOwnerID()})
	
	saynn("Ты теряешь сознание, не сумев долго выдерживать этот натиск...")
	talkModularOwnerToPC("SoftSlaveryChokeOutPCLost") #"Such a weak {npc.npcSlave}. Can't even take some fucking abuse."
	addInfluenceObey(0.5)
	
	var theSexChance:float = 30.0 + 50.0 * ownerFetish(Fetish.UnconsciousSex)
	if(RNG.chance(theSexChance)):
		saynn("Твой хозяин уже собирался встать и уйти... но тут...")
		talkModularOwnerToPC("SoftSlaveryChokeOutPCLostSex")
		addContinue("startSex", [getOwnerID(), "pc", SexType.DefaultSex, {SexMod.DisableDynamicJoiners:true, SexMod.BondageDisabled:true, SexMod.SubsStartUnconscious:true}])
	else:
		saynn("Твой хозяин встает и просто уходит.")
	
		addContinue("endEventUncon")

func afterSexUncon_do(_id:String, _args:Array):
	if(_id == "endEventUncon"):
		endEvent()
		stopRunner()
		GM.main.IS.startInteraction("Unconscious", {main="pc"})

func afterSexUncon_sexResult(_sex:SexEngineResult):
	endEvent()
	stopRunner()

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["sexSatisfaction"] = sexSatisfaction
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	sexSatisfaction = SAVE.loadVar(_data, "sexSatisfaction", 1.0)
