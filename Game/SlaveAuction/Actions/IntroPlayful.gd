extends "res://Game/SlaveAuction/Actions/IntroNormal.gd"

func _init():
	id = "IntroPlayful"

func getName() -> String:
	return "Игривое вступление"

func getButtonDesc() -> String:
	return "Start the auction while acting very playful.\n\nReveals 3 random preferences of each bidder that are [b]always[/b] relevant to the slave. But the non-serious tone makes the bidders less likely to bid."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	saynn("Шторы с мягким шорохом раздвигаются, открывая {presenter.name}, который/ая выходит вперед с дерзкой ухмылкой, явно наслаждаясь вниманием публики.")
	
	sayPresenter("Ну надо же, посмотрите, кто у нас сегодня на рынке Блэктейл! Надеюсь, вы все готовы немного развлечься, потому что сейчас станет по-настоящему интересно.")
	
	saynn("{presenter.YouHe} {presenter.youHeVerb('give')} игриво подмигивает/ает, указывая на стоящую рядом рабыню/раба. Луч прожектора следует за жестом, мягко освещая {slave.him}, пока {slave.he} нервно щурится/тся и переминается с ноги на ногу.")
	
	sayPresenter("Познакомьтесь с этой игрушкой. В ней есть всё, что нужно: обаяние, навыки и... ну, скажем так, вам будет весело разгадывать остальное. Включил и играй, сами знаете, как это работает!")
	
	saynn("В толпе раздается легкий смешок, хотя не все участники аукциона, похоже, впечатлены таким непринужденным тоном. Кто-то откидывается на спинку кресла, а кто-то заинтригован, переводя взгляд с {presenter.name} на рабыню/раба. Вы стараетесь следить за их реакциями и всё фиксируете.")
	
	sayPresenter("Начальная ставка составляет "+str(_auction.startingBid)+" credits.")
	
	for _i in range(3):
		_auction.unlockRandomRelevantTraitEachBidder()

func getPassiveDesireGain() -> float:
	return -0.5
