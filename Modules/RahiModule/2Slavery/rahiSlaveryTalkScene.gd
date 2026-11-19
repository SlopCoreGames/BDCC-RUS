extends SceneBase

func _init():
	sceneID = "rahiSlaveryTalkScene"

func _run():
	if(state == ""):
		addCharacter("rahi")
		aimCameraAndSetLocName("cellblock_orange_nearcell")
		
		var rahiModule = getModule("RahiModule")
		
		var statLimit = getModule("RahiModule").getStatLimit()
		if(getFlag("RahiModule.rahiObedience", 0) > statLimit):
			setFlag("RahiModule.rahiObedience", statLimit)
		if(getFlag("RahiModule.rahiAffection", 0) > statLimit):
			setFlag("RahiModule.rahiAffection", statLimit)
		
		playAnimation(StageScene.Duo, "stand", {npc="rahi"})
		saynn("Рахи стоит у своей кровати.")
		
		if(getFlag("RahiModule.rahiMile7Proposed", false)):
			saynn("Она с гордостью носит кольцо, которое ты ей подарил.")
		elif(getFlag("RahiModule.rahiMile8Branded", false)):
			saynn("Она выглядит гордой после того, как ты поставил на ней клеймо.")
		elif(getFlag("RahiModule.rahiMile8Pierced", false)):
			saynn("Она выглядит гордой, нося твой пирсинг.")
		
		var currentStage = getModule("RahiModule").getSlaveryStage()
		var isEnslaved = getFlag("RahiModule.rahiMile7Enslaved", false)
		
		if(getFlag("RahiModule.rahiNeedsPunishment", false)):
			saynn("[say=rahi]"+RNG.pick([
				"Она просит прощения, {rahiMaster}.. Она очень старалась..",
				"Ей ужасно стыдно за то, что она тебя подвела, {rahiMaster}..",
				"В следующий раз она будет стараться еще сильнее..",
				"Ей так жаль, что она тебя разочаровала, {rahiMaster}..",
				"Она сделает всё, чтобы загладить свою вину перед тобой, {rahiMaster}..",
				"Она надеется, что ты сможешь её простить, {rahiMaster}..",
				"Она знает.. Она всё запорола..",
				"Sorry, {rahiMaster}..",
				"Она готова принять любое наказание, какое ты сочтешь нужным, {rahiMaster}..",
				"Пожалуйста, помоги ей извлечь урок из этой ошибки, {rahiMaster}..",
			])+"[/say]")
		# Just saved Rahi
		elif(currentStage <= 0):
			saynn("[say=rahi]"+RNG.pick([
				"Спасибо.. за то, что спас её..",
				"Она надеется, что не слишком тебя утомляет...",
				"Oh.. Hello..",
				"Она не очень сильна в разговорах... прости...",
				"Ох... Она на мгновение ушла в свои мысли...",
				"Э-эм... Хочешь немного поболтать?..",
				"Она готова выложиться на полную...",
				"Здравствуй...",
			])+"[/say]")
		# Stole crate of toys
		elif(currentStage <= 1):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Ей понравилось наше последнее... ограбление?..",
				"Эй, {rahiMaster}... Она старается не навлекать на себя неприятностей...",
				"Она ценит твою компанию, {rahiMaster}...",
				"Она надеется, что ты не слишком разочарован в ней, {rahiMaster}...",
				"Это было весело... то, что мы сделали... Не так ли, {rahiMaster}?...",
				"Хочешь немного поболтать, {rahiMaster}?.. Она не особо разговорчивая..",
				"Она очень благодарна за то, что ты рядом, {rahiMaster}..",
			])+"[/say]")
		# Got caught drinking
		elif(currentStage <= 2):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Она была такой дурой.. Прости, {rahiMaster}..",
				"Та история с выпивкой.. Больше не повторится, {rahiMaster}..",
				"Прости, что нарушила правила, {rahiMaster}..",
				"Она примет любое наказание, {rahiMaster}.., чтобы всё исправить..",
				"Она постарается лучше себя контролировать, {rahiMaster}.. Просто.. это так трудно..",
				"Ей кажется, что от неё нет никакого толку, {rahiMaster}..",
				"Иногда ей просто хочется свернуться калачиком..",
				"Она вечно всех подводит..",
				"Она устала... быть в одиночестве...",
				"Будет ли кто-нибудь скучать по ней, если она исчезнет?.. Дурацкие мысли... Прости, {rahiMaster}...",
				"Кажется, она сходит с ума...",
				"Ей так стыдно за саму себя...",
				"Такое чувство, будто она тонет, {rahiMaster}...",
			])+"[/say]")
		# After wholesome scene at a waterfall
		elif(currentStage <= 3):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Она очень старается, {rahiMaster}... Но это так трудно...",
				"Она не заслуживает кого-то настолько доброго, как ты, {rahiMaster}...",
				"Она не знает, как отблагодарить тебя, {rahiMaster}...",
				"Ты приносишь свет в её мрачные дни, {rahiMaster}...",
				"Она чувствует... себя в безопасности... когда ты рядом, {rahiMaster}...",
				"Ты заставляешь её хотеть стать лучшей кошечкой, {rahiMaster}..",
				"Она рада, что ты здесь, {rahiMaster}..",
				"Брызгаться с тобой водой было так весело, {rahiMaster}..",
				"Ей стало гораздо лучше после того, что мы творили у того пруда, {rahiMaster}..",
			])+"[/say]")
		# After sharing her backstory
		elif(currentStage <= 4):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Ты единственный, кто её понимает, {rahiMaster}..",
				"Прости, что нагрузил тебя её проблемами, {rahiMaster}..",
				"Спасибо, что не отверг её, {rahiMaster}..",
				"Она чувствует... надежду?.. впервые за долгое время.. Спасибо, {rahiMaster}..",
				"Она думала, что никогда не сможет поделиться своей историей..",
				"Она благодарна за твою поддержку.. Спасибо, что помогаешь ей пройти через это..",
				"Она не знает, сможет ли когда-нибудь простить саму себя...",
				"Как думаешь, старые шрамы могут затянуться, {rahiMaster}?.. Она считает, что нет...",
				"Ты всегда делаешь её счастливой, {rahiMaster}... ",
				"Она хочет быть с тобой честной, {rahiMaster}... Ей хочется выпить... так сильно...",
				"Пожалуйста, не бросай её, {rahiMaster}...",
			])+"[/say]")
		# After ending her alcohol addiction
		elif(currentStage <= 5):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Она хочет навсегда забыть о той, кем была раньше...",
				"Она и представить не могла, как тяжело будет завязать с выпивкой, {rahiMaster}...",
				"Ей стало гораздо лучше, {rahiMaster}... Теперь, когда она трезвая...",
				"Ей всё ещё предстоит долгий путь, верно, {rahiMaster}?.. Но мы со всем справимся...",
				"Теперь ей нужно встретиться со своими страхами и эмоциями лицом к лицу... Это... пугает...",
				"Она просто не знает, как тебя отблагодарить, {rahiMaster}..",
				"Она хочет, чтобы ты ею гордился, {rahiMaster}..",
				"Она мечтает быть такой же уверенной, как ты, {rahiMaster}..",
				"Ты всегда рядом, когда ей нужна поддержка, {rahiMaster}..",
				"Теперь всё ведь наладится, правда, {rahiMaster}?..",
				"Чего-то хочешь, {rahiMaster}?..",
				"Она хорошая кошечка или плохая, {rahiMaster}?..",
			])+"[/say]")
		# After getting healed in cryo
		elif(currentStage <= 6):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Она чувствует себя новой кошечкой..",
				"Она благодарна тебе за заботу и внимание, {rahiMaster}..",
				"Она... вроде как в предвкушении?..",
				"Она чувствует, что снова обрела саму себя... Спасибо тебе, {rahiMaster}...",
				"Ей не терпится узнать, что готовит ей будущее...",
				"Ей так повезло, что ты есть у неё, {rahiMaster}...",
				"Так странно... больше не чувствовать ту боль...",
				"Она рада, что ей больше не нужно прятать свои шрамы...",
				"Meow-meow-meow.. Oh, sorry, {rahiMaster}..",
				"Мяу...",
				"Она ведь показала их тому врачу, верно?..",
				"Она больше никогда не хочет возвращаться в то темное место, {rahiMaster}...",
				"Она и не осознавала, как сильно ты была ей нужна, {rahiMaster}...",
				"Она не знает, где бы она была без тебя, {rahiMaster}...",
				"Она заставит тебя гордиться ею, {rahiMaster}..",
			])+"[/say]")
		# After Rahi agrees to be your slave
		elif(currentStage <= 7 && isEnslaved):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Она сделает всё возможное, чтобы служить тебе, {rahiMaster}.",
				"Она.. Я.. хочу сделать тебя счастливым, {rahiMaster}..",
				"Она всегда будет уважать тебя и повиноваться тебе, {rahiMaster}..",
				"Она.. Я.. предана тебе всем сердцем, {rahiMaster}..",
				"Она принадлежит тебе, {rahiMaster}..",
				"Она.. Я сделаю всё, чтобы ты был счастлив, {rahiMaster}..",
				"Она будет исполнять любую твою команду, {rahiMaster}..",
				"Спасибо тебе.. за то, что сделал её.. меня.. своей рабыней, {rahiMaster}..",
				"Для неё это огромная честь, {rahiMaster}..",
			])+"[/say]")
		# Proposed to Rahi
		elif(currentStage <= 7 && !isEnslaved):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"Она просто не может дождаться, когда станет твоей... женой... {rahiMaster}...",
				"Спасибо, что заставляешь её чувствовать себя такой особенной, {rahiMaster}...",
				"Ты значишь для неё всё... для меня тоже, {rahiMaster}...",
				"Ты сделал меня самой счастливой кошечкой в мире, {rahiMaster}...",
				"Ты — моё всё, {rahiMaster}...",
				"Она любит тебя, {rahiMaster}...",
				"Она так благодарна судьбе за то, что ты есть в её жизни, {rahiMaster}...",
				"Мечты ведь и правда сбываются, правда, {rahiMaster}?..",
				"Ня~!",
				"Мяу-мяу-мяу!",
			])+"[/say]")
		else:
			saynn("[say=rahi]Да, {rahiMaster}?..[/say]")
		
		sayn("Характеристики Рахи:")
		sayn("Стадия отношений: "+str(getFlag("RahiModule.rahiSlaveryStage", 0)))
		sayn("Послушание: "+str(getFlag("RahiModule.rahiObedience", 0)))
		sayn("Привязанность: "+str(getFlag("RahiModule.rahiAffection", 0)))
		sayn("Усталость: "+str(getFlag("RahiModule.rahiTired", 0)))
		sayn("")
		if(getFlag("RahiModule.rahiNeedsPunishment", false)):
			sayn("Рахи заслуживает наказания")
		if(getFlag("RahiModule.rahiNeedsReward", false)):
			sayn("Рахи заслуживает награды")
		if(getFlag("RahiModule.rahiNeedsPunishment", false) || getFlag("RahiModule.rahiNeedsReward", false)):
			sayn("")
		
		sayn("Навыки Рахи:")
		var skills = rahiModule.getSkillsInfo()
		for skillID in skills:
			var skillInfo = skills[skillID]
			
			if(!rahiModule.isSkillLearned(skillID)):
				continue
			
			sayn(skillInfo["name"]+": "+rahiModule.getSkillScoreText(skillID))
		if(getModule("RahiModule").canLearnNewSkill() && getFlag("RahiModule.rahiSlaveryShowNewSkill")):
			setFlag("RahiModule.rahiSlaveryShowNewSkill", false)
			sayn("(В меню отношений можно выбрать новый навык для обучения Рахи)")
		
		addButton("Поговорить", "Поболтать о всяком", "talk")
		if(getFlag("RahiModule.rahiTired", 0) < 3):
			addButton("Награда", "Вознаградить Рахи", "reward")
			addButton("Наказать", "Наказать Рахи", "punish")
			addButton("Занятия", "Посмотреть, что еще можно сделать с Рахи", "activities")
		else:
			addDisabledButton("Награда", "Рахи слишком устала")
			addDisabledButton("Наказать", "Рахи слишком устала")
			addDisabledButton("Занятия", "Рахи слишком устала")
		addButton("Отношения", "Посмотреть, к чему ведут ваши отношения", "relationship")
		if(currentStage >= 5):
			addButton("Покормить", "Покормить Рахи", "feedmenu")
		addButton("Уйти", "Хватит болтать", "endthescene")
		
		GM.ES.triggerRun(Trigger.TalkingToNPC, ["rahiSlavery"])
		
	if(state == "talk"):
		saynn("О чем ты хочешь поговорить с Рахи?")
		
		if(!getFlag("RahiModule.rahiCommentedOnTask", false)):
			addButton("Задание", "Обсудить выполненное задание", "talk_task")
		else:
			addDisabledButton("Задание", "Ты явно оценил её сегодняшнюю работу")
		addButton("О чем угодно", "Поболтать о чем угодно", "talk_anything")
		addButton("Назад", "Назад на меню", "")
		
	if(state == "reward"):
		var slaveryStage = getModule("RahiModule").getSlaveryStage()
		saynn("Как ты хочешь наградить кошечку?")
		
		addButton("Питомец", "Погладить кошечку", "doreward", ["rahiRewardPetScene"])
		if(slaveryStage >= 1):
			addButton("Дать лакомство", "Дать кошечке лакомство", "doreward", ["rahiRewardTreatScene"])
		if(slaveryStage >= 3):
			addButton("Обнимашки", "Потискать кошечку", "doreward", ["rahiRewardCuddleScene"])
		if(getModule("RahiModule").isSkillLearned("rahiSkillExhibit")):
			addButton("Эксгибиционизм", "(Эксгибиционизм) Нагота может приносить удовольствие...", "doreward", ["rahiRewardExhibitionismScene"])
		addButton("Назад", "Назад на меню", "")
		
	if(state == "punish"):
		saynn("Как ты хочешь наказать кошечку?")
		
		addButton("Связать", "Связать кошечку", "dopunish", ["rahiPunishmentTyingUpScene"])
		if(getModule("RahiModule").isSkillLearned("rahiSkillMasochist")):
			addButton("Придушить Рахи", "(Мазохизм) Наказать Рахи жестким брейсплей-сеансом", "dopunish", ["rahiPunishmentChokingScene"])
		if(getModule("RahiModule").isSkillLearned("rahiSkillPetplay")):
			addButton("Принудительный петплей", "(Петплей) Заставить Рахи надеть собачий костюм и вывести её на прогулку", "dopunish", ["rahiPunishmentForcedPetplayScene"])
		if(getModule("RahiModule").isSkillLearned("rahiSkillWatersports")):
			addButton("Писсуар", "(Вотерспорт) Сделать из Рахи свой мочевой унитаз", "dopunish", ["rahiPunishmentPissToiletScene"])
		addButton("Назад", "Назад на меню", "")
		
	if(state == "activities"):
		saynn("Что ты хочешь сделать со своей киской?")
		
		addButton("Душ", "Пойти в душ", "doactivity", ["RahiShowerScene"])
		addButton("Обнять", "Обнять киску и провести время вместе", "doactivity", ["RahiEmbraceScene"])
		if(getModule("RahiModule").isSkillLearned("rahiSkillDominance")):
			addButton("Доминирование", "Научить Рахи быть более доминантной", "doactivity", ["rahiActivityDominanceScene"])
		if(getModule("RahiModule").isSkillLearned("rahiSkillAnal")):
			addButton("Анальный тренинг", "Дрессировать Рахи, чтобы она стала задроткой-попой", "doactivity", ["rahiActivityAnalScene"])
		if(getModule("RahiModule").isSkillLearned("rahiSkillPetplay")):
			addButton("Петплей", "Дрессировать Рахи, чтобы она была щеночком/киской", "doactivity", ["rahiActivityPetplayScene"])

		addButton("Назад", "Назад на меню", "")
		
	if(state == "relationship"):
		saynn("Что ты хочешь изменить в ваших отношениях?")
		
		saynn("Твоя киска зовет тебя: {rahiMaster}")
		
		if(getModule("RahiModule").canSleepInPlayerCell()):
			if(getModule("RahiModule").shouldSleepInPlayerCell()):
				saynn("Твоя киска будет спать в твоей камере, если будет возможность.")
			else:
				saynn("Твоя киска спит в своей камере.")
			
			if(getModule("RahiModule").canSexThePlayerOnMornings()):
				if(getModule("RahiModule").shouldSexThePlayerOnMornings()):
					saynn("Твоя киска разбудит тебя сексом.")
				else:
					saynn("Твоя киска не будет будить тебя сексом.")
			
		# Unlocks from a certain stage
		if(getModule("RahiModule").getSlaveryStage() >= 1):
			addButton("Твой титул", "Как киска должна тебя называть?", "change_title")
		else:
			addDisabledButton("Твой титул", "Развивай отношения дальше, прежде чем сможешь выбрать титул")
		if(getModule("RahiModule").canLearnNewSkill()):
			if(getFlag("RahiModule.rahiTired", 0) < 3):
				addButton("Обучить новому навыку", "Начать обучение киски новому навыку", "train_new_skill")
			else:
				addDisabledButton("Обучить новому навыку", "Рахи слишком устала для этого")
		
		if(getModule("RahiModule").canSleepInPlayerCell()):
			addButton("Переключить режим сна", "Должна ли кошечка спать с тобой в камере или нет", "toggle_sleep")
			
			if(getModule("RahiModule").canSexThePlayerOnMornings()):
				addButton("Утренний секс", "Должна ли кошечка удивить тебя утренним сексом", "toggle_morningsex")
			else:
				addDisabledButton("Утренний секс", "(Секс) Кошечке нужно лучше владеть техникой, чтобы это сделать")
		
		if(getFlag("RahiModule.wearingPortalPanties")):
			addButton("Снять портативные трусики", "Забрать их обратно у Рахи", "take_portal_panties_back")
		elif(GM.pc.getInventory().hasItemID("PortalPanties")):
			addButton("Отдать портативные трусики", "Попросить Рахи надеть те трусики, что у тебя есть", "make_rahi_wear_portal_panties")
		
		addButton("Назад", "Назад на меню", "")
	
	if(state == "take_portal_panties_back"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={underwear=true}})
		
		saynn("Пожалуй, Рахи лучше больше не носить те трусики.")
		
		saynn("[say=pc]Насчет тех трусиков, что на тебе сейчас..[/say]")
		
		saynn("[say=rahi]Ты хочешь их вернуть, {rahiMaster}?[/say]")
		
		saynn("Ты киваешь. Рахи быстро стягивает их и протягивает тебе.")
		
		saynn("[say=rahi]Вот.. Они забавные..[/say]")
		
		saynn("Сказав это, она густо краснеет. Ну и кошечка.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "relationship")
	
	if(state == "make_rahi_wear_portal_panties"):
		playAnimation(StageScene.Duo, "stand", {npc="rahi", npcBodyState={underwear=true}})
		
		saynn("Ты показываешь Рахи те шикарные трусики, что у тебя есть.")
		
		saynn("[say=rahi]Сердечко такое милое.. Где ты их взял, {rahiMaster}?[/say]")
		
		saynn("Ты улыбаешься и предлагаешь их кошечке. Возможно, лучше ничего ей не говорить. Но ты обязательно переводишь портальные трусики в режим «разблокировано». Не хочется, чтобы твоя кошечка запаниковала, когда поймет, что не может их снять.")
		
		saynn("[say=pc]Это тебе подарок, наслаждайся.[/say]")
		
		saynn("Рахи опускает взгляд.")
		
		saynn("[say=rahi]Ты уверен?..[/say]")
		
		saynn("Ты киваешь, заставляя кошечку покраснеть. Она осторожно берет их.")
		
		saynn("[say=pc]Хочу посмотреть, как они будут на тебе смотреться.[/say]")
		
		saynn("[say=rahi]Да, {rahiMaster}, конечно..")
		
		saynn("Рахи быстро скидывает униформу и натягивает фиолетовые трусики.")
		
		saynn("[say=rahi]Немного прохладно.. это что.. металл?[/say]")
		
		saynn("[say=pc]Не парься об этом, киса.[/say]")
		
		saynn("Рахи мурлычет и кивает.")
		
		saynn("[say=rahi]Спасибо.. Они милые..[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "relationship")
	
	if(state == "train_new_skill"):
		saynn("Какой навык ты хочешь начать обучать Рахи?")
		
		saynn("(Если не хочешь, чтобы Рахи освоила определенный навык, можно его не учить — сюжет все равно будет двигаться дальше)")
		
		var rahiModule = getModule("RahiModule")
		var skills = rahiModule.getSkillsInfo()
		for skillID in skills:
			var skillInfo = skills[skillID]
			
			if(rahiModule.isSkillLearned(skillID)):
				continue
			
			if(skillInfo.has("requiredContent")):
				var hasBadContent = false
				for thecontent in skillInfo["requiredContent"]:
					if(!OPTIONS.isContentEnabled(thecontent)):
						hasBadContent = true
				if(hasBadContent):
					continue
			
			sayn("- [b]"+skillInfo["name"]+"[/b]: "+skillInfo["desc"])
			addButton(skillInfo["name"], skillInfo["desc"], "do_teach_new_skill", [skillID])
		
		addButton("Назад", "Проехали", "relationship")
	
	if(state == "change_title"):
		saynn("Как кошечка должна тебя называть?")
		
		saynn("(Новые варианты будут открываться по мере развития ваших отношений)")
		var titles = [
			GM.pc.getName(), "Master", "Mistress",
		]
		var currentRank = getModule("RahiModule").getSlaveryStage()
		if(currentRank >= 2):
			titles.append_array(["Miss", "Mister", "Owner", "Trainer"])
		if(currentRank >= 3):
			titles.append_array(["Lady", "Goddess", "Lord", "Sir"])
		if(currentRank >= 4):
			titles.append_array(["Queen", "Ma’am", "King", "Prince"])
		if(currentRank >= 5):
			titles.append_array(["Mommy", "Madam", "Daddy", "Alpha"])
		if(currentRank >= 6):
			titles.append_array(["Handler", "Your Highness", "Boss", "Kitty's Keeper"])
		if(currentRank >= 7):
			titles.append_array(["Rahi's Handler", "Love"])
		if(currentRank >= 8):
			titles.append_array(["my love", "my Lord", "my Queen", "my Miss", "Bitch"])
		
		for title in titles:
			addButton("'"+title+"'", "Пусть называет тебя так", "set_title", [title])
		addButton("Проехали", "Ты не хочешь ничего менять", "relationship")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "talk_anything"):
		runScene("rahiSlaveryTalkAnythingScene")
		return
		
	if(_action == "talk_task"):
		runScene("rahiTaskCommentingScene")
		setFlag("RahiModule.rahiCommentedOnTask", true)
		setState("")
		return
	
	if(_action == "set_title"):
		if(_args[0] == GM.pc.getName()):
			GM.main.clearFlag("RahiModule.rahiPCName")
		else:
			setFlag("RahiModule.rahiPCName", _args[0])
		setState("")
		return
	
	if(_action == "doreward"):
		var needsReward = getFlag("RahiModule.rahiNeedsReward", false)
		
		if(needsReward):
			increaseFlag("RahiModule.rahiAffection", 4)
			increaseFlag("RahiModule.rahiObedience", 1)
		else:
			increaseFlag("RahiModule.rahiObedience", -2)
			increaseFlag("RahiModule.rahiAffection", 2)
		increaseFlag("RahiModule.rahiTired", 1)
		
		runScene(_args[0], [needsReward])
		setState("")
		setFlag("RahiModule.rahiNeedsReward", false)
		return

	if(_action == "dopunish"):
		var needsPunishment = getFlag("RahiModule.rahiNeedsPunishment", false)
		
		if(needsPunishment):
			increaseFlag("RahiModule.rahiObedience", 4)
			increaseFlag("RahiModule.rahiAffection", 1)
		else:
			increaseFlag("RahiModule.rahiAffection", -2)
			increaseFlag("RahiModule.rahiObedience", 2)
		increaseFlag("RahiModule.rahiTired", 1)
		
		runScene(_args[0], [needsPunishment])
		setState("")
		setFlag("RahiModule.rahiNeedsPunishment", false)
		return

	if(_action == "doactivity"):
		increaseFlag("RahiModule.rahiTired", 1)
		
		runScene(_args[0], ["slavery"])
		setState("")
		return

	if(_action == "do_teach_new_skill"):
		increaseFlag("RahiModule.rahiTired", 1)
		setState("")
		
		getModule("RahiModule").learnSkill(_args[0])
		runScene("rahiSlaverySkillLearnScene", [_args[0]])
		return
		
	if(_action == "toggle_sleep"):
		setFlag("RahiModule.rahiShouldSleepWithPlayer", !getFlag("RahiModule.rahiShouldSleepWithPlayer", false))
		return
		
	if(_action == "toggle_morningsex"):
		setFlag("RahiModule.rahiShouldSexPlayerDuringSleep", !getFlag("RahiModule.rahiShouldSexPlayerDuringSleep", false))
		return
		
	if(_action == "make_rahi_wear_portal_panties"):
		GM.pc.getInventory().removeXOfOrDestroy("PortalPanties", 1)
		setFlag("RahiModule.wearingPortalPanties", true)
		getCharacter("rahi").resetEquipment()
		
	if(_action == "take_portal_panties_back"):
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("PortalPanties"))
		setFlag("RahiModule.wearingPortalPanties", false)
		getCharacter("rahi").getInventory().removeItemFromSlot(InventorySlot.UnderwearBottom)

	if(_action == "feedmenu"):
		runScene("FeedSomethingScene", ["rahi"])
		return

	setState(_action)

func getDebugActions():
	return [
		{
			"id": "raiseObedience",
			"name": "Повысить послушание",
			"args": [
			],
		},
		{
			"id": "raiseAffection",
			"name": "Повысить привязанность",
			"args": [
			],
		},
		{
			"id": "setStage",
			"name": "Установить стадию рабства",
			"args": [
				{
					"id": "stage",
					"name": "Стадия",
					"type": "number",
					"value": 8,
				},
			]
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "raiseObedience"):
		increaseFlag("RahiModule.rahiObedience", 10)
	if(_id == "raiseAffection"):
		increaseFlag("RahiModule.rahiAffection", 10)
	if(_id == "setStage"):
		setFlag("RahiModule.rahiSlaveryStage", _args["stage"])
