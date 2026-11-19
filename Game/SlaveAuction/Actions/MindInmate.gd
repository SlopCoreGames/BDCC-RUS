extends AuctionAction

func _init():
	id = "MindInmate"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Бывший заключенный"

func getButtonDesc() -> String:
	return "Explain how this slave was previously one of the inmates.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Эта девчонка сидела в одной из глубоко запрятанных тюрем AlphaCorp. Закаленная, но теперь она полностью сломлена!",
		"Когда-то заключенная тюрьмы AlphaCorp, а теперь — ценный трофей. Сколько участников торгов смогут похвастаться таким?",
		"Только что из тюремных камер AlphaCorp; эта заключенная повидала всякое и теперь готова служить.",
		"Эта проторчала годы за решеткой в тюрьме AlphaCorp, а теперь {slave.he} готова служить на «той» стороне.",
		"Бывшая заключенная AlphaCorp, уже обученная покорности — идеальный вариант для тех, кто ищет по-настоящему опытной рабыню.",
		"Плененная, наказанная и теперь — в собственности. Эта бывшая узница AlphaCorp будет исполнять любую вашу команду.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"MindInmate": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'An inmate, huh? Bet they know a thing or two about taking punishment.',
		'Breaking someone already broken by prison... poetic.',
		'Sounds like someone who already knows how to follow orders.',
		'Could be a good long-term investment.',
		'Owning someone with that background is.. satisfying.',
		'I love even just the idea.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I don\'t need problems with AlphaCorp.',
		'No thanks, that is too much.',
		'I think this can quickly become a problem.',
		'AlphaCorp slave? Ehh.',
		'I\'d rather not.',
		'That collar is permanent, isn\'t it? Huge red flag.',
	])
	
