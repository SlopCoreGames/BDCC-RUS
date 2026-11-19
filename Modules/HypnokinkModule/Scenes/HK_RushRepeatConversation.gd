extends SceneBase

func _init():
	sceneID = "RushRepeatConversation"

func _run():
	addCharacter("rush")
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("Раш возвышается над тобой, скрестив руки на груди.")
		saynn("[say=rush]Ну и чего тебе, мелюзга? Думаешь, сможешь меня одолеть?[/say]")
		
		addButton("Любопытство", "Так за что он здесь сидит?", "backstory")
		addButton("Предложить свой", "У тебя есть доступная задница", "want_dick")
		addButton("Драться", "Держись подальше, а то будут проблемы", "fight_me")
		#addButton("DEBUG FIGHT", "Ха-ха, получил хук в челюсть!", "debug_fight")
		#addButton("DEBUG SEX", "Ха-ха, получи, лохушка!", "debug_sex")
		addButton("Уйти", "Вообще-то, ты что-то вспомнил об одном месте.", "leaving")
		
	if(state == "backstory"):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("[say=rush]Раздавил черепушку одной сучке об асфальт. Проблемы с гневом. Сама напросилась.[/say]")

		saynn("[say=pc]Ох.[/say]")

		saynn("[say=rush]В общем, из-за этого меня и закрыли. Разнес стол об голову офицера — вот тогда они и выкинули ключ.[/say]")

		saynn("Он фыркает.")

		saynn("[say=rush]Так даже лучше, чесслово. Тут полно мудаков, которым только и надо, что получить по морде, да и так я подальше от \"обычного сброда\".[/say]")

		saynn("Интересно. Он кажется куда более рассудительным, чем можно было ожидать.")

		addButton("Назад", "", "")
		
	if(state == "want_dick"):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("Ты не находишь ответа. Ты слишком занята тем, что гипнотизируешь взглядом его огромный бугорок... Кажется, у тебя даже слюнки потекли.")

		saynn("Раш прослеживает направление твоего взгляда, а затем посмеивается.")
		
		saynn("[say=rush]Ха, бывает. Че, хочешь прокатиться?[/say]")
		
		saynn("[say=pc]Э- эх... ну...")
		
		saynn("Оцепенело, вы выдавливаете кивок.")

		saynn("Раш оглядывает вас с ног до головы, оценивая. Он чешет затылок, выглядя несколько неуверенно.")

		saynn("[say=rush]Уверена? А то мне кажется, я тебя пополам сломаю.[/say]")

		addButton("Безусловно", "Внутренние травмы — это проблемы будущего «я»", "need_dick")
		addButton("Вообще-то нет", "Целые внутренние органы всё-таки важны", "nah_dick")
	if(state == "need_dick"):
		playAnimation(StageScene.SexStanding, "tease", {
			pc="rush", npc="pc",
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={exposedCrotch=true,hard=true},
		})
		
		if(GM.pc.isFullyNaked()):
			saynn("К вашему счастью, вы уже пришли голышом, включая ваше милое отверстие {pc.analStretch}.")
		else:
			saynn("Вы быстро {pc.undressMessage}, оставляя ваше милое {pc.analStretch} открытым.")
			
		saynn("[say=rush]Ладно, я в деле. Давай подготовим тебя.[/say]")
		
		saynn("Добыв откуда-то бутылочку лубриканта, Раш с силой вводит несколько смазанных пальцев в твой анус, тщательно подготавливая тебя к тому, что ждет впереди.")

		saynn("[say=rush]Прислонись к стене. Тебе понадобится опора.[/say]")
		
		saynn("Дельное предложение. Ты прислоняешься к стене, пользуясь случаем, чтобы широко раздвинуть ноги. Раш заходит тебе со спины, хлопая своим {rush.cockDesc} "+RNG.pick(["cock", "dick", "member"])+" по твоей спине. Ледяное чувство трепета пробегает по позвоночнику, когда ты чувствуешь, как его расширяющийся кончик упирается между твоих лопаток. Раш проталкивает пальцы еще глубже, методично смазывая твой проход.")
		
		saynn("[say=pc]Ммм...[/say]")
		
		saynn("Удивительно, но он не торопится, следя за тем, чтобы ты была хорошо растянута и готова. К тому времени, как он наконец убеждается, что ты растянута настолько, насколько это возможно таким способом, ты ловишь себя на том, что почти умоляешь его поскорее закончить.")
		
		saynn("[say=rush]Пора переходить к главному. Готова, малявка?[/say]")
		
		saynn("Продолжая свой неожиданно осторожный подход, он приставляет свой {rush.cockDesc} "+RNG.pick(["cock", "dick", "member"])+" к отверстию твоего жаждущего заднего прохода, и его расширяющаяся головка упирается в твой {pc.analStretch} вход. Затем, медленно, но уверенно, он начинает давить на него.")

		addButton("Принимай", "Это будет непросто", "get_fucked_check")
			
	if(state == "get_fucked_pass"):
		playAnimation(StageScene.SexStanding, "sex", {
			pc="rush", npc="pc",
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={exposedCrotch=true,hard=true},
		})
		saynn("Рашу требуется несколько попыток, прежде чем ему удается втиснуть свой {rush.cockDesc}"+RNG.pick(["cock", "dick", "member"])+" в тебя. Когда он наконец входит, ощущение такое, будто тебя пронзает настоящее дерево.")

		saynn("[say=pc]Твою ж... блядь, окей, окей, он внутри![/say]")
		
		saynn("[say=rush]Ну что, мелочь! Должен сказать, не думал, что влезет![/say]")
		
		saynn("Он дает тебе несколько мгновений, чтобы привыкнуть к этому чувству, а затем начинает медленно двигаться вперед-назад. Ощущения просто невероятные во всех смыслах, и от каждого толчка тебя подбрасывает на цыпочках.")
		
		saynn("[say=rush]Эй, ты там как, в норме?[/say]")
		
		saynn("[say=pc]Нннх, да, всё хорошо! П-продолжай![/say]")
		
		saynn("Раш фыркает и ускоряется, теперь вгоняя свой {rush.cockDesc} всё глубже и глубже, словно поршень."+RNG.pick(["cock", "dick", "member"])+" продолжает тереться внутри тебя, к счастью, достаточно смазанный.")
		
		addButton("Глубже", "", "get_fucked_2")
	if(state == "get_fucked_2"):
		playAnimation(StageScene.SexStanding, "fast", {
			pc="rush", npc="pc",
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={exposedCrotch=true,hard=true},
		})
		saynn("Неумолимый Раш продолжает долбить твою задницу. Твое удовольствие нарастает, пока он набирает всё больше и больше скорости, вбиваясь всё глубже с каждым толчком своего {rush.cockDesc}"+RNG.pick(["cock", "dick", "member"])+" Твои ноги начинают неконтролируемо дрожать так сильно, что ты не уверена, смогла бы устоять на ногах, если бы не член внутри тебя, служащий опорой.")
		
		saynn("[say=rush]Ты принимаешь это просто охеренно, малявка. Скоро всё закончится, слышишь?[/say]")
		
		saynn("[say=pc]Д-да, я уж п-почти...[/say]")
		
		saynn("Ты стремительно приближаешься к оргазму, неумолимое наслаждение пронзает всё тело, превращая твои мысли в блаженную кашу. Раш вгоняет свой "+RNG.pick(["cock", "dick", "member"])+" до самого конца, на всю глубину. С каждым толчком он приподнимает всё твоё тело над землей одним лишь своим членом.")
		
		addButton("Кончай!", "Пусть всё идет своим чередом", "get_fucked_orgasm")
		
	if(state == "get_fucked_orgasm"):
		playAnimation(StageScene.SexStanding, "inside", {
			pc="rush", npc="pc",
			pcCum=true, npcCum=true,
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={exposedCrotch=true,hard=true},
		})
		
		if(GM.pc.isWearingChastityCage()):
			saynn("Твой {pc.cock} слабо пульсирует внутри клетки целомудрия и пускает струйки {pc.cum} на стену, к которой ты прислонилась!")
		elif(GM.pc.hasPenis()):
			saynn("Твой {pc.cock} пульсирует и разбрызгивает {pc.cum} по всей стене, к которой ты прислонилась!")
		if(GM.pc.hasVagina()):
			saynn("Твоя заброшенная киска брызжет соками прямо на стену и стекает по твоим бедрам!")
		
		saynn("Когда твоё кольцо сжимается и пульсирует вокруг его "+RNG.pick(["cock", "dick", "member"])+", он стонет и, наконец, тоже кончает, впечатывая тебя в стену и в твою собственную смазку, наполняя тебя до самых краев! Ты чувствуешь, как твои внутренности растягиваются и расширяются, чтобы вместить всё это, и в глубине души гадаешь, не выплеснется ли всё это в итоге у тебя изо рта. Даже когда он кончает, твой собственный оргазм всё еще продолжается; ты дрожишь и извиваешься, беспомощно насаженная и прижатая к стене.")
		
		saynn("После нескольких моментов затаившего дыхание отдыха Раш отстраняется, позволяя тебе встать на свои дрожащие ноги.")
		
		saynn("[say=pc]Э-это было...[/say]")
		
		saynn("[say=rush]Ха! Это было круто! Готова к еще одному раунду, малявка?[/say]")
		
		saynn("Ты слишком вымотана, чтобы похоть взяла верх, поэтому ты лишь скулишь и качаешь головой.")
		
		addButton("Одеться", "Завтра утром ты это почувствуешь", "get_fucked_after")
		
	if(state == "get_fucked_after"):
		saynn("[say=rush]Справедливо. Тогда позже?[/say]")
		
		saynn("[say=pc]М-может быть, да, звучит...[/say]")
		
		saynn("Где-то на задворках сознания наконец пробивается мысль, напоминающая тебе о том, зачем ты здесь вообще оказался.")
		
		saynn("[say=pc]П-погоди, стой. А как же Вион?[/say]")
		
		saynn("[say=rush]А, точно. Слушай сюда: чисто ради тебя, я на время отстану от этого очкарика.[/say]")
		
		saynn("Ты решаешь уйти на коне и отправиться докладывать о хороших новостях.")
		
		addButton("Уф", "", "endthescene")
		
	if(state == "get_fucked_fail"):
		saynn("Раш делает несколько попыток впихнуть свой {rush.cockDesc} "+RNG.pick(["cock", "dick", "member"])+" в тебя, но он никак не хочет лезть. Вскоре на смену удовольствию приходит раздражение.")

		saynn("[say=rush]Похоже, ты только языком чесать горазд, малявка. Без того, чтобы разорвать тебя пополам, его не впихнуть.[/say]")
		
		addButton("Что?", "С каких это пор это кого-то останавливало?", "get_fucked_fail_2")
		addButton("Всё равно сделать это", "Это будет больно", "get_fucked_pass")
		
	if(state == "get_fucked_fail_2"):
		saynn("[say=pc]Что... но я...[/say]")
		
		saynn("[say=rush]Не, хватит с тебя. На сегодня закончили.[/say]")
		
		saynn("Он отступает назад и начинает вытирать лубрикант со своего "+RNG.pick(["cock", "dick", "member"])+". Ты вроде как должен радоваться, что он решил остановиться, прежде чем причинить тебе вред, но не можешь отделаться от чувства, будто провалил какой-то тест.")
		
		saynn("К тому же, тебя всё ещё чертовски штырит. Блядь.")

		addButton("Уйти", "", "endthescene")
	if(state == "nah_dick"):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("Ты приходишь в себя и трясешь головой. Раш похлопывает по своему огромному, массивному бугру. Ты завороженно наблюдаешь за тем, как он подпрыгивает, и лишь спустя время удается отвести взгляд.")

		saynn("[say=rush]Ага, в самый раз. Не каждая кокслив сможет сдюжить [i]такого[/i] красавчика.[/say]")

		addButton("Назад", "", "")
	if(state == "fight_me"):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("Он громко хохочет.")

		saynn("[say=rush]Ха! Ха-ха, ну и умора! А ты забавный, малявка![/say]")

		saynn("Ты не отступаешь.")

		saynn("[say=pc]Я не шучу. Я тебя сделаю.[/say]")

		saynn("[say=rush]Ладно, ладно. Давай так: если продержишься против меня шесть раундов, я на время оставлю твоего очкарика в покое. Идет?[/say]")

		addButton("Идет", "Будет больно", "deal")
		addButton("Не идет", "Ты не особо веришь в свои шансы.", "no_deal")
	if(state == "deal"):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("Его спесь улетучивается. Он напрягает мускулы и встает в классическую боксерскую стойку.")

		saynn("[say=rush]Ладно, но потом не говори, что я тебя не предупреждал. Ну, показывай руки![/say]")

		saynn("Ты пытаешься подготовиться к тому, что утром наверняка будет больно. Если повезет.")

		addButton("Руки вверх", "Все равно ты не всеми ребрами пользовался", "put_em_up")
	if(state == "no_deal"):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("Он хлопает тебя по спине, отчего ты спотыкаешься и влетаешь в стену.")

		saynn("[say=rush]Да, всё верно. Красава. Сломанные кости — удовольствие так себе, никому не нужно.[/say]")
		
		addButton("Назад", "", "")
	if(state == "if_won"):
		playAnimation(StageScene.Duo, "stand", {npc="rush", npcAction="defeat"})
		saynn("Раш спотыкается и падает на одно колено.")
		
		saynn("[say=rush]Ух! Ну и пинок у тебя, малявка.[/say]")

		saynn("Затем он снова поднимается на ноги, побитый, но непоколебимый.")
		
		saynn("[say=rush]Хорошо ты меня приложил. Сделка есть сделка. Передай этому очкарику, что он в расчете. Пока мне снова не понадобятся кредиты.[/say]")
		
		addButton("Готово", "Сойдет и так", "leave_victorious")
		if(getFlag("HypnokinkModule.RushDealStruckAtLeastOnce")):
			saynn("Вас посещает мысль: если вырубить Раша, можно найти более радикальное решение проблемы.")
			if(GM.pc.getInventory().hasItemID("inmatewristcuffs") and GM.pc.getInventory().hasItemID("inmateanklecuffs")):
				addButton("Решение", "Продолжать бой", "put_em_up_again")
			else:
				addDisabledButton("Решение", "Продолжать бой\n\nДля этого тебе понадобится набор наручников для рук и ног")
		
	if(state == "if_lost"):
		playAnimation(StageScene.Duo, "defeat", {npc="rush"})
		saynn("Нанося последний мощный удар ногой, Раш швыряет вас на пол.")
		
		saynn("[say=rush]Ха! Вот так![/say]")
		
		saynn("Раш надвигается на вас, лежащую на полу. Вы сворачиваетесь калачиком, предвкушая крайне неприятные ближайшие минуты...")
		
		saynn("Вместо этого он рывком поднимает вас на ноги.")
		
		saynn("[say=rush]Неплохо, малявка! Хочешь как-нибудь еще так закуситься?[/say]")
		
		saynn("Он смахивает пыль с твоих плеч, заставляя тебя поморщиться от того, как его грубые ладони скользят по твоим синякам.")
		
		saynn("[say=rush]Знаешь, где меня искать. Сделка всё еще в силе![/say]")
		
		saynn("[say=pc]Да нет... Ладно, может быть. Как-нибудь в другой раз.[/say]")
		
		saynn("Ты решаешь не рисковать и поспешно уходишь, чтобы зализать раны в другом месте.")
		
		addButton("Ow", "", "endthescene")
		
	if(state == "leave_victorious"):
		saynn("Ты решаешь уйти на коне и отправиться докладывать о хороших новостях.")
		
		addButton("Уйти", "", "endthescene")
		
	if(state == "if_won_serious"):
		saynn("Раш наконец сдувается. На секунду кажется, что он вот-вот сможет подняться, но затем его руки разъезжаются, и он валится на пол, вырубаясь без задних ног. Ты не теряешь времени и защелкиваешь на нем наручники.")
		
		addButton("Тащить его", "Лучше поторопиться", "drag_rush")
		addButton("Уйти", "Хотя, пожалуй, не стоит", "endthescene")
		
	if(state == "if_lost_serious"):
		playAnimation(StageScene.Rekt, "kill", {pc="rush", npc="pc"})
		saynn("Ты отшатнулась, и не успеваешь даже поморщиться, как Раш хватает тебя за горло и впечатывает в стену. В глазах всё плывет.")
		
		saynn("[say=rush]Ты, блядь, тупая...[/say]")
		
		saynn("[b]*БАБАХ*[/b]")
		
		saynn("Он снова впечатывает тебя в стену. Сквозь пелену в глазах ты гадаешь, не хрустнул ли у тебя череп.")
		
		saynn("[say=rush]—никогда, блядь, [i]никогда[/i]—[/say]")
		
		saynn("[b]*БАБАХ*[/b]")
		
		saynn("Снова твоя голова врезается в металлическую стену позади тебя. На этот раз ты отчетливо слышишь, как что-то важно хрустнуло, и до тебя начинает доходить: ты, черт возьми, реально можешь сдохнуть.")
		
		addButton("Ох, бля", "Лучше скажи что-нибудь, пока еще можешь", "if_lost_serious_2")
	if(state == "if_lost_serious_2"):
		playAnimation(StageScene.Rekt, "end", {pc="rush", npc="pc"})
		saynn("[say=pc]По- подожди, я...[/say]")
		
		saynn("[say=rush]ЗАТКНИСЬ НАХУЙ![/say]")
		
		saynn("[b]*БАБАХ*[/b]")
		
		saynn("От этого удара у тебя перехватывает дыхание, и ты едва не откусываешь себе язык. Вместо того чтобы заговорить, ты лишь харкаешь кровью.")
		
		saynn("Раш замечает кровь на своей руке. Он отпускает её, замахиваясь для удара, который должен оборвать твою жизнь. А затем второй рукой он отправляет тебя кувыркаться по полу, пока ты не затихаешь в скольжении.")
		
		saynn("[b]*БАБАХ*[/b]")
		
		saynn("С трудом подняв взгляд, ты видишь, что там, где только что была твоя голова, на стене остался вмятый отпечаток кулака Раша.")
		
		saynn("[say=rush]Больше так не делай. Проваливай нахер отсюда.[/say]")
		
		saynn("Ты уползаешь прочь прежде, чем успеваешь окончательно выбить из Раша остатки его едва сдерживаемого самообладания.")
		
		addButton("Ow", "", "endthescene")
		
	if(state == "leaving"):
		playAnimation(StageScene.Duo, "stand", {npc="rush"})
		saynn("В его словах есть смысл. Или, может, ты просто не хочешь, чтобы твои части тела, как внешние, [i]так[/i] и внутренние, перетряхнули с ног на голову. Так или иначе, ты уходишь, пока он не натворил чего-нибудь, о чем ты пожалеешь.")
		
		saynn("[say=rush]Ладно, еще увидимся, малявка! Знаешь, где меня искать![/say]")
		
		saynn("Как ни странно, звучит так, будто это было настоящее приглашение.")
		
		addButton("Отступить", "", "endthescene")


func _react(_action: String, _args):
	if(_action == "put_em_up"):
		runScene("FightScene", ["rush"], "boxing")
		return
		
	if(_action == "put_em_up_again"):
		runScene("FightScene", ["rush", "boxing_serious"], "boxing_serious")
		return
		
	if(_action == "get_fucked_check"):
		GM.pc.addLust(50)
		var anus: Orifice = GM.pc.getBodypart(BodypartSlot.Anus).getOrifice()
		anus.setLooseness(anus.getLooseness() + 1.0)
		if(anus.getLooseness() > 3.0 and anus.getComfortableInsertion() > 25.0):
			_action = "get_fucked_pass"
		else:
			_action = "get_fucked_fail"
			
	if(_action == "get_fucked_pass"):
		var anus: Orifice = GM.pc.getBodypart(BodypartSlot.Anus).getOrifice()
		if(not (anus.getLooseness() > 3.0 and anus.getComfortableInsertion() > 25.0)):
			GM.pc.doPainfullyStretchHole(BodypartSlot.Anus, "rush")
			
	if(_action == "get_fucked_orgasm"):
		GM.pc.gotAnusFuckedBy("rush")
		GM.pc.cummedInAnusBy("rush")
		GM.pc.orgasmFrom("rush")
		GM.pc.addSkillExperience(Skill.SexSlave, 50)
		
	if(_action == "get_fucked_after"):
		setFlag("HypnokinkModule.RushDealStruckAtLeastOnce", true)
		setFlag("HypnokinkModule.OnTheHouseSessions", RNG.randi_range(1,3))
		
	if(_action == "debug_fight"):
		runScene("FightScene", ["rush"], "guardfight")
		return
		
	if(_action == "debug_sex"):
		runScene("GenericSexScene", ["pc", "rush"], "domsex")
		return
		
	if(_action == "leave_victorious"):
		setFlag("HypnokinkModule.RushDealStruckAtLeastOnce", true)
		setFlag("HypnokinkModule.OnTheHouseSessions", RNG.randi_range(1,3))
		
	if(_action == "drag_rush"):
		endScene()
		GM.pc.setLocation("cellblock_lilac_nearcell")
		aimCamera("cellblock_lilac_nearcell")
		runScene("VionSolvesRush")
		return
		
	if(_action == "if_lost_serious_2"):
		GM.pc.addEffect(StatusEffect.Wounded)
		
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)
	

func _react_scene_end(_tag, _result):
	if(_tag == "boxing"):
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("if_won")
			addExperienceToPlayer(50)
		else:
			setState("if_lost")
	if(_tag == "boxing_serious"):
		var battlestate = _result[0]
		
		if(battlestate == "win"):
			setState("if_won_serious")
			addExperienceToPlayer(50)
			setFlag("HypnokinkModule.RushDealStruckAtLeastOnce", true)
			setFlag("HypnokinkModule.OnTheHouseSessions", RNG.randi_range(1,3))
		else:
			setState("if_lost_serious")
		
