extends DialogueFormBank

func getForms() -> Dictionary:
	return {
		"AttackStart": form("Я тебя просто в говно разнесу.", {main=CHAR, target=CHAR}, "main", "target"), # Attacking someone
		"AttackReact": form("Эй, какого хуя ты творишь? В чем твоя проблема?", {main=CHAR, target=CHAR}, "main", "target"), # Reacting to being attacked
		"FightLostGeneric": form("Аргх...", {loser=CHAR, winner=CHAR}, "loser", "winner"),
		"FightWonGeneric": form("Это было легко.", {loser=CHAR, winner=CHAR}, "winner", "loser"),
		"FightSurrender": form("Я сдаюсь, только не калечь меня.", {loser=CHAR, winner=CHAR}, "loser", "winner"),
		
		"GuardCaughtOffLimits": form("Эй, ты что там делаешь?", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardCaughtOffLimitsFight": form("Хочешь подраться? Ну, давай.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardInmateSurrender": form("Сдаешься? Умно.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardFrisk": form("Не двигайся, пока я это делаю.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardFriskFound": form("Так нельзя. Забираю.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardFriskNoFound": form("Чисто. Тебе повезло, зек.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardFriskFailResist": form("Аргх. Да к черту всё.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardGoAway": form("А теперь свали.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		"GuardKeepMoving": form("Двигайся, зэк.", {inmate=CHAR, guard=CHAR}, "guard", "inmate"),
		
		"PunishDecide": form("И что же мне с тобой делать...", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		"PunishDecideStocks": form("Колодки подойдут.", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		"PunishAboutToStocks": form("Наклонись.", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		"PunishLockIntoStocks": form("Развлекайся.", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		"PunishSex": form("Давай повеселимся.", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		"PunishSubSex": form("Ты можешь делать со мной всё, что захочешь.", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		"PunishDecidedSlutwall": form("Хочу видеть, как тебя используют другие на стене шлюх.", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		"PunishLockIntoSlutwall": form("Наслаждайся.", {punisher=CHAR, target=CHAR}, "punisher", "target"),
		
		"ReactBODYWRITINGS": form("Классные надписи на теле, шлюха!", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactTALLYMARKS": form("Классные зарубки, шлюха!", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactCOVERED_IN_CUM": form("Так грязно. Ну и шлюха!", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactCOVERED_IN_PISS": form("Фу, мерзость!", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactNAKED": form("Ха, прикройся, шлюха!", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactCAN_GRAB_AND_FUCK": form("Охренеть, кто-нибудь должен трахнуть тебя, сучка!", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactON_A_LEASH": form("Ха-ха, тебе нравится, когда тебя выставляют напоказ, шлюха?", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactGETTING_FUCKED": form("Красава, шлюху сейчас поимеют!", {main=CHAR, target=CHAR}, "main", "target"),
		
		"ReactLEASHING_SOMEONE": form("Отличный улов!", {main=CHAR, target=CHAR}, "main", "target"),
		"ReactFUCKING_SOMEONE": form("Да, трахай эту сучку!", {main=CHAR, target=CHAR}, "main", "target"),
	
		"AskKeyCanYouUnlock": form("Эй, может, отперешь меня?", {main=CHAR, target=CHAR}, "main", "target"),
		"AskKeyDeny": form("Может, позже.", {main=CHAR, target=CHAR}, "main", "target"),
		"AskKeyGive": form("Ладно, давай отперем тебя.", {main=CHAR, target=CHAR}, "main", "target"),
		"AskKeyChallenge": form("Слушай сюда. Я сейчас тебя трахну. И если будешь послушной подстилкой... может, тогда и отперу.", {main=CHAR, target=CHAR}, "main", "target"),
		"AskKeyChallengeUnlock": form("Хорошая сучка. Мне это понравилось.", {main=CHAR, target=CHAR}, "main", "target"),
		"AskKeyChallengeFail": form("Отстой. Можешь и дальше сидеть взаперти, шлюха.", {main=CHAR, target=CHAR}, "main", "target"),
		"AskKeyChallengeRefuse": form("Я отказываюсь.", {main=CHAR, target=CHAR}, "main", "target"),
		"AskKeyChallengeRefuseStay": form("Ну и сиди взаперти. Мне-то что.", {main=CHAR, target=CHAR}, "main", "target"),
		
		"HelpRestraintsAsk": form("Эй. Поможешь мне с этими креплениями?", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsAgree": form("Конечно. Посмотрим, что можно сделать.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsAltStart": form("Эй. Я хочу помочь тебе с этими креплениями. Посиди смирно.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsAltRefuseUnhappy": form("Мне не нужна твоя помощь с креплениями.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsAltRefuseKinky": form("О, я ношу это только потому, что мне так хочется.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsAltRefuseKinkyReact": form("Кинки.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsDeny": form("Не выйдет. Придется тебе оставаться взаперти.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsFinished": form("Это всё, что я могу сделать.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsPaid": form("Сойдет. Пойду теперь.", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsRefusePay": form("Я не буду платить! Ты даже толком ничего не сделал(а).", {main=CHAR, target=CHAR}, "main", "target"),
		"HelpRestraintsRefusePayWhatever": form("Ну и ладно.", {main=CHAR, target=CHAR}, "main", "target"),
		
		"HelpStocksSlutwallRefuse": form("Мне не нужна твоя помощь, чтобы вырваться на свободу.", {main=CHAR, target=CHAR}, "main", "target"),
		"SlutwallStealCredits": form("Такая шлюха, как ты, не заслуживает этих кредитов.", {main=CHAR, target=CHAR}, "main", "target"), # Stealing from the slutwall's tipbox
		"SlutwallAddTip": form("Вот так. Какая послушная секс-игрушка.", {main=CHAR, target=CHAR}, "main", "target"), # Getting tipped after being used in a slutwall
		"StocksShout": form("Есть кто? Мне тут нужна помощь!", {main=CHAR}, "main"), # Stuck in stocks, trying to get some attention
		
		"ProstitutionStart": form("Хочешь хорошенько развлечься?", {main=CHAR, target=CHAR}, "main", "target"), # Whore offering herself to the potential client
		"ProstitutionOffer": form("И что ты предлагаешь?", {main=CHAR, target=CHAR}, "main", "target"), # Client asking what the whore is offering
		"ProstitutionUsual": form("Как обычно, {X} кредитов.", {main=CHAR, target=CHAR, credits=VAR}, "main", "target"), # Whore offering her 'usual'
		"ProstitutionServiceDom": form("Я могу взять всё в свои руки и доставить тебе нереальное удовольствие, {X} кредитов.", {main=CHAR, target=CHAR, credits=VAR}, "main", "target"), # Whore offering to be a dominant during the sex
		"ProstitutionPricySlut": form("Я стою дорого. Но я того стою, детка, всего лишь {X} кредитов.", {main=CHAR, target=CHAR, credits=VAR}, "main", "target"), # Whore is trying to get more credits out of a client
		"ProstitutionClientAskForDomSlut": form("Мне бы хотелось посмотреть, как ты берешь всё в свои руки.", {main=CHAR, target=CHAR}, "main", "target"), # Client asks if sub slut would dom instead
		"ProstitutionClientAskForSubSlut": form("Если ты не против, я бы хотела сама заправлять здесь.", {main=CHAR, target=CHAR}, "main", "target"), # Client asks if dom slut would sub instead
		"ProstitutionDenied": form("Пожалуй, не стоит.", {main=CHAR, target=CHAR}, "main", "target"), # Client denying the whore (sometimes in a rude way)
		"ProstitutionDeniedWhatever": form("Ну и ладно, сама виновата.", {main=CHAR, target=CHAR}, "main", "target"), # Whore being annoyed that the client has denied her
		"ProstitutionAccept": form("Ладно, посмотрим, на что ты способна.", {main=CHAR, target=CHAR}, "main", "target"), # Client agreeing to the whore's services
		"ProstitutionDemandCreds": form("Отстой полный. Верни кредиты, шлюха.", {main=CHAR, target=CHAR}, "main", "target"), # Client wasn't satisfied enough with the sex
		"ProstitutionRefuseReturnCreds": form("Ничего я тебе не верну, отъебись!", {main=CHAR, target=CHAR}, "main", "target"), # Whore refuses to return the credits
		"ProstitutionScam": form("Знаешь что... Я решила поднять цену. Еще 5 кредитов, пожалуйста.", {main=CHAR, target=CHAR}, "main", "target"), # Whore is trying to scam the client and get more credits
		
		"TalkChatWhat": form("О чём хочешь потереть?", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkStartNemesis": form("Какого хера тебе надо?", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkChatCancel": form("Проехали, не хочу больше болтать.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkChatLeaving": form("Ну и хрен с тобой, я ухожу.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkChatAgree": form("Согласна.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkChatDisagree": form("Не согласна. Пошла нахуй.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkChatWhatever": form("Да похуй, честно говоря.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkChatPickupLine": form("Если бы ты был треугольником, ты был бы остроугольным.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkChatPickupLineFail": form("Это было так тупо!", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkFlirtAccept": form("Ты милашка.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkFlirtDeny": form("Не думаю, что мне нравится то, что ты предлагаешь.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkSexOffer": form("Эй, давай трахнемся!", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkSexOfferAccept": form("Конечно, можешь меня отъебать.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkSexOfferDeny": form("Пожалуй, не стоит.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkSexOfferSelf": form("Эй, может, трахнешь меня?", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkSexOfferSelfAccept": form("Конечно, я могу тебя очень сладко отъебать.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkSexOfferSelfDeny": form("Пожалуй, не стоит.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkGrabAndFuck": form("Ты никуда не уйдешь, пока я не развлекусь с тобой, БДСМ-шная шлюшка.", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkAboutToKidnap": form("Теперь ты моя. Понял?", {main=CHAR, target=CHAR}, "main", "target"),
		"TalkAboutToKidnapReact": form("O.. O-Okay..", {main=CHAR, target=CHAR}, "main", "target"),
	}
