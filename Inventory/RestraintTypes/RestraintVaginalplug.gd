extends RestraintData
class_name RestraintVaginalplug

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = RestraintType.VaginalPlug
	sexReaction = SexReaction.BondageVaginalPlug

var turnedOn = false

func canUnlockWithKey():
	return false

func alwaysSavedWhenStruggledOutOf():
	return true

func shouldDoStruggleMinigame(_pc):
	var _handsFree = !_pc.hasBlockedHands()
	if(_handsFree):
		return false
	return .shouldDoStruggleMinigame(_pc)

func doStruggle(_pc, _minigame:MinigameResult):
	var _handsFree = !_pc.hasBlockedHands()
	var _armsFree = !_pc.hasBoundArms()
	var _legsFree = !_pc.hasBoundLegs()
	var _canSee = !_pc.isBlindfolded()
	var _canBite = !_pc.isBitingBlocked()
	
	var text = "ошибка?"
	var lust = 0
	var pain = 0
	var damage = 0
	var stamina = 0
	
	if(failChanceLowScore(_pc, 30, _minigame)):
		text = "{user.name} пытается вытолкнуть пробку из {user.his} киски, но [b]с треском проваливается[/b], из-за чего пробка заезжает ещё глубже и касается самого входа в матку!"
		damage = -0.5
		lust = scaleDamage(20)
	elif(_handsFree && _armsFree):
		text = "Поскольку руки {user.name} свободны, {user.he} просто {user.verbS('remove')} пробку."
		damage = 1.0
		lust = scaleDamage(10)
	elif(_legsFree):
		text = "{user.name} ерзает и дёргает {user.his} задницей, пытаясь вытолкнуть пробку из {user.his} киски."
		damage = calcDamage(_pc, _minigame)
		stamina = 5
		lust = scaleDamage(5)
	else:
		text = "{user.name} отчаянно извивается, пытаясь вытолкнуть вагинальную пробку. Из-за того, что она не может раздвинуть {user.his} ноги, это даётся ей с огромным трудом."
		damage = calcDamage(_pc, _minigame, 0.5)
		stamina = 10
		lust = scaleDamage(5)
	

	if(damage < 1.0):
		if(_pc.isPlayer() && failChance(_pc, 40) && _pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom)):
			if(_pc.getInventory().getEquippedItem(InventorySlot.UnderwearBottom).coversBodypart(BodypartSlot.Vagina)):
				text += " The plug presses into your panties."
				damage /= 2.0
				
				if(failChance(_pc, 30)):
					text += " [b]Your panties slipped down, oops.[/b]"
					_pc.getInventory().unequipSlot(InventorySlot.UnderwearBottom)
		
		if(!turnedOn && failChance(_pc, 40)):
			text += " {user.name} accidentally turns on the plug inside {user.him} and it starts vibrating!"
			turnedOn = true
		elif(turnedOn && failChance(_pc, 20)):
			text += " {user.name} managed to randomly turn off the vibrating plug."
			turnedOn = false
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(turnedOn):
		return {"text": "The vaginal plug strongly vibrates inside {user.nameS} pussy", "lust": scaleDamage(5)}
	else:
		if(failChance(_pc, 5) || (_isActivelyStruggling && failChance(_pc, 30))):
			turnedOn = true
			return {"text": "[b]The plug inside {user.nameS} pussy accidentally turns on[/b]. It vibrates, bringing {user.him} pleasure!"}
	
	
func resetOnNewDay():
	.resetOnNewDay()
	turnedOn = false

func resetOnNewTry():
	.resetOnNewTry()
	#tightness = 1

func onStruggleRemoval():
	.onStruggleRemoval()
	turnedOn = false

func saveData():
	var data = .saveData()
	
	data["turnedOn"] = turnedOn

	return data
	
func loadData(_data):
	.loadData(_data)
	
	turnedOn = SAVE.loadVar(_data, "turnedOn", false)

func getForceOnCombatAnim() -> String:
	return "RestraintCrotch"
