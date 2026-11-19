extends AuctionAction

func _init():
	id = "BodyPenis"

func getActionType():
	return AuctionActionType.Body

func getName() -> String:
	return "Длина члена"

func getButtonDesc() -> String:
	return "Highlight the slave's penis.\n\n[b]Might[/b] reveal 1 mind preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("PenisSmall") && _slaveTraits["PenisSmall"] > 0.0):
		sayPresenter(RNG.pick([
			"Взгляните на эту милую штучку между ножек {slave.his}. Работать особо не с чем, но в самый раз для тех из вас, кто предпочитает рабов с капелькой стыдливости. {slave.his}",
			"У этого экземпляра скромный комплект, но не стоит недооценивать развлекательный потенциал. В конце концов, дело не всегда в размере — иногда всё дело в том, как мало им есть что предложить.",
			"Посмотри на член {slave.his}! Маленький, да, но это делает процесс подчинения еще слаще, не так ли? Кому не в радость видеть, как раб краснеет от того, как мало у него в штанах?",
			"Для тех, кто обожает рабов, знающих своё место: этот крошечный член позаботится о том, чтобы они об этом никогда не забывали.",
			"Между ног у {slave.his} не особо-то и много... {slave.penis}, честно говоря, выглядит жалко... но это лишь значит, что у {slave.him} полно места, чтобы сосредоточиться на чем-то другом!",
			"Маленький член может стать настоящим преимуществом, особенно если тебе нужен раб, которого легко унижать и контролировать. Только представь, как они будут краснеть каждый раз, когда ты напоминаешь им об этом!",
		]))
	if(_slaveTraits.has("PenisAverage") && _slaveTraits["PenisAverage"] > 0.0):
		sayPresenter(RNG.pick([
			"У этого вполне приличный, средненький член. Не слишком большой, не слишком маленький — в самый раз, чтобы сделать дело!",
			"Приличный средний член для самого разного опыта. Хочешь ли ты, чтобы они были сверху или снизу, {slave.he} справится на отлично.",
			"Посмотри на этот {slave.penis}. В плане размера здесь нет ничего особенного, но это лишь значит, что они будут надежны в любой роли!",
			"Посмотри на этот сочный член, разве он не идеален? Ничего особенного... но иногда особенное и не нужно. Иногда тебе просто нужен хороший сочный член!",
		]))
	if(_slaveTraits.has("PenisLong") && _slaveTraits["PenisLong"] > 0.0):
		sayPresenter(RNG.pick([
			"А вот это уже то, что заставит тебя обратить внимание — у этого раба есть чем поживиться. Длинный и толстый, готовый к действию в любое время!",
			"Зацени! С таким членом этот раб создан для удовольствия. Ребята, такой инструмент на рынке встретишь нечасто.",
			"Взгляни на член {slave.his}! Впечатляет, не так ли? Этот длинный член идеально подходит для тех, кто хочет раба, способного доставить удовольствие даже самым требовательным хозяевам.",
			"Загляни между ног {slave.his}. Такой член — это больше, чем просто оружие, это настоящий актив. Длинный, толстый и готовый исполнить любое твое желание.",
			"Член этого раба достаточно велик, чтобы удовлетворить даже самого требовательного участника торгов. Настоящий приз для тех, кому мало среднего.",
			"Загляни между ног {slave.his}. Не каждый день выпадает шанс увидеть такой член. Он длинный, толстый и уже готов к делу. Одно только это заслуживает того, чтобы за него выставили бешеные ставки!",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Mind, mightChance())

func getTraits() -> Dictionary:
	return {
		"PenisSmall": 1.0,
		"PenisAverage": 1.0,
		"PenisLong": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("PenisSmall") && _slaveTraits["PenisSmall"] > 0.0):
		return RNG.pick([
			'Perfect for humiliating.',
			'That size means total submission.',
			'I love a slave that’s embarrassed by their size. Makes them more obedient.',
			'Tiny cocks are perfect for making a slave focus on other ways to please.',
			'That’ll keep them humble. A small cock means easy control.',
			'There’s a lot of potential with a tiny cock like that - perfect for some extra humiliation.',
		])
	if(_slaveTraits.has("PenisAverage") && _slaveTraits["PenisAverage"] > 0.0):
		return RNG.pick([
			'Now that’s what I like to see.',
			'Perfect!',
			'That is a pretty good cock.',
			'Just what I’ve been looking for.',
			'Perfect cock.',
			'Great cock, all around.',
			'Yes!',
		])
	if(_slaveTraits.has("PenisLong") && _slaveTraits["PenisLong"] > 0.0):
		return RNG.pick([
			'Impressive size.',
			'Wow. Just wow.',
			'Big cocks like that are hard to find!',
			'I’ve been looking for a slave with a cock like that for a while.',
			'A cock like that is worth the investment.',
			'The bigger, the better.',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("PenisSmall") && _slaveTraits["PenisSmall"] > 0.0):
		return RNG.pick([
			'A tiny cock? What am I supposed to do with that?',
			'Too small for my tastes. I need something more impressive.',
			'No thanks, I didn\'t come here for some pathetic little thing.',
			'Useless to me.',
			'Humiliating, sure, but that size is just disappointing.',
			'I was hoping for more..',
		])
	if(_slaveTraits.has("PenisAverage") && _slaveTraits["PenisAverage"] > 0.0):
		return RNG.pick([
			'Nothing special here. If I wanted \'average\', I’d stay home.',
			'I expected more.',
			'Boring.',
			'I was hoping for something a little more... exciting.',
			'Forgettable.',
		])
	if(_slaveTraits.has("PenisLong") && _slaveTraits["PenisLong"] > 0.0):
		return RNG.pick([
			'Too big.',
			'All that size is wasted if they can’t use it right.',
			'I prefer something more modest. That’s just excessive.',
			'Long? Yeah, but that doesn’t mean they know what to do with it.',
			'Too much cock isn’t always a good thing.',
			'Looks impressive, but that’s not what I need in a slave.',
		])
	
	return .getNegativeReaction(_char, _slaveTraits)
