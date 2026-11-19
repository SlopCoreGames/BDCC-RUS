extends AuctionAction

func _init():
	id = "FetishDrugUse"

func getButtonDesc() -> String:
	return "Упомяните о любви рабыни к определенным веществам.\n\n[b]Возможно[/b] раскроет по одной черте характера каждого участника аукциона."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"У этой рабыни есть одна привычка — она вечно ищет новую дозу. Наркотики? {slave.he} без них просто не может жить.",
		"Наркотики — это {slave.his} слабость, а это значит, что {slave.him} легко контролировать. Обеспечь {slave.him} поставками, и {slave.he} будет подчиняться как никто другой.",
		"Одержимая и жаждущая, {slave.he} не скажет «нет» ни одному веществу, которое ты ей предложишь. Наркотики — вот её истинный господин {slave.his}.",
		"Подсевшая на всё, что только можно вообразить, она практически умоляет о новой дозе. Обеспечь {slave.him} добавкой, и {slave.he} пойдет на всё.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		"С этим можно весело поиграть.",
		"Идеально. Подсажу-ка я этого на свой любимый наркотик.",
		"Эта будет ползать в поисках новой дозы.",
		"Раб-торчок — значит, им легко управлять.",
		"Здесь виден потенциал.",
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		"Ты серьезно пытаешься впарить нам торчка?",
		"Раб-торчок? Фу, мерзость.",
		"Мне больше нравятся покорные рабы, чем обдолбанные.",
	])

func getTraits() -> Dictionary:
	return {
		"FetishDrugUse": 1.0,
	}
