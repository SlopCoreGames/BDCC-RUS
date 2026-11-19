extends ItemBase

func _init():
	id = "TFUndoPill"
# MorphIn
# QuickShift
# MorphAway

func getVisibleName():
	return "Таблетка «Морфинг вовне»"
	
func getDescription():
	return "Таблетка, которая якобы способна [color=#"+Color.cyan.to_html()+"]отменяет любые временные эффекты трансформации и возвращает ваше тело в прежнее состояние.[/color]"

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	removeXOrDestroy(1)
	_attacker.undoAllTransformations()
	return "Вы проглатываете таблетку МорфАвей!"

func getPossibleActions():
	return [
		{
			"name": "Выпить",
			"scene": "UseItemLikeInCombatScene",
			"description": "Принять таблетку",
		},
	]

func getPrice():
	return 30

func canSell():
	return true

func canCombine():
	return true

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
	var sub:BaseCharacter = _subInfo.getChar()
	var dom:BaseCharacter = _domInfo.getChar()
	
	return {
		"name": "Морф-отмена",
		"usedName": "таблетка МорфАвей",
		"desc": getDescription(),
		"scoreOnSub": 0.0,
		"scoreOnSelf": 0.0,
		"scoreSubScore": _subInfo.fetishScore({Fetish.TFReceiving: -1.0})+0.20,
		"canUseOnDom": dom.hasActiveTransformations(),
		"canUseOnSub": sub.hasActiveTransformations(),
		"maxUsesByNPC": 1,
	}

func useInSex(_receiver):
	_receiver.undoAllTransformations()
	return {
		text = "{USER.You} {USER.youVerb('feel')} как {USER.yourHis} прежний.".replace("USER", _receiver.getID()),
	}

func getItemCategory():
	return ItemCategory.Medical

func getInventoryImage():
	return "res://Images/Items/medical/bluepill.png"
