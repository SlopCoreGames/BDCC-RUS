extends AuctionAction

func _init():
	id = "PersNaive"

func getActionType():
	return AuctionActionType.Personality

func getName() -> String:
	return "Наивная/Проницательная"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave's naive/perceptive personality.\n\n[b]Might[/b] reveal 1 fetish preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("PersNaive") && _slaveTraits["PersNaive"] > 0.0):
		sayPresenter(RNG.pick([
			"{slave.He} {slave.isAre} — само воплощение невинности. Совершенно наивная и ничего не подозревающая о превратностях мира. Звучит весело, не так ли?",
			"Эта крошка так сладко не ведает о том, что её ждёт. Только представьте, какое удовольствие вы получите, обучая {slave.himHer}.",
			"Чистая, не тронутая жестокостью мира... {slave.he} всё ещё верит в доброту. Звучит весело, не так ли?",
			"Наивность {slave.His} делает {slave.himHer} такой податливой. При должном подходе вы сможете вылепить из {slave.himHer} всё, что пожелаете.",
			"Эта особа едва понимает, что происходит. Чистый холст, ждущий наставлений господина.",
			"Наивная и доверчивая — {slave.he} будет следовать любому приказу без вопросов. Настоящая мечта хозяина.",
		]))
	if(_slaveTraits.has("PersPerceptive") && _slaveTraits["PersPerceptive"] > 0.0):
		sayPresenter(RNG.pick([
			"Не дайте {slave.his} обмануть вас цепями... Эта особа остра на язык, проницательна и всегда наблюдает.",
			"Умная и быстро схватывающая на лету, {slave.he} будет точно знать, чего от неё ждут... и {slave.he} всё исполнит.",
			"{slave.HeShe} {slave.isAre} — не просто тупая рабыня, у этой особы ум острый, как лезвие. Идеально подходит для сложных задач.",
			"Если вам нужен раб с мозгами, вы её нашли. {slave.He} соображает быстрее большинства.",
			"{slave.HeShe} видит всё. Такой проницательный ум, как у {slave.hisHer}, может быть полезен во многих вещах.",
			"Находчивая и проницательная. {slave.He} облегчит вам жизнь благодаря своей {slave.hisHer} интеллекту.",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Fetish, mightChance())

func getTraits() -> Dictionary:
	return {
		"PersNaive": 1.0,
		"PersPerceptive": 1.0,
	}
