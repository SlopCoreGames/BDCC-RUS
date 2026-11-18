extends NpcOwnerEventBase

#var creditsAmount:int = 10

func _init():
	id = "OfferGearUnlock"
	reactsToTags = [E_APPROACH]
	
	eventWeight = 999993.9

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var theNpcOwner := getNpcOwner()
	
	if(theNpcOwner.ownerOfferedUnlock || !theNpcOwner.hasOwnerLock() || !theNpcOwner.checkReadyToUnlockOwnerLock()):
		return false
	
	theNpcOwner.ownerOfferedUnlock = true
	return true

func start():
	playStand()
	saynn("Твой хозяин подходит к тебе и улыбается, {npc.his} сжимает в руке ключ.")
	talkModularOwnerToPC("SoftSlaveryOfferGearUnlock") #You've been locked for quite a while. Ready to be unlocked?
	saynn("Похоже, {npc.he} {npc.verb('want')}, чтобы снять с тебя снаряжение на замках...")
	
	addButton("Окей", "Согласиться, чтобы тебя разблокировали", "beUnlocked")
	addButton("Оставить", "Попросить хозяина оставить всё как есть", "keepGear")

func start_do(_id:String, _args:Array):
	if(_id == "beUnlocked"):
		getNpcOwner().unlockOwnerLock()
		setState("afterUnlocked")
	if(_id == "keepGear"):
		setState("askedKeep")

func afterUnlocked():
	playStand()
	saynn("Ты соглашаешься, позволяя {npc.name} использовать {npc.his} ключ, чтобы отпереть твою запертую экипировку!")
	talkModularOwnerToPC("SoftSlaveryOfferGearUnlock2") #There you go, much better, right? I'm not done with you yet though.
	saynn("Похоже, {npc.he} {npc.verb('want')}, чтобы сделать с тобой что-то другое...")
	addContinue("startApproach")

func afterUnlocked_do(_id:String, _args:Array):
	if(_id == "startApproach"):
		runEvent("", "Approach")

func askedKeep():
	playStand()
	saynn("Ты просишь {npc.name} оставить запертое снаряжение на тебе.")
	talkModularOwnerToPC("SoftSlaveryOfferGearUnlockKeep") #Keep it? Sure, why not. It fits you.
	addInfluenceObey(0.2)
	saynn("{npc.He} {npc.verb('put')} ключ.")
	talkModularOwnerToPC("SoftSlaveryOfferGearUnlockKeep2") #Now, I still wanna do something else with you.
	addContinue("startApproach")

func askedKeep_do(_id:String, _args:Array):
	if(_id == "startApproach"):
		runEvent("", "Approach")

func saveData() -> Dictionary:
	var data := .saveData()
	
	#data["creditsAmount"] = creditsAmount
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	#creditsAmount = SAVE.loadVar(_data, "creditsAmount", 10)
