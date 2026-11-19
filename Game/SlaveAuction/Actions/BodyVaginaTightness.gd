extends AuctionAction

func _init():
	id = "BodyVaginaTightness"

func getActionType():
	return AuctionActionType.Body

func getName() -> String:
	return "Узость киски"

func getButtonDesc() -> String:
	return "Highlight the slave's pussy.\n\n[b]Might[/b] reveal 1 mind preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("VaginaTight") && _slaveTraits["VaginaTight"] > 0.0):
		sayPresenter(RNG.pick([
			"Так, я знаю, вы все облизываетесь на это идеальное тело, но позвольте мне обратить ваше внимание на {slave.his} промежность! Видите эту киску? Она сжата, словно тиски, и её ещё не слишком сильно заездили. Поверьте мне, такой больше не найдёте.",
			"Если вы ищете киску, ради которой придётся попотеть, то вы смотрите прямо на неё. У этой рабыни там невероятно узко, обещаю, ощущения будут незабываемыми.",
			"Рассматривайте хорошенько, но насчёт тесноты вам придётся мне поверить — сжаты ноги или нет, эта девка ещё не изношена. Хватка будет такая, что не захочется отпускать.",
			"Некоторым из вас по душе вызов, и эта штучка его обеспечит. {slave.His} тугая киска будет давать ощущение, будто вы каждый раз открываете новые земли.",
			"Вы же практически видите, насколько {slave.his} киска узкая, верно? Поверьте, стоит вам войти, вы не захотите выходить.",
			"Эта — самая тугая из всех, редкая находка для аукциона. Вы нигде больше не встретите такую первозданную маленькую киску!",
		]))
	if(_slaveTraits.has("VaginaLoose") && _slaveTraits["VaginaLoose"] > 0.0):
		sayPresenter(RNG.pick([
			"А теперь обратите внимание на {slave.his} промежность. Эта киска уже повидала настоящую жару. Она эластичная, натренированная и знает толк в том, как принимать всё, что вы в неё засунете!",
			"Хочешь рабыню, которая точно знает свое дело? Потому что киска {slave.his} растянута до совершенства — какого бы размера ни был твой член, она готова к большему. Раскрытая, манящая и жаждущая.",
			"Кстати, с этой штучкой? Можно не сдерживаться. Заходи так глубоко и грубо, как пожелаешь — эта растянутая киска будет только умолять о добавке.",
			"Не дай сомкнутым ножкам обмануть тебя — поверь, эта рабыня знает толк в удовольствиях. Киска расслабленная, но при этом невероятно отзывчивая и сжимается в нужные моменты так, что ты будешь в восторге от того, как она тебя принимает.",
			"Опытная, хорошо растянутая и очень податливая. Эта киска не будет капризничать. Тебе не придется беспокоиться о том, что ты слишком груб или слишком велик.",
			"Если тебе нравятся киски с богатым опытом, ты нашел идеальную рабыню. Растянутая, открытая и всегда готовая к новому раунду.",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Mind, mightChance())

func getTraits() -> Dictionary:
	return {
		"VaginaTight": 1.0,
		"VaginaLoose": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("VaginaTight") && _slaveTraits["VaginaTight"] > 0.0):
		return RNG.pick([
			'A tight one, huh? That’s what I like to hear.',
			'Perfect, I’ve been wanting something fresh like that.',
			'Tight? That’s enough to get my interest.',
			'Sounds like the ideal pussy for me.',
			'Oh yeah, I will enjoy stretching {slave.her} out.',
			'The things I can do to such a pussy..',
		])
	if(_slaveTraits.has("VaginaLoose") && _slaveTraits["VaginaLoose"] > 0.0):
		return RNG.pick([
			'Now that’s what I like to see.',
			'Perfect!',
			'Well-used and no complaints - that’s exactly what I need.',
			'Loose cunt, huh? That’s perfect for my plans.',
			'This one’s going to get a lot of use!',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("VaginaTight") && _slaveTraits["VaginaTight"] > 0.0):
		return RNG.pick([
			'Tight? No thanks. Sounds like too much work for too little reward.',
			'Not really what I’m after.',
			'Tight ones are overrated.',
			'Meh, sounds like more of a chore than fun.',
			'I’m not interested in something that’s going to resist me the whole time.',
			'Tight is nice, but I’m looking for something more... accommodating..',
			'What\'s the point if {slave.he} can\'t even take a whole horsecock inside?',
		])
	if(_slaveTraits.has("VaginaLoose") && _slaveTraits["VaginaLoose"] > 0.0):
		return RNG.pick([
			'Loose cunt? Ugh. That’s not what I’m looking for in a slave.',
			'I’ll pass on this one.',
			'Loose pussy? No.',
			'Doesn’t sound like {slave.he} has any grip left. Not my thing.',
			'A pussy that’s seen so much action? Nah, I’m out.',
		])
	
	return .getNegativeReaction(_char, _slaveTraits)
