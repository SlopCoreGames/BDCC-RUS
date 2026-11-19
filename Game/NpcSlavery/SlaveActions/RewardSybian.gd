extends SlaveActionBase

func _init():
	id = "RewardSybian"
	actionType = Reward
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 1.0
	slaveOnlyActiveResist = true

	buttonPriority = 60
	rewardHint = 4

func getVisibleName():
	return "Сибиан"

func getVisibleDesc():
	return "Позвольте своей рабыне испытать мощнейший оргазм, усадив её на сибиан"

func checkCanDo(_slaveID, _extraSlavesIDs = {}):
	if(!getFlag("NpcSlaveryModule.hasSybian", false)):
		return [false, "Сначала тебе нужно установить сибиан в своей камере"]
	
	return [true]

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var character:DynamicCharacter = GlobalRegistry.getCharacter(_slaveID)
	var npcSlavery:NpcSlave = character.getNpcSlavery()
	
	var text = "Ты ведешь {npc.name} к машине-сибиану и пристегиваешь {npc.him} к ней, после чего включаешь вибрацию на максимум — награда за {npc.his} великие старания.\n\n"
	
	if(npcSlavery.getDespair() > 0.8):
		text += "Несмотря на невероятную силу вибрации, {npc.heShe} реагирует пассивно, не выказывая особого энтузиазма."
	elif(npcSlavery.getSpoiling() > 0.7):
		text += "Но даже этого режима, кажется, недостаточно — ваша рабыня требует еще больше наслаждения."
	elif(npcSlavery.isResistingSuperActively()):
		text += "Заметно борясь, {npc.heShe} пытается слезть с сибиана. Но вы быстро усаживаете {npc.him} обратно, плотно прижимая {npc.his} промежность к вибрирующим элементам."
	elif(npcSlavery.isActivelyResisting()):
		text += "Тело {npc.his} напрягается, когда сибиан включается. Хотя поначалу {npc.heShe} сопротивляется, она поддается всепоглощающим ощущениям — неоспоримое удовольствие берет верх над {npc.his} волей."
	#elif(npcSlavery.rewardBalance <= 0):
	#	text += ""
	elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit() > 0.5):
		text += "{npc.HeShe} с готовностью подчиняется, с предвкушением усаживаясь на сибиан. По телу {npc.his} пробегает дрожь возбуждения, когда устройство оживает. {npc.HeShe} страстно стонет, плотно прижавшись {npc.his} промежностью к вибрирующим элементам."
	else:
		text += "В глазах {npc.His} мелькает неуверенность, но как только начинается вибрация, {npc.heShe} поддается всепоглощающим ощущениям. Несмотря на первоначальное нежелание, неоспоримое удовольствие берет верх над {npc.his} сопротивлением."
	
	if(character.hasReachableVagina()):
		text += " Вскоре тело {npc.his} охватывает мощный оргазм, {npc.his} {pussy} извергается потоком прозрачной смазки."
	elif(character.isWearingChastityCage()):
		text += " Вскоре тело {npc.his} охватывает мощный оргазм, {npc.his} запертая {penis} выдавливает несколько слабых струек {npc.cum} сквозь маленькое отверстие девственной клетки."
	elif(character.hasReachablePenis()):
		text += " Вскоре тело {npc.his} охватывает мощный оргазм, {npc.his} {npc.penis} пульсирует, выбрасывая длинные нити {npc.cum}."
	else:
		text += " Вскоре тело {npc.his} охватывает мощный оргазм, заставляя её сильно извиваться и дрожать."
	
	character.orgasmFrom("pc")
	npcSlavery.handleReward(4)
	return {
		text = text,
	}

func getAnimationInfo(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery:NpcSlave = getSlave(_slaveID)
	if(npcSlavery.isActivelyResisting() || npcSlavery.isResistingSuperActively()):
		return [StageScene.SybianOral, "hold", {npc="pc", pc=_slaveID, pcCum=true, bodyState={naked=true,hard=true,leashedBy="pc"}}]
	return [StageScene.SybianOral, "intense", {npc="pc", pc=_slaveID, pcCum=true, bodyState={naked=true,hard=true,leashedBy="pc"}}]

func getTimePass(_slaveID, _extraSlavesIDs = {}):
	return 60*30
