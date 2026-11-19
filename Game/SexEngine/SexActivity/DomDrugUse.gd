extends SexActivityBase

var usedItemID:String = ""
var usedUniqueItemID:String = ""
var timePassed:int = 0
var pillVariants:Array = []

func _init():
	id = "DomDrugUse"
	startedByDom = true
	startedBySub = false
	
	activityName = "Употребление наркотиков"
	activityDesc = "Принять наркотики"
	activityCategory = ["Drugs/Lube"]

func getGoals():
	return {
		SexGoal.UseTFDrug: 1.0,
	}

func getSupportedSexTypes():
	return {
		SexType.DefaultSex: true,
		SexType.StocksSex: true,
		SexType.SlutwallSex: true,
		SexType.BitchsuitSex: true,
	}

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var mult = 1.0
	if(_domInfo.getChar().getCharacterType() == CharacterType.Nurse):
		mult = 2.0
	return 0.0 + _domInfo.fetishScore({Fetish.DrugUse: 0.5}) * mult

func getTags(_indx:int):
	return [SexActivityTag.OrderedToDoSomething]

func getPossibleDrugsInfo(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var thedrugs:Array = []
	if(_domInfo.getChar().isPlayer()):
		for item in GM.pc.getInventory().getItemsWithTag(ItemTag.SexEngineDrug):
			if(_sexEngine.disableTFPills && ItemTag.TFItem in item.getTags()):
				continue
			if(item.has_method("getSexEngineInfo")):
				thedrugs.append({
					id = item.id,
					item = item,
					info = item.getSexEngineInfo(_sexEngine, _domInfo, _subInfo),
				})
		return thedrugs
	
	for itemID in GlobalRegistry.getItemIDsByTag(ItemTag.SexEngineDrug):
		var item = GlobalRegistry.getItemRef(itemID)
		if(_sexEngine.disableTFPills && ItemTag.TFItem in item.getTags()):
			continue
		if(item.has_method("getSexEngineInfo")):
			thedrugs.append({
				id = itemID,
				info = item.getSexEngineInfo(_sexEngine, _domInfo, _subInfo),
			})
	
	return thedrugs
	
func getPossibleCanApplyInfo(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var thedrugs:Array = []
	for itemID in GlobalRegistry.getItemIDsByTag(ItemTag.SexEngineCanApply):
		var item = GlobalRegistry.getItemRef(itemID)
		if(_sexEngine.disableTFPills && ItemTag.TFItem in item.getTags()):
			continue
		if(item.has_method("getSexEngineInfo")):
			thedrugs.append({
				id = itemID,
				info = item.getSexEngineInfo(_sexEngine, _domInfo, _subInfo),
			})
	
	return thedrugs
	
func getDrugInfo(itemID, uniqueItemID):
	var item
	if(uniqueItemID != ""):
		item = getDom().getInventory().getItemByUniqueID(uniqueItemID)
	else:
		item = GlobalRegistry.getItemRef(itemID)
		if(item == null):
			return null
	
	return item.getSexEngineInfo(getSexEngine(), getDomInfo(), getSubInfo())

func getStartActions(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
	var possibleDrugsInfo = getPossibleDrugsInfo(_sexEngine, _domInfo, _subInfo)
	addDrugButtons(possibleDrugsInfo, _sexEngine, _domInfo, _subInfo, false)
	
	var possibleCanApplyInfo = getPossibleCanApplyInfo(_sexEngine, _domInfo, _subInfo)
	addDrugButtons(possibleCanApplyInfo, _sexEngine, _domInfo, _subInfo, true)

func addDrugButtons(possibleDrugsInfo:Array, _sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo, _isCanApply:bool = false):
	var dom:BaseCharacter = _domInfo.getChar()
	var sub:BaseCharacter = _subInfo.getChar()
	
	for itemEntry in possibleDrugsInfo:
		var itemID = itemEntry["id"]
		var drugInfo = itemEntry["info"]
		var item = itemEntry["item"] if itemEntry.has("item") else null # Only if pc
		
		if(!dom.isPlayer()):
			if(drugInfo.has("maxUsesByNPC")):
				var maxUses = drugInfo["maxUsesByNPC"]
				var currentUses = _domInfo.getMemory("USEDDRUG_"+str(itemID), 0)
				if(currentUses >= maxUses):
					continue

		var desc = drugInfo["desc"]
		if(dom.isPlayer() && item != null && item.canCombine()):
			desc = "Осталось: "+ str(dom.getInventory().getAmountOf(itemID))+"\n"+desc
		
		var drugFetishScore:float = 1.0
		
		if(!_isCanApply):
			if(drugInfo.has("sexgoal")):
				drugFetishScore = _domInfo.goalsScore({drugInfo["sexgoal"]: 1.0}, _subInfo.charID)
			else:
				drugFetishScore = clamp(_domInfo.fetishScore({Fetish.DrugUse: 1.0}) + 0.5, 0.0, 1.0) / 10.0

		var drugSubcategory:Array = item.getSexEngineSubcategory() if(item != null) else []
		if((_isCanApply || !dom.isOralBlocked()) && (!drugInfo.has("canUseOnDom") || drugInfo["canUseOnDom"])):
			var useonselfScore:float = max(drugInfo["scoreOnSelf"], 0.0) * drugFetishScore
			addStartAction(["useonself", itemID, _isCanApply, item], drugInfo["name"], desc, useonselfScore, {A_CATEGORY: getCategory()+["Себе" if !_isCanApply else "Принять самой/самому"]+drugSubcategory})
		if((_isCanApply || !sub.isOralBlocked()) && (!drugInfo.has("canUseOnSub") || drugInfo["canUseOnSub"])):
			if(_subInfo.canDoActions() && _sexEngine.getSexTypeID() != SexType.SlutwallSex && !_isCanApply):
				var offertosubScore:float = max(drugInfo["scoreOnSub"], 0.0)*(1.0 - _domInfo.getAngerScore()) * drugFetishScore
				#print("OFFER TO SUB: "+itemID+": " +str(offertosubScore))
				addStartAction(["offertosub", itemID, _isCanApply, item], drugInfo["name"], desc, offertosubScore, {A_CATEGORY: getCategory()+["Предложить сабке/сабу"]+drugSubcategory})
			
			var forcetosubScore:float = max(drugInfo["scoreOnSub"], 0.0)*(_domInfo.getAngerScore() if !_isCanApply else 1.0) * drugFetishScore
			#print("FORCE ON SUB: "+itemID+": " +str(forcetosubScore))
			addStartAction(["forcetosub", itemID, _isCanApply, item], drugInfo["name"], desc, forcetosubScore, {A_CATEGORY: getCategory()+["Заставить сабку/саба" if !_isCanApply else "Применить на сабке/сабе"]+drugSubcategory})

func pcCanSeeText(ifcan, ifcant = "какая-нибудь таблетка"):
	if(GM.pc.isBlindfolded()):
		return ifcant
	return ifcan

func startActivity(_args):
	state = ""
	
	if(_args[0] == "forcetosub"):
		timePassed = 0
		#endActivity()
		var itemID = _args[1]
		var item = _args[3]
		usedUniqueItemID = item.uniqueID if item != null else ""
		var drugInfo = getDrugInfo(itemID, usedUniqueItemID)
		usedItemID = itemID
		var _isCanApply = _args[2]
		
		if(!_isCanApply):
			setState("forcing")
		else:
			setState("forcingCanApply")
		
		#if(getDom().isPlayer()):
		#	if(item != null):
		#		item.removeXOrDestroy(1)
			#getDom().getInventory().removeXOfOrDestroy(itemID, 1)
		if(!getDom().isPlayer()):
			getDomInfo().increaseMemory("USEDDRUG_"+str(itemID))
		
		if(drugInfo == null):
			endActivity()
			return
		
		var text = RNG.pick([
			"{dom.You} {dom.youVerb('produce')} "+pcCanSeeText(drugInfo["usedName"])+" и {dom.youVerb('try', 'tries')}, чтобы запихнуть это прямо в рот {sub.your}!",
		])
		if(getSexType() == SexType.SlutwallSex):
			text = RNG.pick([
				"{dom.You} {dom.youVerb('produce')} "+pcCanSeeText(drugInfo["usedName"])+" и {dom.youVerb('slide')} это в анус {sub.your}! Таблетка начинает растворяться внутри.",
			])
		if(_isCanApply):
			text = RNG.pick([
				"{dom.You} {dom.youVerb('produce')} "+pcCanSeeText(drugInfo["usedName"], "something")+" и {dom.youVerb('begin')}, нанося это на {sub.you}!",
			])
		
		if(getSub().isPlayer() && itemID == "TFPill"):
			text += " [color=#"+Color.cyan.to_html()+"]Эта таблетка может подействовать на твое тело[/color]"

		if(_isCanApply):
			addText(text)
		else:
			addText(text)
			react(SexReaction.ForcingDrug)
	
	if(_args[0] == "useonself"):
		timePassed = 0
		#endActivity()
		var itemID = _args[1]
		var item = _args[3]
		usedUniqueItemID = item.uniqueID if item != null else ""
		var drugInfo = getDrugInfo(itemID, usedUniqueItemID)
		usedItemID = itemID
		var _isCanApply = _args[2]
		
		if(!_isCanApply):
			setState("domabouttotake")
		else:
			setState("domabouttotakeCanApply")
		
		#if(getDom().isPlayer()):
			#if(item != null):
			#	item.removeXOrDestroy(1)
			#getDom().getInventory().removeXOfOrDestroy(itemID, 1)
		if(!getDom().isPlayer()):
			getDomInfo().increaseMemory("USEDDRUG_"+str(itemID))
		
		if(drugInfo == null):
			endActivity()
			return
		
		var text = RNG.pick([
			"{dom.You} {dom.youVerb('produce')} "+pcCanSeeText(drugInfo["usedName"])+" и {dom.youAre} вот-вот засунет её в {dom.yourHis} рот.",
		])
		if(_isCanApply):
			text = RNG.pick([
				"{dom.You} {dom.youVerb('produce')} "+pcCanSeeText(drugInfo["usedName"], "something")+" и {dom.youVerb('begin')} втирает её в {dom.yourself}.",
			])
		addText(text)
	
	if(_args[0] == "offertosub"):
		state = "offering"
		timePassed = 0
		#endActivity()
		var itemID = _args[1]
		var item = _args[3]
		usedUniqueItemID = item.uniqueID if item != null else ""
		var drugInfo = getDrugInfo(itemID, usedUniqueItemID)
		usedItemID = itemID

		
		if(drugInfo == null):
			endActivity()
			return
		
		var customDomSay:String = ""
		
		var text:String = RNG.pick([
			"{dom.You} {dom.youVerb('produce')} "+pcCanSeeText(drugInfo["usedName"])+" и {dom.youVerb('offer')} скармливает её {sub.you}.",
		])
		if(getSub().isBlindfolded()):
			text += RNG.pick([
				" {sub.YouHe} может только гадать, что это за наркотик.",
			])
		elif(getSub().isPlayer() && itemID == "TFPill"):
			text += " [color=#"+Color.cyan.to_html()+"]Эта таблетка может подействовать на твое тело[/color]"

			generatePillVariants(itemID)
			if(!pillVariants.empty()):
				var tfNames:Array = []
				for tfID in pillVariants:
					var tf:TFBase = GlobalRegistry.getTransformationRef(tfID)
					if(tf != null):
						var pillName:String = tf.getPillName()
						tfNames.append("a "+pillName)
				customDomSay = "Это либо "+Util.humanReadableList(tfNames, "or")+". "
				customDomSay += RNG.pick([
					"Но я не скажу, какой именно.",
					"Но я не помню, какой именно.",
					"Испытай удачу.",
					"Просто попробуй, и посмотрим, что будет.",
					"Да ладно тебе, будет весело.",
				])
		addText(text)
		if(customDomSay == ""):
			react(SexReaction.OfferingDrug)
		else:
			talkText(DOM_0, customDomSay)
	
func processTurn():
	timePassed += 1
	
	if(timePassed > 1):
		endActivity()
		if(getState() == "offering"):
			addText("{sub.You} проигнорировал(а) предложение {dom.your}.")
			getDomInfo().addAnger(0.25)
			return
		
		if(getState() in ["forcing", "forcingCanApply"]):
			var drugInfo = getDrugInfo(usedItemID, usedUniqueItemID)
			
			var itemRef = GlobalRegistry.getItemRef(usedItemID) if usedUniqueItemID == "" else getDom().getInventory().getItemByUniqueID(usedUniqueItemID)
			if(itemRef == null || drugInfo == null):
				return
			if(usedItemID == "TFPill" && pillVariants.size() > 0):
				itemRef = GlobalRegistry.createItem(usedItemID)
				var thePick:String = RNG.pick(pillVariants)
				itemRef.setTFID(thePick)
				
			if(usedItemID == "TFPill"):
				fetishAffect(SUB_0, Fetish.TFReceiving, 10.0)
				fetishAffect(DOM_0, Fetish.TFGiving, 10.0)
			else:
				fetishAffect(SUB_0, Fetish.DrugUse, 3.0)
				fetishAffect(DOM_0, Fetish.DrugUse, 3.0)
			
			var pillResultText = ""
			var result = itemRef.useInSex(getSub())
			if(result != null && result.has("text") && result["text"]!=""):
				pillResultText = " "+result["text"]
			
			sendSexEvent(SexEvent.DrugSwallowed, DOM_0, SUB_0, {forced=true,itemID=usedItemID})
			if(drugInfo.has("sexgoal")):
				satisfyGoal(drugInfo["sexgoal"])
			
			var text = RNG.pick([
				"{dom.You} {dom.youVerb('force')} {sub.you} проглотить "+pcCanSeeText(drugInfo["usedName"])+"!"+pillResultText,
			])
			if(getSexType() == SexType.SlutwallSex):
				text = RNG.pick([
					"Таблетка растворяется внутри задницы {sub.your}, это была "+pcCanSeeText(drugInfo["usedName"], "какая-то неизвестная хрень")+"!"+pillResultText,
				])
			if(getState() == "forcingCanApply"):
				text = RNG.pick([
					"{dom.You} {dom.youVerb('finish', 'finishes')} applying "+pcCanSeeText(drugInfo["usedName"], "something")+" on {sub.youHim}!"+pillResultText,
				])
			if(usedUniqueItemID != ""):
				getDom().getInventory().getItemByUniqueID(usedUniqueItemID).removeXOrDestroy(1)
			addText(text)
			return
		
		if(getState() in ["domabouttotake", "domabouttotakeCanApply"]):
			var drugInfo = getDrugInfo(usedItemID, usedUniqueItemID)
			
			var itemRef = GlobalRegistry.getItemRef(usedItemID) if usedUniqueItemID == "" else getDom().getInventory().getItemByUniqueID(usedUniqueItemID)
			if(itemRef == null || drugInfo == null):
				return
			
			var pillResultText:String = ""
			var result = itemRef.useInSex(getDom())
			if(result != null && result.has("text") && result["text"]!=""):
				pillResultText = " "+result["text"]
			
			if(usedItemID == "TFPill"):
				fetishAffect(DOM_0, Fetish.TFGiving, 5.0)
			else:
				fetishAffect(DOM_0, Fetish.DrugUse, 2.0)
			
			var text = RNG.pick([
				"{dom.You} {dom.youVerb('swallow')} "+pcCanSeeText(drugInfo["usedName"])+"!"+pillResultText,
			])
			if(state == "domabouttotakeCanApply"):
				text = RNG.pick([
					"{dom.You} {dom.youVerb('finish', 'finishes')} applying "+pcCanSeeText(drugInfo["usedName"], "something")+" on {dom.yourself}!"+pillResultText,
				])
			if(usedUniqueItemID != ""):
				getDom().getInventory().getItemByUniqueID(usedUniqueItemID).removeXOrDestroy(1)
			addText(text)
			return

func getSubSpitOutChance(baseChance:float, domAngerRemoval:float) -> float:
	var theChance = baseChance - getDomInfo().getAngerScore()*domAngerRemoval
	if(getSub().isBitingBlocked()):
		theChance *= 0.5
	
	return max(theChance, 5.0)

func getActions(_indx:int):
	if(_indx == SUB_0):
		if(getState() == "offering"):
			var drugInfo = getDrugInfo(usedItemID, usedUniqueItemID)
			var theObeyScore:float = getSubInfo().personalityScore({PersonalityStat.Naive: 0.2, PersonalityStat.Subby: 0.2}) + getSubInfo().fetishScore({Fetish.DrugUse: 1.0})
			if(!getSub().isBlindfolded()):
				theObeyScore = (max(0.0, theObeyScore) + drugInfo["scoreSubScore"]) * getSubInfo().getComplyScore()
			if(getSubInfo().shouldFullyObey()):
				theObeyScore = 10000.0
			var theResistScore:float = 1.0 - clamp(theObeyScore, 0.0, 1.0)
			addAction("eatit", theObeyScore, "Принять таблетку", "Съесть предложенную таблетку")
			addAction("noteatit", theResistScore, "Отказаться от таблетки", "Ты не хочешь глотать эту таблетку")
		
		if(getState() == "forcing" && getSexType() != SexType.SlutwallSex):
			var theResistScore:float = 0.1 + getSubInfo().getResistScore()*(0.2 - getSubInfo().fetishScore({Fetish.DrugUse: 1.0}))
			var theObeyScore:float = 1.0 - clamp(theResistScore, 0.0, 1.0)
			if(getSubInfo().shouldFullyObey()):
				theResistScore = 0.0
				theObeyScore = 10000.0
			addAction("swallowforced", theObeyScore, "Проглотить таблетку", "Проглоти таблетку во рту")
			addAction("spitpillout", theResistScore, "Выплюнуть таблетку", "Ты реально не хочешь это глотать", {A_CHANCE: getSubSpitOutChance(100.0, 60.0)})
	
		if(getState() == "forcingCanApply"):
			var drugInfo = getDrugInfo(usedItemID, usedUniqueItemID)
			addAction("resistForceCanApply", (1.0-max(0.0, drugInfo["scoreSubScore"])), "Остановить их", "Попытаться помешать им сделать это с тобой", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_HANDS_FOCUS, 70.0, 30.0)})

		if(getState() == "domabouttotake"):
			addAction("resistdometake", getResistScore(SUB_0), "Остановить их", "Попытаться помешать им принять наркотик", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_HANDS_FOCUS, 70.0, 30.0)})
		if(getState() == "domabouttotakeCanApply"):
			addAction("resistForceCanApply", getResistScore(SUB_0), "Остановить их", "Попытаться помешать им применить эту штуку", {A_CHANCE: getResistChance(SUB_0, DOM_0, RESIST_HANDS_FOCUS, 70.0, 30.0)})

func doAction(_indx:int, _id:String, _action:Dictionary):
	if(_id == "spitpillout"):
		if(RNG.chance(getSubSpitOutChance(100.0, 60.0))):
			getDomInfo().addAnger(0.3)
			endActivity()
			var drugInfo = getDrugInfo(usedItemID, usedUniqueItemID)
			if(drugInfo.has("sexgoal")):
				failGoal(drugInfo["sexgoal"])
			addText("{sub.You} {sub.youVerb('manage', 'managed')}, чтобы выплюнуть таблетку!")
			reactSub(SexReaction.Resisting, [50])
			fetishUp(SUB_0, Fetish.DrugUse, -10.0)
			return
		
		getDomInfo().addAnger(0.1)
		addText("{sub.You} {sub.youVerb('try', 'tries')}, чтобы выплюнуть таблетку, но {sub.youVerb('fail')}.")
		fetishUp(SUB_0, Fetish.DrugUse, -20.0)
		
	if(_id == "noteatit"):
		endActivity()
		
		var drugInfo = getDrugInfo(usedItemID, usedUniqueItemID)
		if(drugInfo.has("sexgoal")):
			failGoal(drugInfo["sexgoal"])
		
		addText("{sub.You} {sub.youVerb('refuse')}, чтобы принять предложенную таблетку.")
		if(!getDom().isPlayer() && RNG.chance(100.0 * getDomInfo().personalityScore({PersonalityStat.Impatient: 0.5, PersonalityStat.Mean: 0.2}))):
			getDomInfo().addAnger(0.2)
			addText("Это разозлило {dom.you}.")
		reactSub(SexReaction.RefusingToSwallowDrug)
		
	if(_id in ["eatit", "swallowforced"]):
		endActivity()
		var drugInfo = getDrugInfo(usedItemID, usedUniqueItemID)
		if(drugInfo.has("sexgoal")):
			satisfyGoal(drugInfo["sexgoal"])
		
		#if(getDom().isPlayer() && _id == "eatit"):
		#	getDom().getInventory().removeXOfOrDestroy(usedItemID, 1)
		if(!getDom().isPlayer() && _id == "eatit"):
			getDomInfo().increaseMemory("USEDDRUG_"+str(usedItemID))
		
		var itemRef = GlobalRegistry.getItemRef(usedItemID) if usedUniqueItemID == "" else getDom().getInventory().getItemByUniqueID(usedUniqueItemID)
		if(itemRef == null || drugInfo == null):
			return
		if(usedItemID == "TFPill" && pillVariants.size() > 0):
			itemRef = GlobalRegistry.createItem(usedItemID)
			var thePick:String = RNG.pick(pillVariants)
			itemRef.setTFID(thePick)
			fetishUp(SUB_0, Fetish.TFReceiving, 10.0)
		else:
			fetishUp(SUB_0, Fetish.DrugUse, 5.0)
		
		var pillResultText = ""
		var result = itemRef.useInSex(getSub())
		if(result != null && result.has("text") && result["text"]!=""):
			pillResultText = " "+result["text"]
		
		sendSexEvent(SexEvent.DrugSwallowed, DOM_0, SUB_0, {forced=false,itemID=usedItemID})
		
		addText("{sub.You} {sub.youVerb('obey')} and {sub.youVerb('swallow')} "+pcCanSeeText(drugInfo["usedName"])+"!"+pillResultText)
		if(usedUniqueItemID != ""):
			getDom().getInventory().getItemByUniqueID(usedUniqueItemID).removeXOrDestroy(1)
	
	if(_id == "resistdometake"):
		if(RNG.chance(getResistChance(SUB_0, DOM_0, RESIST_HANDS_FOCUS, 70.0, 30.0))):
			getDomInfo().addAnger(0.3)
			endActivity()
			addText("{sub.You} {sub.youVerb('manage', 'managed')}, чтобы заставить {dom.youHim} выронить таблетку и потерять её!")
			fetishUp(SUB_0, Fetish.DrugUse, -10.0)
			return
		
		getDomInfo().addAnger(0.1)
		if(usedUniqueItemID != ""):
			getDom().getInventory().getItemByUniqueID(usedUniqueItemID).removeXOrDestroy(1)
		addText("{sub.You} {sub.youVerb('try', 'tries')}, чтобы помешать {dom.youHim} принять таблетку, но при этом {sub.youVerb('fail')}.")
		reactSub(SexReaction.Resisting, [50])
	
	if(_id == "resistForceCanApply"):
		if(RNG.chance(getResistChance(SUB_0, DOM_0, RESIST_HANDS_FOCUS, 70.0, 30.0))):
			getDomInfo().addAnger(0.3)
			endActivity()
			addText("{sub.You} {sub.youVerb('manage', 'managed')}, чтобы заставить {dom.youHim} накосячить в процессе применения!")
			return
		
		getDomInfo().addAnger(0.1)
		if(usedUniqueItemID != ""):
			getDom().getInventory().getItemByUniqueID(usedUniqueItemID).removeXOrDestroy(1)
		addText("{sub.You} {sub.youVerb('try', 'tries')}, чтобы остановить {dom.youHim}, но при этом {sub.youVerb('fail')}.")
		reactSub(SexReaction.Resisting, [50])

func generatePillVariants(theItemID:String):
	pillVariants = []
	
	if(theItemID == "TFPill"):
		for _i in 3:
			var newTFID:String = TFUtil.generateTFIDForAPill(pillVariants)
			if(newTFID != ""):
				pillVariants.append(newTFID)

func saveData():
	var data = .saveData()
	
	data["usedItemID"] = usedItemID
	data["usedUniqueItemID"] = usedUniqueItemID
	data["timePassed"] = timePassed
	data["pillVariants"] = pillVariants

	return data
	
func loadData(data):
	.loadData(data)
	
	usedItemID = SAVE.loadVar(data, "usedItemID", "")
	usedUniqueItemID = SAVE.loadVar(data, "usedUniqueItemID", "")
	timePassed = SAVE.loadVar(data, "timePassed", 0)
	pillVariants = SAVE.loadVar(data, "pillVariants", [])
