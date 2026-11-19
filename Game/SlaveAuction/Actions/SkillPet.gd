extends AuctionAction

func _init():
	id = "SkillPet"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Навык питомца"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave’s extensive training as a Pet.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"{slave.He} обучена до совершенства как питомец. И вы знаете, что это значит — {slave.he} будет {slave.isAre} послушной, верной и жаждущей служить.",
		"Ищете преданное существо, которое беспрекословно выполняет команды? Это она. Послушная, верная и жаждущая служить.",
		"От принесения вещей до преклонения колен — {slave.he} обучена реагировать на любую вашу потребность, словно верное животное.",
		"Обученная как питомец, {slave.he} будет ходить за вами повсюду, готовая прийти на помощь по первому зову. Всегда послушная, всегда верная.",
		"Этот питомец знает, что {slave.his} — лишь ваше украшение у ног. Готова повиноваться, жаждет угождать.",
		"Идеально приученная быть верным питомцем, эта крошка никогда не посмеет подвергнуть сомнению ваши приказы.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"SkillPet": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'A loyal pet? I could use that in my household.',
		'Training like that is rare.',
		'Already trained? Saves me the trouble.',
		'Obedience and loyalty. I’m interested.',
		'A perfect pet? That\'s rare',
		'That’s exactly what I’m looking for.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I don\'t need an animal, I need a slave.',
		'I\'m not looking for pets.',
		'You\'re selling an animal? Ugh.',
		'I don\'t like pets, they are so messy.',
		'I\'d rather not.',
		'I hate pets because they keep scratching furniture.',
	])
	
