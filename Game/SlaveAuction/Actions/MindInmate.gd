extends AuctionAction

func _init():
	id = "MindInmate"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Бывший заключенный"

func getButtonDesc() -> String:
	return "Объясните, как этот раб раньше был одним из заключенных.\n\n[b]Возможно[/b] раскроет по одному предпочтению в характере у каждого участника торгов."

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
		'Заключенный, значит? Спорим, они знают толк в том, как принимать наказания.',
		'Доломать того, кто уже сломлен тюрьмой... поэтично.',
		'Похоже на того, кто уже умеет беспрекословно подчиняться.',
		'Может стать отличной долгосрочной инвестицией.',
		'Владеть кем-то с таким прошлым... это приносит особое удовлетворение.',
		'Меня возбуждает даже сама эта мысль.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'Мне не нужны проблемы с «АльфаКорп».',
		'Нет, спасибо, это уже перебор.',
		'Думаю, это может быстро обернуться проблемой.',
		'Раб «АльфаКорп»? Ну, такое.',
		'Пожалуй, не стоит.',
		'Этот ошейник ведь не снимается? Жирнейший тревожный звоночек.',
	])
	
