extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false
var breastPumpID = ""
var penisPumpID = ""
var sybian = false
var breastMilking = false
var penisMilking = false
var isLact = false
var seedCollected = 0.0
var milkCollected = 0.0
var seedTotal = 0.0
var milkTotal = 0.0
var beganLactating = false
var announcedLact = false
var hadOrgasm = false

func _init():
	sceneID = "articaMilkingInCellScene"

func _run():
	if(state == ""):
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		saynn("Как именно ты хочешь подоить Артику?")

		if (breastPumpID != "" && penisPumpID != ""):
			saynn("Ты будешь использовать одновременно и молокоотсос, и пенис-памп!")

		elif (breastPumpID != ""):
			saynn("Ты будешь использовать молокоотсос!")

		elif (penisPumpID != ""):
			saynn("Ты будешь использовать пенис-памп!")

		if (sybian):
			saynn("Артика будет скакать на сибиане во время дойки!")

		if (breastPumpID != "" || penisPumpID != ""):
			addButton("Старт", "Начать дойку", "prepare_milking")
		else:
			addDisabledButton("Старт", "Нужно выбрать либо молокоотсос, либо пенис-памп")
		addButton("CANCEL", "Вы передумали", "endthescene")
		addButtonWithChecks("Молокоотсос", "Выберите, какой молокоотсос использовать на Артике", "pick_breastpump", [], [[ButtonChecks.HasBreastPump]])
		if (!isCaged):
			addButtonWithChecks("Помпа для пениса", "Выберите, какой пенис-памп использовать на Артике", "pick_penispump", [], [[ButtonChecks.HasPenisPump]])
		else:
			addDisabledButton("Помпа для пениса", "Нельзя надеть на Артику пенис-помпу, если её член в клетке!")
		if (getFlag("NpcSlaveryModule.hasSybian")):
			addButton("Сибиан", "Включить/выключить использование сибиан-машины в сцене", "toggle_sybian")
		else:
			addDisabledButton("Сибиан", "В вашей камере не установлена сибиан-машина")
	if(state == "pick_breastpump"):
		saynn("Выберите, какой молокоотсос будет использоваться во время сцены.")

		addButton("Нет", "Никакой молокоотсос использоваться не будет", "do_pick_nobreastpump")
		addPumpButtons("do_pick_breastpump")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_pick_breastpump")
	if(state == "pick_penispump"):
		saynn("Выберите, какая пенис-помпа будет использоваться во время сцены.")

		addButton("Нет", "Никакая помпа использоваться не будет", "do_pick_nopenispump")
		addPenisPumpButtons("do_pick_penispump")
		if (false):
			addButton("Неа", "Тебе не стоит этого видеть", "do_pick_penispump")
	if(state == "prepare_milking"):
		addCharacter("artica", ["naked"])
		playAnimation(StageScene.BreastGroping, "tease", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		breastMilking = (breastPumpID != "")
		penisMilking = (penisPumpID != "")
		isLact = (getCharacter("artica").isLactating())
		if (breastMilking && penisMilking):
			saynn("Постоянно наблюдать за "+str("swollen" if isLact else "non-lactating")+" сиськи.. и её стояк.. так и хочется посмотреть, сколько молока и спермы ты сможешь из неё.. выжать..")

		elif (breastMilking):
			saynn("Постоянно наблюдать за "+str("swollen" if isLact else "non-lactating")+" сиськи.. так и хочется посмотреть, сколько молока ты сможешь из них.. выжать..")

		else:
			saynn("Постоянные взгляды на стояк Артики.. заставляют желать узнать, сколько семени ты сможешь из него.. выжать..")

		if (!isNaked):
			saynn("[say=pc]Артика, я хочу кое-что с тобой сделать..[/say]")

			saynn("Её ушки навострились.")

			saynn("[say=artica]О?[/say]")

			saynn("[say=pc]..но для начала нам нужно снять эту одежду.[/say]")

			if (isVerySlut):
				saynn("[say=artica]Конечно.. сама не знаю, зачем я до сих пор в ней.. ха-ха..[/say]")

			elif (isSlut):
				saynn("[say=artica]Конечно.. я не против постоять перед тобой голой.. ха-ха..[/say]")

			else:
				saynn("[say=artica]О.. мм.. кажется, здесь только мы двое.. ладно..[/say]")

			saynn("Ты помогаешь Артике снять её сиреневую рубашку и шорты, обнажая её {artica.breasts}, {artica.penis} и милый маленький голубой разрез, спрятанный за её яичками.")

			saynn("После этого ты помогаешь ей сесть на пол... там тебе будет удобнее закрепить насос"+str("s" if breastMilking else "")+" на ней.")

		else:
			saynn("[say=pc]Артика, я хочу кое-что с тобой сделать..[/say]")

			saynn("Её ушки навострились.")

			saynn("[say=artica]О?[/say]")

			saynn("[say=pc]Да.. и это просто идеально, что ты уже голая. Дай-ка мне..[/say]")

			saynn("Артика не сопротивляется, когда ты помогаешь ей опуститься на пол... там тебе будет удобнее закрепить насос"+str("s" if breastMilking else "")+" на ней.")

		if (breastMilking):
			addButton("Помпы", "Начать закрепление", "secure_pumps")
		else:
			addButton("Помпа для пениса", "Начать закрепление на её члене", "secure_pumps")
	if(state == "secure_pumps"):
		if (sybian):
			playAnimation(StageScene.SybianOral, "idle", {pc="artica", npc="pc", chained=true, bodyState={naked=true, hard=true}})
			saynn("[say=pc]О да.. чуть не забыла.[/say]")

			saynn("Ты указываешь на небольшое устройство в углу вашей камеры.")

			saynn("[say=pc]Садись на это.[/say]")

			saynn("Глаза Артики округляются.")

			if (isVerySlut):
				saynn("[say=artica]Ммм.. конечно..[/say]")

			elif (isSlut):
				saynn("[say=artica]Ммм.. почему бы и нет.. я слишком умна, чтобы отказываться..[/say]")

			else:
				saynn("[say=artica]Ммм.. ладно.. это, наверное, необходимо.. я слишком умна, чтобы отказываться..[/say]")

			saynn("Артика занимает место на сибианском тренажере, позволяя маленькому резиновому дилдо проникнуть в её щель, пока её клитор и яички покоятся на небольшой ребристой платформе.")

			saynn("Она с огромным интересом наблюдает, как ты берешь короткий поводок и приковываешь пушистую задницу к машине.. почти не задавая вопросов.")

		else:
			playAnimation(StageScene.BreastGroping, "tease", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		if (breastMilking):
			saynn("Ты осторожно располагаешь молокоотсосы на груди Артики,"+str(" milky" if isLact else "")+"мягкие присоски плотно обхватывают её нежные соски.")

		if (penisMilking):
			saynn(""+str("После этого ты" if breastMilking else "Ты")+"ты тянешься за пенисным насосом, прежде чем надеть его на собачий член Артики. Ты надеваешь его без особых хлопот, и кольцо удовольствия теперь плотно обхватывает этот голубой ствол.")

		addButton("Старт", "Включить насосы", "start_pumps")
	if(state == "start_pumps"):
		showFightUI = true
		if (sybian):
			playAnimation(StageScene.SybianOral, "ride", {pc="artica", npc="pc", chained=true, bodyState={naked=true, hard=true}})
		else:
			playAnimation(StageScene.BreastGroping, "tease", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		if (breastMilking):
			saynn("С мягким щелчком ты активируешь каждый из молокоотсосов. Комнату наполняет нежное жужжание — они начинают вытягивать сладкое молоко Артики..."+str(" действительно стараешься..." if !isLact else " судя по всему, без особых проблем — у девушки отлично идет лактация.")+"")

			if (penisMilking):
				saynn("Но ты еще не закончил. С сияющей на лице ухмылкой ты тянешься к пенис-насосу и нажимаешь кнопку, заставляя его ожить! Кольцо удовольствия начинает скользить по голубому стволу Артики, пытаясь выжать всё из её яичек, пока остальные насосы вовсю доят её грудь.")

				saynn("Артику доят сразу двумя типами насосов! Остается надеяться, что она не сломается...")

		else:
			saynn("С мягким щелчком ты активируешь пенис-насос. Кольцо удовольствия начинает двигаться вдоль голубого ствола Артики, пытаясь выжать из её яичек всё семя до последней капли. Комнату наполняет нежное жужжание... а также звук ритмичных фрикций...")

		addButton("Продолжить", "Смотреть, что будет дальше", "next_milk_cycle")
	if(state == "next_milk_cycle"):
		var isArticaClose = (getCharacter("artica").getArousal() > 0.6)
		var isCumming = (getCharacter("artica").getArousal() >= 1.0)
		showFightUI = true
		if (sybian):
			if (isArticaClose):
				playAnimation(StageScene.SybianOral, "intense", {pc="artica", npc="pc", chained=true, bodyState={naked=true, hard=true}})
			else:
				playAnimation(StageScene.SybianOral, "ride", {pc="artica", npc="pc", chained=true, bodyState={naked=true, hard=true}})
		else:
			if (isArticaClose):
				if (penisMilking || isCaged):
					playAnimation(StageScene.BreastGroping, "grope", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
				else:
					playAnimation(StageScene.BreastGroping, "stroke", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
			else:
				if (penisMilking || isCaged):
					playAnimation(StageScene.BreastGroping, "grope", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
				else:
					playAnimation(StageScene.BreastGroping, "stroke", {pc="pc", npc="artica", npcBodyState={naked=true, hard=true}})
		if (sybian):
			saynn("Под Артикой вибрирует сибиан, стимулируя её клитор и киску. Цепь не дает ей слишком сильно извиваться.")

		else:
			saynn("Твои теплые объятия не дают Артике слишком сильно ерзать.")

		if (beganLactating && !announcedLact):
			announcedLact = true
			saynn("Грудь Артики внезапно [b]начала выделять молоко[/b]! Она издает страстный стон, когда молоко начинает свободно течь из её упругих голубых сосков. Она краснеет от того, что её грудь наконец отозвалась на стимуляцию.")

		if (breastMilking):
			if (milkCollected >= 1.0):
				if (RNG.chance(100.0/5.0)):
					saynn("Соски Артики пульсируют от дойки; молоко брызжет в ожидающие насосы, которые неустанно работают, делая каждый рывок.")

				elif (RNG.chance(100.0/4.0)):
					saynn("Молоко течет из налитых темно-голубых сосков Артики, а молокоотсосы ритмично выжимают каждую каплю.")

				elif (RNG.chance(33)):
					saynn("Молоко течет струей, пока Артика стонет, поддаваясь неумолимому тягу насосов, терзающих её темные соски.")

				elif (RNG.chance(50)):
					saynn("Тело Артики дрожит, пока насосы вытягивают грудное молоко, мерно и настойчиво потягивая её соски.")

				else:
					saynn("С каждым всасыванием соски Артики отдают кремовое молоко, а её грудь раздувается от удовольствия.")

				saynn("Грудным насосам удалось собрать "+str(str(Util.roundF(milkCollected, 1)))+" мл молока!")

			else:
				saynn("Грудные насосы дразнят соски Артики, и её грудь охотно отзывается на их тягу.")

				if (RNG.chance(100.0/5)):
					saynn("Удовольствие пронзает тело Артики, пока насос творит свою магию с её чувствительными сосками.")

				elif (RNG.chance(100.0/4)):
					saynn("Насос дразнит чувствительные соски Артики, вырывая у неё нежные стоны наслаждения.")

				elif (RNG.chance(33)):
					saynn("Насосы дразнят соски Артики; молока они выкачивают немного, но посылают волны приятной дрожи по всему её телу.")

				elif (RNG.chance(50)):
					saynn("Грудные насосы не собрали ни капли молока, тщетно качая грудь Артики.")

		if (penisMilking):
			if (RNG.chance(100.0/5)):
				saynn("Каждый ход насоса заставляет Артику вздрагивать, а из её члена уже начинает сочиться предэякулят.")

			elif (RNG.chance(100.0/4)):
				saynn("Член Артики пульсирует, а движения насоса посылают волны удовольствия по всему её телу.")

			elif (RNG.chance(100.0/3)):
				saynn("С каждым движением насоса узел Артики раздувается всё сильнее, а из кончика члена начинает свободно течь смазка.")

			elif (RNG.chance(100.0/2)):
				saynn("Член Артики подергивается, а неумолимый ритм насоса заставляет её страстно стонать.")

			else:
				saynn("Член Артики вздрагивает, когда кольцо насоса скользит вдоль его длины, а её яички напрягаются.")

		if (RNG.chance(30) && getCharacter("artica").getArousal() > 0.7):
			if (RNG.chance(25)):
				saynn("Воздух наполняется милыми звуками, которые издает Артика; её тело дрожит от удовольствия, когда она приближается к оргазму.")

			elif (RNG.chance(33)):
				saynn("Бёдра Артики выгибаются от возбуждения, а дыхание становится прерывистым и тяжёлым по мере приближения к климаксу.")

			elif (RNG.chance(50)):
				saynn("Артика уже совсем близко; её частое дыхание гипнотизирует, а сердце бешено колотится...")

			else:
				saynn("Её тело дрожит, пальцы ног поджимаются, а хвост дико мечет из стороны в сторону. Она вот-вот кончит...")

		if (isCumming):
			saynn("Артика вот-вот кончит...")

			addButton("Оргазм", "Смотреть, что будет дальше", "artica_orgasm")
		else:
			addButton("Продолжить", "Доить Артику сильнее", "next_milk_cycle")
			addButton("Хватит", "Пока хватит доить Артику", "enough_milking")
	if(state == "artica_orgasm"):
		showFightUI = true
		saynn("Мощный оргазм сотрясает тело Артики. Она выгибается и дрожит, пока её мышцы непроизвольно напрягаются.")

		saynn("[say=artica]"+str(RNG.pick(["AhHh-h!..", "Ah-h..ah..ahh..", "с-слишком много.. ахх.. ах.. нняах..", "G-gods.. ahh-h.."]))+"[/say]")

		if (breastMilking && milkCollected > 1.0):
			saynn("Во время этого пика из её груди в молокоотсосы брызжет молоко.")

			saynn("Грудным насосам удалось собрать "+str(str(Util.roundF(milkCollected, 1)))+" мл молока!")

		if (penisMilking):
			if (RNG.chance(25)):
				saynn("Кок Артики жадно пульсирует, пока насос высасывает из её яичек всё до капли, а её стоны наслаждения эхом разносятся по камере.")

			elif (RNG.chance(33)):
				saynn("Кок Артики спазмирует и дергается, наполняя насос порциями спермы.")

			elif (RNG.chance(50)):
				saynn("Насос для пениса работает на пределе, чтобы собрать каждую каплю её кончи, извергающейся из пульсирующего собачьего кока.")

			else:
				saynn("Её кок выпускает поток горячей, липкой спермы. Насос жадно собирает каждую каплю, пока она оседлала волну экстаза.")

			saynn("Насосу удалось собрать "+str(str(Util.roundF(seedCollected, 1)))+" мл спермы!")

		addButton("Доить больше", "Доить пушистику сильнее", "next_milk_cycle")
		addButton("Хватит", "Пока хватит доить Артику", "enough_milking")
	if(state == "enough_milking"):
		saynn("Вы снимаете насосы с Артики, давая ей прийти в себя.")

		if (hadOrgasm):
			saynn("[say=artica]Ах.. ах.. ааах.. б-боги.. ах..[/say]")

		else:
			saynn("[say=artica]Э-это б-было так приятно..[/say]")

		saynn("В итоге вам удалось подоить Артику на.. "+str(str(Util.roundF(milkTotal, 1))+" мл молока" if breastMilking else "")+""+str(" and " if (breastMilking && penisMilking) else "")+""+str(str(Util.roundF(seedTotal, 1))+" мл семени" if penisMilking else "")+"")

		var totalSmart = milkTotal + seedTotal
		if (totalSmart >= 800.0):
			saynn("Ого.. кажется, урожай просто отличный!")

		elif (totalSmart >= 500.0):
			saynn("Довольно неплохой урожай!")

		elif (totalSmart >= 300.0):
			saynn("Неплохо.. хотя кажется, что Артика способна на большее.")

		elif (totalSmart >= 100.0):
			saynn("Маловато.. но всё же.. Лучше, чем ничего!")

		elif (totalSmart >= 1.0):
			saynn("Это было совсем не то.. Может, стоит дать Артике еще отдохнуть.")

		else:
			saynn("В этот раз тебе ничего не удалось.. Может, в следующий раз получится!")

		saynn("Ты возвращаешь её в главный зал.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func addPumpButtons(go_id):
	var pumps = GM.pc.getInventory().getItemsWithTag(ItemTag.BreastPump)
	for pump in pumps:
		addButton(pump.getVisibleName(), pump.getVisibleDescription(), go_id, [pump])

func addPenisPumpButtons(go_id):
	var pumps = GM.pc.getInventory().getItemsWithTag(ItemTag.PenisPump)
	for pump in pumps:
		addButton(pump.getVisibleName(), pump.getVisibleDescription(), go_id, [pump])


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "toggle_sybian"):
		sybian = !sybian
		return

	if(_action == "do_pick_nobreastpump"):
		breastPumpID = ""
		setState("")
		return

	if(_action == "do_pick_breastpump"):
		var pump = _args[0]
		breastPumpID = pump.getUniqueID()
		#GM.pc.getInventory().removeItem(pump)
		#getCharacter("artica").getInventory().forceEquipRemoveOther(pump)
		setState("")
		return

	if(_action == "do_pick_nopenispump"):
		penisPumpID = ""
		setState("")
		return

	if(_action == "do_pick_penispump"):
		var pump = _args[0]
		penisPumpID = pump.getUniqueID()
		#GM.pc.getInventory().removeItem(pump)
		#getCharacter("artica").getInventory().forceEquipRemoveOther(pump)
		setState("")
		return

	if(_action == "secure_pumps"):
		if(breastPumpID!=""):
			var pump = GM.pc.getInventory().getItemByUniqueID(breastPumpID)
			if(pump != null):
				GM.pc.getInventory().removeItem(pump)
				getCharacter("artica").getInventory().forceEquipRemoveOther(pump)
		if(penisPumpID!=""):
			var pump = GM.pc.getInventory().getItemByUniqueID(penisPumpID)
			if(pump != null):
				GM.pc.getInventory().removeItem(pump)
				getCharacter("artica").getInventory().forceEquipRemoveOther(pump)

	if(_action == "start_pumps"):
		getCharacter("artica").addLust(5)
		getCharacter("artica").addArousal(getCharacter("artica").getLustLevel()*0.1)

	if(_action == "next_milk_cycle"):
		processTime(1*60)
		milkCollected = 0.0
		getCharacter("artica").addLust(RNG.randi_range(8, 12))
		getCharacter("artica").addArousal(getCharacter("artica").getLustLevel()*0.2)
		if(breastMilking):
			var beganLactatingNow = getCharacter("artica").stimulateLactation()
			if(beganLactatingNow):
				beganLactating = true
			var pumpItem = getCharacter("artica").getInventory().getItemByUniqueID(breastPumpID)
			if(pumpItem != null):
				var howMuchToExtract = RNG.randf_range(pumpItem.getMilkSpeedPerMinuteMin(), pumpItem.getMilkSpeedPerMinuteMax()) / (6.0 - getCharacter("artica").getArousal()*4.0)
				var howMuchCollected = getCharacter("artica").getBodypart(BodypartSlot.Breasts).getFluids().transferAmountTo(pumpItem, howMuchToExtract)
				milkCollected = howMuchCollected
		milkTotal += milkCollected

	if(_action == "artica_orgasm"):
		hadOrgasm = true
		processTime(60)
		seedCollected = 0.0
		getCharacter("artica").addLust(-int(getCharacter("artica").getLust() * 0.5))
		getCharacter("artica").setArousal(0.0)
		if(getCharacter("artica").getWornPenisPump() != null):
			seedCollected = getCharacter("artica").cumInItem(getCharacter("artica").getWornPenisPump())
		seedTotal += seedCollected
		getCharacter("artica").orgasmFrom("pc")
		
		milkCollected = 0.0
		if(breastMilking):
			var pumpItem = getCharacter("artica").getInventory().getItemByUniqueID(breastPumpID)
			if(pumpItem != null):
				var howMuchToExtract = RNG.randf_range(pumpItem.getMilkSpeedPerMinuteMin(), pumpItem.getMilkSpeedPerMinuteMax())
				var howMuchCollected = getCharacter("artica").getBodypart(BodypartSlot.Breasts).getFluids().transferAmountTo(pumpItem, howMuchToExtract)
				milkCollected = howMuchCollected
		milkTotal += milkCollected

	if(_action == "enough_milking"):
		getCharacter("artica").setArousal(0.0)
		if(breastPumpID != ""):
			var pump = getCharacter("artica").getInventory().getItemByUniqueID(breastPumpID)
			if(pump != null):
				getCharacter("artica").getInventory().removeEquippedItem(pump)
				GM.pc.getInventory().addItem(pump)
		if(penisPumpID != ""):
			var pump = getCharacter("artica").getInventory().getItemByUniqueID(penisPumpID)
			if(pump != null):
				getCharacter("artica").getInventory().removeEquippedItem(pump)
				GM.pc.getInventory().addItem(pump)
		var totalSmart = milkTotal + seedTotal
		if(totalSmart >= 500.0):
			GM.pc.addSkillExperience(Skill.Milking, 50)
			getModule("ArticaModule").addCorruption(0.02)
		if(breastMilking):
			getCharacter("artica").addEffect(StatusEffect.SoreNipplesAfterMilking)
		getModule("ArticaModule").makeLusty()

	setState(_action)

func saveData():
	var data = .saveData()

	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["corruption"] = corruption
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy
	data["breastPumpID"] = breastPumpID
	data["penisPumpID"] = penisPumpID
	data["sybian"] = sybian
	data["breastMilking"] = breastMilking
	data["penisMilking"] = penisMilking
	data["isLact"] = isLact
	data["seedCollected"] = seedCollected
	data["milkCollected"] = milkCollected
	data["seedTotal"] = seedTotal
	data["milkTotal"] = milkTotal
	data["beganLactating"] = beganLactating
	data["announcedLact"] = announcedLact
	data["hadOrgasm"] = hadOrgasm

	return data

func loadData(data):
	.loadData(data)

	isNaked = SAVE.loadVar(data, "isNaked", false)
	isCaged = SAVE.loadVar(data, "isCaged", false)
	corruption = SAVE.loadVar(data, "corruption", 0.0)
	isSlut = SAVE.loadVar(data, "isSlut", false)
	isVerySlut = SAVE.loadVar(data, "isVerySlut", false)
	isLusty = SAVE.loadVar(data, "isLusty", false)
	nakedAndShy = SAVE.loadVar(data, "nakedAndShy", false)
	breastPumpID = SAVE.loadVar(data, "breastPumpID", "")
	penisPumpID = SAVE.loadVar(data, "penisPumpID", "")
	sybian = SAVE.loadVar(data, "sybian", false)
	breastMilking = SAVE.loadVar(data, "breastMilking", false)
	penisMilking = SAVE.loadVar(data, "penisMilking", false)
	isLact = SAVE.loadVar(data, "isLact", false)
	seedCollected = SAVE.loadVar(data, "seedCollected", 0.0)
	milkCollected = SAVE.loadVar(data, "milkCollected", 0.0)
	seedTotal = SAVE.loadVar(data, "seedTotal", 0.0)
	milkTotal = SAVE.loadVar(data, "milkTotal", 0.0)
	beganLactating = SAVE.loadVar(data, "beganLactating", false)
	announcedLact = SAVE.loadVar(data, "announcedLact", false)
	hadOrgasm = SAVE.loadVar(data, "hadOrgasm", false)
