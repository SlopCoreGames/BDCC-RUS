extends "res://Game/SlaveAuction/Actions/IntroNormal.gd"

func _init():
	id = "IntroYFocused"

func getActionType():
	return AuctionActionType.Intro

func getName() -> String:
	return "Уверенное представление"

func getButtonDesc() -> String:
	return "Focus on one of the bidders.\n\nThis action will reveal 75% of all preferences of a single random bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	saynn("Занавес медленно расходится, открывая взору {presenter.name}, которая уверенно стоит на возвышении, а на {presenter.hisHer} губах играет многозначительная улыбка.")

	sayPresenter("Welcome, esteemed guests, to the Blacktail Market! I know many of you are here looking for something.. specific.")

	saynn("Взгляд {presenter.hisHer} скользит по толпе и останавливается на одном конкретном участнике торгов... Связь неоспорима: из-за их непрерывного зрительного контакта остальные участники словно растворяются на заднем плане.")

	sayPresenter("Allow me to introduce our most specially crafted product, someone who I believe will catch your particular interest.")

	saynn("Свет прожектора становится ярче, фокусируясь почти целиком на рабыне. {slave.heShe} стоит во весь рост, и каждый дюйм {slave.hisHer} тела выставлен на критический осмотр выбранного покупателя.")

	saynn("{presenter.name} снова встречается взглядом с тем самым участником, будто делясь с ним секретом. Воздух наполняется напряжением, а предвкушение становится почти осязаемым, когда внимание избранного покупателя приковывается к рабыне, пробуждая в нем жгучее любопытство.")

	saynn("Другие участники переглядываются, но хранят молчание, наблюдая за происходящим, в то время как главный претендент подается вперед, прищурив глаза. Вы стараетесь не упустить ни единой интересной детали.")
	
	sayPresenter("The starting bet is "+str(_auction.startingBid)+" credits.")
	
	_auction.unlockPercentageOfTraitsRandomBidder(0.75, 1.0)

func getPassiveDesireGain() -> float:
	return 0.0
