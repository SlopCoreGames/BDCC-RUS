extends AuctionAction

func _init():
	id = "FetishSexBottom"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave's love of getting fucked.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"У {slave.He} рот, который знает, как угождать во всех смыслах!",
		"Посмотрите на эту штучку, она жаждет любого внимания. Идеальная игрушка для любого, кто знает, как распорядиться {slave.him}.",
		"Эта секс-игрушка живет лишь для того, чтобы её наполняли. Каждое её отверстие так и молит о твоей команде.",
		"Хотите питомца, который не мечтает ни о чем, кроме как быть оттраханным? Вот она — та, кто никогда не скажет «нет».",
		"По тому, как двигается {slave.he}, сразу видно, что {slave.he} живет ради удовольствия. Ради твоего удовольствия, а не {slave.his}.",
		"{slave.He} нужно присвоить, и поверьте, нет ничего, что {slave.he} любила бы больше, чем когда её ставят раком.",
		"Покорная и готовая ко всему, эта секс-кукла станет идеальным дополнением к коллекции любого заводчика.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'Perfect for my tastes.',
		'Just the kind I need.',
		'Can’t wait to use {slave.him}.',
		'Ready for a good time.',
		'Ideal for my playroom.',
		'I will enjoy breeding {slave.him}.',
		'I will enjoy using {slave.him}.',
		'I will enjoy fucking {slave.him} raw.',
	])

func getTraits() -> Dictionary:
	return {
		"FetishSexBottom": 1.0,
	}
