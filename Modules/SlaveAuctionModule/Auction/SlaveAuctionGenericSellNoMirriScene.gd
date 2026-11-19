extends SceneBase

var slaveID = ""
var creditsToGive = 0

func _init():
	sceneID = "SlaveAuctionGenericSellNoMirriScene"

func resolveCustomCharacterName(_charID):
	if(_charID == "slave"):
		return slaveID

func _run():
	if(state == ""):
		saynn("Какую из своих рабынь ты хочешь продать? Помни, что ты больше никогда её не увидишь. Все вещи, которыми она владеет, тоже будут потеряны навсегда.")

		addButton("Отмена", "Вы передумали", "endthescene")
		addSlaveButtons()
		if (false):
			addButton("Неа", "Этого вообще не должны были видеть", "pick_slave")
	if(state == "confirm_pick_slave"):
		addCharacter(slaveID)
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
		saynn("Ты делаешь выбор и используешь телепорт, чтобы доставить рабыню сюда.")

		addButton("Рынок", "Закрепить рабыню на подиуме", "go_market")
	if(state == "go_market"):
		aimCameraAndSetLocName("market_market")
		saynn("Ты закрепляешь {slave.name}, сковывая {slave.his} запястья вместе и пристегивая цепи, которые заставляют твою рабыню стоять на {slave.his} {slave.toes}.")

		saynn("Гул голосов начинает заполнять пустоту... Участники торгов прибывают.")

		saynn("Ты занимаешь место на подиуме ведущей и готовишься.")

		saynn("[say=pc]"+str(RNG.pick(["Alright. Time to shine.", "Let's get this bread.", "Time to do this.", "No one but me.", "Show time."]) )+"[/say]")

		saynn("Аукцион вот-вот начнется...")

		addButton("Рабский аукцион", "Начать мини-игру", "start_auction_minigame")
	if(state == "failed_to_sell"):
		playAnimation(StageScene.Duo, "stand", {pc="pc", npc=slaveID, npcBodyState={leashedBy="pc"}})
		saynn("Аукцион окончен... но никто так и не решился купить твоего раба...")

		saynn("Ставки сделаны, занавес опускается... возвращается жуткая тишина.")

		saynn("Ты знаешь, что будет дальше, поэтому не вмешиваешься. Ты просто берешь раба на поводок... и передаешь {slave.him} персоналу, который быстро уводит {slave.him} куда-то прочь...")

		saynn("Ты успеваешь в последний раз взглянуть на своего раба, прежде чем стена скрывает {slave.him}...")

		addButton("Продолжить", "Прощай, раб...", "delete_slave")
	if(state == "after_sold"):
		playAnimation(StageScene.Duo, "stand", {pc="pc", npc=slaveID, npcBodyState={leashedBy="pc"}})
		saynn("После успешного аукциона ты снимаешь цепи с запястий раба, а затем передаешь поводок безликим слугам, которые ведут {slave.name} к {slave.his} новому владельцу...")

		saynn("Когда занавес начинает опускаться, ты бросаешь последний взгляд на своего раба.")

		addButton("Продолжить", "Прощай, раб...", "do_sell_slave_succ")
	if(state == "do_sell_slave_succ"):
		playAnimation(StageScene.Duo, "stand", {npc="luxe"})
		addCharacter("luxe")
		saynn("Люкс подходит к тебе и протягивает кредитный чип.")

		saynn("[say=luxe]Вот. Твоя доля.[/say]")

		saynn("Когда ты забираешь его, волк просто разворачивается и уходит к себе в кабинет.")

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

	if(_action == "start_auction_minigame"):
		runScene("SlaveAuctionScene", [slaveID, getModule("SlaveAuctionModule").getAuctionSettings(), "pc"], "slave_auction")
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
	data["creditsToGive"] = creditsToGive

	return data

func loadData(data):
	.loadData(data)

	slaveID = SAVE.loadVar(data, "slaveID", "")
	creditsToGive = SAVE.loadVar(data, "creditsToGive", 0)
