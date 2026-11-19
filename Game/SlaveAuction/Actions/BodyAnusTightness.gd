extends AuctionAction

func _init():
	id = "BodyAnusTightness"

func getActionType():
	return AuctionActionType.Body

func getName() -> String:
	return "Степень сжатия ануса"

func getButtonDesc() -> String:
	return "Highlight the slave's ass.\n\n[b]Might[/b] reveal 1 mind preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("AnusTight") && _slaveTraits["AnusTight"] > 0.0):
		sayPresenter(RNG.pick([
			"Так, я знаю, что вы все пялитесь на эту задницу. Позвольте мне сказать: у этой рабыни узенькое анусное отверстие, которое так и просит хорошей растяжки.",
			"Поверьте мне на слово, задница этой рабыни еще не видела особого применения. Сжата как тиски и готова к тому, кто ее заберет!",
			"Взгляните на эту красотку. Гарантирую, дырочка {slave.his} еще не тронута и невероятно тугая — она только и ждет достойного хозяина, чтобы тот ее размял.",
			"Задний проход этой рабыни? Настоящий узел из мышц, ждущий хорошей разрядки. Давно я не видел ничего настолько тугого.",
			"Отсюда может и не видно, но поверьте мне — анус {slave.his} очень узкий. Эта рабыня будет сжимать вас так, как ни одна другая.",
			"Задница этой штучки? Почти не использовалась, почти не растягивалась. Тому, кто заберет {slave.himHer}, выпадет честь стать первым, кто по-настоящему раздвинет {slave.himHer}.",
		]))
	if(_slaveTraits.has("AnusLoose") && _slaveTraits["AnusLoose"] > 0.0):
		sayPresenter(RNG.pick([
			"А если вы ищете задницу, которую уже вовсю использовали, то вам повезло. Анус этой рабыни расслаблен, очень расслаблен. Можно не церемониться!",
			"Рассмотрите эту задницу получше. Дырка этой рабыни уже повидала виды — ее так растянули и использовали, что она готова принять всё, что вы в нее засунете.",
			"Хотите рабыню, которая выдержит всё, что вы творите сзади? У этой дырочка уже растянута и натренирована под любой размер. Никаких жалоб — только чистое наслаждение.",
			"Если вам по душе хорошо раздолбанная задница, то вы по адресу. Эту уже растянули во всех направлениях — идеально для тех, кто любит поиграть пожестче.",
			"Задница этой рабыни повидала всякое. Свободная, зияющая и готовая принять всё, что вы в неё запихнете. Поверьте, {slave.he} будет просить добавки снова и снова.",
			"Давайте не будем ходить вокруг да около — анус {slave.his} широко раскрыт и всегда готов к большему. Он повидал немало, и он более чем готов служить вам так, как вам заблагорассудится.",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Mind, mightChance())

func getTraits() -> Dictionary:
	return {
		"AnusTight": 1.0,
		"AnusLoose": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("AnusTight") && _slaveTraits["AnusTight"] > 0.0):
		return RNG.pick([
			'A tight one, huh? That’s what I like to hear.',
			'Perfect, I’ve been wanting something fresh like that.',
			'Tight? That’s enough to get my interest.',
			'Sounds like the ideal ass for me.',
			'Oh yeah, I will enjoy stretching {slave.her} out.',
			'The things I can do to such a tailhole..',
		])
	if(_slaveTraits.has("AnusLoose") && _slaveTraits["AnusLoose"] > 0.0):
		return RNG.pick([
			'Now that’s what I like to see.',
			'Perfect!',
			'Well-used and no complaints - that’s exactly what I need.',
			'Loose tailhole, huh? That’s perfect for my plans.',
			'This one’s going to get a lot of use!',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("AnusTight") && _slaveTraits["AnusTight"] > 0.0):
		return RNG.pick([
			'Tight? No thanks. Sounds like too much work for too little reward.',
			'Not really what I’m after.',
			'Tight ones are overrated.',
			'Meh, sounds like more of a chore than fun.',
			'I’m not interested in something that’s going to resist me the whole time.',
			'Tight is nice, but I’m looking for something more... accommodating..',
			'What\'s the point if {slave.he} can\'t even take a whole horsecock inside?',
		])
	if(_slaveTraits.has("AnusLoose") && _slaveTraits["AnusLoose"] > 0.0):
		return RNG.pick([
			'Loose asshole? Ugh. That’s not what I’m looking for in a slave.',
			'I’ll pass on this one.',
			'Loose asshole? No.',
			'Doesn’t sound like {slave.he} has any grip left. Not my thing.',
			'An asshole that’s seen so much action? Nah, I’m out.',
		])
	
	return .getNegativeReaction(_char, _slaveTraits)
