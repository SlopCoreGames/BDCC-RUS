extends AuctionAction

func _init():
	id = "SkillSubmissive"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Под навыком"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave’s extensive training as a Submissive.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Эту обучали искусству подчинения. Каждая команда будет исполнена без малейших колебаний. А это именно то, чего ты ждешь от хорошей рабыни.",
		"Ищешь рабыню, которая уже знает, как вставать на колени? Эта покорная особа отлично натренирована и жаждет угодить.",
		"Подчинение — её конек. Идеально подходит для тех, кто обожает полный контроль. Поверь мне, обладать абсолютной властью — это невероятно весело.",
		"Настоящая подчиненная, отточенная до совершенства. {slave.He} никогда не ослушается и не поставит под сомнение твой авторитет. А это именно то, что нужно от хорошей рабыни.",
		"При такой подготовке можно даже не беспокоиться о дисциплине. {slave.He} уже знает, как нужно подчиняться.",
		"Нет ничего приятнее, чем рабыня, живущая ради служения. И эта покорная особа была обучена именно этому. Служить тебе!",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"SkillSubmissive": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I like a well-trained subby thing.',
		'Already knows how to submit? Saves me a lot of time.',
		'A well-trained submissive? Neat.',
		'I like ones that are trained to obey without hesitation.',
		'A trained submissive is always useful.',
		'Sounds nice.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I don\'t need a sub.',
		'I\'m not looking for submissives.',
		'You\'re selling a sub? Ugh.',
		'I don\'t like subs, zero spark in them usually.',
		'I\'d rather not.',
		'Any slave is a sub by default. Whatever.',
	])
	
