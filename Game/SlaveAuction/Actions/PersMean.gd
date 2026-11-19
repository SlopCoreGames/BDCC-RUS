extends AuctionAction

func _init():
	id = "PersMean"

func getActionType():
	return AuctionActionType.Personality

func getName() -> String:
	return "Скверный/Добрый"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave's mean/kind personality.\n\n[b]Might[/b] reveal 1 fetish preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("PersMean") && _slaveTraits["PersMean"] > 0.0):
		sayPresenter(RNG.pick([
			"У {slave.He} острый язык и соответствующий ему скверный нрав. Но в правильных руках эта жестокость может стать вашим главным развлечением.",
			"Если вы ищете вызов, {slave.he} заставит вас выложиться на полную благодаря {slave.hisHer} злобному характеру.",
			"Злобная и непокорная. Эта особа не склонится без боя... но ведь в этом и заключается половина удовольствия, не так ли?",
			"Хотите рабыню с характером? {slave.He} не побоится показать вам {slave.hisHer} зубы и когти. Маленькая проверка на прочность — это всегда весело.",
			"Укрощение скверного нрава {slave.his} потребует усилий, но награда будет невероятно сладкой, когда вы добьетесь своего.",
			"Сейчас {slave.HeShe} может казаться злобной, но сломайте {slave.himHer}, и вы получите нечто поистине особенное. Поверьте, это будет весело.",
		]))
	if(_slaveTraits.has("PersKind") && _slaveTraits["PersKind"] > 0.0):
		sayPresenter(RNG.pick([
			"У {slave.He} золотое сердце. Добрая, нежная и стремящаяся угодить, {slave.heShe} станет чудесной спутницей.",
			"Вы не найдете более послушной и кроткой души, чем {slave.him}. Всегда готова помочь и облегчить вам жизнь.",
			"Этой рабыне не нужны суровые приказы. {slave.HeShe} будет служить с готовностью и добротой в {slave.hisHer} глазах.",
			"Мягкая натура {slave.His} покорит ваше сердце. Идеальный выбор для любого, кто ценит верность и сострадание.",
			"С {slave.himHer} вы получите не просто послушание... у вас будет рабыня, которая искренне заботится о своем {slave.hisHer} хозяине.",
			"Доброе сердце и нежные руки. {slave.He} станет прекрасным дополнением к вашему дому.",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Fetish, mightChance())

func getTraits() -> Dictionary:
	return {
		"PersMean": 1.0,
		"PersKind": 1.0,
	}
