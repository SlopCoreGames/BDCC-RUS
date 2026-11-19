extends SceneBase

func _init():
	sceneID = "SlaveAuctionUpgradesScene"

func _run():
	if(state == ""):
		saynn("Что хочешь улучшить?")
		
		var theUpgrades = getModule("SlaveAuctionModule").getUpgrades()
		
		for upgradeID in theUpgrades:
			var upgradeInfo = theUpgrades[upgradeID]
			var maxLevel:int = getModule("SlaveAuctionModule").getMaxUpgradeLevel(upgradeID)
			var curLevel:int = getFlag("SlaveAuctionModule."+upgradeID, 0)
			var canBuy = getModule("SlaveAuctionModule").canBuyUpgrade(upgradeID)
			
			
			sayn("Улучшение: "+upgradeInfo["name"])
			sayn("Описание: "+upgradeInfo["desc"])
			sayn("Уровень улучшения: "+str(curLevel)+"/"+str(maxLevel))
			if(curLevel >= 1):
				sayn("Текущий уровень: "+upgradeInfo["descs"][curLevel-1])
			if(curLevel < maxLevel):
				var thePrice:int = upgradeInfo["prices"][curLevel]
				sayn("Следующий уровень: "+upgradeInfo["descs"][curLevel])
				sayn("Цена: "+str(thePrice)+" credits")
				if(curLevel > 0):
					if(!canBuy):
						sayn("[color=red]Условие разблокировки[/color]: "+upgradeInfo["conds"][curLevel-1]+"")
					else:
						sayn("[color=green]Условие разблокировки (ВЫПОЛНЕНО)[/color]: "+upgradeInfo["conds"][curLevel-1]+"")
			
				if(canBuy):
					addButtonWithChecks(upgradeInfo["name"], "Купить это улучшение за "+str(thePrice)+" credits", "buy_upgrade", [upgradeID, upgradeInfo], [[ButtonChecks.HasCredits, thePrice]])
				else:
					addDisabledButton(upgradeInfo["name"], "Нельзя купить это улучшение")
			
			sayn("")

		addButton("Закрыть", "Хватит улучшений", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "buy_upgrade"):
		var upgradeID = _args[0]
		var upgradeInfo = _args[1]
		var curLevel:int = getFlag("SlaveAuctionModule."+upgradeID, 0)
		var credsToRemove:int = upgradeInfo["prices"][curLevel]
		GM.pc.addCredits(-credsToRemove)
		
		getModule("SlaveAuctionModule").doBuyUpgrade(upgradeID)
		addMessage("Улучшение куплено!")
		return

	setState(_action)

func getDebugActions():
	return [
	{
		"id": "unlockAll",
		"name": "Выполнить требования",
		"args": [
		],
	},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "unlockAll"):
		for upgradeID in getModule("SlaveAuctionModule").getUpgrades():
			getModule("SlaveAuctionModule").unlockUpgrade(upgradeID)
		
