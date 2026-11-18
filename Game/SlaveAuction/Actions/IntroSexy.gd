extends "res://Game/SlaveAuction/Actions/IntroNormal.gd"

func _init():
	id = "IntroSexy"

func getName() -> String:
	return "Сексуальное представление"

func getButtonDesc() -> String:
	return "Start the auction while acting very seductive.\n\nReveals 2 body-related preferences from each bidder and makes them eager to bid early."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	saynn("В комнате гаснет свет, шторы раздвигаются, и {presenter.name} выходит в свет прожектора с соблазнительной улыбкой. {presenter.She} проводит рукой по всему телу раба, следя за тем, чтобы все взгляды были прикованы к {slave.his}, пока {presenter.you} {presenter.youVerb('speak')} томным, манящим голосом.")
	
	sayPresenter("Welcome to the Blacktail Market! I see you're all ready for something special tonight. Allow me to introduce you to this treat - a fine specimen that will fulfill your wildest fantasies. But remember, only the highest bidder will claim {slave.him}.")
	
	saynn("Участники аукциона ерзают в своих креслах, не сводя глаз с раба. Напряжение в зале растет, и вы уже кожей чувствуете нарастающее возбуждение.")
	
	saynn("В этот момент вы пытаетесь определить, какие именно части тела раба привлекают участников больше всего.")

	sayPresenter("The starting bet is "+str(_auction.startingBid)+" credits.")

	for _i in range(2):
		_auction.unlockRandomTraitOfTypeEachBidder(AuctionTraitType.Body)

func getPassiveDesireGain() -> float:
	return 1.0
