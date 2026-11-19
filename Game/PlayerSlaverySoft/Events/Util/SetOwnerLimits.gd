extends NpcOwnerEventBase

var pickedSexLimits:Array = []
var didIntro:bool = false

func _init():
	id = "SetOwnerLimits"

func onStart(_args:Array):
	setState("start")
	setSubResult(SUB_CONTINUE)

func start():
	if(!didIntro):
		saynn("Вы говорите {npc.name}, что готовы подчиниться... но только если {npc.he} {npc.verb('promise')} выслушает ваши пределы.")
	
		saynn("Ваш хозяин слушает.")
		
		saynn("Вы можете выбрать сколько угодно ограничений. Хозяин может не прислушаться ко всем, но {npc.he} {npc.isAre} гарантирует, что он выслушает хотя бы одно из них.")
	else:
		saynn("Список ограничений:")
	var theOwner = getOwner()
	var theList:Array = []
	for theLimitID in pickedSexLimits:
		if(!NpcOwnerSexLimits.LIMITS.has(theLimitID)):
			continue
		var theChance:float = 100.0 if pickedSexLimits.size() == 1 else NpcOwnerSexLimits.getAgreeChance(theLimitID, theOwner)
		var theLimitEntry:Dictionary = NpcOwnerSexLimits.LIMITS[theLimitID]
		theList.append(theLimitEntry["name"]+": "+theLimitEntry["desc"]+" (Шанс согласия: "+str(Util.roundF(theChance, 1))+"%)")
	saynn(Util.join(theList, "\n"))
	
	addButton("CONFIRM", "Подтвердить список ограничений", "confirm")
	
	var bannedLimits:Array = []
	for limitEntryID in pickedSexLimits:
		if(!NpcOwnerSexLimits.LIMITS.has(limitEntryID)):
			continue
		var limitEntry:Dictionary = NpcOwnerSexLimits.LIMITS[limitEntryID]
		if(!limitEntry.has("bans")):
			continue
		bannedLimits.append_array(limitEntry["bans"])
	
	for limitEntryID in NpcOwnerSexLimits.LIMITS:
		var limitEntry:Dictionary = NpcOwnerSexLimits.LIMITS[limitEntryID]
		var isIn:bool = pickedSexLimits.has(limitEntryID)
		
		if(bannedLimits.has(limitEntryID)):
			addDisabledButton(("+" if !isIn else "-")+limitEntry["name"], "Это ограничение теперь несовместимо с другими выбранными вами лимитами")
		else:
			addButton(("+" if !isIn else "-")+limitEntry["name"], limitEntry["desc"], "toggle", [limitEntryID])

func start_do(_id:String, _args:Array):
	if(_id == "toggle"):
		didIntro = true
		var theLimitID:String = _args[0]
		if(pickedSexLimits.has(theLimitID)):
			pickedSexLimits.erase(theLimitID)
		else:
			pickedSexLimits.append(theLimitID)
	if(_id == "confirm"):
		if(pickedSexLimits.empty()):
			endEvent()
			return
		
		sexLimits.clear()
		var theOwner = getOwner()
		for limitID in pickedSexLimits:
			if(RNG.chance(NpcOwnerSexLimits.getAgreeChance(limitID, theOwner))):
				sexLimits.append(limitID)
		if(sexLimits.size() <= 0):
			sexLimits.append(RNG.pick(pickedSexLimits))
		
		setState("ownerAgreeLimits")
	
func ownerAgreeLimits():
	saynn("Вы озвучиваете хозяину свои пределы... и затем {npc.he} {npc.verb('tell')}, какие именно из них {npc.he} {npc.verb('agree')} соблюдать.")
	
	var theList:Array = []
	for theLimitID in pickedSexLimits:
		if(!NpcOwnerSexLimits.LIMITS.has(theLimitID)):
			continue
		var didAgree:bool = sexLimits.has(theLimitID)
		var theLimitEntry:Dictionary = NpcOwnerSexLimits.LIMITS[theLimitID]
		if(didAgree):
			theList.append("[color=#00CC00]"+theLimitEntry["name"]+": "+theLimitEntry["desc"]+"[/color] (Agrees)")
		else:
			theList.append("[color=red]"+theLimitEntry["name"]+": "+theLimitEntry["desc"]+"[/color] (Nope)")
	saynn(Util.join(theList, "\n"))
	
	addContinue("endEvent")
	
func saveData() -> Dictionary:
	var data := .saveData()
	
	data["pickedSexLimits"] = pickedSexLimits
	data["didIntro"] = didIntro
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	pickedSexLimits = SAVE.loadVar(_data, "pickedSexLimits", [])
	didIntro = SAVE.loadVar(_data, "didIntro", false)

func howMuchTimeToPass(_actionID:String, _args:Array) -> int:
	return 0
