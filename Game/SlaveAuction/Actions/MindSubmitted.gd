extends AuctionAction

func _init():
	id = "MindSubmitted"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Подчинилась"

func getButtonDesc() -> String:
	return "Расскажите участникам аукциона о полной покорности рабыни хозяину.\n\n[b]Возможно[/b] раскроет одну особенность характера каждого участника."

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
		'Идеально, именно так всё и должно быть.',
		'Отлично, именно такими и должны быть все рабы.',
		'Похоже на того, кто уже умеет беспрекословно подчиняться.',
		'Neat.',
		'Сломлены и покорены. Идеально.',
		'Мне нравится.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'Но самое веселое — это процесс их поломки.',
		'Ох, а мне нравится ломать рабов.',
		'А что, если я захочу сломать их сам?',
		'Это совсем не весело.',
		'Ehh, that\'s meh.',
		'Но заставлять их подчиняться — это чертовски весело.',
	])
	
