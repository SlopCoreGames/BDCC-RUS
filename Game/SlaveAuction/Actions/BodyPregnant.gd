extends AuctionAction

func _init():
	id = "BodyPregnant"

func getActionType():
	return AuctionActionType.Body

func getName() -> String:
	return "Беременность"

func getButtonDesc() -> String:
	return "Highlight the slave's pregnant belly.\n\n[b]Might[/b] reveal 1 mind preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Взгляните хорошенько, господа аукционисты — это не просто рабыня. {slave.He} вынашивает новую жизнь внутри {slave.him}! Идеальный вариант для тех, кто ценит красоту беременности.",
		"На рынке не так много таких, как {slave.him}. {slave.HeShe} несет в себе не только бремя рабских обязанностей, но и будущее.",
		"Видите этот живот? Это не от объеданий, {slave.he} {slave.isAre} беременна! В этом кроется столько потенциала для уникальных удовольствий.",
		"В беременных рабынях есть что-то особенное, не находите? Этот округлый живот, то, как {slave.he} бережно хранит жизнь внутри — это редкий и драгоценный опыт.",
		"{slave.He} станет прекрасным дополнением к любой коллекции. Беременная, полная жизни и всё еще жаждущая служить. Такое сочетание нельзя упускать.",
		"Вы покупаете не просто рабыню — с этой штучкой вы инвестируете в будущее. Беременность только добавляет {slave.his} привлекательности.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Mind, mightChance())

func getTraits() -> Dictionary:
	return {
		"Pregnant": 2.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'That’s a rarity!',
		'A pregnant slave? I can’t resist.',
		'There’s something so appealing about that belly.',
		'A rare treat indeed.',
		'I’ve been looking for a pregnant slave for a while.',
		'Pregnant slaves are hard to find.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'Pregnant? I’m not interested in dealing with that hassle.',
		'No thanks, too much responsibility.',
		'Pregnancy makes things complicated. I need a slave that can serve, not someone who needs special care.',
		'That belly\'s a turn-off for me. I’m not here to buy someone who\'s already carrying life.',
		'Pregnant? I\'m not gonna babysit someone else\'s children.',
	])
	
