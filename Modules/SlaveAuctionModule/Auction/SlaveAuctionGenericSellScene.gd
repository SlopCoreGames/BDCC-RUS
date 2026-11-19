extends SceneBase

var slaveID = ""
var hasMirri = true
var creditsToGive = 0

func _init():
	sceneID = "SlaveAuctionGenericSellScene"

func resolveCustomCharacterName(_charID):
	if(_charID == "slave"):
		return slaveID

func _run():
	if(state == ""):
		addCharacter("mirri")
		saynn("Какую из своих рабынь ты хочешь продать? Помни, что ты больше никогда её не увидишь. Все вещи, которыми она владеет, тоже будут потеряны навсегда.")

		addButton("Отмена", "Вы передумали", "endthescene")
		addSlaveButtons()
		if (false):
			addButton("Неа", "Этого вообще не должны были видеть", "pick_slave")
	if(state == "confirm_pick_slave"):
		removeCharacter("mirri")
		addCharacter(slaveID)
		addCharacter("mirri")
		playAnimation(StageScene.Duo, "stand", {npc=slaveID, npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
		saynn("Ты действительно хочешь продать {slave.name}? Помни, что ты больше никогда её не увидишь. Все вещи, которыми она владеет, тоже будут потеряны навсегда.")

		printSlaveTraits()
		if (getFlag("SlaveAuctionModule.upgradeSeePrefs", 0) >= 1):
			saynn("У участников торгов будут следующие предпочтения:")

			saynn(""+str(getModule("SlaveAuctionModule").getBidderInfo())+"")

		addButton("Подтвердить", "Продать эту рабыню!", "do_confirm_pick")
		addButton("Отмена", "Вы передумали", "do_cancel_pick")
	if(state == "do_confirm_pick"):
		playAnimation(StageScene.Duo, "stand", {npc=slaveID, npcBodyState={leashedBy="pc"}})
		if (!getFlag("SlaveAuctionModule.beganAuctionOnce")):
			saynn("Вы делаете свой выбор.")

			saynn("[say=mirri]Я притащу {slave.him}, не переживай.[/say]")

			saynn("[say=pc]Ты такой милый.[/say]")

			saynn("[say=mirri]Оу, спасибо! Обожаю, когда ты так говоришь.[/say]")

			saynn("Мирри исчезает в синем разломе... а затем стремительно выпрыгивает обратно, держа в руке поводок, прикрепленный к ошейнику вашего раба. Она протягивает поводок вам.")

			saynn("[say=mirri]Чем больше кредитов я заработаю, тем выше будет моя репутация работорговца. А это именно то, чего хотим и ты, и я.[/say]")

			saynn("Продавай рабов, повышай репутацию...")

			saynn("[say=mirri]Так что за дело![/say]")

		else:
			saynn("Вы делаете свой выбор. Мирри кивает и использует свой телепорт, чтобы быстро доставить вам раба.")

			saynn("[say=mirri]Давай сделаем это![/say]")

		addButton("Рынок", "Закрепить рабыню на подиуме", "go_market")
	if(state == "go_market"):
		aimCameraAndSetLocName("market_market")
		saynn("Вы приводите {slave.name} на рынок и закрепляете {slave.him}, сковывая запястья {slave.his} цепями, которые заставляют вашу рабыню стоять на {slave.his} {slave.toes}.")

		saynn("Гул голосов начинает заполнять пустоту... Вы надеваете гарнитуру и занимаете позицию.")

		saynn("[say=pc]Забираешь меня?[/say]")

		saynn("[say=mirri]Принято, пять из пяти.[/say]")

		saynn("Мирри тоже занимает место на подиуме ведущей и готовится.")

		saynn("[say=mirri]"+str(RNG.pick(["Alright. Time to shine.", "Let's get this bread.", "Time to do this.", "No one but us.", "Teamwork makes the dream work."]) )+"[/say]")

		saynn("Аукцион вот-вот начнется...")

		addButton("Рабский аукцион", "Начать мини-игру", "start_auction_minigame")
	if(state == "failed_to_sell"):
		playAnimation(StageScene.Duo, "stand", {pc="mirri", npc=slaveID, npcBodyState={leashedBy="mirri"}})
		if (!getFlag("SlaveAuctionModule.failedAuctionOnce")):
			saynn("Аукцион окончен... но никто так и не решился купить твоего раба...")

			saynn("Ставки сделаны, занавес опускается... возвращается жуткая тишина.")

			saynn("Вы видите, как Мирри отцепляет цепь и надевает на вашу рабыню поводок... а затем просто разворачивается, чтобы куда-то уйти. Чего?!")

			saynn("Вы бросаетесь к ней.")

			saynn("[say=pc]Эй, ты куда это тащишь {slave.him}?[/say]")

			saynn("[say=mirri]Ну, ты так отстойно ведешь торги, что {slave.him} никто не купил.[/say]")

			saynn("Вы преграждаете ей путь.")

			saynn("[say=pc]Но куда ты ведешь {slave.him} сейчас?[/say]")

			saynn("Мирри склоняет голову набок.")

			saynn("[say=mirri]С тех пор как это случилось в последний раз, мы нашли... скажем так... новый способ использования рабов~.[/say]")

			saynn("[say=pc]Какой способ? Что вы собираетесь делать?[/say]")

			saynn("[say=mirri]Теперь это не твоя забота, {pc.name}, расслабься.[/say]")

			saynn("Звучит весьма тревожно...")

			saynn("[say=mirri]Послушай, очевидно, что я не могу позволить тебе вернуть эту рабыню в твою тупую тюрьму, {slave.he} слишком много знает об этом месте.[/say]")

			saynn("Мирри нежно чешет {slave.name} под подбородком.")

			saynn("[say=mirri]Так что... это лучший из оставшихся вариантов. Тебе, очевидно, не заплатят, раз уж ты... так феерично провалился... зато мне достанется как минимум сотня кредитов~.[/say]")

			saynn("Все это звучит так... неправильно. Но чем больше ты преграждаешь ей путь, тем настойчивее Мирри тянется к своему пистолету.")

			saynn("[say=mirri]Какой именно части моего объяснения ты не понял?[/say]")

			saynn("[say=pc]Ладно. Но что будет с {slave.him}?[/say]")

			saynn("Ты делаешь шаг в сторону... Мирри проходит мимо тебя, держа поводок твоего раба.")

			saynn("[say=mirri]Охх... Тебе лучше не знать.[/say]")

			saynn("Когда Мирри выходит из комнаты... ты успеваешь в последний раз взглянуть на своего раба, прежде чем стена скрывает {slave.him}...")

		else:
			saynn("Аукцион окончен... но никто так и не решился купить твоего раба...")

			saynn("Ставки сделаны, занавес опускается... возвращается жуткая тишина.")

			saynn("Ты знаешь, что произойдет, поэтому не вмешиваешься. Ты просто позволяешь Мирри надеть поводок на твоего раба... и увести {slave.him}...")

			saynn("Когда Мирри выходит из комнаты... ты успеваешь в последний раз взглянуть на своего раба, прежде чем стена скрывает {slave.him}...")

		addButton("Продолжить", "Прощай, раб...", "delete_slave")
	if(state == "after_sold"):
		playAnimation(StageScene.Duo, "stand", {pc="mirri", npc=slaveID, npcBodyState={leashedBy="mirri"}})
		saynn("После успешного аукциона Мирри освобождает запястья раба от цепей, а затем передает поводок нескольким безликим слугам, которые уводят {slave.name} к {slave.his} новому владельцу...")

		saynn("Когда занавес начинает опускаться, ты бросаешь последний взгляд на своего раба.")

		addButton("Продолжить", "Прощай, раб...", "do_sell_slave_succ")
	if(state == "do_sell_slave_succ"):
		playAnimation(StageScene.Duo, "stand", {npc="mirri"})
		saynn("Мирри подходит к тебе и протягивает кредитный чип.")

		saynn("[say=mirri]"+str(RNG.pick(["Here is your cut, big {pc.girl}.", "Your cut, pretty {pc.girl}.", "Your "+str(getModule("SlaveAuctionModule").getPCCut()*100)+"%, tough {pc.girl}.", "Please doing business, big {pc.girl}."]))+"[/say]")

		saynn("Взяв его, кошкодевочка просто уходит обратно в свою комнату.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addSlaveButtons():
	var slaves = GM.main.getDynamicCharacterIDsFromPool(CharacterPool.Slaves)
	for charID in slaves:
		var character:DynamicCharacter = getCharacter(charID)
		var npcSlavery:NpcSlave = character.getNpcSlavery()
		if(npcSlavery == null):
			continue
		if(npcSlavery.isDoingActivity()):
			addDisabledButton(character.getName(), "Эта рабыня сейчас занята")
			continue
		addButton(character.getName(), character.getSmallDescription(), "pick_slave", [charID])

func printSlaveTraits():
	sayn("{slave.name} черты:")
	var slaveTraits = SlaveAuction.calculateSlaveTraitsStatic(getCharacter(slaveID))
	for traitID in slaveTraits:
		var score:float = slaveTraits[traitID]
		var trait:AuctionTrait = GlobalRegistry.getAuctionTrait(traitID)
		if(score > 0.0):
			var theName:String = trait.getName(traitID)
			sayn("- "+theName+": "+str(Util.roundF(score*100.0, 1))+"%")
	sayn("")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "pick_slave"):
		slaveID = _args[0]
		setState("confirm_pick_slave")
		return

	if(_action == "do_confirm_pick"):
		processTime(5*60)

	if(_action == "do_cancel_pick"):
		removeCharacter(slaveID)
		slaveID = ""
		setState("")
		return

	if(_action == "go_market"):
		processTime(5*60)
		setFlag("SlaveAuctionModule.beganAuctionOnce", true)

	if(_action == "start_auction_minigame"):
		runScene("SlaveAuctionScene", [slaveID, getModule("SlaveAuctionModule").getAuctionSettings()], "slave_auction")
		return

	if(_action == "delete_slave"):
		setFlag("SlaveAuctionModule.failedAuctionOnce", true)
		removeCharacter(slaveID)
		getModule("SlaveAuctionModule").sellToAuction(slaveID)
		getModule("SlaveAuctionModule").addRepCredits(100)
		endScene()
		return

	if(_action == "do_sell_slave_succ"):
		removeCharacter(slaveID)
		getModule("SlaveAuctionModule").sellToSlavery(slaveID)
		GM.pc.addCredits(creditsToGive)
		addMessage("You received "+str(creditsToGive)+" credits.")

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "slave_auction"):
		processTime(2 * 60)
		var wasSold = _result[0]["wasSold"] if (_result.size() > 0 && _result[0].has("wasSold")) else true
		
		if(wasSold):
			var creditsAmount:int = _result[0]["winningBid"]
			getModule("SlaveAuctionModule").addRepCredits(creditsAmount)
			var pcNewCredits:int = int(round(float(creditsAmount) * getModule("SlaveAuctionModule").getPCCut()))
			creditsToGive = pcNewCredits
			if(getModule("SlaveAuctionModule").isReadyToAdvanceRepLevel()):
				addMessage("You are ready to advance your and Mirri's slaver reputation level. Talk with her when you are ready.")
			getModule("SlaveAuctionModule").onSlaveSold(getCharacter(slaveID), creditsAmount)
			setState("after_sold")
		
		else:
			setState("failed_to_sell")

func saveData():
	var data = .saveData()

	data["slaveID"] = slaveID
	data["hasMirri"] = hasMirri
	data["creditsToGive"] = creditsToGive

	return data

func loadData(data):
	.loadData(data)

	slaveID = SAVE.loadVar(data, "slaveID", "")
	hasMirri = SAVE.loadVar(data, "hasMirri", true)
	creditsToGive = SAVE.loadVar(data, "creditsToGive", 0)
