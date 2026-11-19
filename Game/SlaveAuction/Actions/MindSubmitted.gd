extends AuctionAction

func _init():
	id = "MindSubmitted"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Подчинилась"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave’s complete submission to the master.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Знаете, что самое приятное? Эта рабыня полностью подчинилась {slave.his} хозяину! Больше ломать её не нужно, {slave.he} будет беспрекословно слушаться.",
		"Знаете, в чём главная фишка? Она полностью сдалась. {slave.He} {slave.isAre} уже предана и верна, она знает своё {slave.his} место у ваших ног.",
		"Полностью сломлена и предана хозяину. Эта рабыня полностью подчинилась, так что с {slave.him} вам не придётся беспокоиться о непослушании.",
		"Эту уже полностью приучили подчиняться {slave.his} владельцу. Никакого сопротивления, только покорность.",
		"Уже обучена, уже подчинена. Эта рабыня — идеальный вариант для тех, кто не хочет тратить время на её «дрессировку».",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"MindSubmitted": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'Perfect, as it should be.',
		'Great, that\'s how every slave should be.',
		'Sounds like someone who already knows how to follow orders.',
		'Neat.',
		'Broken into submission. Perfect.',
		'I like that.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'But breaking them is the most fun part.',
		'Aww, I like breaking slaves though.',
		'What if I wanted to break them myself?',
		'That\'s no fun.',
		'Ehh, that\'s meh.',
		'Making them submit is fun though.',
	])
	
