extends AuctionAction

func _init():
	id = "FetishExhibitionism"

func getButtonDesc() -> String:
	return "Раскройте страсть рабыни к наготе.\n\n[b]Возможно[/b] раскроет по одной черте характера каждого участника аукциона."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Эта? Она просто обожает быть на виду. Чем больше глаз устремлено на {slave.him}, тем сильнее {slave.he} жаждет внимания. Идеально подходит для публичных выступлений.",
		"Эксгибиционизм у {slave.him} в крови. Раздень {slave.him}, выставь {slave.him} перед толпой, и {slave.he} не только не смутится — {slave.he} будет умолять о добавке.",
		"Тебе никогда не придется беспокоиться о том, что эта девчонка засмущается. {slave.He} расцветает под взглядами, выставляя напоказ свое тело и жадно впитывая всё внимание.",
		"Свет софитов, толпа зрителей — эта рабыня живет ради этого. Тело {slave.His} отзывается на каждый взгляд, жадно впитывая внимание публики.",
		"Эта создана для того, чтобы выставлять напоказ {slave.his} {slave.masc} тело! Выставь {slave.him} на всеобщее обозрение, и {slave.he} будет отыгрывать лучше, чем ты можешь себе представить.",
		"Ни стыда, ни страха — только чистый восторг от того, что на нее смотрят. {slave.He} рождена быть эксгибиционисткой.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		"Артистка, значит? Я всегда за хорошее шоу!",
		"Я хочу видеть {slave.him} на своей сцене.",
		"Публичное раздевание — мой любимый кинк.",
		"Идеально, чтобы развлечь гостей.",
		"У меня на эту штучку большие планы.",
	])

func getTraits() -> Dictionary:
	return {
		"FetishExhibitionism": 1.0,
	}
