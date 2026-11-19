extends SceneBase

var npcID = ""
var npcType = "kind"
var isStaff = true
var charType = "staff member"
var charTypes = "staff members"
var decidedToHit = false
var bornString = ""
var bornChildAmount = 0

func _init():
	sceneID = "DynamicCharacterGivingBirthScene"

func _initScene(_args = []):
	npcID = _args[0]
	addCharacter(npcID)
	
	npcType = "kind"
	var npc = GlobalRegistry.getCharacter(npcID)
	var personality:Personality = npc.getPersonality()
	if(personality.getStat(PersonalityStat.Mean) > 0.3 || personality.getStat(PersonalityStat.Subby) < -0.6):
		npcType = "mean"
	if(personality.getStat(PersonalityStat.Subby) > 0.6 || personality.getStat(PersonalityStat.Coward) > 0.8):
		npcType = "subby"
	
	if(npc.getCharacterType() == CharacterType.Inmate):
		isStaff = false
		charType = "inmate"
		charTypes = "inmates"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		if (npcType == "kind"):
			saynn("Блуждая по тюрьме, ты замечаешь знакомую фигуру. Это {npc.name}, одна из тех "+str(charTypes)+" , которых ты обрюхатил.. {npc.He} замечает тебя и спешит навстречу, на {npc.his} лице читается смесь восторга и беспокойства.")

			var randomNpcLine = RNG.pick(["О, это ты. Я тебя повсюду искала. Мне... мне нужна твоя помощь. С этим самым...", "Я искала тебя, надеясь, что ты поможешь. Сейчас ты нужен мне как никогда.", "Пожалуйста, помоги мне. Это довольно срочно...", "О, наконец-то я тебя нашла. Мне очень нужна твоя помощь.", "Прости, что подхожу к тебе вот так, но мне больше не к кому обратиться."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

			saynn("{npc.He} демонстрирует тебе свой {npc.his} раздутый беременный живот. И, похоже, {npc.he} уже готова рожать..")

			var randomNpcLine2 = RNG.pick(["Кажется, началось... Я всё время чувствую схватки...", "Я беременна, и я не справлюсь в одиночку. Кажется, процесс уже пошёл... Поможешь мне, пожалуйста?", "Мне страшно, и я не знаю, что делать...", "Я чувствую схватки... Мне страшно..."])
			saynn("[say=npc]"+str(randomNpcLine2)+"[/say]")

		elif (npcType == "mean"):
			saynn("Блуждая по тюрьме, ты замечаешь знакомую фигуру. Это {npc.name}, одна из тех "+str(charTypes)+" , которых ты обрюхатил.. О нет.. {npc.He} замечает тебя и спешит навстречу, на {npc.his} лице читается ярость.")

			var randomNpcLine = RNG.pick(["О, отлично, это ты! Ну и заставил же ты меня подождать! Я тебя по всей этой чертовой станции обыскала. Поверить не могу, что мне приходится просить о помощи именно тебя.", "Даже не пытайся строить из себя удивленного! Ты прекрасно знаешь, что натворил.", "Сама не верю, что собираюсь просить тебя о помощи, но вот так всё вышло."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

			saynn("{npc.He} демонстрирует тебе свой {npc.his} раздутый беременный живот. И, похоже, {npc.he} уже готова рожать..")

			var randomNpcLine2 = RNG.pick(["Я беременна! И всё из-за тебя. Теперь твоей заднице придется что-то с этим делать. И быстро.", "Из всех людей в этой дыре, забеременеть пришлось именно от тебя. И что ты теперь будешь делать?", "Поздравляю, я беременна. Сама не верю, что это говорю, но тебе пора взять на себя ответственность и помочь мне.", "Я беременна, и в одиночку мне не справиться. Так что хватит бегать от ответственности и помоги мне хоть раз!", "Знаешь что? Я, блядь, беременна. И мне нужна твоя помощь, эгоистичная ты сволочь...", "Поздравляю, ты сделал меня матерью. Ну так что, ты собираешься взять на себя заботы или мне разгребать всё самой?", "Я беременна, и нравится тебе это или нет, ты в деле. Так ты будешь полезным и поможешь, или мне найти кого-то другого?", "Слушай сюда: я беременна, и мне нужна твоя чертова помощь."])
			saynn("[say=npc]"+str(randomNpcLine2)+"[/say]")

		elif (npcType == "subby"):
			saynn("Блуждая по тюрьме, ты замечаешь знакомую фигуру. Это {npc.name}, одна из тех "+str(charTypes)+" , которых ты обрюхатил.. {npc.He} замечает тебя и краснеет, прежде чем медленно подойти; на {npc.his} застенчивом лице читается смесь восторга и беспокойства.")

			var randomNpcLine = RNG.pick(["Эм, извини... Это, э-э, ты. Я тебя искала. Мне... мне нужна твоя помощь, если ты не против...", "Привет, это я... Не знаю, помнишь ли ты меня... Я...", "Эм, привет. Я тебя искала. Не знаю, к кому еще обратиться...", "П-привет, это ты. Я... я... искала тебя.", "Эм, извини... Прости, что беспокою, но..."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

			saynn("{npc.He} демонстрирует тебе свой {npc.his} раздутый беременный живот. И, похоже, {npc.he} уже готова рожать..")

			var randomNpcLine2 = RNG.pick(["Я... я... я беременна... И кажется... процесс пошел...", "Я... я беременна, и всё уже совсем близко... Может, ты бы мог... помочь мне? Пожалуйста?..", "Я беременна, и мне страшно, потому что, кажется, всё вот-вот случится... Ты не против... помочь мне пройти через это?..", "Я беременна, и мне нужно, чтобы кто-то был рядом... потому что мне страшно... Ты... ты готов помочь?"])
			saynn("[say=npc]"+str(randomNpcLine2)+"[/say]")

		addButton("Помочь", "Помочь им добраться до медблока и принять роды", "help_them")
		addButton("Не моя проблема", "Сказать им, что это их проблема", "tell_not_my_problem")
	if(state == "tell_not_my_problem"):
		saynn("Ты явно не хочешь этим заниматься прямо сейчас.")

		var randomResponce = RNG.pick(["Слушай, твоя беременность — не моя проблема. Разбирайся со всем сама.", "У меня реально нет на это времени, просто дуй в медблок.", "Серьёзно? Ты ждёшь, что я брошу все дела и буду помогать тебе с беременностью? Я здесь не для того, чтобы разгребать твои проблемы.", "У меня своих проблем хватает. Твоя беременность меня не колышет.", "Слушай, я на такое не подписывалась. Твой раздутый живот — не моя забота.", "С чего бы мне вообще париться из-за твоего живота? Мы это всё не планировали. Разбирайся сама."])
		saynn("[say=pc]"+str(randomResponce)+"[/say]")

		if (npcType == "kind"):
			saynn("На "+str(charType)+" издает печальные вздохи, всё еще осторожно поддерживая {npc.his} большой живот {npc.his} руками.")

			var randomNpcLine = RNG.pick(["Ох... понятно. А я думала, тебе не всё равно. Видимо, я ошиблась.", "Не ожидала, что ты окажешься такой бесчувственной... Мне казалось, между нами есть связь... Но, похоже, я ошибалась.", "Тогда я справлюсь сама...", "Наверное, я слишком многого ждала от обычной зэчки...", "Эта беременность меня просто с ног сбивает... Я думала, что смогу на тебя положиться... Но нет...", "Все в порядке. Я понимаю. Попробую добраться до медпункта сама. Не хотела обременять тебя своими проблемами...", "Ладно. Попробую добраться до медпункта сама..."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

		elif (npcType == "mean"):
			if (decidedToHit):
				saynn("На "+str(charType)+" так бесится от твоего ответа, что {npc.he} со всей силы бьет тебя кулаком в грудь.")

			else:
				saynn("На "+str(charType)+" смотрит на тебя {npc.his} раздраженными глазами, сжимая {npc.his} руки в кулаки.")

			var randomNpcLine = RNG.pick(["Типично! Нужно было сразу понять, что от тебя не дождешься никакого приличия. Ублюдок!", "Ладно, да пошел ты! Мне твоя помощь всё равно не нужна. Сама справлюсь.", "Ах ты кобель. Ладно. Разберусь со всем сама, как и всегда с самого начала.", "Ох, какая же я дура, раз подумала, что тебе не плевать. Я это запомню, когда буду держать на руках своего ребенка, зная, что сделала всё без тебя!"])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

		elif (npcType == "subby"):
			saynn("На "+str(charType)+" опускает {npc.his} голову, нежно поглаживая {npc.his} живот {npc.his} руками.")

			var randomNpcLine = RNG.pick(["Ох... Хорошо. Я понимаю. Прости, что побеспокоила...", "Я... я не хотела навязываться. Справлюсь сама. Прости, что попросила...", "Ох... Ну, тогда я пойду. Прости, что потратила твое время...", "Я... я справлюсь сама. Прости, что нагрузила тебя своей ситуацией...", "Я сама доберусь до медблока. Прости, что нагрузила тебя своими проблемами..."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "help_them"):
		aimCameraAndSetLocName("medical_nursery")
		GM.pc.setLocation("medical_nursery")
		saynn("[say=pc]Ладно, тогда пошли.[/say]")

		saynn("Ты берешь {npc.name} за руку и ведешь {npc.him} по тюремным коридорам. В конце концов вы добираетесь до вестибюля детского отделения.")

		saynn("Внутри медсестра быстро замечает ситуацию и спешит на помощь. Она ведет {npc.name} в отдельную светлую палату со специальной больничной койкой.")

		addButton("Продолжить", "Смотреть, что будет дальше", "before_birth")
	if(state == "before_birth"):
		playAnimation(StageScene.GivingBirth, "birth", {pc=npcID, bodyState={naked=true}})
		if (npcType == "kind"):
			saynn("Ты стоишь рядом с {npc.nameS}, пока {npc.he} слушает указания медсестры. Затем {npc.he} протягивает тебе {npc.his} руку и нервно улыбается. Ты решаешь сжать её, чтобы помочь {npc.him} успокоиться.")

			saynn("Начинаются схватки: {npc.name} стонет от боли, до боли сжимая твою руку.")

			saynn("[say=pc]"+str(RNG.pick(["Ты молодец. Просто дыши. Я рядом.", "Ты справишься. Тужься, когда скажет медсестра.", "Я верю в тебя, слушай медсестру."]))+"[/say]")

			saynn("[say=npc]"+str(RNG.pick(["Спасибо, что ты здесь...", "Не знаю, что бы я делала без тебя...", "Я бы не вынесла это в одиночку... спасибо..."]))+"[/say]")

		elif (npcType == "mean"):
			saynn("Ты стоишь рядом с {npc.nameS}, пока {npc.he} слушает указания медсестры. Ты протягиваешь руку {npc.him}, но, кажется, {npc.he} она не нужна.")

			saynn("[say=npc]"+str(RNG.pick(["Я сильная, не нужно меня жалеть... ах...", "Я что, похожа на ту, кому нужна твоя помощь? Ах...", "Держаться за руки — это для неженок... ах...", "Я что, реально буду рожать совсем одна... ах..."]))+"[/say]")

			saynn("Начинаются схватки, заставляя {npc.name} стонать от боли и, в конце концов, вцепиться в твою руку, сжимая её до белизны в костяшках.")

		elif (npcType == "subby"):
			saynn("Ты стоишь рядом с {npc.nameS}, пока {npc.he} слушает указания медсестры и изо всех сил старается {npc.his} не шуметь слишком сильно, вероятно, из-за чувства смущения. Ты решаешь взять {npc.his} за руку и крепко сжать её, отчего {npc.him} густо краснеет.")

			saynn("[say=pc]"+str(RNG.pick(["Ты молодец. Просто дыши. Я рядом.", "Ты справишься. Тужься, когда скажет медсестра.", "Я верю в тебя, слушай медсестру.", "Не сдерживайся, если нужно — кричи, всё в порядке."]))+"[/say]")

			saynn("[say=npc]"+str(RNG.pick(["Yeah.. okay.. ah..", "Спасибо... ах..."]))+"[/say]")

		saynn("Комната наполняется напряжением, когда {npc.name} издает всё более мучительные крики — схватки становятся всё чаще и сильнее.")

		addButton("Продолжить", "Смотреть, что будет дальше", "do_birth")
	if(state == "do_birth"):
		playAnimation(StageScene.GivingBirth, "idle", {pc=npcID, bodyState={naked=true}})
		if (bornChildAmount == 1):
			saynn("{npc.name} родила "+str(bornChildAmount)+" ребенка!")

		else:
			saynn("{npc.name} родила "+str(bornChildAmount)+" детей!")

		saynn(""+str(bornString)+"")

		addButton("Продолжить", "Смотреть, что будет дальше", "after_birth")
	if(state == "after_birth"):
		playAnimation(StageScene.SexStart, "start", {pc = "pc", npc=npcID, npcBodyState={naked=true}})
		if (bornChildAmount <= 1):
			saynn("Мгновения тянутся целую вечность, пока наконец воздух не наполняет крик новорожденного.")

			saynn("Глаза {npc.name} блестят от слез облегчения и радости. {npc.He} ждет, когда медсестра аккуратно вытрет {npc.his} ребенка, а затем начинает баюкать его в {npc.his} руках.")

		elif (bornChildAmount == 2):
			saynn("Мгновения тянутся целую вечность, пока наконец воздух не наполняет крик новорожденного. Ох... Но не одного... Вскоре {npc.name} рожает еще одного ребенка...")

			saynn("Глаза {npc.name} сияют от слез облегчения и радости. {npc.He} ждет, пока медсестра аккуратно обмоет {npc.his} ребенка, а затем начинает баюкать одного из них в {npc.his} руках.")

		else:
			saynn("Мгновения тянутся целую вечность, пока наконец воздух не наполняет крик новорожденного. Ох... Но не одного... Вскоре {npc.name} рожает еще одного ребенка... Но даже после этого живот {npc.his} все еще большой, а значит, есть еще...")

			saynn("Только когда {npc.name} рожает последнего ребенка, глаза {npc.his} начинают блестеть от слез облегчения и радости. {npc.He} ждет, когда медсестра аккуратно вытрет {npc.his} ребенка, а затем начинает баюкать одного из них в {npc.his} руках.")

		saynn("[say=npc]"+str(RNG.pick(["Ох... боже мой... какой идеальный... Посмотри на эти крошечные пальчики, на эти глазки... Какая красота...", "Привет, малыш... Мамочка любит тебя сильнее, чем можно выразить словами... Добро пожаловать в этот мир, моё сокровище...", "Не верится, что я подарила жизнь такому чудесному существу... Кажется, я уже не смогу без тебя дышать...", "Я сделаю всё возможное, чтобы дать тебе ту жизнь, которую ты заслуживаешь..."]))+"[/say]")

		saynn("{npc.He} нежно целует младенца {npc.his} в лоб, пока ты стоишь рядом и улыбаешься.")

		saynn("[say=pc]Ты проделала потрясающую работу![/say]")

		saynn("Вы оба какое-то время просто смотрите на новую жизнь...")

		saynn("В конце концов медсестра начинает твердить, что матери нужно отдохнуть. Что ж, справедливо..")

		if (bornChildAmount <= 1):
			saynn("Ты в последний раз нежно смотришь на мамочку и {npc.his} малыша, прежде чем выйти в вестибюль.")

		else:
			saynn("Ты в последний раз бросаешь нежный взгляд на мамочку и {npc.his} деток, прежде чем выйти в вестибюль.")

		saynn("Пора идти..")

		addButton("Продолжить", "Это было нечто", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "help_them"):
		processTime(10*60)

	if(_action == "tell_not_my_problem"):
		if(npcType=="mean"):
			if(RNG.chance(50) && !getCharacter(npcID).hasBoundArms()):
				decidedToHit = true
				GM.pc.addPain(30)
				addMessage("Ow..")

	if(_action == "before_birth"):
		processTime(3*60)

	if(_action == "do_birth"):
		processTime(35*60)
		var bornChilds = getCharacter(npcID).giveBirth()
		bornChildAmount = bornChilds.size()
		bornString = GM.CS.getChildBirthInfoString(bornChilds)
		GM.pc.addSkillExperience(Skill.Breeder, 50) # Reward for being near
		if(GM.main.IS.hasPawn(npcID)):
			GM.main.IS.stopInteractionsForPawnID(npcID)
			GM.main.IS.getPawn(npcID).setLocation("medical_nursery")
		else:
			GM.main.IS.spawnPawn(npcID)
			if(GM.main.IS.hasPawn(npcID)):
				GM.main.IS.getPawn(npcID).setLocation("medical_nursery")

	setState(_action)

func saveData():
	var data = .saveData()

	data["npcID"] = npcID
	data["npcType"] = npcType
	data["isStaff"] = isStaff
	data["charType"] = charType
	data["charTypes"] = charTypes
	data["decidedToHit"] = decidedToHit
	data["bornString"] = bornString
	data["bornChildAmount"] = bornChildAmount

	return data

func loadData(data):
	.loadData(data)

	npcID = SAVE.loadVar(data, "npcID", "")
	npcType = SAVE.loadVar(data, "npcType", "kind")
	isStaff = SAVE.loadVar(data, "isStaff", true)
	charType = SAVE.loadVar(data, "charType", "staff member")
	charTypes = SAVE.loadVar(data, "charTypes", "staff members")
	decidedToHit = SAVE.loadVar(data, "decidedToHit", false)
	bornString = SAVE.loadVar(data, "bornString", "")
	bornChildAmount = SAVE.loadVar(data, "bornChildAmount", 0)
