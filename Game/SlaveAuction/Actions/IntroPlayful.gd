extends "res://Game/SlaveAuction/Actions/IntroNormal.gd"

func _init():
	id = "IntroPlayful"

func getName() -> String:
	return "Игривое вступление"

func getButtonDesc() -> String:
	return "Start the auction while acting very playful.\n\nReveals 3 random preferences of each bidder that are [b]always[/b] relevant to the slave. But the non-serious tone makes the bidders less likely to bid."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	saynn("Шторы с мягким шорохом раздвигаются, открывая {presenter.name}, который/ая выходит вперед с дерзкой ухмылкой, явно наслаждаясь вниманием публики.")
	
	sayPresenter("Well, well, well, look who we have tonight, here at the Blacktail Market! I hope you're all ready for a little fun, because things are about to get interesting.")
	
	saynn("{presenter.YouHe} {presenter.youHeVerb('give')} игриво подмигивает/ает, указывая на стоящую рядом рабыню/раба. Луч прожектора следует за жестом, мягко освещая {slave.him}, пока {slave.he} нервно щурится/тся и переминается с ноги на ногу.")
	
	sayPresenter("Meet this little toy, someone who has just the right mix of charm, skill, and.. well, let’s just say, you’ll have fun figuring out the rest. Plug-And-Play, you know how it works!")
	
	saynn("В толпе раздается легкий смешок, хотя не все участники аукциона, похоже, впечатлены таким непринужденным тоном. Кто-то откидывается на спинку кресла, а кто-то заинтригован, переводя взгляд с {presenter.name} на рабыню/раба. Вы стараетесь следить за их реакциями и всё фиксируете.")
	
	sayPresenter("The starting bet is "+str(_auction.startingBid)+" credits.")
	
	for _i in range(3):
		_auction.unlockRandomRelevantTraitEachBidder()

func getPassiveDesireGain() -> float:
	return -0.5
