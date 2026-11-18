extends NpcOwnerEventBase

func _init():
	id = "BegUnlock"

func onStart(_args:Array):
	setSubResult(SUB_CONTINUE)
	
	getNpcOwner().addKeyholderSatisfaction(0.15, false)
	if(getNpcOwner().checkReadyToUnlockOwnerLock()):
		setState("readyToUnlock")

func start():
	playStand()
	saynn("Вы умоляете своего хозяина разблокировать {npc.he}, который сковал вас.")
	talkModularOwnerToPC("SoftSlaveryBegUnlockNo") # Cute. But not today.
	saynn("{npc.He} {npc.isAre} еще не готов вас освободить... но ваши мольбы произвели эффект.")
	addInfluenceObey(0.2)
	addContinue("endEvent")
	
func readyToUnlock():
	playStand()
	saynn("Вы умоляете своего хозяина разблокировать {npc.he}, который сковал вас.")
	talkModularOwnerToPC("SoftSlaveryBegUnlockYes") # Alright. It's time to unlock you
	
	addContinue("getUnlocked")

func readyToUnlock_do(_id:String, _args:Array):
	if(_id == "getUnlocked"):
		var theNpcOwner := getNpcOwner()
		if(theNpcOwner):
			theNpcOwner.unlockOwnerLock()
		setState("afterUnlocked")
	
func afterUnlocked():
	playStand()
	saynn("{npc.name} использует {npc.his}, чтобы освободить вас!")
	talkModularOwnerToPC("SoftSlaveryBegUnlockDone") # There you go. Enjoy being free, for now.
	addInfluenceObey(0.2)
	addContinue("endEvent")
	
func saveData() -> Dictionary:
	var data := .saveData()
	
	#data["freedomPrice"] = freedomPrice
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	#freedomPrice = SAVE.loadVar(_data, "freedomPrice", 0)
