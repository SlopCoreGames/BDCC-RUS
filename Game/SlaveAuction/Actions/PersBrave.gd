extends AuctionAction

func _init():
	id = "PersBrave"

func getActionType():
	return AuctionActionType.Personality

func getName() -> String:
	return "Храбрая"

func getButtonDesc() -> String:
	return "Расскажите участникам аукциона о храбрости рабыни.\n\n[b]Возможно[/b] раскроет по одному фетишу каждого участника."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"{slave.He} держится гордо, даже в цепях. Такая храбрость, как у {slave.hisHer}, — редкость среди рабов.",
		"У этой штучки есть стержень, даже перед лицом подчинения. Такая смелость делает слугу по-настоящему сильным.",
		"{slave.HeShe} не отступит перед трудностями. Храбрые рабы вроде {slave.him} вынесут всё ради своего хозяина.",
		"Храбрость — редкое качество для раба. {slave.He} будет держать {slave.hisHer} голову высоко, в какой бы ситуации ни оказалась.",
		"Если вы ищете кого-то волевого, но при этом послушного, то храбрость {slave.his} делает {slave.himHer} отличным выбором.",
		"Даже подчиняясь, {slave.he} не выказывает страха. Это мужество вам еще пригодится.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Fetish, mightChance())

func getTraits() -> Dictionary:
	return {
		"PersBrave": 1.0,
	}
