extends SceneBase

var hasPP = false
var amountCollected = 0.0

func _init():
	sceneID = "ElizaMilkingProstateStraponScene"

func _run():
	if(state == ""):
		addCharacter("eliza")
		aimCameraAndSetLocName("med_milkingroom")
		playAnimation(StageScene.Grope, "tease", {pc="pc", npc="eliza", bodyState={exposedCrotch=true}})
		hasPP = getCharacter("eliza").hasReachablePenis()
		saynn("Вы просите доктора доить вашу простату. Она кивает и ведет вас в специальную комнату... ту самую, где установлен продвинутый стол.")

		saynn("Вы обнажаете свой {pc.penis} и ждете её команд. Вы чувствуете легкое возбуждение, ваш член уже начинает твердеть..."+str(" well.. trying to, in its cage." if GM.pc.isWearingChastityCage() else "")+"")

		saynn("Элиза предлагает вам подойти поближе к столу... что может пойти не так...")

		addButton("Продолжить", "Смотреть, что будет дальше", "get_locked")
	if(state == "get_locked"):
		playAnimation(StageScene.MilkingProstateFuck, "tease", {pc="pc", npc="eliza", bodyState={exposedCrotch=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Элиза нажимает несколько кнопок на компьютере, и стол оживает, направляя свои манипуляторы к вашим конечностям! Ваши запястья и лодыжки захватываются и приподнимаются над полом... Затем машина наклоняет вас над столом... при этом ваши руки и ноги всё еще крепко зафиксированы. Ваше анальное отверстие {pc.analStretch} полностью обнажено...")

		saynn("[say=pc]Ах.[/say]")

		saynn("Вы пытаетесь проверить манипуляторы на прочность, стараясь вырвать запястья или лодыжки... но всё, что вам удается — это заставить моторы жужжать чуть громче; алгоритм стола с легкостью подавляет ваше сопротивление. Вы совершенно беспомощны...")

		saynn("[say=eliza]Отлично. Теперь дайте мне секунду, чтобы подготовиться.[/say]")

		saynn("Элиза снимает лабораторный халат... а также топ и юбку... обнажая свое шикарное черное белье... которое подчеркивает её сексуальные изгибы...")

		if (hasPP):
			saynn("Она хватает подготовленную порно-шлейку для страпона... но быстро осознает свою ошибку.")

			saynn("[say=eliza]Охх... точно~. Мне стоило просто взглянуть на свои раздувшиеся трусики.[/say]")

			saynn("Она стягивает свои кружевные трусики, обнажая {eliza.penis}. Она уже чертовски возбуждена..")

			saynn("[say=eliza]Да, именно так.. Сегодня я буду доить твою простату своим членом~."+str(" I don't even need a strap, I already have a perfect tool to milk someone who is wearing a cage.." if GM.pc.isWearingChastityCage() else " I don't even need a strap, I already have a perfect tool to milk submissive inmates.")+"[/say]")

		else:
			saynn("Затем она хватает готовый ремень для страпона и закрепляет его на талии.. добавляя своему образу пикантности.")

			saynn("[say=eliza]Мгм.. Сегодня я буду доить твою простату этим страпоном."+str(" Perfect tool to milk someone who is wearing a cage.." if GM.pc.isWearingChastityCage() else " Perfect tool to milk submissive inmates.")+"[/say]")

		saynn("Ты сглатываешь, оглядываясь через плечо.. Уголки её губ слегка приподнимаются, когда её взгляд ловит твой покорный взор..")

		saynn("Она достает тюбик лубриканта и медленно подходит к тебе сзади, её лапа делает быстрый скользящий жест по твоей {pc.thick} заднице..")

		saynn("[say=eliza]Нужно убедиться, что после этого ты сможешь ходить.[/say]")

		saynn("Она выдавливает щедрую порцию смазки на свои когтистые пальцы.. и начинает втирать её в твоё анальное кольцо, покрывая его блестящим слоем.")

		saynn("[say=pc]Ах..[/say]")

		saynn("Она ощущается холодной на твоей чувствительной плоти.. твоё отверстие уже сжимается, пока кошка продолжает совершать небольшие круговые движения пальцами, следя за тем, чтобы каждая часть твоей «звездочки» была подготовлена.")

		saynn("Она выдавливает еще немного на свои "+str("strapon" if !hasPP else "cock")+" и использует лапу, чтобы распределить её по всей длине парой движений..")

		saynn("Она совмещает свой.. инструмент.. с твоим дрожащим входом.. и медленно начинает процесс. Мягкими толчками она заставляет "+str("the strap" if !hasPP else "her member")+" проникать в твое заднее отверстие.. сначала с легкостью вводя закругленный кончик, благодаря смазке.")

		saynn("[say=pc]Ммм..[/say]")

		saynn("По мере того как она продолжает погружаться "+str("the slick strapon " if !hasPP else "")+"в тебя, ты чувствуешь, как "+str("it" if !hasPP else "her cock")+" быстро находит твою простату и давит на неё.")

		saynn("[say=pc]Ах..[/say]")

		if (GM.pc.isWearingChastityCage()):
			saynn("Твой запертый член дергается.. капает предэякулятом.. маленькая капля простатической жидкости вырывается наружу и теперь повисает на кончике твоего яичка. Твои внутренние стенки приятно обхватывают блестящий ствол..")

		else:
			saynn("Твой член дергается.. капает предэякулятом.. маленькая капля простатической жидкости вырывается наружу и теперь повисает на самом кончике. Твои внутренние стенки приятно обхватывают блестящий ствол..")

		saynn("Элиза продолжает плавно подавать бедра вперед, вгоняя свой "+str(" rubber cock" if !hasPP else " {eliza.penis}")+" внутрь тебя.. пока не получит достаточно удовольствия.")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_sex")
	if(state == "do_sex"):
		playAnimation(StageScene.MilkingProstateFuck, "sex", {pc="pc", npc="eliza", bodyState={exposedCrotch=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Затем она отстраняется, ослабляя давление на твою простату... лишь для того, чтобы через пару секунд снова сжать её, задавая ритм.")

		saynn("Каждый её следующий толчок заставляет тебя содрогаться всем телом... твоё анус плотно обхватывает этот "+str("strapon" if !hasPP else "shaft")+" , пока он продолжает давить на твою эрогенную зону... заставляя твой {pc.penis} дергаться и выделять всё больше простатной смазки.")

		saynn("[say=pc]Ммм.. ах.. ахх..[/say]")

		saynn("Элиза кладет руку на бок и просто продолжает вбивать свой инструмент в тебя, слегка ускоряя темп. Движения её бедер становятся более твердыми и настойчивыми... но она сохраняет свою клиническую сосредоточенность...")

		saynn("[say=eliza]Мне нравится пеггинг... Пожалуй, это мой любимый способ доить кого-нибудь.[/say]")

		saynn("От постоянной стимуляции ты начинаешь ерзать в путах... твои губы слегка приоткрыты, ты начинаешь тяжело дышать и стонать, а руки судорожно вцепляются в стол.")

		saynn("[say=pc]Ххх.. хах.. хх.. ах..[/say]")

		saynn("Твой бедный, заброшенный член капает всё сильнее... на кончике выступают капли прозрачной жидкости, которые падают в сборник внизу.")

		saynn("Хотя она даже не делает это так быстро... ощущения настолько прекрасны, а твоя разбухшая простата сжимается снова и снова... кажется, ты долго не продержишься...")

		addButton("Продолжить", "Смотреть, что будет дальше", "process_cum")
	if(state == "process_cum"):
		playAnimation(StageScene.MilkingProstateFuck, "fast", {pc="pc", npc="eliza", pcCum=true, bodyState={exposedCrotch=true, hard=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("Элиза наращивает темп, вколачиваясь в твою задницу... и очень скоро... это становится почти невыносимым.")

		saynn("[say=pc]Ах!.. АХх-хх..[/say]")

		saynn("Ты запрокидываешь голову, издавая сладостные стоны, пока всё твоё тело содрогается под её беспощадным пеггингом... Твоё анусное отверстие бешено пульсирует вокруг этого "+str("strap" if !hasPP else "shaft")+" в то время как твой "+str("locked little cock starts to throb inside its cage" if GM.pc.isWearingChastityCage() else "{pc.penis} starts to throb")+", выдавая слабые струйки {pc.cum} в такт толчкам Элизы..")

		saynn("[say=eliza]Ты кончаешь? Хорошо. Давай не оставим ни единой капли этого бесполезного семени в твоих яйцах~.[/say]")

		saynn("Она продолжает трахать тебя, даже когда стенки твоего канала начинают плотно сжимать её ствол... Струйки семени превращаются в сплошное слабое подтекание... твои яички продолжают подергиваться, пока Элиза раз за разом вдребезги разбивает твою простату.")

		saynn("[say=pc]Нхх-хх.. мхх.. ахх.. ахх.. нх..[/say]")

		saynn("Это продолжается какое-то время.."+str(" Until her own orgasm catches up with you. Eliza rams her cock deep inside you and lets it throb, pumping you full of her seed.." if hasPP else "")+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_milking")
	if(state == "after_milking"):
		playAnimation(StageScene.MilkingProstateFuck, "inside", {pc="pc", npc="eliza", bodyState={exposedCrotch=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("После того, что кажется вечностью первобытной, неумолимой стимуляции, Элиза"+str(" gradually eases her motions, leaving most of her strap to rest inside your pulsing rear" if !hasPP else " stops, leaving her cock to rest inside your pulsing rear")+". Это позволяет тебе наконец-то выйти из этого экстатического состояния и попытаться отдохнуть..")

		saynn("Элиза наклоняется в сторону и смотрит на сборник жидкости.")

		saynn("[say=eliza]Спасибо за твое скромное пожертвование~. Ты очень помог.[/say]")

		saynn("Тебя всё еще слегка потряхивает от отголосков того, что только что произошло..")

		saynn("Элиза осторожно вынимает свой "+str("toy" if !hasPP else "dick")+", позволяя твоему отверстию закрыться..")

		addButton("Продолжить", "Смотреть, что будет дальше", "get_up_after")
	if(state == "get_up_after"):
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		GM.pc.setLocation("med_nearmilking")
		aimCameraAndSetLocName("med_nearmilking")
		saynn("Элиза"+str(" takes off her harness and" if !hasPP else "")+" нажимает несколько кнопок на компьютере, заставляя его разжать твои конечности.")

		saynn("Ноги кажутся ватными, поэтому ты просто валишься на стол, пытаясь отдышаться.")

		saynn("[say=eliza]Приятно?[/say]")

		saynn("Ты киваешь.. густо краснея..")

		saynn("Элиза помогает тебе подняться.. а затем выводит тебя в коридор.")

		saynn("[say=eliza]Рада, что тебе понравилось. Но если позволишь, мне пора заполнить кое-какие бумаги. Надеюсь, ты не заблудишься по пути к лобби.[/say]")

		saynn("И вот так просто, она оставляет тебя..")

		saynn("Пора идти.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "get_locked"):
		processTime(5*60)
		if(!hasPP):
			getCharacter("eliza").getInventory().equipItem(GlobalRegistry.createItem("Strapon"))

	if(_action == "do_sex"):
		processTime(5*60)

	if(_action == "process_cum"):
		processTime(5*60)
		amountCollected = GM.main.SCI.processMilkPlayerPenis()
		GM.pc.orgasmFrom("eliza")
		if(hasPP):
			GM.pc.cummedInAnusBy("eliza")

	if(_action == "after_milking"):
		processTime(5*60)

	if(_action == "get_up_after"):
		getCharacter("eliza").removeStrapon()

	setState(_action)

func saveData():
	var data = .saveData()

	data["hasPP"] = hasPP
	data["amountCollected"] = amountCollected

	return data

func loadData(data):
	.loadData(data)

	hasPP = SAVE.loadVar(data, "hasPP", false)
	amountCollected = SAVE.loadVar(data, "amountCollected", 0.0)
