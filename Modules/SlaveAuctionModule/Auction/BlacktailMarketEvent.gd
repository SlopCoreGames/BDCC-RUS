extends EventBase

func _init():
	id = "BlacktailMarketEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "market_intro")
	es.addTrigger(self, Trigger.EnteringRoom, "market_market")
	#es.addTrigger(self, Trigger.EnteringPlayerCell) # Handled in a different scene
	
func run(_triggerID, _args):
	var noMirri = getModule("SlaveAuctionModule").noMirri()
	
	if(noMirri && GM.pc.getLocation() == "market_market"):
		addButton("Продать рабыню", "Начать аукцион!", "soloslavesell")
		if(getFlag("SlaveAuctionModule.upgradeSeePrefs", 0) >= 1):
			addButton("Инфо о ставках", "Проверить предпочтения следующих покупателей", "solobidders")
		addButton("Улучшения", "Улучшить рынок Блэктейл", "soloupgrades")
		
		addButton("Тюремная камера", "Телепортироваться обратно в камеру", "exitsecure")
	
	if(GM.pc.getLocation() == "market_intro"):
		addButton("Тюремная камера", "Телепортироваться обратно в камеру", "exitsecure")
		if(noMirri):
			addButton("Ноутбук", "Использовать ноутбук Мирри для заказа товаров", "mirrilaptop")
	
		if(!noMirri):
			if(getFlag("SlaveAuctionModule.beganAuctionOnce") && !getFlag("SlaveAuctionModule.luxeIntroHap")):
				addDisabledButton("Мирри", "Её здесь нет...")
				
				saynn("Из комнаты в конце коридора доносится громкий гул голосов...")
			else:
				if(!checkCharacterBusy("MirriBusy", "Похоже, кошкодевочки здесь нет", "Mirri")):
					addButton("Мирри", "Поговорить с кошкодевочкой", "mirri")
				
	if(true):
		if(GM.pc.getLocation() == GM.pc.getCellLocation()):
			addButton("Рынок Блэктейл", "Телепортироваться на рынок Блэктейл", "entersecure")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "mirrilaptop"):
		runScene("MirriBuySellScene")
	if(_method == "entersecure"):
		var noMirri = getModule("SlaveAuctionModule").noMirri()
		if(noMirri):
			GM.pc.setLocation("market_market")
		else:
			GM.pc.setLocation("market_intro")
		addMessage("Вы используете свой релей-тег синего пространства, чтобы телепортироваться на рынок Блэктейл.")
		GM.main.reRun()
	if(_method == "mirri"):
		if(!GM.ES.triggerReact(Trigger.TalkingToNPC, ["mirri"])):
			getCharacter("mirri").updateBodyparts()
			runScene("MirriTalkScene")
	if(_method == "exitsecure"):
		GM.pc.setLocation(GM.pc.getCellLocation())
		addMessage("Вы используете телепорт, чтобы вернуться в свою камеру.")
		GM.main.reRun()
	if(_method == "soloslavesell"):
		runScene("SlaveAuctionGenericSellNoMirriScene")
	if(_method == "solobidders"):
		runScene("SlaveAuctionBiddersScene")
	if(_method == "soloupgrades"):
		runScene("SlaveAuctionUpgradesScene")
