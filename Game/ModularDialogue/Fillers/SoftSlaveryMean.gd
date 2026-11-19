extends DialogueFiller

func _init():
	priority = 12

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var guard = getChar(_args, _form.mainRole)
	var personality:Personality = guard.getPersonality()
	var meanness = personality.getStat(PersonalityStat.Mean)
	#var subby = personality.getStat(PersonalityStat.Subby)
	
	if(meanness < 0.4):
		return false
	
	return true

func getFormIDs() -> Array:
	return [
		"SoftSlaveryOffer",
		"SoftSlaveryOfferYes",
		"SoftSlaveryPCOffer",
		"SoftSlaveryPCOfferYes",
		"SoftSlaveryPCOfferNo",
		
		"SoftSlaveryIntro1Willing",
		
		"SoftSlaveryIntro1",
		"SoftSlaveryIntro2",
		"SoftSlaveryIntro3",
		"SoftSlaveryIntroEND",
		
		"SoftSlaveryChangeName",
		"SoftSlaveryChangeNameEND",
		
		"SoftSlaveryAttackReaction",
		"SoftSlaveryAttackLost",
		"SoftSlaveryAttackWon",
		
		"SoftSlaveryAskedFreedom",
		"SoftSlaveryAskedFreedomPay",
		"SoftSlaveryAskedFreedomEND",
		
		"SoftSlaveryTalkStart",
		
		"SoftSlaveryProtectedByFriendStart",
		"SoftSlaveryProtectedByFriendResponse",
		"SoftSlaveryProtectedByFriendAllGoodResp",
		"SoftSlaveryProtectedByFriendLost",
		"SoftSlaveryProtectedByFriendWonThank",
		
		"SoftSlaveryChokeOutStart",
		"SoftSlaveryChokeOutEndured",
		"SoftSlaveryChokeOutPCWon",
		"SoftSlaveryChokeOutPCLost",
		"SoftSlaveryChokeOutPCLostSex",
		
		"SoftSlaveryFuckStart",
		"SoftSlaveryFuckResultGood",
		"SoftSlaveryFuckResultOkay",
		"SoftSlaveryFuckResultBad",
		
		"SoftSlaveryFuckNemesisApproach",
		"SoftSlaveryFuckNemesisAsk",
		"SoftSlaveryFuckNemesisAnswer",
		"SoftSlaveryFuckNemesisYes",
		"SoftSlaveryFuckNemesisNo",
		
		"SoftSlaveryFuckJealousStart",
		"SoftSlaveryFuckJealousFight",
		"SoftSlaveryFuckJealousOwnerWon",
		"SoftSlaveryFuckJealousOwnerWonFuck",
		"SoftSlaveryFuckJealousOwnerLostOffer",
		"SoftSlaveryFuckJealousOwnerLostOffer2",
		"SoftSlaveryFuckJealousOwnerLostOfferAgree",
		"SoftSlaveryFuckJealousOwnerLostOfferAgree2",
		"SoftSlaveryFuckJealousOwnerLostOfferNope",
		
		"SoftSlaverySlutwallStart",
		"SoftSlaverySlutwallLocked",
		
		"SoftSlaveryStocksStart",
		"SoftSlaveryStocksLocked",
		
		"SoftSlaveryGiveCreditsStart",
		"SoftSlaveryGiveCreditsTake",
		"SoftSlaveryGiveCreditsShort",
		
		"SoftSlaveryMarkingStart",
		"SoftSlaveryMarkingEnough",
		"SoftSlaveryMarkingAnother",
		"SoftSlaveryMarkingNoStart",
		"SoftSlaveryMarkingNo",
		"SoftSlaveryMarkingNoFail",
		"SoftSlaveryMarkingBegYes",
		"SoftSlaveryMarkingBegYes2",
		"SoftSlaveryMarkingBegNo",
		"SoftSlaveryMarkingBegNo2",
		"SoftSlaveryMarkingBegCredits",
		"SoftSlaveryMarkingBegCreditsGive",
		"SoftSlaveryMarkingBegCreditsGive2",
		"SoftSlaveryMarkingBegNoMarked",
		"SoftSlaveryMarkingBegFoot",
		"SoftSlaveryMarkingBegFootKiss",
		"SoftSlaveryMarkingBegFootKiss2",
		"SoftSlaveryMarkingBegHumiliation",
		"SoftSlaveryMarkingBegHumiliation2",
		"SoftSlaveryMarkingBegHumiliation3",
		"SoftSlaveryMarkingBegHumiliation4",
		"SoftSlaveryMarkingNotDone",
		"SoftSlaveryMarkingNotDoneStocks",
		"SoftSlaveryMarkingNotDoneStocks2",
		"SoftSlaveryMarkingNotDoneUrinal",
		"SoftSlaveryMarkingNotDoneUrinal2",
		
		"SoftSlaveryParadeAroundStart",
		"SoftSlaveryParadeAroundFirst",
		"SoftSlaveryParadeAroundMore",
		"SoftSlaveryParadeAroundLast",
		"SoftSlaveryParadeAroundFree",
		"SoftSlaveryParadeAroundEatGagged",
		"SoftSlaveryParadeAroundEat",
		"SoftSlaveryParadeAroundPlatform",
		"SoftSlaveryParadeAroundShower",
		
		"SoftSlaveryThreesomeStart",
		
		"SoftSlaveryPunishCredits",
		"SoftSlaveryPunishCredits2",
		
		"SoftSlaveryPunishRipClothes",
		
		"SoftSlaveryPunishRoughSex",
		"SoftSlaveryPunishRoughSexPCWon",
		"SoftSlaveryPunishRoughSexEnded",
		
		"SoftSlaveryPunishSlutwall",
		"SoftSlaveryPunishSlutwallLock",
		
		"SoftSlaveryPunishStocks",
		"SoftSlaveryPunishStocksLock",
		"SoftSlaveryPunishStocksAsk",
		"SoftSlaveryPunishStocksAskNope",
		"SoftSlaveryPunishStocksAskNoBuy",
		"SoftSlaveryPunishStocksAskNoBuy2",
		"SoftSlaveryPunishStocksAskNoBuy3",
		"SoftSlaveryPunishStocksAskSure",
		"SoftSlaveryPunishStocksAfterSex",
		"SoftSlaveryPunishStocksAfterBadSex",
		"SoftSlaveryPunishStocksAfterBadSex2",
		"SoftSlaveryPunishStocksOwnerLost",
		"SoftSlaveryPunishStocksOwnerLost2",
		"SoftSlaveryPunishStocksOwnerLost3",
		"SoftSlaveryPunishStocksOwnerWon",
		"SoftSlaveryPunishStocksOwnerWon2",
		"SoftSlaveryPunishStocksOwnerWon3",
		"SoftSlaveryPunishStocksOwnerWon4",
		
		"SoftSlaveryPunishSell",
		"SoftSlaveryPunishSell2",
		
		"SoftSlaveryPunishGB",
		"SoftSlaveryPunishGBGiveup",
		"SoftSlaveryPunishGBOffer",
		"SoftSlaveryPunishGBSure",
		"SoftSlaveryPunishGBFollow",
		"SoftSlaveryPunishGBSubOffer",
		"SoftSlaveryPunishGBSubOfferYes",
		"SoftSlaveryPunishGBSubOfferNo",
		"SoftSlaveryPunishGBSubOfferNoAw",
		"SoftSlaveryPunishGBNo",
		"SoftSlaveryPunishGBNoReact",
		"SoftSlaveryPunishGBStart",
		"SoftSlaveryPunishGBEnd",
		
		"SoftSlaveryPunishLockRestraint",
		"SoftSlaveryPunishLockRestraint2",
		"SoftSlaveryPunishLockRestraint3",
		
		"SoftSlaveryResist",
		
		"SoftSlaveryFuckInStocksExtra",
		"SoftSlaveryFuckInStocksExtraYes",
		"SoftSlaveryFuckInStocksExtraNo",
		"SoftSlaveryFuckInStocksExtraNo2",
		"SoftSlaveryFuckInStocksExtraFree",
		"SoftSlaveryFuckInStocksExtraFreeLost",
		
		"SoftSlaveryParadeFuckOffer",
		"SoftSlaveryParadeFuckOfferYes",
		"SoftSlaveryParadeFuckOfferYesThree",
		"SoftSlaveryParadeFuckOfferNo",
		"SoftSlaveryParadeFuckOfferNo2",
		"SoftSlaveryParadeFuckOfferGood",
		"SoftSlaveryParadeFuckOfferFight",
		"SoftSlaveryParadeFuckOfferWon",
		"SoftSlaveryParadeFuckOfferLostWatch",
		"SoftSlaveryParadeFuckOfferLostBoth",
		
		"SoftSlaveryParadeGuard",
		"SoftSlaveryParadeGuardPunish",
		"SoftSlaveryParadeGuardPunish2",
		"SoftSlaveryParadeGuardProblem",
		"SoftSlaveryParadeGuardProblem2",
		"SoftSlaveryParadeGuardWon",
		"SoftSlaveryParadeGuardLost",
		
		"SoftSlaveryGB",
		"SoftSlaveryGBGiveup",
		"SoftSlaveryGBOffer",
		"SoftSlaveryGBSure",
		"SoftSlaveryGBFollow",
		"SoftSlaveryGBSubOffer",
		"SoftSlaveryGBSubOfferYes",
		"SoftSlaveryGBSubOfferNo",
		"SoftSlaveryGBSubOfferNoAw",
		"SoftSlaveryGBNo",
		"SoftSlaveryGBNoReact",
		"SoftSlaveryGBStart",
		"SoftSlaveryGBEnd",
		
		"SoftSlaveryLockRestraint",
		"SoftSlaveryLockRestraint2",
		"SoftSlaveryLockRestraint3",
		"SoftSlaveryOfferGearUnlock",
		"SoftSlaveryOfferGearUnlock2",
		"SoftSlaveryOfferGearUnlockKeep",
		"SoftSlaveryOfferGearUnlockKeep2",
		"SoftSlaveryNoticedNoGear",
		"SoftSlaveryNoticedNoGear2",
		
		"SoftSlaveryAskSex",
		"SoftSlaveryAskFuckOwner",
		"SoftSlaveryAskFuckOwnerBad",
		"SoftSlaveryAskFuckOwnerOkay",
		"SoftSlaveryAskFuckOwnerGood",
		
		"SoftSlaveryPetFuck",
		"SoftSlaveryPetWalkies",
		"SoftSlaveryPetWalkiesReady",
		"SoftSlaveryWalkiesCorrect",
		"SoftSlaveryWalkiesWrong",
		"SoftSlaveryWalkiesBark",
		"SoftSlaveryWalkiesPet",
		"SoftSlaveryWalkiesGoodPuppy",
		"SoftSlaveryWalkiesGoodPuppySex",
		"SoftSlaveryWalkiesBadPuppy",
		"SoftSlaveryWalkiesBadPuppyObey",
		"SoftSlaveryWalkiesLostNotDone",
		"SoftSlaveryWalkiesBiteProtect",
		"SoftSlaveryWalkiesBiteBad",
		"SoftSlaveryWalkiesBiteAttack",
		"SoftSlaveryWalkiesBall",
		"SoftSlaveryWalkiesBall2",
		"SoftSlaveryWalkiesPraise",
		"SoftSlaveryWalkiesBallTooFarFake",
		"SoftSlaveryWalkiesBallTooFar",
		"SoftSlaveryWalkiesNoBallFound",
		
		"SoftSlaveryBegUnlockNo",
		"SoftSlaveryBegUnlockYes",
		"SoftSlaveryBegUnlockDone",
		
		#"SoftSlavery",
	]

func getText(_id:String, _args:Dictionary):
	if(_id == "SoftSlaveryOffer"):
		return [
			"На тебе так и просятся цепи. Хочешь стать моей рабыней?",
			"Мне нужна тюремная сучка. Ты подойдёшь. Не заставляй меня ждать.",
			"Как насчёт того, чтобы принести пользу и стать моей рабыней?",
			"Ты выглядишь так, будто отчаянно нуждаешься в хозяине. Пожалуй, я смогу тебя терпеть.",
			"Давай не будем тратить моё время. Хочешь быть моей рабыней? Мне как раз не помешала бы хорошая тюремная сучка.",
			"На тебе так и написано: «коврик для ног». Хочешь доказать, что я права? Мне бы пригодилась послушная тюремная сучка.",
		]
	if(_id == "SoftSlaveryOfferYes"):
		return [
			"Хорошо. А теперь шевелись.",
			"Долго же ты копалась. Не отставай.",
			"Ладно. Может, ты не совсем безнадёжна. Иди за мной.",
			"Наконец-то. Постарайся не отставать.",
			"Твоя жизнь только что стала куда интереснее. По крайней мере, моя. Иди за мной.",
			"Отлично. А то я уже начала скучать. Постарайся не разочаровать меня.",
			"Не заставляй меня пожалеть об этом. Иди за мной.",
		]
	if(_id == "SoftSlaveryPCOffer"):
		return [
			"Тебе случайно не нужна тюремная сучка?",
			"Я ищу хозяина. Ты вполне подходишь на эту роль.",
			"Тебе не пригодилась бы тюремная сучка? Я свободна.",
			"Я хочу кому-нибудь служить. Хочешь владеть мной? Если скажешь «нет», я могу и укусить.",
			"Нужен кто-то, кто будет тебе подчиняться? Я могла бы притворяться твоей рабыней, если будешь ко мне достаточно добр.",
			"Из меня вышла бы отличная тюремная сучка. Нет, лучшая. Интересует?",
			"Я предлагаю себя в рабство. Ну что скажешь, ублюдок? Доволен?",
			"Мне нужен хозяин. Возьмешь меня себе в тюремные сучки? И лучше бы тебе сказать «да», блядь.",
		]
	if(_id == "SoftSlaveryPCOfferYes"):
		return [
			"Ладно. Мне как раз не помешало бы что-нибудь для истязаний. Иди за мной.",
			"Тебе повезло, я сегодня в хорошем настроении. Иди сюда.",
			"Хорошо. Мне нужна рабыня. Не разочаруй меня.",
			"Пойдет. Это может быть слегка развлекательно. Следуй за мной.",
			"Окей. Но ты пожалеешь, если от тебя будет больше проблем, чем пользы.",
			"Ладно. Тюремная сучка мне бы не помешала. Сойдешь. Иди сюда.",
		]
	if(_id == "SoftSlaveryPCOfferNo"):
		return [
			"Нет. У меня есть стандарты.",
			"Категорически нет. Сама мысль об этом отвратительна.",
			"Не смей оскорблять меня таким предложением.",
			"Лучше уж буду один, чем со мной рядом будет ошиваться такая рабыня, как ты.",
			"Пасс. Я не собираю мусор.",
		]
	if(_id == "SoftSlaveryIntro1Willing"):
		return [
			"Добро пожаловать в твою новую жизнь.",
			"Начнем. Слушай внимательно.",
			"Пора тебе усвоить свое место.",
			"Теперь ты узнаешь, на что ты годен на самом деле.",
			"Давай-ка я распишу тебе твое жалкое новое существование.",
			"Я объясняю всё только один раз.",
		]
	
	if(_id == "SoftSlaveryIntro1"):
		return [
			"Наконец-то очнулся, ублюдок?",
			"Да открой ты уже свои гребаные глаза. Знаю, что ты притворяешься.",
			"Вернулась в реальность, шлюшка? Добро пожаловать в ад.",
			"Эй, игрушка для траха. Голова кружится? Отлично.",
			"Подъем, соня. Твой сладкий сон подошел к концу.",
			"Утро, ублюдок. Смотри на меня. Живо.",
			"Вставай, блять! Тебе больше не позволено дрыхнуть.",
			"Наконец-то. А теперь слушай сюда, блять.",
			"Докажи, что ты жива, сучка. Посмотри на меня.",
			"Хорошо, ты очнулась. Только попробуй, блять, снова вырубиться.",
			"Наконец-то, черт возьми. Ты хоть знаешь, как скучно на тебя пялиться?",
			"Смотрите-ка, кто наконец соизволил проснуться. Бесполезная шлюха.",
			"А вот и ты. Я уже собиралась вылить на тебя ведро воды.",
		]
	if(_id == "SoftSlaveryIntro2"):
		return [
			"С этого момента ты — моя собственность, моя {npc.npcSlave}. Усек?",
			"Слушай сюда, блядь, {npc.npcSlave}. Ты. Принадлежишь. Мне. Слышишь?",
			"Твоя свобода закончилась, {npc.npcSlave}. Теперь ты — вещь, которую можно использовать. Ясно?",
			"Давай вдолбим это в твою толстую черепушку, {npc.npcSlave}. Теперь ты принадлежишь мне. Слышишь?",
			"Твоя жизнь теперь принадлежит мне, ублюдок. Ты — моя {npc.npcSlave}. Ты это понимаешь?",
			"Слушай сюда, блядь, {npc.npcSlave}. Теперь ты принадлежишь мне. До последнего дюйма. Понял?",
			"Твоей жизни, сука, пришел конец. Теперь ты моя {npc.npcSlave}, жалкое ничтожество. Слышишь меня?",
			"Свобода — это теперь просто ебаное воспоминание. Ты моя, {npc.npcSlave}. Слышишь?",
			"Давай я разжую это для твоей тупой задницы. Ты. Моя. {npc.npcSlave}. И ничего больше. Ты, блядь, меня слышишь?",
			"С этого момента ты — рабыня. Моя {npc.npcSlave}. Ты существуешь только для того, чтобы служить мне. Поняла?",
		]
	if(_id == "SoftSlaveryIntro3"):
		return [
			"Ты будешь слушаться каждого, блядь, моего слова. Или я заставлю тебя пожалеть о том, что ты вообще родилась.",
			"Делай в точности то, что я прикажу, сучка. Откажешься — и я тебя сломаю. Всё предельно просто.",
			"Твоя единственная цель — подчиняться мне. Попробуй только вякнуть — и мне придётся тебя наказать.",
			"Попробуй только сопротивляться. Блядь, да я тебе даже позволю! Это лишь даст мне повод хорошенько тебя отпороть.",
			"Твоя единственная задача — слушаться. Ошибёшься — и я буду наказывать тебя до тех пор, пока ты собственное имя не забудешь.",
		]
	if(_id == "SoftSlaveryIntroEND"):
		return [
			"Я буду приглядывать за тобой. И не, блядь, забывай, кто твоя хозяйка.",
			"Мои глаза всегда следят за тобой, {npc.npcSlave}. Не забывай о своём владельце.",
			"Я буду заходить, чтобы использовать тебя. Не забывай, что ты — моя.",
			"Я буду видеть тебя регулярно. И помни: твоё место — у моих ног.",
			"Я буду заходить с проверками. Мысль обо мне должна быть твоим постоянным ужасом.",
			"Я буду заглядывать к тебе. Лучше будь готов(а) служить.",
			"Побега не существует. Я найду тебя и напомню тебе, кто ты есть на самом деле.",
			"Не вздумай прятаться, ты принадлежишь мне. Я еще вернусь, чтобы использовать свой {npc.npcSlave}, запомни это.",
			"Я буду часто проверять свой {npc.npcSlave}. Будь готов(а) к тому, что тебя будут использовать.",
		]

	if(_id == "SoftSlaveryChangeName"):
		return [
			"И как же мне тебя называть, {npc.npcSlave}?",
			"Дай мне имя, чтобы я мог(ла) над тобой издеваться, {npc.npcSlave}.",
			"Скажи, как тебя называть, пока я не окрестил(а) тебя просто «Пиздой».",
			"Выплюни какое-нибудь имя, {npc.npcSlave}. Мне нужно что-то, что я буду выкрикивать, когда буду тебя наказывать.",
			"Какое имя мне использовать, когда я буду тебя трахать? Говори.",
			"Можешь выбрать себе имя, {npc.npcSlave}. Это не сделает тебя менее моей собственностью.",
		]
	if(_id == "SoftSlaveryChangeNameEND"):
		return [
			"Ладно. Ты моя {npc.npcSlave}, и ничего больше.",
			"Конечно. Могу звать тебя {npc.npcSlave}, если это достаточно унизительно для тебя.",
			"Хорошо. И помни, что это имя — всё, что у тебя осталось, {npc.npcSlave}.",
		]

	if(_id == "SoftSlaveryAttackReaction"):
		return [
			"Тупая ебаная сука! Ты за это заплатишь, {npc.npcSlave}!",
			"Как ты СМЕЕШЬ прикасаться ко мне, никчемная {npc.npcSlave}!",
			"Ну всё! За такое я тебя сломаю!",
			"Ты только что подписала себе смертный приговор на пытки, {npc.npcSlave}!",
			"Большая ошибка, {npc.npcSlave}! Теперь ты по-настоящему познаешь страдания!",
		]
	if(_id == "SoftSlaveryAttackLost"):
		return [
			"Pathetic.. really..",
			"Это было всё, на что ты способна? Ты всё еще моя собственность, {npc.npcSlave}.",
			"Фух.. Ты всё ещё моя {npc.npcSlave}.",
			"Ну ты и тупица.. Ты всё ещё моя, {npc.npcSlave}.",
			"Ты реально думал, что это сработает? Ну ты и тупой..",
			"Смело, но глупо..",
			"Столько усилий, а ты всё такая же никчёмная..",
			"Сдайся, мусор. Ты была рождена, чтобы быть моей {npc.npcSlave}.. ты и сама это знаешь.. фух..",
		]
	if(_id == "SoftSlaveryAttackWon"):
		return [
			"Сейчас я научу тебя твоему грёбаному месту, {npc.npcSlave}!",
			"Пора преподать тебе урок, дерзкое ты кусок дерьма!",
			"Хотел драки? Теперь получишь грёбаный урок!",
			"Я буду наслаждаться каждой секундой твоего наказания, {npc.npcSlave}!",
		]

	if(_id == "SoftSlaveryAskedFreedom"):
		return [
			"Свобода? Думаешь, ты её заслуживаешь, ничтожная {npc.npcSlave}? Неужели?",
			"Хочешь на волю? Думаешь, я должна отпустить свою любимую {npc.npcSlave}?",
			"Оставить мою защиту? Без меня ты сдохнешь за пару часов, {npc.npcSlave}. Ты этого реально хочешь?",
			"Без меня ты — пустое место, {npc.npcSlave}. Думаешь, сможешь выжить там, снаружи?",
		]
	if(_id == "SoftSlaveryAskedFreedomPay"):
		return [
			"Твоя свобода стоит <CREDITS>, {npc.npcSlave}. Хотя тебе столько и не положено.",
			"Заплати мне <CREDITS>, и, может быть, я подумаю о том, чтобы отпустить мою {npc.npcSlave}.",
			"<CREDITS>, или завали ебало про свободу, {npc.npcSlave}.",
			"С тебя <CREDITS>, если хочешь свалить, {npc.npcSlave}.",
			"Думаешь, сможешь откупиться? <CREDITS> могут меня убедить, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryAskedFreedomEND"):
		return [
			"Ладно. А теперь съебись с глаз моих, мусор. Живи свою тупую жизнь.",
			"Наконец-то. Теперь я смогу найти раба попослушнее. Наверное.",
			"Ладно. Проваливай уже. Может, я даже тебя запомню.",
			"Мгм. И не вздумай ползти обратно, когда поймешь, что ты никому не нужен.",
			"Наконец-то от тебя есть хоть какая-то польза — ты уходишь. А теперь съебись. Было весело тебя знать.",
		]

	if(_id == "SoftSlaveryTalkStart"):
		return [
			"Какого хуя тебе надо, {npc.npcSlave}?",
			"Говори, ничтожество {npc.npcSlave}. Надеюсь, это действительно важно.",
			"Ты меня прерываешь, {npc.npcSlave}. Надеюсь, это, блять, что-то стоящее.",
			"Живее, {npc.npcSlave}. Мое терпение тоньше, чем твоя полезность.",
			"Не трать мое ебаное время. Что такое, {npc.npcSlave}?",
			"Чего ты ко мне пристаешь, {npc.npcSlave}? Выкладывай уже.",
			"У тебя пять секунд, чтобы изложить суть дела, {npc.npcSlave}.",
			"Разговариваешь со мной без разрешения, {npc.npcSlave}? Надеюсь, это, блять, чрезвычайная ситуация.",
		]

	if(_id == "SoftSlaveryProtectedByFriendStart"):
		return [
			"Эй, ублюдок, что ты творишь с {pc.name}?",
			"Руки прочь от {pc.name}, сука. Какого хуя ты делаешь с {pc.him}?",
			"Ты! Тебе лучше оставить {pc.name} в покое, придурок.",
			"Какого хуя ты делаешь с {pc.name}? Отпусти {pc.him}.",
		]
	if(_id == "SoftSlaveryProtectedByFriendResponse"):
		return [
			"Это не твое, блять, дело. Проваливай прямо сейчас.",
			"Занимайся своими делами, пока тебе не причинили боль.",
			"Сунешь свой нос в мои дела — и я его сломаю.",
			"Тебя это не касается. Отъебись.",
			"Свали нахуй, пока я тебя не заставила.",
			"Ты сама напросилась. Проваливай.",
			"Вмешаешься — пожалеешь. Этот {npc.npcSlave} принадлежит мне.",
			"Еще одно слово, и ты пополнишь мою коллекцию. А теперь исчезни."
		]
	if(_id == "SoftSlaveryProtectedByFriendAllGoodResp"):
		return [
			"Ладно. Как хочешь.",
			"Ладно, фух. Продолжай, раз так.",
			"Тьфу. Как хочешь, сучка.",
			"Ну и отлично, пусть тебя насилуют, мне плевать.",
			"Меня устраивает. И больше не донимай меня.",
		]
	if(_id == "SoftSlaveryProtectedByFriendLost"):
		return [
			"А теперь ползи отсюда, пока я не решила оставить тебя себе.",
			"Свали нахуй с глаз моих, пока еще можешь.",
			"Беги уже, жалкая неудачница. И не вздумай больше меня испытывать.",
			"Исчезни, и еще скажи спасибо, что я тебя отпускаю.",
			"Проваливай. И если я снова увижу тебя рядом с моим {npc.npcSlave}, ты потеряешь гораздо больше, чем просто в драке.",
		]
	if(_id == "SoftSlaveryProtectedByFriendWonThank"):
		return [
			"Не за что.",
			"Да без проблем.",
			"Да ладно. Не стоит благодарности.",
			"Пустяки. Рада, что смогла помочь.",
			"Кто-то же должен это делать. Не за что.",
		]

	if(_id == "SoftSlaveryChokeOutStart"):
		return [
			"Моей ярости нужна груша для битья, и ты — счастливый {npc.npcSlave}, не так ли?",
			"У меня сегодня просто ебанутое настроение. И ты — тот никчемный {npc.npcSlave}, которому выпало на нем страдать.",
			"Мне нужно что-нибудь сломать. Стой смирно, блять, {npc.npcSlave}, и терпи.",
			"Всему этому гневу нужен выход. Ты станешь моим средством от стресса, {npc.npcSlave}.",
			"Ничто так не исправляет паршивый день, как возможность придушить непослушную {npc.npcSlave}.",
			"Ты будешь впитывать мой гнев, {npc.npcSlave}. Сопротивляйся — и мне это понравится еще больше.",
			"Пора тебе отрабатывать свое содержание, {npc.npcSlave}. Стань моей личной отдушиной для злости.",
		]
	if(_id == "SoftSlaveryChokeOutEndured"):
		return [
			"Хорошо. Стало легче. Ты выполнила свое предназначение, {npc.npcSlave}.",
			"Это немного разрядило обстановку. А теперь съебись с глаз моих, {npc.npcSlave}.",
			"Не думай, что если ты это пережила, то стала особенной. Ты всё еще всего лишь моя {npc.npcSlave}.",
			"Считай это привилегией, {npc.npcSlave}. Хоть раз в жизни от тебя была польза.",
			"Ладно. Можешь идти. Но мои руки будут помнить ощущение твоего горла, {npc.npcSlave}.",
			"Ты всё вытерпела. Молодец. А теперь ползи прочь, {npc.npcSlave}. Твоя полезность исчерпана.",
		]
	if(_id == "SoftSlaveryChokeOutPCWon"):
		return [
			"Да пошла ты, дерзкая кусок дерьма. Это еще не конец.",
			"Тебе повезло, {npc.npcSlave}. Но я заставлю тебя пожалеть об этом.",
			"Запомни этот момент, {npc.npcSlave}. Это твоя последняя победа в жизни.",
			"Глупая, упрямая {npc.npcSlave}. За это я с особым удовольствием тебя сломаю.",
			"Даже не смей думать, что это что-то меняет. Ты всё еще моя собственность.",
			"Запомни мои слова, {npc.npcSlave}. Я подчиню себе твой боевой дух и раздавлю его.",
		]
	if(_id == "SoftSlaveryChokeOutPCLost"):
		return [
			"Жалкое зрелище. Даже не смогла не спать во время порки, {npc.npcSlave}.",
			"Бесполезная. Сдалась, как дешевая шлюха.",
			"Посмотри на себя. В отключке. Ты разочарование даже в роли боксерской груши, {npc.npcSlave}.",
			"В беспамятстве? Да я толком и не начинал, кусок слабого мусора.",
			"Ну конечно, ты вырубилась. Даже когда это важно, ты не можешь быть годной {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryChokeOutPCLostSex"):
		return [
			"Теперь ты даже сопротивляться не можешь.",
			"По крайней мере, так ты ведешь себя тихо.",
			"Наконец-то ты ведешь себя как послушная {npc.npcSlave}.",
			"Впрочем, это всё, на что ты годна.",
			"Ты ничего не почувствуешь. Хотя твои чувства всё равно никого не волнуют.",
			"Посмотрим, сколько пользы я смогу из тебя выжать, пока ты не очнулась.",
		]

	if(_id == "SoftSlaveryFuckStart"):
		return [
			"Я хочу трахаться. А ну тащи свою задницу сюда, {npc.npcSlave}. Живо.",
			"Блядь, как же меня штырит. Иди сюда, {npc.npcSlave}, пока я тебя за волосы не приволок.",
			"На колени, {npc.npcSlave}. Сейчас я буду тебя использовать.",
			"Мне нужно в кого-нибудь вставиться. Считай, что тебе повезло, что это будешь ты, {npc.npcSlave}.",
			"Не стой столбом, {npc.npcSlave}. А ну, иди сюда и обслужи меня.",
		]
	if(_id == "SoftSlaveryFuckResultGood"):
		return [
			"На этот раз ты меня не совсем разочаровал(а). Но не привыкай к этому, {npc.npcSlave}.",
			"Ладно. Ты выполнил(а) свою задачу. Может, я даже использую тебя снова.",
			"Не зря потратил(а) время. Запомни это чувство, {npc.npcSlave}, — это лучшее, на что ты способен(на) в жизни.",
			"Приемлемо. Может, ты всё-таки начинаешь понимать своё место, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryFuckResultOkay"):
		return [
			"Едва достаточно. В следующий раз постарайся получше, иначе я найду способ тебя мотивировать, {npc.npcSlave}.",
			"Посредственно. Это правда всё, на что ты способен(на), {npc.npcSlave}?",
			"Тебе повезло, что я пришла. Твои старания были жалкими, {npc.npcSlave}.",
			"Скучновато. Постарайся получше, когда в следующий раз я решу удостоить тебя своим вниманием, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryFuckResultBad"):
		return [
			"Бесполезный(ая). Ты даже на быстрый трах не годен(на), {npc.npcSlave}.",
			"Ты думал, это было приемлемо? Ты еще тупее, чем кажешься, {npc.npcSlave}.",
			"Абсолютно жалко. Мне было веселее трахать шлюз, чем тебя, {npc.npcSlave}.",
			"Ты просто позорище. Надо бы выкинуть тебя в космос и найти себе {npc.npcSlave}, которая знает, что делает.",
		]
	if(_id == "SoftSlaveryFuckNemesisApproach"):
		return [
			"Ну надо же. Неужели это наша новая сучка.",
			"Смотрите, кого притащило. Видимо, наконец-то нашла свое место под солнцем, а?",
			"О, какой приятный сюрприз. Видеть тебя в таком состоянии — прямо греет душу.",
			"Какая встреча. Я всегда знала, что ты в итоге станешь чьей-то собственностью.",
			"Боже мой. Как же великие пали. Или ты всегда была такой жалкой?",
		]
	if(_id == "SoftSlaveryFuckNemesisAsk"):
		return [
			"Какого хера тебе надо? Выкладывай быстрее.",
			"Говори быстрее. Я занята тем, что ставлю эту {npc.npcSlave} на ее {pc.his} место.",
			"Прервешь меня еще раз — пожалеешь. Чего тебе?",
			"Давай побыстрее. Мой {npc.npcSlave} ждет {pc.his} урока.",
		]
	if(_id == "SoftSlaveryFuckNemesisAnswer"):
		return [
			"Это дерьмо меня подставило. Не хочешь вместе проучить {pc.him}?",
			"Твоя собственность задолжала мне. Давай заставим {pc.him} отдуваться. Прямо сейчас.",
			"Я хочу кусочек твоего раба за то, что натворил {pc.he}. Давай сломаем {pc.him} вместе.",
			"Твоему рабу пора знать свое {npc.his} место после того, что он со мной сделал. Предлагаю помочь тебе это устроить.",
		]
	if(_id == "SoftSlaveryFuckNemesisYes"):
		return [
			"Ладно. Посмотрим, сколько выдержит эта {npc.npcSlave}.",
			"Хорошая идея. Эта никчемная {npc.npcSlave} заслуживает двойного внимания.",
			"Ладно. Я в деле.",
			"А почему бы и нет? Давай, блядь, сделаем это!",
		]
	if(_id == "SoftSlaveryFuckNemesisNo"):
		return [
			"Отъебись. Моя {npc.npcSlave} — мои правила. Я не делюсь.",
			"Без шансов. Я ломаю свою собственность сам. А теперь свали.",
			"Руки держи при себе. Эту {npc.npcSlave} буду портить только я.",
			"Нет. Мне не нужна твоя помощь, чтобы поставить эту {npc.npcSlave} на {pc.his} место.",
			"Свали в туман. Эту {npc.npcSlave} буду трахать только я.",
		]

	if(_id == "SoftSlaveryFuckJealousStart"):
		return [
			"Эй! Это моя {npc1.npcSlave}! Убери свои ебаные руки от {pc.him}!",
			"Какого хуя ты творишь с моей собственностью? Эта {npc1.npcSlave} принадлежит мне!",
			"Эй, кусок дерьма! Эта {npc1.npcSlave} моя! Отъебись от неё нахуй!",
			"Тронешь мою {npc1.npcSlave} еще раз — и я тебе, блять, руки переломаю!",
			"Ты что, смерти ищешь, раз так лезешь к моей {npc1.npcSlave}?",
		]
	if(_id == "SoftSlaveryFuckJealousFight"):
		return [
			"Свали нахер отсюда, пока я тебя не заставила. Эта {npc.npcSlave} — моя.",
			"Это моя {npc.npcSlave}, ничтожество ебаное. Уходи сейчас же, иначе потом будешь уползать на карачках.",
			"Забудь об этой рабыне. Эта {npc.npcSlave} принадлежит мне.",
			"Проваливай, мудак. Это моя {npc.npcSlave}, а не твоя.",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerWon"):
		return [
			"Видишь? Эта {npc.npcSlave} — блядь моя. И никогда об этом не забывай.",
			"Пусть это будет тебе уроком. {pc.He} — {pc.isAre} моя собственность. А теперь съебись нахер.",
			"Ты проиграл, жалкое дерьмо. Моя {npc.npcSlave} остается со мной. А теперь ползи отсюда.",
			"Твоему тупому мозгу достаточно ясно? {pc.He} — {pc.verb('belong')} мне. А теперь съебись.",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerWonFuck"):
		return [
			"Не стоило лезть к тому, что принадлежит мне. Теперь вы обе — мои личные игрушки.",
			"Ты сама на это напросилась. Теперь вместо одной сучки мне придется ломать сразу двух.",
			"Неверный ход, мудак. Теперь я с удовольствием сломаю вас обоих.",
			"Ты только что вызвался стать моей второй {npc.npcSlave}. Надеюсь, ты готов к тому, что тебя будут трахать.",
			"Идеально. Теперь у меня в два раза больше дырок, чтобы в них ебаться. А ну, живо сюда, оба!",
			"Я возбуждена, и вы оба будете с этим разбираться. Считайте это своим наказанием."
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOffer"):
		return [
			"Погоди! Блядь... слушай, может, мы могли бы разделить эту маленькую {npc.npcSlave}?",
			"Притормози! Прежде чем ты сделаешь какую-нибудь глупость... нам обоим не помешала бы эта {npc.npcSlave}.",
			"Стой! Давай рассуждать здраво... {npc.npcSlave} может служить двум господам, верно?",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOffer2"):
		return [
			"Эта гребаная {npc.npcSlave} — та самая, что наврала нам обоим! Давайте заставим {pc.him} за это заплатить.",
			"Эта лживая мелкая сучка так и не сказала мне о тебе. Давай накажем {pc.him} вместе.",
			"Эта сучка {npc.npcSlave} обвела нас обоих вокруг пальца. Не думаешь, что {pc.he} {pc.verb('deserve')} за это?",
			"Рабыня — вот главная проблема. Давай преподадим {pc.him} такой урок, который {pc.he} не забудет.",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferAgree"):
		return [
			"Может, в твоих словах и есть смысл.",
			"Блядь, а ведь это реально логично.",
			"Ладно, я слушаю.",
			"Вот это, сука, идея, которую я могу поддержать.",
			"Может, нам стоит объединиться в этом деле?",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferAgree2"):
		return [
			"Давай заставим эту мелкую дрянь пожалеть обо всем на свете.",
			"Ладно. Давай сломаем эту лживую шлюху вместе.",
			"По рукам. А теперь давай по-настоящему повеселимся с этой сучкой.",
		]
	if(_id == "SoftSlaveryFuckJealousOwnerLostOfferNope"):
		return [
			"Хорошая попытка, жалкое ты чмо. Я просто получу удовольствие от вас обеих.",
			"Ты в отчаянии. Это мило. Теперь вы оба будете служить мне.",
			"Твои мольбы только раззадорили меня. Я возьму вас обоих.",
			"Отличная идея. Я её улучшу. Вы оба будете стоять передо мной на коленях.",
		]

	if(_id == "SoftSlaverySlutwallStart"):
		return [
			"А ну иди сюда. Сегодня я запихну тебя в стену шлюх. И не смей, блядь, дергаться, {npc.npcSlave}.",
			"Стена шлюх зовет тебя. Только попробуй брыкаться, {npc.npcSlave}.",
			"Шевели поршнями, {npc.npcSlave}. Ты отправляешься в стену шлюх, и я не желаю слышать ни единого ебаного слова.",
			"Сегодня ты моя секс-игрушка в стене шлюх. Подставь шею, никчемная {npc.npcSlave}.",
			"Твоя задница принадлежит мне, и сегодня я использую её в стене шлюх. Не дергайся, {npc.npcSlave}.",
			"Будь хорошей маленькой {npc.npcSlave} и тащи свою жопу к стене шлюх. Живо.",
		]
	if(_id == "SoftSlaverySlutwallLocked"):
		return [
			"Ну вот, ты заперта, жалкая {npc.npcSlave}. Посмотрим, сколько ты сможешь вытерпеть.",
			"Идеально. Загнанная в угол и беспомощная. Именно такой я и люблю свою {npc.npcSlave}.",
			"Посмотри на себя. Теперь тебе не сбежать, {npc.npcSlave}. Пора брать урок.",
			"Скованная цепями и готовая к использованию. Вот для чего ты была создана, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryStocksStart"):
		return [
			"А ну иди сюда. Колодки уже ждут, и все будут смотреть, как я тебя ломаю. Не брыкайся, {npc.npcSlave}.",
			"Сегодня ты отправишься в колодки, {npc.npcSlave}. Вся станция увидит, какая ты шлюха.",
			"Шевелись, {npc.npcSlave}. Я выставлю тебя напоказ в колодках. Попробуй только дернуться — и я сделаю тебе еще больнее.",
			"Сегодня ты моя публичная игрушка для секса. Все увидят тебя запертой в колодках. Выставь шею, {npc.npcSlave}.",
			"Так и подмывает унизить тебя в колодках на глазах у всех. Не дергайся, {npc.npcSlave}.",
			"Будь хорошей {npc.npcSlave} и тащи свою задницу к колодкам. Толпа жаждет зрелищ.",
		]
	if(_id == "SoftSlaveryStocksLocked"):
		return [
			"Даже не думай шевелиться. Теперь ты в моей власти, {npc.npcSlave}.",
			"Заперта и на виду у всех. Ты всего лишь игрушка, {npc.npcSlave}.",
			"Беспомощная и выставленная на обозрение всей станции. Теперь это твоя жизнь, {npc.npcSlave}.",
			"Ну вот, ты заперта... Давай устроим этим людям шоу, которое они не забудут, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGiveCreditsStart"):
		return [
			"Мне нужны <CREDITS>, блять, прямо сейчас. Живо отдавай, {npc.npcSlave}.",
			"Твои кредиты теперь мои. Немедленно гони <CREDITS>, {npc.npcSlave}.",
			"Ты сейчас же отдашь мне <CREDITS>. Не заставляй меня спрашивать дважды, никчемная {npc.npcSlave}.",
			"<CREDITS>. Живо. И чтобы я не слышала никаких ебаных оправданий, {npc.npcSlave}.",
			"Отдай мне <CREDITS>, жалкая {npc.npcSlave}. Это приказ.",
			"Считай, что это твоя единственная цель на сегодня. Сдавай <CREDITS>, {npc.npcSlave}.",
			"Я решила, что ты должна мне <CREDITS>. Плати сейчас же, {npc.npcSlave}.",
			"Будь хоть раз полезной в своей никчемной жизни и отдай мне <CREDITS> прямо сейчас, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGiveCreditsTake"):
		return [
			"Наконец-то, блядь. Может, ты не совсем бесполезная, {npc.npcSlave}.",
			"Наконец-то. Я уже начал думать, что придется выбивать их из тебя силой, {npc.npcSlave}.",
			"Хорошо. Ты только что избавила себя от кучи боли, {npc.npcSlave}.",
			"Пора бы тебе уже научиться подчиняться, {npc.npcSlave}.",
			"Долго же ты копалась. Не заставляй меня ждать в следующий раз, {npc.npcSlave}.",
			"Видишь? Послушание дается легче, чем наказание, {npc.npcSlave}.",
			"Ладно. А теперь помни, кому на самом деле принадлежат эти кредиты, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGiveCreditsShort"):
		return [
			"Ты смеешь недоплачивать? Ты об этом пожалеешь, {npc.npcSlave}.",
			"Недосдача? Ты, блядь, сама напрашиваешься на наказание, {npc.npcSlave}.",
			"Жалкое зрелище. Ты даже с этим не можешь справиться. Готовься страдать, {npc.npcSlave}.",
			"Разочаровываешь. Похоже, мне придется забрать оплату другим способом, {npc.npcSlave}."
		]

	if(_id == "SoftSlaveryMarkingStart"):
		return [
			"Я сейчас поставлю на тебе свою {npc.npcSlave}. И не дай бог тебе, блять, шелохнуться.",
			"Не дергайся, кусок дерьма. Это чтобы ты не забывал, кто твой хозяин.",
			"Даже не вздумай вздрагивать. Я украшаю свою собственность.",
			"Замри нахуй. Я сделаю так, чтобы вся тюрьма знала, кому ты принадлежишь.",
			"Смотри на меня и, блять, не моргай. Я мечу свою собственность.",
			"А ну иди сюда и заткнись. Ты отсюда не уйдешь, пока я не нанесу на тебя свою метку."
		]
	if(_id == "SoftSlaveryMarkingEnough"):
		return [
			"В самый раз. Теперь ты выглядишь как подобающая собственность.",
			"Хорошо. Теперь никто не перепутает, кому принадлежит эта {npc.npcSlave}.",
			"Идеально. Хорошо помеченная {npc.npcSlave} — счастливая {npc.npcSlave}.",
			"На сегодня хватит. Выглядишь почти сносно.",
			"Готово. Выглядит достаточно унизительно.",
			"Четкие линии. Грязный смысл. Как раз для такой {npc.npcSlave}, как ты.",
		]
	if(_id == "SoftSlaveryMarkingAnother"):
		return [
			"Думаешь, одного достаточно? А вот и нет.",
			"Хочешь еще? Жаль, но ты получишь их, хочешь ты того или нет.",
			"Достаточно? Это я решаю, когда достаточно. Добавим еще один.",
			"Я еще не закончил тебя осквернять.",
			"Хочешь еще один? Еще бы. Не дергайся.",
			"Я могла бы заниматься этим весь день... и, пожалуй, так и сделаю.",
			"Эти надписи делают тебя таким жалким. Давай добавим еще одну.",
			"Ты дернулся. Это стоит тебе еще одной.",
			"Ты пошевелился. Теперь мне придется разводить на тебе каракули.",
			"Еще одна тебя не убьет. А вот если снова дернешься — может.",
			"Твои страдания так забавляют. Получишь еще одну.",
		]
	if(_id == "SoftSlaveryMarkingNoStart"):
		return [
			"Да плевать, сегодня лень помечать этот мусор.",
			"Ладно. Пока оставлю тебя чистым. Но не расслабляйся.",
			"Не сегодня. Считай, что тебе повезло, ничтожный {npc.npcSlave}.",
			"Хорошо. В этот раз без надписей на теле. Но помни: ты всё еще принадлежишь мне.",
			"Хм. Может, сегодня позволю тебе остаться чистым. Но завтрашний день будет не таким милосердным.",
			"Будь благодарна, что сегодня я в милостивом настроении, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryMarkingNo"):
		return [
			"Ладно. На сегодня с украшательством покончено.",
			"Ладно. На этом всё. Выглядишь как подобает униженной сучке.",
			"На сегодня хватит. Будешь капризничать — я испишу тебя с ног до головы.",
			"Сойдет. Теперь ты выглядишь по-настоящему опозоренной.",
			"Я закончила. Надеюсь, все увидят это и поймут, кто ты такая.",
			"Окей. На данный момент ты достаточно помечена, чтобы не забывать своё место."
		]
	if(_id == "SoftSlaveryMarkingNoFail"):
		return [
			"Не испытывай моё терпение, кусок дерьма. Моя {npc.npcSlave} получает метки только тогда, когда я так скажу.",
			"Будешь дергаться — вырежу эти слова прямо на твоей коже. Стой смирно и терпи.",
			"Будешь сопротивляться — я завалю всё твоё тело надписями. А теперь не шевелись.",
			"Заткни свой ебаный рот. Я решу, когда мы закончим. Тебя ждет клеймо.",
		]
	if(_id == "SoftSlaveryMarkingBegYes"):
		return [
			"Твое жалкое нытье меня забавляет. Ладно, так уж и быть, проявлю милосердие.",
			"Ты выглядишь так мерзко, когда умоляешь. Ладно, только в этот раз.",
			"Твои мольбы настолько жалки, что даже развлекают. Ладно, только на этот раз.",
			"Умоляешь меня? Как в самый раз для {npc.npcSlave}. Ладно.",
		]
	if(_id == "SoftSlaveryMarkingBegYes2"):
		return [
			"Тогда на этом всё.",
			"Ладно. Мы закончили.",
			"Ты заслужил(а) временную отсрочку.",
			"Ладно. На этот раз я тебя отпущу.",
		]
	if(_id == "SoftSlaveryMarkingBegNo"):
		return [
			"Если уж собрался(ась) ныть, то встань на свои ебаные колени, где тебе и место.",
			"На колени. Вот так должен умолять приличный {npc.npcSlave}.",
			"Кто вообще умоляет стоя? На колени, {npc.npcSlave}!",
			"Хочешь умолять? Встань на колени и сделай это убедительно.",
			"Умоляй как никчемная {npc.npcSlave}, которой ты и являешься. На колени.",
		]
	if(_id == "SoftSlaveryMarkingBegNo2"):
		return [
			"На колени, живо.",
			"Ты меня слышала? Встань на колени, пока я не заставила тебя.",
			"На колени. Не заставляй меня повторять дважды.",
			"На колени. Прояви уже хоть каплю ебаного уважения.",
			"На колени. У меня нет на тебя весь день.",
		]
	if(_id == "SoftSlaveryMarkingBegCredits"):
		return [
			"Хорошо. А теперь гони 5 кредитов, иначе я раскрашу твою кожу.",
			"Хочешь, чтобы я остановилась? Плати 5 кредитов. Иначе сама знаешь, что будет.",
			"Живо отдавай 5 кредитов, или я займусь декорированием твоего никчемного тела.",
			"А теперь дай мне 5 кредитов, и, может быть, я тебя отпущу. Может быть.",
		]
	if(_id == "SoftSlaveryMarkingBegCreditsGive"):
		return [
			"Спасибо. Твои кредиты ценнее, чем ты сам(а).",
			"Хорошо. Такова цена твоего жалкого существования.",
			"Ладно. Сегодня я возьму твои кредиты вместо твоего достоинства.",
			"Неплохо. Твои кредиты покупают тебе временную отсрочку.",
			"Сойдет. Продолжай платить, если не хочешь мучиться.",
		]
	if(_id == "SoftSlaveryMarkingBegCreditsGive2"):
		return [
			"Думаю, на этом всё, {npc.npcSlave}.",
			"Пока на этом закончим, {npc.npcSlave}.",
			"Ладно. Мы закончили. Пока что, {npc.npcSlave}.",
			"Хорошо. Сгинь с глаз моих, пока я не передумал(а).",
		]
	if(_id == "SoftSlaveryMarkingBegNoMarked"):
		return [
			"Так тебе и надо за то, что испытываешь моё терпение. Наслаждайся своим новым декором.",
			"Да будет так. Носи эти метки как напоминание о своем месте.",
			"Ты сама напросилась. Теперь живи с последствиями.",
			"Такой швали, как ты, клеймо только впору. Будет помогать держать тебя в узде.",
			"Не ной. Ты сама это на себя навлекла.",
			"Это твое наказание. Носи его с позором.",
			"Ты хотела бунтовать? Ну вот, посмотри, каким ходячим позором ты стала.",
			"Считай это заслуженным унижением. И не смей жаловаться."
		]
	if(_id == "SoftSlaveryMarkingBegFoot"):
		return [
			"Хорошо. А теперь целуй мой {npc.foot}. Поклоняйся мне, если не хочешь, чтобы тебя изуродовали.",
			"Ладно. А теперь целуй мой {npc.foot}. Будь послушной {npc.npcSlave}, иначе я раскрашу тебя, как настоящую шлюху.",
			"А теперь унизься как следует. Целуй мой {npc.foot}. Живо!",
			"Думаешь, на этом всё? Сначала поцелуй мою {npc.foot}. Моя собственность должна меня боготворить.",
		]
	if(_id == "SoftSlaveryMarkingBegFootKiss"):
		return [
			"Жалкое зрелище. Ты ведь сделаешь всё что угодно, лишь бы не получить клеймо, верно?",
			"Такое приятное зрелище. Бесполезная {npc.npcSlave} на своём законном месте.",
			"Видеть, как ты унижаешься — это идеально. Именно то, чего я хотела.",
			"В самый раз. Продолжай.",
			"Унижение тебе к лицу. Целуй дальше.",
		]
	if(_id == "SoftSlaveryMarkingBegFootKiss2"):
		return [
			"Пожалуй, на сегодня унижений достаточно.",
			"На данный момент вопрос решен.",
			"Ладно. Мы закончили. Пока что.",
			"Хорошо. Исчезни с глаз моих, пока я не придумала тебе применение посерьёзнее.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation"):
		return [
			"Хорошо. А теперь признай, что ты моя {npc.npcSlave}. Всего лишь моя собственность.",
			"Ладно. А теперь я хочу услышать, как ты признаёшься, что ты — {npc.npcSlave}. Моя никчёмная {npc.npcSlave}. Говори громче!",
			"Так. Теперь я хочу, чтобы ты унизилась. Признай, что ты принадлежишь мне. Признай, что ты — {npc.npcSlave}.",
			"Дальше. Теперь хочу, чтобы ты сказала правду. Признай, что ты моя {npc.npcSlave}. Ты принадлежишь мне. Вкладывай в каждое гребаное слово смысл.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation2"):
		return [
			"Что? Я не слышу твое жалкое бормотание.",
			"Громче. Я хочу слышать твой стыд.",
			"Недостаточно громко. Говори так, будто ты сама в это веришь, отброс.",
			"Повысь голос. Я хочу, чтобы каждый слышал твое унижение.",
			"Говори внятно. Не смей, блять, мямлить.",
			"Еще раз, но на этот раз с подобающим стыдом.",
			"Громче. Я хочу, чтобы вся тюрьма знала, кто ты такая.",
			"Не стесняйся. Скажи это так, как подобает никчемной {npc.npcSlave}.",
			"Повтори еще раз, и чтобы это звучало убедительно.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation3"):
		return [
			"Так-то лучше. Рада, что ты наконец-то осознал своё место.",
			"Хорошо. Наконец-то из этой никчёмной пасти вылетела хоть какая-то правда.",
			"Вот именно такой тон покорности я и хотела услышать.",
			"А вот это уже приемлемо. Не забывай о таком настрое.",
			"Лучше. Может, ты всё-таки выучишь своё место.",
			"Сойдёт. И не вздумай забыть то, в чём ты только что признался.",
			"Хорошо. По крайней мере, теперь ты знаешь себе цену.",
			"Приемлемо. Носи этот стыд в себе.",
		]
	if(_id == "SoftSlaveryMarkingBegHumiliation4"):
		return [
			"Думаю, на сегодня унижений достаточно.",
			"На данный момент вопрос решен.",
			"Ладно. Мы закончили. Пока что.",
			"Ладно. Исчезни с глаз моих, пока я не нашла способ развлечься ещё сильнее.",
		]
	if(_id == "SoftSlaveryMarkingNotDone"):
		return [
			"Вообще-то... знаешь что... я еще не закончила тебя унижать.",
			"Погоди. У меня на тебя еще куча унизительных планов.",
			"Стой. Мы еще не закончили. У меня найдется тебе применение и поинтереснее.",
			"Я соврал. Это еще не конец.",
			"Вообще-то... Тебя ждет еще немало страданий. О да.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneStocks"):
		return [
			"Это просто чтобы моя собственность не вздумала сбежать.",
			"Считай это страховкой от твоих жалких попыток к бегству.",
			"Не хочу, чтобы ты дергалась, пока я украшаю свою собственность.",
			"Так ты точно не будешь шевелиться. Мы ведь не хотим, чтобы я испортила свой шедевр, верно?",
			"Это поможет тебе стоять смирно, как и подобает хорошей {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneStocks2"):
		return [
			"Идеально. Это истинное искусство.",
			"Аккуратно. Выглядит именно так, как и должно выглядеть никчемное имущество.",
			"Идеально. Унижение тебе к лицу.",
			"Хорошо. Это отлично подчеркивает твой статус.",
			"Превосходно. Это станет твоим вечным напоминанием.",
		]
	if(_id == "SoftSlaveryMarkingNotDoneUrinal"):
		return [
			"Сейчас я поставлю на тебе правильную метку.",
			"Так и хочется выжечь на своей {npc.npcSlave} клеймо этим самым.",
			"Это ведь единственный верный способ пометить никчемную собственность, не находишь?",
			"Видишь это? Сейчас я нанесу тебе метку, которую ты заслуживаешь...",
		]
	if(_id == "SoftSlaveryMarkingNotDoneUrinal2"):
		return [
			"Ммм... Хорошая, никчемная {npc.npcSlave}.",
			"Как же это было приятно. О, теперь ты выглядишь как подобает помеченной вещи.",
			"Хах. Выглядишь идеально, такая мерзкая {npc.npcSlave}.",
			"Тебе ведь понравилось, да? Жалкое зрелище.",
			"Да.. хорошо.. носи свое унижение с гордостью, {npc.npcSlave}.",
		]

	if(_id == "SoftSlaveryParadeAroundStart"):
		return [
			"Пора показать всей тюрьме мою новую {npc.npcSlave}. Шевелись.",
			"Я посажу тебя на поводок и буду выгуливать как настоящую {npc.npcSlave}. Даже не думай сопротивляться.",
			"Все увидят, что у меня есть. Подставь шею, {npc.npcSlave}.",
			"Пора на прогулку. Вся тюрьма увидит мою {npc.npcSlave} напоказ.",
			"Я промарширую с тобой через всю тюрьму, чтобы каждый мог хорошенько рассмотреть мою новую собственность.",
		]
	if(_id == "SoftSlaveryParadeAroundFirst"):
		return [
			"Привыкай к этим взглядам, {npc.npcSlave}. Это только начало.",
			"Уже чувствуешь унижение? Хорошо. Мы только начали.",
			"Видишь, как они на тебя пялятся? Вот так смотрят на собственность. И это еще не всё.",
			"Нравится быть моим маленьким экспонатом? Только не расслабляйся, это была самая легкая часть.",
			"Это еще цветочки, {npc.npcSlave}. Настоящее веселье только начинается.",
		]
	if(_id == "SoftSlaveryParadeAroundMore"):
		return [
			"Шевелись. Мы еще не закончили.",
			"Еще одно место, еще одна публика для моей {npc.npcSlave}.",
			"Устала? Жаль. Нам нужно осмотреть еще несколько мест.",
			"Готова снова пойти на показ? Да, ты готова.",
			"Видишь их лица? Теперь все знают, кто ты такая. Давай устроим шоу для следующей толпы.",
			"Бьюсь об заклад, тебе уже начинает это нравиться, жалкая {npc.npcSlave}.",
			"Забавно наблюдать, как ты корчишься. Пойдем найдем еще людей, чтобы заставить тебя смущаться.",
		]
	if(_id == "SoftSlaveryParadeAroundLast"):
		return [
			"Последнее унижение. Сделай так, чтобы оно того стоило.",
			"Последний рывок. Только посмей меня разочаровать.",
			"Финальная остановка. Хочу, чтобы ты запомнила каждое пялящееся на тебя лицо.",
			"Еще один раунд. К концу я хочу, чтобы ты была сломлена и покорна.",
			"Почти закончили. Не позорь меня, иначе пожалеешь.",
			"Это твой последний шанс доказать, что из тебя выйдет сносная {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryParadeAroundFree"):
		return [
			"На сегодня хватит. Не расслабляйся, {npc.npcSlave}.",
			"Свободна. Но помни, кому ты принадлежишь.",
			"Сгинь с глаз моих. Я найду тебя, когда снова захочу.",
			"Беги, {npc.npcSlave}. И не заставляй меня искать тебя самой.",
			"На сегодня всё. И не заставляй меня приходить за тобой.",
			"Свободна. Но помни: ты принадлежишь мне, и я могу забрать тебя в любой момент.",
			"Пока что можешь уползти. Но не забывай своё место.",
		]
	if(_id == "SoftSlaveryParadeAroundEatGagged"):
		return [
			"Смотри, как я ем, {npc.npcSlave}.",
			"Тебе ведь не под силу есть с этой штукой, а? И хорошо. Скоро ты узнаешь, что такое голод.",
			"Будешь сидеть и смотреть, как я наслаждаюсь едой. Если повезёт, может, и объедками тебя покормлю.",
			"Твой голод меня забавляет. Смотри дальше, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryParadeAroundEat"):
		return [
			"Жри эту жижу. Для такой {npc.npcSlave}, как ты, это даже слишком щедро.",
			"Вот твоя еда. Не задерживайся.",
			"Ешь быстрее, {npc.npcSlave}.",
			"Твоя еда, {npc.npcSlave}. Будь благодарна, что я вообще тебя кормлю.",
			"Глотай быстрее. Твой перерыв почти закончился.",
		]
	if(_id == "SoftSlaveryParadeAroundPlatform"):
		return [
			"Видишь эти колодки? Вот где ты окажешься, если будешь плохо себя вести.",
			"Один неверный шаг, и я запру тебя в одних из них на всеобщее обозрение.",
			"Вот твое будущее, если ослушаешься меня, {npc.npcSlave}.",
			"Думаешь, эта прогулка унизительна? На этих платформах начинается настоящий позор.",
			"Тебе нравится мысль о том, что тебя здесь выставляют напоказ, {npc.npcSlave}? Тебе должна.",
		]
	if(_id == "SoftSlaveryParadeAroundShower"):
		return [
			"Пора смыть грязь с моей собственности. И не вздумай брыкаться.",
			"Ты должна выглядеть прилично. Под воду, живо!",
			"Стой смирно, пока я тебя отмываю, {npc.npcSlave}.",
		]

	if(_id == "SoftSlaveryThreesomeStart"):
		return [
			"Я привел друга. Ты будешь обслуживать нас обоих, {npc.npcSlave}.",
			"У меня компания. Сегодня ты будешь ублажать сразу двух хозяев. Понятно, {npc.npcSlave}?",
			"Сегодня для тебя проблем будет вдвое больше, {npc.npcSlave}. Мы собираемся использовать тебя вместе.",
			"Я привел друга. Постарайся, чтобы мы оба остались довольны, {npc.npcSlave}.",
			"Сегодня тебе нужно угодить двоим, {npc.npcSlave}. Лучше не разочаруй нас.",
			"Надеюсь, ты готова, {npc.npcSlave}. Сегодня у тебя двойная порция обязанностей.",
			"Сейчас ты принадлежишь нам обоим, {npc.npcSlave}. А теперь на колени.",
		]
	if(_id == "SoftSlaveryPunishCredits"):
		return [
			"Я забираю это. Считай это налогом за твою тупость.",
			"Теперь это моё. Плата за то, что ты тратишь моё время.",
			"Это теперь моё. Назови это сбором за твоё жалкое непослушание.",
			"Твои кредиты смотрятся в моем кармане куда лучше, чем в твоих никчемных руках.",
			"Это должно компенсировать всё то раздражение, которое ты мне доставил(а).",
			"Недостаточно, чтобы выкупить твою свободу, но, может, хватит, чтобы ты чуть меньше страдал(а).",
			"Считай это платой за мое терпение, которое ты только что исчерпал(а).",
		]
	if(_id == "SoftSlaveryPunishCredits2"):
		return [
			"Если мне не достанется твоего послушания, я заберу всё остальное. В следующий раз будет хуже.",
			"Это, блядь, предупреждение. Огрызнешься еще раз — и я заберу что-нибудь другое.",
			"Кредиты — это меньшее из того, что я могу у тебя отжать. Испытай мое терпение еще раз.",
			"В следующий раз я не буду таким(ой) милосердным(ой). Я заберу то, что действительно причиняет боль.",
		]
	if(_id == "SoftSlaveryPunishRipClothes"):
		return [
			"Навеселился(ась), мелкая дрянь? Начни подчиняться, пока я окончательно не вышел(ла) из себя.",
			"Закончил(а) свой жалкий бунт? В следующий раз я сорву с тебя не только одежду.",
			"Все еще чувствуешь себя смелой, {npc.npcSlave}? Я могу раздеть тебя еще сильнее и заставить горько об этом пожалеть.",
			"Выпустила пар? Хорошо. А теперь подчиняйся, иначе я дам тебе реальный повод для слез.",
			"Нравится капризничать? Это была твоя последняя забава на долгое время. А теперь — слушайся.",
			"Считай, что твой дух сломлен. Теперь придет очередь твоего тела учиться послушанию.",
		]
	if(_id == "SoftSlaveryPunishRoughSex"):
		return [
			"Ладно. Значит, пойдем по сложному пути, {npc.npcSlave}.",
			"У тебя был шанс подчиниться. Теперь ты узнаешь, что бывает, когда упрямишься.",
			"Непослушание карается. Только посмей дернуться.",
			"Ты сама выбрала эту боль. И я получу истинное удовольствие, причиняя её тебе.",
			"Твое сопротивление сделало всё только хуже для тебя самой.",
			"Нужно было слушаться, когда была возможность. Теперь будешь платить по счетам.",
			"У тебя просто закончились варианты, {npc.npcSlave}. Добро пожаловать к последствиям.",
			"Твое тело будет подчиняться, даже если твой упрямый разум — нет.",
			"Ты выучишь свое место, по одному крику за раз.",
			"Мне нравится ломать таких упрямых рабынь, как ты. Твое сопротивление только делает процесс слаще.",
			"Думаешь, сможешь мне отказать? Посмотрим, надолго ли тебя хватит.",
			"Каждый раз, когда ты будешь сопротивляться, я буду становиться только грубее. Твоя боль — твой выбор.",
			"Это тело принадлежит мне. Пора это доказать.",
		]
	if(_id == "SoftSlaveryPunishRoughSexPCWon"):
		return [
			"Это еще не конец. Чертовски далеко не конец, {npc.npcSlave}.",
			"Ты заплатишь за это в десятикратном размере. Помяни мое слово.",
			"Наслаждайся моментом. Он сделает твое наказание еще слаще.",
			"Большая ошибка. Ты только всё усложнила.",
			"Это ничего не меняет. Ты всё ещё моя собственность.",
			"Думаешь, ты победила? Ты лишь отсрочила неизбежное.",
		]
	if(_id == "SoftSlaveryPunishRoughSexEnded"):
		return [
			"В следующий раз подчиняйся. Иначе то, что будет, покажется тебе нежным массажем.",
			"Пусть это будет уроком. Моё терпение иссякло.",
			"Считай это предупреждением. У меня припасено для тебя кое-что похуже.",
			"Это я ещё была добра. В следующий раз не стану сдерживаться.",
			"Запомни эту боль. Это ничто по сравнению с тем, что ждёт тебя впереди.",
			"Тебе ещё повезло. Не заставляй меня доказывать, насколько всё может быть хуже.",
			"Это был твой бесплатный урок. Следующий обойдётся тебе очень дорого.",
			"Мое милосердие не безгранично. И ты только что нащупала его край.",
			"Запомни это чувство. Это лучшее, что тебя ждет за непослушание.",
			"Это была лишь малая часть того, что ты заслуживаешь за непокорность.",
			"Надеюсь, ты усвоила урок. Ради собственного же блага.",
			"Твое тело принадлежит мне. Не заставляй меня напоминать тебе об этом вот так.",
			"Это была чистая жалость по сравнению с тем, что я сделаю в следующий раз.",
			"Каждый твой крик, каждая слеза принадлежат мне. Веди себя соответственно.",
		]
	if(_id == "SoftSlaveryPunishSlutwall"):
		return [
			"Шагай к стене для шлюх, иначе я переломаю тебе ноги и потащу туда волоком.",
			"Шевели ногами, {npc.npcSlave}, иначе я сделаю так, что ты вообще не сможешь ходить.",
			"Иди за мной, или я что-нибудь сломаю, и тебе всё равно придется тащиться следом.",
			"Стена шлюх ждет. Можешь идти по доброй воле, а можешь — с воплями.",
			"Иди тихо, или я дам тебе реальный повод поплакать.",
			"Не усложняй всё без того нелегко. Шагай, {npc.npcSlave}.",
			"Можешь дойти до стены шлюх сама, а можешь, чтобы я дотащила твое сломленное тело.",
		]
	if(_id == "SoftSlaveryPunishSlutwallLock"):
		return [
			"Наслаждайся тем, что тебя используют все подряд, {npc.npcSlave}.",
			"Хоть раз в своей жалкой жизни принеси от себя пользу.",
			"Наконец-то ты служишь своему истинному предназначению — быть общественной собственностью.",
			"Это всё, на что ты годна. Быть дыркой общего пользования.",
			"Добро пожаловать в твое единственное предназначение. Попробуй только еще побрюзжать.",
			"Хотя бы наконец-то от тебя есть толк.",
			"Это всё, чего ты стоишь. Запомни это.",
			"Прими своё предназначение, {npc.npcSlave}. Это всё, на что ты годна.",
			"Надеюсь, тебе понравится твоя новая роль — станциильная спермобак.",
		]

	if(_id == "SoftSlaveryPunishStocks"):
		return [
			"Шевели своими грёбаными ногами, иначе я переломаю их и потащу твоё бесполезное тело за собой.",
			"Иди, {npc.npcSlave}, иначе я буду тащить тебя, выдирая волосы клочьями.",
			"Живее шевелись, а то будешь ползти на разбитых коленях каждый сраный дюйм.",
			"Иди покорно, или я заковываю тебя в цепи и заставлю истекать кровью весь путь.",
			"Либо ты сама дойдёшь до колодок, либо я потащу твоё обмякшее тело на себе.",
		]
	if(_id == "SoftSlaveryPunishStocksLock"):
		return [
			"С твоим неповиновением покончено. Посмотрим, каково тебе будет быть всеобщей {npc.npcSlave}.",
			"Для меня ты — пустое место. Может, толпа найдёт тебе какое-нибудь применение.",
			"Раз ты отказываешься служить мне, будешь служить игрушкой для любого, кто захочет причаститься к моей {npc.npcSlave}.",
			"Твое непослушание карается публичным унижением. Наслаждайся ролью всеобщей {npc.npcSlave}.",
			"Слишком упрямая для меня? Посмотрим, как ты справишься с ролью общей собственности.",
			"Если не хочешь быть моей {npc.npcSlave}, то станешь всеобщей {npc.npcSlave}.",
			"Пора сделать тебя полезной для кого-то другого, раз уж ты бесполезна как моя {npc.npcSlave}.",
			"Раз уж ты не умеешь вести себя как моя {npc.npcSlave}, будешь учиться у незнакомцев.",
		]
	if(_id == "SoftSlaveryPunishStocksAsk"):
		return [
			"Твоя рабыня свободна для использования?",
			"Эта рабыня открыта для бизнеса?",
			"Не возражаешь, если я воспользуюсь твоей рабыней?",
			"Твоя рабыня выглядит как {pc.he}, которую только что {pc.verb('need')}.",
			"Можно мне тоже по очереди с твоей рабыней?",
			"Эта рабыня готова к публичному использованию?",
			"Твой раб явно жаждет внимания. Можно мне?",
		]
	if(_id == "SoftSlaveryPunishStocksAskNope"):
		return [
			"Бесплатного не бывает. <CREDITS> кредитов за использование моей {npc.npcSlave}.",
			"Не без оплаты. Сначала <CREDITS> кредитов.",
			"У всего есть цена. <CREDITS> кредитов, и моя {npc.npcSlave} в твоем распоряжении на какое-то время.",
			"<CREDITS> кредитов, и ты сможешь делать со своей {npc.npcSlave} всё, что захочешь, какое-то время.",
			"Заплати <CREDITS> кредитов, и используй мою {npc.npcSlave} как свою игрушку.",
			"Я не раздаю свою {npc.npcSlave} направо и налево. <CREDITS> кредитов за одно использование.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy"):
		return [
			"А что, если я не хочу платить за твою поношенную {npc.npcSlave}?",
			"Я не собираюсь платить за подержанный товар.",
			"Слишком дорого для битого имущества.",
			"Это больше, чем стоит твоя {npc.npcSlave}.",
			"Не собираюсь платить столько за твою непослушную {npc.npcSlave}.",
			"Твоя {npc.npcSlave} не стоит таких денег.",
			"Твоя цена слишком высока для бесполезного барахла.",
			"Эта {npc.npcSlave} уже выглядит изрядно потрёпанной.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy2"):
		return [
			"Тогда съебись, нищеброд.",
			"Нет кредитов — нет {npc.npcSlave}. Проваливай.",
			"Тогда хватит тратить моё время. Исчезни.",
			"Проваливай нахер, если не можешь платить.",
			"Нищей швали не стоит беспокоить владельцев. Свали.",
			"Возвращайся, когда у тебя будут настоящие кредиты.",
			"Тогда ты ничего не получишь. Выметайся.",
			"Отвали, скряга.",
		]
	if(_id == "SoftSlaveryPunishStocksAskNoBuy3"):
		return [
			"Я не уйду, не использовав твой {npc.npcSlave}.",
			"Может, я просто заберу то, что захочу, из твоего {npc.npcSlave}.",
			"Твой {npc.npcSlave} выглядит достаточно соблазнительно, чтобы заграбастать его просто так.",
			"Думаю, я всё равно угощусь твоим {npc.npcSlave}.",
			"Твой {npc.npcSlave} всё равно пойдёт в дело.",
			"С такой собственностью, как ты, я не принимаю слово «нет».",
			"Может, я использую твой {npc.npcSlave} прямо у тебя на глазах?",
			"Этот {npc.npcSlave} так или иначе послужит мне.",
		]
	if(_id == "SoftSlaveryPunishStocksAskSure"):
		return [
			"Конечно.",
			"Меня устраивает.",
			"Вот, держи.",
			"На, должно хватить.",
			"Вроде сойдёт.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterSex"):
		return [
			"Видишь, что бывает, когда ты приносишь пользу, {npc.npcSlave}? А теперь стой смирно и помни своё место.",
			"Это всё, на что ты годна, {npc.npcSlave}. Помни об этом, когда решишь ослушаться.",
			"Наконец-то ты принесла пользу, {npc.npcSlave}. Может, общественное использование тебе к лицу. Наслаждайся колодками.",
			"Видишь, как жизнь становится лучше, когда ты послушна, {npc.npcSlave}? Наслаждайся колодками.",
			"Ты нашла своё призвание, {npc.npcSlave}. Публичная шлюха.",
			"Хорошая {npc.npcSlave}. А теперь сиди взаперти и думай о послушании.",
			"В этом твоё истинное предназначение, {npc.npcSlave}. Запомни это. Наслаждайся колодками.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterBadSex"):
		return [
			"Твоя {npc.npcSlave} просто ужасна. Верни мои кредиты.",
			"Худший трах, за который я когда-либо платил. Верните мне деньги за эту никчемную {npc.npcSlave}.",
			"Эта {npc.npcSlave} не стоит потраченных кредитов. Верните их.",
			"Твоя {npc.npcSlave} слишком много брыкается. Не стоит своих денег.",
			"Этот {npc.npcSlave} сломан. Верни мои кредиты.",
			"Зря потраченные кредиты. Твой {npc.npcSlave} бесполезен.",
			"Ужасный сервис от твоего {npc.npcSlave}. Требую возврата денег.",
			"Твой {npc.npcSlave} бракованный. Верни бабки.",
		]
	if(_id == "SoftSlaveryPunishStocksAfterBadSex2"):
		return [
			"Никаких возвратов. Ты использовал мой {npc.npcSlave}, так что теперь съебись.",
			"Ты получил то, за что заплатил. Б/у имущество возврату не подлежит.",
			"Ты использовал мой {npc.npcSlave}. Смирись с этим.",
			"Мой {npc.npcSlave} послужил тебе. Возврата нет.",
			"Ты платил за доступ к моему {npc.npcSlave}, а не за удовольствие.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost"):
		return [
			"Жалкое проявление слабости.",
			"Ты дерешься как рабыня.",
			"Это всё, на что ты способна, слабачка?",
			"Столько борьбы — и всё впустую, дура.",
			"Ты даже слабее, чем твоя {npc.npcSlave}.",
			"Столько злости и так мало сил. Жалкое зрелище.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost2"):
		return [
			"Так-то лучше. Две рабыни в колодках — там тебе и место.",
			"Обе рабыни теперь надежно заперты. Идеально.",
			"Учись знать свое место рядом со своей {npc.npcSlave}.",
			"Теперь ты понимаешь свое истинное положение.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerLost3"):
		return [
			"Прекрасно. Теперь твоя {npc.npcSlave} будет наблюдать за твоим наказанием.",
			"Хорошо. Твой {npc.npcSlave} поучится на твоих страданиях.",
			"Отлично. Твой {npc.npcSlave} увидит, что бывает с неудачниками.",
			"Куда лучше. Твой {npc.npcSlave} запомнит твою слабость.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon"):
		return [
			"Знай своё место, мразь.",
			"Ты слабак. Не забывай о своём положении.",
			"Жалкое зрелище. Учись понимать свой статус.",
			"Ты — ничтожество. Запомни это.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon2"):
		return [
			"Ты тоже. Ты ходишь по очень тонкому льду, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon3"):
		return [
			"И теперь ты выучишь своё место.",
			"Ты такая слабая. И теперь ты выучишь своё место.",
			"Жалкое зрелище. И теперь ты выучишь своё место.",
			"Ты тупая и слабая. И теперь ты выучишь своё место.",
		]
	if(_id == "SoftSlaveryPunishStocksOwnerWon4"):
		return [
			"И ты смотри. Ты ходишь по очень тонкому льду, {npc.npcSlave}.",
			"Слушай внимательно, рабыня. Вот что бывает с непослушными сучками.",
		]

	if(_id == "SoftSlaveryPunishSell"):
		return [
			"Меня уже просто задрал твой вид. С меня хватит. Реально хватит.",
			"С меня хватит твоего вечного непослушания. Ты больше не будешь моей проблемой.",
			"Ты подвёл меня в последний раз, жалкий {npc.npcSlave}. Я избавляюсь от тебя.",
			"Я хотел тебя сломать, но ты даже не стоишь этих ебаных усилий. С этим покончено.",
			"Из тебя могло бы что-то выйти, но ты просто кусок сломанного дерьма. С меня хватит.",
			"Ты — сплошное разочарование. Я с тобой завязываю.",
			"Мне тошно тратить на тебя время. Считай, что теперь ты — чья-то чужая проблема.",
			"Ты — безнадежный случай. Буду минимизировать убытки. С меня довольно.",
			"Каждое мгновение с тобой было ошибкой. И сейчас я это исправляю.",
			"Ты худшая {npc.npcSlave}, которая у меня когда-либо была. С меня хватит.",
		]
	if(_id == "SoftSlaveryPunishSell2"):
		return [
			"Пусть кто-нибудь другой разгребает твое жалкое дерьмо.",
			"Может, твой следующий хозяин справится с твоим никчемным гонором. Сомневаюсь.",
			"Наслаждайся своей новой жизнью. Надеюсь, они будут в десять раз строже, чем я, блять.",
			"Посмотрим, надолго ли тебя хватит с тем, кто не станет терпеть твое дерьмо.",
			"Ты больше не моя проблема. Пусть кто-нибудь другой попытается вбить в тебя хоть каплю здравого смысла.",
			"Удачи в новой жизни. Они не будут такими, блять, терпеливыми, как я.",
			"С твоим непослушанием теперь справится кто-нибудь другой. Я с тебя умываю руки.",
			"Тот, кто тебя купит, получает бракованную {npc.npcSlave}. Удачи им, блять, огромной.",
			"Надеюсь, твой следующий хозяин переломает тебя пополам. Ты это заслужил(а).",
			"Иди и будь чьим-то еще масштабным разочарованием.",
		]


	if(_id == "SoftSlaveryPunishGB"):
		return [
			"Ты был(а) непослушным мелким засранцем. Пора становиться шлюхой для гангбанга.",
			"Думаешь, так и дальше будешь выпендриваться? Посмотрим, как тебе понравится, когда тебя будут юзать все подряд.",
			"Твое постоянное непослушание принесло тебе отличную награду. Гангбанг.",
			"Раз уж ты не можешь выполнять простые команды, может, твои дырки хоть в чем-то пригодятся.",
			"Плохих рабынь делят на всех. Скоро ты станешь публичной шлюхой для группового секса.",
			"С твоим гонором пора завязывать. Может, если тебя будут передавать из рук в руки как игрушку, ты придешь в чувство.",
			"Тебе нужно напомнить, где твое место. Гангбанг должен отлично с этим справиться.",
			"За непослушание каждое твое отверстие будет забито до отказа. Надеюсь, ты готова, {npc.npcSlave}.",
			"Думаешь, ты особенная? Посмотрим, какой особенной ты будешь себя чувствовать, когда я превращу тебя в очередную шлюху для групповухи.",
		]
	if(_id == "SoftSlaveryPunishGBGiveup"):
		return [
			"Блядь. Даже желающих трахнуть твои никчемные дырки не наберется.",
			"Жалкое зрелище. Даже в наказание не получается найти людей, которым было бы интересно тебя оттрахать.",
			"Сука. Что это говорит о тебе, если твои тупые дырки никому не нужны?",
			"Черт. Сегодня твоим жалким телом никто не интересуется. Тебе еще повезло.",
			"Блядь. Даже на гангбанг людей не наскрести. Вот насколько ты плоха.",
		]
	if(_id == "SoftSlaveryPunishGBOffer"):
		return [
			"Эй. Хотите помочь мне проучить мою непослушную {npc.npcSlave}?",
			"Интересуешься наказать мою бесполезную {npc.npcSlave}?",
			"Не хочешь использовать мою непослушную {npc.npcSlave} как кумдамп?",
			"Хочешь помочь преподать урок этой никчемной {npc.npcSlave}?",
			"Моей {npc.npcSlave} нужно хорошенько всыпать. Не хочешь поучаствовать в гангбенге?",
			"Этому куску дерьма нужно напомнить, что они всего лишь дырки. Интересно?",
			"Хочешь поучаствовать в гангбенге моей непослушной {npc.npcSlave}?",
			"Не хочешь помочь мне превратить эту {npc.npcSlave} в шлюху для гангбенга?",
			"Моя {npc.npcSlave} заслуживает того, чтобы её использовали все подряд. В деле?",
			"Эту сучку нужно поставить на {pc.his} место. Поможешь?",
		]
	if(_id == "SoftSlaveryPunishGBSure"):
		return [
			"О да, черт возьми. Обожаю ломать шлюх.",
			"Всегда рад поставить никчемную рабыню на место.",
			"Я в деле. Нет ничего лучше, чем наказывать непослушных шлюх-игрушек.",
			"С радостью. Как раз искал себе хорошую подстилку.",
			"Определенно. Давайте заставим эту сучку пожалеть о своем рождении.",
			"С удовольствием. Нет ничего лучше, чем групповуха со шлюхой.",
			"Ебать, да! Мне всё равно нужно было снять стресс.",
			"Идеальный момент. Мне как раз не помешал бы жесткий трах.",
		]
	if(_id == "SoftSlaveryPunishGBFollow"):
		return [
			"За мной, поищем местечко, чтобы разнести эту сучку в щепки.",
			"Сюда. Пора заставить эту {npc.npcSlave} визжать.",
			"За мной. Пора начинать это наказание.",
			"Давай же. Чем быстрее начнем, тем быстрее сломаем {pc.him}.",
			"Иди за мной. Я хочу, чтобы эту {npc.npcSlave} сломали, пока не стало слишком поздно.",
			"Пошли. Жду не дождусь, когда эта шлюха начнет умолять.",
		]
	if(_id == "SoftSlaveryPunishGBSubOffer"):
		return [
			"Может, вместо неё накажут меня?",
			"Если есть выбор, я бы предпочла стать шлюхой для групповухи.",
			"А можно мне занять место твоей рабыни? Мне нужно, чтобы меня использовали.",
			"Ты не против, если на этот раз всё достанется мне? Обожаю быть дыркой.",
			"Вообще-то, я бы предпочла сама заглатывать все члены.",
			"Не против, если я присоединюсь как еще одна секс-игрушка? Обожаю групповой секс.",
			"А можно мне стать главным блюдом? Ну, или хотя бы дополнительной дыркой?",
			"Я хочу, чтобы меня передавали из рук в руки и использовали.",
			"Может, используешь меня вместо неё? Мне нужно наказание.",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferYes"):
		return [
			"Мне по кайфу. Чем больше мяса для траха, тем лучше.",
			"Конечно, почему бы и нет? Сломать двух шлюх куда интереснее, чем одну.",
			"Отлично. В два раза больше визгов, в два раза больше веселья.",
			"Идеально. Мы будем юзать вас обеих, пока вы окончательно не сломаетесь.",
			"Меня устраивает. Больше дырок, которые можно набивать и унижать.",
			"Супер. Будешь нашей бонусной спермобак.",
			"Ладно. Чем больше бесполезных шлюх, тем веселее.",
			"Хорошая мысль. Мы обеих превратим в руины.",
			"А почему бы и нет? На всех хватит.",
			"Ебать, да! Две шлюхи на групповуху лучше, чем одна.",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferNo"):
		return [
			"Нет, у нас уже есть одна сучка, которую надо проучить.",
			"Прости, сейчас дело в том, чтобы сломать мою {npc.npcSlave}, а не тебя.",
			"Нам не нужна еще одна шлюха, которая будет отвлекать от главного.",
			"Это наказание зарезервировано для моей непослушной собственности.",
			"У нас тут и так достаточно мяса для траха.",
			"Нет, спасибо, я хочу сосредоточиться на том, чтобы сломать именно эту шлюху.",
		]
	if(_id == "SoftSlaveryPunishGBSubOfferNoAw"):
		return [
			"Блядь. А я так хотела, чтобы меня использовали.",
			"Черт. Нет ничего лучше, чем быть материалом для групповухи.",
			"Жаль. Обожаю, когда меня передают из рук в руки, как игрушку.",
			"Какое разочарование. Я буквально живу ради такого наказания.",
			"Ну и ладно. Может, найду кого-нибудь другого, кто меня отымеет.",
			"Какая жалость. Быть использованной толпой — моё самое любимое.",
			"Черт возьми. А я надеялась сегодня побыть шлюхой для гангбэнга.",
		]
	if(_id == "SoftSlaveryPunishGBNo"):
		return [
			"Не интересно.",
			"В этот раз я пасую.",
			"Не, спасибо.",
			"Не в моем вкусе.",
			"Пожалуй, в этот раз я постою в сторонке.",
			"Не сегодня.",
			"Пожалуй, не стоит.",
			"Нет, со мной всё в порядке.",
			"Я откажусь.",
		]
	if(_id == "SoftSlaveryPunishGBNoReact"):
		return [
			"Да пошел ты тогда. Твоя потеря.",
			"Как хочешь, трус.",
			"Ладно. Твоя слабая задница нам всё равно не нужна.",
			"Твой выбор. Куча других мечтают развлечься.",
			"Жаль тебя. Пропускаешь самое веселье.",
			"Без проблем. Найдем кого-нибудь с яйцами.",
			"Плевать. Значит, мне будет веселее.",
			"Жалкое зрелище. Даже групповуху не вывезти.",
		]
	if(_id == "SoftSlaveryPunishGBStart"):
		return [
			"Пора узнать своё место, никчемная шлюха.",
			"Да начнется наказание. Надеюсь, ты готова, что тебя сломают.",
			"Вот что бывает с непослушными рабынями.",
			"Готова стать шлюхой для группового секса? Надеюсь, что нет.",
			"Посмотрим, сколько ебли ты выдержишь, прежде чем сломаешься.",
			"Пришло время заставить тебя пожалеть о каждом твоем «нет».",
		]
	if(_id == "SoftSlaveryPunishGBEnd"):
		return [
			"Помни это чувство каждый раз, когда решишь мне перечить.",
			"Пусть это будет уроком о том, кому принадлежат эти дырки, сучка.",
			"В следующий раз будет вдвое жестче. Запомни это.",
			"Надеюсь, тебе понравилось наказание, потому что впереди еще много интересного.",
			"Твое тело — моя собственность, чтобы использовать и делить с кем угодно. Больше никогда об этом не забывай.",
			"Вспомни этот момент, когда в следующий раз захочешь разбаловаться.",
			"Пусть это напомнит тебе, что ты всего лишь кусок мяса для ебли.",
		]

	if(_id == "SoftSlaveryPunishLockRestraint"):
		return [
			"Ты облажалась. И теперь тебе придется за это отвечать.",
			"Тебя засаживают за решетку, как и положено тупой девчонке.",
			"Ведешь себя как глупая сучка — вот и получаешь соответствующее отношение.",
			"Вот так. Теперь при каждом движении ты будешь вспоминать, кому принадлежит твоя никчемная задница.",
			"Тебе еще повезло, что я вообще соизволил тебя запереть, а не просто вышвырнул вон.",
			"Надеюсь, он впивается тебе в кожу. В этом и весь смысл, тупая шлюха.",
			"Хотела буянить? Получай. Теперь будешь таскать на себе мою гребаную бирку собственности, пока мне не надоест смотреть на твои мучения.",
		]
	if(_id == "SoftSlaveryPunishLockRestraint2"):
		return [
			"Тронешь замок — и клянусь... Просто попробуй.",
			"Я сразу пойму, если ты начнешь с ним возиться.",
			"Этот замок снимут тогда, когда я, блядь, скажу. А не когда твое жалкое нытье станет слишком громким.",
			"Снимешь его раньше моего разрешения — и я устрою тебе вещи похуже. Поняла?",
			"Даже не вздумай дышать на этот замок неправильно. В следующий раз я не буду такой щедрой.",
			"Твоя единственная задача теперь — носить этот замок и завалить ебало.",
		]
	if(_id == "SoftSlaveryPunishLockRestraint3"):
		return [
			"Я в двух секундах от того, чтобы сделать это навсегда. Еще один гребаный всхлип, и замок останется на тебе на месяц.",
			"Ты испытываешь меня на прочность, {npc.npcSlave}. А я не люблю, когда меня испытывают. Исправь свое поведение, или я исправлю его за тебя.",
			"Это твое предупреждение. Еще один тупой выпад, и этот замок станет меньшей из твоих проблем.",
			"Продолжай испытывать меня, и ты узнаешь, насколько креативной я могу быть. А теперь, блять, веди себя прилично.",
			"По твоему лицу видно, что ты до сих пор нихера не понял. С меня хватит нежностей.",
			"Ты на исходе моего терпения. В следующий раз я не буду предупреждать, {npc.npcSlave}. Я просто тебя сломаю.",
		]

	if(_id == "SoftSlaveryResist"):
		return [
			"Серьезно, {npc.npcSlave}? Ты, тупая сука, реально хочешь, чтобы всё прошло именно так?",
			"Думаешь, сможешь мне противостоять, {npc.npcSlave}? Как же это, блять, мило.",
			"Значит, хочешь пойти по сложному пути? Как хочешь, мелкая дрянь.",
			"Сопротивляешься? Ты еще пожалеешь об этом выборе больше, чем о чем-либо другом в своей жалкой жизни.",
			"Ты реально пытаешься дать сдачи? Какая же, блядь, жалкость.",
			"Это, по-твоему, весело? Получать пиздюлей, пока не подчинишься? Ты больная.",
			"Думаешь, у тебя тут есть выбор? Как же, блядь, мило.",
			"Хочешь поиграть жестко? Ну так давай поиграем, никчемная сучка.",
			"Твой этот маленький бунт закончится тем, что ты будешь рыдать от боли.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtra"):
		return [
			"Эй! Я тоже хочу очередь трахать эту шлюху.",
			"Не против, если я присоединюсь? Эта шлюшка явно не прочь, чтобы её оттрахали еще сильнее.",
			"Можно мне тоже по очереди с твоей игрушкой для секса? Эти дырочки просто умоляют о наполнении.",
			"Место для еще одного найдется? Я бы с удовольствием разнес эту шлюху вместе с тобой.",
			"Думаешь, твоя сучка вывезет нас двоих?",
			"Не забирай всё веселье себе. Поделись своей шлюхой.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraYes"):
		return [
			"Конечно, давай. Помоги мне затянуть путы на этой никчемной {npc.npcSlave} потуже.",
			"Хорошая идея. Помоги мне закрепить мою {npc.npcSlave}, чтобы {pc.he} не могла вырваться.",
			"Идеально. Давай сделаем так, чтобы эта сучка {pc.isAre} оказалась в полной ловушке.",
			"Рад, что спросил. Помоги мне как следует зафиксировать {pc.him} для хорошего траха.",
			"Без проблем. Давай устроим двойной разъеб этой жалкой {npc.npcSlave}.",
			"Мне подходит. Помоги мне сделать так, чтобы {pc.he} {pc.isAre} была абсолютно беспомощной перед нами.",
			"Ебать, да! Давай сломаем эту {npc.npcSlave} вместе.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraNo"):
		return [
			"Нет. Это моя {npc.npcSlave}, так что съебись.",
			"Проваливай. Я не делю свою собственность с таким мусором, как ты.",
			"Эта {npc.npcSlave} принадлежит только мне. Найди себе другую игрушку для траха.",
			"Ни за что. Я не собираюсь делиться своим {npc.npcSlave} с тобой.",
			"Свали в туман. Эта {npc.npcSlave} только для моего пользования.",
			"Отъебись. Мой {npc.npcSlave} — мои правила.",
			"Никакого дележа. Этот {npc.npcSlave} принадлежит мне.",
			"Найди себе другой {npc.npcSlave}. Этот уже занят.",
			"Заведи себе свою. А эту я буду ломать сама.",
			"Отойди. Эта {npc.npcSlave} — моя.",
			"Делиться не планирую. Иди найди себе другую дырку, которую можно затыкать.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraNo2"):
		return [
			"Серьезно? Я не спрашивала, кусок дерьма.",
			"Жаль. Но я возьму то, что хочу.",
			"Я не разрешения просила, долбоёб.",
			"Это не переговоры, мудак.",
			"Просто смотри, как я беру то, что мне нужно.",
			"Мне насрать, что ты там думаешь, ублюдок.",
			"Ну попробуй останови меня, сука.",
			"Это случится, нравится тебе это или нет.",
			"Тебе не помешать мне развлекаться.",
			"Хер тебе. Я никуда не уйду.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraFree"):
		return [
			"Ты свободна, пока что. Но не привыкай.",
			"Ладно, хватит. Свали нахер с моих глаз.",
			"Проваливай. Ты мне уже надоел.",
			"Это всё внимание, которое ты сегодня получишь. А теперь исчезни.",
			"Беги уже, использованная шлюха. Продолжим позже.",
			"Давай, выметайся. На сегодня мне хватило веселья.",
			"Считай, сессия окончена. А теперь съебись.",
			"Можешь идти на все четыре стороны. Только не заставляй меня искать тебя саму.",
			"Исчезни с глаз. Притащу тебя обратно, когда снова захочу.",
		]
	if(_id == "SoftSlaveryFuckInStocksExtraFreeLost"):
		return [
			"Ты всё ещё моя {npc.npcSlave}, поняла? Не забывай об этом.",
			"Не думай, что это что-то меняет. Ты всё ещё моя собственность.",
			"Помни, кто на самом деле владеет тобой, никчемная {npc.npcSlave}.",
			"Это была лишь временная аренда. Ты всё ещё принадлежишь мне, сучка.",
			"Не строй лишних планов. Ты всё ещё моя гребаная {npc.npcSlave}.",
			"Ничего не изменилось. Ты всё ещё моя собственность, которую можно юзать и насиловать как угодно.",
			"Ты всё ещё подчиняешься мне, ясно? Не заставляй меня напоминать об этом.",
			"Это не меняет твоего статуса моей секс-игрушки.",
			"Ты всё еще моя, просто теперь ты еще немного более сломленная.",
			"Твое тело может быть свободным, но ты всё равно моя {npc.npcSlave}.",
		]

	if(_id == "SoftSlaveryParadeFuckOffer"):
		return [
			"Эта сучка выглядит так, будто ей не помешал бы качественный трах. Можно мне {pc.him}?",
			"Какая отчаявшаяся рабыня. Не против, если я разложу {pc.him}?",
			"Эта рабыня практически умоляет об этом. Можно мне сломать {pc.him}?",
			"Твоя рабыня выглядит недотраханной. Не хочешь позволить мне это исправить?",
			"Я наблюдаю за твоей рабыней. Хочу показать {pc.him}, что такое настоящая боль. Можно?",
			"На {pc.him} прямо так и написано: «хочу». Дай мне тоже по очереди.",
			"Какая жалкая рабыня. Не против, если я использую {pc.him} по назначению?",
		]
	if(_id == "SoftSlaveryParadeFuckOfferYes"):
		return [
			"Конечно. Заставь эту {npc.npcSlave} визжать.",
			"Валяй. {pc.He} не помешает хорошего ебалова.",
			"Добро пожаловать. Только не испорти моё имущество так, чтобы им нельзя было пользоваться.",
			"Ладно. Только не испорти моё имущество так, чтобы им нельзя было пользоваться.",
			"Конечно, почему бы и нет? {pc.He} всё равно {pc.verb('exist')}.",
			"Обязательно. Сделай так, чтобы стоны {pc.his} слышала вся тюрьма.",
			"Да. Поставь эту {npc.npcSlave} на {pc.his} место.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferYesThree"):
		return [
			"Знаешь что? Ладно. Я присоединюсь и покажу тебе, как это делается.",
			"Вообще-то, я тоже в деле. Устроим тройничок.",
			"Хорошая идея. Мне самой не помешало бы снять стресс.",
			"Ладно, но первый ход за мной. Смотри и учись.",
			"Да, и я покажу тебе, как правильно заставить {pc.him} умолять.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferNo"):
		return [
			"Ни хера. Можешь смотреть, но к моей {npc.npcSlave} не прикасаться.",
			"Ни единого шанса, блять. Ищи себе другую {npc.npcSlave}, которую будешь портить.",
			"Абсолютно нет. Моя {npc.npcSlave} — не какая-то там публичная шлюха.",
			"Съебись отсюда нахер. Эта {npc.npcSlave} принадлежит только мне.",
			"Проваливай, отброс. Я не позволяю такому мусору, как ты, трогать моё.",
			"Тронешь мою {npc.npcSlave} — и я тебе, блять, руки переломаю.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferNo2"):
		return [
			"Ладно.",
			"Плевать.",
			"Твоя потеря.",
			"Как хочешь.",
			"Жадная сволочь.",
			"Упущенная возможность.",
			"Жалкое зрелище.",
			"Ожидаемо.",
			"Пустая трата времени.",
			"Ну и оставь свой мусор себе.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferGood"):
		return [
			"Хорошая маленькая {npc.npcSlave}. А теперь продолжим этот парад.",
			"Видишь? Ты была рождена быть публичной шлюхой. А теперь шевели жопой.",
			"Хорошо. А теперь хватит купаться во внимании, двигайся дальше.",
			"Шоу окончено. Пора идти, {npc.npcSlave}.",
			"Ладно. Хватит развлекаться. За работу.",
			"Я еще не закончила выставлять свою собственность напоказ. Пошли.",
			"Развлекать толпу — твоя работа. А теперь марш.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferFight"):
		return [
			"Понятно. Тебе просто нужно, чтобы кто-нибудь вбил в тебя капельку здравого смысла.",
			"Неправильный ответ, ублюдок. Пора показать тебе, как здесь всё устроено.",
			"Так вот оно как? Ладно. Значит, я возьму то, что хочу, силой.",
			"Идеально. Я как раз искала повод сегодня кого-нибудь помучить.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferWon"):
		return [
			"Еще один дурак, решивший, что может забрать моё.",
			"Пусть это станет уроком для всех наблюдающих. Никто не трогает мою {npc.npcSlave}, кроме меня.",
			"Еще один тупой мудак повержен. Теперь все знают, что со мной лучше не связываться.",
			"Они реально думали, что смогут тебя отбить? Как же это, блядь, мило.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferLostWatch"):
		return [
			"Теперь ты моя. А твой жалкий хозяин будет на это смотреть.",
			"Я победил. И теперь твой тупой хозяин получит места в первом ряду на это шоу.",
			"Я победил. Твоему хозяину стоит внимательно смотреть, как я буду надлежащим образом ломать {npc.his}.",
		]
	if(_id == "SoftSlaveryParadeFuckOfferLostBoth"):
		return [
			"Я победил. Думаю, я трахну вас обеих, никчемные шлюхи.",
			"Две по цене одной. Буду использовать вас, как мне заблагорассудится.",
			"Идеально. Две секс-игрушки в моем распоряжении.",
		]

	if(_id == "SoftSlaveryParadeGuard"):
		return [
			"Эй. Какого хуя здесь происходит?",
			"А ну стоять, мразь. Объясни это дерьмо.",
			"Ты! Какого хуя ты себе позволяешь?",
			"Стой. У тебя должно быть чертовски хорошее объяснение.",
			"Эту заключенную что, реально должны держать на поводке, как животное?",
			"Погоди. Какого хуя эта заключенная на поводке? Живо объясняйся.",
			"Объясняйся. Живо. Почему {pc.isAre} {pc.he} на поводке, как собака?",
			"Так, блять, стоять. Мне нужно знать, что это за хуйня происходит.",
		]
	if(_id == "SoftSlaveryParadeGuardPunish"):
		return [
			"Я ставлю эту никчемную зэчку на {pc.his} место.",
			"Просто учу эту зэчку, блять, манерам.",
			"Устраиваю этой непослушной зэчке заслуженное унижение.",
			"Стандартная процедура, чтобы поставить непослушную зэчку в строй.",
			"Просто напоминаю этой зэчке, на что {pc.he} годна.",
		]
	if(_id == "SoftSlaveryParadeGuardPunish2"):
		return [
			"Ну, тогда продолжай. Сделай так, чтобы ей было больно.",
			"Очень хорошо. Не церемонься с {pc.him}.",
			"Ладно. Сделай так, чтобы {pc.he} выучила {pc.his} урок.",
			"Ладно, научи этого зэка уважению.",
			"Ладно. {pc.He} наверняка {pc.verb('deserve')} во что бы то ни стало {pc.he} {pc.verb('get')}.",
			"Хорошо. Этот зек выглядит так, будто {pc.he} {pc.verb('need')} это.",
		]
	if(_id == "SoftSlaveryParadeGuardProblem"):
		return [
			"Это, блядь, не твое дело.",
			"Отъебись, это тебя не касается, нищеброд.",
			"Занимайся своим ебаным делом, пока тебе не прилетело.",
			"Свали в сторону, охранник. Это дело между мной и моей собственностью.",
			"Поверь мне, тебе лучше в это не ввязываться.",
			"Свали нахуй, пока я не заставил тебя пожалеть об этом.",
			"Это между мной и моим {npc.npcSlave}. Отъебись.",
			"Не твоё дело. Проваливай, пока ещё можешь.",
			"Исчезни. {pc.He} {pc.isAre} моя собственность, а не твоя.",
		]
	if(_id == "SoftSlaveryParadeGuardProblem2"):
		return [
			"Серьёзно? Хочешь сегодня помучиться?",
			"Ты реально хочешь, блядь, это сделать?",
			"Так вот как всё будет? Мне только в радость.",
			"Ты совершаешь свою последнюю гребаную ошибку.",
			"Много слов для того, кого сейчас будут ебать во все щели.",
			"Тебе не следовало этого говорить.",
		]
	if(_id == "SoftSlaveryParadeGuardWon"):
		return [
			"Так просто от меня не отделаешься.",
			"Вот что бывает, когда лезешь к тому, что принадлежит мне.",
			"Так на чём мы остановились? Ах да, пошли.",
			"Пусть это послужит уроком любому, кто решит со мной связаться.",
			"Пошли, {npc.npcSlave}. Мы еще не закончили.",
			"Пора продолжать, {npc.npcSlave}.",
			"Теперь, когда с помехами покончено, вернемся к делу.",
		]
	if(_id == "SoftSlaveryParadeGuardLost"):
		return [
			"Проваливай, зек.",
			"Считай, что тебе повезло. А теперь брысь отсюда.",
			"Можешь идти. Только не попадайся мне на глаза в таком виде снова.",
			"Беги уже. Второго шанса не будет.",
			"Шевели поршнями, пока я не передумала.",
			"Свободен. И не заставляй меня жалеть об этом.",
			"Давай, съебись нахуй с моих глаз.",
			"Считай, что это твой счастливый день. А теперь исчезни.",
		]


	if(_id == "SoftSlaveryGB"):
		return [
			"Сегодня твои дырки — общественная собственность. Я сдаю тебя в аренду любому, кому посчитаю нужным. Будь благодарна, если получишь хоть один кредит, {npc.npcSlave}.",
			"Я решила, что сегодня ты у нас шлюха для групповухи. Тебя будет юзать любой отброс, которого я здесь найду. Может, хоть раз отработаешь свой хлеб, {npc.npcSlave}.",
			"Пора заставить это тело приносить пользу. Сегодня тебя будут передавать из рук в руки, как дешевую игрушку. Не жди многого, но, может, тебе и перепадет доля, {npc.npcSlave}.",
			"Твоя единственная цель на сегодня — быть шлюхой для группового секса. Я продаю твои дырки тем, кто больше предложит. Может, получишь процент, если развлечешь нас как следует, {npc.npcSlave}.",
			"Сегодня ты не более чем живая мастурбаторка. Готовься, что тебя будут юзать без смазки все, кому я позволю. Считай любые кредиты, что получишь, благословением, {npc.npcSlave}.",
		]
	if(_id == "SoftSlaveryGBGiveup"):
		return [
			"Ну конечно, никто не хочет тратить на тебя время. Ты даже усилий не стоишь.",
			"Неудивительно. Ты недостаточно хороша, чтобы ради тебя кто-то заморачивался.",
			"Жалкое зрелище. Даже клиентов привлечь не можешь, хотя я тебя практически даром раздаю.",
		]
	if(_id == "SoftSlaveryGBOffer"):
		return [
			"Эй! Я тут подрабатываю сутенершей для своей никчемной {npc.npcSlave}, устраиваю групповуху. Просто платите мне.",
			"Хотите поюзать мою рабыню? Мне нужны тела, чтобы эта групповуха стоила того. И вы мне за это заплатите.",
			"Ищу желающих разломать мою {npc.npcSlave}. Не беспокойтесь о нежности. Просто заплатите мне вперед.",
			"Хотите снять стресс? Моя {npc.npcSlave} свободна. Просто платите и присоединяйтесь.",
			"Нужно выпустить пар? Моя {npc.npcSlave} готова побыть шлюхой для гангбанга. Но это будет стоить вам кредитов.",
		]
	if(_id == "SoftSlaveryGBSure"):
		return [
			"Наконец-то достойное развлечение.",
			"Определенно. Мне как раз не помешало бы кого-нибудь оттрахать толпой.",
			"Чертовски да! Давайте устроим этой сучке {pc.his} испытание.",
			"Конечно, почему бы и нет. Звучит пиздато.",
			"Ладно, я в деле. Это должно быть забавно.",
		]
	if(_id == "SoftSlaveryGBFollow"):
		return [
			"Идите за мной, поищем местечко.",
			"Сюда. Пора заставить эту {npc.npcSlave} стонать.",
			"За мной. Пора начинать этот гангбэнг.",
			"Давай же. Чем быстрее начнем, тем быстрее сломаем {pc.him}.",
			"Иди за мной. Я хочу, чтобы эту {npc.npcSlave} оттрахали толпой, пока не стало слишком поздно.",
			"Пошли. Жду не дождусь, когда эта шлюха заскулит.",
		]
	if(_id == "SoftSlaveryGBSubOffer"):
		return [
			"Вообще-то, я хочу, чтобы трахали меня. Я заплачу.",
			"А можно мне вместо неё быть дыркой? У меня есть кредиты.",
			"Я бы лучше сама принимала все члены. Называй цену.",
			"Используй меня вместо своей рабыни. Я сделаю так, что ты не пожалеешь.",
			"Позволь мне стать шлюхой для гангбэнга. Я могу заплатить за эту привилегию.",
			"Меня тоже оттрахаете толпой? У меня полно кредитов.",
			"Я хочу, чтобы использовали меня. Забирай мои кредиты.",
		]
	if(_id == "SoftSlaveryGBSubOfferYes"):
		return [
			"Ладно. Еще больше мяса для мясорубки. Надеюсь, твои кредиты стоят того.",
			"Плевать. Очередная отчаявшаяся шлюшка, готовая платить за унижения. Ну, окей.",
			"Отлично. Платить за групповуху — ну и шлюха.",
			"Хорошо. Платящие клиенты получают самое жесткое обращение.",
		]
	if(_id == "SoftSlaveryGBSubOfferNo"):
		return [
			"Нам не нужна еще одна платящая шлюха. Одна у нас уже есть.",
			"Нет, у нас и так хватает отчаявшихся дырок.",
			"Поздно, это место уже занято.",
			"У нас уже предостаточно ебаного мяса.",
		]
	if(_id == "SoftSlaveryGBSubOfferNoAw"):
		return [
			"Ладно. Твои потери.",
			"Плевать.",
			"Типично.",
			"Ладно.",
			"Отлично. Похуй.",
		]
	if(_id == "SoftSlaveryGBNo"):
		return [
			"Не интересно.",
			"Нахер это надо.",
			"Нет, спасибо, у меня есть стандарты.",
			"Пропустим это.",
			"Пожалуй, не стоит.",
			"Вовсе нет.",
		]
	if(_id == "SoftSlaveryGBNoReact"):
		return [
			"Твоя потеря, ублюдок.",
			"Значит, нам достанется больше, трус.",
			"Ладно. Нам и так не особо нужна твоя слабая жопа.",
			"Да пофиг. Тебя и убеждать не стоит.",
			"Жалкое зрелище. Настоящий кайф тебе не по зубам.",
			"Типично. Слишком неженка для нормального развлечения.",
		]
	if(_id == "SoftSlaveryGBStart"):
		return [
			"Пора за дело.",
			"Все готовы? Начнем.",
			"Пусть начинается групповуха. Не сдерживайтесь.",
			"Пора проверить, на сколько хватит этой {npc.npcSlave}.",
			"Посмотрим, сколько эта {npc.npcSlave} выдержит, прежде чем сломается.",
		]
	if(_id == "SoftSlaveryGBEnd"):
		return [
			"Наконец-то закончили. Вот твоя доля, {npc.npcSlave}. Не потрать всё сразу.",
			"Все повеселились? Хорошо. Ты это заслужила, {npc.npcSlave}.",
			"Повеселилась? Уверена, что да. Вот твоя часть.",
			"Пожалуй, ты не совсем бесполезна. Это твоё, {npc.npcSlave}.",
			"Ты выжила. Вот твоя плата за то, что была послушной дыркой.",
			"Все довольны? Отлично. Это тебе, {npc.npcSlave}.",
		]


	if(_id == "SoftSlaveryLockRestraint"):
		return [
			"Сегодня мне хочется нацепить на тебя что-нибудь.",
			"У меня настроение посмотреть на тебя в кандалах.",
			"Твоё тело выглядит... пустым. Мне нужно закрепить на тебе что-нибудь.",
			"Время бондажа. Ты будешь носить всё, что я на тебе защелкну.",
			"Ты принадлежишь мне до последнего дюйма. Пора тебя запереть.",
			"Твоя голая кожа просто умоляет о каком-нибудь снаряжении для связывания."
		]
	if(_id == "SoftSlaveryLockRestraint2"):
		return [
			"Выбирай любую, сегодня я щедра.",
			"Выбирай. Мне доставляет удовольствие наблюдать, как ты сама выбираешь свое снаряжение.",
			"С чем, по-твоему, ты сможешь совладать? Говори же, живо!",
			"Выбери свои путы. Какие из них сделают тебя совершенно беспомощной?",
		]
	if(_id == "SoftSlaveryLockRestraint3"):
		return [
			"Ключ у меня. Попробуешь сломать оковы — и я превращу твою жизнь в ад, {npc.npcSlave}.",
			"Ключ у меня. Попытаешься сбежать — и тебя ждет наказание, {npc.npcSlave}.",
			"Это будет заперто, пока я не скажу иначе. Привыкай.",
			"Эти путы останутся на тебе навсегда, пока я не решу иначе. Не заставляй меня наказывать тебя.",
		]
	if(_id == "SoftSlaveryOfferGearUnlock"):
		return [
			"Уже надоело сидеть взаперти? Может, пора тебя уже развязать?",
			"Устала от этих оков? Что ж, полагаю, пришло время их снять.",
			"Ты заперта уже довольно долго. Готова, чтобы тебя отперли?",
			"Устала от ограничений? Может, я и дам тебе свободу... на время.",
		]
	if(_id == "SoftSlaveryOfferGearUnlock2"):
		return [
			"Вот так. Временная свобода. Но не привыкай. А теперь я хочу заняться с тобой кое-чем другим.",
			"Пока что свободна. Пора заняться чем-нибудь другим.",
			"Наслаждайся свободой, пока можешь. Пора переходить к делу.",
		]
	if(_id == "SoftSlaveryOfferGearUnlockKeep"):
		return [
			"Хочешь остаться взаперти? Что ж, валяй.",
			"Тебе больше нравятся путы? Хорошо. Твое место в рабстве.",
			"Нравится быть запертой? Я так и знала, что ты рождена быть рабыней.",
			"Хочешь оставаться связанной? Отлично.",
			"Предпочитаешь быть в оковах? А ты, оказывается, не такая уж и тупая.",
		]
	if(_id == "SoftSlaveryOfferGearUnlockKeep2"):
		return [
			"А теперь пора пустить мою связанную собственность в дело.",
			"Раз уж ты остаешься взаперти, пришло время для новых развлечений.",
			"Ну, посмотрим, что еще я могу сделать со своей скованной рабыней.",
		]
	if(_id == "SoftSlaveryNoticedNoGear"):
		return [
			"Где твои оковы, {npc.npcSlave}? Я точно помню, что застегивал их на тебе.",
			"На тебе нет моих пут. Живо объясняйся, {npc.npcSlave}.",
			"Снаряжение, которым я тебя сковал, исчезло. Это сулит тебе неприятности, {npc.npcSlave}.",
			"Ты должна была быть в путах. Где снаряжение, {npc.npcSlave}?",
			"Ты без своего бондажа. Не хочешь объяснить это дерьмо?"
		]
	if(_id == "SoftSlaveryNoticedNoGear2"):
		return [
			"Это значит — наказание, и оно будет суровым.",
			"Ты только что сама напросилась на наказание.",
			"Ты совершила очень глупый поступок. Готовься к наказанию.",
		]

	if(_id == "SoftSlaveryAskSex"):
		return [
			"Наконец-то вспомнила свое место? А теперь на колени.",
			"Наконец-то ты начала умолять как следует. На колени, ничтожество.",
			"С радостью. Как раз искала, на ком бы сорвать злость. На колени.",
			"Ты будешь брать всё, что я дам. А теперь — на колени.",
			"Встань на колени, и, может быть, я соизволю использовать твое жалкое тело.",
		]
	if(_id == "SoftSlaveryAskFuckOwner"):
		return [
			"Ладно. Только не разочаруй меня.",
			"Не привыкай к такой привилегии. Постарайся не облажаться.",
			"Хорошо. Только не будь совсем уж жалкой тварью.",
			"Разрешаю. Сделай так, чтобы это того стоило.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerBad"):
		return [
			"Жалкое зрелище. Даже девственница справилась бы лучше.",
			"Абсолютно бесполезная. Ты больше никогда не будешь сверху.",
			"Это было позорно. Ты совершенно безнадежна.",
			"Ты хоть сама понимаешь, что творишь? Очевидно, что, блядь, нет.",
			"Бесполезная. Живо на свое место — под мой {npc.foot}.",
			"Только попробуй еще раз попроситься на «топа», после такого позорища.",
			"Вау. Это было реально хреново. Тебе должно быть стыдно.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerOkay"):
		return [
			"В лучшем случае — посредственно. Едва ли стоило затраченных усилий.",
			"Не совсем ужасно, но всё равно жалко.",
			"Удивительно, но ты не опозорилась окончательно.",
			"Средне. Что для тебя — уже достижение.",
			"Слабовато, но сойдет.",
			"Не самое худшее из того, что мне приходилось терпеть, но близко к тому.",
			"Для начала сойдет. Только не задирай нос.",
		]
	if(_id == "SoftSlaveryAskFuckOwnerGood"):
		return [
			"Не совсем ужасно. Можешь пожить еще, {npc.npcSlave}.",
			"Хоть раз получилось нормально. Постарайся не скатываться.",
			"Впечатляет. Впрочем, для рабыни — вполне.",
			"Наконец-то хоть какой-то вменяемый результат. Давно пора.",
			"Ты превзошла мои низкие ожидания. Хорошо.",
			"Работа сделана сносно. Может, сегодня я тебя и не накажу.",
		]


	if(_id == "SoftSlaveryPetFuck"):
		return [
			"Не вздумай сопротивляться, {npc.npcSlave}. Этот сучьий костюм наденут на тебя, нравится тебе это или нет. А потом я тебя оттрахаю.",
			"Пора пустить в дело мою {npc.npcSlave}. Этот сучий костюм будет держать тебя в узде, пока я беру то, что хочу.",
			"Только попробуй дернуться. Я надеваю это, чтобы как следует использовать свою сучку-трахозавтрак.",
			"Давай-ка наденем на тебя эти оковы, {npc.npcSlave}. Мне нужно, во что бы трахнуться, и ты — идеальный вариант.",
			"Не дергайся, {npc.npcSlave}. Я собираюсь тебя использовать, а этот костюм только облегчит мне задачу.",
			"Посмотри на это. Не волнуйся, все отверстия открыты, чтобы я мог юзать тебя без лишней возни.",
		]
	if(_id == "SoftSlaveryPetWalkies"):
		return [
			"Время прогулочки. Давай подготовим тебя, {npc.npcSlave}.",
			"Пора на прогулку, {npc.npcSlave}. Не заставляй меня ждать.",
			"Прогулочка, {npc.npcSlave}! Хватит дергаться, дай мне это на тебя нацепить.",
			"Мы идем гулять, {npc.npcSlave}. Хочу похвастаться своей собственностью. А теперь — надевай костюм сучки.",
			"Прогулочка. Давай покончим с этим, {npc.npcSlave}.",
			"А ну сюда, {npc.npcSlave}. Время прогулки. И ты будешь в костюме сучки.",
			"Прогулочка. Давай наденем на тебя снарягу, и пойдем.",
		]
	if(_id == "SoftSlaveryPetWalkiesReady"):
		return [
			"Готов? Постарайся не отставать, дворняга.",
			"Всё? Не заставляй меня тебя тащить.",
			"Готов идти? Шевелись быстрее.",
			"Готов? Хорошо. А теперь иди за мной и не тормози.",
			"Снарядился? Тогда погнали.",
			"Готов? Смотри не отстанешь.",
		]
	if(_id == "SoftSlaveryWalkiesCorrect"):
		return [
			"Верно.",
			"Вот так. Хоть раз в жизни.",
			"Хорошо. Ты сделал хоть что-то правильно.",
			"Верно. Ты это запомнил.",
			"Неплохо. Это ведь не так уж и сложно.",
			"Верно. Но не привыкай к похвалам.",
			"Хорошо. Ты стал чуть более послушным.",
		]
	if(_id == "SoftSlaveryWalkiesWrong"):
		return [
			"Неверно. Бесполезный.",
			"Ты облажался. Типично.",
			"Неверно. Даже близко не угадал.",
			"Это было неправильно. Очевидно.",
			"Неверно. Ты вообще стараешься?",
			"Жалкое зрелище. Мне нужно дрессировать тебя жестче.",
		]
	if(_id == "SoftSlaveryWalkiesBark"):
		return [
			"Ну и дворняга. Гавкни на меня.",
			"Такой жалкий щенок. Ну же, покажи, как ты умеешь лаять.",
			"Ну и питомец. Гавкни.",
			"Ну и тупая дворняга. А ну, давай, гавкни.",
			"Гавкни для меня, тупая псина.",
		]
	if(_id == "SoftSlaveryWalkiesPet"):
		return [
			"Какая покорная дворняжка. Можно тебя погладить?",
			"Такой покорный щенок. Можно тебя потискать?",
			"Такой покорный питомец. Не против, если я тебя поглажу?",
			"Щеночек. Можно тебя погладить?",
			"Можно тебя погладить, чтобы ты не вцепилась?",
			"Такая покорная зверушка. Можно погладить?",
		]
	if(_id == "SoftSlaveryWalkiesGoodPuppy"):
		return [
			"Такая послушная зверушка.",
			"Хорошо.",
			"Ну и щенок.",
			"Хороший щенок.",
			"Хороший песик.",
		]
	if(_id == "SoftSlaveryWalkiesGoodPuppySex"):
		return [
			"Ты собираешься быть полезной и дашь мне трахнуть тебя?",
			"Будешь хорошей сучкой и сама подставишься?",
			"Будешь послушным песиком и позволишь мне тебя использовать?",
			"Будешь послушной и позволишь мне тебя оттрахать?",
			"У тебя что, течка, щенок? Может, я смогу её утолить.",
			"Будь хорошей собачкой и дай мне себя использовать.",
		]
	if(_id == "SoftSlaveryWalkiesBadPuppy"):
		return [
			"Тупая дворняжка.",
			"Плохая собачка.",
			"Бесполезный щенок.",
			"Никчемная дворняжка.",
			"Паршивая дворняжка.",
			"Плохая секс-игрушка.",
			"Бесполезная сучка.",
		]
	if(_id == "SoftSlaveryWalkiesBadPuppyObey"):
		return [
			"Тебе стоит больше слушаться, {npc.npcSlave}.",
			"Ты научишься подчиняться, {npc.npcSlave}.",
			"Твоя покорность довольно низка, {npc.npcSlave}.",
			"Ты научишься подчиняться.",
		]
	if(_id == "SoftSlaveryWalkiesLostNotDone"):
		return [
			"Плевать. Мы еще не закончили.",
			"Неважно. Шевели поршнями.",
			"Без разницы. Двигайся.",
			"Пофиг. Ты всё равно моя/мой.",
		]
	if(_id == "SoftSlaveryWalkiesBiteProtect"):
		return [
			"Это мой {npc.npcSlave}. Проваливай.",
			"Отойди. Эта дворняжка — моя.",
			"Исчезни. Этот щенок принадлежит мне.",
			"Тронешь моего питомца — пожалеешь.",
			"Свали нахер, пока я тебе больно не сделала.",
			"Этот щенок мой. Отойди.",
			"Проваливай. Это моё.",
		]
	if(_id == "SoftSlaveryWalkiesBiteBad"):
		return [
			"Ай! Приструни свою тупую зверюгу.",
			"Ой! Дрессируй свою дурацкую псину.",
			"Твою мать! Контролируй свою тупую дворнягу.",
			"Ай! Твоему тупому питомцу не хватает дисциплины.",
			"Ой! Твой тупой щенок совсем не обучен.",
			"Ай! Твоей дурацкой дворняге нужно больше тренировок.",
			"Ой! Твоему тупому щенку пора бы выучить своё место.",
			"Блядь. Приструни свою тупую псину.",
		]
	if(_id == "SoftSlaveryWalkiesBiteAttack"):
		return [
			"Ай! Ты за это заплатишь.",
			"Сука! Ты об этом пожалеешь.",
			"Ай! Ты за это пострадаешь.",
			"Это тебе дорого обойдётся.",
			"Ай! Я заставлю тебя визжать.",
			"Ай! Я тебя сломаю.",
		]
	if(_id == "SoftSlaveryWalkiesBall"):
		return [
			"Хочу поиграть с тобой в «апорт», щенок.",
			"Давай поиграем в «апорт», щеночек.",
			"Пора приносить мячик, щенок.",
			"Тебе нравится играть с мячиками? Давай поиграем в «апорт».",
			"Время приносить мячик. Надеюсь, ты знаешь, что делать.",
			"Посмотрим, как ты будешь приносить мячик, как послушная собачка.",
			"Что-то мне хочется поиграть в «апорт» со своим щенком.",
			"Время мячика, щенок.",
			"Давай поиграем в «апорт», мой маленький щеночек.",
			"Время игры в «апорт», питомец.",
		]
	if(_id == "SoftSlaveryWalkiesBall2"):
		return [
			"А ну, тащи мяч!",
			"Принеси!",
			"А ну, тащи!",
			"Принеси мячик!",
			"Апорт!",
			"А ну, принеси мой мячик!",
			"Живо принеси его!",
		]
	if(_id == "SoftSlaveryWalkiesPraise"):
		return [
			"Хорошо. Хоть раз не облажалась.",
			"Молодец. Наконец-то до тебя дошло.",
			"Ладно. Справилась.",
			"Хорошо. Ты сделал хоть что-то правильно.",
			"Хорошо. Ты меня не разочаровала.",
		]
	if(_id == "SoftSlaveryWalkiesBallTooFarFake"):
		return [
			"Не можешь найти? Он у меня в руке, глупая ты дворняжка.",
			"Ищешь это? Да я его даже не кидала, тупая псина.",
			"Всё еще ищешь? Мячик прямо здесь, у меня в руке. Ну и глупый же ты щенок.",
			"Не можешь найти? Это потому что я его не кидала. Ну и тупая же ты дворняжка.",
			"Всё ещё ищешь? Мячик всё это время был у меня, глупая ты дворняга.",
			"Запутался? Ну ты и дурачок. Я просто притворилась, что бросила его, тупая собака.",
		]
	if(_id == "SoftSlaveryWalkiesBallTooFar"):
		return [
			"Ты куда это собрался? Мячика там нет, потерянная ты псина.",
			"Опять заблудился? Мячик не так уж далеко улетел.",
			"Куда это ты побрел? Ну и тупая же собака.",
			"Ориентиры потерял? Мячика там нет.",
			"Уже потерялся? Бесполезный. Или, может, ты пытаешься сбежать?",
			"Бродишь где-то? Ты совсем потерялся.",
		]
	if(_id == "SoftSlaveryWalkiesNoBallFound"):
		return [
			"Грустишь, потому что не нашел мой мячик? Это потому, что я сделала вид, будто бросила его. Ну и тупой же щенок.",
			"Ты такой глупенький. Я ведь на самом деле его даже не бросала.",
			"Не можешь найти? Это потому, что я на самом деле его не кидала. И ты повелся.",
			"Не нашла мячик? Да потому что он у меня в руке, тупая ты щеночка.",
			"Не нашла? Мячик всё это время был у меня, глупая собачка.",
			"Запуталась? Какая же ты смешная. Я просто притворилась, что кинула его, тупая псина.",
		]

	if(_id == "SoftSlaveryBegUnlockNo"):
		return [
			"Черта с два. Ты реально думала, что я скажу «да»?",
			"Думаешь, мне не насрать на твой комфорт? Замки остаются на месте, {npc.npcSlave}.",
			"Без шансов. Обожаю смотреть, как ты мучаешься в этом снаряжении, {npc.npcSlave}.",
			"Это дерьмо будет на тебе вечно, пока мне не надоест. Смирись с этим, {npc.npcSlave}.",
			"Ты выглядишь идеально — беспомощная и загнанная в ловушку. С чего бы мне что-то менять?",
			"Спросишь еще раз — и я добавлю еще один замок. Попробуй только, {npc.npcSlave}.",
			"Твои страдания — моё развлечение. Снаряжение остается на тебе.",
			"Оно никуда не денется, {npc.npcSlave}. Считай это своей униформой на ближайшее время.",
		]
	if(_id == "SoftSlaveryBegUnlockYes"):
		return [
			"Уф, ладно. Моё веселье всё равно начинает угасать. Иди сюда.",
			"Может, я и сниму его, ясно?",
			"Думаю, ты заслужила передышку, {npc.npcSlave}.",
			"Пожалуй, я тебя отстегну. С меня хватит веселья.",
		]
	if(_id == "SoftSlaveryBegUnlockDone"):
		return [
			"Готово. Только не слишком радуйся — это ненадолго.",
			"Всё. Честно говоря, без всякой стяжки ты выглядишь жалко.",
			"Временная свобода. Оглянуться не успеешь, как я снова запру тебя.",
			"Наслаждайся моментом, пока можешь, {npc.npcSlave}. Моё терпение не бесконечно.",
			"Не привыкай. Я уже прикидываю, что на тебя навесить в следующий раз.",
		]
