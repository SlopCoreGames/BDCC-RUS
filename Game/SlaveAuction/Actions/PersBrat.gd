extends AuctionAction

func _init():
	id = "PersBrat"

func getActionType():
	return AuctionActionType.Personality

func getName() -> String:
	return "Дерзкая"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave's bratty nature.\n\n[b]Might[/b] reveal 1 fetish preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"{slave.He} {slave.isAre} — из тех, кто обожает переходить границы. Настоящая братки, полная дразнилок и игривого непослушания.",
		"{slave.He} {slave.isAre} — такая капризная штучка, что {slave.he} не даст тебе расслабиться. Но ведь весь кайф именно в этом вызове, верно?",
		"{slave.He} {slave.isAre} — та еще дрянь. С {slave.himHer} тебя ждет игра в неповиновение и подчинение. Суть в том, чтобы дразнить твой контроль.",
		"{slave.He} {slave.isAre} — игривая проказница с характером, который не даст тебе заскучать. Но правильная рука вполне может укротить {slave.himHer}.",
		"Кто же не любит легкое сопротивление? {slave.He} точно знает, на какие кнопки нажимать, чтобы ты заставил {slave.him} понервничать. Настоящая братки.",
		"Послушная, когда всё идет не по плану, но в глазах {slave.hisHer} всегда пляшут чертики. Охота за {slave.himHer} принесет тебе истинное удовольствие.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Fetish, mightChance())

func getTraits() -> Dictionary:
	return {
		"PersBrat": 1.0,
	}
