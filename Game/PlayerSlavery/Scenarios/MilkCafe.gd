extends PlayerSlaveryBase

var cowTrust:float = 0.0
var bullTrust:float = 0.0

var obedience:float = 0.0

var needsPunishment:bool = false
var canMilkOthers:bool = false

var day:int = 0

var pcGaveMilkOrSeed:int = 0 # How many times pc was milked or milked others
var milkedToday:int = 0
var milkedTotal:int = 0
var totalEarned:int = 0

var gotMilkedNoon:bool = false
var gotMilkedEvening:bool = false

func onNewDay():
	gotMilkedNoon = false
	gotMilkedEvening = false
	day += 1

var agreeMilk:bool = true
var agreeSeed:bool = false

var cowTopic:int = 0
var bullTopic:int = 0
var guyTopic:int = 0

var peekTried:int = 0
var peekState:int = PEEK_START
const PEEK_START = 0
const PEEK_NOTICED_PADLOCK = 1
const PEEK_NOTICED_CUSTOMER = 2
const PEEK_NOTICED_BY_CUSTOMER = 3
const PEEK_BULLIED_BY_GIRL = 4
const PEEK_FIRST_EVENT_HAPPENED = 5
const PEEK_SECOND_EVENT_HAPPENED = 6
const PEEK_THIRD_EVENT_HAPPENED = 7
var gonnaHavePeekEvent:bool = false

var padlockDamage:float = 0.0

var canHelpCage:bool = false
var cageRemoved:bool = false
var cageDamage:float = 0.0

var canHelpMilka:bool = false
var milkaExtraBreastSize:int = 0
var helpedMilka:bool = false

var upgradeLevel:int = -1
var extraProfit:int = 0

var lactationTry:int = 0
var isGuyTurn:bool = false

var lastEvent:String = ""

var charsHere:Array = []

const IDLE_HUNGRY = 0
const IDLE_SOCIAL = 1
const IDLE_IDLE = 2
const IDLE_NEEDY = 3
const IDLE_MAX = 3

var idleState:int = IDLE_IDLE

var state:String = "intro" #"ePeekSecondEvent"
var texts:Array = []
var actions:Array = []

const C_PC = "pc"
const C_COW = "psmilka"
const C_BULL = "pspip"
const C_GIRL = "psmilkgirl"
const C_GUY = "psmilkguy"
const C_OFFICER = "psmilkofficer"

const L_DOOR = "pscafe_door"
const L_SLEEP = "pscafe_sleep"
const L_BASEMENT_RIGHT = "pscafe_right"
const L_COW = "pscafe_cow"
const L_BULL = "pscafe_bull"
const L_ACT = "pscafe_act"
const L_EAT = "pscafe_eat"
const L_CENTER = "pscafe_center"
const L_COUNTER = "pscafe_counter"
const L_DOCKS = "pscafe_docks"
const L_FIELD = "pscafe_field"
const L_FIELD2 = "pscafe_field2"
const L_FIELD3 = "pscafe_field3"
const L_TABLE = "pscafe_table"

func saveData() -> Dictionary:

	return {
		cowTrust = cowTrust,
		bullTrust = bullTrust,
		obedience = obedience,
		canMilkOthers = canMilkOthers,
		needsPunishment = needsPunishment,
		day = day,
		state = state,
		texts = texts,
		actions = actions,
		agreeMilk = agreeMilk,
		agreeSeed = agreeSeed,
		pcGaveMilkOrSeed = pcGaveMilkOrSeed,
		milkedToday = milkedToday,
		milkedTotal = milkedTotal,
		idleState = idleState,
		gotMilkedNoon = gotMilkedNoon,
		gotMilkedEvening = gotMilkedEvening,
		cowTopic = cowTopic,
		bullTopic = bullTopic,
		guyTopic = guyTopic,
		peekTried = peekTried,
		peekState = peekState,
		padlockDamage = padlockDamage,
		totalEarned = totalEarned,
		canHelpCage = canHelpCage,
		cageRemoved = cageRemoved,
		cageDamage = cageDamage,
		charsHere = charsHere,
		canHelpMilka = canHelpMilka,
		helpedMilka = helpedMilka,
		milkaExtraBreastSize = milkaExtraBreastSize,
		upgradeLevel = upgradeLevel,
		extraProfit = extraProfit,
		lactationTry = lactationTry,
		isGuyTurn = isGuyTurn,
		lastEvent = lastEvent,
		gonnaHavePeekEvent = gonnaHavePeekEvent,
	}

func loadData(_data:Dictionary):
	cowTrust = SAVE.loadVar(_data, "cowTrust", 0.0)
	bullTrust = SAVE.loadVar(_data, "bullTrust", 0.0)
	obedience = SAVE.loadVar(_data, "obedience", 0.0)
	canMilkOthers = SAVE.loadVar(_data, "canMilkOthers", false)
	needsPunishment = SAVE.loadVar(_data, "needsPunishment", false)
	day = SAVE.loadVar(_data, "day", 0)
	state = SAVE.loadVar(_data, "state", "")
	texts = SAVE.loadVar(_data, "texts", [])
	actions = SAVE.loadVar(_data, "actions", [])
	agreeMilk = SAVE.loadVar(_data, "agreeMilk", true)
	agreeSeed = SAVE.loadVar(_data, "agreeSeed", false)
	pcGaveMilkOrSeed = SAVE.loadVar(_data, "pcGaveMilkOrSeed", 0)
	milkedToday = SAVE.loadVar(_data, "milkedToday", 0)
	milkedTotal = SAVE.loadVar(_data, "milkedTotal", 0)
	idleState = SAVE.loadVar(_data, "idleState", IDLE_IDLE)
	gotMilkedNoon = SAVE.loadVar(_data, "gotMilkedNoon", false)
	gotMilkedEvening = SAVE.loadVar(_data, "gotMilkedEvening", false)
	cowTopic = SAVE.loadVar(_data, "cowTopic", 0)
	bullTopic = SAVE.loadVar(_data, "bullTopic", 0)
	guyTopic = SAVE.loadVar(_data, "guyTopic", 0)
	peekTried = SAVE.loadVar(_data, "peekTried", 0)
	peekState = SAVE.loadVar(_data, "peekState", 0)
	padlockDamage = SAVE.loadVar(_data, "padlockDamage", 0.0)
	totalEarned = SAVE.loadVar(_data, "totalEarned", 0)
	canHelpCage = SAVE.loadVar(_data, "canHelpCage", false)
	cageRemoved = SAVE.loadVar(_data, "cageRemoved", false)
	cageDamage = SAVE.loadVar(_data, "cageDamage", 0.0)
	charsHere = SAVE.loadVar(_data, "charsHere", [])
	canHelpMilka = SAVE.loadVar(_data, "canHelpMilka", false)
	helpedMilka = SAVE.loadVar(_data, "helpedMilka", false)
	milkaExtraBreastSize = SAVE.loadVar(_data, "milkaExtraBreastSize", 0)
	upgradeLevel = SAVE.loadVar(_data, "upgradeLevel", -1)
	extraProfit = SAVE.loadVar(_data, "extraProfit", 0)
	lactationTry = SAVE.loadVar(_data, "lactationTry", 0)
	isGuyTurn = SAVE.loadVar(_data, "isGuyTurn", false)
	lastEvent = SAVE.loadVar(_data, "lastEvent", "")
	gonnaHavePeekEvent = SAVE.loadVar(_data, "gonnaHavePeekEvent", false)

const UPGRADES = [
	{
		earned = 500,
		message = "The owners bought some breast and penis pumps!",
		creditsMult = 5.0,
	},
	{
		earned = 3000,
		message = "The owners have replaced the grass in the garden with tastier one!",
		creditsMult = 10.0,
	},
	{
		earned = 10000,
		message = "The owners have installed a milking stall!",
		creditsMult = 20.0,
	},
	{
		earned = 25000,
		message = "The owners have bought some fuck-machines!",
		creditsMult = 30.0,
	},
	{
		earned = 50000,
		message = "The owners have made the cafe prettier and also gave you better cells!",
		creditsMult = 100.0,
	},
	{
		earned = 100000,
		message = "The owners have installed an advanced milking table!",
		creditsMult = 200.0,
	},
]
const UPGRADE_PUMPS = 0
const UPGRADE_GRASS = 1
const UPGRADE_STALL = 2
const UPGRADE_FUCKMACHINE = 3
const UPGRADE_CELLS = 4
const UPGRADE_MILKINGTABLE = 5

const MILKA_LINES = [
	"Oh, hai. There is more of us here now, neat. Name is Milka!",
	"I'm a cow here. I like making new friends!",
	"I also make a lot of milk.. Well, I'm trying to.",
	"If you ever feel sad, talk with me! I like helping!",
	"I like being milked. Feels good! Moo!",
	"Moo-moo-moo~.",
	"People say my milk tastes like strawberries~.",
	"My breasts aren't that big. I'm sure they will grow!",
	"The bull over there is a bit grumpy. I think I know why!",
	"I have many nipples.. but most of them don't work. Aw.",
	"I don't like overthinking.. Makes my head buzz-buzz.",
	"Life is getting better actually! The funny marks don't hurt as much.",
	"These owners gave me my name.. Milka. Fits me, doesn't it? I just need bigger titties!",
	"Do you have dreams? Sometimes I dream of soft grass and sunshine. Moo~.",
	"The cafe doesn't seem to be doing well.. reminds me of my home..",
	"I can tell them to milk my breasts twice as much. Then they will go easier on you. Just let me know!",
	"When I'm scared, I just count the lines. It helps!",
	"I would love to help that bull.. Then he would breed me maybe! Breeding is in my DNA~.",
	"What's my real name? Uh.. Um. Milka? I'm just a cow.. Silvery grass, fields, barns, that's where I grew up! I think.",
	"Hm.. Thinking is hard. I will get back to you.",
	"Oh. I remember a stage! Maybe I was a singer?",
	"I like it when you scratch behind my ears. It reminds me of.. hm..",
	"I like humming songs. Moo-moo-moo~. Man, I was totally a singer!",
	"My memory is foggy.. froggy, haha. Get it?",
	"I'm happiest I ever was!",
	"My breasts feel funny. If you're sad, feel free to touch!",
	"I don't know what tomorrow brings. But if you're here, it's okay!",
	"I taste ash.. Did the grass always tasted like that?",
	"I was a singer, I'm telling you. Ahhh-h-hh~.",
	"A talent scout once told me I have a great voice!",
	"More milking? Sign me up!",
	"Oh yeah! I traveled a lot! I saw many places. Many stages. A singing cow, I was popular~.",
	"I was trying to help my old farm. Earn credits with my voice!",
	"That talent scout found me and gave me a chance!",
	"Thank you for being here with me! Cows are social creatures.",
	"Wanna talk about something else?",
	"I think I'm out of things to talk about.. I might start repeating, I'm sorry!",
]

const PIP_LINES = [
	"They got you too, huh? Welcome, I guess. I'm Pip.",
	"I was the cheapest bull they were able to buy. Can you see why?",
	"The previous owner has melted the key when I tried to run. Yeah, that key.",
	"They still milk me. They need their stupid cream.",
	"The owner girl is a real fucking bitch. The guy is better but I don't trust him.",
	"That cow over there? Milka or whatever her name is.. She is delusional. I'm sorry but she totally is.",
	"The customers don't even know that the owners use our milk and cum in their food.",
	"I'm so fucking horny..",
	"They turned the freezer room into our cells. They don't have enough credits to pay for it anyway.",
	"My tailhole has really puffed up lately. Fuck..",
	"I was caged because the owner wanted to turn me into a femboy. I'm a stud, god dammit!",
	"No point in yelling.. The walls are too thick.",
	"I'm not into pegging! I'm not, I'm not, I'm not. I allow it because otherwise the pressure becomes too much.",
	"That Milka cow is dumb.. But I would breed her anyway.. Hell, I'd breed you..",
	"If you could help me.. Please. I will do anything.",
	"It's boring here. Could have been worse I guess.",
	"Milka is eating that grass.. like a fucking cow. I'd rather starve. Or eat ass even.",
	"I'm glad you're here. Well.. Not in the bad way.",
	"I lied a bit. No, I just didn't tell you everything. I was caged and enslaved because I banged some club owner's slutty wife. If you ask me, that was worth it.",
	"Yeah.. That pussy was clenching around my long, thick horsecock.. Shit, I'm dripping.",
	"I heard one of the customers compliment the cupcakes. I knew my seed was good!",
	"My nipples are getting sensitive too. Don't tell the owners or they will start milking them as well.",
	"I play with my nips, okay? I fucking do. I finger my ass sometimes. I'm a stud, I need a ball-draining amount of pleasure.",
	"When I get out, I'm heading straight back to that club.",
	"Breeding.. This place is messing with me. I have weird dreams. Wet dreams.",
	"If you wanna help me cum, I'd appreciate it, okay? Doesn't mean I'm a bottom.",
	"They were talking about starting a cheese shop too.. I will give them some cheese alright.",
	"That club owner that I fucked over? I don't regret it.",
	"Days are just flying by, aren't they?",
	"If you wanna milk me, let me know. I can bend over.",
	"I can probably fist myself by this point.. I have such a fucking donut of a hole. Shit.",
	"You know what I regret? I should have protected Milka more from these fuckers. I don't know, she is not that bad.",
	"I fucked many caged sluts. Didn't know I would become one.",
	"I don't know what else to say. I will start repeating I guess.",
]

const LEO_LINES = [
	"Sorry.. but it had to be like this. Good milk is hard to get.. Customers hate cheap milk..",
	"We and Sofie, my love, we're in huge need of credits.. This cafe wasn't cheap to buy.",
	"Sofie has a big, kind heart. It's just.. tough times for us.",
	"We're both at fault, I think.. we made some mistakes..",
	"You know.. this little space cafe was always our dream.. We're so close.. to being free.",
	"I put everything on this dream.. Sofie put everything on red.. I don't blame her, it's my fault for not stopping her..",
	"I love her.. maybe I'm dumb.. but it feels good to be near her, you know? No matter what happens..",
]

func _init():
	id = "MilkCafe"

func onSlaveryStart():
	updateCharacters()
	call(state+"_state")
	var theCow = GlobalRegistry.getCharacter(C_COW)
	if(theCow):
		theCow.induceLactation()
		theCow.cancelPregnancy()

func onSlaveryEnd():
	GM.pc.removeEffect(StatusEffect.PSMilkCafeProduction)
	var theCow = GlobalRegistry.getCharacter(C_COW)
	if(theCow):
		theCow.induceLactation()
		theCow.cancelPregnancy()

# Gets called after onSlaveryStart()
func getStartScene() -> String:
	return "PSMilkCafeGameplayScene"

func getPCViewDistance() -> float:
	return 150.0

func setState(_state:String):
	state = _state

func updateCharacters():
	GlobalRegistry.getCharacter("pspip").resetEquipment()
	GlobalRegistry.getCharacter("psmilka").updateBodyparts()

func isPipCaged() -> bool:
	return !cageRemoved

func getMilkaBreastSize() -> int:
	return 2 + milkaExtraBreastSize

func getCreditsEarnMult() -> float:
	if(upgradeLevel >= 0 && upgradeLevel < UPGRADES.size()):
		return UPGRADES[upgradeLevel]["creditsMult"]
	return 1.0

func saynn(_text:String):
	texts.append(_text+"\n\n")
func sayn(_text:String):
	texts.append(_text+"\n")
func say(_text:String):
	texts.append(_text)
func addTextToBack(_text:String):
	if(texts.empty()):
		texts.append(_text+"\n\n")
	else:
		var lastText:String = texts.pop_back()
		if(lastText.ends_with("\n\n")):
			lastText = lastText.trim_suffix("\n\n")+" "+_text+"\n\n"
		elif(lastText.ends_with("\n")):
			lastText = lastText.trim_suffix("\n")+" "+_text+"\n"
		else:
			lastText = lastText+" "+_text+"\n"
		texts.append(lastText)

func talk(_whoID:String, _text:String, addToChars:bool = true):
	saynn("[say="+_whoID+"]"+_text+"[/say]")
	if(addToChars):
		addChar(_whoID)
func addChar(_whoID:String):
	if(_whoID == "pc"):
		return
	if(!charsHere.has(_whoID)):
		charsHere.append(_whoID)
func getCharacterList() -> Array:
	return charsHere

func aimCamera(_loc:String):
	GM.main.aimCameraAndSetLocName(_loc)

func playAnimation(theSceneID, theActionID, args = {}):
	if(GM.main != null):
		GM.main.playAnimation(theSceneID, theActionID, args)

func addAction(_name:String, _desc:String, _id:String, _args:Array = []):
	actions.append([true, -1, _name, _desc, _id, _args])

func addContinue(_id:String, _args:Array = []):
	addAction("Continue", "See what happens next", _id, _args)

func addDisabledAction(_name:String, _desc:String):
	actions.append([false, -1, _name, _desc])

func getFinalText() -> String:
	return Util.join(texts)

func getFinalActions() -> Array:
	var result:Array = []
	
	for actionEntry in actions:
		result.append([actionEntry[1], "action" if actionEntry[0] else "", actionEntry[2], actionEntry[3], actionEntry])
	
	return result
	
func startNewState():
	actions.clear()
	texts.clear()
	charsHere.clear()
	
func processFightEnd(_didPCWin:bool):
	startNewState()
	call(state + "_fightResult", _didPCWin)

func processSexEnd(_sexResult:SexEngineResult):
	startNewState()
	call(state + "_sexResult", _sexResult)

func doFinalAction(_finalActionEntry:Array) -> Dictionary:
	if(_finalActionEntry[1] == "action"):
		var _actionEntry:Array = _finalActionEntry[4]
		startNewState()
		
		var theID:String = _actionEntry[4]
		var theArgs:Array = _actionEntry[5]
		
		if(theID == "setState"):
			state = theArgs[0]
			call(state + "_state")
			return {}
		if(theID == "startFight"):
			return {fight=theArgs[0]}
		if(theID == "startSex"):
			return {sex=theArgs}
		if(theID == "triggerEventMaybe"):
			triggerEventMaybe()
			call(state + "_state")
			return {}
		if(theID == "ENDING"):
			return {end=theArgs[0]}
		if(theID == "SLEEP"):
			setState("main")
			sleepScene()
			return {}
			
		
		call(state + "_do", theID, theArgs)
		if(texts.empty() && actions.empty()):
			call(state + "_state")
		elif(actions.empty()):
			addAction("Continue", "See what happens next..", "setState", [state])
	return {}
	
func processTurn():
	GM.main.processTime(60*RNG.randi_range(60, 180))
	idleState += 1
	if(idleState > IDLE_MAX):
		idleState = 0

func addUpTextNum(_value:String, _howMuch:int, reverse:bool = false):
	var howMuchStr:String = ("+" if _howMuch >= 0 else "")+str(_howMuch)
	if(_howMuch*(1 if !reverse else -1) >= 0):
		addTextToBack("[color=#00CC00]("+_value+" "+howMuchStr+")[/color]")
	else:
		addTextToBack("[color=red]("+_value+" "+howMuchStr+")[/color]")
func addUpText(_value:String, _howMuch:int):
	if(_howMuch == 0):
		_howMuch = 1
	var howMuchStr:String = ("+".repeat(_howMuch) if _howMuch >= 0 else "-".repeat(-_howMuch))
	if(_howMuch >= 0):
		addTextToBack("[color=#00CC00]("+_value+" "+howMuchStr+")[/color]")
	else:
		addTextToBack("[color=red]("+_value+" "+howMuchStr+")[/color]")
func addUpTextF(_value:String, _howMuch:float):
	var theU:int = int(round(_howMuch))
	if(theU == 0 && _howMuch > 0.0):
		theU = 1
	if(theU == 0 && _howMuch < 0.0):
		theU = -1
	addUpText(_value, theU)

func addTreat(_howMuch:int = 1):
	var oldAmount:int = getTreatAmount()
	if(_howMuch > 0):
		for _i in range(_howMuch):
			GM.pc.getInventory().addItem(GlobalRegistry.createItem("appleitem"))
	if(_howMuch < 0):
		GM.pc.getInventory().removeXOfOrDestroy("appleitem", -_howMuch)
	var newTreatAmount:int = getTreatAmount()
	
	if(oldAmount == newTreatAmount):
		return
	var theDiff:int = newTreatAmount - oldAmount
	if(theDiff != 0):
		addUpText("Treat" if (theDiff == 1 || theDiff == -1) else "Treats", theDiff)

func getTreatAmount() -> int:
	return GM.pc.getInventory().getAmountOf("appleitem")

func addShiv():
	GM.pc.getInventory().addItem(GlobalRegistry.createItem("Shiv"))
	addUpText("Shiv", 1)

func useShiv() -> bool:
	if(GM.pc.getInventory().removeFirstOf("Shiv")):
		addUpText("Shiv", -1)
		return true
	return false

func getShivAmount() -> int:
	return GM.pc.getInventory().getAmountOf("Shiv")

func sayMilkaLine():
	if(cowTopic >= MILKA_LINES.size()):
		talk(C_COW, RNG.pick(MILKA_LINES))
	else:
		talk(C_COW, MILKA_LINES[cowTopic])
		cowTopic += 1
func sayPipLine():
	if(bullTopic >= PIP_LINES.size()):
		talk(C_BULL, RNG.pick(PIP_LINES))
	else:
		talk(C_BULL, PIP_LINES[bullTopic])
		bullTopic += 1
func sayLeoLine():
	if(guyTopic >= LEO_LINES.size()):
		talk(C_GUY, RNG.pick(LEO_LINES))
	else:
		talk(C_GUY, LEO_LINES[guyTopic])
		guyTopic += 1

func addCredits(_howMuch:int):
	GM.pc.addCredits(_howMuch)
	addUpTextNum("Credits", _howMuch)
func addStamina(_howMuch:int):
	var theMaxStamina:float = float(GM.pc.getMaxStamina())
	var theFactor:float = theMaxStamina/100.0
	var howMuchActually:int = int(round(_howMuch*theFactor))
	GM.pc.addStamina(howMuchActually)
	addUpTextNum("Stamina", howMuchActually)
func addPain(_howMuch:int):
	GM.pc.addPain(_howMuch)
	addUpTextNum("Pain", _howMuch, true)
func addObedience(_howMuch:float):
	obedience += (_howMuch*2.0 if _howMuch<0.0 else _howMuch) / 100.0
	addUpTextF("Obedience", _howMuch)
func addCowTrust(_howMuch:float):
	cowTrust += _howMuch / 100.0
	addUpTextF("Cow's trust", _howMuch)
func addBullTrust(_howMuch:float):
	bullTrust += _howMuch / 100.0
	addUpTextF("Bull's trust", _howMuch)
func addPadlockDamage(_howMuch:float):
	padlockDamage += _howMuch / 20.0
	addUpTextF("Padlock's damage", _howMuch)

func getCredits() -> int:
	return GM.pc.getCredits()

func gotMilked(howMuch:int = 1):
	milkedToday += howMuch
	milkedTotal += howMuch

func onDayEnd():
	var earned:int = extraProfit
	
	if(milkedToday > 0):
		var earnMult:float = getCreditsEarnMult()
		var earnedCredsMin:int = milkedToday * 100 + milkedTotal * milkedTotal
		var earnedCredsMax:int = milkedToday * 300 + milkedTotal * milkedTotal
		earned += RNG.randi_range(int(earnedCredsMin*earnMult), int(earnedCredsMax*earnMult))
	
	if(pcGaveMilkOrSeed <= 0):
		needsPunishment = true
	
	if(earned > 0):
		totalEarned += earned
		saynn("Кафе получило небольшую прибыль!")
		addCredits(earned)
	else:
		saynn("Кафе не удалось получить прибыль из-за нехватки молока или сливок.")
	
	for theNewUpgradeLevel in range(UPGRADES.size()):
		if(upgradeLevel >= theNewUpgradeLevel):
			continue
		var theEntry:Dictionary = UPGRADES[theNewUpgradeLevel]
		var amountToEarn:int = theEntry["earned"]
		if(totalEarned >= amountToEarn):
			upgradeLevel = theNewUpgradeLevel
			sayn("[b]Кафе заработало достаточно кредитов на улучшение![/b]")
			saynn(theEntry["message"])
	
	milkedToday = 0
	extraProfit = 0
	pcGaveMilkOrSeed = 0
	onNewDay()

func addBreastPump(_charID:String) -> bool:
	var theChar:BaseCharacter = GlobalRegistry.getCharacter(_charID)
	var thePump = GlobalRegistry.createItem("BreastPump")
	if(theChar.canBeMilked()):
		var theFluids = thePump.getFluids()
		theFluids.addFluid("Milk", 400.0)
	theChar.getInventory().forceEquipStoreOtherUnlessRestraint(thePump)
	return true

func removeBreastPump(_charID:String):
	GlobalRegistry.getCharacter(_charID).getInventory().clearSlot(InventorySlot.UnderwearTop)

func addPenisPump(_charID:String) -> bool:
	var theChar:BaseCharacter = GlobalRegistry.getCharacter(_charID)
	if(theChar.isWearingChastityCage()):
		return false
	theChar.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("PenisPump"))
	return true

func removePenisPump(_charID:String):
	var theChar:BaseCharacter = GlobalRegistry.getCharacter(_charID)
	if(theChar.isWearingChastityCage()):
		return
	GlobalRegistry.getCharacter(_charID).getInventory().clearSlot(InventorySlot.Penis)

func addStrapon(_charID:String, _cumID:String = "") -> bool:
	var theChar:BaseCharacter = GlobalRegistry.getCharacter(_charID)
	if(!theChar.canWearStrapon() || theChar.isWearingStrapon()):
		return false
	var theStrapon = GlobalRegistry.createItem(RNG.pick([
		"Strapon",
		"StraponCanine",
		"StraponDragon",
		"StraponFeline",
		"StraponHorse",
	]))
	if(_cumID != ""):
		var cumChar:BaseCharacter = GlobalRegistry.getCharacter(_cumID)
		var fluids:Fluids = theStrapon.getFluids()
		fluids.addFluid(cumChar.getFluidType(FluidSource.Penis), RNG.randf_range(400.0, 700.0), cumChar.getFluidDNA(FluidSource.Penis))
	theChar.getInventory().forceEquipStoreOtherUnlessRestraint(theStrapon)
	return true
	
func removeStrapon(_charID:String):
	var theChar:BaseCharacter = GlobalRegistry.getCharacter(_charID)
	if(theChar && theChar.isWearingStrapon()):
		theChar.removeStrapon()

func cowBullBoth(cowText:String, bullText:String, bothText:String) -> String:
	if(agreeMilk && agreeSeed && GM.pc.hasPenis()):
		return bothText
	if(agreeSeed && GM.pc.hasPenis()):
		return bullText
	return cowText

func cowBull() -> String:
	return cowBullBoth("cow", "bull", "cow")

func getObedienceText() -> String:
	var theObedience:float = obedience if obedience < 0.0 else obedience*2.0
	if(theObedience <= -0.9):
		return "The owners despise you. You’re nothing but trouble in their eyes."
	if(theObedience <= -0.7):
		return "The owners really hate you."
	if(theObedience <= -0.5):
		return "The owners dislike your behaviour."
	if(theObedience <= -0.3):
		return "The owners think you're very disobedient."
	if(theObedience <= -0.1):
		return "The owners think you're disobedient."
	if(theObedience <= 0.1):
		return "The owners keep a close eye on you."
	if(theObedience <= 0.3):
		return "The owners see you as somewhat cooperative."
	if(theObedience <= 0.5):
		return "The owners are pleased with your behaviour."
	if(theObedience <= 0.7):
		return "The owners think you're very obedient."
	if(theObedience <= 0.9):
		return "The owners think you're very loyal."
	return "The owners think you're the perfect slave."

func getCowTrustText() -> String:
	var theTrust:float = cowTrust * 2.0
	if(theTrust < 0.0):
		return "The cow dislikes you."
	if(theTrust <= 0.0):
		return "The cow doesn't know you."
	if(theTrust <= 0.2):
		return "The cow knows you a little bit."
	if(theTrust <= 0.4):
		return "The cow likes you."
	if(theTrust <= 0.6):
		return "The cow thinks you're very nice."
	if(theTrust <= 0.8):
		return "The cow adores you."
	return "You are cow's best friend."

func getBullTrustText() -> String:
	var theTrust:float = bullTrust * 2.0
	if(theTrust < 0.0):
		return "The bull dislikes you."
	if(theTrust <= 0.0):
		return "The bull doesn't know you."
	if(theTrust <= 0.2):
		return "The bull knows you a little bit."
	if(theTrust <= 0.4):
		return "The bull thinks you're alright."
	if(theTrust <= 0.6):
		return "The bull respects you."
	if(theTrust <= 0.8):
		return "The bull admires you."
	return "You and the bull are buddies."

func getDoorDamageText() -> String:
	if(padlockDamage <= 0.1):
		return "The padlock is completely fine."
	if(padlockDamage <= 0.3):
		return "The padlock is slightly damaged."
	if(padlockDamage <= 0.5):
		return "The padlock has some bents and scratches."
	if(padlockDamage <= 0.7):
		return "The padlock has a lot of damage."
	if(padlockDamage < 1.0):
		return "The padlock is barely holding."
	return "The padlock is broken."

func resetAllGear():
	removeStrapon(C_PC)
	removeStrapon(C_GIRL)
	removeBreastPump(C_COW)
	removePenisPump(C_BULL)
	removeBreastPump(C_PC)
	removePenisPump(C_PC)

func main_state():
	resetAllGear()
	if(!GM.pc.hasEffect(StatusEffect.PSMilkCafeProduction)):
		GM.pc.addEffect(StatusEffect.PSMilkCafeProduction)
	aimCamera(L_CENTER)
	playAnimation(StageScene.Solo, "stand")
	
	saynn("Вы — "+cowBullBoth("cow", "bull", "cow")+" рабыня, принадлежащая двум владельцам кафе. Они будут приходить доить тебя для получения "+cowBullBoth("milk", "seed", "milk and seed")+" дважды в день.")
	
	if(day <= 0):
		saynn("Сейчас вы стоите в полумраке подвального помещения, которое служит складом кафе. Большая часть света проникает из открытого сада. В углах установлено оборудование для дойки. Единственная дверь отсюда заперта. По ту сторону двери находится выключенная морозильная камера, разделенная на секции. Одна из этих секций — ваша камера. Помимо вас, здесь находятся еще две рабыни.")
	else:
		saynn("Вы стоите в полумраке подвального помещения, которое служит складом кафе.")
	
	sayn("День: "+str(day))
	sayn("Послушание: "+getObedienceText())#+" "+str(Util.roundF(obedience*100.0, 1))+"%")
	sayn("Доверие коровы: "+getCowTrustText())#+" "+str(Util.roundF(cowTrust*100.0, 1))+"%")
	sayn("Доверие быка: "+getBullTrustText())#+" "+str(Util.roundF(bullTrust*100.0, 1))+"%")
	if(getTreatAmount() > 0):
		sayn("Лакомства: "+str(getTreatAmount()))
	if(getShivAmount() > 0):
		sayn("Заточки: "+str(getShivAmount()))
	
	sayn("")
	
	if(idleState == IDLE_IDLE):
		sayn("У вас нет каких-то особых потребностей.")
		if(padlockDamage > 0.0):
			sayn("Дверь: "+getDoorDamageText())
		
		addAction("Graze", "Spend time on the field, chew some grass", "idleGraze")
		addAction("Hide in cell", "Hide in your cell", "idleCell")
		# If messy
		addAction("Wash", "Ask to be washed", "idleWash")
		if(GM.pc.getStamina() > 0):
			if(GM.pc.isBlindfolded()):
				addDisabledAction("Peek outside", "You can't see..")
			else:
				addAction("Peek outside", "Peek through the door's little window", "idlePeek")
		else:
			addDisabledAction("Peek outside", "The window is high so you need some stamina to reach it")
		if(peekState >= PEEK_NOTICED_PADLOCK):
			if(padlockDamage >= 1.0):
				if(cageRemoved && helpedMilka):
					addAction("Freedom!", "The door is pretty much open. You can leave!", "ENDING", ["end_breaklock"])
				else:
					addAction("Freedom!", "The door is pretty much open. You can leave", "endingLockCheck")
			elif(!GM.pc.hasBoundLegs()):
				if(GM.pc.getStamina() > 0):
					addAction("Kick door", "Smash the door to damage the padlock", "idleSmash")
				else:
					addDisabledAction("Kick door", "You don't have any stamina")
			else:
				addDisabledAction("Kick door", "Your legs are cuffed!")
		if(GM.pc.getInventory().hasRemovableRestraintsNoLockedSmartlocks()):
			if(GM.pc.getStamina() > 0):
				addAction("Struggle", "Try to struggle off the restraints", "idleStruggle")
			else:
				addDisabledAction("Struggle", "You don't have any stamina!")
		if(canHelpCage && !cageRemoved):
			if(GM.pc.hasBoundArms() || GM.pc.hasBlockedHands()):
				addDisabledAction("Bull's cage", "You can't do it with blocked hands")
			else:
				if(GM.pc.getStamina() <= 0):
					addDisabledAction("Bull's cage", "You don't have any stamina to do this")
				else:
					addAction("Bull's cage", "Help Pip with his chastity cage", "idleBullCage")
	if(idleState == IDLE_SOCIAL):
		saynn("Вам хочется пообщаться.")
		
		addAction("Cow", "Spend time with the cow", "talkCow")
		addAction("Bull", "Spend time with the bull", "talkBull")
		addAction("Annoy owners", "Make them regret buying you!", "talkAnnoy")
	if(idleState == IDLE_HUNGRY):
		saynn("Вы чувствуете голод.")
		
		addAction("Eat grass", "Go eat grass like a good livestock", "eatGrass")
		addAction("Starve", "You refuse to eat the grass", "eatStarve")
		addAction("Demand", "Demand the owners to be fed normal food", "eatDemand")
		if(getTreatAmount() > 0):
			addAction("Eat a treat!", "Eat one of your treats", "eatTreat")
		#addAction("Suck bull", "Feed on the bull's seed", "eatSuckBull")
	if(idleState == IDLE_NEEDY):
		saynn("Вам хочется заняться чем-нибудь пошлым.")
		
		addAction("Just chill", "Get some extra stamina", "needyRest")
		addAction("Complain", "Complain that you are extremely needy!", "needyComplain")
		addAction("Offer self", "Let the owners do whatever they want with you..", "needyOfferSelf")
		# Obedience check
		if(obedience < 0.4):
			addDisabledAction("Be milked", "You're not obedient enough to ask to be milked an extra time")
		else:
			if(GM.pc.getStamina() <= 0):
				addDisabledAction("Be milked", "You don't have enough stamina to be milked!")
			else:
				addAction("Be milked", "Ask the owners to milk you an extra time", "needyMilk")
		if(canHelpMilka && (getMilkaBreastSize() < BreastsSize.O)):
			if(GM.pc.hasBoundArms() || GM.pc.hasBlockedHands()):
				addDisabledAction("Milka's breasts", "You can't do it with blocked hands")
			else:
				if(GM.pc.getStamina() <= 0):
					addDisabledAction("Milka's breasts", "You don't have any stamina to do this")
				else:
					addAction("Milka's breasts", "Help Milka by applying special cream to her breasts", "idleCowBreasts")
		if(helpedMilka || canMilkOthers):
			if(GM.pc.getStamina() > 0):
				addAction("Milk Cow", "Help with milking the cow", "talkCowMilk")
			else:
				addDisabledAction("Milk Cow", "You don't have any stamina left")
		if(bullTrust > 0.5 || cageRemoved || canMilkOthers):
			if(GM.pc.getStamina() > 0):
				addAction("Milk Bull", "Help with milking the bull", "talkBullMilk")
			else:
				addDisabledAction("Milk Bull", "You don't have any stamina left")

func addContinueEventTrigger():
	addContinue("triggerEventMaybe")

func lateCheck() -> bool:
	if(GM.main.isVeryLate()):
		setState("sleep")
		return true
	return false

func triggerEventMaybe():
	resetAllGear()
	if(lateCheck()):
		return
	
	if(!gotMilkedNoon && GM.main.getTime() >= 11*60*60):
		gotMilkedNoon = true
		if(isGuyTurn):
			setState("about_to_be_milked_by_guy")
		else:
			setState("about_to_be_milked_by_girl")
		isGuyTurn = !isGuyTurn
		return
	if(!gotMilkedEvening && GM.main.getTime() >= 20*60*60):
		gotMilkedEvening = true
		if(isGuyTurn):
			setState("about_to_be_milked_by_guy")
		else:
			setState("about_to_be_milked_by_girl")
		isGuyTurn = !isGuyTurn
		return
	
	var possible:Array = []
	
	if(RNG.chance(70) && day >= 1):
		possible.append(["eOwnerMilkSlave", 10.0])
		possible.append(["eGirlBulliesSlave", 3.0])
		possible.append(["eGirlCattleProdCow", 2.0])
		possible.append(["eGirlCattleProdBull", 2.0])
		possible.append(["eEatAss", 1.0 if !GM.pc.isOralBlocked() else 3.0])
		possible.append(["eWannaCuddle", 2.0])
		possible.append(["eRandomStuff", 5.0])
		if(getTreatAmount() > 0):
			possible.append(["eCowSeesTreat", 4.0])
			possible.append(["eBullSeesTreat", 4.0])
		if(canHelpCage && !cageRemoved):
			possible.append(["eHelpCage", 4.0])
	
	if(!possible.empty()):
		var theEvent:String = RNG.pickWeightedPairs(possible)
		if(theEvent == lastEvent):
			theEvent = RNG.pickWeightedPairs(possible)
		if(theEvent == lastEvent):
			theEvent = RNG.pickWeightedPairs(possible)
		setState(theEvent)
		lastEvent = theEvent
	else:
		setState("main")

func addNextIdleStageButton():
	addContinue("nextIdle")

func main_do(_id:String, _args:Array):
	if(_id.begins_with("idle") || _id.begins_with("talk") || _id.begins_with("eat") || _id.begins_with("needy")):
		processTurn()
	if(_id == "idleGraze"):
		aimCamera(RNG.pick([L_FIELD, L_FIELD2, L_FIELD3]))
		saynn("Вы проводите время в саду, просто бродя вокруг.")
		saynn("Делать особо нечего... так что ты просто жуешь траву от скуки.")
		if(upgradeLevel >= UPGRADE_GRASS):
			addStamina(20)
			addPain(-20)
		else:
			addStamina(10)
			addPain(-10)
		
		if(obedience < 0.0 && RNG.chance(10.0 - 4.0*getShivAmount())):
			saynn("Во время прогулки ты находишь острый кусок дерева.")
			addShiv()
		
		var special:String = RNG.pickWeightedDict({
			"": 100.0, "guy": 20.0, "girl": 20.0, "cow": 10.0,
		})
		if(special == "guy"):
			saynn(RNG.pick([
				"Leo notices you while he is carrying some boxes around.",
				"Leo notices you while he is watering the garden.",
				"Leo notices you while he is harvesting some fruits from the garden.",
			]))
			if(obedience < -0.1):
				talk(C_GUY, RNG.pick([
					"You're a pretty naughty "+cowBull()+".",
					"Sofie isn't too happy with you.",
					"Don't do anything silly.",
					"You must be hungry. Maybe you should obey more.",
				]))
			else:
				talk(C_GUY, RNG.pick([
					"Such a good "+cowBull()+".",
					"Can I pat you?",
					"Don't mind me, keep grazing.",
					"You must be hungry.",
				]))
			addObedience(1)
		if(special == "girl"):
			saynn("Заходит Софи, чтобы проверить, как ты.")
			if(obedience < -0.1):
				talk(C_GIRL, RNG.pick([
					"I don't trust your bratty ass.",
					"The fuck are you doing here? Eating grass? Alright.",
					"Don't look at me like that, you dumb bitch.",
				]))
			else:
				talk(C_GIRL, RNG.pick([
					"Keep chewing, animal.",
					"Keep looking silly, animal.",
					"Keep chewing the grass, I need your "+cowBullBoth("milk", "seed", "milk")+".",
				]))
			addObedience(1)
		if(special == "cow" && cowTrust > 0.0):
			saynn("Ты натыкаешься на Милку, которая делает то же самое.")
			talk(C_COW, RNG.pick([
				"Moo..",
				"Moo!",
				"Moo?",
				"Moo? Moo!",
			]))
			addCowTrust(1.0)
		if(special == "bull" && bullTrust > 0.0):
			saynn("Ты натыкаешься на Пип, которая делает то же самое.")
			talk(C_BULL, RNG.pick([
				"The ceiling is too high.. can't reach.",
				"I tried digging.. there is just steel under the ground.",
				"If we find flint.. we might get a fire going.. but what's then?",
				"If we can find a stone big enough..",
			]))
			addBullTrust(1.0)
			
		addContinueEventTrigger()
	if(_id == "idleCell"):
		aimCamera(L_SLEEP)
		saynn("Ты прячешься в своей камере, подальше от всех.")
		if(upgradeLevel >= UPGRADE_CELLS):
			addStamina(50)
		else:
			addStamina(15)
		
		var special:String = RNG.pickWeightedDict({
			"": 60.0, "guy": 40.0, "girl": 20.0,
		})
		if(special == "guy"):
			saynn("Тебя находит Лео.")
			talk(C_GUY, RNG.pick([
				"Aw, c'mon. Don't be shy.",
				"I don't bite, you don't have to hide.",
				"Sofie is gonna be angry if she sees you here.",
				"You don't like this place? Sorry.",
				"I don't wanna tell Sofie..",
			]))
		if(special == "girl"):
			saynn("Софи находит тебя в камере и вытаскивает за шиворот.")
			addPain(10)
			if(obedience < -0.1):
				talk(C_GIRL, RNG.pick([
					"Eat grass, you dumb animal.",
					"No hiding, you dumb animal.",
					"Don't make me mad, you slut.",
					"You have a field if you want to rest, you dumb animal.",
				]))
			else:
				talk(C_GIRL, RNG.pick([
					"Eat the grass, what are you doing here?",
					"No hiding, you're an animal.",
					"Don't make me mad.",
					"You have a field if you want to rest.",
				]))
			addObedience(-2)
		addContinueEventTrigger()
	if(_id == "idleWash"):
		aimCamera(L_FIELD)
		GM.pc.clearBodyFluids()
		GM.pc.clearBodywritings()
		GM.pc.clearTallymarks()
		#GM.pc.afterTakingAShower()
		saynn("Ты просишь, чтобы тебя помыли.")
		
		if(RNG.chance(50)):
			saynn("Софи грубо хватает тебя за руку и прижимает к садовой стене. Не говоря ни слова, она направляет резкую струю холодной воды прямо тебе в спину и задницу, заставляя тебя вздрогнуть.")
			talk(C_GIRL, "Turn around.")
			saynn("Ты повинуешься, и она проводит струей по твоему телу тем же самым образом... ровно столько, чтобы отмыть тебя.")
		else:
			saynn("Лео выводит тебя на открытое поле. Держа в одной руке шланг, а в другой — губку, он осторожно поливает твоё тело водой, стараясь смыть каждую крупицу грязи... и прочего дерьма.")
			talk(C_GUY, "There we go. Much better, eh?")
		addContinueEventTrigger()
	if(_id == "idlePeek"):
		aimCamera(L_COUNTER)
		if(peekState == PEEK_START):
			saynn("Ты встаешь на цыпочки и заглядываешь в узкую щель окна в верхней части укрепленной двери.")
			addStamina(-10)
			saynn("Там грязно и туманно... а еще там так плотно, что ни один звук не может просочиться наружу.")
			saynn("Разглядеть многого трудно... стойка перекрывает большую часть обзора. Но ты видишь симпатичные столики с розовыми скатертями... широкие кресла, похожие на диваны... и несколько посетителей.")
			saynn("Ты машешь рукой, пытаясь привлечь внимание... но тебя никто не видит. Кто-нибудь должен помочь, им просто нужно тебя заметить...")
			saynn("Вскоре ты сдаешься.")
			saynn("Глядя сквозь узкую щель между дверью и рамой... ты замечаешь, что с той стороны висит [b]навесной замок[/b]. Ты не можешь до него дотянуться... но можешь попытаться выломать его с этой стороны.")
			saynn("Бык замечает тебя.")
			talk(C_BULL, "That is a very dumb idea.")
			saynn("Ты пожимаешь плечами.")
			talk(C_BULL, "Don't let me stop you though. This world was built on dumb ideas.")
			saynn("Софи приближается к двери, поэтому ты бросаешься наутек, пока еще есть возможность.")
			peekState = PEEK_NOTICED_PADLOCK
			peekTried = 0
			return
		peekTried += 1
		saynn("Ты встаешь на цыпочки и заглядываешь в маленькое окошко.")
		addStamina(-10)
		
		saynn(RNG.pick([
			"Sofie's back blocks the view completely, she is standing behind the counter. You can't see anything past her.",
			"There are a few customers around.. But all of them are sitting behind the tables, casually chatting with each other or staring into their datapads. If only any of them would look your way..",
			"You see Leo working as a waiter, serving tables. Sofie is preparing a meal for someone. Could be a fly-through, you don't see anyone sitting behind the tables.",
			"All of the tables seem to be empty, no customers around.",
			"You notice pure void of space behind the cafe's reinforced glass panels.. Even if you escape, where are you gonna go..",
			"There are some customers so you do your best to get their attention, waving and tapping.",
		]))
	
		if(peekState == PEEK_NOTICED_PADLOCK && RNG.chance(-50+peekTried*40)):
			peekTried = 0
			peekState = PEEK_NOTICED_CUSTOMER
			playAnimation(StageScene.Solo, "stand", {pc=C_OFFICER})
			saynn("Ты уже собиралась сдаться... но тут вдруг [b]замечаешь кого-то[/b]...")
			saynn("На нем шикарная одежда... и, надо сказать, чертовски обаятельная улыбка. Ну и волк.")
			saynn("Ты подпрыгиваешь и машешь ему рукой... но он слишком быстро отворачивается. И вскоре уходит.")
			return
		elif(peekState == PEEK_NOTICED_CUSTOMER && RNG.chance(-30+peekTried*50)):
			peekTried = 0
			peekState = PEEK_NOTICED_BY_CUSTOMER
			playAnimation(StageScene.Solo, "stand", {pc=C_OFFICER})
			saynn("Ты уже собиралась сдаться... но тут ты снова [b]замечаешь его[/b]!")
			saynn("Это тот самый щеголеватый волк, которого ты видела на днях. Он занят заказом.")
			saynn("Это твой шанс! Ты машешь и прыгаешь, пытаясь привлечь его внимание...")
			saynn("Волк заканчивает делать заказ... и бросает быстрый взгляд на твою дверь.")
			talk(C_PC, "C'mon, notice me! I'm here!")
			saynn("Его брови едва заметно дергаются... но разобрать что-то точно невозможно.")
			saynn("Софи отдает ему заказ... и он уходит. Блядь, почти получилось...")
			return
		elif(peekState == PEEK_NOTICED_BY_CUSTOMER && RNG.chance(-20+peekTried*50)):
			peekTried = 0
			peekState = PEEK_BULLIED_BY_GIRL
			playAnimation(StageScene.Solo, "stand", {pc=C_OFFICER})
			saynn("Ты видишь [b]его[/b]! Он вернулся, чтобы сделать заказ.")
			saynn("На этот раз тебе даже не нужно махать рукой... он смотрит через плечо Софи прямо на твою дверь.")
			saynn("Ты видишь, как он что-то говорит девчонке... что-то, что заставляет её вздрогнуть. О черт.")
			addContinue("setState", ["pEventBullyByGirl"])
			return
		elif(peekState == PEEK_BULLIED_BY_GIRL && RNG.chance(-10+peekTried*60) && !gonnaHavePeekEvent):
			peekTried = 0
			gonnaHavePeekEvent = true
			peekState = PEEK_FIRST_EVENT_HAPPENED
			playAnimation(StageScene.Solo, "stand", {pc=C_OFFICER})
			saynn("Ты видишь [b]его[/b]!")
			saynn("Какая разница, что там вякнула эта сучка... ты машешь руками, привлекая его внимание. Кажется, сработало!")
			saynn("Волк едва заметно улыбается... но на этом всё. Хм...")
			saynn("Он заканчивает делать заказ... забирает его... и просто уходит.")
			saynn("Может быть... может быть, всё это бессмысленно. Может, ты уже ничего не можешь изменить...")
			return
		elif(peekState == PEEK_FIRST_EVENT_HAPPENED && RNG.chance(-30+peekTried*100) && !gonnaHavePeekEvent):
			peekTried = 0
			gonnaHavePeekEvent = true
			peekState = PEEK_SECOND_EVENT_HAPPENED
			playAnimation(StageScene.Solo, "stand", {pc=C_OFFICER})
			saynn("Ты видишь [b]его[/b]! Это офицер.")
			saynn("Он смотрит на тебя... и расплывается в знакомой улыбке.")
			saynn("Это значит, что сегодня он, скорее всего, будет в ночную смену... как и ты.")
			return
		elif(peekState == PEEK_SECOND_EVENT_HAPPENED && RNG.chance(min(-40+peekTried*60, 50.0)) && !gonnaHavePeekEvent):
			peekTried = 0
			gonnaHavePeekEvent = true
			peekState = PEEK_THIRD_EVENT_HAPPENED
			playAnimation(StageScene.Solo, "stand", {pc=C_OFFICER})
			saynn("Ты видишь [b]его[/b]! Это офицер.")
			saynn("Он смотрит на тебя... и расплывается в знакомой улыбке.")
			saynn("Это значит, что сегодня он, скорее всего, будет в ночную смену... как и ты.")
			return
		
		var special:String = RNG.pickWeightedDict({
			"": 100.0, "guy": 10.0, "girl": 10.0,
		})
		if(special == "guy"):
			playAnimation(StageScene.Duo, "stand", {npc=C_GUY})
			saynn("Лео внезапно входит в дверь.")
			talk(C_GUY, "Excuse me, coming through.")
			saynn("Он почти проходит мимо тебя... но вдруг замирает.")
			talk(C_GUY, RNG.pick([
				"Wait. Step away from the door please.",
				"Hm. Don't touch this door please.",
				"You shouldn't mess with this door or Sofie is gonna be angry.",
				"Wait. What are you doing here?"
			]))
			addObedience(-1)
		if(special == "girl"):
			playAnimation(StageScene.Duo, "defeat", {npc=C_GIRL})
			saynn("Дверь бьет тебя прямо по носу — это Софи резко распахнула её!")
			addPain(20)
			talk(C_GIRL, RNG.pick([
				"Why are you so dumb? Don't make me punish you.",
				"Really? Get away from the door or I will hurt you.",
				"Get away from the door, dumb animal.",
				"Back off, you stupid "+cowBull()+".",
			]))
			addObedience(-1)
		
		saynn("Если не прекратишь, [b]кто-нибудь обязательно тебя заметит.[/b]")
		
		addContinueEventTrigger()
	if(_id == "endingLockCheck"):
		setState("failedlockescape")
		padlockDamage = 0.8
		
	if(_id == "idleSmash"):
		aimCamera(L_DOOR)
		
		saynn("Ты выжидаешь подходящий момент и бьешь по двери!")
		addStamina(-30)
		
		addPadlockDamage(RNG.randf_range(1.0, 3.0))
		
		if(cageRemoved):
			saynn("Пип присоединяется и тоже наносит мощный удар копытами!")
			addPadlockDamage(RNG.randf_range(1.0, 3.0))
		
		if(padlockDamage >= 1.0):
			saynn("[b]Замок сломан![/b] Но сейчас времени на что-то еще просто нет.")
		
		if(RNG.chance(30.0 - 10.0*getShivAmount())):
			saynn("От двери отлетает маленький щеп — довольно острый кусок дерева.")
			addShiv()
		
		var special:String = RNG.pickWeightedDict({
			"": 100.0, "guy": 10.0, "cuffs": 10.0,
		})
		if(special == "guy"):
			playAnimation(StageScene.Duo, "stand", {npc=C_GUY})
			saynn("Спустя несколько секунд выходит Лео.")
			talk(C_GUY, RNG.pick([
				"Hey. Uh. Can you stop?",
				"Don't touch this door.",
				"Keep away from this door please.",
			]))
			saynn("По крайней мере, тебе удалось выбраться без проблем.")
			addObedience(-1)
		if(special == "girl"):
			if(RNG.chance(10.0 - obedience*20.0)):
				saynn("Спустя мгновение Софи открывает дверь и хватает тебя.")
				talk(C_GIRL, RNG.pick([
					"That was dumb.",
					"Alright, you're getting it!",
					"Fine, you're getting it.",
					"Fine, you want a punishment?",
					"Asking for a punishment, whore.",
				]))
				bullyScene(C_PC)
				addObedience(-2)
			else:
				playAnimation(StageScene.Duo, "defeat", {npc=C_GIRL})
				saynn("Спустя мгновение Софи распахивает дверь и швыряет тебя на пол.")
				addPain(5)
				talk(C_GIRL, RNG.pick([
					"Stop doing that, you stupid whore.",
					"Don't touch this door, you dumb bitch.",
					"Don't touch this door or you will regret it.",
					"I will make sure it hurts more next time.",
				]))
				addObedience(-2)
			if(RNG.chance(100.0 - obedience*70.0)):
				saynn("Она достает наручники и застегивает их на твоих лодыжках!")
				GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("inmateanklecuffs"))
		
		addContinueEventTrigger()
	if(_id == "idleCowBreasts"):
		aimCamera(L_COW)
		playAnimation(StageScene.BreastGroping, "grope", {pc="pc", npc="psmilka"})
		
		milkaExtraBreastSize += 2
		updateCharacters()
		
		saynn(RNG.pick([
			"You grab the cream tube from Milka's hands and begin to carefully apply it all around her breasts and nipples.",
		]))
		addStamina(-20)
		talk(C_COW, RNG.pick([
			"Ohh, feels funny!",
			"Feels nice..",
			"I can feel something already..",
			"Thank you for helping!",
		]))
		saynn("Процесс занимает немало времени, так что вы успеваете немного поболтать.")
		addCowTrust(1)
		sayMilkaLine()
		saynn(RNG.pick([
			"Eventually, you notice Milka's breasts getting fuller and rounder! They clearly got bigger.",
		]))
		if(milkaExtraBreastSize > 5 && !helpedMilka):
			helpedMilka = true
			talk(C_COW, RNG.pick([
				"Thank you, thank you, thank you! My titties look so much better now! I can make so much milk~.",
			]))
			saynn("Похоже, Милка довольна таким размером... но трубка еще не пуста.")
			talk(C_COW, "You can apply it more if you want.. But I just feel bad for taking up so much of your time.. Can I give back?")
			addCowTrust(5)
			addAction("It's okay", "You are happy that you helped Milka and that's all that you needed", "setState", ["main"])
			addAction("Breastfeed", "Feed on Milka's breasts!", "milkaRewardBreastfeed")
			addAction("Breed her", "Fuck Milka with your cock or a strapon!", "milkaRewardBreed")
		
		elif(GM.pc.getBreastsSize() < BreastsSize.O):
			talk(C_COW, RNG.pick([
				"Ah.. Thank you! I can use it on you too if you want!",
			]))
			saynn("Ты читаешь мелкий шрифт на тюбике. Там сказано, что изменения происходят мгновенно и навсегда.")
		
			addContinueEventTrigger()
			addAction("Your breasts", "Allow Milka to use the cream on your breasts, making them bigger!", "milkaUseCreamOnPC")
		else:
			talk(C_COW, RNG.pick([
				"Ah.. I'm a better cow now.",
			]))
			addContinueEventTrigger()
	if(_id == "milkaUseCreamOnPC"):
		playAnimation(StageScene.BreastGroping, "grope", {pc="psmilka", npc="pc", npcBodyState={hard=true}})
		saynn("Ты соглашаешься, позволяя Милке нанести специальный крем на твой {pc.breasts}.")
		saynn("Это всё еще занимает какое-то время, так что вы продолжаете болтать.")
		var theBreasts:BodypartBreasts = GM.pc.getBodypart(BodypartSlot.Breasts)
		if(theBreasts):
			theBreasts.size += 1
			theBreasts.processTime(0)
		sayMilkaLine()
		saynn("В конце концов ты начинаешь чувствовать, как в груди всё подергивается! С губ срывается легкий вздох, когда ты ощущаешь, как твоя грудь становится всё больше и больше!")
		talk(C_COW, "There we go!")
		addContinueEventTrigger()
	if(_id == "milkaRewardBreed"):
		playAnimation(StageScene.SexMatingPress, "fast", {pc="pc", npc="psmilka", pcCum=true, bodyState={hard=true,naked=true}})
		var _withStrapon:bool = addStrapon(C_PC, C_BULL)
		
		if(!_withStrapon):
			saynn("Да, глядя на раскрасневшееся лицо Милки и её мягкое, жаждущее тело... тебя посещает безумная идея. Ты осторожно прижимаешь её к полу.")
			talk(C_PC, "Let's see how you take it, Milka.")
			saynn("Она ахает, её ушки дергаются, а хвостик подрагивает, когда ты хватаешь её за бедра и разводишь их широко.")
			talk(C_COW, "moo~?..")
			saynn("Ты высоко задираешь её ноги, прижимая их к самым плечам. Её влажная киска блестит, пока ты прицеливаешься своим твердым членом к её жаждущему входу.")
			saynn("Резким толчком ты входишь глубоко в её щель, заставляя Милку издать отчаянный стон.")
			talk(C_COW, "Ahhh~! Mooo~..")
			saynn("Твои бедра с силой впечатываются в её бедра, твой {pc.penis} методично и грубо вколачивается в её киску. Её огромная молочная грудь подпрыгивает при каждом толчке, а соски уже подтекают каплями молока с ароматом клубники.")
			talk(C_PC, "That's it.. take it, cowgirl.")
			saynn("Ты крепче сжимаешь её ноги и ускоряешься, вбиваясь в её киску; головка твоего члена давит на самые чувствительные точки, пока она извивается под тобой.")
			talk(C_COW, "Ahhh.. ahhh.. moo~.. it’s too much!")
			saynn("Тело Милки выгибается дугой, её грудь трясется и брызжет молоком, а киска сжимается вокруг тебя от мощного оргазма. Ты чувствуешь, как её стенки доят твой член, заставляя тебя самого вот-вот кончить.")
			talk(C_PC, "Nghhh..")
			saynn("Последним глубоким толчком ты зарываешься в неё до самого основания и начинаешь заливать её утробу своим горячим семенем. Густые струи {pc.cum} наполняют её, смешиваясь с её соками.")
			saynn("Милка вскрикивает от наслаждения, её соски брызжут еще большим количеством сладкого молока, пока её тело дрожит под тобой, а хвост плотно сворачивается кольцом.")
			talk(C_COW, "Mmmhh~.. s-so warm.. moo..")
			saynn("Ты остаешься внутри нее на несколько мгновений, тяжело дыша, прежде чем наконец выскользнуть наружу. Смесь спермы и молока стекает с нее, пока она лежит, удовлетворенная и сияющая.")
			talk(C_PC, "Good girl.")
			talk(C_COW, "Thank you.. for filling me.. ahh..")
			saynn("Ты садишься рядом, немного отдыхая и перебирая ее волосы.")
		else:
			saynn("Да, глядя на раскрасневшееся лицо Милки и ее мягкое, жаждущее тело... тебя посещает безумная идея. Ты осторожно укладываешь ее на пол и идешь к полке с доильным оборудованием, чтобы схватить один из ремней для страпона.")
			talk(C_PC, "Let's see how you take it, Milka.")
			saynn("Она ахает, её ушки дергаются, а хвостик подрагивает, когда ты хватаешь её за бедра и разводишь их широко.")
			talk(C_COW, "moo~?..")
			saynn("Прежде чем залезть на нее сверху, ты плотно закрепляешь ремень на талии.")
			saynn("Затем ты высоко задираешь ноги Милки, прижимая их к ее плечам, пока скользкий кончик твоего смазанного игрушки прижимается к ее влажному входу.")
			talk(C_PC, "Ready to be bred, cowgirl?")
			saynn("Плавным, но мощным толчком ты входишь глубоко в ее щель, заставляя Милку издать отчаянный стон.")
			talk(C_COW, "Ahhh~! Mooo~..")
			saynn("Твои бедра впечатываются в ее бедра, страпон методично и грубо долбит ее киску. Ее пышная молочная грудь подпрыгивает при каждом движении, а соски источают сладкое молоко с ароматом клубники.")
			talk(C_PC, "That's it.. take it, cowgirl.")
			saynn("Ты крепче сжимаешь ее ноги и ускоряешься, вколачивая игрушку в ее щель; ее кончик задевает самые чувствительные точки, пока она не начинает извиваться под тобой.")
			talk(C_COW, "Ahhh.. ahhh.. moo~.. it’s too much!")
			saynn("Тело Милки выгибается дугой, грудь дрожит и брызжет молоком, а ее киска судорожно сжимает ствол игрушки от мощного оргазма. Внезапный спазм активирует скрытый механизм в страпоне.")
			saynn("С едва слышным гулом игрушка начинает закачивать теплое семя глубоко в ее матку, выпуская густые струи жидкости, похожей на сперму, которая смешивается с ее соками.")
			saynn("Милка громко стонет, её соски брызжут всё большим количеством сладкого молока, а её тело дрожит под тобой, и хвост плотно сворачивается кольцом, когда ты наполняешь её.")
			talk(C_COW, "Mmmhh~.. s-so warm.. moo..")
			saynn("Ты на мгновение оставляешь страпон внутри неё, наблюдая за тем, как вздымается и опускается её грудь, прежде чем медленно вытащить его. Смесь спермы и молока капает из её киски, пока она лежит перед тобой, сияющая и удовлетворенная.")
			talk(C_PC, "Good girl.")
			talk(C_COW, "Thank you.. for filling me.. ahh..")
			saynn("Ты садишься рядом, немного отдыхая и перебирая ее волосы.")
		
		if(_withStrapon):
			GlobalRegistry.getCharacter(C_COW).cummedInVaginaBy(C_PC, FluidSource.Strapon)
		else:
			GlobalRegistry.getCharacter(C_COW).cummedInVaginaBy(C_PC)
		GM.pc.orgasmFrom(C_COW)
		
		addContinue("setState", ["main"])
		
	if(_id == "milkaRewardBreastfeed"):
		playAnimation(StageScene.BreastFeeding, "feed", {pc="psmilka", npc="pc"})
		
		saynn("Да, глядя на новую грудь Милки... у тебя появляется идея. Ты опускаешься перед ней на колени и тянешь руки к её новым прекрасным пышным холмикам.")
		talk(C_PC, "Mind if I taste them?")
		saynn("Милка краснеет, её ушки приподнимаются. Она разводит ноги и отклоняет торс назад, подставляя тебе свою тяжелую грудь, чтобы ты мог с ней поиграть.")
		talk(C_COW, "Moo~. Anything for you, sweet friend.")
		saynn("Наклонившись, ты обхватываешь губами один набухший сосок, осторожно сжимая его зубами.")
		saynn("Теплое, сладкое молоко брызжет тебе в рот, на вкус как свежая клубника. Твоя рука обхватывает другую грудь, ощупывая и разминая её тяжелую форму.")
		talk(C_COW, "Ah..")
		saynn("Милка вздрагивает, её хвост виляет, а сама она тихо стонет. Ты переходишь на другую грудь, насаживаясь на другой сосок и жадно сосая его, выманивая новую струю молочной сладости.")
		saynn("Твои пальцы разминают и щипают, играя с её затвердевшими сосками, пока они выпускают всё больше и больше этого вкусного клубничного молока тебе в рот.")
		talk(C_COW, "Ah.. more.. yes.. moo..")
		saynn("Каждый глоток заставляет её тело содрогаться. Она запрокидывает голову и издает всё более ободряющие стоны, а её киска с каждой секундой становится всё влажнее.")
		talk(C_COW, "Mmhh.. ahh-hh~..")
		saynn("Серия быстрых конвульсий сотрясает её тело; её жаждущая щель пульсирует, а соски брызжут новой порцией этого вкусного нектара.")
		saynn("Осушив обе груди, ты откидываешься назад, слизывая капли с губ. Милка удовлетворенно вздыхает, ее глаза полуприкрыты от наслаждения.")
		talk(C_PC, "Your milk tastes nice.")
		talk(C_COW, "Thank you.. for making me feel so.. good.")
		saynn("Вы сидите вместе в теплом сиянии; ее грудь вздымается и опускается, пока она пытается восстановить дыхание.")
		
		GlobalRegistry.getCharacter(C_COW).milk()
		
		addPain(-100)
		addStamina(100)
		addContinue("setState", ["main"])
	
	if(_id == "idleBullCage"):
		aimCamera(L_BULL)
		playAnimation(StageScene.ChairOral, "rub", {pc="pspip", npc="pc"})
		
		saynn(RNG.pick([
			"You inspect Pip's chastity cage and try to wiggle it off.",
			"You grip the base of Pip's cage and give it a firm twist, trying to loosen its hold on his sheath.",
			"You slide your nail into the lock of Pip's chastity cage and try to turn it.",
			"You find a little rock in the garden and start to carefully hit the lock of Pip's chastity cage.",
			"You sharpen a twig that you have found in the garden and try to use it as a lockpick inside Pip's chastity cage.",
			"You get a good grip on the metal pieces of Pip's chastity cage and use your full strength to try to bend them.",
		]))
		cageDamage += RNG.randf_range(0.2, 0.3)
		addStamina(-20)
		addBullTrust(1)
		
		sayPipLine()
		
		if(cageDamage >= 1.0):
			saynn("Чудо! Тебе [b]удалось взломать замок[/b]! Его обломки рассыпаются по полу.")
			talk(C_BULL, "Ah..")
			saynn("Ты осторожно начинаешь тянуть за саму клетку, пытаясь снять ее... но что-то все еще мешает. Пульсирующий член Пипа отчаянно пытается встать колом.")
			talk(C_BULL, "Fuck.. Really? How the fuck is it still stuck. I'm just destined to stay a femboy fucktoy, aren't I?")
			saynn("Ты уже почти готов сдаться... но замечаешь, как зажатый конский член Пипа всё сильнее разгибает металл, пытаясь достичь эрекции.")
			saynn("Если не получается снять клетку самому... может, заставить его член сделать это, раззадорив парня еще сильнее?")
			
			addAction("Tease", "Keep teasing him about the chastity cage", "cageTeaseUnlock")
			addAction("Anal", "Fuck his ass (or peg him with a strapon) to try to help him!", "cageAnalFuck")
			#addAction("Sit on face", "Sit on his face to try to get him hard enough!", "cageSitOnFace")
			return
		#	cageRemoved = true
		#	updateCharacters()
		else:
			if(cageDamage < 0.35):
				saynn("Почти ничего не изменилось. Нужно продолжать попытки.")
			elif(cageDamage < 0.7):
				saynn("Клетка поддается, ты это чувствуешь. С каждой попыткой она все сильнее шатается.")
			else:
				saynn("Кажется, клетка вот-вот лопнет. Ты уже почти у цели.")
		addContinueEventTrigger()
	if(_id == "cageAnalFuck"):
		cageRemoved = true
		updateCharacters()
		var _wornStrapon:bool = addStrapon(C_PC)
		playAnimation(StageScene.SexLowDoggy, "fast", {pc="pc", npc="pspip", pcCum=true, npcCum=true, bodyState={hard=true}, npcBodyState={hard=true}})

		if(!_wornStrapon):
			saynn("Ты решаешь помочь ему. Резким движением ты швыряешь Пипа на пол, заставляя его лечь животом вниз, а задницей вверх.")
			talk(C_PC, "Let's try this, stud.")
			saynn("Глаза Пипа расширяются, когда ты прижимаешь свой твердый член к его влажному, дрожащему анусу.")
			talk(C_BULL, "W-wait.. what are you..")
			saynn("Ты хватаешь его за бедра, приподнимая их ровно настолько, чтобы идеально выровняться. Его хвост хлещет из стороны в сторону, пока ты дразнишь его отверстие кончиком члена.")
			talk(C_PC, "Relax.. you love this, don't you?")
			saynn("Одним плавным толчком ты глубоко входишь в тугой анус Пипа. Он ахает, выгибая спину, а его запертая клетка с грохотом бьется о пол.")
			saynn("Твой член входит и выходит, массируя его простату. Каждый твой толчок вырывает из него милые стоны.")
			talk(C_BULL, "Ahh.. f-fuck.. so rough..")
			saynn("Ты не даешь ему времени осознать происходящее, наращивая темп. Твоя рука вцепляется в его волосы и резко тянет их назад.")
			saynn("Предэякулят капает с кончика клетки, пока его задница сжимается вокруг тебя, а напряжение нарастает до почти невыносимого предела.")
			talk(C_PC, "That’s it.. be a good girl and cum for me.")
			saynn("Член Пипа бешено дергается, клетка гнется под напором. Одним финальным, мощным толчком его [b]член вырывается на свободу[/b], прутья его клетки разлетаются в щепки от невероятной силы эрекции!")
			saynn("Освободившись, его раздутый лошадиный член за секунды становится каменным, а затем взрывается густым, мощным потоком семени!")
			saynn("Густые струи спермы разлетаются по всему полу, пока Пип стонет от блаженства, а его тело сотрясает сильная дрожь, пока ты наполняешь его задницу своей тягучей жидкостью.")
			talk(C_BULL, "F-fuck! Ah! Ahhh-h!..")
			talk(C_PC, "Holy shit, it worked.")
			saynn("Даже хозяева приходят проверить, из-за чего поднялся такой шум.")
			talk(C_GIRL, "What the hell is going on out here?")
			talk(C_GUY, "Looks like they found a way to take off the cage.")
			talk(C_GIRL, "Could have put a bucket under him at least, fuck.")
			saynn("Они могли бы порадоваться этому сильнее... но что ж. По крайней мере, Пип, похоже, в восторге.")
			talk(C_BULL, "T-thank you.. hh-hh..")
			saynn("Ты улыбаешься, глядя на изнеможденное тело Пипа, а твоя грудь мерно вздымается от чувства удовлетворения.")
		else:
			saynn("Ты решаешь помочь ему. Сначала ты идешь к складу доильного оборудования, берешь страпон, закрепляешь его на бедрах и густо смазываешь резиновый ствол лубрикантом.")
			saynn("Затем уверенным движением ты швыряешь Пипа на пол, заставляя его лечь на живот, выставив задницу вверх.")
			talk(C_PC, "Let's try this, stud.")
			saynn("Глаза Пипа расширяются, когда ты прижимаешь свой новый резиновый член к его влажному, дрожащему анусу.")
			talk(C_BULL, "W-wait.. what are you..")
			saynn("Ты хватаешь его за бедра, приподнимая их ровно настолько, чтобы идеально выровняться. Его хвост хлещет из стороны в сторону, пока ты дразнишь его отверстие кончиком члена.")
			talk(C_PC, "Relax.. you love this, don't you?")
			saynn("Одним плавным толчком ты вгоняешь страпон глубоко в тугой анус Пипа. Он ахает, выгибая спину.")
			saynn("Твой резиновый член входит и выходит, массируя его простату. Каждый твой толчок вырывает из него милые стоны.")
			talk(C_BULL, "Ahh.. f-fuck.. so rough..")
			saynn("Ты не даешь ему времени осознать происходящее, наращивая темп. Одной рукой ты хватаешь его за волосы и резко тянешь назад, пока вбиваешься в него.")
			saynn("Предэякулят капает с кончика его запертой клетки, пока его задница сжимается вокруг твоей игрушки, а напряжение нарастает до почти невыносимого предела.")
			talk(C_PC, "That’s it.. be a good girl and cum for me.")
			saynn("Член Пипа бешено дергается внутри клетки, металл гнется под напором. Одним финальным, мощным толчком бедер ты заставляешь его [b]клетку лопнуть[/b] от неистовой силы его эрекции!")
			saynn("Освободившись, его раздутый лошадиный член за секунды становится каменным, а затем взрывается густым, мощным потоком семени!")
			saynn("Густые струи коньяка заливают пол, пока Пип блаженно стонет, содрогаясь всем телом.")
			talk(C_BULL, "F-fuck! Ah! Ahhh-h!..")
			talk(C_PC, "Holy shit, it worked.")
			saynn("Даже хозяева приходят проверить, из-за чего поднялся такой шум.")
			talk(C_GIRL, "What the hell is going on out here?")
			talk(C_GUY, "Looks like they found a way to take off the cage.")
			talk(C_GIRL, "Could have put a bucket under him at least, fuck.")
			saynn("Они могли бы порадоваться этому сильнее... но что ж. По крайней мере, Пип, похоже, в восторге.")
			talk(C_BULL, "T-thank you.. hh-hh..")
			saynn("Ты улыбаешься, глядя на изнеможденное тело Пипа, а твоя грудь мерно вздымается от чувства удовлетворения.")
		
		GlobalRegistry.getCharacter(C_BULL).cummedInAnusBy(C_PC)
		GM.pc.orgasmFrom(C_BULL)
		addBullTrust(5)
		addContinue("setState", ["main"])
		
	if(_id == "cageTeaseUnlock"):
		cageRemoved = true
		updateCharacters()
		playAnimation(StageScene.ChairOral, "tease", {pc="pspip", npc="pc", pcCum=true, bodyState={hard=true}})
		
		saynn("Пора ему помочь. Ты перестаешь возиться с его клеткой и просто смотришь на него снизу вверх.")
		talk(C_PC, "I guess you are right.")
		saynn("Он наклоняет голову.")
		talk(C_BULL, "Huh?")
		talk(C_PC, "I guess you are destined to be someone's slut.")
		saynn("Пип вздыхает... ты замечаешь, как его запертый член слегка дергается.")
		talk(C_PC, "It's not that bad. I'm sure you will grow to like it.")
		talk(C_BULL, "What do you mean?")
		talk(C_PC, "You love cumming from your prostate getting smashed already, don't you?")
		saynn("Он хмурится... но член дергается еще сильнее, создавая дополнительное давление на клетку.")
		talk(C_BULL, "I'm a stud!")
		talk(C_PC, "Just face it. Your cock is locked away forever. It's no better than a clit. You're a girl, not a stud.")
		saynn("Предэякулят течет из кончика клетки. Пип сильно ерзает, а его пульсирующая попытка эрекции все сильнее гнет металл!")
		talk(C_BULL, "H-hey, d-don't say that.")
		talk(C_PC, "Your clitty is dripping, slut. You love it, admit it. You love getting fucked like a girl.")
		saynn("Внезапно с громким звоном верхняя часть его клетки отлетает, мгновенно обнажая твердый, расширенный у основания мясной конский член. Ого.")
		talk(C_BULL, "Ahh-h-h!..")
		saynn("Пип видит это и ахает, вцепляясь в стул, пока его член все еще пульсирует... как вдруг из него вырывается густая, мощная порция семени! Струя за струей конь летит по воздуху красивыми дугами, пока он стонет как шлюха, не в силах унять дрожь во всем теле, откинув голову назад.")
		talk(C_PC, "Holy shit, it worked.")
		talk(C_BULL, "Mhh-h.. ah.. ghh-h.. ah-hh..")
		saynn("Даже хозяева приходят проверить, из-за чего поднялся такой шум.")
		talk(C_GIRL, "Really? You've hit pure oil and your lazy ass couldn't put a bucket under that stream?")
		talk(C_GUY, "But at least his cage is off, Sofie. Milking him is gonna be easier.")
		saynn("Софи ворчит и уходит.")
		talk(C_BULL, "Shit.. so much. T-thank you..")
		saynn("Ты улыбаешься и киваешь.")
		addBullTrust(5)
		addContinue("setState", ["main"])
	
	if(_id == "idleStruggle"):
		var struggleData:Dictionary = GM.pc.doStruggleOutOfRestraints(false, false, null, 5.0)
		if(struggleData.empty()):
			return
		var text:String = struggleData["text"] if struggleData.has("text") else "[color=red]ERROR? No struggle text provided[/color]"
		saynn(text)
		
		if(struggleData.has("animation")):
			playAnimation(StageScene.Solo, struggleData["animation"])
		if(struggleData.has("lust") && struggleData["lust"] > 0):
			GM.pc.addLust(struggleData["lust"])
		if(struggleData.has("pain") && struggleData["pain"] > 0):
			addPain(struggleData["pain"])
		addStamina(-30)
		#if(struggleData.has("stamina") && struggleData["stamina"] != 0):
		#	sub.addStamina(-struggleData["stamina"])
		
		addContinueEventTrigger()

	if(_id == "talkCow"):
		playAnimation(StageScene.Duo, "stand", {npc=C_COW})
		aimCamera(L_COW)
		saynn("Ты проводишь некоторое время, зависая с коровой.")
		addCowTrust(1)
		sayMilkaLine()
		
		if(cowTrust >= 0.1 && !canHelpMilka):
			canHelpMilka = true
			saynn("Прежде чем ты уйдешь...")
			talk(C_COW, "OH!")
			saynn("Ты останавливаешься и наблюдаешь, как она достает какой-то... тюбик с кремом.")
			talk(C_COW, "The owner bought it for me. But he is too busy running the cafe to apply it.")
			saynn("Ты читаешь состав... эстроген, пролактин... судя по всему, этот крем должен стимулировать лактацию. Его нужно наносить прямо на грудь.")
			talk(C_COW, "I'm too afraid to use it myself, I'm just a cow!")
		elif(helpedMilka):
			saynn("Вы еще немного болтаете.")
			sayMilkaLine()
		
		addContinueEventTrigger()
	if(_id == "talkBull"):
		playAnimation(StageScene.Duo, "stand", {npc=C_BULL})
		aimCamera(L_BULL)
		saynn("Ты проводишь некоторое время, зависая с быком.")
		addBullTrust(1)
		sayPipLine()
		
		if(bullTrust >= 0.1 && !canHelpCage):
			canHelpCage = true
			saynn("Перед твоим уходом он показывает тебе свою девственную клетку. Его запертый член сильно пульсирует внутри своей тесной маленькой тюрьмы.")
			talk(C_BULL, "It's been there for at least a few months. I'm fucking desperate. Maybe you can try to do something? If you have the time.")
			saynn("Бык в клетке — это как-то неправильно. С другой стороны, возможно, такова его судьба.")
		elif(cageRemoved):
			saynn("Вы еще немного болтаете.")
			sayPipLine()
		
		addContinueEventTrigger()
	if(_id == "talkAnnoy"):
		saynn(RNG.pick([
			"You bang on the door to annoy your owners.",
			"You annoy the owners while they get something from their little garden.",
			"You annoy the owners while they check on the bull and the cow.",
			"You annoy the owners while they are busy washing the other livestock.",
		]))
		addObedience(-3)
		var special:String = RNG.pickWeightedDict({
			"nothing": 5.0,
			"treat": 5.0 if getTreatAmount() <= 1 else 1.0,
			"bully": 2.0 - obedience*3.0,
			"shiv": 2.0 - getShivAmount()*0.5,
		})
		if(special == "treat"):
			playAnimation(StageScene.Duo, "stand", {npc=C_GUY})
			saynn("Лео подходит к тебе.")
			talk(C_GUY, "Sofie really doesn't like that you're making so much noise.")
			saynn("Его рука достает ломтик яблока.")
			talk(C_GUY, "If I give you a treat, will you behave?")
			saynn("Ты киваешь, это очевидно. Парень протягивает тебе угощение.")
			addTreat(1)
		if(special == "bully"):
			saynn("Софи дико бесится из-за тебя.")
			talk(C_GIRL, RNG.pick([
				"SHUT UP, BITCH.",
				"YOU ARE SUCH A WHINY BITCH.",
				"YOU WANT MY ATTENTION? YOU GOT IT, WHORE.",
			]))
			bullyScene(C_PC)
		if(special == "shiv"):
			if(bullTopic <= 0):
				saynn("После этого трюка к тебе подходит один из других рабов.")
				talk(C_BULL, "Hey.. you don't know me.. but I think this might be more useful to you than me.")
				saynn("Он протягивает тебе заточенный камень... его можно использовать как оружие.")
				
			else:
				saynn("После этого трюка к тебе подходит Пип.")
				talk(C_BULL, "Hey.. I think this might be more useful to you than me.")
				saynn("Он протягивает тебе заточенный камень... его можно использовать как оружие.")
			addShiv()
		
		addContinueEventTrigger()
	if(_id == "talkCowMilk"):
		if(cowTopic > 0):
			saynn("Ты предлагаешь Милке подоить её. Она соглашается.")
		else:
			saynn("Ты говоришь корове, что пора её подоить.")
		milkScene(C_PC, C_COW)
		addStamina(-40)
		addCowTrust(3)
		addContinueEventTrigger()
		if(helpedMilka):
			addAction("Breed her", "Fuck Milka with your cock or a strapon!", "milkaRewardBreed")
		else:
			addDisabledAction("Breed her", "She doesn't trust you enough..")
	if(_id == "talkBullMilk"):
		if(bullTopic > 0):
			saynn("Ты предлагаешь Пипу подоить его. Он соглашается.")
		else:
			saynn("Ты говоришь быку, что пришло время подоить его.")
		milkScene(C_PC, C_BULL)
		addStamina(-40)
		addBullTrust(3)
		addContinueEventTrigger()
	if(_id == "eatGrass"):
		aimCamera(L_EAT)
		if(upgradeLevel >= UPGRADE_GRASS):
			saynn("Ты выходишь на поле и поедаешь немного этой вкусной травы.")
			addStamina(50)
			GM.pc.fillBalls(0.2)
			GM.pc.fillBreasts(0.2)
		else:
			saynn("Ты выходишь на поле и ешь траву.")
			addStamina(30)
		addObedience(1)
		var special:String = RNG.pickWeightedDict({
			"nothing": 5.0,
			"cow": 1.0,
			"bull": 1.0,
		})
		if(special == "cow" && cowTrust > 0.0):
			playAnimation(StageScene.Duo, "stand", {npc=C_COW})
			GlobalRegistry.getCharacter(C_COW).fillBreasts(0.5)
			saynn("Милка делает то же самое неподалеку, пережевывая травинки.")
			talk(C_COW, RNG.pick([
				"Tasty, isn't it?",
				"Moo~. Free grass.. Constant milking.. What else would a cow want?",
				"Happy times!",
				"Enough grass for us both!",
			]))
			saynn("Ты... киваешь.")
			addCowTrust(2)
		if(special == "bull" && bullTrust > 0.0):
			playAnimation(StageScene.Duo, "stand", {npc=C_BULL})
			GlobalRegistry.getCharacter(C_BULL).fillBalls(0.5)
			saynn("Пип прячется в углу поля, медленно жуя одну-единственную травинку.")
			talk(C_BULL, RNG.pick([
				"They have a whole ass garden.. but we're only allowed to eat grass.",
				"I'm not a grass-eater, okay? I just.. need something to chew on at least.",
				"I wanna step on their berries so much.. but they will do the same with mine.",
				"This place isn't so bad, is it? Eh, who am I kidding..",
			]))
			saynn("Ты киваешь.")
			addBullTrust(2)
		addContinueEventTrigger()
	if(_id == "eatStarve"):
		saynn("Что угодно лучше, чем жрать траву. Ты решаешь просто сдохнуть от голода.")
		addStamina(-30)
		if(GM.pc.getStamina() <= 0):
			saynn("Ой... Живот разболелся...")
			addPain(20)
		if(getTreatAmount() <= 0 && RNG.chance(20+GM.pc.getPainLevel()*80.0+clamp(obedience, 0.0, 1.0)*50.0)):
			playAnimation(StageScene.Duo, "stand", {npc=C_GUY})
			saynn("Лео подходит к тебе и протягивает морковку...")
			talk(C_GUY, "I know the grass isn't what you normally eat. But don't starve yourself, okay? Don't tell Sofie.")
			saynn("Держи, угощение!")
			addTreat(1)
		addContinueEventTrigger()
	if(_id == "eatDemand"):
		saynn("Ты требуешь нормальной еды!")
		addObedience(-2)
		if(RNG.chance(max(20.0+obedience*50.0, 10.0))):
			saynn("Владельцы... всё-таки кормят тебя. Они дают тебе немного объедков, чтобы ты мог перекусить.")
			addStamina(40)
		else:
			saynn("Владельцам, кажется, плевать. Похоже, ты умираешь от голода...")
			addStamina(-30)
		addContinueEventTrigger()
	if(_id == "eatTreat"):
		saynn("Ты съедаешь лакомство! Было очень вкусно.")
		addStamina(100)
		addPain(-100)
		saynn("Но вскоре всё закончилось.")
		addTreat(-1)
		
		if(RNG.chance(30) && cowTrust > 0.0):
			saynn("Милка пускает слюнки, наблюдая за тобой.")
			if(getTreatAmount() > 0):
				saynn("Ты просто не можешь выносить этот взгляд щенячьих глаз Милки... У тебя завалялось лишнее лакомство, и ты решаешь отдать его ей.")
				talk(C_COW, "For me? Thank you-u-u~!")
				addCowTrust(3)
				addTreat(-1)
				
		if(RNG.chance(20) && bullTrust > 0.0):
			saynn("Пип вздыхает.")
			talk(C_BULL, RNG.pick([
				"That was enough, huh?",
				"I see how it is.",
				"Eating treats that they gave you, huh?",
			]))
			saynn("В его голосе слышится ревность.")
			addBullTrust(-1)
		
		addContinueEventTrigger()
	if(_id == "needyMilk"):
		saynn("Ты просишь подоить тебя еще разок...")
		addObedience(1)
		milkScene(RNG.pick([C_GUY, C_GIRL]), C_PC)
		addContinueEventTrigger()
	if(_id == "needyRest"):
		saynn("Ты решаешь просто расслабиться...")
		addStamina(20)
		
		var possible:Array = []
		if(cowTrust > 0.0 && RNG.chance(20+cowTrust*100.0)):
			possible.append("cow")
		if(bullTrust > 0.0 && RNG.chance(20+bullTrust*100.0)):
			possible.append("bull")
		if(obedience > 0.5 && RNG.chance(10.0)):
			possible.append("guy")
		
		if(!possible.empty()):
			var randP:String = RNG.pick(possible)
			if(randP == "cow"):
				playAnimation(StageScene.Duo, "stand", {npc=C_COW})
				saynn("Милка подходит и начинает болтать с тобой.")
				sayMilkaLine()
				addCowTrust(2)
			if(randP == "bull"):
				playAnimation(StageScene.Duo, "stand", {npc=C_BULL})
				saynn("Пип подходит и начинает болтать с тобой.")
				sayPipLine()
				addBullTrust(2)
			if(randP == "guy"):
				playAnimation(StageScene.Duo, "stand", {npc=C_GUY})
				saynn("Лео подходит и начинает болтать с тобой.")
				sayLeoLine()
		
		#GM.pc.orgasmFrom("pc")
		addContinueEventTrigger()
	if(_id == "needyOfferSelf"):
		saynn("Ты решаешь предложить своё тело владельцам...")
		
		saynn("Кто именно будет тебя трахать?")
		
		setState("needySex")
		addAction("Leo", "Let the guy fuck you", "startSex", [C_GUY, C_PC, SexType.DefaultSex, {SexMod.BondageDisabled: true, SexMod.DisableDynamicJoiners: true}])
		addAction("Sofie", "Let the girl fuck you", "startSex", [C_GIRL, C_PC, SexType.DefaultSex, {SexMod.BondageDisabled: true, SexMod.DisableDynamicJoiners: true}])
		addAction("Both", "Let them both have fun with you", "startSex", [[C_GIRL, C_GUY], C_PC, SexType.DefaultSex, {SexMod.BondageDisabled: true, SexMod.DisableDynamicJoiners: true}])
	if(_id == "needyComplain"):
		saynn("Ты жалуешься на то, как сильно тебе хочется ласки!")
		addObedience(-2)
		
		if(RNG.chance(30)):
			saynn("Внезапно к тебе кто-то подходит.")
			bullyScene(C_PC)
		
		addContinueEventTrigger()
	
	if(_id == "startEvent"):
		setState(_args[0])

func needySex_sexResult(_sex:SexEngineResult):
	saynn("Секс окончен!")
	if(_sex.didSubsWin()):
		saynn("Их отлупили.")
		addObedience(-4)
	else:
		if(_sex.getAverageDomSatisfaction() < 0.7):
			saynn("Им не понравилось.")
			addObedience(-2)
		else:
			addObedience(3)
			
			if(RNG.chance(30.0+obedience*70.0)):
				saynn("Тебя угостили вкусняшкой!")
				addTreat(1)

	addContinue("setState", ["main"])

func sleep_state():
	aimCamera(L_SLEEP)
	saynn("Становится поздно. Кафе закрывается, и владельцы возвращают тебя в камеру, прежде чем запереть двери.")
	
	saynn("Пора попытаться уснуть.")
	
	onDayEnd()
	
	if(gonnaHavePeekEvent):
		if(peekState == PEEK_FIRST_EVENT_HAPPENED):
			addAction("Sleep?", "It's time to sleep but you feel like something is about to happen..", "setState", ["ePeekFirstEvent"])
		if(peekState == PEEK_SECOND_EVENT_HAPPENED):
			addAction("Sleep?", "It's time to sleep but you feel like something is about to happen..", "setState", ["ePeekSecondEvent"])
		if(peekState == PEEK_THIRD_EVENT_HAPPENED):
			addAction("Sleep?", "It's time to sleep but you feel like something is about to happen..", "setState", ["ePeekThirdEvent"])
		return
	addAction("Sleep", "Time to sleep", "SLEEP")

func sleepScene():
	aimCamera(L_SLEEP)
	playAnimation(StageScene.Sleeping, "sleep")
	GM.main.startNewDay()
	GM.pc.afterSleeping(false)
	saynn("Наступил новый день. Пора просыпаться.")
	if(upgradeLevel >= UPGRADE_CELLS):
		saynn("Спать на настоящей кровати куда приятнее.")
		addStamina(50)
		addPain(-100)
	else:
		saynn("Старые ящики — не лучшая замена кровати, так что ты едва чувствуешь себя отдохнувшим.")
		addStamina(20)
		addPain(-50)
	
	if(obedience <= -1.0):
		addContinue("ENDING", ["end_annoying"])
	else:
		if(needsPunishment):
			addContinue("setState", ["morningpunish"])
		else:
			addContinue("setState", ["main"])
		if(GM.pc.getCredits() >= 0):
			saynn("[b]Владельцы выплатили долг! Тебя могут отпустить![/b]")
			addAction("Freedom!", "You did your part. Time for the owners to do the same", "ENDING", ["end_credits"])

#func sleep_do(_id:String, _args:Array):
#	if(_id == "sleep"):
#
#			#setState("main")


func about_to_be_milked_by_guy_state():
	aimCamera(L_ACT)
	playAnimation(StageScene.Duo, "stand", {npc=C_GUY})
	saynn("Лео подходит к тебе.")
	if(agreeMilk && !GM.pc.canBeMilked() && !GM.pc.hasEffect(StatusEffect.HasCumInsideAnus) && !GM.pc.hasEffect(StatusEffect.HasCumInsideVagina)):
		talk(C_GUY, RNG.pick([
			"Time for milking. Are you lactating? If not, I will have to try to knock you up first.",
		]))
		saynn("Похоже, если ты согласишься, он попытается тебя осеменить...")
	else:
		talk(C_GUY, RNG.pick([
			"I have to milk you now.",
			"Are you ready to be milked?",
			"Our cafe needs "+cowBullBoth("milk", "cream", "milk")+" to continue operating. I'm here to milk you.",
		]))
	
	addAction("Agree", "Let him milk you!", "agree")
	addAction("Decline", "You'd rather not.", "decline")

func about_to_be_milked_by_guy_do(_id:String, _args:Array):
	if(_id == "agree"):
		saynn("Ты решаешь позволить ему подоить тебя.")
		addObedience(1)
		
		milkScene(C_GUY, C_PC)
		setState("main")
	if(_id == "decline"):
		saynn("Ты отклоняешь его предложение.")
		addObedience(-1)
		if(day > 0 && RNG.chance(max(5.0 - obedience*50.0, 5.0))):
			playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
			setState("about_to_be_milked_by_girl")
			
			saynn("Внезапно выходит Софи и свирепо смотрит на тебя. Лео замечает её и делает несколько шагов назад.")
			talk(C_GIRL, RNG.pick([
				"Think you're so smart? Guess I'm gonna have to milk you myself.",
				"Leo might be soft but I'm not so lenient. Get ready to be punished.",
			]))
			saynn("Похоже, она хочет с тобой подраться...")
			
			addAction("Fight!", "Start the fight", "startFight", [C_GIRL])
			if(getShivAmount() > 0):
				addAction("Shiv her!", "Use your shiv to make her fuck off", "useShiv")
		else:
			if(obedience < -0.1):
				talk(C_GUY, RNG.pick([
					"That's not good, I will have to tell Sofie.",
					"Don't be bratty, we will have to punish you then.",
					"I don't want to force you. But I would like to see more obedience."
				]))
			else:
				if(milkedToday <= 0):
					talk(C_GUY, RNG.pick([
						"Why not? You belong to us, remember? Ugh, fine.",
						"How are we gonna run the cafe? Please consider allowing me to milk you. I don't wanna force you.",
						"You better hope the other slaves will give us at least some milk and seed.",
						"The cafe might have to close if we can't even source the ingredients.."
					]))
				else:
					talk(C_GUY, RNG.pick([
						"We have some milk and cream already.. but if we have extra, the cafe can earn more profit.",
						"No? Okay. I guess we will have to make due with what we have.",
						"I don't wanna force you. But we need all of the "+cowBullBoth("milk", "cream", "milk and cream")+" we can get our hands on.",
					]))
			setState("main")

func about_to_be_milked_by_girl_state():
	aimCamera(L_ACT)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
	saynn("Софи подходит к тебе.")
	if(agreeMilk && !GM.pc.canBeMilked() && !GM.pc.hasEffect(StatusEffect.HasCumInsideAnus) && !GM.pc.hasEffect(StatusEffect.HasCumInsideVagina)):
		talk(C_GIRL, RNG.pick([
			"I've came to milk you. I don't care if you're not lactating, I will just have to breed you first then.",
		]))
		saynn("Похоже, если ты согласишься, она попытается тебя оплодотворить...")
	else:
		if(obedience < -0.1):
			talk(C_GIRL, RNG.pick([
				"I've come to milk you. Gonna be a bitch again?",
				"It's milking time. Don't make it harder for yourself, just obey, slut.",
				"I've come to milk you. Do what I say or I will make you.",
			]))
		else:
			talk(C_GIRL, RNG.pick([
				"It's milking time.",
				"Got some "+cowBullBoth("milk", "cream", "milk and cream")+"? I need it all.",
				"I've come to milk you so you better behave.",
			]))
	saynn("Похоже, она не собирается принимать ответ «нет»...")
	
	addAction("Allow", "Let her milk you", "agree")
	addAction("Fight!", "Resist her attempts", "decline")

func about_to_be_milked_by_girl_do(_id:String, _args:Array):
	if(_id == "agree"):
		saynn("Ты решаешь позволить ей подоить тебя.")
		addObedience(1)
		
		milkScene(C_GIRL, C_PC)
		setState("main")
	if(_id == "decline"):
		saynn("Ты отклоняешь её предложение.")
		addObedience(-1)
		if(obedience < -0.1):
			talk(C_GIRL, RNG.pick([
				"Such a stubborn bitch. You will regret it.",
				"I'm getting sick of you. Fine, let's do this the hard way.",
				"Alright, try to stop me then, you stupid whore.",
			]))
		else:
			talk(C_GIRL, RNG.pick([
				"Really? I guess I'm gonna have to force you then.",
				"Such a silly animal. I will make you behave.",
				"You're nothing but an animal. Behave or I will make you.",
			]))
		saynn("Похоже, тебе придётся с ней сразиться.")
		addAction("Fight!", "Start the fight", "startFight", [C_GIRL])
		if(getShivAmount() > 0):
			addAction("Shiv her!", "Use your shiv to make her fuck off", "useShiv")
	if(_id == "useShiv"):
		playAnimation(StageScene.Duo, "shiv", {npc=C_GIRL, npcAction="defeat"})
		saynn("Прежде чем Софи успевает среагировать, ты выхватываешь шило и наносишь ей удар!")
		
		talk(C_GIRL, RNG.pick([
			"OW, FUCKER!",
			"WHERE DID YOU GET THAT, YOU BITCH?",
			"UGH, I WILL BREAK YOU.. fuck..",
		]))
		addObedience(-3)
		
		if(RNG.chance(10 - (getShivAmount()-1)*3)):
			saynn("Софи кряхтит, уходя. Чудесным образом, [b]тебе удалось сохранить шило[/b].")
		else:
			saynn("Софи кряхтит, уходя. К сожалению, её кожа оказалась достаточно толстой, чтобы сломать шило.")
			useShiv()
		#setState("main")
		addContinue("setState", ["main"])
	
func about_to_be_milked_by_girl_fightResult(_didPCWin:bool):
	if(_didPCWin):
		saynn("Тебе удалось отбиться от Софи!")
		talk(C_GIRL, RNG.pick([
			"I'm not done with you, slut..",
			"Argh.. Screw you then, you stupid bitch.",
			"Alright, fuck you, I will go milk someone else.",
			"I will just make cupcakes out of you if you're gonna keep doing this.",
		]))
		
		addObedience(-5)
	else:
		saynn("Ты проиграл в схватке...")
		talk(C_GIRL, RNG.pick([
			"Pathetic.",
			"That was dumb. Very dumb.",
			"Stop being such a fucking brat.",
			"I got enough lazy fucks around me.",
		]))
		saynn("Софи хватает тебя и готовится к процедуре дойки.")
		
		milkScene(C_GIRL, C_PC)
	
	addContinue("setState", ["main"])

func parse(_text:String, _chars:Dictionary):
	return GM.ui.processString(_text, _chars)

var charOverrides:Dictionary = {}# no sync

func sayParsed(_text:String):
	saynn(parse(_text, charOverrides))

func stimulateLactation(_target:BaseCharacter, forceLactation:bool = false) -> bool:
	if(forceLactation):
		_target.induceLactation()
	if(_target.stimulateLactation() || _target.stimulateLactation()):
		return true
	return false

func getBreastsCapacity(_target:BaseCharacter) -> float:
	if(!_target.hasBodypart(BodypartSlot.Breasts)):
		return 0.0
	var theBreasts = _target.getBodypart(BodypartSlot.Breasts)
	var theProduction = theBreasts.getFluidProduction()
	if(!theProduction):
		return 0.0
	return theProduction.getCapacity()

func getBallsCapacity(_target:BaseCharacter) -> float:
	if(!_target.hasBodypart(BodypartSlot.Penis)):
		return 0.0
	var thePenis = _target.getBodypart(BodypartSlot.Penis)
	var theProduction = thePenis.getFluidProduction()
	if(!theProduction):
		return 0.0
	return theProduction.getCapacity()

func induceLactationScene(_actorID:String, _targetID:String):
	addChar(_actorID)
	addChar(_targetID)
	charOverrides = {actor=_actorID, target=_targetID}
	var _isPCActor:bool = (_actorID == C_PC)
	var _isPCTarget:bool = (_targetID == C_PC)
	var _actor:BaseCharacter = GlobalRegistry.getCharacter(_actorID)
	var _target:BaseCharacter = GlobalRegistry.getCharacter(_targetID)
	
	var _hasVag:bool = _target.hasReachableVagina()
	var _canGetPreg:bool = _target.hasWombIn(BodypartSlot.Vagina if _hasVag else BodypartSlot.Anus) && _target.getFertility() > 0.3
	
	var _hasCumAlready:bool = false
	if(_hasVag && _target.hasEffect(StatusEffect.HasCumInsideVagina)):
		_hasCumAlready = true
	if(!_hasVag && _target.hasEffect(StatusEffect.HasCumInsideAnus)):
		_hasCumAlready = true
	
	sayParsed("{actor.You} {actor.youVerb('check')} {target.your} {target.breasts}, squeezing them.. and finding no milk.")
	if(_actorID == C_GIRL):
		talk(_actorID, RNG.pick([
			"No milk in your tits. We need to fix that.",
			"Your stupid tits aren't lactating. I'm gonna fix that."
		]))
	elif(_actorID == C_GUY):
		talk(_actorID, RNG.pick([
			"You're not lactating, I don't think. I will have to do something about that first.",
			"You're not lactating. We need to fix that."
		]))
	else:
		talk(_actorID, "You're not lactating. We need to fix that.")
	
	# Just stimulate breasts
	if(_hasCumAlready):
		playAnimation(StageScene.BreastGroping, "grope", {pc=_actorID, npc=_targetID, npcBodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('see')} that {target.yourHis} "+("cunt" if _hasVag else "tailhole")+" is already creamed enough so {actor.youHe} just {actor.youHeVerb('pull')} {target.youHim} into a tight embrace and {actor.youHeVerb('begin')} tightly-squeezing {target.yourHis} {target.breasts}, stimulating them!")
		talk(_targetID, "Ah..")
		if(stimulateLactation(_target, lactationTry >= (6 if _canGetPreg else 3))):
			lactationTry = 0
			sayParsed("And soon enough, {target.yourHis} nipples start squirting {target.milk}! {target.YouHe} [b]began lactating[/b]!")
			talk(_actorID, "There we go.")
		else:
			sayParsed("{target.YourHis} nipples get hard and sensitive from the stimulation.. But there is no milk still.")
			talk(_actorID, "We will keep trying.")
	# BREED
	else:
		var _isStrap:bool = false
		if(addStrapon(_actorID, C_GUY)):
			_isStrap = true
			sayParsed("{actor.You} {actor.youVerb('secure')} a strapon around {actor.yourHis} waist and {actor.youVerb('load')} it with something that looks a lot like cum..")
			if(!_canGetPreg):
				talk(_targetID, "Wait, I can't get pregnant.")
				if(_actorID == C_GIRL):
					talk(_actorID, "I will keep trying until you do, slut.")
				else:
					talk(_actorID, "We will see if that's true.")
			else:
				talk(_targetID, "Are you really planning to breed me!?")
				if(_actorID == C_GIRL):
					talk(_actorID, "Bitch, I own you, of course I will knock you up.")
				else:
					talk(_actorID, "Cows make a lot more milk if they're pregnant.")
			sayParsed("{target.You} {target.youVerb('get')} pinned to the floor!")
		else:
			sayParsed("{actor.You} {actor.youVerb('pull')} {actor.yourHis} {actor.penis} out..")
			if(!_canGetPreg):
				talk(_targetID, "Wait, I can't get pregnant.")
				if(_actorID == C_GIRL):
					talk(_actorID, "I will keep trying until you do, slut.")
				else:
					talk(_actorID, "We will see if that's true.")
			else:
				talk(_targetID, "Are you really planning to breed me!?")
				if(_actorID == C_GIRL):
					talk(_actorID, "Bitch, I own you, of course I will knock you up.")
				else:
					talk(_actorID, "Cows make a lot more milk if they're pregnant.")
			sayParsed("{target.You} {target.youVerb('get')} pinned to the floor!")
		
		if(_isStrap):
			playAnimation(StageScene.SexLowDoggy, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('slam')} {actor.yourHis} shiny strapon down {target.yourHis} "+str("tailhole" if !_hasVag else "pussy")+" and {actor.youVerb('pound')} it hard until the tightness makes the toy release its load deep inside {target.youHim}!")
		else:
			playAnimation(StageScene.SexLowDoggy, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('slam')} {actor.yourHis} {actor.penis} down {target.yourHis} "+str("tailhole" if !_hasVag else "pussy")+" and {actor.youVerb('pound')} it hard until the orgasm makes {actor.youHim} stuff it full of {actor.yourHis} seed!")
		
		if(_hasVag):
			_target.gotVaginaFuckedBy(_actorID)
			_target.cummedInVaginaBy(_actorID, FluidSource.Strapon if _isStrap else FluidSource.Penis)
		else:
			_target.gotAnusFuckedBy(_actorID)
			_target.cummedInAnusBy(_actorID, FluidSource.Strapon if _isStrap else FluidSource.Penis)
		_target.orgasmFrom(_actorID)
		_actor.orgasmFrom(_targetID)
		if(!_canGetPreg):
			if(stimulateLactation(_target, lactationTry >= (6 if _canGetPreg else 3))):
				lactationTry = 0
				sayParsed("{target.Your} {target.breasts} suddenly start leaking {target.milk}! {target.YouHe} [b]began lactating[/b]!")
				if(_actorID == C_GIRL):
					talk(_actorID, "Much better. All you needed is some good old breeding.")
				else:
					talk(_actorID, "There we go. And you doubted me.")
	if(_targetID == C_PC):
		addStamina(-20)

func bullyScene(_targetID:String):
	addChar(C_GIRL)
	addChar(_targetID)
	charOverrides = {actor=C_GIRL, target=_targetID}
	#var _isPCActor:bool = (_actorID == C_PC)
	var _isPCTarget:bool = (_targetID == C_PC)
	var _actor:BaseCharacter = GlobalRegistry.getCharacter(C_GIRL)
	var _target:BaseCharacter = GlobalRegistry.getCharacter(_targetID)
	
	var possible:Array = []
	possible.append(["choke", 1.0])
	possible.append(["puppypin", 1.0])
	possible.append(["chokeride", 1.0])
	possible.append(["sitface", 1.0])
	possible.append(["feetcrotch", 1.0])
	possible.append(["feetface", 1.0])
	possible.append(["lickcrotch", 1.0])
	possible.append(["spank", 1.0])
	
	var bullyWay:String = RNG.pickWeightedPairs(possible)
	if(bullyWay == "choke"):
		playAnimation(StageScene.Choking, "idle", {pc=C_GIRL, npc=_targetID})
		sayParsed("Sofie grabs {target.your} throat and puts enough pressure on it to make {target.youHim} see darkness in {target.yourHis} eyes.")
		talk(C_GIRL, RNG.pick([
			"Not so tough now, are you?",
			"What's gonna break first, your neck or your spirit?",
			"Seeing stars already? These are the only stars you will ever see.",
			"You are nothing but a slave. My slave!",
			"You are a fucking slave, hear me?",
		]))
	elif(bullyWay == "puppypin"):
		playAnimation(StageScene.PuppyPinned, "pinned", {pc=C_GIRL, npc=_targetID, npcBodyState={naked=true,hard=true,leashedBy=C_GIRL}})
		sayParsed("Sofie shoves some puppy restraints onto {target.your} arms and legs before pinning {target.youHim} to the floor with her leg, her toes brushing against the back of {target.yourHis} head.")
		talk(C_GIRL, RNG.pick([
			"Bark, you dumb mut.",
			"Say something and I will keep these on you.",
			"Nothing but a breeding bitch.",
			"Wiggle your ass for me, bitch. Show me what I paid for.",
		]))
	elif(bullyWay == "chokeride"):
		playAnimation(StageScene.SexCowgirlChoke, "tease", {pc=_targetID, npc=C_GIRL, bodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Sofie pulls {target.you} down to the floor and then straddles {target.youHim}, leaning down to wrap both hands around {target.yourHis} throat, making it extremely hard to breathe.")
		talk(C_GIRL, RNG.pick([
			"Not so tough now, are you?",
			"What's gonna break first, your neck or your spirit?",
			"Seeing stars already? These are the only stars you will ever see.",
			"You are nothing but a slave. My slave!",
			"You are a fucking slave, hear me?",
		]))
	elif(bullyWay == "sitface"):
		playAnimation(StageScene.SexFaceSitting, "grind", {pc=C_GIRL, npc=_targetID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Sofie pushes {target.you} down to the floor and sits on top of {target.yourHis} face, grinding her soaking pussy against {target.yourHis} face, rocking her hips and glancing down at {target.youHim}.")
		talk(C_GIRL, RNG.pick([
			"You're nothing but my pussy licker, slut.",
			"You're enjoying this, aren't you? Stupid bitch.",
			"Drown in my cunt for all I care.",
			"I paid a lot for your ass. I get to use this face any way I want.",
			"Lick me. Do it or I will make you drown.",
		]))
	elif(bullyWay == "feetcrotch"):
		playAnimation(StageScene.SexFeetPlay, "crotch", {pc=C_GIRL, npc=_targetID, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		if(_target.hasPenis()):
			sayParsed("Sofie flexes her toes and puts them over {target.your} {target.penis}, rubbing and applying just enough pressure to make {target.youHim} squirm and whine.")
			if(_target.isWearingChastityCage()):
				talk(C_GIRL, RNG.pick([
					"Your cock is useless anyway, should I crush it?",
					"Don't you dare drip onto my toes. I will crush your balls for that.",
					"You love it, huh? Pathetic.",
				]))
			else:
				talk(C_GIRL, RNG.pick([
					"You're lucky I can milk this cock. Otherwise I'd just crush it.",
					"Don't you dare drip onto my toes. I will crush your balls for that.",
					"You love it, huh? Pathetic.",
				]))
		else:
			sayParsed("Sofie flexes her toes and puts them over {target.your} crotch, rubbing and applying just enough pressure to make {target.youHim} squirm and whine.")
			talk(C_GIRL, RNG.pick([
				"You love it, huh? Pathetic.",
				"Stupid bitch.",
				"Why are you so dumb?",
			]))
	elif(bullyWay == "feetface"):
		playAnimation(StageScene.SexFeetPlay, "head", {pc=C_GIRL, npc=_targetID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Sofie lifts her foot and slowly brushes her toes across {target.your} cheek and lips, pressing her heel into {target.yourHis} jaw.")
		talk(C_GIRL, RNG.pick([
			"Suck on these. Do it, whore.",
			"Why are you blushing? You're enjoying it, huh?",
			"You look more pathetic than my husband.",
		]))
	elif(bullyWay == "lickcrotch"):
		playAnimation(StageScene.SexOralForced, "lick", {pc=C_GIRL, npc=_targetID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Sofie yanks {target.you} down to {target.yourHis} knees and shoves her wet cunt into {target.yourHis} face.")
		talk(C_GIRL, RNG.pick([
			"You're nothing but my pussy licker, slut.",
			"You're enjoying this, aren't you? Stupid bitch.",
			"Drown in my cunt for all I care.",
			"I paid a lot for your ass. I get to use this face any way I want.",
			"Lick me. Do it or I will make you drown.",
		]))
	elif(bullyWay == "spank"):
		playAnimation(StageScene.Spanking, "fast", {pc=C_GIRL, npc=_targetID, npcBodyState={naked=true, hard=true}})
		sayParsed("Sofie brings {target.you} onto all fours and delivers a sharp smack to {target.yourHis} ass with her palm, again and again, making redness appear on {target.yourHis} skin.")
		talk(C_GIRL, RNG.pick([
			"Produce more for me or your ass will be glowing every day.",
			"Take it, slut.",
			"Gonna whine, huh?",
		]))
	sayParsed("After Sofie is satisfied with bullying {target.you}, she finally lets {target.youHim} be.")

func milkScene(_actorID:String, _targetID:String):
	addChar(_actorID)
	addChar(_targetID)
	if(_targetID == C_COW):
		GlobalRegistry.getCharacter(C_COW).induceLactation()
	charOverrides = {actor=_actorID, target=_targetID}
	var _isPCActor:bool = (_actorID == C_PC)
	var _isPCTarget:bool = (_targetID == C_PC)
	var _actor:BaseCharacter = GlobalRegistry.getCharacter(_actorID)
	var _target:BaseCharacter = GlobalRegistry.getCharacter(_targetID)
	var _canMilkBreasts:bool = true
	if(_isPCTarget && !agreeMilk):
		_canMilkBreasts = false
	if(_targetID == C_BULL):
		_canMilkBreasts = false
	var _canMilkPenis:bool = _target.hasReachablePenis()
	var _canMilkProstate:bool = (_target.hasReachablePenis() || _target.isWearingChastityCage())
	if(_isPCTarget && !agreeSeed):
		_canMilkPenis = false
		_canMilkProstate = false
	var _canUsePumps:bool = (upgradeLevel >= UPGRADE_PUMPS)
	
	if(_targetID == C_PC):
		if(_canMilkBreasts && !_target.canBeMilked()):
			induceLactationScene(_actorID, _targetID)
			lactationTry += 1
			return
		else:
			lactationTry = 0
	
	var possible:Array = []
	
	if(_canMilkBreasts && _canMilkPenis):
		possible.append(["gropeAndStroke", 1.0])
	elif(_canMilkBreasts):
		possible.append(["grope", 1.0])
	if(_canMilkBreasts):
		if(upgradeLevel >= UPGRADE_PUMPS):
			possible.append(["breastpumps", 3.0])
		if(upgradeLevel >= UPGRADE_STALL):
			possible.append(["milkstall", 5.0])
			possible.append(["milkstallpumps", 5.0])
		if(upgradeLevel >= UPGRADE_FUCKMACHINE):
			possible.append(["milksybian", 8.0])
		if(upgradeLevel >= UPGRADE_MILKINGTABLE):
			possible.append(["milkmachine", 12.0])
	if(_canMilkPenis):
		possible.append(["stroke", 1.0])
		if(upgradeLevel >= UPGRADE_PUMPS):
			possible.append(["penispump", 3.0])
		if(upgradeLevel >= UPGRADE_STALL):
			possible.append(["stallpenispump", 5.0])
	if(_canMilkProstate):
		possible.append(["fingering", 0.5])
		possible.append(["pegging", 0.5])
		if(upgradeLevel >= UPGRADE_FUCKMACHINE):
			possible.append(["fuckmachineseed", 8.0])
		if(upgradeLevel >= UPGRADE_MILKINGTABLE):
			possible.append(["fingeringsmarttable", 4.0])
			possible.append(["peggingsmarttable", 4.0])
			possible.append(["seedmilkmachine", 4.0])
	
	if(possible.empty()):
		sayParsed("Game couldn't figure out how to milk {target.you}!")
		return
	var milkWay:String = RNG.pickWeightedPairs(possible)
	
	var shouldMilkPenis:bool = false
	var shouldMilkBreasts:bool = false
	var collectedEnough:bool = false
	var collectedMilk:float = 0.0
	var collectedSeed:float = 0.0
	
	if(milkWay == "gropeAndStroke"):
		shouldMilkPenis = true
		shouldMilkBreasts = true
		playAnimation(StageScene.BreastGroping, "stroke", {pc=_actorID, npc=_targetID, milkTank=true, npcCum=true, npcBodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('bring')} {target.you} down to the floor and {actor.youVerb('milk')} {target.yourHis} {target.breasts} with one hand while stroking {target.yourHis} {target.penis} with another!")
	if(milkWay == "grope"):
		shouldMilkBreasts = true
		playAnimation(StageScene.BreastGroping, "grope", {pc=_actorID, npc=_targetID, milkTank=true, npcCum=true, npcBodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('guide')} {target.you} down onto the floor and {actor.youVerb('milk')} {target.yourHis} {target.breasts} with both hands, letting every drop flow into the tank!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("At the same time, a penis pump drains {target.yourHis} balls!")
	if(milkWay == "stroke"):
		shouldMilkPenis = true
		#playAnimation(StageScene.ChairOral, "stroke", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true,hard=true}})
		playAnimation(StageScene.Grope, "strokefast", {pc=_targetID, npc=_actorID, milkTank=true, pcCum=true, bodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('lock')} eyes with {target.you} and {actor.youVerb('proceed')} to stroke {target.yourHis} {target.penis} in slow, firm strokes until {target.yourHis} seed splatters into the collection container!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	if(milkWay == "fingering"):
		shouldMilkPenis = true
		playAnimation(StageScene.SexFisting, "sex", {pc=_actorID, npc=_targetID, npcCum=true, npcBodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('position')} {target.you} on all fours, then {actor.youVerb('slide')} {actor.yourHis} fingers deep to tease {target.yourHis} prostate, pumping until {target.yourHis} {target.penis} spurts hot seed into the waiting container!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	if(milkWay == "pegging"):
		shouldMilkPenis = true
		if(addStrapon(_actorID)):
			playAnimation(StageScene.SexFreeStanding, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={naked=true,hard=true}, npcBodyState={naked=true,hard=true}})
			sayParsed("{actor.You} {actor.youVerb('wear')} a strapon and {actor.youVerb('start')} pegging {target.your} ass with it, the rubber toy pressing deep to tease and stimulate {target.yourHis} prostate! More and more seed trickles down from {target.yourHis} {target.penis} into the seed tank.")
		else:
			playAnimation(StageScene.SexFreeStanding, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={showPenis=true,hard=true}, npcBodyState={naked=true,hard=true}})
			sayParsed("{actor.You} {actor.youVerb('grab')} {target.you} and {actor.youVerb('line')} {actor.yourHis} cock against {target.yourHis} slick asshole, then {actor.youVerb('ram')} in, every thrust aiming straight for {target.yourHis} prostate! More and more seed trickles down from {target.yourHis} {target.penis} into the seed tank.")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	if(milkWay == "breastpumps"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		playAnimation(StageScene.Cuddling, "squirm", {pc=_actorID, npc=_targetID, npcCum=true, npcBodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('hold')} {target.you} close while two breast-pumps are working away on {target.yourHis} {target.breasts}, humming as they draw every drop of {target.milk} into their internal reservoirs!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("At the same time, a penis pump drains {target.yourHis} balls!")
	if(milkWay == "penispump"):
		shouldMilkPenis = true
		addPenisPump(_targetID)
		playAnimation(StageScene.SybianOral, "hold", {pc=_targetID, npc=_actorID, nosybian=true, chained=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('secure')} a penis pump around {target.your} {target.penis} and {actor.youVerb('let')} it stroke away at {target.yourHis} member until {target.youHe} can no longer hold back, {target.yourHis} {target.cum} filling the internal reservoir!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	if(milkWay == "stallpenispump"):
		shouldMilkPenis = true
		addPenisPump(_targetID)
		var theChains := [["hoseshort", "penisPump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]
		sayParsed("{actor.You} {actor.youVerb('lock')} {target.you} into the milking stall and {actor.youVerb('fit')} a pump over {target.yourHis} {target.penis}. {actor.YouHe} then just {actor.youHeVerb('watch', 'watches')} as the pleasure ring strokes and caresses the length, stimulating {target.yourHis} cock until it starts stuffing the pump’s reservoir full!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
			theChains.append(["hoseshort", "breastpump", "scene", "milktank"])
		playAnimation(StageScene.MilkingStallSolo, "cum", {pc=_targetID, npc=_actorID, npcCum=true, bodyState={naked=true, hard=true, chains=theChains}})
	if(milkWay == "milkstall"):
		shouldMilkBreasts = true
		playAnimation(StageScene.MilkingStallDuo, "cum", {pc=_targetID, npc=_actorID, npcCum=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('cuff')} {target.you} to the milking stall, bending {target.youHim} forward and then hand-milking {target.yourHis} {target.breasts}, like they're udders! Any milk drips down into the milk tank.")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("At the same time, a penis pump drains {target.yourHis} balls!")
	if(milkWay == "milkstallpumps"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		var theChains := [["hoseshort", "breastpump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]
		sayParsed("{actor.You} {actor.youVerb('cuff')} {target.you} to the milking stall and {actor.youVerb('let')} two breast pumps work away at {target.yourHis} {target.breasts}. {actor.YouHe} {actor.youHeVerb('watch', 'watches')} them hum and steadily fill the milk tank.")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("At the same time, a penis pump drains {target.yourHis} balls!")
			theChains.append(["hoseshort", "penisPump", "scene", "milktank"])
		playAnimation(StageScene.MilkingStallSolo, "cum", {pc=_targetID, npc=_actorID, npcCum=true, bodyState={naked=true, hard=true, chains=theChains}})
	if(milkWay == "milksybian"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		playAnimation(StageScene.SybianOral, "hold", {pc=_targetID, npc=_actorID, pcCum=true, chained=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('set')} {target.you} on top of the buzzing sybian and {actor.youVerb('let')} two breast pumps hum away at {target.yourHis} {target.breasts}, collecting milk as the machine fucks {target.yourHis} "+("cunt" if _target.hasReachableVagina() else "ass")+"!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("At the same time, a penis pump drains {target.yourHis} balls!")
	if(milkWay == "fuckmachineseed"):
		shouldMilkPenis = true
		playAnimation(StageScene.HangingSexFuckmachine, "fast", {pc=_targetID, pcCum=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('cuff')} {target.you} by the wrists high above {target.yourHis} head. {actor.YouHe} then {actor.youHeVerb('bring')} a fuck-machine behind and {actor.youHeVerb('turn')} it on! Its thick dildo slides into {target.your} ass and starts hammering {target.yourHis} prostate until {target.yourHis} seed begins to trickle down into the collection tank!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	if(milkWay == "milkmachine"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		var theChains := [["hose", "breastpump", "scene", "milkIntake"]]
		sayParsed("{actor.You} {actor.youVerb('oversee')} the process as an advanced milking machine uses its dildos to fuck {target.yourHis} holes, manipulators pinning {target.yourHis} limbs, two pumps draining {target.yourHis} {target.breasts} into the tanks!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("At the same time, a penis pump drains {target.yourHis} balls!")
			theChains.append(["hose", "penisPump", "scene", "milkIntake"])
		playAnimation(StageScene.BDSMMachineFuck, "fastdouble", {pc=_targetID, pcCum=true, bodyState={naked=true, hard=true,chains=theChains}})
	if(milkWay == "fingeringsmarttable"):
		shouldMilkPenis = true
		playAnimation(StageScene.MilkingProstate, "fast", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('bend')} {target.you} forward over the advanced milking table, manipulators holding {target.yourHis} limbs in place. Two fingers slip into {target.yourHis} asshole, stroking {target.yourHis} prostate just right until {target.yourHis} cock starts throbbing and dripping high-quality seed into the fluid intake!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	if(milkWay == "peggingsmarttable"):
		shouldMilkPenis = true
		if(addStrapon(_actorID)):
			playAnimation(StageScene.MilkingProstateFuck, "fast", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('secure')} {target.you} over the advanced table, manipulators holding {target.yourHis} limbs in place. A pre-lubed strapon presses against {target.yourHis} tight ring, spreading it wide before sliding inside. {actor.You} {actor.youVerb('begin')} pounding {target.yourHis} ass nice and hard, using the info that the table provides to maximize the stimulation of the prostate. Soon, seed begins to dribble down into the fluid intake.")
		else:
			playAnimation(StageScene.MilkingProstateFuck, "fast", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={showPenis=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('secure')} {target.you} over the advanced table, manipulators holding {target.yourHis} limbs in place. A {actor.penis} presses against {target.yourHis} tight ring, spreading it wide before sliding inside. {actor.You} {actor.youVerb('begin')} pounding {target.yourHis} ass nice and hard, using the info that the table provides to maximize the stimulation of the prostate. Soon, seed begins to dribble down into the fluid intake.")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	if(milkWay == "seedmilkmachine"):
		shouldMilkPenis = true
		playAnimation(StageScene.BDSMMachineAltFuck, "fast" if !_target.hasReachableVagina() else "fastdouble", {pc=_targetID, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('activate')} the "+("dual-" if _target.hasReachableVagina() else "")+"dildo milking mode on the advanced table. "+("Two rigid dildos thrust in unison into {target.yourHis} holes" if _target.hasReachableVagina() else "A rigid dildo thrusts into {target.yourHis} fuckhole")+", stretching and pounding {target.yourHis} prostate until {target.yourHis} cock erupts, filling the seed tank with thick ropes!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("At the same time, two breast-pumps hum away at {target.yourHis} {target.breasts}, pulling out {target.milk}!")
	
	if(shouldMilkPenis):
		collectedSeed += _target.milkSeed()
	if(shouldMilkBreasts):
		collectedMilk += _target.milk()
	
	_target.orgasmFrom(_actorID)
	if(_isPCTarget):
		addStamina(-40)
	
	collectedEnough = false
	if(shouldMilkBreasts):
		var theCapacity:float = getBreastsCapacity(_target)
		if(theCapacity > 0.0):
			var fluidRatio:float = collectedMilk / theCapacity
			if(fluidRatio >= 0.2 || collectedMilk >= 400.0):
				collectedEnough = true
	if(shouldMilkPenis):
		var theCapacity:float = getBallsCapacity(_target)
		if(theCapacity > 0.0):
			var fluidRatio:float = collectedSeed / theCapacity
			if(fluidRatio >= 0.4 || collectedSeed >= 250.0):
				collectedEnough = true
	
	#var collectedTotal:float = collectedMilk + collectedSeed
#	var collectedTotalWeighted:float = collectedMilk + collectedSeed*3.0
#	if(collectedTotalWeighted < 10.0):
#		collectedEnough = false
#	else:
#		collectedEnough = true
	
	if(shouldMilkBreasts && shouldMilkPenis):
		sayParsed("{actor.You} managed to collect "+str(Util.roundF(collectedMilk, 1))+"ml of {target.milk} and "+str(Util.roundF(collectedSeed, 1))+"ml of {target.cum}.")
	elif(shouldMilkBreasts):
		sayParsed("{actor.You} managed to collect "+str(Util.roundF(collectedMilk, 1))+"ml of {target.milk}.")
	elif(shouldMilkPenis):
		sayParsed("{actor.You} managed to collect "+str(Util.roundF(collectedSeed, 1))+"ml of {target.cum}.")
	
	if(collectedEnough):
		if(_targetID == C_PC || _actorID == C_PC):
			pcGaveMilkOrSeed += 1
		if(_actorID == C_GIRL):
			talk(_actorID, RNG.pick([
				"Good enough.",
				"That's enough for now. I will be back soon.",
				"Good. Now go away.",
				"Sure, that will do.",
			]))
		elif(_actorID == C_GUY):
			talk(_actorID, RNG.pick([
				"Such a good "+("cow" if shouldMilkBreasts else "bull")+". Thank you.",
				"Well done, this will allow us to run the cafe for some time.",
				"This is great, thank you. Good "+("cow" if shouldMilkBreasts else "bull")+".",
				"The customers will enjoy it. Thank you.",
			]))
		else:
			talk(_actorID, RNG.pick([
				"Such a good "+("cow" if shouldMilkBreasts else "bull")+".",
				"Good "+("cow" if shouldMilkBreasts else "bull")+". Very good.",
				"Good "+("cow" if shouldMilkBreasts else "bull")+". Now go get some rest.",
				"Love to see it. You may rest now.",
			]))
		milkedToday += 1
	else:
		if(_actorID == C_GIRL):
			talk(_actorID, RNG.pick([
				"That's barely anything. Pathetic.",
				"Really? That's almost nothing. Useless bitch.",
				"Pretty much nothing. I wasted my time with you. Ugh.",
				"Pathetic yield, why am I even keeping you then.",
			]))
		elif(_actorID == C_GUY):
			talk(_actorID, RNG.pick([
				"That's.. not enough. Can you try better next time?",
				"That's not enough sadly. Some customers will have to stay hungry.",
				"Not enough.. "+("How am I gonna make cupcakes without cream.." if shouldMilkPenis else "How am I gonna make cappuccino without milk.."),
				"Not enough.. unfortunately.",
			]))
		else:
			talk(_actorID, RNG.pick([
				"That's not enough, sadly.",
				"Not enough, unfortunately.",
			]))


func failedlockescape_state():
	playAnimation(StageScene.Solo, "kick")
	aimCamera(L_COUNTER)
	
	saynn("Ты вкладываешь всю свою силу в следующий удар... и вышибаешь укрепленную дверь! Навесной замок разлетается пополам, не в силах больше удерживать тебя внутри.")
	addStamina(-80)
	
	saynn("Почувствовав храбрость... и вдохновение... ты вылетаешь из этой чертовой темницы, щурясь от яркого света кафе.")
	
	saynn("После такого шума посетители оборачиваются к тебе... Их глаза округляются от изумления.")
	
	saynn("Сами того не осознавая, ты перепрыгиваешь через прилавок и несешься к выходу!")
	
	addContinue("setState", ["fldown"])

func fldown_state():
	addChar(C_GUY)
	#addChar(C_GIRL)
	playAnimation(StageScene.Duo, "defeat", {npc=C_GUY, npcAction="stunbaton"})
	aimCamera(L_DOCKS)
	
	saynn("Ты не думаешь... ты просто действуешь. Бей или беги. Но, похоже, сегодня бежать не получится...")
	
	saynn("Выбраться из кафе было проще всего... но теперь ты в каких-то доках. За окнами — лишь космические корабли да бесконечная пустота.")
	
	saynn("Ты пытаешься заскочить на один из кораблей... но панель двери отвечает тебе противным писком.")
	
	saynn("И именно в этот момент настигают последствия... Ты чувствуешь невыносимую боль: электрошокер втыкают тебе прямо в ребра, и разряд такой силы, что он свалит слона, не то что тебя.")
	
	addPain(70)
	
	talk(C_GUY, "Sorry, I can't let you go.")
	
	saynn("Тебе хочется как-то ответить... но ты не можешь. Твое тело бьется в конвульсиях на полу от остаточных разрядов...")
	
	saynn("Лео хватает тебя за шиворот и затаскивает обратно в кафе.")
	
	talk(C_GUY, "Uh.. ignore us, please. Enjoy your meals, pretend we're not here.")
	
	saynn("Увидев тебя — голым, а рядом парня с электрошокером... большинство посетителей просто спешно собирают вещи и сваливают.")
	
	addContinue("setState", ["flback"])

func flback_state():
	addChar(C_GUY)
	addChar(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_GIRL, npc=C_GUY})
	aimCamera(L_CENTER)
	
	saynn("Тебя волокут обратно в тускло освещенную служебную комнату...")
	
	talk(C_GIRL, "REALLY? You let {pc.him} escape? What the fuck is wrong with you?!")
	
	talk(C_GUY, "I didn't. {pc.He} broke out somehow.")
	
	if(!cageRemoved && !helpedMilka):
		saynn("Все еще пошатываясь от головокружения, ты оглядываешься и видишь других рабов. Бык тяжело вздыхает... а корова просто дрожит в углу, ее полные ужаса глаза прикованы только к электрошокеру.")
	elif(cageRemoved):
		saynn("Все еще пошатываясь от головокружения, ты оглядываешься и видишь других рабов. Бык выглядит так, будто готов прийти тебе на помощь... но в его взгляде читаются явные сомнения. А корова просто дрожит в углу, ее полные ужаса глаза прикованы только к электрошокеру.")
	else:
		saynn("Всё ещё кружится голова. Оглядевшись, ты видишь остальных рабов. Корова явно хочет помочь чем может... но при виде электрошокера её начинает трясти, и она морщится от страха. Бык... он лишь вздыхает, глядя на тебя, и качает головой.")
	
	saynn("У тебя возникает стойкое ощущение, что без их общей помощи тебе просто пиздец.")
	
	saynn("Хозяева выходят и закрывают за собой дверь. Ты всё ещё слышишь, как они спорят.")
	
	saynn("Похоже, твоя попытка побега провалилась... И теперь всё тело ноет от боли.")
	
	addContinue("setState", ["flcheck"])

func flcheck_state():
	processTurn()
	playAnimation(StageScene.Solo, "stand")
	
	saynn("Спустя какое-то время тебе удаётся подняться.")
	
	saynn("Дверь снова заперта... но, похоже, они использовали тот же самый наполовину сломанный навесной замок. Эти жлобы даже не удосужились купить новый.")
	
	addContinue("setState", ["main"])



func morningpunish_state():
	addChar(C_GIRL)
	playAnimation(StageScene.SexCowgirlChoke, "tease", {pc="pc", npc=C_GIRL})
	
	saynn("Прежде чем ты успеваешь встать, в камеру влетает Софи и прижимает тебя к полу, её руки мгновенно смыкаются на твоём горле!")
	talk(C_GIRL, RNG.pick([
		"WHY ARE YOU SO FUCKING LAZY? WHERE IS MY "+("MILK" if agreeMilk else "SEED")+"? HOW AM I SUPPOSED TO RUN MY CAFE?",
		"YOU THOUGHT THIS IS A HOLIDAY RESORT? YOU BETTER START GIVING ME YOUR "+("MILK" if agreeMilk else "SEED")+" OR I WILL HAVE TO SELL YOU. MAYBE EVEN IN BITS.",
		"BITCH, I BOUGHT YOU BECAUSE I NEED TO MAKE CUPCAKES OUT OF SOMETHING. GIVE ME "+("MILK" if agreeMilk else "SEED")+" OR IT WILL BE YOUR FLESH.",
		"YOU THINK YOU'RE SMART? I WILL TORTURE YOU UNTIL YOU START GIVING ME MY "+("MILK" if agreeMilk else "SEED")+". ALL OF IT.",
	]))
	
	saynn("Она явно в ярости из-за того, что ты не выдал ни семени, ни молока для кафе...")
	
	saynn("Ты пытаешься сбросить её с себя... но, похоже, она ещё не закончила тебя наказывать...")
	
	addContinue("startSex", [C_GIRL, C_PC, SexType.DefaultSex, {SexMod.SubMustGoUnconscious:true, SexMod.DisableDynamicJoiners:true}])
	if(getShivAmount() > 0):
		addAction("Shiv her!", "Make her fuck off by shiving her", "useshiv")
	else:
		addDisabledAction("Shiv her!", "You don't have any shivs")

func morningpunish_do(_id:String, _args:Array):
	if(_id == "useshiv"):
		playAnimation(StageScene.Duo, "shiv", {npc=C_GIRL, npcAction="defeat"})
		
		saynn("Тебе удаётся вырваться, вонзив заточку ей в руку!")
		talk(C_GIRL, RNG.pick([
			"ARGH! YOU FUCKER!",
			"YOU BITCH.. FUCK!",
			"THAT FUCKING HURT, FUCKER.",
		]))
		if(RNG.chance(10 - (getShivAmount()-1)*3)):
			saynn("Софи кряхтит, уходя. Чудесным образом, [b]тебе удалось сохранить шило[/b].")
		else:
			saynn("Софи кряхтит, уходя. К сожалению, её кожа оказалась достаточно толстой, чтобы сломать шило.")
			useShiv()
		
		needsPunishment = false
		addContinue("setState", ["main"])

func morningpunish_sexResult(_sex:SexEngineResult):
	saynn("Наказание окончено!")
	if(_sex.didSubsWin()):
		playAnimation(StageScene.Duo, "shove", {npc=C_GIRL, npcAction="hurt"})
		saynn("Тебе удалось дать отпор Софи.")
		talk(C_GIRL, RNG.pick([
			"..fucking slut.",
			"..stupid bitch.",
			"..I'm not done with you, whore.",
			"Ugh. Fuck you.",	
		]))
		saynn("Она кряхтит... и оставляет тебя в покое... пока что.")
		addObedience(-5)
	else:
		if(_sex.isSubUnconscious(C_PC)):
			playAnimation(StageScene.SexStart, "defeated", {pc=C_GIRL})
			saynn("Софи убирает руки от твоего горла и несколько раз дает тебе звонкую пощечину.")
			talk(C_GIRL, RNG.pick([
				"Get up, your dumb bitch. I know you're not dead.",
				"Get up. If you don't want more, you better start producing.",
			]))
			saynn("Она быстро уходит и возвращается с ведром воды, которое выплескивает тебе в лицо. Освежает.")
			addStamina(40)
			addPain(-50)
		elif(_sex.getAverageDomSatisfaction() < 0.7):
			playAnimation(StageScene.SexStart, "start", {pc=C_GIRL})
			saynn("С Софи покончено... но она не выглядит особо удовлетворенной.")
			talk(C_GIRL, RNG.pick([
				"You can't even struggle right.",
				"Why are you so fucking weak? Ughh, everyone around me is a mistake.",
				"Next time, try harder, you slut.",
			]))
			addObedience(-2)
		else:
			playAnimation(StageScene.SexStart, "start", {pc=C_GIRL})
			saynn("С Софи покончено... кажется, она больше не чувствует такого... напряжения.")
			talk(C_GIRL, RNG.pick([
				"Start producing or you will see me again.",
				"If anything, at least I got myself a punching bag. Second one.",
				"Next time, try harder, you slut",
			]))
	
	if(!canMilkOthers):
		canMilkOthers = true
		saynn("Прежде чем уйти, она добавляет кое-что еще...")
		talk(C_GIRL, "If you can't give me enough "+cowBullBoth("milk", "cream", "milk")+", start milking others. Be useful, bitch.")
	
	needsPunishment = false
	addContinue("setState", ["main"])



func eOwnerMilkSlave_state():
	var theOwner:String = RNG.pick([C_GUY, C_GIRL])
	var theSlave:String = RNG.pick([C_BULL, C_COW])
	charOverrides = {actor=theOwner, target=theSlave}
	addChar(theOwner)
	addChar(theSlave)
	playAnimation(StageScene.Duo, "stand", {pc=theOwner, npc=theSlave})
	if(theSlave == C_BULL):
		aimCamera(L_BULL)
	else:
		aimCamera(L_COW)
	
	sayParsed("{actor.You} {actor.youVerb('want')} to milk {target.you}!")
	
	if(theOwner == C_GIRL):
		talk(C_GIRL, RNG.pick([
			"It's milking time, slut.",
			"I've come to milk you so you better behave, you animal.",
		]))
	if(theOwner == C_GUY):
		talk(C_GUY, RNG.pick([
			"I have to milk you now.",
			"Are you ready to be milked?",
			"Our cafe needs milk and cream to continue operating. I'm here to milk you.",
		]))
	
	addAction("Watch", "See what happens", "doWatch", [theOwner, theSlave])
	if(obedience > 0.2):
		if(GM.pc.getStamina() > 0):
			if(GM.pc.hasBlockedHands() || GM.pc.hasBoundArms()):
				addDisabledAction("Help owner", "Your arms are bound..")
			else:
				addAction("Help owner", "Ask to be the one who is doing the milking.", "doHelp", [theOwner, theSlave])
		else:
			addDisabledAction("Help owner", "You don't have enough stamina")
	else:
		addDisabledAction("Help owner", "The owners don't trust you enough.")

func eOwnerMilkSlave_do(_id:String, _args:Array):
	var theOwner:String = _args[0]
	var theSlave:String = _args[1]
	charOverrides = {actor=theOwner, target=theSlave}
	if(_id == "doWatch"):
		milkScene(theOwner, theSlave)
		addContinue("setState", ["main"])
	if(_id == "doHelp"):
		sayParsed("You ask {actor.name} if you can help with the milking. {actor.He} decides to let you do it.")
		if(theOwner == C_GIRL):
			talk(theOwner, RNG.pick([
				"Sure, saves me time.",
				"Fine, be useful.",
				"Fuck it, go ahead. Squeeze every last drop out though.",
				"Whatever, go do it, I need to return to the counter.",
				"You? Okay. Don't you dare slacking off though.",
			]), false)
		else:
			talk(theOwner, RNG.pick([
				"Sure, saves me time.",
				"Fine, be useful.",
				"Fuck it, go ahead. Squeeze every last drop out though.",
				"Whatever, go do it, I need to return to the counter.",
				"You? Okay. Don't you dare slacking off though.",
			]), false)
		addObedience(2)
		milkScene(C_PC, theSlave)
		addStamina(-30)
		addContinue("setState", ["main"])


func eGirlBulliesSlave_state():
	var theOwner:String = C_GIRL
	var theSlave:String = RNG.pick([C_BULL, C_COW])
	charOverrides = {actor=theOwner, target=theSlave}
	addChar(theOwner)
	addChar(theSlave)
	playAnimation(StageScene.Duo, "stand", {pc=theOwner, npc=theSlave})
	if(theSlave == C_BULL):
		aimCamera(L_BULL)
	else:
		aimCamera(L_COW)
	
	sayParsed("{actor.You} {actor.youVerb('approach', 'approaches')} {target.you}!")
	
	talk(theOwner, RNG.pick([
		"Why are you looking at me, you dumb animal? You wanna get punished?",
		"I'm feeling mean. Come here, slut.",
		"I'm not in a good mood. This means, it's humiliation time!",
		"Bitch, when was the last time I degraded you? I gotta show you your place again.",
		"Come here. I need a new reason to laugh at you.",
		"Look at you, standing there like you think you matter. You don't. Don't believe me?",
		"Did you forget your place already, you stupid animal? I can remind you.",
	]))
	
	sayParsed("{actor.You} clearly {actor.youVerb('want')} to bully {target.youHim}!")
	
	addAction("Let it happen", "See what happens", "doWatch", [theOwner, theSlave])
	addAction("Protect", "Protect the slave!", "doProtect", [theOwner, theSlave])
	addAction("Get bullied", "Make Sofie bully you instead", "takeBlame", [theOwner, theSlave])

func eGirlBulliesSlave_do(_id:String, _args:Array):
	var theOwner:String = _args[0]
	var theSlave:String = _args[1]
	charOverrides = {actor=theOwner, target=theSlave}
	if(_id == "doWatch"):
		bullyScene(theSlave)
		if(theSlave == C_BULL):
			addBullTrust(-3)
		else:
			addCowTrust(-3)
		addContinue("setState", ["main"])
	
	if(_id == "doProtect"):
		playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
		sayParsed("You attempt to protect {target.you} from Sofie!")
		if(theSlave == C_BULL):
			addBullTrust(5)
		else:
			addCowTrust(5)
		talk(C_GIRL, RNG.pick([
			"Really? You are even more dumb than I thought.",
			"I guess I will have you punish both of you.",
			"That was a big mistake.",
		]))
		sayParsed("Looks like you will have to fight.")
		addObedience(-1)
		addAction("Fight", "Start the fight", "startFight", [C_GIRL])
		if(getShivAmount() > 0):
			addAction("Shiv her!", "Use your shiv to make her fuck off", "useShiv")
	if(_id == "useShiv"):
		playAnimation(StageScene.Duo, "shiv", {npc=C_GIRL, npcAction="defeat"})
		saynn("Прежде чем Софи успевает среагировать, ты выхватываешь шило и наносишь ей удар!")
		
		talk(C_GIRL, RNG.pick([
			"OW, FUCKER!",
			"WHERE DID YOU GET THAT, YOU BITCH?",
			"UGH, I WILL BREAK YOU.. fuck..",
		]))
		addObedience(-3)
		
		if(RNG.chance(10 - (getShivAmount()-1)*3)):
			saynn("Софи кряхтит, уходя. Чудесным образом, [b]тебе удалось сохранить шило[/b].")
		else:
			saynn("Софи кряхтит, уходя. К сожалению, её кожа оказалась достаточно толстой, чтобы сломать шило.")
			useShiv()
		addContinue("setState", ["main"])
		
	if(_id == "takeBlame"):
		playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
		sayParsed("You tell Sofie to let her anger on you instead!")
		talk(C_GIRL, RNG.pick([
			"Alright, you asked for it.",
			"Really? Are you that big of a slut?",
			"Sure, I will humiliate you as well.",
		]))
		bullyScene(C_PC)
		if(theSlave == C_BULL):
			addBullTrust(4)
		else:
			addCowTrust(4)
		addContinue("setState", ["main"])

func eGirlBulliesSlave_fightResult(_didPCWin:bool):
	if(_didPCWin):
		saynn("Тебе удалось отбиться от Софи!")
		talk(C_GIRL, RNG.pick([
			"I'm not done with you, slut..",
			"Argh.. Screw you then, you stupid bitch.",
			"Alright, fuck you then.",
			"I will just make cupcakes out of you if you're gonna keep doing this.",
		]))
		addObedience(-5)
	else:
		saynn("Ты проиграл в схватке...")
		talk(C_GIRL, RNG.pick([
			"Pathetic.",
			"That was dumb. Very dumb.",
			"From hero to zero.",
			"I got enough lazy fucks around me.",
		]))
		bullyScene(C_PC)
	
	addContinue("setState", ["main"])




func eGirlCattleProdCow_state():
	var theOwner:String = C_GIRL
	var theSlave:String = C_COW
	charOverrides = {actor=theOwner, target=theSlave}
	addChar(theOwner)
	addChar(theSlave)
	playAnimation(StageScene.Duo, "stand", {pc=theOwner, npc=theSlave})
	if(theSlave == C_BULL):
		aimCamera(L_BULL)
	else:
		aimCamera(L_COW)
	
	sayParsed("Sofie approaches Milka with a cattle-prod in her hand!")
	talk(C_GIRL, RNG.pick([
		"Some shock is ought to help you make more milk.",
		"The cafe needs more milk, Milka. Show me your tits.",
		"Present your tits, cow.",
		"This will help your tits. Present them.",
	]))
	sayParsed("Milka shivers, her lips trembling.")
	talk(C_COW, RNG.pick([
		"It hurts when you do that..",
		"If you say so..",
		"I thought I make enough..",
	]))
	
	addAction("Let it happen", "See what happens", "doWatch", [theOwner, theSlave])
	addAction("Protect", "Protect the slave!", "doProtect", [theOwner, theSlave])

func eGirlCattleProdCow_do(_id:String, _args:Array):
	var theOwner:String = _args[0]
	var theSlave:String = _args[1]
	charOverrides = {actor=theOwner, target=theSlave}
	if(_id == "doWatch"):
		addChar(theOwner)
		addChar(theSlave)
		GlobalRegistry.getCharacter(C_COW).fillBreasts(1.0)
		playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc=theSlave, npcAction="hurt"})
		saynn("Софи прижимает электрошокер к груди Милки и сжимает рукоятку, пропуская болезненный разряд через её грудь.")
		talk(C_COW, "Ow!")
		saynn("Тело Милки содрогается, мышцы напрягаются... и из её сосков брызжет чистое молоко!")
		talk(C_GIRL, "Much better.")
	
	if(_id == "doProtect"):
		if(RNG.chance(50)):
			playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc="pc", npcAction="hurt"})
			
			saynn("Ты отталкиваешь Милку с пути электрошокера... и получаешь удар вместо неё. Ой! Всё тело сотрясается от резкого болезненного разряда, прошивающего тебя насквозь.")
			addPain(40)
			addStamina(-25)
			
			talk(C_GIRL, "Really? Fine, your tits will do too.")
			addObedience(-1)
			
			if(GM.pc.isLactating()):
				GM.pc.fillBreasts(1.0)
				saynn("Твоя грудь [b]кажется налитой, из неё сочится {pc.milk}![/b]")
			else:
				if(GM.pc.stimulateLactation()):
					saynn("Твоя грудь [b]внезапно начала лактацию![/b]")
				else:
					saynn("Ты чувствуешь стимуляцию в груди...")
			saynn("Когда Софи уходит, Милка быстро тебя обнимает.")
			addCowTrust(4)
		else:
			playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc="pc", npcAction="dodge"})
			
			saynn("Ты отталкиваешь Милку с пути электрошокера... и тебе удаётся увернуться!")
			addStamina(-25)
			saynn("Софи закатывает глаза.")
			talk(C_GIRL, "I have no time for this. Screw you.")
			addObedience(-4)
			saynn("Когда Софи уходит, Милка быстро тебя обнимает.")
			addCowTrust(4)
	
	addContinue("setState", ["main"])



func eGirlCattleProdBull_state():
	var theOwner:String = C_GIRL
	var theSlave:String = C_BULL
	charOverrides = {actor=theOwner, target=theSlave}
	addChar(theOwner)
	addChar(theSlave)
	playAnimation(StageScene.Duo, "stand", {pc=theOwner, npc=theSlave})
	if(theSlave == C_BULL):
		aimCamera(L_BULL)
	else:
		aimCamera(L_COW)
	
	sayParsed("Sofie approaches Pip with a cattle-prod in her hand!")
	talk(C_GIRL, RNG.pick([
		"Some shock is ought to help you make more seed.",
		"The cafe needs more cream, Pip. Show me your cock.",
		"Present your balls, bull.",
		"This will help your cum-production. Present yourself.",
	]))
	sayParsed("Pip steps back, away from her.")
	talk(C_BULL, RNG.pick([
		"Really? Use it on that weird cow, not me.",
		"You are NOT putting it anywhere near my balls.",
		"No-no-no, go away.",
		"I will get you your cream, you don't have to do this.",
	]))
	
	addAction("Let it happen", "See what happens", "doWatch", [theOwner, theSlave])
	addAction("Protect", "Protect the slave!", "doProtect", [theOwner, theSlave])

func eGirlCattleProdBull_do(_id:String, _args:Array):
	var theOwner:String = _args[0]
	var theSlave:String = _args[1]
	charOverrides = {actor=theOwner, target=theSlave}
	if(_id == "doWatch"):
		addChar(theOwner)
		addChar(theSlave)
		GlobalRegistry.getCharacter(C_BULL).fillBalls(1.0)
		playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc=theSlave, npcBodyState={hard=true}, npcAction="hurt"})
		saynn("Софи прижимает электрошокер к "+("chastity cage" if !cageRemoved else "balls")+" Пипу и сжимает рукоятку, пропуская через него болезненный разряд.")
		talk(C_BULL, "ARGH! FUCK!")
		saynn("Тело Пипа сотрясается конвульсиями, из его рта вырывается гортанный крик... "+("His locked cock throbs inside its tight prison, leaking with seed." if !cageRemoved else "His cock goes hard instantly, throbbing, flared tip dripping with seed."))
		talk(C_GIRL, "Much better.")
	
	if(_id == "doProtect"):
		if(RNG.chance(50)):
			playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc="pc", npcAction="hurt", npcBodyState={hard=true}})
			
			saynn("Ты отталкиваешь Пипа с пути электрошокера... и вместо него получаешь удар сам. Ой! Всё твоё тело пронзает резкий, болезненный разряд тока.")
			addPain(40)
			addStamina(-25)
			
			talk(C_GIRL, "You really wanna protect that pathetic joke of a stud? Pff.")
			addObedience(-1)
			
			if(GM.pc.hasPenis()):
				GM.pc.fillBalls(1.0)
				saynn("Твои яйца [b]кажутся налитыми![/b]")
			elif(GM.pc.isLactating()):
				GM.pc.fillBreasts(1.0)
				saynn("Твоя грудь [b]кажется налитой, из неё сочится {pc.milk}![/b]")
			else:
				if(GM.pc.stimulateLactation()):
					saynn("Твоя грудь [b]внезапно начала лактацию![/b]")
				else:
					saynn("Ты чувствуешь стимуляцию в груди...")
			saynn("Когда Софи уходит, Пип подходит к тебе.")
			talk(C_BULL, "This sucks. Sorry.")
			addBullTrust(4)
		else:
			playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc="pc", npcAction="dodge"})
			
			saynn("Ты отталкиваешь Пипа с пути электрошокера... и тебе удаётся увернуться!")
			addStamina(-25)
			saynn("Софи закатывает глаза.")
			talk(C_GIRL, "I have no time for this. Screw you.")
			addObedience(-4)
			saynn("Когда Софи уходит, Пип подходит к тебе.")
			talk(C_BULL, "Fuck that bitch, right?")
			addBullTrust(4)
	
		if(RNG.chance(100.0 - getShivAmount()*40.0)):
			saynn("Он протягивает тебе заточенный камень.")
			addShiv()
			talk(C_BULL, "I hope this will be helpful to you.")
	
	addContinue("setState", ["main"])



func eEatAss_state():
	addChar(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_GIRL})

	saynn("К тебе подходит Софи, держа в руке какое-то аппетитное лакомство.")
	talk(C_GIRL, "Want this? I know you do.")
	saynn("Свободной рукой она хватает тебя за воротник.")
	talk(C_GIRL, "My ass needs a good eating.")
	if(GM.pc.isOralBlocked()):
		saynn("Она побрякивает ключами прямо перед твоим лицом.")
		talk(C_GIRL, "I will even free your face if you do.")
	
	addAction("Deny", "A treat isn't worth it", "deny")
	addAction("Eat ass", "Ohh, a treat!", "eatAss")

func eEatAss_do(_id:String, _args:Array):
	if(_id == "deny"):
		saynn("Вы отклоняете её предложение.")
		talk(C_GIRL, "Alright, screw you then.")
		addObedience(-1)
	
	if(_id == "eatAss"):
		GM.pc.freeEyesDeleteAll()
		GM.pc.freeMouthDeleteAll()
		playAnimation(StageScene.SexRimming, "fast", {pc=C_GIRL, npc=C_PC, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Вы повинуетесь: встаете на колени и наблюдаете, как Софи разворачивается и сует свою задницу вам прямо в лицо.")	
		saynn("Нежными движениями языка вы начинаете обслуживать её, смачивая её анус своей слюной.")
		talk(C_GIRL, RNG.pick([
			"C'mon, get your tongue in there, you slut.",
			"Do it properly or no treat!",
			"Mhh.. maybe I should use you as my ass-licker instead.",
		]))
		saynn("Тихие стоны срываются с губ девушки, пока вы усердно вылизываете её задницу, позволяя языку исследовать её сфинктер.")
		saynn("Когда работа сделана, она неохотно вручает вам награду.")
		addTreat(1)
		addObedience(3)
	
	addContinue("setState", ["main"])

func eWannaCuddle_state():
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_GUY})

	saynn("Лео подходит к тебе.")
	talk(C_GUY, "I'm not here to bully you, don't worry. Wanna chill together maybe?")
	
	addAction("Chill", "Agree to chill with your owner", "chill")
	addAction("No", "You'd rather not", "noChill")

func eWannaCuddle_do(_id:String, _args:Array):
	if(_id == "noChill"):
		saynn("Вы отклоняете его предложение.")
		talk(C_GUY, "Sure, okay, no problem.")
	
	if(_id == "chill"):
		playAnimation(StageScene.Cuddling, "idle", {pc=C_GUY, npc=C_PC})
		saynn("Вы решаете провести немного времени с этим парнем.")
		saynn("Приятно хоть раз не подвергаться насилию или издевательствам. Лео болтает с вами, а вы в основном просто молчите.")
		sayLeoLine()
		saynn("В конце концов, он встает и уходит.")
		addStamina(30)
		addObedience(1)
	
	addContinue("setState", ["main"])


func eCowSeesTreat_state():
	addChar(C_COW)
	playAnimation(StageScene.Beg, "beg", {pc=C_COW, npc=C_PC})

	saynn("Милка прыгает вокруг... прежде чем остановиться рядом с вами и принюхаться к воздуху.")
	talk(C_COW, RNG.pick([
		"You have a treat? Can I have?? Pretty please-e-e-e-e!",
		"Treat? Please?.. I love treats..",
		"I sniff a treat on you! Since you haven't eaten it yet.. maybe I can..",
		"Treat?..",
	]))
	saynn("Она опускается перед тобой на колени... и смотрит на тебя взглядом преданного щенка.")
	
	addAction("Give treat", "Give Milka a treat", "give")
	addAction("No", "You'd rather save it", "noGive")

func eCowSeesTreat_do(_id:String, _args:Array):
	if(_id == "noGive"):
		saynn("Ты отказываешь Милке.")
		talk(C_COW, "Aww..")
		saynn("Она пытается это скрыть... но ей явно грустно.")
		addCowTrust(-3)
	
	if(_id == "give"):
		playAnimation(StageScene.Beg, "pat", {pc=C_COW, npc=C_PC})
		saynn("Как тут можно сказать «нет»? Ты даешь Милке лакомство и ласково гладишь её.")
		addTreat(-1)
		saynn("Милка счастливо уплетает угощение и с восторгом прижимается носом к твоей руке!")
		talk(C_COW, RNG.pick([
			"Thank you, thank you, thank-youuuuu!",
			"It tasted SO GOOD!",
			"Thankiesssss!",
			"You are so kind!",
		]))
		addCowTrust(4)
	
	addContinue("setState", ["main"])


func eBullSeesTreat_state():
	addChar(C_BULL)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_BULL})

	saynn("Пип медленно подходит к тебе, низко опустив голову.")
	talk(C_BULL, RNG.pick([
		"I'm gonna be honest.. I'm hungry as fuck.. I don't wanna eat that stupid grass.. Do you maybe have something?",
		"I'm sorry for asking.. but do you maybe have something to eat? I hate the grass, man.. I hate it so much..",
	]))
	saynn("Он выглядит отчаявшимся.")
	
	addAction("Give treat", "Give Pip a treat", "give")
	addAction("No", "You'd rather save it", "noGive")
	addAction("Eat ass!", "Tease him. Your ass is a great treat", "eatAss")

func eBullSeesTreat_do(_id:String, _args:Array):
	if(_id == "noGive"):
		saynn("Ты отказываешь Пипу.")
		talk(C_BULL, RNG.pick([
			"Shit.. fine..",
			"I saw that you had a treat.. but it's okay.. shit..",
			]))
		saynn("Он направляется к травяному полю.")
		addBullTrust(-2)
	if(_id == "give"):
		playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_BULL})
		saynn("У тебя завалялось лишнее лакомство, и ты решаешь угостить его.")
		addTreat(-1)
		saynn("Пип хватает его и смакует, старательно облизывая со всех сторон... прежде чем вонзить в него зубы.")
		talk(C_BULL, RNG.pick([
			"Shit, that tastes too good.. Thank you, friend.",
			"Fuck me that tastes good.. Thank you.",
			"What are they putting into these.. I want more.. Thank you.",
		]))
		addBullTrust(3)
	if(_id == "eatAss"):
		playAnimation(StageScene.SexRimming, "fast", {pc=C_PC, npc=C_BULL, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		talk(C_PC, "My ass is a good treat, you know.")
		saynn("Он пожимает плечами.")
		talk(C_BULL, "Sure.")
		saynn("Ты смотришь на него в замешательстве... но он лишь упрямо продолжает, опускаясь на колени позади тебя и утыкаясь лицом в твою задницу, проводя длинным мускулистым языком по плоти твоей {pc.analStretch} звезды...")
		saynn("О черт... он просовывает язык внутрь, вылизывая тебя... всё твоё тело пробирает дрожь...")
		if(GM.pc.isWearingChastityCage()):
			saynn("Твой запертый член пульсирует в клетке... простата покалывает от стимуляции...")
		elif(GM.pc.hasReachablePenis()):
			saynn("Твой член пульсирует, сочась предэякулятом... простата покалывает от стимуляции...")
		elif(GM.pc.hasReachableVagina()):
			saynn("Твоя киска едва заметно пульсирует, источая соки...")
		saynn("Тихие стоны срываются с твоих губ, пока парень так тщательно тебя обслуживает...")
		saynn("Когда он заканчивает... ты остаешься дрожать. Пип встает и готовится уходить.")
		talk(C_PC, "Wait, want the treat?")
		talk(C_BULL, "Uh.. I guess I'm good now. Thanks.")
		addBullTrust(1)
	addContinue("setState", ["main"])

func eRandomStuff_state():
	var possible:Array = [
		"milkapip1",
		"milkapip2",
		"milkapip3",
		"milkapip4",
		"milkapip5",
		"milkapip6",
		"milkapip7",
	]
	
	var theEvent:String = RNG.pick(possible)
	if(theEvent == "milkapip1"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_BULL, "Can I ask something? Do you even understand that you're a slave?")
		talk(C_COW, "Moo? I'm a cow.. Cows can't be slaves..")
		talk(C_BULL, "You have a collar around your neck.")
		saynn("Милка пытается взглянуть на свою шею.")
		talk(C_COW, "Do I? Maybe I'm also a puppy then? A cowpup! Awoof-moo!")
		saynn("Парень вздыхает и просто оставляет её в покое.")
	if(theEvent == "milkapip2"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "Hope you're doing well, Pip!")
		talk(C_BULL, "I guess. Why are you asking? What do you want?")
		saynn("Милка моргает.")
		talk(C_COW, "Um.. I don't know.. uh.. I'm sorry..")
		saynn("Пип вздыхает.")
		talk(C_BULL, "It's okay, Milka.. It's okay. Thank you, hope you're well too.")
		saynn("Милка просияла, быстро ткнулась носом в красавца и убежала.")
	if(theEvent == "milkapip3"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "Pip, do bulls like carrots?")
		talk(C_BULL, "That's.. rabbits. I'm also a horse, not a bull.")
		saynn("Милка в замешательстве наклоняет голову, и её ушки забавно хлопают.")
		talk(C_COW, "Oh. What about sugar cubes then?")
		talk(C_BULL, "I'd eat one, sure.")
		saynn("Она ахает.")
		talk(C_COW, "Horses eat sugar cubes?! I want to be a horse too! Neigh-moo!")
		saynn("Пип просто закрывает глаза и вздыхает, стараясь не улыбнуться.")
	if(theEvent == "milkapip4"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "You look sad, Pip. Want me to share my milk with you?")
		talk(C_BULL, "That’s.. not really something I drink.")
		saynn("Милка наклоняет голову, а затем пожимает плечами.")
		talk(C_COW, "More for me then!")
		saynn("Она обхватывает свои груди руками и хихикает, пока Пип что-то бормочет себе под нос и отводит взгляд.")
	if(theEvent == "milkapip5"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		saynn("Милка подходит к Пипу, сжимая в пальцах крошечный цветок.")
		talk(C_COW, "For you!")
		talk(C_BULL, "Where did you even get this?")
		talk(C_COW, "Found it growing near the wall! It was lonely, so now it’s yours.")
		saynn("Пип колеблется, прежде чем взять его, явно не зная, как реагировать.")
		talk(C_BULL, "..Thanks, Milka.")
		saynn("Милка помогает привязать это к уху Пипа.")
		talk(C_COW, "Yay! Now you’re a fancy bull!")
	if(theEvent == "milkapip6"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		if(!cageRemoved):
			saynn("Милка сидит на корточках перед Пипом, не отрывая взгляда от его девственной клетки.")
			talk(C_BULL, "What are you doing?")
			talk(C_COW, "What is that?")
			saynn("Пип вздыхает.")
			talk(C_BULL, "Chastity cage. I can't breed anyone with it on.")
			saynn("Милка ахает.")
			talk(C_COW, "But what kind of bull are you if you can't breed?! How are you gonna breed me?!")
			talk(C_BULL, "I'm not a bull, okay? I'm a stud! These stupid owners bought me and are using me as a bull.")
			saynn("Милка прищуривается.")
			talk(C_COW, "Things just don't add up, you're right. You're not a bull.")
			saynn("Пип пожимает плечами.")
			talk(C_COW, "And you're not a stud also.. Maybe you're a cow, like me! Can you moo? Moo~.")
			saynn("Пип снова вздыхает.")
		else:
			saynn("Милка сидит на корточках перед Пипом, уставившись на его лошачий член.")
			talk(C_BULL, "What are you doing?")
			talk(C_COW, "Where is your thingie?")
			talk(C_BULL, "T.. Thingie?")
			saynn("Милка наклоняет голову набок.")
			talk(C_COW, "You know.. a metal thingie.")
			talk(C_BULL, "Chastity cage. Our friend here helped me break it.")
			saynn("Он кивает в твою сторону.")
			talk(C_COW, "OHH! Means you can breed now?!")
			talk(C_BULL, "I guess.")
			saynn("Милка улыбается.")
	if(theEvent == "milkapip7"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "Pip, can bulls purr?")
		talk(C_BULL, "No.")
		talk(C_COW, "Are you sure?")
		talk(C_BULL, "Very.")
		saynn("Милка прижимается к его груди и закрывает глаза.")
		talk(C_COW, "Hmm.. nope. No purring. You’re a broken bull.")
		talk(C_BULL, "..I feel broken, yeah.")
		talk(C_COW, "I still like you..")
		saynn("Милка нежно похлопывает его, а затем убегает вприпрыжку.")

	addContinue("setState", ["main"])



func eHelpCage_state():
	playAnimation(StageScene.TFLook, "crotch", {pc=C_BULL})
	aimCamera(L_BULL)
	
	saynn("Пип дергает за свою девственницкую клетку, пытаясь снять её... но в процессе лишь сильнее сдавливает яйца.")
	talk(C_BULL, "Ah, fuck.. God dammit.")
	
	addAction("Ignore", "Let him stay caged", "setState", ["main"])
	if(GM.pc.getStamina() > 0):
		addAction("Help", "Help Pip with his cage. Will use some stamina..", "doHelp")
	addAction("Bully", "Bully him and his locked cock!", "doBully")

func eHelpCage_do(_id:String, _args:Array):
	if(_id == "doHelp"):
		saynn("Вы решаете помочь ему.")
		talk(C_BULL, "Oh.. sure, you can try.")
		playAnimation(StageScene.ChairOral, "rub", {pc="pspip", npc="pc"})
		
		saynn(RNG.pick([
			"You inspect Pip's chastity cage and try to wiggle it off.",
			"You grip the base of Pip's cage and give it a firm twist, trying to loosen its hold on his sheath.",
			"You slide your nail into the lock of Pip's chastity cage and try to turn it.",
			"You find a little rock in the garden and start to carefully hit the lock of Pip's chastity cage.",
			"You sharpen a twig that you have found in the garden and try to use it as a lockpick inside Pip's chastity cage.",
			"You get a good grip on the metal pieces of Pip's chastity cage and use your full strength to try to bend them.",
		]))
		cageDamage += RNG.randf_range(0.1, 0.25)
		addStamina(-20)
		addBullTrust(1)
		
		sayPipLine()

		if(cageDamage < 0.35):
			saynn("Почти ничего не изменилось. Нужно продолжать попытки.")
		elif(cageDamage < 0.7):
			saynn("Клетка поддается, ты это чувствуешь. С каждой попыткой она все сильнее шатается.")
		else:
			saynn("Кажется, клетка вот-вот лопнет. Ты уже почти у цели.")
	if(_id == "doBully"):
		playAnimation(StageScene.SexFaceSitting, "sit", {pc=C_PC, npc=C_BULL, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Вместо того чтобы помочь, вы решаете подразнить его за то, что он в клетке.")
		if(GM.pc.hasPenis()):
			saynn("Вы прижимаете его к полу и садитесь ему на лицо, так что ваши яйца покоятся на его лбу."+(", your pussy coats his snout and cheeks with your juices" if GM.pc.hasReachableVagina() else "")+"!")
		elif(GM.pc.hasReachableVagina()):
			saynn("Вы прижимаете его к полу и садитесь ему на лицо, так что ваша киска заливает его морду и щеки соками!")
		else:
			saynn("Вы прижимаете его к полу и садитесь ему на лицо, вжимая промежность прямо в его морду!")
		talk(C_PC, RNG.pick([
			"Do you really need your cock? You're doing fine as is. Grade S buttslut.",
			"Bet you forgot what your own cock feels like. Doesn’t matter though, does it? Your ass does all the work.",
			"Such a pretty little femboy, all caged up. I almost feel bad.. almost.",
			"Silly stud, I thought you'd get used to being a fucktoy by now.",
		]))
		saynn("Его лицо слегка краснеет... но он пытается оттолкнуть вас.")
		talk(C_BULL, RNG.pick([
			"I'm a stud..",
			"I'm not a slut..",
			"I'm strong.. and virile..",
		]))
		addBullTrust(1)
		
	addContinue("setState", ["main"])


func pEventBullyByGirl_state():
	addChar(C_GIRL)
	addChar(C_GUY)
	aimCamera(L_CENTER)
	playAnimation(StageScene.Duo, "hurt", {npc=C_GIRL, npcAction="shove"})
	
	saynn("Софи отдает заказ шикарному волку... а затем спешит к вам.")
	saynn("Ты не успеваешь сделать и пары шагов назад, как она уже рядом — хватает тебя за воротник и грубо толкает обратно.")
	talk(C_GIRL, "WHY ARE YOU SO STUPID? ARGH!")
	saynn("Ого... ну и злющая сучка.")
	talk(C_GIRL, "I WILL CUT YOUR LEGS OFF IF I HAVE TO. HEAR ME?")
	saynn("К ней присоединяется второй владелец.")
	talk(C_GUY, "What's wrong, sweetheart?")
	saynn("Она хватает и его, тоже толкая назад.")
	talk(C_GIRL, "WHAT'S WRONG? We're almost got caught with FUCKING SLAVES in our basement, that's what! It's all your fault!")
	saynn("Парень слегка опускает голову... и осторожно подходит к своей партнерше, нежно обнимая её.")
	talk(C_GUY, "But we didn't get caught, did we?")
	saynn("Софи сбрасывает его руки...")
	talk(C_GIRL, "If you don't look after this bitch, it's only a matter of time. I don't wanna rot in a fucking prison.")
	saynn("Лео снова обнимает её, ласково прижимаясь щекой к её щеке.")
	talk(C_GUY, "My bad, love. Try to relax, take some rest. If we're gonna be careful, we will be able to pull through. Together.")
	saynn("Софи пронзает тебя яростным взглядом... но затем просто вздыхает.")
	talk(C_GIRL, "Fine.. I need a massage.")
	saynn("Лео расцветает в улыбке. Он берет Софи за руку и приглашает её следовать за собой.")
	saynn("Интересно.")
	addContinue("setState", ["main"])


func ePeekFirstEvent_state():
	aimCamera(L_SLEEP)
	addChar(C_GIRL)
	addChar(C_GUY)
	playAnimation(StageScene.Choking, "idle", {pc=C_GIRL, npc=C_PC})
	
	saynn("Прежде чем ты успеваешь заснуть, Софи врывается в твою камеру и прижимает тебя к стене.")
	talk(C_GIRL, "YOU FUCKED US, YOU KNOW THAT? I HOPE YOU'RE FUCKING HAPPY.")
	saynn("Она рычит и слегка сдавливает тебе горло... но вдруг резко убирает руки от твоей шеи.")
	talk(C_GIRL, "And I can't even hurt you. Aghh, I hate you so much.")
	saynn("Входит Лео, второй владелец.")
	talk(C_GUY, "Sofie? We're closed for the day but someone is still sitting behind the table.")
	talk(C_GIRL, "Yep. He knows about THIS BITCH.")
	saynn("Глаза парня округляются.")
	talk(C_GUY, "Oh shit.. I saw a holster on his belt. Are we screwed?")
	talk(C_GIRL, "I don't fucking know. But he said he wants to see {pc.him}.")
	addContinue("setState", ["ePeekFirstEvent2"])
	
func ePeekFirstEvent2_state():
	aimCamera(L_SLEEP)
	addChar(C_GIRL)
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_GIRL, bodyState={leashedBy=C_GIRL}})
	saynn("Софи достает поводок и пристегивает его к твоему ошейнику. Затем она заглядывает тебе прямо в глаза.")
	talk(C_GIRL, "No. Funny. Business. You hear me? I really don't wanna turn my cafe into a steakhouse.")
	saynn("Ты киваешь...")
	talk(C_GUY, "..it's our cafe, right, sweetheart?")
	saynn("Она рычит.")
	talk(C_GIRL, "If we fuck this up, it will be nobody's cafe. C'mon, try to look nice.")
	saynn("Софи начинает тянуть тебя к двери...")
	addContinue("setState", ["ePeekFirstEvent3"])

func ePeekFirstEvent3_state():
	aimCamera(L_TABLE)
	addChar(C_OFFICER)
	addChar(C_GIRL)
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_OFFICER, npcAction="sit", bodyState={hard=true}})
	saynn("Тебя выводят наружу... твои глаза жмурятся, пытаясь привыкнуть к яркому свету.")
	saynn("В кафе пусто... Время закрытия уже прошло. Все столики свободны... за исключением одного.")
	saynn("За стойкой ждет зрелый волк, его взгляд сосредоточен на чтении меню.")
	talk(C_GIRL, "There you go, sir. Here is the person that you saw. {pc.He} {pc.isAre} just our..")
	saynn("Голос Софи звучит гораздо... вежливее.")
	talk(C_OFFICER, "Thank you.")
	saynn("Софи и Лео переглядываются с озадаченными лицами. Ты стоишь неподвижно у стола, заложив руки за спину... атмосфера становится весьма... наэлектризованной.")
	talk(C_OFFICER, "I have a long night shift ahead of me. So.. a cup of coffee would be nice. Maybe a cupcake.")
	saynn("Владельцы снова обмениваются растерянными взглядами... пока Софи не тычет локтем Лео в бок.")
	talk(C_GUY, "Oh.. of course. I will get right to it, sir.")
	saynn("Лео спешит к стойке... в то время как офицер убирает меню и переключает внимание на тебя... на твое {pc.masc} тело... на твою {pc.breasts}..."+(" towards your {pc.penis}.." if GM.pc.hasPenis() else ""))
	talk(C_OFFICER, "I knew there was some secret to this place.. It's a crime.")
	talk(C_GIRL, "Uh.. it's nothing illegal.. we can explain..")
	saynn("Офицер обрывает её на полуслове.")
	talk(C_OFFICER, "Your food and coffee have no right to be SO good. Let me tell you, best in the whole galaxy. And I've been in a lot of these space cafes, believe me.")
	saynn("Софи не знает, как реагировать на такие слова... поэтому она просто кивает... всё еще сжимая в руке поводок, прикрепленный к твоему ошейнику.")
	talk(C_OFFICER, "I know that you have your secret.. ingredients. And I don't wanna reveal them to others. That would be extremely rude, wouldn't it?")
	talk(C_GIRL, "Uh.. y-yeah, it would be.")
	saynn("Офицер кивает.")
	talk(C_OFFICER, "All I'm asking for is.. some personal dinners. I will pay, of course. I will make it worth it for you.")
	saynn("Софи трет лицо свободной рукой... можно заметить легкую дрожь в её теле.")
	talk(C_GIRL, "Of course, sir. That can be arranged.")
	talk(C_OFFICER, "I don't wanna be push-y. I'm okay with getting the same treatment that everyone else does. I want to ask {pc.his} opinion.")
	saynn("Он перехватывает поводок посередине... и слегка тянет за него, приглашая тебя подойти ближе.")
	talk(C_OFFICER, "Do you want to service me?")
	saynn("Лео наконец возвращается с заказом офицера. Чашка кофе и несколько капкейков...")
	
	addAction("Agree", "Agree to service the offer", "doAgree")
	addAction("No", "This is too much", "noAgree")

func ePeekFirstEvent3_do(_id:String, _args:Array):
	if(_id == "noAgree"):
		GM.main.PSH.unlockEnding("MilkCafe", "officer") # In case people don't wanna sub to him
		gonnaHavePeekEvent = false
		peekState = PEEK_BULLIED_BY_GIRL
		aimCamera(L_SLEEP)
		playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
		saynn("Вы решаете отклонить его предложение. Пронзительный взгляд Софи буквально впивается в вас...")
		talk(C_OFFICER, "That's okay. I understand. I will just stay as a normal client.")
		talk(C_GIRL, "Okay. Now, if you excuse us..")
		saynn("Офицер кивает. Софи рывком тащит вас обратно в подвал... прямиком в вашу камеру.")
		talk(C_GIRL, "You are SO fucking lucky. I was gonna murder you on the spot. Now sleep.")
		saynn("Она уходит и запирает дверь камеры.")
		addAction("Sleep", "Now it's time to sleep.. for real", "SLEEP")
	if(_id == "doAgree"):
		addChar(C_OFFICER)
		gonnaHavePeekEvent = false
		playAnimation(StageScene.Duo, "kneel", {npc=C_OFFICER, npcAction="sit", bodyState={hard=true, leashedBy=C_OFFICER}})
		saynn("Вместо того чтобы что-то сказать, вы просто демонстрируете покорность, опускаясь перед ним на колени.")
		saynn("Офицер улыбается... и протягивает руку, чтобы почесать вас под подбородком.")
		talk(C_GIRL, "Do you still.. uh.. need us?")
		talk(C_OFFICER, "I think I will need one of you.")
		saynn("Софи снова тычет локтем напарнику в бок, заставляя его поскорее исчезнуть.")
		if(agreeMilk || !GM.pc.hasPenis()):
			saynn("Офицер берет чашку свежесваренного кофе и делает глоток.")
			talk(C_OFFICER, "I think it could use a bit more milk. Fresh milk.")
			saynn("Он ставит чашку почти у самого края стола... совсем рядом с вашей грудью.")
			talk(C_GIRL, "Of course, I will fix it right away.")
			addAction("Fresh milk..", "See what Sofie will do with your breasts", "setState", ["ePeekFirstEventMilk"])
		else:
			saynn("Офицер берет капкейк... и подносит его ближе, внимательно разглядывая.")
			talk(C_OFFICER, "Looks a bit.. dry to me. Could use some more cream. Fresh cream. What do you think?")
			saynn("Он ставит капкейк на край стола... совсем рядом с тобой.")
			talk(C_GIRL, "Of course, I will fix it right away.")
			saynn("Софи убегает, чтобы схватить кое-что... стрэп-он.")
			addAction("Fresh cream..", "See what Sofie will do with you", "setState", ["ePeekFirstEventSeed"])

func ePeekFirstEventMilk_state():
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.BreastGroping, "grope", {pc=C_GIRL, npc=C_PC, npcCum=true, npcBodyState={naked=true,hard=true}})
	GM.pc.milk()
	saynn("Софи кивает офицеру и мягко берет тебя за руку, направляя к столу.")
	saynn("Она усаживает тебя у самого края, так что твои {pc.breasts} оказываются прямо под дымящейся чашкой офицера.")
	saynn("Медленно Софи обхватывает твои груди ладонями и начинает ласкать и поглаживать их.")
	saynn("Её большие пальцы надавливают на соски, перекатывая их из стороны в сторону, пока ты не начинаешь дрожать, а твои бугорки не становятся твердыми и сверхчувствительными.")
	saynn("На каждом соске образуется капля сливочного {pc.milk}, которая затем стекает прямо в чашку офицера.")
	saynn("Увидев это, Софи начинает доить тебя, сжимая грудь мягкими, но уверенными движениями... отчего {pc.milk} брызжет прямо в кофе.")
	saynn("Ты тихо стонешь, ерзая под её руками, пока волны удовольствия и смущения накрывают тебя. Офицер не может оторвать от тебя взгляда.")
	saynn("Спустя некоторое время в чашке образуется аппетитный слой твоего теплого {pc.milk}. Офицер одобрительно кивает, подносит чашку к губам и делает глоток.") 
	talk(C_OFFICER, "Mmm.. that is perfect.")
	saynn("Глаза Софи загораются, когда она слышит это.")
	if(agreeSeed && GM.pc.hasPenis()):
		saynn("Затем офицер берет капкейк... и подносит его ближе, внимательно осматривая.")
		talk(C_OFFICER, "Looks a bit.. dry to me. Could use some more cream. What do you think?")
		saynn("Он кладет капкейк обратно.")
		talk(C_GIRL, "Of course, sir. I will fix it right away.")
		saynn("Софи убегает, чтобы схватить кое-что... стрэп-он.")
		addAction("Fresh cream..", "See what Sofie will do with you", "setState", ["ePeekFirstEventSeed"])
	else:
		addContinue("setState", ["ePeekFirstEvent4"])

func ePeekFirstEventSeed_state():
	addChar(C_OFFICER)
	addChar(C_GIRL)
	addStrapon(C_GIRL)
	playAnimation(StageScene.SexFreeStanding, "fast", {pc=C_GIRL, npc=C_PC, pcCum=true, npcCum=true, bodyState={naked=true,hard=true}, npcBodyState={naked=true,hard=true}})
	GM.pc.milkSeed()
	GM.pc.orgasmFrom(C_GIRL)
	saynn("Софи затягивает на бедрах ремни страпона, и резиновый член у её талии нетерпеливо подпрыгивает.")
	saynn("Она хватает тебя за запястья и уводит их за спину, одновременно надавливая тебе на лопатки и заставляя наклониться вперед — так что твой член зависает прямо над капкейком...")
	saynn("Решительным движением она совмещает свой новый резиновый ствол с твоим жаждущим анусом.")
	saynn("Мощным толчком Софи вгоняет страпон глубоко в тебя. Ты ахаешь, когда кончик упирается в твою точку удовольствия..."+("making your cock go hard instantly." if !GM.pc.isWearingChastityCage() else "making your caged cock attempt to go hard in its prison."))
	saynn("Она начинает медленный, размеренный ритм: каждый толчок массирует твою простату всё глубже, заставляя тебя извиваться.")
	talk(C_PC, "M-mmh.. mmm..")
	saynn("Предэякулят капает с твоего члена, пока её игрушка входит и выходит из тебя. Офицер с огромным интересом наблюдает за тем, как тебя трахают.")
	saynn("Софи ускоряется, вколачивая страпон в тебя всё сильнее и жестче. Твои стоны становятся громче, эхом разносясь по кафе.")
	saynn("Вскоре твоя простата раздувается и становится твердой. И вот, с криком наслаждения, ты начинаешь кончать... Густые струи крема пульсируют из твоего члена, попадая прямо на капкейк.")
	saynn("Софи держит его неподвижно, позволяя твоему члену добавить еще один слой поверх уже имеющейся глазури.")
	saynn("Когда ты заканчиваешь... офицер наклоняется вперед и хватает капкейк со стола... прежде чем откусить добрый кусок.")
	talk(C_OFFICER, "Mmm.. that’s rich. Incredible.")
	saynn("Услышав это, Софи улыбается... пока ты тяжело дышишь, чувствуя опустошенность в яичках.")
	addContinue("setState", ["ePeekFirstEvent4"])

func ePeekFirstEvent4_state():
	removeStrapon(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_GUY, npc=C_OFFICER, npcAction="sit"})
	saynn("Офицер наслаждается остатком своего... ужина... потягивая кофе и доедая капкейк.")
	saynn("Ты стоишь неподалеку... но Софи и Лео держатся на несколько шагов в стороне, чтобы не мешать трапезе.")
	talk(C_OFFICER, "Alright, I think I can pay now.")
	extraProfit += 10000
	saynn("Лео быстро подходит к столу... со счетом в руках.")
	talk(C_OFFICER, "Would this be enough, perhaps?")
	saynn("Офицер достает кредитный чип... и протягивает его парню. Глаза Лео округляются.")
	talk(C_GUY, "Sir.. this is way too much.")
	saynn("Офицер улыбается.")
	talk(C_OFFICER, "The rest is a tip. I really enjoyed the service. I hope we can do this again sometime. Eh?")
	saynn("Софи подбегает к Лео и шепчет ему на ухо.")
	talk(C_GIRL, "..take the fucking chip already and go, don't be stupid.. take the slave too..")
	saynn("Лео кивает офицеру... и берет твой поводок.")
	talk(C_GUY, "Thank you, sir. We would love to have you here again.")
	saynn("Офицер кивает в ответ... и наблюдает, как Лео ведет тебя обратно на кухню.")
	
	addContinue("setState", ["ePeekFirstEvent5"])

func ePeekFirstEvent5_state():
	aimCamera(L_SLEEP)
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {npc=C_GUY, bodyState={leashedBy=C_GUY}})
	
	saynn("Лео возвращает тебя в камеру. Ты чувствуешь... сильную усталость.")
	talk(C_GUY, "You did very well. Thank you..")
	saynn("Он снимает поводок с твоего ошейника.")
	talk(C_GUY, "Sleep well.")
	
	addAction("Sleep", "Time to sleep!", "SLEEP")


func ePeekSecondEvent_state():
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL, bodyState={leashedBy=C_GIRL}})
	saynn("Ты не планировала спать... и, похоже, была права.")

	saynn("В камеру входит Софи и тут же пристегивает поводок к твоему ошейнику.")

	talk(C_GIRL, "You're in luck, the guy wants to see you again.")
	saynn("Она поднимает тебя с пола и смахивает пыль с твоей задницы. Свободной рукой она берет тебя за подбородок.")

	talk(C_GIRL, "If you don't want to be in trouble, you are gonna do everything that he wants you to do. Like a good slut.")
	saynn("Кажется, на этот раз выбора у тебя будет немного...")
	addAction("Follow", "See where she brings you", "setState", ["ePeekSecondEvent2"])

func ePeekSecondEvent2_state():
	aimCamera(L_TABLE)
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.ChairOral, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true,hard=true}, npcBodyState={naked=true, hard=true}})
	GM.pc.freeMouthDeleteAll()
	GM.pc.freeHandsDeleteAll()
	GM.pc.freeArmsDeleteAll()
	saynn("Софи выводит тебя в зал кафе. Кафе уже закрыто, так что вокруг никого нет... кроме него. Парень сидит за своим привычным столиком, уже уплетая капкейк и наслаждаясь кофе.")

	saynn("Ты опускаешься на колени возле его стола... почему-то это кажется правильным.")

	talk(C_GIRL, "Your dessert has arrived, sir.")
	talk(C_OFFICER, "Wonderful.")
	saynn("Десерт? Не думаешь, что тебя когда-нибудь так называли...")

	saynn("Офицер протягивает руку и берет тебя за подбородок; от мягкого прикосновения его большой мужской ладони внутри всё начинает трепетать. Будем надеяться, что этот десерт не начнет таять слишком быстро.")

	talk(C_OFFICER, "Are they treating you well here?")
	saynn("Он спрашивает тебя... От этого внезапного вопроса ты опускаешь глаза. Ты буквально кожей чувствуешь сверлящий взгляд Софи за спиной...")

	saynn("Требуется время, чтобы заставить себя сделать жест... но ты киваешь... медленно... едва заметно. Софи за твоей спиной облегченно вздыхает.")

	talk(C_OFFICER, "I see. It's just.. would be a shame to see such a treat go to waste.")
	talk(C_GIRL, "We take good care of {pc.him}.")
	saynn("Офицер кивает... делает глоток кофе... а затем осторожно расстегивает ширинку, обнажая свой полуэрегированный член.")

	saynn("Вид его плоти так близко... заставляет рот наполняться слюной. Каждая вена, каждая складка, острое острие, запах... всё это заставляет тебя жаждать служения.")
	addContinue("setState", ["ePeekSecondEvent3"])

func ePeekSecondEvent3_state():
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.ChairOral, "stroke", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true,hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Ты ныряешь под стол... и устраиваешься между его ног.")

	saynn("Его член — словно магнит... увидев его, ты обхватываешь его рукой, обхватывая ствол пальцами.")

	saynn("Похоже, офицера не смущает твоя смелость. Ты замечаешь его мимолетную улыбку, пока он невозмутимо продолжает свой ужин.")

	saynn("Не встретив сопротивления, ты переходишь к делу: твоя рука скользит по блестящей поверхности, заставляя член наливаться твердостью. Ты во все глаза наблюдаешь, как он наполняется кровью, вены вздуваются, а на кончике появляется первая капля предэякулята.")

	talk(C_GIRL, "If you need something, I'm here. Just so you know.")
	talk(C_OFFICER, "I think all my current needs are satisfied, thank you.")
	saynn("Ты продолжаешь ласкать его, твоя рука скользит вверх и вниз по всей длине, а его яички при этом слегка напрягаются.")

	saynn("Пока он ест свой капкейк, несколько крошек падают ему на штаны... но одна из счастливчиков приземляется прямо на его член, плавая в маленькой лужице его предэякулята... Так и хочется её украсть...")
	addContinue("setState", ["ePeekSecondEvent4"])
	
func ePeekSecondEvent4_state():
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.ChairOral, "suck", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true,hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Ты подносишь голову ближе к самой головке... и затем... быстрым движением языка... слизываешь крошку, пропитанную его слегка солоноватой смазкой.")

	saynn("Он замечает это... и намеренно рассыпает еще несколько крошек по всему своему члену.")

	saynn("И тогда... вместо того чтобы охотиться за каждой по отдельности... ты просто приоткрываешь губы и заглатываешь всю головку его члена целиком; твой язык мгновенно начинает поиски, скользя по пульсирующей поверхности и покрывая её своей слюной.")

	saynn("Член входит всё глубже, головка уже касается задней стенки твоей глотки и направляется вниз по твоему узкому горлу. Прежде чем сработает рвотный рефлекс, ты решаешь слегка отстраниться... а затем снова заглатываешь часть его члена.")

	saynn("Твои уши улавливают его тихий рык. Каждый раз, когда твой язык касается чувствительной головки, его яички снова напрягаются, а ствол подпитывает тебя всё новой порцией смазки.")

	talk(C_OFFICER, "Actually.. Do you have.. chains.. perhaps?")
	talk(C_GIRL, "Yes, plenty. Mmh, may I ask why do you need them?")
	saynn("Офицер тихо посмеивается и в несколько глотков допивает свой кофе.")

	talk(C_OFFICER, "I'd like to enjoy my dessert on the table, not under it.")
	talk(C_GIRL, "Of course, sir.")
	addContinue("setState", ["ePeekSecondEvent5"])
	
func ePeekSecondEvent5_state():
	playAnimation(StageScene.SexOralTable, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Возвращается Софи с цепями... и помогает привязать тебя к столу так, чтобы твоя голова свисала с края.")

	talk(C_OFFICER, "Thank you.")
	saynn("Офицер встает и подходит к тебе... его твердый член нависает прямо над твоим лицом, а головка капает тебе на подбородок.")

	talk(C_OFFICER, "I will try to be careful.")
	saynn("Медленно он начинает заталкивать свой член тебе в рот; головка скользит между зубов, задевает твой мягкий язык, а затем пробирается к задней стенке горла, уходя глубоко вниз.")

	saynn("Ты чувствуешь, как он растягивает тебя... твои кулаки сжимаются, пока ты пытаешься отвлечься от рвотного рефлекса. Но в конце концов он берет свое: горло внезапно сжимается вокруг его члена, издавая влажные звуки позывов.")

	talk(C_OFFICER, "Mhh.. that felt good. May I?")
	saynn("Твои кулаки всё еще сжаты... но большие пальцы невольно дергаются...")
	addContinue("setState", ["ePeekSecondEvent6"])

func ePeekSecondEvent6_state():
	playAnimation(StageScene.SexOralTable, "suck", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Офицер начинает двигать бедрами, почти полностью вынимая член... а затем снова мощно всаживает его, растягивая твое горло еще сильнее.")

	saynn("Его ладони ложатся тебе на шею, он прощупывает тот бугорок, который образуется при каждом прохождении его плоти.")

	saynn("Ты мельком видишь Софи. Её злобные глаза молча следят за основным действием, проверяя, не сломлена ли ты окончательно.")

	saynn("Ты всё сильнее давишься и задыхаешься от этого члена... и всё же... тебе всё мало. Одинокие слезы текут по твоим щекам, пока твое горло служит для его удовольствия. Всё твое тело хочет извиваться... но цепи удерживают тебя неподвижно ради него.")

	talk(C_OFFICER, "Yeah.. such a nice treat. Could use some cream stuffing, huh?")
	saynn("Да...")
	addContinue("setState", ["ePeekSecondEvent7"])

func ePeekSecondEvent7_state():
	playAnimation(StageScene.SexOralTable, "suckfast", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Он ускоряется, трахая твое горло еще быстрее, по-настоящему испытывая твои пределы. Поскольку большую часть времени твой трахеальный проход перекрыт гигантским членом, воздуха становится катастрофически мало... твои внутренние стенки сжимаются вокруг ствола еще сильнее, заставляя парня стонать от наслаждения.")

	saynn("Ты видишь, как его узел раздувается... становясь всё толще, пока кровь приливает к его паху. Он делает несколько попыток вогнать его внутрь... но решает не вывихивать тебе челюсть.")

	talk(C_OFFICER, "Hope you are ready..")
	addContinue("setState", ["ePeekSecondEvent8"])
	
func ePeekSecondEvent8_state():
	GM.pc.gotThroatFuckedBy(C_OFFICER)
	GM.pc.cummedInMouthBy(C_OFFICER)
	playAnimation(StageScene.SexOralTable, "suckinside", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Последним мощным толчком он заталкивает почти всю свою длину; его узел упирается тебе в губы, а член начинает пульсировать у тебя в горле.")

	saynn("Он запрокидывает голову и рычит... когда его член начинает извергать волны кремовой спермы прямо на твои внутренние стенки, проникая глубоко в живот.")

	talk(C_OFFICER, "Ngh-h..")
	saynn("Пока он занят тем, что наполняет тебя своей кончой, ты начинаешь замечать, как по краям зрения подступает тьма, всё становится всё более размытым. И всё же ты продолжаешь служить, жадно заглатывая всё, что дает тебе его член.")
	addContinue("setState", ["ePeekSecondEvent9"])

func ePeekSecondEvent9_state():
	playAnimation(StageScene.SexOralTable, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Когда офицер заканчивает, он наконец вынимается, позволяя тебе наконец вздохнуть. Ты кашляешь... кашляешь много... жадно хватая ртом каждый глоток воздуха.")

	talk(C_OFFICER, "What a treat. Could be the best treat in the whole galaxy.")
	saynn("Софи подходит к вам двоим.")

	talk(C_GIRL, "I'm glad you have enjoyed our offerings.")
	saynn("Он кивает... и протягивает ей кредитный чип.")

	talk(C_OFFICER, "Will this be enough?")
	saynn("Она быстро проверяет его. На нем явно крупная сумма... и всё же... её губы сжимаются в узкую линию.")

	talk(C_GIRL, "Well..")
	saynn("Без лишних слов офицер просто протягивает второй чип.")

	talk(C_OFFICER, "Best treat, like I said.")
	saynn("Софи берет чип и кивает.")

	talk(C_GIRL, "Thank you. I will wrap everything up.")
	saynn("Офицер снова кивает.. застегивает ширинку.. и направляется к выходу, бросив на тебя быстрый взгляд и улыбнувшись уже в дверях.")
	addContinue("setState", ["ePeekSecondEvent10"])

func ePeekSecondEvent10_state():
	aimCamera(L_SLEEP)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
	saynn("После этого ужина Софи возвращает тебя в камеру.")

	talk(C_GIRL, "Next time, put a little more passion into it. We got bills to pay.")
	saynn("Ты не отвечаешь.. просто ждешь, когда она уйдет.")
	
	gonnaHavePeekEvent = false
	addAction("Sleep", "Time to sleep", "SLEEP")




func ePeekThirdEvent_state():
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL, bodyState={leashedBy=C_GIRL}})
	saynn("Ты знал, что Софи придет за тобой после закрытия кафе. Ты этого ждал.")

	talk(C_GIRL, "C'mon, you know the drill.")
	saynn("Она пристегивает поводок к твоему ошейнику и тянет за него, приглашая следовать за ней.")

	talk(C_GIRL, "I'm expecting a lot of credits. Got it, slut?")
	saynn("Ты киваешь.. а что еще тебе остается делать?")
	
	addContinue("setState", ["ePeekThirdEvent2"])

func ePeekThirdEvent2_state():
	aimCamera(L_TABLE)
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.ChairOral, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true,hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Ты следуешь за этой жадной девчонкой в обеденную зону и подходишь к привычному столику. Волк уже ждет тебя.")

	saynn("Кредиты сами себя не заработают.. Не дожидаясь команд, ты опускаешься на колени и забираешься под стол; твои руки находят молнию и извлекают яички и кожаный чехол офицера. После нескольких нежных поглаживаний кончик его члена начинает показываться наружу.. а затем, благодаря твоим ласкам, из него выходит и остальная часть ствола.")

	talk(C_OFFICER, "I thought I'm the hungry one here. Hah.")
	saynn("Софи вежливо улыбается, держа в свободной руке меню.")

	talk(C_GIRL, "Would you like to order something, sir?")
	talk(C_OFFICER, "You know.. I'm pretty hungry tonight. I could go for a whole cake. Or a pie.")
	saynn("Софи приподнимает бровь и откашливается.")

	talk(C_GIRL, "Hm.. we would have to check if we still have some left.")
	saynn("Пока ты усердно ласкаешь его член языком, он запускает руку под стол, чтобы похлопать тебя.")

	talk(C_OFFICER, "No worries. I already have everything I need.")
	saynn("Его улыбка... кажется, он задумал что-то эдакое.")

	addContinue("setState", ["ePeekThirdEvent3"])

func ePeekThirdEvent3_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Офицер хватает поводок и манит тебя вылезти из-под стола... а затем заставляет встать на него лицом вниз, так что твой {pc.thick} зад торчит во все стороны.")

	saynn("Он кладет свой твердый член на твои ягодицы и начинает медленно водить им вперед-назад.")

	talk(C_OFFICER, "What a treat, no reason to keep you on the dirty floor. Right?")
	saynn("Ты оглядываешься через плечо... и видишь его улыбку... а также строгий взгляд Софи. Ты киваешь...")

	saynn("Офицер проводит кончиком своего члена по твоей "+str("holes.. your pussy and tailhole" if GM.pc.hasReachableVagina() else "{pc.anusStretch} tailhole")+".. его предэякулят капает на твою чувствительную плоть. "+str("He ends up guiding his cock down to your needy slit, the tip pressing against the folds.. before spreading them wide." if GM.pc.hasReachableVagina() else "He takes some time teasing you before guiding his cock down to your needy star, the tip pressing against it.. before spreading it slightly.")+"")

	addContinue("setState", ["ePeekThirdEvent4"])

func ePeekThirdEvent4_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "sex", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Резким толчком он входит в твою "+str("velvet" if GM.pc.hasReachableVagina() else "inviting")+" теплоту. Дюйм за дюймом его член исследует твои влажные внутренние стенки, с каждым разом проникая всё глубже.")

	talk(C_OFFICER, "That's it.. Take it all.")
	saynn("Он задает медленный... но невероятно приятный ритм, и каждый толчок погружает тебя всё глубже в состояние покорной секс-игрушки... Сквозь губы вырываются тихие стоны, пока тебя трахают прямо на столе, а твои руки судорожно вцепились в его края.")

	addContinue("setState", ["ePeekThirdEvent5"])

func ePeekThirdEvent5_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "fast", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Это приятно... обоим: и тебе, и ему. Чувствуя, как твоя "+str("{pc.pussyStretch} pussy" if GM.pc.hasReachableVagina() else "{pc.analStretch} ass")+" отлично справляется с его членом, парень ускоряется, всаживаясь всё глубже и сильнее.")

	talk(C_PC, "Ah.. ah..")
	talk(C_OFFICER, "Such a nice pussy." if GM.pc.hasReachableVagina() else "Such a nice ass.")
	saynn("От этого звука твои внутренние мышцы сжимаются, а влажные стенки плотно обхватывают его ствол, пока он продолжает трахать тебя, преодолевая трение.")

	saynn("Ты вряд ли сможешь долго это терпеть... ты вот-вот кончишь.")

	addContinue("setState", ["ePeekThirdEvent6"])

func ePeekThirdEvent6_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "inside", {pc=C_OFFICER, npc=C_PC, pcCum=true, npcCum=true, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	if(GM.pc.hasReachableVagina()):
		GM.pc.gotVaginaFuckedBy(C_OFFICER)
		GM.pc.cummedInVaginaBy(C_OFFICER)
	else:
		GM.pc.gotAnusFuckedBy(C_OFFICER)
		GM.pc.cummedInAnusBy(C_OFFICER)
	GM.pc.orgasmFrom(C_OFFICER)
	saynn("Ты чувствуешь, как основание его члена раздувается — узел наполняется кровью. Без предупреждения он сильнее прижимает тебя к столу... а затем одним мощным толчком вгоняет в тебя всю свою длину... вместе с узлом... заполняя тебя до краев.")

	talk(C_OFFICER, "Grrhh..")
	talk(C_PC, "Ahhh-h!..")
	saynn("Теплое семя густыми волнами заливает твою "+str("womb" if GM.pc.hasReachableVagina() else "butt")+"стол содрогается от того, как твое тело извивается, не в силах вместить в себя такой объем... Вскоре ты кончаешь, и твоя "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole")+" пульсирует и сжимается вокруг его пульсирующего узла, высасывая каждую каплю его горячей спермы.")

	saynn("Стимуляция слишком сильная... твои глаза закатываются, а громкие стоны эхом разносятся по пустому кафе..."+str("Your pussy squirts from your g-spot getting smashed by his fat orb" if GM.pc.hasReachableVagina() else "")+""+str("Your {pc.penis} squirts with {pc.cum} from your prostate getting smashed by his fat orb" if (!GM.pc.hasReachableVagina() && GM.pc.hasPenis()) else "")+""+str("Your tailhole keeps pusling" if (!GM.pc.hasReachableVagina() && !GM.pc.hasPenis()) else "")+", твои ноги дико дрожат, пока волк позади продолжает осеменять тебя, опустошая свои яйца прямо внутри тебя.")

	saynn("Когда всё заканчивается, вы оба дрожите на столе... оба совершенно измотанные.")

	talk(C_OFFICER, "That.. I really needed that.")
	saynn("Пока ты всё ещё корчишься от ощущения его полной длины внутри тебя, Софи подходит к вам двоим.")

	talk(C_GIRL, "I hope you have been satisfied with our selection.")
	saynn("Он усмехается.")

	talk(C_OFFICER, "I'm still very much hungry, miss.")
	
	addContinue("setState", ["ePeekThirdEvent7"])
	
func ePeekThirdEvent7_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "lick", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Он вырывает свой узел из твоей "+str("pussy" if GM.pc.hasReachableVagina() else "ass")+".. прежде чем опуститься на колени и уткнуться лицом в твою "+str("crotch" if GM.pc.hasReachableVagina() else "butt")+".")

	saynn("Волк... он начинает ласкать тебя языком... ты чувствуешь, как его мощный язык скользит по твоей "+str("folds" if GM.pc.hasReachableVagina() else "tailhole")+".. прежде чем проникнуть в залитое кремом отверстие и приняться вылизывать внутренние стенки.")

	talk(C_GIRL, "Of course, sir. Enjoy your.. cake.")
	saynn("И он так и делает: вылизывает тебя изнутри, вонзая язык туда-сюда, заглатывая твои соки... а заодно и своё семя. Похоже, этот парень не из привередливых...")

	saynn("Такое обращение... это так приятно... твои тихие стоны заставляют его хотеть ещё. Он оставляет крем внутри тебя почти нетронутым... и просто завершает процесс, покрывая твою "+str("folds" if GM.pc.hasReachableVagina() else "star")+" ещё слоем, проводя языком по всем изгибам.")

	saynn("Когда он заканчивает, он поднимается и нежно ласкает твою задницу.")

	talk(C_OFFICER, "So tasty.")
	
	addContinue("setState", ["ePeekThirdEvent8"])
	
func ePeekThirdEvent8_state():
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_OFFICER, npc=C_GIRL})
	saynn("Волк поворачивается к девушке и начинает шарить по карманам, доставая кредитные чипы.")

	saynn("Но прежде чем протянуть их леди... он замирает. Софи слегка вздрагивает бровями и надувает губы.")

	talk(C_OFFICER, "I'm aware of your cafe's.. situation.")
	saynn("Софи слегка наклоняет голову, теперь уже с легким беспокойством.")

	talk(C_GIRL, "What do you mean exactly?")
	talk(C_OFFICER, "The numerous debts. You did what you did.. to survive. You resorted to using illegal slaves.")
	saynn("Он бросает на тебя быстрый взгляд. Ты всё ещё лежишь на столе, тяжело и часто дыша...")

	saynn("Софи часто моргает... можно буквально почувствовать, что её сердце колотится быстрее твоего. Лео тоже подходит к столу, внимательно прислушиваясь.")

	talk(C_GIRL, "Uh.. there was.. no other choice really.")
	talk(C_OFFICER, "I ain't planning to blackmail you, don't worry. And you ain't going to jail, not because of me. What I want to do.. is make an offer.")
	saynn("Лео и Софи переглядываются.")

	talk(C_GUY, "An offer?")
	talk(C_OFFICER, "I give you enough credits to pay off your debts. A clean slate, a new life. And in exchange..")
	saynn("Его мужская рука ложится тебе на спину... и нежно поглаживает её.")

	talk(C_OFFICER, "I get to keep this cutie pie.")
	saynn("Лео и Софи снова смотрят друг на друга, их глаза расширены от изумления. Они просто не могут в это поверить.")

	talk(C_GUY, "Oh..")
	saynn("Наступает короткая тишина... пока в голове у девушки крутятся шестеренки мыслей.")

	talk(C_GIRL, "How about.. ten percent on top maybe?.. We will really-really miss this cutie pie.")
	talk(C_GUY, "Sofie..")
	talk(C_GIRL, "Tshhh.. shut up..")
	saynn("Серьезно? Даже волк ошарашен такими попытками поторговаться.")

	talk(C_OFFICER, "I can give five.")
	talk(C_GIRL, "Deal.")
	saynn("Офицер достает еще несколько ярких кредитных чипов... проверяет, верно ли посчитана сумма... а затем протягивает их Софи. Взамен она передает поводок, пристегнутый к твоему ошейнику.")

	saynn("Как только сделка завершена, пара быстро скрывается на кухне. Только Лео напоследок машет тебе рукой... прежде чем Софи утягивает его с глаз долой.")

	addContinue("setState", ["ePeekThirdEvent9"])

func ePeekThirdEvent9_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.Duo, "stand", {npc=C_OFFICER, bodyState={leashedBy=C_OFFICER}})
	aimCamera(L_DOCKS)
	saynn("Офицер помогает тебе подняться... а затем пристегивает поводок к твоему ошейнику...")

	talk(C_OFFICER, "Well.. let's go then.")
	saynn("Ты киваешь и следуешь за волком вниз, к докам. Глянув в окно, ты видишь его корабль... он огромный... едва вписывается в ангар.")

	saynn("Твой взгляд постоянно натыкается на эмблемы AlphaCorp. Кем бы он ни был, он явно занимает высокое положение в пищевой цепочке.")

	saynn("Ты подходишь к стыковочному порту. Он открывает шлюз... и приглашает тебя войти. Ты бросаешь последний взгляд на кафе... прежде чем переступить порог.")

	addContinue("ENDING", ["end_officer"])




func intro_state():
	aimCamera(L_DOCKS)
	GM.pc.setLocation(L_CENTER)
	playAnimation(StageScene.Solo, "kneel")
	saynn("Ты оказываешься... внутри чего-то, напоминающего грузовой отсек космического грузовика. Вокруг разбросано несколько ящиков, большинство из них заперты. Тебе удается заглянуть в один из них и обнаружить... фрукты и овощи. Странно.")

	saynn("Помимо груза... ты здесь совсем одна.")

	saynn("Космический грузовик определенно куда-то движется... Ты осматриваешься повнимательнее.")

	saynn("Отсюда есть два выхода — две двери. Одна широкая, предназначенная для разгрузки товаров... и ведет прямиком в открытый космос. Вторая — маленькая, скорее всего, ведет в кабину пилота. Она заперта. За ней слышны чьи-то голоса... но больше ничего.")

	saynn("Пожалуй, стоит просто подождать и посмотреть, что будет дальше...")

	addContinue("setState", ["intro2"])

func intro2_state():
	playAnimation(StageScene.Duo, "stand", {pc=C_GIRL, npc=C_GUY})
	saynn("Вскоре грузовой корабль начинает швартовку. После... не самого плавного... процесса стыковки двигатели наконец глохнут.")

	saynn("В грузовой отсек входят... два дракона... Девушка начинает говорить первой.")

	talk(C_GIRL, "You're still alive. Good. Gonna start slow. Here is the deal. In case you haven't noticed it yet, we have bought you.")
	saynn("Двое против одного... а ты, мягко говоря, не вооружен. Кто знает, сколько еще народу может прятаться за стеной.")

	talk(C_GIRL, "Since you are now our property.. you are gonna do exactly what we tell you to do. Otherwise.. Show {pc.him}, Leo.")
	talk(C_GUY, "Sure.")
	saynn("Парень достает... что-то похожее на складную дубинку... но с маленькой вилочкой на конце. Он сжимает рукоять... и между зубцами вилки проскакивают маленькие разряды электричества.")

	talk(C_GUY, "If this touches you, it will hurt.")
	saynn("Ну да, это и так очевидно.")

	talk(C_GIRL, "Now. I'm gonna put a leash on you. Leo?")
	talk(C_GUY, "I got you.")
	talk(C_GIRL, "You fucking better.")
	saynn("Девушка... Софи... достает поводок и тянется, чтобы пристегнуть его к твоему ошейнику. При этом парень готов ударить тебя в любой момент.")

	saynn("Ты стоишь смирно и позволяешь им делать всё, что им нужно.")

	talk(C_GIRL, "Now grab a crate.")
	saynn("Они не слишком тяжелые... но и не совсем легкие. После того как ты это сделаешь, девушка начинает сверлить парня взглядом... явно сбивая его с толку.")

	talk(C_GUY, "Sofie?")
	talk(C_GIRL, "Grab one too, don't be a lazy fuck.")
	talk(C_GUY, "Alright.")
	saynn("Парень убирает оружие, хватает ящик и идет следом за тобой.")

	addContinue("setState", ["intro3"])

func intro3_state():
	addChar(C_GIRL)
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL, flipNPC=true, bodyState={leashedBy=C_GIRL}})
	aimCamera(L_COUNTER)
	saynn("Вы выходите из грузового космолета... и видите что-то вроде доков. Есть еще несколько стыковочных портов... но сейчас все они свободны. Что бы это место ни было, трафик здесь явно невелик.")

	saynn("Следуя вдоль доков, все еще на поводке, вы начинаете замечать... строение в самом конце пути. Можно сказать, что это космическая станция... но это было бы сильным преувеличением. Оно размером всего лишь с двухэтажное здание.")

	saynn("Сквозь окна доков трудно разглядеть детали... но вы замечаете гигантскую неоновую вывеску над строением. На ней написано... «Ежедневная капля».")

	saynn("Внутри... вы видите обеденную зону с несколькими розовыми столиками... и стойку, за которой скрывается маленькая кухня.")

	saynn("Девушка ведет вас за стойку... к двери в глубине кухни.")

	addContinue("setState", ["intro4"])

func intro4_state():
	aimCamera(L_CENTER)
	addChar(C_GIRL)
	addChar(C_GUY)
	saynn("За дверью... обнаруживается небольшая лестница, уходящая во тьму.")

	talk(C_GIRL, "Keep going, animal.")
	saynn("Животное? Вы осторожно спускаетесь по ступеням, неуклюже заглядывая из-за ящика, который несете в руках.")

	saynn("Ваши глаза начинают постепенно привыкать к темноте. Пока это происходит, они начинают различать какие-то силуэты. Прежде чем вы успеваете разглядеть детали, девушка резко дергает за поводок.")

	talk(C_GIRL, "You will get a chance to say hi later.")
	
	addContinue("setState", ["intro5"])
	
func intro5_state():
	aimCamera(L_SLEEP)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
	saynn("Вы следуете за этой стервой в какое-то подобие... промышленной морозильной камеры? Это большое холодное помещение, разделенное на несколько секций, но, кажется, питание подается только на одну из них. Вы ставите ящик именно туда, куда вам велели.")

	talk(C_GIRL, "Go sleep now.")
	saynn("Она указывает на одну из пустых секций холодильной камеры.")

	saynn("Ты заходишь внутрь... Дверь за тобой захлопывается.")

	saynn("Здесь прохладно... но придётся потерпеть.")

	addContinue("setState", ["intro6"])

func intro6_state():
	GM.main.startNewDay()
	playAnimation(StageScene.Sleeping, "sleep")
	saynn("Тебе удаётся немного поспать... но сон был, мягко говоря, не самым приятным.")

	addStamina(20)
	addPain(-50)
	day = 0
	saynn("Ты слышишь стук в дверь... а это значит... пора вставать.")
	
	addContinue("setState", ["intro7"])
	
func intro7_state():
	aimCamera(L_CENTER)
	addChar(C_GIRL)
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
	saynn("Ты встаёшь и выходишь в основное помещение. Похоже, не ты один проснулся... Из других отсеков холодильника выходят ещё две... рабыни... лошадь и разноцветный щенок.")

	saynn("Девушка и парень, что были здесь вчера, тоже здесь... твои новые хозяева.")

	talk(C_GIRL, "Everyone welcome the new animal.")
	saynn("Девушка ловит твой растерянный взгляд. Ты оглядываешься получше... и замечаешь кучу... странного оборудования. В углу этого... подвала, кажется, есть отдельное огороженное пространство... с маленьким садиком. Солнечный свет, пробивающийся сквозь потолок этого сада — единственный источник света, освещающий остальную часть подвала.")

	talk(C_GIRL, "Yes. You are now an animal.")
	talk(C_GUY, "We're running a cafe and we need milk and cream to keep it running.")
	saynn("Софи одаряет Лео свирепым взглядом.")

	talk(C_GIRL, "Why don't you tell them the exact coordinates of this cafe while you're at it, huh?")
	talk(C_GUY, "My bad.")
	saynn("Девушка снова поворачивается к тебе.")

	talk(C_GIRL, "He is not wrong though. Ever so often, we are gonna come down here and milk you. All of you.")
	saynn("Молоко? Похоже, оборудование нужно именно для этого.")

	talk(C_GUY, "Once you help the cafe earn enough credits, we will actually let you go.")
	talk(C_GIRL, "We will consider that, yes. How much is enough? Right now it's 250 thousand credits.")
	addCredits(-250000)
	saynn("Ого, сколько всего...")

	saynn("Софи подходит именно к тебе.")

	talk(C_GIRL, "So. How are you gonna be useful to us? We already have a cow and a bull so you could be either, I don't care. I just don't take 'no' for an answer.")

	addAction("Milk", "Your breasts will be milked. Their size will be increased over time", "setState", ["intro8milk"])
	if(GM.pc.hasReachablePenis() || GM.pc.isWearingChastityCage()):
		addAction("Seed", "Your cock will be milked", "setState", ["intro8seed"])
		addAction("Both", "Both, your breasts and your cock will be milked", "setState", ["intro8both"])
	else:
		addDisabledAction("Seed", "Sadly, you don't have a penis to be seed-milked")
		addDisabledAction("Both", "Sadly, you don't have a penis to also be seed-milked")

func intro8milk_state():
	agreeMilk = true
	agreeSeed = false
	addChar(C_GIRL)
	addChar(C_GUY)
	saynn("Ты говоришь владельцам, что сама выберешь себе грудь.")

	talk(C_GIRL, "Alright. And if you're not lactating, we will find a way to make you do it, don't you worry, cow.")
	saynn("Корова... неужели это теперь твоя роль?")

	talk(C_GIRL, "We will start milking you soon. If you're hungry, go eat grass.")
	saynn("После этого твои новые хозяева оставляют тебя в покое.")

	saynn("Остальные рабы... животные... корова и бык... расходятся по своим углам.")
	addContinue("setState", ["main"])

func intro8seed_state():
	agreeMilk = false
	agreeSeed = true
	addChar(C_GIRL)
	addChar(C_GUY)
	saynn("Ты говоришь владельцам, что сам выберешь себе член.")

	talk(C_GIRL, "Alright. So you're a bull then. Good.")
	saynn("Бык... неужели это теперь твоя роль?")

	talk(C_GIRL, "We will start milking you soon. If you're hungry, go eat grass.")
	saynn("После этого твои новые хозяева оставляют тебя в покое.")

	saynn("Остальные рабы... животные... корова и бык... расходятся по своим углам.")
	addContinue("setState", ["main"])

func intro8both_state():
	agreeMilk = true
	agreeSeed = true
	addChar(C_GIRL)
	addChar(C_GUY)
	saynn("Ты говоришь владельцам, что выбираешь... и член, и грудь.")

	talk(C_GIRL, "Alright. We shouldn't have any problems milking your cock. But if you're not lactating, we will find a way to make you do it, don't you worry, cow.")
	saynn("Корова... неужели это теперь твоя роль?")

	talk(C_GIRL, "We will start milking you soon. If you're hungry, go eat grass.")
	saynn("После этого твои новые хозяева оставляют тебя в покое.")

	saynn("Остальные рабы... животные... корова и бык... расходятся по своим углам.")
	addContinue("setState", ["main"])
