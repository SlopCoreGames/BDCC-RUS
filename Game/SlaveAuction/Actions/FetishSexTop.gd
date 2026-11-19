extends AuctionAction

func _init():
	id = "FetishSexTop"

func getButtonDesc() -> String:
	return "Расскажите участникам аукциона о навыках рабыни в роли «топа».\n\n[b]Возможно[/b] раскроет по одной черте характера каждого участника."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Захотелось доминантной парочки? Эта рабыня обожает брать контроль в самых изысканных формах. Поверь мне, {slave.he} {slave.isAre} чертовски хороша в трахе!",
		"Хочешь игрушку, которая выжмет из тебя все соки? Эта заставит тебя умолять о добавке.",
		"Настоящий хищник в постели; она живет охотой, жаждя довести {slave.his} хозяев до самого взрывного оргазма.",
		"Эта рабыня просто расцветает, когда доминирует, и поверь мне, {slave.he} точно знает, как заставить других сдаться на милость наслаждения.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"FetishSexTop": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'С ними будет весело поработать.',
		'Как раз то, что мне нужно.',
		'Сильные и напористые.',
		'Идеальный топ!',
		'С ними будет вполне сносно.',
	])
