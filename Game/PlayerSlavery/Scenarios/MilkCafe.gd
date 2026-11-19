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
	addAction("Continue", "Смотреть, что будет дальше", _id, _args)

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
			addAction("Continue", "Смотри, что будет дальше...", "setState", [state])
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
		"Страпон",
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
	
	saynn("Вы — "+cowBullBoth("cow", "bull", "cow")+" рабыня, принадлежащая двум владельцам кафе. Они будут приходить доить тебя для получения "+cowBullBoth("milk", "seed", "молоко и семя")+" дважды в день.")
	
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
		
		addAction("Graze", "Провести время на поле, пожевать травку", "idleGraze")
		addAction("Hide in cell", "Спрятаться в камере", "idleCell")
		# If messy
		addAction("Wash", "Попросить, чтобы тебя помыли", "idleWash")
		if(GM.pc.getStamina() > 0):
			if(GM.pc.isBlindfolded()):
				addDisabledAction("Выглянуть наружу", "Ничего не видно...")
			else:
				addAction("Peek outside", "Заглянуть в дверной глазок", "idlePeek")
		else:
			addDisabledAction("Выглянуть наружу", "Окно высоко, нужно немного выносливости, чтобы до него дотянуться")
		if(peekState >= PEEK_NOTICED_PADLOCK):
			if(padlockDamage >= 1.0):
				if(cageRemoved && helpedMilka):
					addAction("Freedom!", "Дверь практически открыта. Можно уходить!", "ENDING", ["end_breaklock"])
				else:
					addAction("Freedom!", "Дверь практически открыта. Можно выходить", "endingLockCheck")
			elif(!GM.pc.hasBoundLegs()):
				if(GM.pc.getStamina() > 0):
					addAction("Kick door", "Разбить дверь, чтобы повредить навесной замок", "idleSmash")
				else:
					addDisabledAction("Пнуть дверь", "У тебя закончилась выносливость")
			else:
				addDisabledAction("Пнуть дверь", "Твои ноги в кандалах!")
		if(GM.pc.getInventory().hasRemovableRestraintsNoLockedSmartlocks()):
			if(GM.pc.getStamina() > 0):
				addAction("Struggle", "Попытаться вырваться из оков", "idleStruggle")
			else:
				addDisabledAction("Сопротивление", "У тебя закончились силы!")
		if(canHelpCage && !cageRemoved):
			if(GM.pc.hasBoundArms() || GM.pc.hasBlockedHands()):
				addDisabledAction("Клетка быка", "Ты не сможешь сделать это с зажатыми руками")
			else:
				if(GM.pc.getStamina() <= 0):
					addDisabledAction("Клетка быка", "У тебя не хватает выносливости для этого")
				else:
					addAction("Bull's cage", "Помочь Пипу с его клетки целомудрия", "idleBullCage")
	if(idleState == IDLE_SOCIAL):
		saynn("Вам хочется пообщаться.")
		
		addAction("Cow", "Провести время с коровой", "talkCow")
		addAction("Bull", "Провести время с быком", "talkBull")
		addAction("Annoy owners", "Заставить их пожалеть о покупке тебя!", "talkAnnoy")
	if(idleState == IDLE_HUNGRY):
		saynn("Вы чувствуете голод.")
		
		addAction("Eat grass", "Иди ешь траву, как послушный скот", "eatGrass")
		addAction("Starve", "Ты отказываешься есть траву", "eatStarve")
		addAction("Demand", "Требовать от хозяев нормальной еды", "eatDemand")
		if(getTreatAmount() > 0):
			addAction("Eat a treat!", "Съесть одно из своих лакомств", "eatTreat")
		#addAction("Suck bull", "Feed on the bull's seed", "eatSuckBull")
	if(idleState == IDLE_NEEDY):
		saynn("Вам хочется заняться чем-нибудь пошлым.")
		
		addAction("Just chill", "Восстановить немного выносливости", "needyRest")
		addAction("Complain", "Ныть о том, как сильно тебе хочется внимания!", "needyComplain")
		addAction("Offer self", "Пусть хозяева делают с тобой всё, что им вздумается...", "needyOfferSelf")
		# Obedience check
		if(obedience < 0.4):
			addDisabledAction("Дать подоить", "Ты недостаточно послушна, чтобы попросить о дополнительном доении")
		else:
			if(GM.pc.getStamina() <= 0):
				addDisabledAction("Дать подоить", "У тебя не хватает выносливости, чтобы тебя подоили!")
			else:
				addAction("Be milked", "Попросить хозяев подоить тебя еще разок", "needyMilk")
		if(canHelpMilka && (getMilkaBreastSize() < BreastsSize.O)):
			if(GM.pc.hasBoundArms() || GM.pc.hasBlockedHands()):
				addDisabledAction("Грудь Милки", "Ты не сможешь сделать это с зажатыми руками")
			else:
				if(GM.pc.getStamina() <= 0):
					addDisabledAction("Грудь Милки", "У тебя не хватает выносливости для этого")
				else:
					addAction("Milka's breasts", "Помочь Милке, нанеся на её грудь специальный крем", "idleCowBreasts")
		if(helpedMilka || canMilkOthers):
			if(GM.pc.getStamina() > 0):
				addAction("Milk Cow", "Помочь с дойкой коровы", "talkCowMilk")
			else:
				addDisabledAction("Подоить корову", "У тебя совсем не осталось выносливости")
		if(bullTrust > 0.5 || cageRemoved || canMilkOthers):
			if(GM.pc.getStamina() > 0):
				addAction("Milk Bull", "Помочь с дойкой быка", "talkBullMilk")
			else:
				addDisabledAction("Поить быка", "У тебя совсем не осталось выносливости")

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
				"Лео замечает тебя, когда таскает коробки.",
				"Лео замечает тебя, когда поливает сад.",
				"Лео замечает тебя, когда собирает урожай фруктов в саду.",
			]))
			if(obedience < -0.1):
				talk(C_GUY, RNG.pick([
					"Ты такая шалунья "+cowBull()+".",
					"Софи не в восторге от тебя.",
					"Не вытворяй глупостей.",
					"Ты, должно быть, голодна. Может, тебе стоит больше слушаться?",
				]))
			else:
				talk(C_GUY, RNG.pick([
					"Такая послушная "+cowBull()+".",
					"Можно тебя погладить?",
					"Не обращай на меня внимания, жуй дальше.",
					"Ты, должно быть, проголодалась.",
				]))
			addObedience(1)
		if(special == "girl"):
			saynn("Заходит Софи, чтобы проверить, как ты.")
			if(obedience < -0.1):
				talk(C_GIRL, RNG.pick([
					"Я не доверяю твоей наглой мордашке.",
					"Какого хера ты тут забыла? Траву жрешь? Ну ладно.",
					"Не пялься на меня так, тупая сучка.",
				]))
			else:
				talk(C_GIRL, RNG.pick([
					"Жуй давай, животное.",
					"Выглядишь как дурочка, животное.",
					"Жуй травку, мне нужно твоё "+cowBullBoth("milk", "seed", "milk")+".",
				]))
			addObedience(1)
		if(special == "cow" && cowTrust > 0.0):
			saynn("Ты натыкаешься на Милку, которая делает то же самое.")
			talk(C_COW, RNG.pick([
				"Му-у...",
				"Му!",
				"Му?",
				"Му? Му-у!",
			]))
			addCowTrust(1.0)
		if(special == "bull" && bullTrust > 0.0):
			saynn("Ты натыкаешься на Пип, которая делает то же самое.")
			talk(C_BULL, RNG.pick([
				"Потолок слишком высокий... не дотянуться.",
				"Я пыталась копать... но под землей сплошная сталь.",
				"Если найдем кремень... может, получится развести огонь... но что потом?",
				"Если удастся найти камень побольше...",
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
				"Ну же, не стесняйся.",
				"Я не кусаюсь, так что можешь не прятаться.",
				"Софи будет в ярости, если увидит тебя здесь.",
				"Тебе не нравится это место? Прости.",
				"Не хочу говорить Софи...",
			]))
		if(special == "girl"):
			saynn("Софи находит тебя в камере и вытаскивает за шиворот.")
			addPain(10)
			if(obedience < -0.1):
				talk(C_GIRL, RNG.pick([
					"Жри траву, тупое животное!",
					"Не прячься, тупое животное.",
					"Не зли меня, сучка.",
					"Хочешь отдохнуть — иди в поле, тупое животное.",
				]))
			else:
				talk(C_GIRL, RNG.pick([
					"Жри траву, ты чего тут забыла?",
					"Не прячься, ты же животное.",
					"Не беси меня.",
					"Хочешь отдохнуть — есть поле.",
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
			talk(C_GIRL, "Развернись.")
			saynn("Ты повинуешься, и она проводит струей по твоему телу тем же самым образом... ровно столько, чтобы отмыть тебя.")
		else:
			saynn("Лео выводит тебя на открытое поле. Держа в одной руке шланг, а в другой — губку, он осторожно поливает твоё тело водой, стараясь смыть каждую крупицу грязи... и прочего дерьма.")
			talk(C_GUY, "Вот так. Куда лучше, а?")
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
			talk(C_BULL, "Это очень тупая идея.")
			saynn("Ты пожимаешь плечами.")
			talk(C_BULL, "Впрочем, не смею тебя задерживать. Этот мир и так построен на идиотских идеях.")
			saynn("Софи приближается к двери, поэтому ты бросаешься наутек, пока еще есть возможность.")
			peekState = PEEK_NOTICED_PADLOCK
			peekTried = 0
			return
		peekTried += 1
		saynn("Ты встаешь на цыпочки и заглядываешь в маленькое окошко.")
		addStamina(-10)
		
		saynn(RNG.pick([
			"Спина Софи полностью загораживает обзор — она стоит за стойкой. Дальше неё ничего не видно.",
			"Вокруг есть пара посетителей... Но все они сидят за столиками, непринужденно болтая друг с другом или уставившись в свои датапады. Если бы только кто-нибудь из них взглянул в твою сторону...",
			"Ты видишь Лео — он работает официантом и разносит заказы. Софи готовит еду для кого-то. Возможно, это просто проходной момент, ведь за столиками никого не видно.",
			"Все столики кажутся пустыми, посетителей нет.",
			"За армированными стеклянными панелями кафе ты замечаешь лишь абсолютную пустоту космоса... Даже если ты сбежишь, куда тебе идти?",
			"В заведении есть посетители, так что ты изо всех сил стараешься привлечь их внимание, размахивая руками и постукивая по стеклу.",
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
			talk(C_PC, "Ну же, заметьте меня! Я здесь!")
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
			talk(C_GUY, "Простите, разрешите пройти.")
			saynn("Он почти проходит мимо тебя... но вдруг замирает.")
			talk(C_GUY, RNG.pick([
				"Постойте. Отойдите от двери, пожалуйста.",
				"Хм. Пожалуйста, не трогай эту дверь.",
				"Тебе не стоит возиться с этой дверью, иначе Софи разозлится.",
				"Погоди. Что ты здесь делаешь?"
			]))
			addObedience(-1)
		if(special == "girl"):
			playAnimation(StageScene.Duo, "defeat", {npc=C_GIRL})
			saynn("Дверь бьет тебя прямо по носу — это Софи резко распахнула её!")
			addPain(20)
			talk(C_GIRL, RNG.pick([
				"Ну почему ты такой тупой? Не заставляй меня наказывать тебя.",
				"Серьезно? Отойди от двери, иначе я причиню тебе боль.",
				"Отойди от двери, тупое животное.",
				"А ну назад, тупица! "+cowBull()+".",
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
				"Эй. Эм. Можешь уже перестать?",
				"Не трогай эту дверь.",
				"Пожалуйста, держись подальше от этой двери.",
			]))
			saynn("По крайней мере, тебе удалось выбраться без проблем.")
			addObedience(-1)
		if(special == "girl"):
			if(RNG.chance(10.0 - obedience*20.0)):
				saynn("Спустя мгновение Софи открывает дверь и хватает тебя.")
				talk(C_GIRL, RNG.pick([
					"Это было тупо.",
					"Ладно, ты начинаешь понимать!",
					"Ладно, ты схватываешь на лету.",
					"Ладно, хочешь наказания?",
					"Сама напрашиваешься на наказание, шлюха.",
				]))
				bullyScene(C_PC)
				addObedience(-2)
			else:
				playAnimation(StageScene.Duo, "defeat", {npc=C_GIRL})
				saynn("Спустя мгновение Софи распахивает дверь и швыряет тебя на пол.")
				addPain(5)
				talk(C_GIRL, RNG.pick([
					"Прекрати это делать, тупая шлюха.",
					"Не трогай эту дверь, тупая сучка.",
					"Не трогай эту дверь, иначе пожалеешь.",
					"В следующий раз я позабочусь о том, чтобы было еще больнее.",
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
			"Ты выхватываешь тюбик с кремом из рук Милки и начинаешь осторожно размазывать его по её груди и соскам.",
		]))
		addStamina(-20)
		talk(C_COW, RNG.pick([
			"Охх, как щекотно!",
			"Приятно...",
			"Я уже что-то чувствую...",
			"Спасибо за помощь!",
		]))
		saynn("Процесс занимает немало времени, так что вы успеваете немного поболтать.")
		addCowTrust(1)
		sayMilkaLine()
		saynn(RNG.pick([
			"Со временем ты замечаешь, что грудь Милки становится всё пышнее и круглее! Она явно увеличилась в размерах.",
		]))
		if(milkaExtraBreastSize > 5 && !helpedMilka):
			helpedMilka = true
			talk(C_COW, RNG.pick([
				"Спасибо, спасибо, спасибо! Мои сиськи теперь выглядят намного лучше! Теперь я смогу давать столько молока~.",
			]))
			saynn("Похоже, Милка довольна таким размером... но трубка еще не пуста.")
			talk(C_COW, "Можешь нанести побольше, если хочешь... Но мне неловко, что ты тратишь на меня столько времени... Может, я могу тебя отблагодарить?")
			addCowTrust(5)
			addAction("It's okay", "Ты счастлив, что помог Милке, и это всё, что тебе было нужно.", "setState", ["main"])
			addAction("Breastfeed", "Покормиться из груди Милки!", "milkaRewardBreastfeed")
			addAction("Breed her", "Трахнуть Милку членом или страпоном!", "milkaRewardBreed")
		
		elif(GM.pc.getBreastsSize() < BreastsSize.O):
			talk(C_COW, RNG.pick([
				"Ах... Спасибо! Если хочешь, я могу использовать его и на тебе!",
			]))
			saynn("Ты читаешь мелкий шрифт на тюбике. Там сказано, что изменения происходят мгновенно и навсегда.")
		
			addContinueEventTrigger()
			addAction("Your breasts", "Позволить Милке нанести крем на твою грудь, чтобы она стала больше!", "milkaUseCreamOnPC")
		else:
			talk(C_COW, RNG.pick([
				"Ах.. теперь я лучшая коровка.",
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
		talk(C_COW, "Вот так!")
		addContinueEventTrigger()
	if(_id == "milkaRewardBreed"):
		playAnimation(StageScene.SexMatingPress, "fast", {pc="pc", npc="psmilka", pcCum=true, bodyState={hard=true,naked=true}})
		var _withStrapon:bool = addStrapon(C_PC, C_BULL)
		
		if(!_withStrapon):
			saynn("Да, глядя на раскрасневшееся лицо Милки и её мягкое, жаждущее тело... тебя посещает безумная идея. Ты осторожно прижимаешь её к полу.")
			talk(C_PC, "Посмотрим, как ты это примешь, Милка.")
			saynn("Она ахает, её ушки дергаются, а хвостик подрагивает, когда ты хватаешь её за бедра и разводишь их широко.")
			talk(C_COW, "moo~?..")
			saynn("Ты высоко задираешь её ноги, прижимая их к самым плечам. Её влажная киска блестит, пока ты прицеливаешься своим твердым членом к её жаждущему входу.")
			saynn("Резким толчком ты входишь глубоко в её щель, заставляя Милку издать отчаянный стон.")
			talk(C_COW, "Ahhh~! Mooo~..")
			saynn("Твои бедра с силой впечатываются в её бедра, твой {pc.penis} методично и грубо вколачивается в её киску. Её огромная молочная грудь подпрыгивает при каждом толчке, а соски уже подтекают каплями молока с ароматом клубники.")
			talk(C_PC, "Вот так.. принимай, ковбойша.")
			saynn("Ты крепче сжимаешь её ноги и ускоряешься, вбиваясь в её киску; головка твоего члена давит на самые чувствительные точки, пока она извивается под тобой.")
			talk(C_COW, "Ааах.. ааах.. муу~.. это слишком много!")
			saynn("Тело Милки выгибается дугой, её грудь трясется и брызжет молоком, а киска сжимается вокруг тебя от мощного оргазма. Ты чувствуешь, как её стенки доят твой член, заставляя тебя самого вот-вот кончить.")
			talk(C_PC, "Нгххх..")
			saynn("Последним глубоким толчком ты зарываешься в неё до самого основания и начинаешь заливать её утробу своим горячим семенем. Густые струи {pc.cum} наполняют её, смешиваясь с её соками.")
			saynn("Милка вскрикивает от наслаждения, её соски брызжут еще большим количеством сладкого молока, пока её тело дрожит под тобой, а хвост плотно сворачивается кольцом.")
			talk(C_COW, "Мммхх~.. т-так тепло.. муу..")
			saynn("Ты остаешься внутри нее на несколько мгновений, тяжело дыша, прежде чем наконец выскользнуть наружу. Смесь спермы и молока стекает с нее, пока она лежит, удовлетворенная и сияющая.")
			talk(C_PC, "Хорошая девочка.")
			talk(C_COW, "Спасибо.. что наполнил меня.. ахх..")
			saynn("Ты садишься рядом, немного отдыхая и перебирая ее волосы.")
		else:
			saynn("Да, глядя на раскрасневшееся лицо Милки и ее мягкое, жаждущее тело... тебя посещает безумная идея. Ты осторожно укладываешь ее на пол и идешь к полке с доильным оборудованием, чтобы схватить один из ремней для страпона.")
			talk(C_PC, "Посмотрим, как ты это примешь, Милка.")
			saynn("Она ахает, её ушки дергаются, а хвостик подрагивает, когда ты хватаешь её за бедра и разводишь их широко.")
			talk(C_COW, "moo~?..")
			saynn("Прежде чем залезть на нее сверху, ты плотно закрепляешь ремень на талии.")
			saynn("Затем ты высоко задираешь ноги Милки, прижимая их к ее плечам, пока скользкий кончик твоего смазанного игрушки прижимается к ее влажному входу.")
			talk(C_PC, "Готова к осеменению, ковбойша?")
			saynn("Плавным, но мощным толчком ты входишь глубоко в ее щель, заставляя Милку издать отчаянный стон.")
			talk(C_COW, "Ahhh~! Mooo~..")
			saynn("Твои бедра впечатываются в ее бедра, страпон методично и грубо долбит ее киску. Ее пышная молочная грудь подпрыгивает при каждом движении, а соски источают сладкое молоко с ароматом клубники.")
			talk(C_PC, "Вот так.. принимай, ковбойша.")
			saynn("Ты крепче сжимаешь ее ноги и ускоряешься, вколачивая игрушку в ее щель; ее кончик задевает самые чувствительные точки, пока она не начинает извиваться под тобой.")
			talk(C_COW, "Ааах.. ааах.. муу~.. это слишком много!")
			saynn("Тело Милки выгибается дугой, грудь дрожит и брызжет молоком, а ее киска судорожно сжимает ствол игрушки от мощного оргазма. Внезапный спазм активирует скрытый механизм в страпоне.")
			saynn("С едва слышным гулом игрушка начинает закачивать теплое семя глубоко в ее матку, выпуская густые струи жидкости, похожей на сперму, которая смешивается с ее соками.")
			saynn("Милка громко стонет, её соски брызжут всё большим количеством сладкого молока, а её тело дрожит под тобой, и хвост плотно сворачивается кольцом, когда ты наполняешь её.")
			talk(C_COW, "Мммхх~.. т-так тепло.. муу..")
			saynn("Ты на мгновение оставляешь страпон внутри неё, наблюдая за тем, как вздымается и опускается её грудь, прежде чем медленно вытащить его. Смесь спермы и молока капает из её киски, пока она лежит перед тобой, сияющая и удовлетворенная.")
			talk(C_PC, "Хорошая девочка.")
			talk(C_COW, "Спасибо.. что наполнил меня.. ахх..")
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
		talk(C_PC, "Не возражаешь, если я их попробую?")
		saynn("Милка краснеет, её ушки приподнимаются. Она разводит ноги и отклоняет торс назад, подставляя тебе свою тяжелую грудь, чтобы ты мог с ней поиграть.")
		talk(C_COW, "Му-у~. Всё, что угодно для тебя, сладкий друг.")
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
		talk(C_PC, "Твоё молоко очень вкусное.")
		talk(C_COW, "Спасибо... за то, что заставляешь меня чувствовать себя так... хорошо.")
		saynn("Вы сидите вместе в теплом сиянии; ее грудь вздымается и опускается, пока она пытается восстановить дыхание.")
		
		GlobalRegistry.getCharacter(C_COW).milk()
		
		addPain(-100)
		addStamina(100)
		addContinue("setState", ["main"])
	
	if(_id == "idleBullCage"):
		aimCamera(L_BULL)
		playAnimation(StageScene.ChairOral, "rub", {pc="pspip", npc="pc"})
		
		saynn(RNG.pick([
			"Вы осматриваете девственную клетку Пипа и пытаетесь стряхнуть её.",
			"Вы крепко хватаете основание клетки Пипа и с силой поворачиваете её, пытаясь ослабить хватку на его препуции.",
			"Вы вставляете ноготь в замок клетки Пипа и пытаетесь его провернуть.",
			"Вы находите в саду камешек и начинаете осторожно долбить им по замку клетки Пипа.",
			"Вы затачиваете найденную в саду веточку и пытаетесь использовать её как отмычку внутри клетки Пипа.",
			"Вы крепко хватаетесь за металлические части клетки Пипа и изо всех сил пытаетесь их согнуть.",
		]))
		cageDamage += RNG.randf_range(0.2, 0.3)
		addStamina(-20)
		addBullTrust(1)
		
		sayPipLine()
		
		if(cageDamage >= 1.0):
			saynn("Чудо! Тебе [b]удалось взломать замок[/b]! Его обломки рассыпаются по полу.")
			talk(C_BULL, "Ah..")
			saynn("Ты осторожно начинаешь тянуть за саму клетку, пытаясь снять ее... но что-то все еще мешает. Пульсирующий член Пипа отчаянно пытается встать колом.")
			talk(C_BULL, "Блядь... Серьёзно? Какого хуя она всё ещё застряла? Неужели мне суждено вечно оставаться фембойчиком-игрушкой для траха?")
			saynn("Ты уже почти готов сдаться... но замечаешь, как зажатый конский член Пипа всё сильнее разгибает металл, пытаясь достичь эрекции.")
			saynn("Если не получается снять клетку самому... может, заставить его член сделать это, раззадорив парня еще сильнее?")
			
			addAction("Tease", "Продолжать дразнить его из-за клетки целомудрия", "cageTeaseUnlock")
			addAction("Anal", "Трахнуть его в зад (или использовать страпон), чтобы попытаться помочь!", "cageAnalFuck")
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
			talk(C_PC, "Давай попробуем это, самец.")
			saynn("Глаза Пипа расширяются, когда ты прижимаешь свой твердый член к его влажному, дрожащему анусу.")
			talk(C_BULL, "П-погоди... что ты...")
			saynn("Ты хватаешь его за бедра, приподнимая их ровно настолько, чтобы идеально выровняться. Его хвост хлещет из стороны в сторону, пока ты дразнишь его отверстие кончиком члена.")
			talk(C_PC, "Расслабься... тебе же это нравится, правда?")
			saynn("Одним плавным толчком ты глубоко входишь в тугой анус Пипа. Он ахает, выгибая спину, а его запертая клетка с грохотом бьется о пол.")
			saynn("Твой член входит и выходит, массируя его простату. Каждый твой толчок вырывает из него милые стоны.")
			talk(C_BULL, "Ахх... блядь... как грубо...")
			saynn("Ты не даешь ему времени осознать происходящее, наращивая темп. Твоя рука вцепляется в его волосы и резко тянет их назад.")
			saynn("Предэякулят капает с кончика клетки, пока его задница сжимается вокруг тебя, а напряжение нарастает до почти невыносимого предела.")
			talk(C_PC, "Вот так... будь хорошей девочкой и кончи для меня.")
			saynn("Член Пипа бешено дергается, клетка гнется под напором. Одним финальным, мощным толчком его [b]член вырывается на свободу[/b], прутья его клетки разлетаются в щепки от невероятной силы эрекции!")
			saynn("Освободившись, его раздутый лошадиный член за секунды становится каменным, а затем взрывается густым, мощным потоком семени!")
			saynn("Густые струи спермы разлетаются по всему полу, пока Пип стонет от блаженства, а его тело сотрясает сильная дрожь, пока ты наполняешь его задницу своей тягучей жидкостью.")
			talk(C_BULL, "F-fuck! Ah! Ahhh-h!..")
			talk(C_PC, "Охренеть, сработало.")
			saynn("Даже хозяева приходят проверить, из-за чего поднялся такой шум.")
			talk(C_GIRL, "Что здесь, черт возьми, происходит?")
			talk(C_GUY, "Похоже, они нашли способ снять клетку.")
			talk(C_GIRL, "Могли бы хоть ведро под него подставить, блядь.")
			saynn("Они могли бы порадоваться этому сильнее... но что ж. По крайней мере, Пип, похоже, в восторге.")
			talk(C_BULL, "С-спасибо.. хх-хх..")
			saynn("Ты улыбаешься, глядя на изнеможденное тело Пипа, а твоя грудь мерно вздымается от чувства удовлетворения.")
		else:
			saynn("Ты решаешь помочь ему. Сначала ты идешь к складу доильного оборудования, берешь страпон, закрепляешь его на бедрах и густо смазываешь резиновый ствол лубрикантом.")
			saynn("Затем уверенным движением ты швыряешь Пипа на пол, заставляя его лечь на живот, выставив задницу вверх.")
			talk(C_PC, "Давай попробуем это, самец.")
			saynn("Глаза Пипа расширяются, когда ты прижимаешь свой новый резиновый член к его влажному, дрожащему анусу.")
			talk(C_BULL, "П-погоди... что ты...")
			saynn("Ты хватаешь его за бедра, приподнимая их ровно настолько, чтобы идеально выровняться. Его хвост хлещет из стороны в сторону, пока ты дразнишь его отверстие кончиком члена.")
			talk(C_PC, "Расслабься... тебе же это нравится, правда?")
			saynn("Одним плавным толчком ты вгоняешь страпон глубоко в тугой анус Пипа. Он ахает, выгибая спину.")
			saynn("Твой резиновый член входит и выходит, массируя его простату. Каждый твой толчок вырывает из него милые стоны.")
			talk(C_BULL, "Ахх... блядь... как грубо...")
			saynn("Ты не даешь ему времени осознать происходящее, наращивая темп. Одной рукой ты хватаешь его за волосы и резко тянешь назад, пока вбиваешься в него.")
			saynn("Предэякулят капает с кончика его запертой клетки, пока его задница сжимается вокруг твоей игрушки, а напряжение нарастает до почти невыносимого предела.")
			talk(C_PC, "Вот так... будь хорошей девочкой и кончи для меня.")
			saynn("Член Пипа бешено дергается внутри клетки, металл гнется под напором. Одним финальным, мощным толчком бедер ты заставляешь его [b]клетку лопнуть[/b] от неистовой силы его эрекции!")
			saynn("Освободившись, его раздутый лошадиный член за секунды становится каменным, а затем взрывается густым, мощным потоком семени!")
			saynn("Густые струи коньяка заливают пол, пока Пип блаженно стонет, содрогаясь всем телом.")
			talk(C_BULL, "F-fuck! Ah! Ahhh-h!..")
			talk(C_PC, "Охренеть, сработало.")
			saynn("Даже хозяева приходят проверить, из-за чего поднялся такой шум.")
			talk(C_GIRL, "Что здесь, черт возьми, происходит?")
			talk(C_GUY, "Похоже, они нашли способ снять клетку.")
			talk(C_GIRL, "Могли бы хоть ведро под него подставить, блядь.")
			saynn("Они могли бы порадоваться этому сильнее... но что ж. По крайней мере, Пип, похоже, в восторге.")
			talk(C_BULL, "С-спасибо.. хх-хх..")
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
		talk(C_PC, "Думаю, ты прав(а).")
		saynn("Он наклоняет голову.")
		talk(C_BULL, "А?")
		talk(C_PC, "Похоже, тебе суждено быть чьей-то шлюхой.")
		saynn("Пип вздыхает... ты замечаешь, как его запертый член слегка дергается.")
		talk(C_PC, "Всё не так уж плохо. Уверен(а), тебе это со временем понравится.")
		talk(C_BULL, "В каком смысле?")
		talk(C_PC, "Тебе ведь уже нравится кончать от того, как разминают твою простату, а?")
		saynn("Он хмурится... но член дергается еще сильнее, создавая дополнительное давление на клетку.")
		talk(C_BULL, "Я — настоящий самец!")
		talk(C_PC, "Просто смирись. Твой член заперт навсегда. Он не лучше клитора. Ты девка, а не самец.")
		saynn("Предэякулят течет из кончика клетки. Пип сильно ерзает, а его пульсирующая попытка эрекции все сильнее гнет металл!")
		talk(C_BULL, "Э-эй, н-не говори так...")
		talk(C_PC, "Твой клитор течет, шлюшка. Тебе это нравится, признай. Тебе нравится, когда тебя трахают как девку.")
		saynn("Внезапно с громким звоном верхняя часть его клетки отлетает, мгновенно обнажая твердый, расширенный у основания мясной конский член. Ого.")
		talk(C_BULL, "Ahh-h-h!..")
		saynn("Пип видит это и ахает, вцепляясь в стул, пока его член все еще пульсирует... как вдруг из него вырывается густая, мощная порция семени! Струя за струей конь летит по воздуху красивыми дугами, пока он стонет как шлюха, не в силах унять дрожь во всем теле, откинув голову назад.")
		talk(C_PC, "Охренеть, сработало.")
		talk(C_BULL, "Mhh-h.. ah.. ghh-h.. ah-hh..")
		saynn("Даже хозяева приходят проверить, из-за чего поднялся такой шум.")
		talk(C_GIRL, "Серьезно? Ты попал в чистую струю масла, а твоя ленивая задница даже не смогла подставить ведро под этот поток?")
		talk(C_GUY, "Но зато клетка снята, Софи. Доить его будет проще.")
		saynn("Софи ворчит и уходит.")
		talk(C_BULL, "Черт... так много. С-спасибо...")
		saynn("Ты улыбаешься и киваешь.")
		addBullTrust(5)
		addContinue("setState", ["main"])
	
	if(_id == "idleStruggle"):
		var struggleData:Dictionary = GM.pc.doStruggleOutOfRestraints(false, false, null, 5.0)
		if(struggleData.empty()):
			return
		var text:String = struggleData["text"] if struggleData.has("text") else "[color=red]ОШИБКА? Текст сопротивления не предоставлен[/color]"
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
			talk(C_COW, "О!")
			saynn("Ты останавливаешься и наблюдаешь, как она достает какой-то... тюбик с кремом.")
			talk(C_COW, "Владелец купил это для меня. Но он слишком занят управлением кафе, чтобы применить это на деле.")
			saynn("Ты читаешь состав... эстроген, пролактин... судя по всему, этот крем должен стимулировать лактацию. Его нужно наносить прямо на грудь.")
			talk(C_COW, "Мне самой страшно это использовать, я же просто корова!")
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
			talk(C_BULL, "Оно там лежит уже месяца несколько. Я, блядь, в отчаянии. Может, ты попробуешь что-нибудь сделать? Если у тебя будет время.")
			saynn("Бык в клетке — это как-то неправильно. С другой стороны, возможно, такова его судьба.")
		elif(cageRemoved):
			saynn("Вы еще немного болтаете.")
			sayPipLine()
		
		addContinueEventTrigger()
	if(_id == "talkAnnoy"):
		saynn(RNG.pick([
			"Ты стучишь в дверь, чтобы позлить своих хозяев.",
			"Ты донимаешь хозяев, пока они копаются в своем маленьком садике.",
			"Ты донимаешь хозяев, пока они проверяют быка и корову.",
			"Ты донимаешь хозяев, пока они заняты мытьем остального скота.",
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
			talk(C_GUY, "Софи очень не нравится, что ты так сильно шумишь.")
			saynn("Его рука достает ломтик яблока.")
			talk(C_GUY, "Если я дам тебе вкусняшку, будешь вести себя хорошо?")
			saynn("Ты киваешь, это очевидно. Парень протягивает тебе угощение.")
			addTreat(1)
		if(special == "bully"):
			saynn("Софи дико бесится из-за тебя.")
			talk(C_GIRL, RNG.pick([
				"ЗАТКНИСЬ, СУЧКА!",
				"НУ ТЫ И НЫТИКША, СУЧКА.",
				"ХОЧЕШЬ МОЕГО ВНИМАНИЯ? ПОЛУЧАЙ, ШЛЮХА.",
			]))
			bullyScene(C_PC)
		if(special == "shiv"):
			if(bullTopic <= 0):
				saynn("После этого трюка к тебе подходит один из других рабов.")
				talk(C_BULL, "Эй... ты меня не знаешь... но, по-моему, это принесет тебе больше пользы, чем мне.")
				saynn("Он протягивает тебе заточенный камень... его можно использовать как оружие.")
				
			else:
				saynn("После этого трюка к тебе подходит Пип.")
				talk(C_BULL, "Эй... думаю, это будет полезнее для тебя, чем для меня.")
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
			addAction("Breed her", "Трахнуть Милку членом или страпоном!", "milkaRewardBreed")
		else:
			addDisabledAction("Оплодотворить её", "Она тебе не особо доверяет...")
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
				"Вкусно, правда?",
				"Му-у~. Свежая травка... постоянное доение... Чего еще может хотеть корова?",
				"Счастливые времена!",
				"Травы хватит на нас обоих!",
			]))
			saynn("Ты... киваешь.")
			addCowTrust(2)
		if(special == "bull" && bullTrust > 0.0):
			playAnimation(StageScene.Duo, "stand", {npc=C_BULL})
			GlobalRegistry.getCharacter(C_BULL).fillBalls(0.5)
			saynn("Пип прячется в углу поля, медленно жуя одну-единственную травинку.")
			talk(C_BULL, RNG.pick([
				"У них там целый сад... а нам разрешено жрать только траву.",
				"Я не травоядная, ясно? Мне просто... нужно хоть что-то пожевать.",
				"Так и хочется растоптать их ягодыцы... но они наверняка сделают то же самое с моими.",
				"А это место не такое уж плохое, да? Эх, кого я обманываю...",
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
			talk(C_GUY, "Я знаю, что трава — это не совсем то, что ты обычно ешь. Но не мори себя голодом, ладно? И не говори Софи.")
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
				talk(C_COW, "Для меня? Оооооой, спасибо-о-о~!")
				addCowTrust(3)
				addTreat(-1)
				
		if(RNG.chance(20) && bullTrust > 0.0):
			saynn("Пип вздыхает.")
			talk(C_BULL, RNG.pick([
				"Ну что, хватит уже, а?",
				"Ах, вот оно как.",
				"Жрешь вкусняшки, которые тебе дали, да?",
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
		addAction("Leo", "Дай мужику трахнуть тебя", "startSex", [C_GUY, C_PC, SexType.DefaultSex, {SexMod.BondageDisabled: true, SexMod.DisableDynamicJoiners: true}])
		addAction("Sofie", "Дай девке трахнуть тебя", "startSex", [C_GIRL, C_PC, SexType.DefaultSex, {SexMod.BondageDisabled: true, SexMod.DisableDynamicJoiners: true}])
		addAction("Both", "Пусть они оба развлекут тебя", "startSex", [[C_GIRL, C_GUY], C_PC, SexType.DefaultSex, {SexMod.BondageDisabled: true, SexMod.DisableDynamicJoiners: true}])
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
			addAction("Sleep?", "Пора спать, но кажется, вот-вот что-то случится...", "setState", ["ePeekFirstEvent"])
		if(peekState == PEEK_SECOND_EVENT_HAPPENED):
			addAction("Sleep?", "Пора спать, но кажется, вот-вот что-то случится...", "setState", ["ePeekSecondEvent"])
		if(peekState == PEEK_THIRD_EVENT_HAPPENED):
			addAction("Sleep?", "Пора спать, но кажется, вот-вот что-то случится...", "setState", ["ePeekThirdEvent"])
		return
	addAction("Sleep", "Пора спать", "SLEEP")

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
			addAction("Freedom!", "Свою часть работы ты выполнила. Теперь очередь хозяев", "ENDING", ["end_credits"])

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
			"Пора доить. У тебя есть молоко? Если нет, то сначала мне придется тебя оплодотворить.",
		]))
		saynn("Похоже, если ты согласишься, он попытается тебя осеменить...")
	else:
		talk(C_GUY, RNG.pick([
			"Сейчас я буду тебя доить.",
			"Ты готова к дойке?",
			"Нашему кафе нужно "+cowBullBoth("milk", "cream", "milk")+" продолжать работу. И я здесь, чтобы подоить тебя.",
		]))
	
	addAction("Agree", "Пусть он подоит тебя!", "agree")
	addAction("Decline", "Ты бы предпочла этого не делать.", "decline")

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
				"Думаешь, самая умная? Значит, придётся доить тебя лично.",
				"Лео, может, и мягкотелый, но я не такой снисходительный. Готовься к наказанию.",
			]))
			saynn("Похоже, она хочет с тобой подраться...")
			
			addAction("Fight!", "Начать бой", "startFight", [C_GIRL])
			if(getShivAmount() > 0):
				addAction("Shiv her!", "Используй заточку, чтобы она отъебалась", "useShiv")
		else:
			if(obedience < -0.1):
				talk(C_GUY, RNG.pick([
					"Это не к добру, придётся рассказать Софи.",
					"Не капризничай, а то нам придётся тебя наказать.",
					"Я не хочу принуждать тебя. Но мне хотелось бы видеть больше послушания."
				]))
			else:
				if(milkedToday <= 0):
					talk(C_GUY, RNG.pick([
						"Почему бы и нет? Ты ведь принадлежишь нам, помнишь? Тьфу, ладно.",
						"Как мы будем управлять кафе? Пожалуйста, позволь мне подоить тебя. Я не хочу применять силу.",
						"Тебе лучше надеяться, что остальные рабыни дадут нам хоть немного молока и семени.",
						"Кафе, возможно, придется закрыть, если мы не сможем достать даже базовые ингредиенты..."
					]))
				else:
					talk(C_GUY, RNG.pick([
						"У нас уже есть немного молока и сливок... но если будет излишек, кафе сможет принести больше прибыли.",
						"Нет? Ладно. Значит, придется довольствоваться тем, что есть.",
						"Не хочу тебя заставлять. Но нам нужно всё, "+cowBullBoth("milk", "cream", "молоко и сливки,")+" которые только сможем раздобыть.",
					]))
			setState("main")

func about_to_be_milked_by_girl_state():
	aimCamera(L_ACT)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
	saynn("Софи подходит к тебе.")
	if(agreeMilk && !GM.pc.canBeMilked() && !GM.pc.hasEffect(StatusEffect.HasCumInsideAnus) && !GM.pc.hasEffect(StatusEffect.HasCumInsideVagina)):
		talk(C_GIRL, RNG.pick([
			"Я пришел подоить тебя. Плевать, если ты еще не лактаторша — значит, сначала придется тебя осеменить.",
		]))
		saynn("Похоже, если ты согласишься, она попытается тебя оплодотворить...")
	else:
		if(obedience < -0.1):
			talk(C_GIRL, RNG.pick([
				"Я пришел подоить тебя. Опять будешь строить из себя сучку?",
				"Время дойки. Не усложняй себе жизнь, просто подчиняйся, шлюха.",
				"Я пришла подоить тебя. Делай, что велю, иначе заставлю.",
			]))
		else:
			talk(C_GIRL, RNG.pick([
				"Время дойки.",
				"Немного есть... "+cowBullBoth("milk", "cream", "молоко и сливки,")+"...? Мне нужно всё до последней капли.",
				"Я пришла тебя подоить, так что веди себя прилично.",
			]))
	saynn("Похоже, она не собирается принимать ответ «нет»...")
	
	addAction("Allow", "Позволить ей подоить тебя", "agree")
	addAction("Fight!", "Сопротивляться её попыткам", "decline")

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
				"Какая упрямая сучка. Ты ещё пожалеешь об этом.",
				"Ты начинаешь меня бесить. Ладно, тогда будем делать это по-плохому.",
				"Ну давай, попробуй остановить меня, тупая шлюха.",
			]))
		else:
			talk(C_GIRL, RNG.pick([
				"Серьёзно? Что ж, тогда мне придётся применить силу.",
				"Какое глупое животное. Я научу тебя вести себя прилично.",
				"Ты всего лишь животное. Веди себя смирно, иначе я заставлю тебя.",
			]))
		saynn("Похоже, тебе придётся с ней сразиться.")
		addAction("Fight!", "Начать бой", "startFight", [C_GIRL])
		if(getShivAmount() > 0):
			addAction("Shiv her!", "Используй заточку, чтобы она отъебалась", "useShiv")
	if(_id == "useShiv"):
		playAnimation(StageScene.Duo, "shiv", {npc=C_GIRL, npcAction="defeat"})
		saynn("Прежде чем Софи успевает среагировать, ты выхватываешь шило и наносишь ей удар!")
		
		talk(C_GIRL, RNG.pick([
			"АЙ, СУКА!",
			"ГДЕ ТЫ ЭТО ВЗЯЛА, СУЧКА?!",
			"УГХ, Я ТЕБЯ СЛОМАЮ... блядь...",
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
			"Я с тобой ещё не закончил, шлюха...",
			"Арх... Да пошла ты тогда, тупая сука.",
			"Ладно, блядь, пойду подою кого-нибудь другого.",
			"Если ты не прекратишь, я из тебя просто капкейки сделаю.",
		]))
		
		addObedience(-5)
	else:
		saynn("Ты проиграл в схватке...")
		talk(C_GIRL, RNG.pick([
			"Жалкое зрелище.",
			"Это было тупо. Очень тупо.",
			"Хватит вести себя как гребаная капризная девчонка.",
			"Мне и так хватает ленивых ублюдков вокруг.",
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
	
	sayParsed("{actor.You} {actor.youVerb('check')} {target.your} {target.breasts}, сжимаю их... и не нахожу ни капли молока.")
	if(_actorID == C_GIRL):
		talk(_actorID, RNG.pick([
			"В твоих сиськах нет молока. Нам нужно это исправить.",
			"Твои тупые сиськи не лактируют. Я собираюсь это исправить."
		]))
	elif(_actorID == C_GUY):
		talk(_actorID, RNG.pick([
			"Кажется, ты не лактируешь. Сначала мне придется кое-что с этим сделать.",
			"Ты не лактируешь. Нам нужно это исправить."
		]))
	else:
		talk(_actorID, "Ты не лактируешь. Нам нужно это исправить.")
	
	# Just stimulate breasts
	if(_hasCumAlready):
		playAnimation(StageScene.BreastGroping, "grope", {pc=_actorID, npc=_targetID, npcBodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('see')} that {target.yourHis} "+("cunt" if _hasVag else "tailhole")+" уже достаточно взбита, так что {actor.youHe} просто {actor.youHeVerb('pull')} {target.youHim} в крепкие объятия и {actor.youHeVerb('begin')}, сильно сжимая {target.yourHis} {target.breasts}, стимулируя их!")
		talk(_targetID, "Ah..")
		if(stimulateLactation(_target, lactationTry >= (6 if _canGetPreg else 3))):
			lactationTry = 0
			sayParsed("И вскоре соски {target.yourHis} начинают брызгать {target.milk}! {target.YouHe} [b]начали лактацией[/b]!")
			talk(_actorID, "Вот так-то лучше.")
		else:
			sayParsed("Соски {target.YourHis} становятся твердыми и чувствительными от стимуляции... Но молока всё еще нет.")
			talk(_actorID, "Мы будем продолжать попытки.")
	# BREED
	else:
		var _isStrap:bool = false
		if(addStrapon(_actorID, C_GUY)):
			_isStrap = true
			sayParsed("{actor.You} {actor.youVerb('secure')} страпон на талию {actor.yourHis} и {actor.youVerb('load')} его чем-то, что очень похоже на сперму...")
			if(!_canGetPreg):
				talk(_targetID, "Погоди, я не могу забеременеть.")
				if(_actorID == C_GIRL):
					talk(_actorID, "Я буду пытаться до тех пор, пока ты не залетишь, сучка.")
				else:
					talk(_actorID, "Посмотрим, так ли это на самом деле.")
			else:
				talk(_targetID, "Ты правда планируешь меня осеменить!?")
				if(_actorID == C_GIRL):
					talk(_actorID, "Сучка, ты принадлежишь мне, так что, конечно, я тебя обрюхачу.")
				else:
					talk(_actorID, "Коровы дают гораздо больше молока, если они беременны.")
			sayParsed("{target.You} {target.youVerb('get')} прижата к полу!")
		else:
			sayParsed("{actor.You} {actor.youVerb('pull')} {actor.yourHis} {actor.penis} out..")
			if(!_canGetPreg):
				talk(_targetID, "Погоди, я не могу забеременеть.")
				if(_actorID == C_GIRL):
					talk(_actorID, "Я буду пытаться до тех пор, пока ты не залетишь, сучка.")
				else:
					talk(_actorID, "Посмотрим, так ли это на самом деле.")
			else:
				talk(_targetID, "Ты правда планируешь меня осеменить!?")
				if(_actorID == C_GIRL):
					talk(_actorID, "Сучка, ты принадлежишь мне, так что, конечно, я тебя обрюхачу.")
				else:
					talk(_actorID, "Коровы дают гораздо больше молока, если они беременны.")
			sayParsed("{target.You} {target.youVerb('get')} прижата к полу!")
		
		if(_isStrap):
			playAnimation(StageScene.SexLowDoggy, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('slam')} {actor.yourHis} блестящий страпон глубоко в {target.yourHis} "+str("tailhole" if !_hasVag else "pussy")+" и {actor.youVerb('pound')} его со всей силы, пока от тесноты игрушка не разрядится глубоко внутри {target.youHim}!")
		else:
			playAnimation(StageScene.SexLowDoggy, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('slam')} {actor.yourHis} {actor.penis} down {target.yourHis} "+str("tailhole" if !_hasVag else "pussy")+" и {actor.youVerb('pound')} его со всей силы, пока оргазм не наполнит {actor.youHim} кучей {actor.yourHis}!")
		
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
				sayParsed("{target.Your} у {target.breasts} внезапно начинает сочиться {target.milk}! {target.YouHe} [b]началось лактация[/b]!")
				if(_actorID == C_GIRL):
					talk(_actorID, "Так-то лучше. Всё, что тебе было нужно — это старое доброе разведение.")
				else:
					talk(_actorID, "Вот так-то. А ты мне не верила.")
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
		sayParsed("Софи вцепляется в горло {target.your} и сжимает его так сильно, что у {target.youHim} в {target.yourHis} глазах начинает темнеть.")
		talk(C_GIRL, RNG.pick([
			"Что, уже не такая крутая?",
			"Что сломается первым: твоя шея или твой дух?",
			"Уже искры из глаз посыпались? Это единственные звезды, которые тебе суждено увидеть.",
			"Ты всего лишь рабыня. Моя рабыня!",
			"Ты гребаная рабыня, слышишь?!",
		]))
	elif(bullyWay == "puppypin"):
		playAnimation(StageScene.PuppyPinned, "pinned", {pc=C_GIRL, npc=_targetID, npcBodyState={naked=true,hard=true,leashedBy=C_GIRL}})
		sayParsed("Софи нацепляет на руки и ноги {target.your} собачьи кандалы, а затем прижимает {target.youHim} к полу ногой, едва касаясь пальцами затылка {target.yourHis}.")
		talk(C_GIRL, RNG.pick([
			"Лай, тупая псина!",
			"Скажешь хоть слово — и я не сниму с тебя эту сбрую.",
			"Просто сучка для разведения.",
			"Виляй своей задницей для меня, сучка. Покажи, за что я заплатил.",
		]))
	elif(bullyWay == "chokeride"):
		playAnimation(StageScene.SexCowgirlChoke, "tease", {pc=_targetID, npc=C_GIRL, bodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Софи стягивает {target.you} на пол, а затем садится верхом на {target.youHim}, наклоняясь и обхватывая обеими руками {target.yourHis} за горло, так что дышать становится невыносимо трудно.")
		talk(C_GIRL, RNG.pick([
			"Что, уже не такая крутая?",
			"Что сломается первым: твоя шея или твой дух?",
			"Уже искры из глаз посыпались? Это единственные звезды, которые тебе суждено увидеть.",
			"Ты всего лишь рабыня. Моя рабыня!",
			"Ты гребаная рабыня, слышишь?!",
		]))
	elif(bullyWay == "sitface"):
		playAnimation(StageScene.SexFaceSitting, "grind", {pc=C_GIRL, npc=_targetID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Софи толкает {target.you} на пол и усаживается прямо на лицо {target.yourHis}, втирая свою мокрую киску в {target.yourHis}, покачивая бедрами и поглядывая на {target.youHim}.")
		talk(C_GIRL, RNG.pick([
			"Ты всего лишь моя лизалка, шлюха.",
			"Тебе ведь это нравится, а? Тупая сучка.",
			"Да хоть утони в моей щелке, мне плевать.",
			"Я немало отвалила за твою задницу. И я буду использовать это лицо так, как захочу.",
			"Лижи меня. Лижи, или я заставлю тебя захлебнуться.",
		]))
	elif(bullyWay == "feetcrotch"):
		playAnimation(StageScene.SexFeetPlay, "crotch", {pc=C_GIRL, npc=_targetID, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		if(_target.hasPenis()):
			sayParsed("Софи шевелит пальцами ног и прижимает их к {target.your} {target.penis}, потирая и надавливая ровно настолько, чтобы заставить {target.youHim} корчиться и скулить.")
			if(_target.isWearingChastityCage()):
				talk(C_GIRL, RNG.pick([
					"Твой член всё равно бесполезен, может, мне его раздавить?",
					"Только посмей капнуть мне на пальцы ног. За это я раздавлю твои яйца.",
					"Тебе ведь нравится, да? Жалкое зрелище.",
				]))
			else:
				talk(C_GIRL, RNG.pick([
					"Тебе повезло, что я умею доить этот член. Иначе я бы его просто раздавила.",
					"Только посмей капнуть мне на пальцы ног. За это я раздавлю твои яйца.",
					"Тебе ведь нравится, да? Жалкое зрелище.",
				]))
		else:
			sayParsed("Софи разминает пальцы ног и прижимает их к паху {target.your}, потирая и надавливая ровно настолько, чтобы заставить {target.youHim} корчиться и скулить.")
			talk(C_GIRL, RNG.pick([
				"Тебе ведь нравится, да? Жалкое зрелище.",
				"Тупая сучка.",
				"Ну почему ты такой тупой?",
			]))
	elif(bullyWay == "feetface"):
		playAnimation(StageScene.SexFeetPlay, "head", {pc=C_GIRL, npc=_targetID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Софи поднимает ногу и медленно проводит пальцами по щеке и губам {target.your}, вжимая пятку в челюсть {target.yourHis}.")
		talk(C_GIRL, RNG.pick([
			"Соси их. Давай, шлюха.",
			"Чего это ты покраснела? Тебе ведь нравится, а?",
			"Ты выглядишь еще жальче, чем мой муж.",
		]))
	elif(bullyWay == "lickcrotch"):
		playAnimation(StageScene.SexOralForced, "lick", {pc=C_GIRL, npc=_targetID, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true, leashedBy=C_GIRL}})
		sayParsed("Софи рывком опускает {target.you} на {target.yourHis} колени и вжимает свою мокрую киску прямо в {target.yourHis} лицо.")
		talk(C_GIRL, RNG.pick([
			"Ты всего лишь моя лизалка, шлюха.",
			"Тебе ведь это нравится, а? Тупая сучка.",
			"Да хоть утони в моей щелке, мне плевать.",
			"Я немало отвалила за твою задницу. И я буду использовать это лицо так, как захочу.",
			"Лижи меня. Лижи, или я заставлю тебя захлебнуться.",
		]))
	elif(bullyWay == "spank"):
		playAnimation(StageScene.Spanking, "fast", {pc=C_GIRL, npc=_targetID, npcBodyState={naked=true, hard=true}})
		sayParsed("Софи ставит {target.you} на четвереньки и раз за разом наотмашь хлопает {target.yourHis} по заднице, пока кожа на {target.yourHis} не покрывается красными пятнами.")
		talk(C_GIRL, RNG.pick([
			"Давай больше молока, иначе твоя задница будет гореть каждый божий день.",
			"На, жри, сучка.",
			"Что, сейчас заныть вздумаешь?",
		]))
	sayParsed("Насладившись издевательствами над {target.you}, Софи наконец оставляет {target.youHim} в покое.")

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
		sayParsed("Игра не смогла понять, как доить {target.you}!")
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
		sayParsed("{actor.You} {actor.youVerb('bring')} {target.you} на пол и {actor.youVerb('milk')} {target.yourHis} {target.breasts} одной рукой, одновременно лаская {target.yourHis} {target.penis} другой!")
	if(milkWay == "grope"):
		shouldMilkBreasts = true
		playAnimation(StageScene.BreastGroping, "grope", {pc=_actorID, npc=_targetID, milkTank=true, npcCum=true, npcBodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('guide')} {target.you} на пол и {actor.youVerb('milk')} {target.yourHis} {target.breasts} обеими руками, позволяя каждой капле стекать в бак!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("В то же время пенисный насос высасывает {target.yourHis} яичек!")
	if(milkWay == "stroke"):
		shouldMilkPenis = true
		#playAnimation(StageScene.ChairOral, "stroke", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true,hard=true}})
		playAnimation(StageScene.Grope, "strokefast", {pc=_targetID, npc=_actorID, milkTank=true, pcCum=true, bodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('lock')} глаза с {target.you} и {actor.youVerb('proceed')}, чтобы медленно и уверенно ласкать {target.yourHis} {target.penis}, пока {target.yourHis} семя не разбрызгается по сборному контейнеру!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	if(milkWay == "fingering"):
		shouldMilkPenis = true
		playAnimation(StageScene.SexFisting, "sex", {pc=_actorID, npc=_targetID, npcCum=true, npcBodyState={naked=true,hard=true}})
		sayParsed("{actor.You} {actor.youVerb('position')} {target.you} на четвереньках, затем {actor.youVerb('slide')} {actor.yourHis} пальцев глубоко внутрь, чтобы дразнить {target.yourHis} простату, качая до тех пор, пока {target.yourHis} {target.penis} не брызнет горячим семенем прямо в ожидающий контейнер!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	if(milkWay == "pegging"):
		shouldMilkPenis = true
		if(addStrapon(_actorID)):
			playAnimation(StageScene.SexFreeStanding, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={naked=true,hard=true}, npcBodyState={naked=true,hard=true}})
			sayParsed("{actor.You} {actor.youVerb('wear')} страпон и {actor.youVerb('start')} пеггинг {target.your} задницы, резиновая игрушка глубоко вжимается, дразня и стимулируя {target.yourHis} простату! Все больше и больше семени стекает из {target.yourHis} {target.penis} в семенной бак.")
		else:
			playAnimation(StageScene.SexFreeStanding, "fast", {pc=_actorID, npc=_targetID, pcCum=true, npcCum=true, bodyState={showPenis=true,hard=true}, npcBodyState={naked=true,hard=true}})
			sayParsed("{actor.You} {actor.youVerb('grab')} {target.you} и {actor.youVerb('line')} {actor.yourHis} член прижимается к {target.yourHis} скользкому анусу, а затем {actor.youVerb('ram')} входит, и каждый толчок направлен прямо в {target.yourHis} простату! Все больше и больше семени стекает из {target.yourHis} {target.penis} в семенной бак.")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	if(milkWay == "breastpumps"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		playAnimation(StageScene.Cuddling, "squirm", {pc=_actorID, npc=_targetID, npcCum=true, npcBodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('hold')} {target.you} близко, пока два молокоотсоса работают над {target.yourHis} {target.breasts}, гудя и выкачивая каждую каплю {target.milk} в свои внутренние резервуары!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("В то же время пенисный насос высасывает {target.yourHis} яичек!")
	if(milkWay == "penispump"):
		shouldMilkPenis = true
		addPenisPump(_targetID)
		playAnimation(StageScene.SybianOral, "hold", {pc=_targetID, npc=_actorID, nosybian=true, chained=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('secure')} пенисный насос вокруг {target.your} {target.penis}, и {actor.youVerb('let')} ритмично качает {target.yourHis} член, пока {target.youHe} не перестает сдерживаться, {target.yourHis} {target.cum} наполняя внутренний резервуар!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	if(milkWay == "stallpenispump"):
		shouldMilkPenis = true
		addPenisPump(_targetID)
		var theChains := [["hoseshort", "penisPump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]
		sayParsed("{actor.You} {actor.youVerb('lock')} {target.you} заходит в доильный отсек и {actor.youVerb('fit')} насос на {target.yourHis} {target.penis}. {actor.YouHe} просто {actor.youHeVerb('watch', 'watches')}, пока кольцо удовольствия ласкает и обхватывает всю длину, стимулируя {target.yourHis} член, пока он не начинает забивать резервуар насоса до краев!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
			theChains.append(["hoseshort", "breastpump", "scene", "milktank"])
		playAnimation(StageScene.MilkingStallSolo, "cum", {pc=_targetID, npc=_actorID, npcCum=true, bodyState={naked=true, hard=true, chains=theChains}})
	if(milkWay == "milkstall"):
		shouldMilkBreasts = true
		playAnimation(StageScene.MilkingStallDuo, "cum", {pc=_targetID, npc=_actorID, npcCum=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('cuff')} {target.you} ведет к доильному отсеку, заставляя {target.youHim} наклониться вперед, а затем начинает доить руками {target.yourHis} {target.breasts}, словно это вымя! Молоко стекает прямо в молочный бак.")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("В то же время пенисный насос высасывает {target.yourHis} яичек!")
	if(milkWay == "milkstallpumps"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		var theChains := [["hoseshort", "breastpump", "scene", "milktank"], ["short", "neck", "scene", "bottompipe"]]
		sayParsed("{actor.You} {actor.youVerb('cuff')} {target.you} ведет к доильному отсеку, и {actor.youVerb('let')} два молокоотсоса вовсю работают над {target.yourHis} {target.breasts}. {actor.YouHe} {actor.youHeVerb('watch', 'watches')}, как они гудят, неуклонно наполняя молочный бак.")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("В то же время пенисный насос высасывает {target.yourHis} яичек!")
			theChains.append(["hoseshort", "penisPump", "scene", "milktank"])
		playAnimation(StageScene.MilkingStallSolo, "cum", {pc=_targetID, npc=_actorID, npcCum=true, bodyState={naked=true, hard=true, chains=theChains}})
	if(milkWay == "milksybian"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		playAnimation(StageScene.SybianOral, "hold", {pc=_targetID, npc=_actorID, pcCum=true, chained=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('set')} {target.you} усаживает на жужжащий сибиан, и {actor.youVerb('let')} два молокоотсоса гудят над {target.yourHis} {target.breasts}, собирая молоко, пока машина трахает {target.yourHis} "+("cunt" if _target.hasReachableVagina() else "ass")+"!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("В то же время пенисный насос высасывает {target.yourHis} яичек!")
	if(milkWay == "fuckmachineseed"):
		shouldMilkPenis = true
		playAnimation(StageScene.HangingSexFuckmachine, "fast", {pc=_targetID, pcCum=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('cuff')} {target.you} за запястья высоко над {target.yourHis} головой. {actor.YouHe} затем {actor.youHeVerb('bring')} сзади фурри-машину и {actor.youHeVerb('turn')} её на! Её толстый дилдо входит в {target.your} задницу и начинает молотить по {target.yourHis} простате, пока {target.yourHis} семя не начинает стекать в сборный бак!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	if(milkWay == "milkmachine"):
		shouldMilkBreasts = true
		addBreastPump(_targetID)
		var theChains := [["hose", "breastpump", "scene", "milkIntake"]]
		sayParsed("{actor.You} {actor.youVerb('oversee')} процесс, пока продвинутая доильная машина использует свои дилдо, чтобы трахать {target.yourHis} отверстия, манипуляторы прижимают {target.yourHis} конечности, а два насоса выкачивают {target.yourHis} {target.breasts} в резервуары!")
		if(_canUsePumps && _canMilkPenis && addPenisPump(_targetID)):
			shouldMilkPenis = true
			sayParsed("В то же время пенисный насос высасывает {target.yourHis} яичек!")
			theChains.append(["hose", "penisPump", "scene", "milkIntake"])
		playAnimation(StageScene.BDSMMachineFuck, "fastdouble", {pc=_targetID, pcCum=true, bodyState={naked=true, hard=true,chains=theChains}})
	if(milkWay == "fingeringsmarttable"):
		shouldMilkPenis = true
		playAnimation(StageScene.MilkingProstate, "fast", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('bend')} {target.you} вперед на продвинутый доильный стол, манипуляторы удерживают {target.yourHis} конечности на месте. Два пальца скользят в {target.yourHis} анус, идеально лаская {target.yourHis} простату, пока {target.yourHis} член не начинает пульсировать, роняя высококачественное семя прямо в приемник жидкости!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	if(milkWay == "peggingsmarttable"):
		shouldMilkPenis = true
		if(addStrapon(_actorID)):
			playAnimation(StageScene.MilkingProstateFuck, "fast", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('secure')} {target.you} на продвинутом столе, манипуляторы удерживают {target.yourHis} конечности на месте. Предварительно смазанный страпон прижимается к {target.yourHis} узкому кольцу, растягивая его, прежде чем скользнуть внутрь. {actor.You} {actor.youVerb('begin')} долбит {target.yourHis} задницу со всей силы, используя возможности стола, чтобы максимально стимулировать простату. Вскоре семя начинает стекать в приемник для жидкости.")
		else:
			playAnimation(StageScene.MilkingProstateFuck, "fast", {pc=_targetID, npc=_actorID, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={showPenis=true, hard=true}})
			sayParsed("{actor.You} {actor.youVerb('secure')} {target.you} на продвинутом столе, манипуляторы удерживают {target.yourHis} конечности на месте. {actor.penis} прижимается к {target.yourHis} узкому кольцу, растягивая его, прежде чем скользнуть внутрь. {actor.You} {actor.youVerb('begin')} долбит {target.yourHis} задницу со всей силы, используя возможности стола, чтобы максимально стимулировать простату. Вскоре семя начинает стекать в приемник для жидкости.")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	if(milkWay == "seedmilkmachine"):
		shouldMilkPenis = true
		playAnimation(StageScene.BDSMMachineAltFuck, "fast" if !_target.hasReachableVagina() else "fastdouble", {pc=_targetID, bodyState={naked=true, hard=true}})
		sayParsed("{actor.You} {actor.youVerb('activate')} the "+("dual-" if _target.hasReachableVagina() else "")+"режим дойки дилдо на продвинутом столе. "+("Два жестких дилдо синхронно входят в {target.yourHis} отверстия" if _target.hasReachableVagina() else "Жесткий дилдо врывается в {target.yourHis} дырку")+", растягивая и долбя {target.yourHis} простату, пока {target.yourHis} член не извергается, наполняя бак для семени густыми струями!")
		if(_canUsePumps && _canMilkBreasts && addBreastPump(_targetID)):
			shouldMilkBreasts = true
			sayParsed("В то же время два молокоотсоса гудят на {target.yourHis} {target.breasts}, вытягивая {target.milk}!")
	
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
		sayParsed("{actor.You} удалось собрать "+str(Util.roundF(collectedMilk, 1))+"мл {target.milk} и "+str(Util.roundF(collectedSeed, 1))+"мл {target.cum}.")
	elif(shouldMilkBreasts):
		sayParsed("{actor.You} удалось собрать "+str(Util.roundF(collectedMilk, 1))+"мл {target.milk}.")
	elif(shouldMilkPenis):
		sayParsed("{actor.You} удалось собрать "+str(Util.roundF(collectedSeed, 1))+"мл {target.cum}.")
	
	if(collectedEnough):
		if(_targetID == C_PC || _actorID == C_PC):
			pcGaveMilkOrSeed += 1
		if(_actorID == C_GIRL):
			talk(_actorID, RNG.pick([
				"Достаточно.",
				"На сегодня хватит. Скоро вернусь.",
				"Хорошо. А теперь брысь отсюда.",
				"Конечно, сойдет.",
			]))
		elif(_actorID == C_GUY):
			talk(_actorID, RNG.pick([
				"Такая послушная "+("cow" if shouldMilkBreasts else "bull")+". Спасибо.",
				"Отличная работа, теперь мы сможем какое-то время содержать кафе.",
				"Это великолепно, спасибо. Хорошо. "+("cow" if shouldMilkBreasts else "bull")+".",
				"Клиентам понравится. Спасибо.",
			]))
		else:
			talk(_actorID, RNG.pick([
				"Такая послушная "+("cow" if shouldMilkBreasts else "bull")+".",
				"Хорошо. "+("cow" if shouldMilkBreasts else "bull")+". Очень хорошо.",
				"Добро. "+("cow" if shouldMilkBreasts else "bull")+". А теперь иди отдохни.",
				"Приятно на это смотреть. Теперь можешь отдыхать.",
			]))
		milkedToday += 1
	else:
		if(_actorID == C_GIRL):
			talk(_actorID, RNG.pick([
				"Это почти ничто. Жалкое зрелище.",
				"Серьезно? Это же почти пусто. Бесполезная сучка.",
				"Практически ничего. Я зря только время на тебя тратил. Тьфу.",
				"Жалкий улов. Зачем я тебя вообще держу?",
			]))
		elif(_actorID == C_GUY):
			talk(_actorID, RNG.pick([
				"Этого... маловато. Постараешься в следующий раз получше?",
				"К сожалению, этого недостаточно. Некоторым клиентам придется остаться голодными.",
				"Маловато... "+("Как мне печь капкейки без сливок..." if shouldMilkPenis else "Как мне делать капучино без молока..."),
				"К сожалению, этого недостаточно.",
			]))
		else:
			talk(_actorID, RNG.pick([
				"К сожалению, этого недостаточно.",
				"К несчастью, маловато.",
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
	
	talk(C_GUY, "Прости, но отпустить тебя я не могу.")
	
	saynn("Тебе хочется как-то ответить... но ты не можешь. Твое тело бьется в конвульсиях на полу от остаточных разрядов...")
	
	saynn("Лео хватает тебя за шиворот и затаскивает обратно в кафе.")
	
	talk(C_GUY, "Э-э... не обращайте на нас внимания, пожалуйста. Приятного аппетита, делайте вид, что нас здесь нет.")
	
	saynn("Увидев тебя — голым, а рядом парня с электрошокером... большинство посетителей просто спешно собирают вещи и сваливают.")
	
	addContinue("setState", ["flback"])

func flback_state():
	addChar(C_GUY)
	addChar(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_GIRL, npc=C_GUY})
	aimCamera(L_CENTER)
	
	saynn("Тебя волокут обратно в тускло освещенную служебную комнату...")
	
	talk(C_GIRL, "ДА ВЫ ИЗДЕВАЕТЕСЬ?! Вы позволили {pc.him} сбежать? Какого хера с вами не так?!")
	
	talk(C_GUY, "Это не я. {pc.He} каким-то образом удалось вырваться.")
	
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
		"ПОЧЕМУ ВЫ ТАКИЕ ЕБАНЫЕ ЛЕНИВЫЕ? ГДЕ МОЙ "+("MILK" if agreeMilk else "SEED")+"? КАК МНЕ ТЕПЕРЬ УПРАВЛЯТЬ КАФЕ?",
		"ВЫ ЧТО, ПОДУМАЛИ, ЧТО ЭТО КУРОРТНЫЙ ОТДЫХ?! ЛУЧШЕ НАЧНИТЕ ОТДАВАТЬ МНЕ ВАШ "+("MILK" if agreeMilk else "SEED")+" , ИНАЧЕ МНЕ ПРИДЕТСЯ ВАС ПРОДАТЬ. МОЖЕТ, ДАЖЕ ПО ЧАСТЯМ.",
		"СУЧКА, Я КУПИЛ ТЕБЯ, ПОТОМУ ЧТО МНЕ НУЖНО ИЗ ЧЕГО-ТО СЛЕПИТЬ КАПКЕЙКИ. ДАВАЙ МНЕ "+("MILK" if agreeMilk else "SEED")+" А НЕ ТО ТВОЕЙ ПЛОТЬЮ СТАНЕТ НАЧИНАНИЕ.",
		"ДУМАЕШЬ, ТЫ УМНАЯ? Я БУДУ ТЕРЗАТЬ ТЕБЯ, ПОКА ТЫ НЕ НАЧНЕШЬ ОТДАВАТЬ МНЕ МОЁ "+("MILK" if agreeMilk else "SEED")+". ВСЁ ДО КАПЛИ.",
	]))
	
	saynn("Она явно в ярости из-за того, что ты не выдал ни семени, ни молока для кафе...")
	
	saynn("Ты пытаешься сбросить её с себя... но, похоже, она ещё не закончила тебя наказывать...")
	
	addContinue("startSex", [C_GIRL, C_PC, SexType.DefaultSex, {SexMod.SubMustGoUnconscious:true, SexMod.DisableDynamicJoiners:true}])
	if(getShivAmount() > 0):
		addAction("Shiv her!", "Заставить её отъебаться, вонзив в неё заточку", "useshiv")
	else:
		addDisabledAction("Заткнуть её заточкой!", "У тебя нет заточков")

func morningpunish_do(_id:String, _args:Array):
	if(_id == "useshiv"):
		playAnimation(StageScene.Duo, "shiv", {npc=C_GIRL, npcAction="defeat"})
		
		saynn("Тебе удаётся вырваться, вонзив заточку ей в руку!")
		talk(C_GIRL, RNG.pick([
			"А-А-А! ТЫ, УБЛЮДОК!",
			"ТЫ, СУЧКА... БЛЯТЬ!",
			"БЛЯДСКИ БОЛЬНО, ГАНДОН.",
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
			"..ебаная шлюха.",
			"..тупая сучка.",
			"..я с тобой еще не закончил, блядь.",
			"Уф. Пошла ты нахуй.",	
		]))
		saynn("Она кряхтит... и оставляет тебя в покое... пока что.")
		addObedience(-5)
	else:
		if(_sex.isSubUnconscious(C_PC)):
			playAnimation(StageScene.SexStart, "defeated", {pc=C_GIRL})
			saynn("Софи убирает руки от твоего горла и несколько раз дает тебе звонкую пощечину.")
			talk(C_GIRL, RNG.pick([
				"Вставай, тупая сучка. Знаю, что ты не сдохла.",
				"Вставай. Если не хочешь добавки, лучше начинай выдавать молоко.",
			]))
			saynn("Она быстро уходит и возвращается с ведром воды, которое выплескивает тебе в лицо. Освежает.")
			addStamina(40)
			addPain(-50)
		elif(_sex.getAverageDomSatisfaction() < 0.7):
			playAnimation(StageScene.SexStart, "start", {pc=C_GIRL})
			saynn("С Софи покончено... но она не выглядит особо удовлетворенной.")
			talk(C_GIRL, RNG.pick([
				"Ты даже сопротивляться толком не умеешь.",
				"Почему ты такая ебаная слабая? Уф, всё вокруг меня — сплошное разочарование.",
				"В следующий раз постарайся получше, шлюха.",
			]))
			addObedience(-2)
		else:
			playAnimation(StageScene.SexStart, "start", {pc=C_GIRL})
			saynn("С Софи покончено... кажется, она больше не чувствует такого... напряжения.")
			talk(C_GIRL, RNG.pick([
				"Начинай выдавать, иначе увидишь меня снова.",
				"Если уж на то пошло, то у меня хотя бы появилась груша для битья. Вторая за сегодня.",
				"В следующий раз постарайся лучше, сучка.",
			]))
	
	if(!canMilkOthers):
		canMilkOthers = true
		saynn("Прежде чем уйти, она добавляет кое-что еще...")
		talk(C_GIRL, "Если не можешь дать достаточно мне, "+cowBullBoth("milk", "cream", "milk")+", начни доить остальных. Будь полезной, мразь.")
	
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
	
	sayParsed("{actor.You} {actor.youVerb('want')} доит {target.you}!")
	
	if(theOwner == C_GIRL):
		talk(C_GIRL, RNG.pick([
			"Время дойки, шлюха.",
			"Я пришла доить тебя, так что веди себя прилично, животное.",
		]))
	if(theOwner == C_GUY):
		talk(C_GUY, RNG.pick([
			"Сейчас я буду тебя доить.",
			"Ты готова к дойке?",
			"Нашему кафе нужны молоко и сливки, чтобы продолжать работу. Я здесь, чтобы подоить тебя.",
		]))
	
	addAction("Watch", "Посмотреть, что будет", "doWatch", [theOwner, theSlave])
	if(obedience > 0.2):
		if(GM.pc.getStamina() > 0):
			if(GM.pc.hasBlockedHands() || GM.pc.hasBoundArms()):
				addDisabledAction("Помочь хозяйке", "Твои руки связаны...")
			else:
				addAction("Help owner", "Попросить разрешения самой заниматься дойкой.", "doHelp", [theOwner, theSlave])
		else:
			addDisabledAction("Помочь хозяйке", "Недостаточно выносливости")
	else:
		addDisabledAction("Помочь хозяйке", "Владельцы тебе недостаточно доверяют.")

func eOwnerMilkSlave_do(_id:String, _args:Array):
	var theOwner:String = _args[0]
	var theSlave:String = _args[1]
	charOverrides = {actor=theOwner, target=theSlave}
	if(_id == "doWatch"):
		milkScene(theOwner, theSlave)
		addContinue("setState", ["main"])
	if(_id == "doHelp"):
		sayParsed("Ты спрашиваешь {actor.name}, можно ли тебе помочь с дойкой. {actor.He} решает позволить тебе это сделать.")
		if(theOwner == C_GIRL):
			talk(theOwner, RNG.pick([
				"Конечно, это сэкономит мне время.",
				"Ладно, будь полезной.",
				"Да к черту, валяй. Только выжми из них всё до последней капли.",
				"Неважно, иди делай, мне нужно вернуться за стойку.",
				"Ты? Ладно. Только не вздумай халтурить.",
			]), false)
		else:
			talk(theOwner, RNG.pick([
				"Конечно, это сэкономит мне время.",
				"Ладно, будь полезной.",
				"Да к черту, валяй. Только выжми из них всё до последней капли.",
				"Неважно, иди делай, мне нужно вернуться за стойку.",
				"Ты? Ладно. Только не вздумай халтурить.",
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
		"Чего уставилась, тупая скотина? Хочешь получить наказание?",
		"Что-то я сегодня злая. А ну, иди сюда, сучка.",
		"У меня не самое лучшее настроение. А это значит — время унижений!",
		"Сучка, когда я в последний раз тебя унижала? Пора снова напомнить тебе твое место.",
		"Иди сюда. Мне нужен новый повод, чтобы посмеяться над тобой.",
		"Посмотри на себя: стоишь тут с таким видом, будто ты чего-то стоишь. Ни черта подобного. Не веришь?",
		"Ты что, уже забыла свое место, тупое животное? Я могу быстро напомнить.",
	]))
	
	sayParsed("{actor.You} явно {actor.youVerb('want')}, чтобы издеваться над {target.youHim}!")
	
	addAction("Let it happen", "Посмотреть, что будет", "doWatch", [theOwner, theSlave])
	addAction("Protect", "Защитить рабыню!", "doProtect", [theOwner, theSlave])
	addAction("Get bullied", "Сделать так, чтобы Софи издевалась над тобой", "takeBlame", [theOwner, theSlave])

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
		sayParsed("Ты пытаешься защитить {target.you} от Софи!")
		if(theSlave == C_BULL):
			addBullTrust(5)
		else:
			addCowTrust(5)
		talk(C_GIRL, RNG.pick([
			"Серьезно? Ты еще тупее, чем я думала.",
			"Думаю, мне придется наказать вас обоих.",
			"Это была большая ошибка.",
		]))
		sayParsed("Похоже, тебе придется сражаться.")
		addObedience(-1)
		addAction("Fight", "Начать бой", "startFight", [C_GIRL])
		if(getShivAmount() > 0):
			addAction("Shiv her!", "Используй заточку, чтобы она отъебалась", "useShiv")
	if(_id == "useShiv"):
		playAnimation(StageScene.Duo, "shiv", {npc=C_GIRL, npcAction="defeat"})
		saynn("Прежде чем Софи успевает среагировать, ты выхватываешь шило и наносишь ей удар!")
		
		talk(C_GIRL, RNG.pick([
			"АЙ, СУКА!",
			"ГДЕ ТЫ ЭТО ВЗЯЛА, СУЧКА?!",
			"УГХ, Я ТЕБЯ СЛОМАЮ... блядь...",
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
		sayParsed("Ты говоришь Софи, чтобы она выместила весь свой гнев на тебе!")
		talk(C_GIRL, RNG.pick([
			"Ладно, ты сам напросился.",
			"Правда? Неужели ты такая развратная шлюха?",
			"Конечно, я унижу и тебя тоже.",
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
			"Я с тобой ещё не закончил, шлюха...",
			"Арх... Да пошла ты тогда, тупая сука.",
			"Ладно, тогда пошло оно всё нахуй.",
			"Если ты не прекратишь, я из тебя просто капкейки сделаю.",
		]))
		addObedience(-5)
	else:
		saynn("Ты проиграл в схватке...")
		talk(C_GIRL, RNG.pick([
			"Жалкое зрелище.",
			"Это было тупо. Очень тупо.",
			"Из героя в ничтожества.",
			"Мне и так хватает ленивых ублюдков вокруг.",
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
	
	sayParsed("Софи подходит к Милке, сжимая в руке электрошокер!")
	talk(C_GIRL, RNG.pick([
		"Немного разрядов явно помогут тебе давать больше молока.",
		"В кафе не хватает молока, Милка. Покажи свои сиськи.",
		"Выставляй свои сиськи, корова.",
		"Это пойдет твоим сиськам на пользу. Показывай.",
	]))
	sayParsed("Милка вздрагивает, её губы дрожат.")
	talk(C_COW, RNG.pick([
		"Когда ты так делаешь... это больно...",
		"Раз ты так говоришь...",
		"Я думала, что даю достаточно...",
	]))
	
	addAction("Let it happen", "Посмотреть, что будет", "doWatch", [theOwner, theSlave])
	addAction("Protect", "Защитить рабыню!", "doProtect", [theOwner, theSlave])

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
		talk(C_COW, "Ай!")
		saynn("Тело Милки содрогается, мышцы напрягаются... и из её сосков брызжет чистое молоко!")
		talk(C_GIRL, "Так гораздо лучше.")
	
	if(_id == "doProtect"):
		if(RNG.chance(50)):
			playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc="pc", npcAction="hurt"})
			
			saynn("Ты отталкиваешь Милку с пути электрошокера... и получаешь удар вместо неё. Ой! Всё тело сотрясается от резкого болезненного разряда, прошивающего тебя насквозь.")
			addPain(40)
			addStamina(-25)
			
			talk(C_GIRL, "Серьёзно? Ладно, твои сиськи тоже сойдут.")
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
			talk(C_GIRL, "У меня нет на это времени. Пошла ты.")
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
	
	sayParsed("Софи приближается к Пипу с электрошокером в руке!")
	talk(C_GIRL, RNG.pick([
		"Немного разрядов должны помочь тебе вырабатывать больше семени.",
		"В кафе не хватает сливок, Пип. Покажи мне свой член.",
		"Предъяви свои яйца, бык.",
		"Это поможет твоей выработке спермы. Предъяви себя.",
	]))
	sayParsed("Пип отступает от неё назад.")
	talk(C_BULL, RNG.pick([
		"Серьёзно? Используй это на той странной корове, а не на мне.",
		"Ты НЕ поднесешь эту штуку ни на йоту к моим яйцам!",
		"Нет-нет-нет, уходи!",
		"Я достану тебе сливок, тебе не обязательно это делать.",
	]))
	
	addAction("Let it happen", "Посмотреть, что будет", "doWatch", [theOwner, theSlave])
	addAction("Protect", "Защитить рабыню!", "doProtect", [theOwner, theSlave])

func eGirlCattleProdBull_do(_id:String, _args:Array):
	var theOwner:String = _args[0]
	var theSlave:String = _args[1]
	charOverrides = {actor=theOwner, target=theSlave}
	if(_id == "doWatch"):
		addChar(theOwner)
		addChar(theSlave)
		GlobalRegistry.getCharacter(C_BULL).fillBalls(1.0)
		playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc=theSlave, npcBodyState={hard=true}, npcAction="hurt"})
		saynn("Софи прижимает электрошокер к "+("девственная клетка" if !cageRemoved else "balls")+" Пипу и сжимает рукоятку, пропуская через него болезненный разряд.")
		talk(C_BULL, "АААГХ! БЛЯТЬ!")
		saynn("Тело Пипа сотрясается конвульсиями, из его рта вырывается гортанный крик... "+("Его зажатый член пульсирует в своей тесной тюрьме, сочась семенем." if !cageRemoved else "Его член мгновенно встает колом, пульсируя, а раздутая головка течет от смазки."))
		talk(C_GIRL, "Так гораздо лучше.")
	
	if(_id == "doProtect"):
		if(RNG.chance(50)):
			playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc="pc", npcAction="hurt", npcBodyState={hard=true}})
			
			saynn("Ты отталкиваешь Пипа с пути электрошокера... и вместо него получаешь удар сам. Ой! Всё твоё тело пронзает резкий, болезненный разряд тока.")
			addPain(40)
			addStamina(-25)
			
			talk(C_GIRL, "Ты реально хочешь защищать этого жалкого недотраха? Пфф.")
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
			talk(C_BULL, "Это отстой. Сорян.")
			addBullTrust(4)
		else:
			playAnimation(StageScene.Duo, "stunbaton", {pc=theOwner, npc="pc", npcAction="dodge"})
			
			saynn("Ты отталкиваешь Пипа с пути электрошокера... и тебе удаётся увернуться!")
			addStamina(-25)
			saynn("Софи закатывает глаза.")
			talk(C_GIRL, "У меня нет на это времени. Пошла ты.")
			addObedience(-4)
			saynn("Когда Софи уходит, Пип подходит к тебе.")
			talk(C_BULL, "Нахер эту сучку, да?")
			addBullTrust(4)
	
		if(RNG.chance(100.0 - getShivAmount()*40.0)):
			saynn("Он протягивает тебе заточенный камень.")
			addShiv()
			talk(C_BULL, "Надеюсь, это будет тебе полезно.")
	
	addContinue("setState", ["main"])



func eEatAss_state():
	addChar(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_GIRL})

	saynn("К тебе подходит Софи, держа в руке какое-то аппетитное лакомство.")
	talk(C_GIRL, "Хочешь это? Знаю, что хочешь.")
	saynn("Свободной рукой она хватает тебя за воротник.")
	talk(C_GIRL, "Моей заднице нужно хорошенько полакомиться.")
	if(GM.pc.isOralBlocked()):
		saynn("Она побрякивает ключами прямо перед твоим лицом.")
		talk(C_GIRL, "Если сделаешь это, я даже позволю тебе размять лицо.")
	
	addAction("Deny", "Вкусняшка того не стоит.", "deny")
	addAction("Eat ass", "О-о, вкусняшка!", "eatAss")

func eEatAss_do(_id:String, _args:Array):
	if(_id == "deny"):
		saynn("Вы отклоняете её предложение.")
		talk(C_GIRL, "Ладно, пошла ты тогда.")
		addObedience(-1)
	
	if(_id == "eatAss"):
		GM.pc.freeEyesDeleteAll()
		GM.pc.freeMouthDeleteAll()
		playAnimation(StageScene.SexRimming, "fast", {pc=C_GIRL, npc=C_PC, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Вы повинуетесь: встаете на колени и наблюдаете, как Софи разворачивается и сует свою задницу вам прямо в лицо.")	
		saynn("Нежными движениями языка вы начинаете обслуживать её, смачивая её анус своей слюной.")
		talk(C_GIRL, RNG.pick([
			"Давай же, сучка, засунь туда язык.",
			"Делай как следует, иначе никакой вкусняшки!",
			"Ммм... может, мне лучше использовать тебя как свою подстилку для лизания задницы.",
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
	talk(C_GUY, "Не бойся, я здесь не для того, чтобы тебя задирать. Может, просто расслабимся вместе?")
	
	addAction("Chill", "Согласиться на отдых со своим хозяином", "chill")
	addAction("No", "Ты бы предпочел этого не делать", "noChill")

func eWannaCuddle_do(_id:String, _args:Array):
	if(_id == "noChill"):
		saynn("Вы отклоняете его предложение.")
		talk(C_GUY, "Конечно, ладно, без проблем.")
	
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
		"У тебя есть вкусняшка? Можно мне?? Ну пожааааалуйста!",
		"Вкусняшка? Пожалуйста?.. Обожаю вкусняшки...",
		"О, я чую вкусняшку на тебе! Раз ты её ещё не съела... может, мне можно?..",
		"Вкусняшка?..",
	]))
	saynn("Она опускается перед тобой на колени... и смотрит на тебя взглядом преданного щенка.")
	
	addAction("Give treat", "Дать Милке вкусняшку", "give")
	addAction("No", "Ты предпочитаешь приберечь её", "noGive")

func eCowSeesTreat_do(_id:String, _args:Array):
	if(_id == "noGive"):
		saynn("Ты отказываешь Милке.")
		talk(C_COW, "О-о-о...")
		saynn("Она пытается это скрыть... но ей явно грустно.")
		addCowTrust(-3)
	
	if(_id == "give"):
		playAnimation(StageScene.Beg, "pat", {pc=C_COW, npc=C_PC})
		saynn("Как тут можно сказать «нет»? Ты даешь Милке лакомство и ласково гладишь её.")
		addTreat(-1)
		saynn("Милка счастливо уплетает угощение и с восторгом прижимается носом к твоей руке!")
		talk(C_COW, RNG.pick([
			"Спасибо, спасибо, спасибооооооо!",
			"Это БЫЛО ТАК ВКУСНО!",
			"Спасибкиииии!",
			"Ты такая добрая!",
		]))
		addCowTrust(4)
	
	addContinue("setState", ["main"])


func eBullSeesTreat_state():
	addChar(C_BULL)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_BULL})

	saynn("Пип медленно подходит к тебе, низко опустив голову.")
	talk(C_BULL, RNG.pick([
		"Буду честен... я чертовски голоден... не хочу жрать эту тупую траву... У тебя случайно нет чего-нибудь поинтереснее?",
		"Прости, что спрашиваю... но, может, у тебя есть какая-нибудь еда? Терпеть не могу эту траву, блин... просто ненавижу её...",
	]))
	saynn("Он выглядит отчаявшимся.")
	
	addAction("Give treat", "Дать Пипу вкусняшку", "give")
	addAction("No", "Ты предпочитаешь приберечь её", "noGive")
	addAction("Eat ass!", "Подразнить его. Твоя задница — отличное лакомство", "eatAss")

func eBullSeesTreat_do(_id:String, _args:Array):
	if(_id == "noGive"):
		saynn("Ты отказываешь Пипу.")
		talk(C_BULL, RNG.pick([
			"Shit.. fine..",
			"Я видел, что у тебя была вкусняшка... но ладно... бля...",
			]))
		saynn("Он направляется к травяному полю.")
		addBullTrust(-2)
	if(_id == "give"):
		playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_BULL})
		saynn("У тебя завалялось лишнее лакомство, и ты решаешь угостить его.")
		addTreat(-1)
		saynn("Пип хватает его и смакует, старательно облизывая со всех сторон... прежде чем вонзить в него зубы.")
		talk(C_BULL, RNG.pick([
			"Черт, это слишком вкусно... Спасибо, друг.",
			"Твою мать, как же вкусно... Спасибо.",
			"Что они туда добавляют... хочу еще... Спасибо.",
		]))
		addBullTrust(3)
	if(_id == "eatAss"):
		playAnimation(StageScene.SexRimming, "fast", {pc=C_PC, npc=C_BULL, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		talk(C_PC, "Моя жопа — тоже отличная вкусняшка, знаешь ли.")
		saynn("Он пожимает плечами.")
		talk(C_BULL, "Конечно.")
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
		talk(C_PC, "Погоди, хочешь вкусняшку?")
		talk(C_BULL, "Э-э... Ну, вроде всё. Спасибо.")
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
		
		talk(C_BULL, "Можно спросить? Ты вообще понимаешь, что ты — рабыня?")
		talk(C_COW, "Му? Я же корова... А коровы не могут быть рабынями...")
		talk(C_BULL, "На твоей шее плотно сидит ошейник.")
		saynn("Милка пытается взглянуть на свою шею.")
		talk(C_COW, "Неужели? Может, я тогда тоже щеночек? Коровупсик! Ауф-муу!")
		saynn("Парень вздыхает и просто оставляет её в покое.")
	if(theEvent == "milkapip2"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "Надеюсь, у тебя всё путём, Пип!")
		talk(C_BULL, "Ну, наверное. А чего ты спрашиваешь? Что тебе нужно?")
		saynn("Милка моргает.")
		talk(C_COW, "Эм.. я не знаю.. а.. прости..")
		saynn("Пип вздыхает.")
		talk(C_BULL, "Всё хорошо, Милка... Всё хорошо. Спасибо, и у тебя тоже всё пусть будет хорошо.")
		saynn("Милка просияла, быстро ткнулась носом в красавца и убежала.")
	if(theEvent == "milkapip3"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "Пип, а быки любят морковку?")
		talk(C_BULL, "Это... кролики. И вообще-то я лошадь, а не бык.")
		saynn("Милка в замешательстве наклоняет голову, и её ушки забавно хлопают.")
		talk(C_COW, "Оу. А как насчет кубиков сахара?")
		talk(C_BULL, "Ну, я бы съела, конечно.")
		saynn("Она ахает.")
		talk(C_COW, "Лошади едят сахар?! Хочу тоже быть лошадкой! Иго-го-му!")
		saynn("Пип просто закрывает глаза и вздыхает, стараясь не улыбнуться.")
	if(theEvent == "milkapip4"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "Ты выглядишь грустной, Пип. Хочешь, поделюсь с тобой молоком?")
		talk(C_BULL, "Это... не совсем то, что я обычно пью.")
		saynn("Милка наклоняет голову, а затем пожимает плечами.")
		talk(C_COW, "Значит, больше достанется мне!")
		saynn("Она обхватывает свои груди руками и хихикает, пока Пип что-то бормочет себе под нос и отводит взгляд.")
	if(theEvent == "milkapip5"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		saynn("Милка подходит к Пипу, сжимая в пальцах крошечный цветок.")
		talk(C_COW, "Держи!")
		talk(C_BULL, "Ты вообще где это взяла?")
		talk(C_COW, "Нашла его у самой стены! Он рос совсем один, так что теперь он твой.")
		saynn("Пип колеблется, прежде чем взять его, явно не зная, как реагировать.")
		talk(C_BULL, "..Спасибо, Милка.")
		saynn("Милка помогает привязать это к уху Пипа.")
		talk(C_COW, "Ура! Теперь ты у нас породистый бычок!")
	if(theEvent == "milkapip6"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		if(!cageRemoved):
			saynn("Милка сидит на корточках перед Пипом, не отрывая взгляда от его девственной клетки.")
			talk(C_BULL, "Ты что творишь?")
			talk(C_COW, "А это еще что такое?")
			saynn("Пип вздыхает.")
			talk(C_BULL, "Корсет целомудрия. В нем невозможно никого оплодотворить.")
			saynn("Милка ахает.")
			talk(C_COW, "Но какой же ты бык, если не можешь трахаться?! Как ты собираешься осеменять меня?!")
			talk(C_BULL, "Я не бык, ясно?! Я жеребец! Эти тупые хозяева купили меня и используют как обычного быка.")
			saynn("Милка прищуривается.")
			talk(C_COW, "Тут и правда что-то не сходится, ты прав. Ты не бык.")
			saynn("Пип пожимает плечами.")
			talk(C_COW, "И ты тоже не жеребец... Может, ты корова, как и я! Умеешь мычать? Му-у~.")
			saynn("Пип снова вздыхает.")
		else:
			saynn("Милка сидит на корточках перед Пипом, уставившись на его лошачий член.")
			talk(C_BULL, "Ты что творишь?")
			talk(C_COW, "А где твоя штуковина?")
			talk(C_BULL, "Ш.. штуковина?")
			saynn("Милка наклоняет голову набок.")
			talk(C_COW, "Ну.. знаешь, такая железная штуковина.")
			talk(C_BULL, "Корсет целомудрия. Наш друг здесь помог мне его взломать.")
			saynn("Он кивает в твою сторону.")
			talk(C_COW, "О-О-О! Значит, теперь тебя можно осеменять?!")
			talk(C_BULL, "Думаю, да.")
			saynn("Милка улыбается.")
	if(theEvent == "milkapip7"):
		addChar(C_COW)
		addChar(C_BULL)
		playAnimation(StageScene.Duo, "stand", {pc=C_COW, npc=C_BULL})
		
		talk(C_COW, "Пип, а быки умеют мурлыкать?")
		talk(C_BULL, "Нет.")
		talk(C_COW, "Вы уверены?")
		talk(C_BULL, "Очень.")
		saynn("Милка прижимается к его груди и закрывает глаза.")
		talk(C_COW, "Хмм.. нет. Не мурлыкают. Ты бракованный бык.")
		talk(C_BULL, "..Я чувствую себя сломленной, да.")
		talk(C_COW, "Ты мне всё ещё нравишься..")
		saynn("Милка нежно похлопывает его, а затем убегает вприпрыжку.")

	addContinue("setState", ["main"])



func eHelpCage_state():
	playAnimation(StageScene.TFLook, "crotch", {pc=C_BULL})
	aimCamera(L_BULL)
	
	saynn("Пип дергает за свою девственницкую клетку, пытаясь снять её... но в процессе лишь сильнее сдавливает яйца.")
	talk(C_BULL, "Ах, блядь.. Сука!")
	
	addAction("Ignore", "Пусть остается в клетке", "setState", ["main"])
	if(GM.pc.getStamina() > 0):
		addAction("Help", "Помочь Пипу с его клеткой. Потратит немного выносливости..", "doHelp")
	addAction("Bully", "Затравить его и его запертый член!", "doBully")

func eHelpCage_do(_id:String, _args:Array):
	if(_id == "doHelp"):
		saynn("Вы решаете помочь ему.")
		talk(C_BULL, "О.. ну конечно, попробуй.")
		playAnimation(StageScene.ChairOral, "rub", {pc="pspip", npc="pc"})
		
		saynn(RNG.pick([
			"Вы осматриваете девственную клетку Пипа и пытаетесь стряхнуть её.",
			"Вы крепко хватаете основание клетки Пипа и с силой поворачиваете её, пытаясь ослабить хватку на его препуции.",
			"Вы вставляете ноготь в замок клетки Пипа и пытаетесь его провернуть.",
			"Вы находите в саду камешек и начинаете осторожно долбить им по замку клетки Пипа.",
			"Вы затачиваете найденную в саду веточку и пытаетесь использовать её как отмычку внутри клетки Пипа.",
			"Вы крепко хватаетесь за металлические части клетки Пипа и изо всех сил пытаетесь их согнуть.",
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
			saynn("Вы прижимаете его к полу и садитесь ему на лицо, так что ваши яйца покоятся на его лбу."+(", твоя киска заливает его морду и щеки соками" if GM.pc.hasReachableVagina() else "")+"!")
		elif(GM.pc.hasReachableVagina()):
			saynn("Вы прижимаете его к полу и садитесь ему на лицо, так что ваша киска заливает его морду и щеки соками!")
		else:
			saynn("Вы прижимаете его к полу и садитесь ему на лицо, вжимая промежность прямо в его морду!")
		talk(C_PC, RNG.pick([
			"Тебе правда так нужен твой член? И так всё отлично. Настоящая жопошлёпка S-класса.",
			"Спорим, ты уже забыл, каково это — чувствовать свой член? Впрочем, какая разница, а? Твоя задница всё делает за него.",
			"Такой миленький фембой, и весь в клетке. Мне почти жаль его... почти.",
			"Глупый самец, я думала, ты уже привык к роли секс-игрушки.",
		]))
		saynn("Его лицо слегка краснеет... но он пытается оттолкнуть вас.")
		talk(C_BULL, RNG.pick([
			"Я же самец...",
			"Я не шлюха...",
			"Я сильный... и породистый...",
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
	talk(C_GIRL, "ПОЧЕМУ ТЫ ТАКОЙ ТУПОЙ? АРГХ!")
	saynn("Ого... ну и злющая сучка.")
	talk(C_GIRL, "ЕСЛИ ПРИДЕТСЯ, Я ТЕБЕ НОГИ ОТРЕЖУ. СЛЫШИШЬ?!")
	saynn("К ней присоединяется второй владелец.")
	talk(C_GUY, "Что случилось, милый?")
	saynn("Она хватает и его, тоже толкая назад.")
	talk(C_GIRL, "ЧТО СЛУЧИЛОСЬ? Нас чуть не спалили с ЕБАНЫМИ РАБАМИ в подвале, вот что! Это всё твоя вина!")
	saynn("Парень слегка опускает голову... и осторожно подходит к своей партнерше, нежно обнимая её.")
	talk(C_GUY, "Но нас ведь не поймали, верно?")
	saynn("Софи сбрасывает его руки...")
	talk(C_GIRL, "Если ты не будешь присматривать за этой сукой, это лишь вопрос времени. Я не хочу сгнить в ебаной тюрьме.")
	saynn("Лео снова обнимает её, ласково прижимаясь щекой к её щеке.")
	talk(C_GUY, "Моя вина, любовь моя. Постарайся расслабиться, отдохни. Если будем осторожны, то прорвемся. Вместе.")
	saynn("Софи пронзает тебя яростным взглядом... но затем просто вздыхает.")
	talk(C_GIRL, "Ладно... Мне нужен массаж.")
	saynn("Лео расцветает в улыбке. Он берет Софи за руку и приглашает её следовать за собой.")
	saynn("Интересно.")
	addContinue("setState", ["main"])


func ePeekFirstEvent_state():
	aimCamera(L_SLEEP)
	addChar(C_GIRL)
	addChar(C_GUY)
	playAnimation(StageScene.Choking, "idle", {pc=C_GIRL, npc=C_PC})
	
	saynn("Прежде чем ты успеваешь заснуть, Софи врывается в твою камеру и прижимает тебя к стене.")
	talk(C_GIRL, "ТЫ ВСЁ ПРОСРАЛ, ПОНИМАЕШЬ?! НАДЕЮСЬ, ТЫ, БЛЯДЬ, ДОВОЛЕН!")
	saynn("Она рычит и слегка сдавливает тебе горло... но вдруг резко убирает руки от твоей шеи.")
	talk(C_GIRL, "И я даже не могу причинить тебе боль. Ааах, как же я тебя ненавижу.")
	saynn("Входит Лео, второй владелец.")
	talk(C_GUY, "Софи? Мы уже закрыты, но за столиком всё еще кто-то сидит.")
	talk(C_GIRL, "Ага. Он знает про ЭТУ СУКУ.")
	saynn("Глаза парня округляются.")
	talk(C_GUY, "Ох, бля... Я видела кобуру у него на поясе. Нам пиздец?")
	talk(C_GIRL, "Хрен его знает. Но он сказал, что хочет видеть {pc.him}.")
	addContinue("setState", ["ePeekFirstEvent2"])
	
func ePeekFirstEvent2_state():
	aimCamera(L_SLEEP)
	addChar(C_GIRL)
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {pc=C_PC, npc=C_GIRL, bodyState={leashedBy=C_GIRL}})
	saynn("Софи достает поводок и пристегивает его к твоему ошейнику. Затем она заглядывает тебе прямо в глаза.")
	talk(C_GIRL, "Нет. Это серьезный бизнес. Слышишь? Я очень не хочу превращать свое кафе в стейк-хаус.")
	saynn("Ты киваешь...")
	talk(C_GUY, "..это наше кафе, верно, милочка?")
	saynn("Она рычит.")
	talk(C_GIRL, "Если мы всё просрём, кафе не достанется никому. Давай, постарайся выглядеть прилично.")
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
	talk(C_GIRL, "Вот, сэр. Это тот человек, которого вы видели. {pc.He} {pc.isAre} всего лишь наше..")
	saynn("Голос Софи звучит гораздо... вежливее.")
	talk(C_OFFICER, "Благодарю.")
	saynn("Софи и Лео переглядываются с озадаченными лицами. Ты стоишь неподвижно у стола, заложив руки за спину... атмосфера становится весьма... наэлектризованной.")
	talk(C_OFFICER, "Мне предстоит долгая ночная смена. Так что.. чашечка кофе была бы кстати. И, может, капкейк.")
	saynn("Владельцы снова обмениваются растерянными взглядами... пока Софи не тычет локтем Лео в бок.")
	talk(C_GUY, "О.. конечно. Сейчас всё сделаю, сэр.")
	saynn("Лео спешит к стойке... в то время как офицер убирает меню и переключает внимание на тебя... на твое {pc.masc} тело... на твою {pc.breasts}..."+(" в сторону вашего {pc.penis}.." if GM.pc.hasPenis() else ""))
	talk(C_OFFICER, "Я знал, что у этого места есть какой-то секрет.. Это просто преступление.")
	talk(C_GIRL, "Э-э.. здесь нет ничего незаконного.. мы можем всё объяснить..")
	saynn("Офицер обрывает её на полуслове.")
	talk(C_OFFICER, "Ваша еда и кофе просто не имеют права быть НАСТОЛЬКО вкусными. Поверьте мне, это лучшее в целой галактике. А я перебыл в куче таких космических кафешек, уж поверьте.")
	saynn("Софи не знает, как реагировать на такие слова... поэтому она просто кивает... всё еще сжимая в руке поводок, прикрепленный к твоему ошейнику.")
	talk(C_OFFICER, "Я знаю, что у вас есть свои... секретные ингредиенты. И я не хочу раскрывать их другим. Это было бы крайне грубо, не так ли?")
	talk(C_GIRL, "Э-э... д-да, было бы.")
	saynn("Офицер кивает.")
	talk(C_OFFICER, "Все, о чем я прошу — это... личные ужины. Я буду платить, разумеется. И я сделаю так, чтобы это того стоило.")
	saynn("Софи трет лицо свободной рукой... можно заметить легкую дрожь в её теле.")
	talk(C_GIRL, "Конечно, сэр. Это можно устроить.")
	talk(C_OFFICER, "Не хочу быть слишком навязчивым. Меня устроит то же отношение, что и у всех остальных. Но я хочу узнать мнение {pc.his}.")
	saynn("Он перехватывает поводок посередине... и слегка тянет за него, приглашая тебя подойти ближе.")
	talk(C_OFFICER, "Ты хочешь обслужить меня?")
	saynn("Лео наконец возвращается с заказом офицера. Чашка кофе и несколько капкейков...")
	
	addAction("Agree", "Согласиться на предложение об обслуживании", "doAgree")
	addAction("No", "Это уже слишком", "noAgree")

func ePeekFirstEvent3_do(_id:String, _args:Array):
	if(_id == "noAgree"):
		GM.main.PSH.unlockEnding("MilkCafe", "officer") # In case people don't wanna sub to him
		gonnaHavePeekEvent = false
		peekState = PEEK_BULLIED_BY_GIRL
		aimCamera(L_SLEEP)
		playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
		saynn("Вы решаете отклонить его предложение. Пронзительный взгляд Софи буквально впивается в вас...")
		talk(C_OFFICER, "Все в порядке. Я понимаю. Тогда я буду просто обычным клиентом.")
		talk(C_GIRL, "Хорошо. А теперь, если позволите...")
		saynn("Офицер кивает. Софи рывком тащит вас обратно в подвал... прямиком в вашу камеру.")
		talk(C_GIRL, "Тебе, блять, чертовски повезло. Я уже собирался прикончить тебя на месте. А теперь спи.")
		saynn("Она уходит и запирает дверь камеры.")
		addAction("Sleep", "Теперь пора поспать... по-настоящему", "SLEEP")
	if(_id == "doAgree"):
		addChar(C_OFFICER)
		gonnaHavePeekEvent = false
		playAnimation(StageScene.Duo, "kneel", {npc=C_OFFICER, npcAction="sit", bodyState={hard=true, leashedBy=C_OFFICER}})
		saynn("Вместо того чтобы что-то сказать, вы просто демонстрируете покорность, опускаясь перед ним на колени.")
		saynn("Офицер улыбается... и протягивает руку, чтобы почесать вас под подбородком.")
		talk(C_GIRL, "Мы тебе всё ещё... э-э... нужны?")
		talk(C_OFFICER, "Думаю, мне понадобится кто-то из вас.")
		saynn("Софи снова тычет локтем напарнику в бок, заставляя его поскорее исчезнуть.")
		if(agreeMilk || !GM.pc.hasPenis()):
			saynn("Офицер берет чашку свежесваренного кофе и делает глоток.")
			talk(C_OFFICER, "Мне кажется, сюда не помешало бы ещё немного молока. Свежего молока.")
			saynn("Он ставит чашку почти у самого края стола... совсем рядом с вашей грудью.")
			talk(C_GIRL, "Конечно, я сейчас же всё исправлю.")
			addAction("Fresh milk..", "Посмотри, что Софи сделает с твоей грудью", "setState", ["ePeekFirstEventMilk"])
		else:
			saynn("Офицер берет капкейк... и подносит его ближе, внимательно разглядывая.")
			talk(C_OFFICER, "Как по мне, выглядит суховато. Не помешало бы побольше сливок. Свежих сливок. Что думаешь?")
			saynn("Он ставит капкейк на край стола... совсем рядом с тобой.")
			talk(C_GIRL, "Конечно, я сейчас же всё исправлю.")
			saynn("Софи убегает, чтобы схватить кое-что... стрэп-он.")
			addAction("Fresh cream..", "Посмотри, что Софи сделает с тобой", "setState", ["ePeekFirstEventSeed"])

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
	talk(C_OFFICER, "Ммм... просто идеально.")
	saynn("Глаза Софи загораются, когда она слышит это.")
	if(agreeSeed && GM.pc.hasPenis()):
		saynn("Затем офицер берет капкейк... и подносит его ближе, внимательно осматривая.")
		talk(C_OFFICER, "Как-то он какой-то... суховатый, не находишь? Не помешало бы добавить побольше сливок. Что скажешь?")
		saynn("Он кладет капкейк обратно.")
		talk(C_GIRL, "Конечно, господин. Я сейчас же всё исправлю.")
		saynn("Софи убегает, чтобы схватить кое-что... стрэп-он.")
		addAction("Fresh cream..", "Посмотри, что Софи сделает с тобой", "setState", ["ePeekFirstEventSeed"])
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
	saynn("Мощным толчком Софи вгоняет страпон глубоко в тебя. Ты ахаешь, когда кончик упирается в твою точку удовольствия..."+("отчего твой член мгновенно встает колом." if !GM.pc.isWearingChastityCage() else "отчего твой запертый член пытается встать в своей клетке."))
	saynn("Она начинает медленный, размеренный ритм: каждый толчок массирует твою простату всё глубже, заставляя тебя извиваться.")
	talk(C_PC, "M-mmh.. mmm..")
	saynn("Предэякулят капает с твоего члена, пока её игрушка входит и выходит из тебя. Офицер с огромным интересом наблюдает за тем, как тебя трахают.")
	saynn("Софи ускоряется, вколачивая страпон в тебя всё сильнее и жестче. Твои стоны становятся громче, эхом разносясь по кафе.")
	saynn("Вскоре твоя простата раздувается и становится твердой. И вот, с криком наслаждения, ты начинаешь кончать... Густые струи крема пульсируют из твоего члена, попадая прямо на капкейк.")
	saynn("Софи держит его неподвижно, позволяя твоему члену добавить еще один слой поверх уже имеющейся глазури.")
	saynn("Когда ты заканчиваешь... офицер наклоняется вперед и хватает капкейк со стола... прежде чем откусить добрый кусок.")
	talk(C_OFFICER, "Ммм... божественно. Невероятно.")
	saynn("Услышав это, Софи улыбается... пока ты тяжело дышишь, чувствуя опустошенность в яичках.")
	addContinue("setState", ["ePeekFirstEvent4"])

func ePeekFirstEvent4_state():
	removeStrapon(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_GUY, npc=C_OFFICER, npcAction="sit"})
	saynn("Офицер наслаждается остатком своего... ужина... потягивая кофе и доедая капкейк.")
	saynn("Ты стоишь неподалеку... но Софи и Лео держатся на несколько шагов в стороне, чтобы не мешать трапезе.")
	talk(C_OFFICER, "Ладно, думаю, теперь я могу заплатить.")
	extraProfit += 10000
	saynn("Лео быстро подходит к столу... со счетом в руках.")
	talk(C_OFFICER, "Может, этого будет достаточно?")
	saynn("Офицер достает кредитный чип... и протягивает его парню. Глаза Лео округляются.")
	talk(C_GUY, "Господин... это слишком много.")
	saynn("Офицер улыбается.")
	talk(C_OFFICER, "Остальное — на чай. Мне очень понравилось обслуживание. Надеюсь, мы еще как-нибудь повторим. А?")
	saynn("Софи подбегает к Лео и шепчет ему на ухо.")
	talk(C_GIRL, "..да возьми ты уже эту гребаную карту и вали, не тупи... и рабыню забери тоже...")
	saynn("Лео кивает офицеру... и берет твой поводок.")
	talk(C_GUY, "Благодарим вас, сэр. Будем рады видеть вас здесь снова.")
	saynn("Офицер кивает в ответ... и наблюдает, как Лео ведет тебя обратно на кухню.")
	
	addContinue("setState", ["ePeekFirstEvent5"])

func ePeekFirstEvent5_state():
	aimCamera(L_SLEEP)
	addChar(C_GUY)
	playAnimation(StageScene.Duo, "stand", {npc=C_GUY, bodyState={leashedBy=C_GUY}})
	
	saynn("Лео возвращает тебя в камеру. Ты чувствуешь... сильную усталость.")
	talk(C_GUY, "Ты отлично справилась. Спасибо...")
	saynn("Он снимает поводок с твоего ошейника.")
	talk(C_GUY, "Спи сладко.")
	
	addAction("Sleep", "Пора спать!", "SLEEP")


func ePeekSecondEvent_state():
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL, bodyState={leashedBy=C_GIRL}})
	saynn("Ты не планировала спать... и, похоже, была права.")

	saynn("В камеру входит Софи и тут же пристегивает поводок к твоему ошейнику.")

	talk(C_GIRL, "Тебе повезло, этот парень хочет видеть тебя снова.")
	saynn("Она поднимает тебя с пола и смахивает пыль с твоей задницы. Свободной рукой она берет тебя за подбородок.")

	talk(C_GIRL, "Если не хочешь проблем, будешь делать всё, что он пожелает. Как послушная шлюшка.")
	saynn("Кажется, на этот раз выбора у тебя будет немного...")
	addAction("Follow", "Посмотреть, куда она тебя приведет", "setState", ["ePeekSecondEvent2"])

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

	talk(C_GIRL, "Ваш десерт готов, сэр.")
	talk(C_OFFICER, "Замечательно.")
	saynn("Десерт? Не думаешь, что тебя когда-нибудь так называли...")

	saynn("Офицер протягивает руку и берет тебя за подбородок; от мягкого прикосновения его большой мужской ладони внутри всё начинает трепетать. Будем надеяться, что этот десерт не начнет таять слишком быстро.")

	talk(C_OFFICER, "С тобой здесь хорошо обращаются?")
	saynn("Он спрашивает тебя... От этого внезапного вопроса ты опускаешь глаза. Ты буквально кожей чувствуешь сверлящий взгляд Софи за спиной...")

	saynn("Требуется время, чтобы заставить себя сделать жест... но ты киваешь... медленно... едва заметно. Софи за твоей спиной облегченно вздыхает.")

	talk(C_OFFICER, "Понимаю. Просто... было бы жаль, если бы такое лакомство пропало зря.")
	talk(C_GIRL, "Мы хорошо заботимся о {pc.him}.")
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

	talk(C_GIRL, "Если тебе что-нибудь понадобится, я рядом. Просто чтобы ты знал.")
	talk(C_OFFICER, "Думаю, все мои текущие потребности удовлетворены, спасибо.")
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

	talk(C_OFFICER, "Вообще-то... У тебя есть... цепи... может быть?")
	talk(C_GIRL, "Да, полно. Ммм, могу я спросить, зачем они тебе?")
	saynn("Офицер тихо посмеивается и в несколько глотков допивает свой кофе.")

	talk(C_OFFICER, "Я бы хотела наслаждаться десертом на столе, а не под ним.")
	talk(C_GIRL, "Конечно, сэр.")
	addContinue("setState", ["ePeekSecondEvent5"])
	
func ePeekSecondEvent5_state():
	playAnimation(StageScene.SexOralTable, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Возвращается Софи с цепями... и помогает привязать тебя к столу так, чтобы твоя голова свисала с края.")

	talk(C_OFFICER, "Благодарю.")
	saynn("Офицер встает и подходит к тебе... его твердый член нависает прямо над твоим лицом, а головка капает тебе на подбородок.")

	talk(C_OFFICER, "Я постараюсь быть осторожной.")
	saynn("Медленно он начинает заталкивать свой член тебе в рот; головка скользит между зубов, задевает твой мягкий язык, а затем пробирается к задней стенке горла, уходя глубоко вниз.")

	saynn("Ты чувствуешь, как он растягивает тебя... твои кулаки сжимаются, пока ты пытаешься отвлечься от рвотного рефлекса. Но в конце концов он берет свое: горло внезапно сжимается вокруг его члена, издавая влажные звуки позывов.")

	talk(C_OFFICER, "Ммм... это было приятно. Можно мне?")
	saynn("Твои кулаки всё еще сжаты... но большие пальцы невольно дергаются...")
	addContinue("setState", ["ePeekSecondEvent6"])

func ePeekSecondEvent6_state():
	playAnimation(StageScene.SexOralTable, "suck", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Офицер начинает двигать бедрами, почти полностью вынимая член... а затем снова мощно всаживает его, растягивая твое горло еще сильнее.")

	saynn("Его ладони ложатся тебе на шею, он прощупывает тот бугорок, который образуется при каждом прохождении его плоти.")

	saynn("Ты мельком видишь Софи. Её злобные глаза молча следят за основным действием, проверяя, не сломлена ли ты окончательно.")

	saynn("Ты всё сильнее давишься и задыхаешься от этого члена... и всё же... тебе всё мало. Одинокие слезы текут по твоим щекам, пока твое горло служит для его удовольствия. Всё твое тело хочет извиваться... но цепи удерживают тебя неподвижно ради него.")

	talk(C_OFFICER, "Да... такое классное лакомство. Не помешало бы немного кремовой начинки, а?")
	saynn("Да...")
	addContinue("setState", ["ePeekSecondEvent7"])

func ePeekSecondEvent7_state():
	playAnimation(StageScene.SexOralTable, "suckfast", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Он ускоряется, трахая твое горло еще быстрее, по-настоящему испытывая твои пределы. Поскольку большую часть времени твой трахеальный проход перекрыт гигантским членом, воздуха становится катастрофически мало... твои внутренние стенки сжимаются вокруг ствола еще сильнее, заставляя парня стонать от наслаждения.")

	saynn("Ты видишь, как его узел раздувается... становясь всё толще, пока кровь приливает к его паху. Он делает несколько попыток вогнать его внутрь... но решает не вывихивать тебе челюсть.")

	talk(C_OFFICER, "Надеюсь, ты готова...")
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

	talk(C_OFFICER, "Какое лакомство. Пожалуй, лучшее во всей галактике.")
	saynn("Софи подходит к вам двоим.")

	talk(C_GIRL, "Рада, что вам понравилось наше меню.")
	saynn("Он кивает... и протягивает ей кредитный чип.")

	talk(C_OFFICER, "Этого будет достаточно?")
	saynn("Она быстро проверяет его. На нем явно крупная сумма... и всё же... её губы сжимаются в узкую линию.")

	talk(C_GIRL, "Ну...")
	saynn("Без лишних слов офицер просто протягивает второй чип.")

	talk(C_OFFICER, "Лучшее лакомство, как я и сказала.")
	saynn("Софи берет чип и кивает.")

	talk(C_GIRL, "Спасибо. Сейчас я всё упакую.")
	saynn("Офицер снова кивает.. застегивает ширинку.. и направляется к выходу, бросив на тебя быстрый взгляд и улыбнувшись уже в дверях.")
	addContinue("setState", ["ePeekSecondEvent10"])

func ePeekSecondEvent10_state():
	aimCamera(L_SLEEP)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
	saynn("После этого ужина Софи возвращает тебя в камеру.")

	talk(C_GIRL, "В следующий раз вкладывай в это больше страсти. Нам счета оплачивать.")
	saynn("Ты не отвечаешь.. просто ждешь, когда она уйдет.")
	
	gonnaHavePeekEvent = false
	addAction("Sleep", "Пора спать", "SLEEP")




func ePeekThirdEvent_state():
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL, bodyState={leashedBy=C_GIRL}})
	saynn("Ты знал, что Софи придет за тобой после закрытия кафе. Ты этого ждал.")

	talk(C_GIRL, "Давай, ты же знаешь правила.")
	saynn("Она пристегивает поводок к твоему ошейнику и тянет за него, приглашая следовать за ней.")

	talk(C_GIRL, "Жду кучу кредитов. Уяснила, сучка?")
	saynn("Ты киваешь.. а что еще тебе остается делать?")
	
	addContinue("setState", ["ePeekThirdEvent2"])

func ePeekThirdEvent2_state():
	aimCamera(L_TABLE)
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.ChairOral, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true,hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Ты следуешь за этой жадной девчонкой в обеденную зону и подходишь к привычному столику. Волк уже ждет тебя.")

	saynn("Кредиты сами себя не заработают.. Не дожидаясь команд, ты опускаешься на колени и забираешься под стол; твои руки находят молнию и извлекают яички и кожаный чехол офицера. После нескольких нежных поглаживаний кончик его члена начинает показываться наружу.. а затем, благодаря твоим ласкам, из него выходит и остальная часть ствола.")

	talk(C_OFFICER, "А я-то думала, что это я здесь голодная. Ха!")
	saynn("Софи вежливо улыбается, держа в свободной руке меню.")

	talk(C_GIRL, "Желаете что-нибудь заказать, сэр?")
	talk(C_OFFICER, "Знаешь... я сегодня чертовски голоден. Можно было бы и целый торт съесть. Или пирог.")
	saynn("Софи приподнимает бровь и откашливается.")

	talk(C_GIRL, "Хм... нам нужно проверить, не осталось ли еще чего-нибудь.")
	saynn("Пока ты усердно ласкаешь его член языком, он запускает руку под стол, чтобы похлопать тебя.")

	talk(C_OFFICER, "Не беспокойся. У меня уже есть всё, что нужно.")
	saynn("Его улыбка... кажется, он задумал что-то эдакое.")

	addContinue("setState", ["ePeekThirdEvent3"])

func ePeekThirdEvent3_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "tease", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Офицер хватает поводок и манит тебя вылезти из-под стола... а затем заставляет встать на него лицом вниз, так что твой {pc.thick} зад торчит во все стороны.")

	saynn("Он кладет свой твердый член на твои ягодицы и начинает медленно водить им вперед-назад.")

	talk(C_OFFICER, "Какое наслаждение, нет смысла держать тебя на грязном полу. Верно?")
	saynn("Ты оглядываешься через плечо... и видишь его улыбку... а также строгий взгляд Софи. Ты киваешь...")

	saynn("Офицер проводит кончиком своего члена по твоей "+str("дырочки... твоя киска и анус" if GM.pc.hasReachableVagina() else "{pc.anusStretch} tailhole")+".. его предэякулят капает на твою чувствительную плоть. "+str("В конце концов он направляет свой член к твоей жаждущей щели, прижимая головку к складкам плоти... прежде чем широко раздвинуть их." if GM.pc.hasReachableVagina() else "Он некоторое время дразнит тебя, прежде чем направить член к твоей жаждущей дырочке, прижимая к ней головку... а затем слегка растягивая её.")+"")

	addContinue("setState", ["ePeekThirdEvent4"])

func ePeekThirdEvent4_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "sex", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Резким толчком он входит в твою "+str("velvet" if GM.pc.hasReachableVagina() else "inviting")+" теплоту. Дюйм за дюймом его член исследует твои влажные внутренние стенки, с каждым разом проникая всё глубже.")

	talk(C_OFFICER, "Вот так... Принимай всё до капли.")
	saynn("Он задает медленный... но невероятно приятный ритм, и каждый толчок погружает тебя всё глубже в состояние покорной секс-игрушки... Сквозь губы вырываются тихие стоны, пока тебя трахают прямо на столе, а твои руки судорожно вцепились в его края.")

	addContinue("setState", ["ePeekThirdEvent5"])

func ePeekThirdEvent5_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "fast", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Это приятно... обоим: и тебе, и ему. Чувствуя, как твоя "+str("{pc.pussyStretch} pussy" if GM.pc.hasReachableVagina() else "{pc.analStretch} ass")+" отлично справляется с его членом, парень ускоряется, всаживаясь всё глубже и сильнее.")

	talk(C_PC, "Ah.. ah..")
	talk(C_OFFICER, "Какая чудесная киска." if GM.pc.hasReachableVagina() else "Какая классная жопка.")
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

	talk(C_OFFICER, "Грррх..")
	talk(C_PC, "Ahhh-h!..")
	saynn("Теплое семя густыми волнами заливает твою "+str("womb" if GM.pc.hasReachableVagina() else "butt")+"стол содрогается от того, как твое тело извивается, не в силах вместить в себя такой объем... Вскоре ты кончаешь, и твоя "+str("pussy" if GM.pc.hasReachableVagina() else "tailhole")+" пульсирует и сжимается вокруг его пульсирующего узла, высасывая каждую каплю его горячей спермы.")

	saynn("Стимуляция слишком сильная... твои глаза закатываются, а громкие стоны эхом разносятся по пустому кафе..."+str("Твоя киска брызжет соком, когда его жирный шар вколачивается прямо в твою точку G" if GM.pc.hasReachableVagina() else "")+""+str("Твоя {pc.penis} брызжет {pc.cum}, когда его жирный шар вколачивается прямо в твою простату" if (!GM.pc.hasReachableVagina() && GM.pc.hasPenis()) else "")+""+str("Твоё анусное отверстие продолжает пульсировать" if (!GM.pc.hasReachableVagina() && !GM.pc.hasPenis()) else "")+", твои ноги дико дрожат, пока волк позади продолжает осеменять тебя, опустошая свои яйца прямо внутри тебя.")

	saynn("Когда всё заканчивается, вы оба дрожите на столе... оба совершенно измотанные.")

	talk(C_OFFICER, "Это.. мне это было очень нужно.")
	saynn("Пока ты всё ещё корчишься от ощущения его полной длины внутри тебя, Софи подходит к вам двоим.")

	talk(C_GIRL, "Надеюсь, вы остались довольны нашим выбором.")
	saynn("Он усмехается.")

	talk(C_OFFICER, "Я всё ещё очень голоден, мисс.")
	
	addContinue("setState", ["ePeekThirdEvent7"])
	
func ePeekThirdEvent7_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.SexOverTable, "lick", {pc=C_OFFICER, npc=C_PC, bodyState={showPenis=true, hard=true}, npcBodyState={naked=true, hard=true}})
	saynn("Он вырывает свой узел из твоей "+str("pussy" if GM.pc.hasReachableVagina() else "ass")+".. прежде чем опуститься на колени и уткнуться лицом в твою "+str("crotch" if GM.pc.hasReachableVagina() else "butt")+".")

	saynn("Волк... он начинает ласкать тебя языком... ты чувствуешь, как его мощный язык скользит по твоей "+str("folds" if GM.pc.hasReachableVagina() else "tailhole")+".. прежде чем проникнуть в залитое кремом отверстие и приняться вылизывать внутренние стенки.")

	talk(C_GIRL, "Конечно, сэр. Наслаждайтесь вашим.. тортиком.")
	saynn("И он так и делает: вылизывает тебя изнутри, вонзая язык туда-сюда, заглатывая твои соки... а заодно и своё семя. Похоже, этот парень не из привередливых...")

	saynn("Такое обращение... это так приятно... твои тихие стоны заставляют его хотеть ещё. Он оставляет крем внутри тебя почти нетронутым... и просто завершает процесс, покрывая твою "+str("folds" if GM.pc.hasReachableVagina() else "star")+" ещё слоем, проводя языком по всем изгибам.")

	saynn("Когда он заканчивает, он поднимается и нежно ласкает твою задницу.")

	talk(C_OFFICER, "Так вкусно.")
	
	addContinue("setState", ["ePeekThirdEvent8"])
	
func ePeekThirdEvent8_state():
	addChar(C_OFFICER)
	addChar(C_GIRL)
	playAnimation(StageScene.Duo, "stand", {pc=C_OFFICER, npc=C_GIRL})
	saynn("Волк поворачивается к девушке и начинает шарить по карманам, доставая кредитные чипы.")

	saynn("Но прежде чем протянуть их леди... он замирает. Софи слегка вздрагивает бровями и надувает губы.")

	talk(C_OFFICER, "Я в курсе... ситуации в твоём кафе.")
	saynn("Софи слегка наклоняет голову, теперь уже с легким беспокойством.")

	talk(C_GIRL, "Что именно ты имеешь в виду?")
	talk(C_OFFICER, "Твои огромные долги. Ты пошла на это... чтобы выжить. Ты начала использовать нелегальных рабов.")
	saynn("Он бросает на тебя быстрый взгляд. Ты всё ещё лежишь на столе, тяжело и часто дыша...")

	saynn("Софи часто моргает... можно буквально почувствовать, что её сердце колотится быстрее твоего. Лео тоже подходит к столу, внимательно прислушиваясь.")

	talk(C_GIRL, "Э-э... на самом деле... другого выбора не было.")
	talk(C_OFFICER, "Не волнуйся, я не собираюсь тебя шантажировать. И в тюрьму ты не сядешь, уж не из-за меня. То, что я хочу... это сделать тебе предложение.")
	saynn("Лео и Софи переглядываются.")

	talk(C_GUY, "Предложение?")
	talk(C_OFFICER, "Я даю тебе столько кредитов, чтобы ты закрыла все долги. Чистый лист, новая жизнь. А взамен...")
	saynn("Его мужская рука ложится тебе на спину... и нежно поглаживает её.")

	talk(C_OFFICER, "Эта милашка остаётся у меня.")
	saynn("Лео и Софи снова смотрят друг на друга, их глаза расширены от изумления. Они просто не могут в это поверить.")

	talk(C_GUY, "Oh..")
	saynn("Наступает короткая тишина... пока в голове у девушки крутятся шестеренки мыслей.")

	talk(C_GIRL, "Как насчёт... десяти процентов сверху?.. Нам будет очень, очень не хватать этой милашки.")
	talk(C_GUY, "Софи...")
	talk(C_GIRL, "Тссс... заткнись...")
	saynn("Серьезно? Даже волк ошарашен такими попытками поторговаться.")

	talk(C_OFFICER, "Могу дать пять.")
	talk(C_GIRL, "По рукам.")
	saynn("Офицер достает еще несколько ярких кредитных чипов... проверяет, верно ли посчитана сумма... а затем протягивает их Софи. Взамен она передает поводок, пристегнутый к твоему ошейнику.")

	saynn("Как только сделка завершена, пара быстро скрывается на кухне. Только Лео напоследок машет тебе рукой... прежде чем Софи утягивает его с глаз долой.")

	addContinue("setState", ["ePeekThirdEvent9"])

func ePeekThirdEvent9_state():
	addChar(C_OFFICER)
	playAnimation(StageScene.Duo, "stand", {npc=C_OFFICER, bodyState={leashedBy=C_OFFICER}})
	aimCamera(L_DOCKS)
	saynn("Офицер помогает тебе подняться... а затем пристегивает поводок к твоему ошейнику...")

	talk(C_OFFICER, "Ну... тогда пошли.")
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

	talk(C_GIRL, "Ты всё ещё жив. Хорошо. Начнём потихоньку. Слушай условия. Если ты ещё не заметил — мы тебя купили.")
	saynn("Двое против одного... а ты, мягко говоря, не вооружен. Кто знает, сколько еще народу может прятаться за стеной.")

	talk(C_GIRL, "Раз уж теперь ты наша собственность... ты будешь делать ровно то, что тебе велят. Иначе... Покажи {pc.him}, Лео.")
	talk(C_GUY, "Конечно.")
	saynn("Парень достает... что-то похожее на складную дубинку... но с маленькой вилочкой на конце. Он сжимает рукоять... и между зубцами вилки проскакивают маленькие разряды электричества.")

	talk(C_GUY, "Если это коснётся тебя, будет больно.")
	saynn("Ну да, это и так очевидно.")

	talk(C_GIRL, "А теперь. Я надену на тебя поводок. Лео?")
	talk(C_GUY, "Поймал.")
	talk(C_GIRL, "Как бы тебе не пришлось, блядь.")
	saynn("Девушка... Софи... достает поводок и тянется, чтобы пристегнуть его к твоему ошейнику. При этом парень готов ударить тебя в любой момент.")

	saynn("Ты стоишь смирно и позволяешь им делать всё, что им нужно.")

	talk(C_GIRL, "А теперь хватай ящик.")
	saynn("Они не слишком тяжелые... но и не совсем легкие. После того как ты это сделаешь, девушка начинает сверлить парня взглядом... явно сбивая его с толку.")

	talk(C_GUY, "Софи?")
	talk(C_GIRL, "Ты тоже хватай, не будь ленивой сукой.")
	talk(C_GUY, "Ладно.")
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

	talk(C_GIRL, "Работай дальше, животное.")
	saynn("Животное? Вы осторожно спускаетесь по ступеням, неуклюже заглядывая из-за ящика, который несете в руках.")

	saynn("Ваши глаза начинают постепенно привыкать к темноте. Пока это происходит, они начинают различать какие-то силуэты. Прежде чем вы успеваете разглядеть детали, девушка резко дергает за поводок.")

	talk(C_GIRL, "Шанс поздороваться у тебя будет позже.")
	
	addContinue("setState", ["intro5"])
	
func intro5_state():
	aimCamera(L_SLEEP)
	playAnimation(StageScene.Duo, "stand", {npc=C_GIRL})
	saynn("Вы следуете за этой стервой в какое-то подобие... промышленной морозильной камеры? Это большое холодное помещение, разделенное на несколько секций, но, кажется, питание подается только на одну из них. Вы ставите ящик именно туда, куда вам велели.")

	talk(C_GIRL, "А теперь иди спать.")
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

	talk(C_GIRL, "Все, поприветствуйте новое животное.")
	saynn("Девушка ловит твой растерянный взгляд. Ты оглядываешься получше... и замечаешь кучу... странного оборудования. В углу этого... подвала, кажется, есть отдельное огороженное пространство... с маленьким садиком. Солнечный свет, пробивающийся сквозь потолок этого сада — единственный источник света, освещающий остальную часть подвала.")

	talk(C_GIRL, "Да. Теперь ты — животное.")
	talk(C_GUY, "Мы тут держим кафе, и чтобы оно работало, нам нужны молоко и сливки.")
	saynn("Софи одаряет Лео свирепым взглядом.")

	talk(C_GIRL, "Почему бы тебе заодно не выложить им точные координаты этого кафе, а?")
	talk(C_GUY, "Мой косяк.")
	saynn("Девушка снова поворачивается к тебе.")

	talk(C_GIRL, "Хотя он прав. Время от времени мы будем спускаться сюда и доить вас. Всех до одного.")
	saynn("Молоко? Похоже, оборудование нужно именно для этого.")

	talk(C_GUY, "Как только вы поможете кафе заработать достаточно кредитов, мы действительно вас отпустим.")
	talk(C_GIRL, "Мы подумаем об этом, да. Сколько значит «достаточно»? Прямо сейчас это 250 тысяч кредитов.")
	addCredits(-250000)
	saynn("Ого, сколько всего...")

	saynn("Софи подходит именно к тебе.")

	talk(C_GIRL, "Итак. Какую пользу вы принесете нам? У нас уже есть корова и бык, так что вы можете быть кем угодно, мне плевать. Я просто не принимаю ответ «нет».")

	addAction("Milk", "Вашу грудь будут доить. Со временем её размер будет увеличиваться.", "setState", ["intro8milk"])
	if(GM.pc.hasReachablePenis() || GM.pc.isWearingChastityCage()):
		addAction("Seed", "Ваш член будут доить.", "setState", ["intro8seed"])
		addAction("Both", "И грудь, и член будут доить.", "setState", ["intro8both"])
	else:
		addDisabledAction("Семя", "К сожалению, у тебя нет пениса, чтобы доить семя.")
		addDisabledAction("Оба", "К сожалению, у тебя нет члена, чтобы тебя тоже доили на семя")

func intro8milk_state():
	agreeMilk = true
	agreeSeed = false
	addChar(C_GIRL)
	addChar(C_GUY)
	saynn("Ты говоришь владельцам, что сама выберешь себе грудь.")

	talk(C_GIRL, "Ладно. И если ты еще не лактационная корова, мы найдем способ заставить тебя это делать, не переживай, коровка")
	saynn("Корова... неужели это теперь твоя роль?")

	talk(C_GIRL, "Скоро мы начнем тебя доить. Если проголодаешься — иди пожуй траву")
	saynn("После этого твои новые хозяева оставляют тебя в покое.")

	saynn("Остальные рабы... животные... корова и бык... расходятся по своим углам.")
	addContinue("setState", ["main"])

func intro8seed_state():
	agreeMilk = false
	agreeSeed = true
	addChar(C_GIRL)
	addChar(C_GUY)
	saynn("Ты говоришь владельцам, что сам выберешь себе член.")

	talk(C_GIRL, "Понятно. Значит, ты бык. Хорошо")
	saynn("Бык... неужели это теперь твоя роль?")

	talk(C_GIRL, "Скоро мы начнем тебя доить. Если проголодаешься — иди пожуй траву")
	saynn("После этого твои новые хозяева оставляют тебя в покое.")

	saynn("Остальные рабы... животные... корова и бык... расходятся по своим углам.")
	addContinue("setState", ["main"])

func intro8both_state():
	agreeMilk = true
	agreeSeed = true
	addChar(C_GIRL)
	addChar(C_GUY)
	saynn("Ты говоришь владельцам, что выбираешь... и член, и грудь.")

	talk(C_GIRL, "Ладно. С твоим хреном проблем с дойкой быть не должно. Но если ты еще не лактационная корова, мы найдем способ заставить тебя это делать, не переживай, коровка")
	saynn("Корова... неужели это теперь твоя роль?")

	talk(C_GIRL, "Скоро мы начнем тебя доить. Если проголодаешься — иди пожуй траву")
	saynn("После этого твои новые хозяева оставляют тебя в покое.")

	saynn("Остальные рабы... животные... корова и бык... расходятся по своим углам.")
	addContinue("setState", ["main"])
