extends SexActivityBase

var pumpID:String = ""
var timesMilked:int = 0
var noticedSore:bool = false

func _init():
	id = "DomPutBreastPumpOnSub"
	startedByDom = true
	startedBySub = false
	
	activityName = "Надеть молокоотсос на подчиненную"
	activityDesc = "Дои её молокоотсосом!"
	activityCategory = ["Breasts", "Сцеживание субмиссивной"]

func getGoals():
	return {
		SexGoal.MilkWithBreastPump: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.StocksSex: true,
		SexType.BitchsuitSex: true,
	}

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	return 0.0

func getStartActions(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var dom:BaseCharacter = _domInfo.getChar()
	var sub:BaseCharacter = _subInfo.getChar()
	
	var allPumpsIDs:Array = GlobalRegistry.getItemIDsByTag(ItemTag.BreastPumpUsableByNPC)
	
	#var putOnDomScore = getActivityScoreCustomGoals({SexGoal.SubWearStraponOnDom: 1.0}, _sexEngine, _domInfo, _subInfo) / float(allStraponIds.size())
	#var putOnSubScore = getActivityScoreCustomGoals({SexGoal.SubWearStraponOnSub: 1.0}, _sexEngine, _domInfo, _subInfo) / float(allStraponIds.size())
	
	if(sub.getFirstItemThatCoversBodypart(BodypartSlot.Breasts) == null):
		if(dom.isPlayer()):
			for straponObject in dom.getInventory().getItemsWithTag(ItemTag.BreastPump):
				addStartAction(["sub", straponObject.uniqueID], straponObject.getVisibleName(), straponObject.getVisisbleDescription(), 0.0, {A_CATEGORY: ["Breasts", "Сцеживание субмиссивной"]})
		else:
			var theActivityScore:float = getActivityScore(_sexEngine, _domInfo, _subInfo)
			for pumpNewID in allPumpsIDs:
				var pumpObject:ItemBase = GlobalRegistry.getItemRef(pumpNewID)
				
				addStartAction(["sub", pumpNewID], pumpObject.getVisibleName(), pumpObject.getVisisbleDescription(), theActivityScore, {A_CATEGORY: ["Breasts", "Сцеживание субмиссивной"]})

func getTags(_indx:int) -> Array:
	if(_indx == SUB_0):
		return [SexActivityTag.BreastsUsed]
	return []
	
func startActivity(_args):
	if(_args[0] == "sub"):
		var pumpItem:ItemBase
		if(getDom().isPlayer()):
			pumpItem = getDom().getInventory().getItemByUniqueID(_args[1])
			getSexEngine().addTrackedGear(getDomID(), getSubID(), pumpItem.uniqueID)
			getDom().getInventory().removeItem(pumpItem)
			pumpID = pumpItem.uniqueID
		else:
			pumpItem = GlobalRegistry.createItem(_args[1])
			pumpID = pumpItem.uniqueID
		#	fuelStraponRandomly(straponItem)
		getSub().getInventory().forceEquipByStoreOther(pumpItem, getDom())
		
		setState("milkingSub")
		affectSub(getSubInfo().fetishScore({Fetish.Lactation: 1.0})+0.3, 0.03, -0.1, 0.0)
		
		addTextPick([
			"{dom.You} {dom.youVerb('force')} a "+pumpItem.getCasualName()+" on {sub.you}.",
			"{dom.You} {dom.youVerb('put')} a "+pumpItem.getCasualName()+" on {sub.you}.",
		])
		
		noticedSore = getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)
		
		react(SexReaction.PutBreastPumpOnSub)

func milkingSub_processTurn():
	var pumpItem = getSub().getInventory().getEquippedItemByUniqueID(pumpID)
	if(!pumpItem || pumpItem.isRemoved()):
		endActivity()
		return
	
	affectSub(getSubInfo().fetishScore({Fetish.Lactation: 1.0})+0.3, 0.1, -0.02, 0.0)
	#getSubInfo().addArousalForeplay(0.03 + max(0.0, getSubInfo().fetishScore({Fetish.Lactation: 0.07})))
	getSubInfo().stimulateArousalZone(0.2, BodypartSlot.Breasts, 1.0)
	if(!isZoneOverstimulated(SUB_0, S_BREASTS)):
		fetishAffect(SUB_0, Fetish.Lactation)
	else:
		fetishUp(SUB_0, Fetish.Lactation, -3.0)
	
	timesMilked += 1
	var text:String = ""
	if(getSub().canBeMilked()):
		var howMuchToExtract:float = 10.0
		if(pumpItem.has_method("getMilkSpeedPerMinuteMin")):
			howMuchToExtract = RNG.randf_range(pumpItem.getMilkSpeedPerMinuteMin(), pumpItem.getMilkSpeedPerMinuteMax()) / (5.0 - min(4.0, getSub().getArousal()*10.0))
		
		var howMuchCollected:float = getSub().getBodypart(BodypartSlot.Breasts).getFluids().transferAmountTo(pumpItem, howMuchToExtract)
		
		var howMuchCollectedStr:String = str(Util.roundF(howMuchCollected, 1))+" ml"
				
		text += RNG.pick([
			"Молокоотсос доит {sub.your} {sub.breasts} в течение "+howMuchCollectedStr+" of {sub.milk}.",
			"Молокоотсос доит {sub.your} {sub.breasts} в течение "+howMuchCollectedStr+" of {sub.milk}.",
		])
		
		if(pumpItem.getFluids().isFull()):
			text += " Насос полон!"
		elif(RNG.chance(20)):
			var howMuchInPump = pumpItem.getFluids().getFluidAmount()
			
			text += " Теперь в насосе "+str(Util.roundF(howMuchInPump, 1))+" мл."
			
		sendSexEvent(SexEvent.BreastsPumpMilked, DOM_0, SUB_0, {loadSize=howMuchCollected, madeLactate=false})
	else:
		text += RNG.pick([
			"Молокоотсос стимулирует {sub.your} {sub.breasts}.",
			"Молокоотсос стимулирует {sub.your} {sub.breasts}, но молоко не идет.",
			"Молокоотсос пытается подоить {sub.your} {sub.breasts}, но {sub.youHe} {sub.youAreHeIs} не лактирует.",
		])
		var suddenlyLactate = false
		if(getSub().stimulateLactation()):
			suddenlyLactate = true
			text += RNG.pick([
				" У {sub.You} внезапно [b]началось молокоотделение[/b]! {sub.Milk} протекает из сосков {sub.yourHis}.",
			])
		sendSexEvent(SexEvent.BreastsPumpMilked, DOM_0, SUB_0, {loadSize=0.0, madeLactate=suddenlyLactate})
	
	var _isSore:bool = getSub().hasEffect(StatusEffect.SoreNipplesAfterMilking)
	if(!noticedSore && _isSore):
		noticedSore = true
		text += " Соски {sub.YourHis} [b]разболелись[/b] от такого долгого доения!"
	
	if(_isSore):
		var howMuchPainAdd = RNG.randi_range(2, 5)
		getSubInfo().addPain(howMuchPainAdd)
		sendSexEvent(SexEvent.PainInflicted, DOM_0, SUB_0, {pain=howMuchPainAdd,isDefense=false,intentional=false})
		text += RNG.pick([
			" Болят воспаленные соски {sub.YourHis}!",
			" Соски {sub.YourHis} ноют от того, что их так долго доили!",
			" Соски {sub.YourHis} садят!",
		])
	elif(RNG.chance(30)):
		text += RNG.pick([
			" Соски {sub.YourHis} чешутся.",
			" Соски {sub.YourHis} дергают.",
			" Соски {sub.YourHis} покалывает.",
		])
	
	addText(text)
	react(SexReaction.MilkingSubWithBreastPump, [7.0, 5.0])


func getActions(_indx:int):
	if(_indx == DOM_0):
		if(getState() in ["milkingSub"]):
			addAction("stopMilking", (0.1 if timesMilked > 3 else 0.0), "Прекратить доение "+getSub().getName(), "Снять молокоотсосы с "+getSub().getName(), {A_PRIORITY: 0})
	if(_indx == SUB_0):
		addAction("moo", fetish(SUB_0, Fetish.Lactation)*0.3, "Мууу", "Издавать милые звуки", {A_PRIORITY: 0})

		if(isReadyToCumHandled(SUB_0)):
			addAction("cum", 1.0, "Кончай!", "Ты сейчас кончишь.", {A_PRIORITY: 1001})
	
func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "stopMilking"):
		var text:String = ""
		text += "{dom.You} {dom.youVerb('take')} снимает молокоотсосы с {sub.your} сисек!"
		
		var pumpItem = getSub().getInventory().getEquippedItemByUniqueID(pumpID)
		if(pumpItem != null):
			getSub().getInventory().removeEquippedItem(pumpItem)
			if(getDom().isPlayer()):
				getDom().getInventory().addItem(pumpItem)
				
		satisfyGoals()
		
		endActivity()
		addText(text)
		react(SexReaction.RemoveBreastPumpFromSub, [100.0, 30.0])

	if(_id == "moo"):
		var muffled:String = ""
		if(getSub().isGagged()):
			muffled = " muffled"
		addTextPick([
			"{sub.You} {sub.youVerb('produce')} милое"+muffled+" мычание.",
			"{sub.You} {sub.youVerb('imitate')} милое"+muffled+" коровье «му».",
			"{sub.You} {sub.youVerb('moo')}, пока {sub.yourHis} {sub.breasts} доят.",
			"{sub.You} {sub.youVerb('moo')}, пока молокоотсосы работают на {sub.yourHis} груди..."
		])
		moan(SUB_0, SexReaction.SubMoos)
		return
	if(_id == "cum"):
		getSub().cumOnFloor(getDomID())
		getSubInfo().cum()
		var extraText:String = ""
		if(getSub().isLactating()):
			extraText = ", {sub.yourHis} {sub.breasts} брызжет {sub.milk} из этого соска во время оргазма"
		getSubInfo().stimulateArousalZone(0.0, BodypartSlot.Breasts, 2.0)
		fetishAffect(SUB_0, Fetish.Lactation, 3.0)
		sendSexEvent(SexEvent.UniqueOrgasm, DOM_0, SUB_0, {orgasmType="breasts"})
		addGenericOrgasmText(SUB_0, extraText)
		return

func onActivityEnd():
	var pumpItem = getSub().getInventory().getEquippedItemByUniqueID(pumpID)
	if(pumpItem == null):
		return
	getSub().getInventory().removeEquippedItem(pumpItem)
	if(getDom().isPlayer()):
		getDom().getInventory().addItem(pumpItem)

func getAnimationPriority():
	return 0

func getAnimation():
	if(getSexType() != SexType.DefaultSex):
		return null
	return [StageScene.Cuddling, "squirm", {pc=DOM_0, npc=SUB_0}]

func isAnimOptional() -> bool:
	return true

func saveData():
	var data = .saveData()
	
	data["pumpID"] = pumpID
	data["timesMilked"] = timesMilked
	data["noticedSore"] = noticedSore

	return data
	
func loadData(data):
	.loadData(data)
	
	pumpID = SAVE.loadVar(data, "pumpID", "")
	timesMilked = SAVE.loadVar(data, "timesMilked", 0)
	noticedSore = SAVE.loadVar(data, "noticedSore", false)
