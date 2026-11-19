extends EventBase

func _init():
	id = "AdvancedPenisPumpEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom)
	es.addTrigger(self, Trigger.Waiting)
	es.addTrigger(self, Trigger.WakeUpInCell)
	es.addTrigger(self, Trigger.TakingAShower)
	
func react(_triggerID, _args):
	var currentTime = GM.main.getTimeInGlobalSeconds()
	var lastTimeMilked = getFlag("MedicalModule.AdvPenisPumpLastMilked", 0)
	
	# Means this event runs every 30 minutes basically
	if(currentTime >= (lastTimeMilked + 60*30) || _triggerID == Trigger.WakeUpInCell):
		setFlag("MedicalModule.AdvPenisPumpLastMilked", currentTime)
	else:
		return false
	
	if(!GM.pc.getInventory().hasItemIDEquipped("PenisPumpAdvanced") || !GM.pc.hasPenis()):
		return false
	
	var cumProducion = GM.pc.getBodypart(BodypartSlot.Penis).getFluidProduction()
	if(cumProducion == null):
		return false
	
	if(GM.pc.canBeSeedMilked() && cumProducion.getFluidLevel()>=1.0):
		var penisPump = GM.pc.getInventory().getEquippedItemByID("PenisPumpAdvanced")
		if(penisPump == null):
			return false
		
		GM.pc.addSkillExperience(Skill.Breeder, 10)
		var howMuchTransferred = GM.pc.getBodypart(BodypartSlot.Penis).getFluids().transferTo(penisPump, 1.0)
		GM.pc.orgasmFrom("pc")
		if(howMuchTransferred > 0.0):
			GM.main.addMessage("Твой пенисный насос включается, выкачивая сок из твоего члена, пока ты не кончишь на полную катушку! Он собирает "+str(Util.roundF(howMuchTransferred))+" мл {pc.cum} во время твоего оргазма.")
			
			if(penisPump.getFluids().isFull()):
				GM.main.addMessage("Твой пенисный насос теперь полон!")
		

	return false
	
func getPriority():
	return 20
