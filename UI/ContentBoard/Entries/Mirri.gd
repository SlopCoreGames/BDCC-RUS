extends ContentBoardEntryBase

func _init():
	id = "Mirri"
	
func getName() -> String:
	return "Рынок Блэктейл"

func getDesc(_isFull:bool) -> String:
	if(_isFull):
		return "Познакомьтесь с Мирри и Люксом из семьи Блэктейл, которые проводят аукцион рабов. Получите возможность продавать своих рабов на рынке Блэктейл!"
	return "Встреться с Мирри и Люкс из семьи Блэктейл, которые проводят аукцион рабов. Продавай своих рабов здесь!"

func getKinks() -> Array:
	return [
		"Игрок доминирует",
		"Рабство (ПК — работорговец)",
		"Аукционы рабов",
		"Нонкон",
	]

func getCompletedDesc() -> String:
	var r6out = getFlag("SlaveAuctionModule.r6outcome", "")
	if(r6out == "mirrislave"):
		return ("Вы помогли Люксу продать Мирри в рабство. С глаз долой — из сердца вон! Вы всё ещё можете участвовать в черном рынке, но теперь уже в роли ведущего!")
	if(r6out == "mirrigone"):
		return ("Вы избавились от Мирри окончательно. Эта сучка получила по заслугам. Вы всё ещё можете участвовать в черном рынке, но теперь уже в роли ведущего!")
	if(r6out == "luxedead"):
		return ("Люкс мертв. Теперь Мирри — глава семьи Блэктейл! Если хотите, вы всё ещё можете продавать рабов на рынке Блэктейл.")
	if(r6out == "middleground"):
		return ("Вам удалось помочь Мирри и Люксу найти компромисс! Мирри больше не часть семьи Блэктейл, но Люкс больше не будет терроризировать её. Если хотите, вы всё ещё можете продавать рабов на рынке Блэктейл.")

	return "Теперь вы можете спокойно продавать рабов на рынке Блэктейл!"

func getStatus() -> int:
	if(getFlag("SlaveAuctionModule.repLevel", 0) >= 6):
		return ContentBoardStatus.Completed
	if(getFlag("SlaveAuctionModule.s1hap", false)):
		return ContentBoardStatus.InProgress
	return ContentBoardStatus.ConditionsNotMet

func getStartConditions() -> Array:
	return [
		[completeIf("Mining_IntroducedToMinning"), "Выполните приказ Риши и отправляйтесь работать в шахты."],
		[completeIf("PortalPantiesModule.Alex_FirstTimeTalked"), "Поговорите с Алексом Ринардом у входа в шахты."],
		[completeIf("PortalPantiesModule.Panties_AskedAlex"), "Спросите Алекса Ринарда, не может ли он помочь вам с кредитами."],
		[completeIfBool(getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex", false) || getFlag("PortalPantiesModule.Panties_PcDenied", false)), "Полностью выполни задание с «трусиками-порталами», которое дает Алекс Ринард, или откажи ему после первой же попытки."],
		[completeIfBool(GM.pc.getSkillsHolder().getLevel() >= 10), "Достигните 10 уровня."],
		[completeIf("SocketModule.socketIntroduced"), "Войдите в мастерскую, чтобы встретиться с Сокетом."],
		[completeIfBool(int(getFlag("NpcSlaveryModule.slavesSpace", 0)) > 0), "Купите у Сокета улучшение для расширения камер (минимум одно)."],
		[completeIfBool((GM.main.getPCSlaveAmount() > 0) || getFlag("SlaveAuctionModule.s1hap", false)), "Порабощайте кого угодно: избивайте, ломайте дух, а затем похищайте прямо в свою камеру."],
		[completeIfBool(doesPCHaveBrokenSlave() || getFlag("SlaveAuctionModule.s1hap", false)), "Заставьте хотя бы одного из своих рабов полностью подчиниться вам, сломав его волю или заставив полюбить вас."],
		[completeIf("SlaveAuctionModule.s1hap"), "Позвольте Мирри найти вас рядом с камерами!"],
	]

func getProgressText() -> String:
	return "Выполните задание \"Чернохвостый рынок\", чтобы продвинуться по сюжету"

func doesPCHaveBrokenSlave() -> bool:
	var hasBrokenSlave:bool = false
	var slaves = GM.main.getPCSlavesIDs()
	for slaveID in slaves:
		var theSlave:BaseCharacter = GlobalRegistry.getCharacter(slaveID)
		if(theSlave == null):
			continue
		var npcSlavery:NpcSlave = theSlave.getNpcSlavery()
		if(npcSlavery == null):
			continue
		if(npcSlavery.hasSubmittedToPC()):
			hasBrokenSlave = true
			break
	return hasBrokenSlave
