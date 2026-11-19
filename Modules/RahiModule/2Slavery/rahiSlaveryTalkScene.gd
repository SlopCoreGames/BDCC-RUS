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
				"She is sorry, {rahiMaster}.. She tried her best..",
				"She feels terrible for letting you down, {rahiMaster}..",
				"She will work harder next time..",
				"She is so sorry for failing you, {rahiMaster}..",
				"She will do anything to make it up to you, {rahiMaster}..",
				"She hopes you can forgive her, {rahiMaster}..",
				"She knows.. She messed up..",
				"Sorry, {rahiMaster}..",
				"She is willing to accept any punishment you see fit, {rahiMaster}..",
				"Please help her learn from her mistakes, {rahiMaster}..",
			])+"[/say]")
		# Just saved Rahi
		elif(currentStage <= 0):
			saynn("[say=rahi]"+RNG.pick([
				"Thank you.. for saving her..",
				"She hopes she isn't bothering you..",
				"Oh.. Hello..",
				"She is not really good at talking.. sorry..",
				"Oh.. She got lost in her thoughts for a second..",
				"U-um.. Do you wanna chat for a bit?..",
				"She is willing to do her best..",
				"Hello..",
			])+"[/say]")
		# Stole crate of toys
		elif(currentStage <= 1):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"She enjoyed our last.. heist?..",
				"Hey, {rahiMaster}.. She is trying to stay out of trouble..",
				"She appreciates your company, {rahiMaster}..",
				"She hopes you're not too disappointed with her, {rahiMaster}..",
				"That was fun.. what we did.. Wasn't it, {rahiMaster}?..",
				"Wanna chat for a bit, {rahiMaster}?.. She is not much of a talker..",
				"She is very grateful to have you around, {rahiMaster}..",
			])+"[/say]")
		# Got caught drinking
		elif(currentStage <= 2):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"She was so stupid.. Sorry, {rahiMaster}..",
				"That drinking thing.. Won't happen again, {rahiMaster}..",
				"Sorry for breaking the rules, {rahiMaster}..",
				"She will accept any punishment, {rahiMaster}.. to make things right..",
				"She will try to control herself better, {rahiMaster}.. It's just.. so hard..",
				"She feels like she is not good for anything, {rahiMaster}..",
				"Sometimes she just wants to curl up into a ball..",
				"She always lets others down..",
				"She is tired.. of being alone..",
				"Will anyone miss her if she is gonna be gone?.. Bad thoughts.. Sorry, {rahiMaster}..",
				"It feels like she is losing her mind..",
				"She is so ashamed of herself..",
				"It feels like she is drowning, {rahiMaster}..",
			])+"[/say]")
		# After wholesome scene at a waterfall
		elif(currentStage <= 3):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"She is trying hard, {rahiMaster}.. But it's difficult..",
				"She doesn't deserve someone as kind as you, {rahiMaster}..",
				"She doesn't know how to repay you, {rahiMaster}..",
				"You bring light into her dark days, {rahiMaster}..",
				"She feels.. safe.. when you are near, {rahiMaster}..",
				"You make her want to be a better kitty, {rahiMaster}..",
				"She is glad you're here, {rahiMaster}..",
				"Splashing you with water was fun, {rahiMaster}..",
				"She feels way better after what we did near that water pond, {rahiMaster}..",
			])+"[/say]")
		# After sharing her backstory
		elif(currentStage <= 4):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"You're the only one who understands her, {rahiMaster}..",
				"Sorry for burdening you with her problems, {rahiMaster}..",
				"Thank you for not rejecting her, {rahiMaster}..",
				"She feels.. hopeful?.. for the first time in a long time.. Thank you, {rahiMaster}..",
				"She thought she would never be able to share her story..",
				"She is grateful for your support.. Thank you for helping her through this..",
				"She doesn't know if she can forgive herself..",
				"Do you think old scars can heal, {rahiMaster}?.. She thinks no..",
				"You always make her happy, {rahiMaster}.. ",
				"She is gonna be honest with you, {rahiMaster}.. She wants to drink.. so much..",
				"Please don't give up on her, {rahiMaster}..",
			])+"[/say]")
		# After ending her alcohol addiction
		elif(currentStage <= 5):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"She wants to never look back at her past self..",
				"She never realized how hard it would be to quit drinking, {rahiMaster}..",
				"She feels so much better, {rahiMaster}.. Now that she is sober..",
				"Still a long way for her, right, {rahiMaster}.. But we will get there..",
				"She has to face her fears and emotions head-on now.. It's.. scary..",
				"She can't thank you enough, {rahiMaster}..",
				"She wants to make you proud, {rahiMaster}..",
				"She wishes she could be as confident as you, {rahiMaster}..",
				"You're always here when she needs support, {rahiMaster}..",
				"Things are gonna get better now, right, {rahiMaster}?..",
				"Want something, {rahiMaster}?..",
				"Is she a good or a bad kitty, {rahiMaster}?..",
			])+"[/say]")
		# After getting healed in cryo
		elif(currentStage <= 6):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"She feels like a new kitty..",
				"She is grateful for your care and attention, {rahiMaster}..",
				"She is.. kinda excited?..",
				"She feels like she can herself again.. Thank you, {rahiMaster}..",
				"She is excited to see what the future holds..",
				"She is so lucky to have you, {rahiMaster}..",
				"So strange.. to not feel that pain..",
				"She is glad she doesn't have to hide her scars anymore..",
				"Meow-meow-meow.. Oh, sorry, {rahiMaster}..",
				"Meow..",
				"She showed that doctor, didn't she?..",
				"She never wants to return to that dark place, {rahiMaster}..",
				"She never realized how much she needed you in her life, {rahiMaster}..",
				"She doesn't know where she would be without you, {rahiMaster}..",
				"She is gonna make you proud, {rahiMaster}..",
			])+"[/say]")
		# After Rahi agrees to be your slave
		elif(currentStage <= 7 && isEnslaved):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"She will do her best to serve you, {rahiMaster}.",
				"She.. I.. want to make you happy, {rahiMaster}..",
				"She will always respect and obey you, {rahiMaster}..",
				"She.. I'm.. devoted to you, {rahiMaster}..",
				"She belongs to you, {rahiMaster}..",
				"She.. I will do anything to make you happy, {rahiMaster}..",
				"She will follow your every command, {rahiMaster}..",
				"Thank you.. for making her.. me.. your slave, {rahiMaster}..",
				"She is so honored, {rahiMaster}..",
			])+"[/say]")
		# Proposed to Rahi
		elif(currentStage <= 7 && !isEnslaved):
			saynn("[say=rahi]"+RNG.pick([
				"Yes, {rahiMaster}?..",
				"She can't wait to be your.. wife.. {rahiMaster}..",
				"Thank you for making her feel so special, {rahiMaster}..",
				"You mean everything to her.. to me, {rahiMaster}..",
				"You made me the happiest kitty in the world, {rahiMaster}..",
				"You're my everything, {rahiMaster}..",
				"She loves you, {rahiMaster}..",
				"She is so greateful to have you in her life, {rahiMaster}..",
				"Dreams do come true, don't they, {rahiMaster}?..",
				"Nya~!",
				"Meow-meow-meow!",
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
			"name": "Raise Obedience",
			"args": [
			],
		},
		{
			"id": "raiseAffection",
			"name": "Raise Affection",
			"args": [
			],
		},
		{
			"id": "setStage",
			"name": "Set Slavery Stage",
			"args": [
				{
					"id": "stage",
					"name": "Stage",
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
