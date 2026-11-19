extends AuctionAction

func _init():
	id = "BodyFemininity"

func getActionType():
	return AuctionActionType.Body

func getName() -> String:
	return "Женственность"

func getButtonDesc() -> String:
	return "Point out the slave's femininity/masculinity.\n\n[b]Might[/b] reveal 1 mind preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("Masculine") && _slaveTraits["Masculine"] > 0.0):
		sayPresenter(RNG.pick([
			"Взгляните на это крепкое телосложение. Созданная для тяжелого труда и выносливости, эта заготовка — лучший актив, который вы когда-либо найдете.",
			"Широкие плечи, мощные руки — сила, которая говорит сама за себя. Только представьте, на что способен {slave.he} ради вас.",
			"Крепкий и надежный — этот экземпляр является эталоном мужского совершенства, способным справиться с любой задачей, которую вы поставите перед {slave.him}.",
			"Гора мышц, идеально подходящая для рабского труда или охраны. Вы покупаете не просто раба, вы покупаете мощь.",
			"Посмотрите на этот рельеф! Грубая сила и выносливость, заключенные в тело, готовое к служению.",
			"{slave.He} {slave.isAre} — сложен как зверь, сильный и внушительный. Именно то, что нужно любому искушенному покупателю в его коллекцию.",
		]))
	if(_slaveTraits.has("Androgynous") && _slaveTraits["Androgynous"] > 0.0):
		sayPresenter(RNG.pick([
			"Редкая находка — этот экземпляр балансирует на грани между мужским и женским, сочетая в себе элегантность и силу.",
			"Прекрасный баланс: не слишком мягкий, но и не слишком грубый. Идеальное сочетание мужских и женских черт.",
			"Универсальное и манящее тело, предлагающее лучшее из обоих миров и готовое угождать вам любым способом.",
			"Его изменчивые формы заставят вас гадать, что именно ждет вас впереди — уникальное дополнение к коллекции любого ценителя.",
			"Ни то, ни другое. Настоящая загадка, гибкая и пленительная во всех смыслах.",
			"Грациозная, но при этом сильная; её аура таинственности заставит вас возвращаться к ней снова и снова.",
		]))
	if(_slaveTraits.has("Feminine") && _slaveTraits["Feminine"] > 0.0):
		sayPresenter(RNG.pick([
			"Нежная и мягкая, её женская красота неоспорима — идеальный выбор для обладателей утонченного вкуса.",
			"Только взгляните на эти изгибы — само воплощение грации и соблазна, готовое покорить любого господина.",
			"Элегантные формы, девчачья миловидность и жажда угодить — такая рабыня никогда не надоест.",
			"Безупречный образец женственности; одной её красоты достаточно, чтобы развязать настоящую войну ставок.",
			"Мягкие изгибы, нежная кожа и невинное лицо. Вы вряд ли найдете более совершенную женскую фигуру.",
			"Милая, хрупкая и такая девчачья. Идеально подходит для тех, кто ищет в своей коллекции нежность и мягкость.",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Mind, mightChance())

func getTraits() -> Dictionary:
	return {
		"Masculine": 1.0,
		"Androgynous": 1.0,
		"Feminine": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("Masculine") && _slaveTraits["Masculine"] > 0.0):
		return RNG.pick([
			'Strong, I like that.',
			'Very powerful.',
			'Impressive physique.',
			'Perfection.',
			'Now we’re talking.',
		])
	if(_slaveTraits.has("Androgynous") && _slaveTraits["Androgynous"] > 0.0):
		return RNG.pick([
			'Perfection.',
			'Captivating.',
			'Interesting, for sure.',
		])
	if(_slaveTraits.has("Feminine") && _slaveTraits["Feminine"] > 0.0):
		return RNG.pick([
			'Beautiful and graceful.',
			'Just the right amount of girly!',
			'Just the softness I like.',
			'Gorgeous.',
			'A true beauty.',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)
