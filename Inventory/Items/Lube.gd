extends ItemBase

func _init():
	id = "lube"

func getVisibleName():
	return "Смазка"
	
func getDescription():
	return "Персональный лубрикант на водной основе, гарантирующий отсутствие раздражения. Подходит как для вагинального, так и для анального использования; ваши отверстия быстрее восстанавливаются и меньше растягиваются"

func getA():
	return ""

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	_attacker.addEffect(StatusEffect.LubedUp, [8*60*60])
	removeXOrDestroy(1)
	return _attacker.getName() + " смазка нанесена!"

func getPossibleActions():
	return [
		{
			"name": "Применить",
			"scene": "UseItemLikeInCombatScene",
			"description": "Использовать лубрикант",
		},
	]

func getPrice():
	return 1

func canSell():
	return true

func canCombine():
	return true

func getTags():
	return [
		ItemTag.SoldByMedicalVendomat,
		ItemTag.SexEngineCanApply,
		]

func getItemCategory():
	return ItemCategory.Medical

func getInventoryImage():
	return "res://Images/Items/medical/lubricant.png"

func getSexEngineInfo(_sexEngine, _domInfo, _subInfo):
	var sub:BaseCharacter = _subInfo.getChar()
	var dom:BaseCharacter = _domInfo.getChar()
	
	return {
		"name": "Смазка",
		"usedName": "lube",
		"desc": "Делает твои дырочки более чувствительными.",
		"scoreOnSub": _sexEngine.hasGoalScore(_domInfo, SexGoal.SubOptionalApplyLubeOnSub, _subInfo)*(0.1-_domInfo.fetishScore({Fetish.Sadism: 0.1})),
		"scoreOnSelf": _sexEngine.hasGoalScore(_domInfo, SexGoal.SubOptionalApplyLubeOnDom, _subInfo)*(0.1-_domInfo.fetishScore({Fetish.Masochism: 0.1})),
		"scoreSubScore": _subInfo.getComplyScore(),
		"canUseOnDom": !dom.hasEffect(StatusEffect.LubedUp) && dom.getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null,
		"canUseOnSub": !sub.hasEffect(StatusEffect.LubedUp) && sub.getFirstItemThatCoversBodypart(BodypartSlot.Anus) == null,
		"maxUsesByNPC": 2,
	}

func useInSex(_receiver):
	_receiver.addEffect(StatusEffect.LubedUp)
	return {
		text = "{USER.You} {USER.youVerb('feel')} готово.".replace("USER", _receiver.getID()),
	}
