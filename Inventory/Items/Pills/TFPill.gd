extends ItemBase

var tfID:String = ""
var tfArgs:Dictionary = {}
var configDesc:String = ""

func _init():
	id = "TFPill"

func getVisibleName():
	if(GM.main != null && GM.main.SCI != null && uniqueID!=null):
		var theID:String = getTFID()
		if(GM.main.SCI.isTransformationUnlocked(theID)):
			var tf = GlobalRegistry.getTransformationRef(theID)
			if(tf != null):
				return tf.getPillName()
	
	return "Странная таблетка"

#func getInventoryGroupID() -> String:
#	if(GM.main == null):
#		return .getInventoryGroupID()
#	var theID:String = getTFID()
#	if(GM.main != null && GM.main.SCI.isTransformationUnlocked(theID)):
#		return .getInventoryGroupID()+"_"+theID
#	return .getInventoryGroupID()

func getInventoryGroupName() -> String:
	return "Трансформационные таблетки"

func getSexEngineSubcategory() -> Array:
	return ["ТФ-таблетки"]

func getDescription():
	var theDesc:String = "Таблетка без каких-либо этикеток или инструкций. Кто знает, что она сделает..\n"
	if(tfID == "" || !GM.main.SCI.isTransformationUnlocked(tfID)):
		theDesc += "[color=#"+Color.cyan.to_html()+"]Эта таблетка может оказать какое-то трансформирующее воздействие на ваше тело.[/color]"
	else:
		var theTF:TFBase = GlobalRegistry.getTransformationRef(tfID)
		if(theTF):
			theDesc += "[color=#"+Color.cyan.to_html()+"]Эффект трансформации: [/color]"+theTF.getName()
		else:
			theDesc += "[color=#"+Color.cyan.to_html()+"]Эффект трансформации: [/color]"+"ОШИБКА!"
	
	if(!configDesc.empty()):
		theDesc += ("\n\n[color=#"+Color.cyan.to_html()+"]Настройки таблетки:\n"+configDesc+"[/color]")
	
	return theDesc

func canUseInCombat():
	return true

func getTFID() -> String:
	if(tfID == ""):
		tfID = TFUtil.generateTFIDForAPill()
		if(tfID != ""):
			var tf = GlobalRegistry.getTransformationRef(tfID)
			if(tf != null):
				tfArgs = tf.generatePillArgs()
	return tfID

func setTFID(newTFID:String):
	tfID = newTFID
	tfArgs.clear()
	if(tfID != ""):
		var tf = GlobalRegistry.getTransformationRef(tfID)
		if(tf != null):
			tfArgs = tf.generatePillArgs()

func makePillStrangeIfCan():
	var newTfID:String = TFUtil.generateTFIDForAPill([], 0.0)
	if(newTfID != ""):
		tfID = newTfID
		var tf = GlobalRegistry.getTransformationRef(tfID)
		if(tf != null):
			tfArgs = tf.generatePillArgs()

func setConfigDesc(newDesc:String):
	configDesc = newDesc

func pillStartTF(_user) -> Array:
	var _id:String = getTFID()
	
	var tfHolder = _user.getTFHolder()
	
	if(tfID == "" || GlobalRegistry.getTransformationRef(tfID) == null || tfHolder == null || !tfHolder.canStartTransformation(tfID)):
		return [false, "{USER.You} {USER.youVerb('swallow')} таблетку.. но ничего не происходит. Похоже, {USER.youHe} повезло!".replace("USER", _user.getID())]
	
	_user.getTFHolder().startTransformation(tfID, tfArgs)
	return [true, "{USER.You} {USER.youVerb('swallow')} странную таблетку..".replace("USER", _user.getID())]

func useInCombat(_attacker, _receiver):
	removeXOrDestroy(1)
	return pillStartTF(_attacker)[1]

func getPossibleActions():
	return [
		{
			"name": "Выпить",
			"scene": "UseItemLikeInCombatScene",
			"description": "Принять таблетку",
		},
	]

func getPrice():
	return 3

func canSell():
	return true

func canCombine():
	return false

#func tryCombine(_otherItem):
#	if(tfID == "" && _otherItem.tfID == ""):
#		return .tryCombine(_otherItem)
#	return false

func addsIntoxication():
	return 0.0

func getTimedBuffs():
	return [
	]

func getBuffsDurationSeconds():
	return 60*60*12

func getTimedBuffsTurns():
	return [
	]

func getBuffsDurationTurns():
	return 5

func getTags():
	return [
		#ItemTag.SoldByMedicalVendomat,
		ItemTag.SexEngineDrug,
		ItemTag.KeptAfterDrugDenRun,
		ItemTag.TFItem,
		]

func getBuyAmount():
	return 1

func getSexEngineInfo(_sexEngine, _domInfo, _subInfo):
	#var sub:BaseCharacter = _subInfo.getChar()
	#var dom:BaseCharacter = _domInfo.getChar()
	
	return {
		"name": getVisibleName(),
		"usedName": "странная таблетка",
		"desc": getDescription(),
		"scoreOnSub": 0.2,#_domInfo.goalsScoreMax({SexGoal.FuckVaginal: 1.0, SexGoal.FuckAnal: 0.5}, _subInfo.charID)*_domInfo.fetishScore({Fetish.Breeding: 1.0}),
		"scoreOnSelf": 0.0,
		"scoreSubScore": _subInfo.fetishScore({Fetish.TFReceiving: 1.0}),
		"canUseOnDom": true,
		"canUseOnSub": true,
		"maxUsesByNPC": 99,
		"sexgoal": SexGoal.UseTFDrug,
	}

func useInSex(_receiver):
	var _success:bool = pillStartTF(_receiver)[0]
	return {
		text = "Сначала ничего не происходит.." if _success else "Таблетка не произвела никакого эффекта.",
	}

func getItemCategory():
	return ItemCategory.Medical

func getInventoryImage():
	return "res://Images/Items/medical/tfpill.png"

func saveData():
	var data = .saveData()
	
	data["tfID"] = tfID
	data["tfArgs"] = tfArgs
	data["configDesc"] = configDesc
	
	return data
	
func loadData(data):
	.loadData(data)
	
	tfID = SAVE.loadVar(data, "tfID", "")
	tfArgs = SAVE.loadVar(data, "tfArgs", {})
	configDesc = SAVE.loadVar(data, "configDesc", "")
