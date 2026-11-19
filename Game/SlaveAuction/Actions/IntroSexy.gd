extends "res://Game/SlaveAuction/Actions/IntroNormal.gd"

func _init():
	id = "IntroSexy"

func getName() -> String:
	return "Сексуальное представление"

func getButtonDesc() -> String:
	return "Начинайте аукцион, ведя себя крайне соблазнительно.\n\nРаскрывает по 2 телесных предпочтения у каждого участника и заставляет их жаждать торгов с самого начала."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	saynn("В комнате гаснет свет, шторы раздвигаются, и {presenter.name} выходит в свет прожектора с соблазнительной улыбкой. {presenter.She} проводит рукой по всему телу раба, следя за тем, чтобы все взгляды были прикованы к {slave.his}, пока {presenter.you} {presenter.youVerb('speak')} томным, манящим голосом.")
	
	sayPresenter("Добро пожаловать на рынок Блэктейл! Вижу, вы все заждались чего-то особенного сегодня вечером. Позвольте представить вам это лакомство — великолепный экземпляр, который воплотит в жизнь ваши самые смелые фантазии. Но помните: {slave.him} достанется только тому, кто предложит самую высокую цену.")
	
	saynn("Участники аукциона ерзают в своих креслах, не сводя глаз с раба. Напряжение в зале растет, и вы уже кожей чувствуете нарастающее возбуждение.")
	
	saynn("В этот момент вы пытаетесь определить, какие именно части тела раба привлекают участников больше всего.")

	sayPresenter("Начальная ставка составляет "+str(_auction.startingBid)+" credits.")

	for _i in range(2):
		_auction.unlockRandomTraitOfTypeEachBidder(AuctionTraitType.Body)

func getPassiveDesireGain() -> float:
	return 1.0
