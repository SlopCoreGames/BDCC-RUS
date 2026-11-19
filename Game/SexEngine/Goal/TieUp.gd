extends SexGoalBase

func _init():
	id = SexGoal.TieUp

func getVisibleName():
	return "Связать"

func generateData(_sexEngine, _domInfo, _subInfo):
	return [
		2,
	]

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	if(_sexEngine.isBondageDisabled()):
		return false
	if(_domInfo.getChar().hasBoundArms() || _domInfo.getChar().hasBlockedHands()):
		return false
	var itemTagToUse = ItemTag.CanBeForcedByGuards
	if(_sexEngine.getSexTypeID() == SexType.StocksSex):#(isStocksSex()):
		itemTagToUse = ItemTag.CanBeForcedInStocks

	if(_subInfo.getChar().getInventory().getAmountOfRestraintsThatCanForceDuringSex(itemTagToUse) <= 0):
		return false
	
	return true

func isCompleted(_sexEngine, _domInfo, _subInfo, _data):
	#if(_subInfo.getChar().getInventory().getAmountOfRestraintsThatCanForceDuringSex(ItemTag.CanBeForcedByGuards) <= 0):
	#	return true
	
	return _data[0] <= 0

func progressGoal(_sexEngine, _domInfo, _subInfo, _data, _args = []):
	if(_data is Array && _data.size() > 0):
		_data[0] -= 1

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {
		SexGoal.SubUndressSub: 0.3,
	}

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	var sub = _subInfo.getChar()
	var dom = _domInfo.getChar()
	
	for _i in range(RNG.randi_range(0, 2)):
		var itemTagToUse = ItemTag.CanBeForcedByGuards
		if(_sexEngine.getSexTypeID() == SexType.StocksSex):
			itemTagToUse = ItemTag.CanBeForcedInStocks
		
		var possibleRestraints = sub.getInventory().getRestraintsThatCanBeForcedDuringSex(itemTagToUse)
		
		if(possibleRestraints.size() > 0):
			var randomRestraintID:String = RNG.pick(possibleRestraints)
		
			sub.getInventory().forceEquipByStoreOtherUnlessRestraint(GlobalRegistry.createItem(randomRestraintID), dom)
			sendSexEvent(_sexEngine, SexEvent.BondageGearForced, _domInfo, _subInfo, {itemID=randomRestraintID})

func canBegFor() -> bool:
	return true

func getBegName() -> String:
	return "Tie me up"

func getBegCategory() -> Array:
	return BegCategoryExotic

func getBegDesc() -> String:
	return "Beg the dom to make you wear bondage gear!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to make {sub.youHim} wear bondage gear."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return RNG.pick([
		"Умоляю, позволь мне надеть БДСМ-атрибутику. Хочу быть связанной и совершенно беспомощной.",
		"Можешь, пожалуйста, пристегнуть к нам что-нибудь? Мне нужно почувствовать себя полной беспомощной.",
		"Пожалуйста, я хочу быть твоей связанной игрушкой. Наденешь на меня БДСМ-снаряжение?",
		"Если у тебя есть какая-нибудь атрибутика для связывания... можешь пристегнуть её на меня... пожалуйста?",
		"Мне бы не помешали наручники... или верёвки... да что угодно.",
		"Обожаю БДСМ-штучки... нацепи на меня столько, сколько захочешь.",
	])

func getBegDomFetishes() -> Dictionary:
	return {
		Fetish.Rigging: 1.0,
	}
