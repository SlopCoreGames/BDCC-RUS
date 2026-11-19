extends AuctionAction

func _init():
	id = "BodyBreasts"

func getActionType():
	return AuctionActionType.Body

func getName() -> String:
	return "Размер груди"

func getButtonDesc() -> String:
	return "Highlight the slave's breasts.\n\n[b]Might[/b] reveal 1 mind preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("BreastsSmall") && _slaveTraits["BreastsSmall"] > 0.0):
		if(!_char.hasNonFlatBreasts()):
			sayPresenter(RNG.pick([
				"О да, я хочу, чтобы вы все полюбовались этой идеально плоской грудью — подтянутой и сильной, настоящим холстом чистых возможностей!",
				"Взгляните на грудь {slave.his}. Кто-то предпочитает изгибы, но другие ценят чистые, упругие линии плоского, скульптурного тела.",
				"Взгляните на эти {slave.breasts}. Не всем нужна мягкость. Для тех, кто предпочитает голые мышцы и рельеф, эта рабыня — само совершенство.",
				"Для владельцев, которым нравится атлетичный вид: грудь этой рабыни максимально плоская и твердая.",
			]))
		else:
			sayPresenter(RNG.pick([
				"Я хочу, чтобы вы все хорошенько рассмотрели эту маленькую, упругую грудь. Идеально сформированную и такую чувствительную.",
				"Некоторые из вас предпочитают более скромную, изящную грудь, и эта рабыня превзойдет все ожидания со своими миниатюрными красавицами.",
				"Разве эти {slave.breasts} не идеальны? Тугие маленькие шарики, которые так и просятся на ладонь.",
				"Говорят, чем больше, тем лучше, но для людей с утонченным вкусом эти {slave.breasts} — редкое и изысканное лакомство.",
				"Посмотрите на грудь {slave.his}. Миниатюрная и мягкая — это грудь той, кто умеет доставлять удовольствие, не перегружая чувства. Тонкая, но незабываемая.",
				"Посмотрите на грудь {slave.his}. Для тех, кто жаждет точности и изящества: эта маленькая, подтянутая грудь — именно то, что вы ищете.",
			]))
	if(_slaveTraits.has("BreastsAverage") && _slaveTraits["BreastsAverage"] > 0.0):
		sayPresenter(RNG.pick([
			"Взгляните на эту идеальную грудь. Налитая, нежная, созданная для прикосновений.",
			"Взгляните на грудь {slave.his}. Не слишком маленькая, не слишком большая — {slave.his} грудь как раз на любой вкус. Идеально ложится в ладонь.",
			"Хочу, чтобы вы все смотрели туда же, куда и я. Эти мягкие, округлые формы идеальны для любого сценария. Не слишком вызывающие, но на них просто невозможно не смотреть.",
			"Сиськи! Если вы ищете золотую середину, то это именно то, что вам нужно. Идеально средние, но чертовски соблазнительные.",
			"Посмотрите на {slave.his} красотки. С такой грудью ты получаешь лучшее из двух миров: достаточно пышная, чтобы дразнить, но не настолько огромная, чтобы стать обузой.",
			"Округлые и податливые, {slave.his} {slave.breasts} будут радовать каждое ваше прикосновение. Они просто созданы для того, чтобы ими любовались.",
		]))
	if(_slaveTraits.has("BreastsHuge") && _slaveTraits["BreastsHuge"] > 0.0):
		sayPresenter(RNG.pick([
			"Эти массивные, тяжелые груди вы точно не забудете. Переполненные и так и просящие внимания.",
			"Для тех, кто любит, чтобы было за что ухватиться: эти огромные, сочные груди — воплощение вашей мечты!",
			"Посмотрите на {slave.his} {slave.breasts}. Пышные, тяжелые, мимо них невозможно пройти!",
			"Посмотрите на {slave.his} {slave.breasts}. Эти массивные красавицы — всё, что вы так долго искали.",
			"Посмотреть на {slave.his} {slave.breasts}? Огромные, мягкие и переполненные. Идеально для тех, кто способен совладать с таким объемом.",
			"Замереть на мгновение, любуясь невероятным размером и тяжестью {slave.his} {slave.breasts} — истинная роскошь в чистом виде.",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Mind, mightChance())

func getTraits() -> Dictionary:
	return {
		"BreastsSmall": 1.0,
		"BreastsAverage": 1.0,
		"BreastsHuge": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("BreastsSmall") && _slaveTraits["BreastsSmall"] > 0.0):
		if(!_char.hasNonFlatBreasts()):
			return RNG.pick([
				'Flat and toned, just the way I like it.',
				'A firm, flat chest? Yes please.',
				'So elegant.',
				'So lean.',
				'Exactly what I’m looking for.',
				'Muscular and flat.',
				'That flat chest is ideal for what I need.',
			])
		else:
			return RNG.pick([
				'I prefer small breasts, they are so much more cute.',
				'Perky and petite? I’ll take that over huge tits any day.',
				'Small and perky. Just the way I like them.',
				'Size doesn’t matter when they look this perfect.',
				'Lean and beautiful.',
				'Those small, tight breasts? Perfect.',
			])
	if(_slaveTraits.has("BreastsAverage") && _slaveTraits["BreastsAverage"] > 0.0):
		return RNG.pick([
			'Now that’s what I like to see.',
			'Perfect!',
			'These are ideal.',
			'Huh. Yeah. They’re just right, not too much, not too little.',
			'Perfect breasts.',
			'Those are some good-looking tits.',
			'Yes!',
		])
	if(_slaveTraits.has("BreastsHuge") && _slaveTraits["BreastsHuge"] > 0.0):
		return RNG.pick([
			'Give me, give me!',
			'Oh, that\'s my weakness.',
			'Perfect for my tastes. I love a lot to handle!',
			'Those massive beauties? Yes!',
			'Finally, something with size.',
			'The bigger, the better.',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)
