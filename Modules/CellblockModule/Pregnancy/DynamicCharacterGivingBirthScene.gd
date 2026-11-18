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

			var randomNpcLine = RNG.pick(["Hey, it's you. I've been looking for you everywhere. I.. I need your help. With this..", "I've been searching for you, hoping you would assist me. I need your help now more than ever.", "Can you please help me? It's kinda urgent..", "Oh, I finally found you. I really need your help.", "I'm sorry for approaching you like this but I don't have anyone else."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

			saynn("{npc.He} демонстрирует тебе свой {npc.his} раздутый беременный живот. И, похоже, {npc.he} уже готова рожать..")

			var randomNpcLine2 = RNG.pick(["I think it's happening, I keep feeling contractions..", "I'm pregnant and I can't do this alone. I think it's already happening.. Will you please help me?", "I'm scared and I don't know what to do..", "I feel the contractions.. I'm scared.."])
			saynn("[say=npc]"+str(randomNpcLine2)+"[/say]")

		elif (npcType == "mean"):
			saynn("Блуждая по тюрьме, ты замечаешь знакомую фигуру. Это {npc.name}, одна из тех "+str(charTypes)+" , которых ты обрюхатил.. О нет.. {npc.He} замечает тебя и спешит навстречу, на {npc.his} лице читается ярость.")

			var randomNpcLine = RNG.pick(["Oh, great, it's you! Took your sweet time, didn't you? I've been searching all over this damn station. I can't believe I have to ask you for help.", "Don't even try to act surprised! You know damn well what you've done.", "I can't believe I'm even considering asking you for help, but here it goes."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

			saynn("{npc.He} демонстрирует тебе свой {npc.his} раздутый беременный живот. И, похоже, {npc.he} уже готова рожать..")

			var randomNpcLine2 = RNG.pick(["I'm pregnant! And it's all because of you. Now I need your sorry ass to do something about it. Fast..", "Of all the people to get knocked up by in this hellhole, it had to be you. What are you gonna do about it?", "Congratulations, I'm pregnant. I can't believe I'm saying this, but I need your sorry ass to step up and help me.", "I'm pregnant and I can't handle this on my own. So quit avoiding responsibility and help me, for once.", "Guess what? I'm fucking pregnant. And I need your help, you selfish jerk..", "Congratulations, you're made me a mother. Now, are you going to step up and assist me, or should I handle it myself?", "I'm pregnant, and whether you like it or not, you're involved. So, are you going to be useful and help or should I find someone else?", "Listen, I'm pregnant, and I need your damn help."])
			saynn("[say=npc]"+str(randomNpcLine2)+"[/say]")

		elif (npcType == "subby"):
			saynn("Блуждая по тюрьме, ты замечаешь знакомую фигуру. Это {npc.name}, одна из тех "+str(charTypes)+" , которых ты обрюхатил.. {npc.He} замечает тебя и краснеет, прежде чем медленно подойти; на {npc.his} застенчивом лице читается смесь восторга и беспокойства.")

			var randomNpcLine = RNG.pick(["Um, excuse me.. It's, uh, you. I've been looking for you. I.. I need your help, if you don't mind..", "Hi, it's me.. I don't know if you remember me.. I..", "Um, hi. I've been looking for you. I don't know who else to ask..", "H-Hey, it's you. I.. I've been.. looking for you.", "Um, excuse me.. I'm sorry to bother you but.."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

			saynn("{npc.He} демонстрирует тебе свой {npc.his} раздутый беременный живот. И, похоже, {npc.he} уже готова рожать..")

			var randomNpcLine2 = RNG.pick(["I-I.. I'm pregnant.. And I think.. it's happening..", "I.. I'm pregnant and it's getting really close.. Maybe you could.. help me? Please?..", "I'm pregnant and I'm scared because I think it's about to happen.. Would you mind.. helping me through this?..", "I'm pregnant and I need someone to be there.. because I'm scared.. Would you.. be willing to help?"])
			saynn("[say=npc]"+str(randomNpcLine2)+"[/say]")

		addButton("Помочь", "Помочь им добраться до медблока и принять роды", "help_them")
		addButton("Не моя проблема", "Сказать им, что это их проблема", "tell_not_my_problem")
	if(state == "tell_not_my_problem"):
		saynn("Ты явно не хочешь этим заниматься прямо сейчас.")

		var randomResponce = RNG.pick(["Look, your pregnancy is not my problem. Deal with it on your own.", "I really don't have time for this, just go to the medical wing.", "Seriously? You expect me to drop everything and help you with your pregnancy? I'm not here to handle your problems.", "I have my own problems to deal with. Your pregnancy is not my concern.", "Look, I didn't sign up for this. Your pregnant belly is not my responsibility.", "Why should I care about your pregnant belly? It's not like we planned any of this. Figure it out yourself."])
		saynn("[say=pc]"+str(randomResponce)+"[/say]")

		if (npcType == "kind"):
			saynn("На "+str(charType)+" издает печальные вздохи, всё еще осторожно поддерживая {npc.his} большой живот {npc.his} руками.")

			var randomNpcLine = RNG.pick(["Oh.. I see. I thought you would care. I guess I was wrong.", "I didn't expect you to be so cold-hearted.. I thought we had some connection.. But I guess I was wrong.", "I will figure this out on my own then..", "I guess I was hoping for too much from some inmate..", "This pregnancy is overwhelming.. I thought I could rely on you.. Guess not..", "It's okay. I understand. I will try to get to the medical on my own. Didn't mean to burden you with my problems..", "Okay. I will try to get to the medical on my own.."])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

		elif (npcType == "mean"):
			if (decidedToHit):
				saynn("На "+str(charType)+" так бесится от твоего ответа, что {npc.he} со всей силы бьет тебя кулаком в грудь.")

			else:
				saynn("На "+str(charType)+" смотрит на тебя {npc.his} раздраженными глазами, сжимая {npc.his} руки в кулаки.")

			var randomNpcLine = RNG.pick(["Typical! I should have known better than to expect any decency from you. Fucker!", "Fine, fuck you too then! I don't need your help anyway. I will manage on my own.", "You fucker. Fine. I will handle this alone, just like I've had to from the beginning.", "Oh, how silly of me to think you might care. I will remember this when I'm holding my baby, knowing that I did it all without you!"])
			saynn("[say=npc]"+str(randomNpcLine)+"[/say]")

		elif (npcType == "subby"):
			saynn("На "+str(charType)+" опускает {npc.his} голову, нежно поглаживая {npc.his} живот {npc.his} руками.")

			var randomNpcLine = RNG.pick(["Oh.. Okay. I understand. I'm sorry for bothering you..", "I.. I didn't mean to impose. I will manage on my own. Sorry for asking..", "Oh.. I guess I will go now. Sorry for wasting your time..", "I.. I'll handle this on my own. Sorry for burdening you with my situation..", "I will find my own way to the medical wing. Sorry for bothering you with my troubles.."])
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

			saynn("[say=pc]"+str(RNG.pick(["You're doing great. Just breathe through it. I'm here with you.", "You can do it. Push when the nurse tells you.", "I believe in you, listen to the nurse."]))+"[/say]")

			saynn("[say=npc]"+str(RNG.pick(["Thank you for being here..", "I don't know how would I do it without you..", "I couldn't go through this alone.. thank you.."]))+"[/say]")

		elif (npcType == "mean"):
			saynn("Ты стоишь рядом с {npc.nameS}, пока {npc.he} слушает указания медсестры. Ты протягиваешь руку {npc.him}, но, кажется, {npc.he} она не нужна.")

			saynn("[say=npc]"+str(RNG.pick(["I'm strong, I don't need your pity.. ah..", "Do I look like I need your hand? Ah..", "Holding hands is for softies.. ah..", "I'm gonna give birth without any hand holding.. ah.."]))+"[/say]")

			saynn("Начинаются схватки, заставляя {npc.name} стонать от боли и, в конце концов, вцепиться в твою руку, сжимая её до белизны в костяшках.")

		elif (npcType == "subby"):
			saynn("Ты стоишь рядом с {npc.nameS}, пока {npc.he} слушает указания медсестры и изо всех сил старается {npc.his} не шуметь слишком сильно, вероятно, из-за чувства смущения. Ты решаешь взять {npc.his} за руку и крепко сжать её, отчего {npc.him} густо краснеет.")

			saynn("[say=pc]"+str(RNG.pick(["You're doing great. Just breathe through it. I'm here with you.", "You can do it. Push when the nurse tells you.", "I believe in you, listen to the nurse.", "Don't hold it, it's okay to scream if you need to."]))+"[/say]")

			saynn("[say=npc]"+str(RNG.pick(["Yeah.. okay.. ah..", "Thank you.. ah.."]))+"[/say]")

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

		saynn("[say=npc]"+str(RNG.pick(["Oh.. oh my.. so perfect.. Look at the tiny fingers and those little eyes.. So beautiful..", "Hi, mommy loves you more than words can express.. welcome to the world, my precious..", "I can't believe I brought this incredible life into existence.. I can't live without you already..", "I will do everything in my power to give you the life you deserve.."]))+"[/say]")

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
