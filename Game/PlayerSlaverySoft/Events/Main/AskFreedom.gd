extends NpcOwnerEventBase

var freedomPrice:int = 0

func _init():
	id = "AskFreedom"

func onStart(_args:Array):
	freedomPrice = getFreedomPrice()
	setSubResult(SUB_CONTINUE)

func start():
	playStand()
	saynn("Вы спрашиваете своего хозяина, может ли {npc.he} отпустить вас на волю.")
	
	if(freedomPrice <= 0):
		talkModularOwnerToPC("SoftSlaveryAskedFreedom") #"I guess I can. No point in me bugging you any further, you already know that you are my {npc.npcSlave}. Do you really want that though?"
		saynn("Вы спрашиваете, значит ли это, что вам больше не придется платить. {npc.He} {npc.verb('nod')}.")
		saynn("Хотите ли вы, чтобы {npc.name} перестал быть вашим хозяином?")
	
		addButton("CANCEL", "Вы передумали", "endEvent")
		addButton("Да", "Попросить их перестать быть вашим хозяином", "commit")
	else:
		talkOwner(getModularDialogue(C_OWNER, C_PC, "SoftSlaveryAskedFreedomPay").replace("<CREDITS>", str(freedomPrice)+" credits"))
		saynn("Похоже, это обойдется вам в копеечку...")
		
		addButton("Отмена", "Вы передумали", "endEvent")
		if(GM.pc.getCredits() >= freedomPrice):
			addButton("Заплатить", "Заплатить хозяину "+str(freedomPrice)+" кредитов, чтобы снова стать свободным", "doPay")
		else:
			addDisabledButton("Заплатить", "У вас недостаточно кредитов...")
		
func start_do(_id:String, _args:Array):
	if(_id == "commit"):
		setState("committed")
	if(_id == "doPay"):
		GM.pc.addCredits(-freedomPrice)
		GM.main.addMessage("Ты заплатил "+str(freedomPrice)+" кредитов за свою свободу!")
		setState("committed")
	
func committed():
	if(freedomPrice <= 0):
		saynn("Вы говорите хозяину, что действительно этого хотите.")
		talkModularOwnerToPC("SoftSlaveryAskedFreedomEND") #Alright, well. Go away then.
		saynn("Это было легко...")
	else:
		saynn("Вы протягиваете своему владельцу кредитный чип с внушительной суммой.")
		saynn("{npc.name} бросает на него быстрый взгляд и убирает себе.")
		talkModularOwnerToPC("SoftSlaveryAskedFreedomEND") #Alright, well. Go away then.
		saynn("Это было легко...")
	addContinue("doEndEveything")

func committed_do(_id:String, _args:Array):
	if(_id == "doEndEveything"):
		var theNpcOwner := getNpcOwner()
		stopRunner()
		endEvent()
		if(theNpcOwner):
			theNpcOwner.endSlavery()

func getFreedomPrice() -> int:
	var theNpcOwner := getNpcOwner()
	if(!theNpcOwner):
		return 0
	return theNpcOwner.calcFreedomPrice()

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["freedomPrice"] = freedomPrice
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	freedomPrice = SAVE.loadVar(_data, "freedomPrice", 0)
