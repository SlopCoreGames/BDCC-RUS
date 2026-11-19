extends AuctionAction

func _init():
	id = "MindBroken"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Сломленная психика"

func getButtonDesc() -> String:
	return "Укажите на сломленный разум рабыни... Это может вызвать бурную реакцию, как положительную, так и отрицательную.\n\n[b]Может[/b] раскрыть по одной черте характера каждого участника аукциона."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Ах да, кстати... эту совсем сломали. Ни мыслей, ни сопротивления — только чистое послушание.",
		"Ах да, кстати... {slave.He} {slave.isAre} сломлена и готова беспрекословно выполнять любую команду. У этой больше нет воли, чтобы сопротивляться.",
		"Разум этой рабыни стерт. {slave.He} {slave.isAre} она в твоем распоряжении, лепи из нее что хочешь, не колеблясь. Чистый холст!",
		"Ах да, кстати... {slave.he} {slave.is} просто чистый лист. Но это даже хорошо. Эта сломленная рабыня будет исполнять любой твой каприз без лишних вопросов.",
		"Ах да, кстати... {slave.He} {slave.isAre} абсолютно послушная, полностью сломленная. Эта не станет сопротивляться ни одному твоему требованию.",
		"Ах да, кстати... эту сломали окончательно. Идеальная кукла: никаких мыслей, только действия. Любая команда будет исполнена без единого вопроса.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"MindBroken": 3.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		"Обожаю чистые листы.",
		"Экономит мне время.",
		"Куклы — это весело.",
		"Мне бы не помешала хорошая кукла для траха.",
		"Похоже на идеальную послушную куклу.",
		"Значит, мне не придется самому выносить им мозг."
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		"Ты серьезно? Это же ужасно.",
		"Вы что, продаете нам сломленную рабыню? Офигеть...",
		"Нахрена мне сдалась эта кукла?",
		"Мне нужна личность, а не ебаная кукла.",
		"Да, бесит неимоверно.",
	])
	
func getPassiveDesireGain() -> float:
	return -0.5
