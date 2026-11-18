extends RecruitSceneBase

var straponUsed = false
var vagVariant = false

func _init():
	sceneID = "FerriRecSceneOralSadism"

func _reactInit():
	putOn("ferri", "inmatewristcuffs")
	putOn("ferri", "basketmuzzle")

func _run():
	if(state == ""):
		addCharacter("ferri", ["naked"])
		aimCameraAndSetLocName("hideout_breakroom")
		straponUsed = (extra("strapon", "") != "") && (extra("variant", "") == "strapon")
		vagVariant = (extra("variant", "") == "vaginal")
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcBodyState={naked=true}})
		saynn("Вы просите команду дать вам кольцо-кляп... и Кайт протягивает его вам!")

		saynn("И вот ты входишь в камеру. Ферри всё еще здесь: голая, в наручниках, с намордником и на поводке, привязанном к трубе.")

		saynn("Её голубые глаза впиваются в тебя в ту же секунду, как ты переступаешь порог.")

		saynn("[say=ferri]Наконец-то. Ну ты и тянешь, вредина... Развяжи меня уже![/say]")

		saynn("Ты поднимаешь кольцевой кляп. Её зрачки сужаются.")

		saynn("[say=ferri]Мяу?! Да ни за что! Я не собираюсь совать эту хрень в рот![/say]")

		saynn("[say=pc]"+str(ch1("You don't get to say no.", "Shut up and open wide, slut.", "You're mine to use and abuse. Accept it."))+"[/say]")

		saynn("[say=ferri]Я тебе все пальцы откушу![/say]")

		saynn("С нынешним намордником ей это вряд ли удастся — металлическая корзина сдерживает клыки. Но намордник всё равно придется чем-то заменить.")

		saynn("Итак, ты хватаешь Ферри за рога. Она вскрикивает, и по её спине пробегает дрожь, когда ты крепко их сжимаешь.")

		saynn("[say=ferri]М-мяу... не надо... не трогай их...[/say]")

		saynn("Так. Похоже, нужно просто трогать их сильнее.")

		saynn("[say=pc]"+str(ch1("Then behave.", "Too late, bitch.", "You're so sensitive. Pathetic."))+"[/say]")

		saynn("Пока Ферри извивается от того, что ты трешь её рога, ты снимаешь с неё намордник и запихиваешь кольцо-кляп ей в рот. Она тут же пытается выплюнуть его, но ты туго затягиваешь ремешок на затылке.")

		saynn("[say=ferri]Я.. не.. х-хороша.. хфф..[/say]")

		saynn("Это всё, что она успевает промямлить, прежде чем ты окончательно затыкаешь ей рот.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_start")
	if(state == "pp_start"):
		playAnimation(StageScene.SexOralForced, "tease", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Её челюсть теперь зафиксирована в открытом положении, а в уголках губ уже начинает скапливаться слюна.")

		saynn("[say=pc]"+str(ch1("There we go. That's better.", "Look at you. Mouth stretched open like a good little cocksleeve.", "Perfect. Now you can't bite. Not that your teeth would do much."))+"[/say]")

		saynn("Она пытается сомкнуть челюсти, но не может; её голубые глаза сверкают от чистой ненависти.")

		saynn("Ты хватаешь её за поводок и резко тянешь на себя, заставляя её упасть на колени. Затем ты на секунду отстегиваешь её наручники, чтобы схватить её за руки и завести их высоко над головой.")

		saynn("[say=ferri]Мммнх..[/say]")

		if (straponUsed):
			saynn("Вы также быстро закрепляете на талии ремни для страпона, и его наконечник зависает прямо перед её пастью.")

			addButton("Продолжить", "Смотреть, что будет дальше", "pp_fuck")
		elif (!vagVariant):
			saynn("Ваш {pc.penis} уже наготове и тверд, он замер у самого входа в её пасть.")

			addButton("Продолжить", "Смотреть, что будет дальше", "pp_fuck")
		else:
			saynn("Ваша {pc.vaginaStretch} киска уже выставлена напоказ, дразня её пасть.")

			addButton("Продолжить", "Смотреть, что будет дальше", "vag_fuck")
	if(state == "pp_fuck"):
		playAnimation(StageScene.SexOralForced, "suck", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Вы прицеливаетесь получше. Она неистово трясет головой, её хвост бешено молотит по сторонам. Эта сучка явно хочет пожестче. Окей.")

		saynn("Правой рукой вы удерживаете её лапы, а левой налетаете на её голову, хватаете за волосы и тянете на себя, заставляя её взвизгнуть и перестать отворачиваться.")

		saynn("И вот тогда вы направляете свой "+str("cock" if !straponUsed else "rubber toy")+" к стальному кольцу и толкаете!")

		saynn("[say=ferri]Мммф-..[/say]")

		saynn("Твоя "+str("shaft" if !straponUsed else "strapon")+" соскальзывает с её губ, проходит по кошачьему языку и тут же достигает задней стенки горла. Она мгновенно давится, а на глазах выступают слёзы.")

		saynn("[say=pc]"+str(ch1("Breathe through your nose. You'll need it.", "That's it. Take it. Take it all, slut.", "Choke on it, bitch."))+"[/say]")

		saynn("Она всё ещё пытается закусить тебя, сжимая челюсти, но всё, что ей удаётся — это давиться слюной и пускать слюни.")

		saynn("Ты проталкиваешь свой "+str("dick" if !straponUsed else "rubber cock")+" ещё глубже. Горло Ферри сжимается вокруг кончика твоего "+str("member" if !straponUsed else "shiny member")+". Она издаёт влажный, сдавленный звук... и всё её тело напрягается. Её когти пытаются впиться в твою руку, но ты крепко держишь её за запястья.")

		saynn("[say=ferri]Глрк!.. мммм!..[/say]")

		saynn("Ты начинаешь двигать бёдрами, поначалу медленно. Ты оттягиваешься назад, пока лишь кончик не замирает на её языке... а затем снова толкаешь вперёд. С каждым толчком ты вбиваешь свой член всё глубже... пока её нос не упирается тебе в пах, а дыхание не перехватывает. Её глаза широко распахнуты, а по синему меху текут слёзы.")

		saynn("[say=pc]"+str(ch1("You can take more. I know you can.", "Shut up and take it.", "Pathetic little whore."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_fast")
	if(state == "pp_fast"):
		playAnimation(StageScene.SexOralForced, "suckfast", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты ускоряешься, работая всё жёстче и грубее. Твои бёдра с силой впечатываются в её лицо, её узкое горло обхватывает тебя по всей длине, а слюна продолжает стекать по подбородку, на грудь и в ложбинку между её сиськами.")

		saynn("Когда ты входишь до упора, ей становится трудно дышать. Её грудь вздымается, пока она пытается судорожно втягивать воздух носом между толчками. Но ты не останавливаешься.")

		saynn("[say=ferri]Мммф!.. хррк!.. нннгх!..[/say]")

		saynn("[say=pc]"+str(ch1("Running out of air, huh?", "You don't need air. You just need my cock.", "Breathe? No. You don't get to breathe. Not until I'm done."))+"[/say]")

		saynn("Ты выходишь почти полностью, заставляя её судорожно и жадно глотнуть воздуха... а затем с силой входишь обратно, до самого основания. Её нос снова плотно прижимается к твоей коже.")

		saynn("Её бьёт сильный рвотный рефлекс, тело содрогается, а хвост начинает хлестать по полу.")

		saynn("[say=ferri]Хрррк..[/say]")

		saynn("Свободной рукой ты хватаешь её за один из рогов, используя его как опору. Глаза Ферри на мгновение закатываются, а бёдра начинают подёргиваться.")

		saynn("После этого ты начинаешь трахать ей лицо ещё интенсивнее, заставляя её кивать головой вперёд-назад при каждом твоём толчке. По щекам текут слёзы, а из горла доносятся горячие влажные звуки... позывы, удушье, стоны.")

		saynn("Она снова пытается укусить, мышцы челюсти напрягаются от попытки сжать зубы... но кляп справляется со своей задачей. Её зубы лишь клацают по стали.")

		if (straponUsed):
			saynn("Ты чувствуешь, как нарастает давление. Яички сжимаются.")

			saynn("[say=pc]"+str(ch1("I'm close. You're going to swallow every drop.", "I'm going to cum down your throat. Don't you dare waste a single drop.", "Open wider. I'm going to fill that throat. Maybe you'll drown. Wouldn't that be a shame."))+"[/say]")

		else:
			saynn("Ты используешь не настоящий член... но всё равно чувствуешь непреодолимое желание войти в неё по-настоящему глубоко...")

			saynn("[say=pc]"+str(ch1("Get ready, cutie.", "Get ready, slut.", "Open wider, you stupid slut."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_cum")
	if(state == "pp_cum"):
		playAnimation(StageScene.SexOralForced, "suckinside", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if (!straponUsed):
			saynn("Последний мощный толчок. Ты заходишь так глубоко, как только можешь, и твой член пульсирует.")

			saynn("[say=ferri]Мммпф-![/say]")

			saynn("Ты кряхтишь, когда её сжимающиеся стенки доводят тебя до края. Твой член пульсирует, когда ты изливаешься ей в глотку, выкачивая свой {pc.cum} ей в живот. Она одновременно давится и задыхается, не в силах глотнуть воздуха, пока ты занят её глубоким минетoм. Часть семени вылетает через её ноздри, из-за чего эта дракат выглядит по-настоящему жалко.")

			saynn("[say=pc]"+str(ch1("Cute. You love cum, huh?", "Cum whore.", "What a cum whore."))+"[/say]")

			saynn("Ты удерживаешь её на своём члене долгое время. По её щекам всё сильнее текут слёзы, а её голубые глаза слабеют с каждой секундой.")

			saynn("Пусть она и страдает... для тебя это чертовски приятно. Твои яйца опустошаются этой сучкой до капли.")

		else:
			saynn("Последний мощный толчок. Ты входишь так глубоко, как только можешь, вбивая в неё эту резиновую игрушку!")

			saynn("[say=ferri]Мммпф-![/say]")

			saynn("Ты с огромным интересом наблюдаешь, как она одновременно давится и задыхается, не в силах глотнуть воздуха. Часть её собственной слюны вылетает через ноздри, из-за чего эта дракат выглядит по-настоящему жалко.")

			saynn("[say=pc]"+str(ch1("Cute.", "Whore.", "What a whore."))+"[/say]")

			saynn("Ты удерживаешь её на своём блестящем стволе долгое время. По её щекам всё сильнее текут слёзы, а её голубые глаза слабеют с каждой секундой.")

			saynn("Пусть она и страдает... для тебя это развлечение.")

		saynn("Впрочем, пожалуй, на сегодня достаточно.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_pullout")
	if(state == "pp_pullout"):
		playAnimation(StageScene.GivingBirth, "idle", {pc="ferri", bodyState={naked=true, hard=true}})
		saynn("Когда ты наконец выходишь, Ферри валится с ног. Она начинает громко кашлять."+str(", spitting some of your seed out, as much as she can" if !straponUsed else " while you take off your strapon harness and put it away")+".")

		saynn("[say=ferri]Гхк.. б-блядь.. гхк..[/say]")

		saynn("Ты берешь корзинный намордник и заменяешь им кольцо-кляп. Ее клыки цокают о металл, но она не пытается тебя укусить... она слишком занята попытками восстановить дыхание.")

		if (!straponUsed):
			saynn("[say=pc]"+str(ch1("You did well. I'm proud of you.", "Look at you. Drooling cum like the worthless bitch you are.", "Pathetic. Absolutely pathetic."))+"[/say]")

		else:
			saynn("[say=pc]"+str(ch1("You did well. I'm proud of you.", "Look at you. Drooling like the worthless bitch you are.", "Pathetic. Absolutely pathetic."))+"[/say]")

		saynn("Ее хвост обернулся вокруг тела, грудь часто вздымается.")

		saynn("[say=ferri]Угх.. м-мудак..[/say]")

		saynn("Ее голос звучит очень слабо и хрипло.")

		saynn("[say=pc]"+str(ch1("Good girl. Rest now.", "That's what you get for being a brat.", "You're lucky I didn't go longer."))+"[/say]")

		saynn("Ты выходишь из камеры, чтобы посмотреть, что думает Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "vag_fuck"):
		playAnimation(StageScene.SexOralForced, "lick", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Одной рукой ты хватаешь ее за волосы, а другой прижимаешь ее выгнутые запястья над головой. Она пытается отвернуться, но ты рывком поворачиваешь ее лицо к себе.")

		saynn("[say=ferri]Мммф-![/say]")

		saynn("Ты прижимаешься щелью прямо к ее губам; ее язык зажат внутри кольца, и ему некуда деться, кроме как давить на твою плоть.")

		saynn("[say=pc]"+str(ch1("Taste me.", "That's it. Lick, slut. Use that tongue.", "You wanted to bite? Too bad. Now you just get to serve."))+"[/say]")

		saynn("Ты втираешься киской в ее лицо, размазывая свою влагу по ее губам, подбородку и щекам. Приглушенные протесты Ферри отдаются вибрацией в твоем клиторе.")

		saynn("[say=ferri]Мнгх.. хррк..[/say]")

		saynn("Поскольку твоя щель плотно прижата к ее лицу, ей едва хватает воздуха, чтобы дышать. Весело.")

		saynn("[say=pc]"+str(ch1("Just keep licking, girl.", "That's it. Suffer for me.", "Such a good little face to grind."))+"[/say]")

		saynn("Ты продолжаешь вжиматься бедрами, втирая щель своей киски в её язык, смешивая её слюну со своими соками. Она пытается отстраниться, но ты удерживаешь её на месте, заставляя её нос вжиматься в твою промежность. Её глаза широко распахнуты, а уши поникли.")

		saynn("[say=pc]"+str(ch1("Running out of air already? Pathetic.", "You don't need air. You just need my pussy.", "Breathe? No. You don't get to breathe. Not until I'm done."))+"[/say]")

		saynn("Ты на мгновение отстраняешься... ровно настолько, чтобы она могла судорожно, рвано глотнуть воздуха. Слюна и твои соки тянутся тонкими нитями между её лицом и твоей киской.")

		saynn("Затем ты снова резко подаешься вперед, втираясь ещё сильнее. Её нос плотно прижимается к твоему лобку. Её приглушённые звуки отдаются вибрацией во всём твоём теле. Она снова пытается укусить, но не может — кольцо слишком жёсткое.")

		addButton("Продолжить", "Смотреть, что будет дальше", "vag_fast")
	if(state == "vag_fast"):
		playAnimation(StageScene.SexOralForced, "lickfast", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты ускоряешься, двигаясь всё сильнее и грубее. Твои бёдра совершают неистовые круговые движения по её лицу, раз за разом проходя клитором по её губам и языку. Это настолько приятно, что ты начинаешь стонать...")

		saynn("Ферри задыхается, пытаясь поймать хоть немного воздуха между твоими толчками.")

		saynn("[say=pc]"+str(ch1("You're drooling all over yourself. Cute.", "Messy little thing. I'm going to ruin that face.", "Scream for me. I want to feel it."))+"[/say]")

		saynn("Свободной рукой ты хватаешь её за один из рогов, используя его как опору, чтобы втираться ещё яростнее. Глаза Ферри на секунду закатываются, а её бёдра непроизвольно дёргаются.")

		saynn("Её сопротивление слабеет, а приглушённые протесты превращаются в мокрые, жалкие всхлипы. Слёзы текут по её щекам, смешиваясь со слюной и соками твоей киски.")

		saynn("Ты чувствуешь, как нарастает давление... жар разливается по всему телу...")

		saynn("[say=pc]"+str(ch1("I'm close. You're going to swallow everything I give you.", "I'm going to cum all over that stupid face.", "Open wider. I'm going to flood your mouth. Maybe you'll drown. Wouldn't that be a shame."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "vag_cum")
	if(state == "vag_cum"):
		playAnimation(StageScene.SexOralForced, "lick", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Последний мощный толчок. Ты плотно прижимаешься своей киской к её губам и позволяешь этому случиться...")

		saynn("Всё твоё тело дрожит, когда оргазм прошибает тебя насквозь... волны удовольствия накрывают тебя, заставляя запрокинуть голову и издать стон. Твоя киска пульсирует и извергается, заливая прямо в открытый рот этой дряни, покрывая её язык и стекая по горлу.")

		saynn("[say=ferri]Ммммф-![/say]")

		saynn("Она давится и задыхается, когда твои соки наполняют её рот быстрее, чем она успевает глотать. Часть жидкости разлетается мимо кольца, брызгая на подбородок и грудь. Её нос глубоко зарыт в твои влажные складки, перекрывая доступ к воздуху.")

		saynn("[say=pc]"+str(ch1("Cute.", "Cum slut.", "What a messy little whore."))+"[/say]")

		saynn("Ты удерживаешь её так, мягко вжимаясь в неё во время послевкусие оргазма, следя за тем, чтобы каждая последняя капля размазалась по её лицу. По её щекам текут слёзы, как и по твоим, а её голубые глаза слабеют с каждой секундой.")

		saynn("Впрочем, пожалуй, на сегодня достаточно.")

		addButton("Продолжить", "Смотреть, что будет дальше", "vag_pullout")
	if(state == "vag_pullout"):
		playAnimation(StageScene.GivingBirth, "idle", {pc="ferri", bodyState={naked=true, hard=true}})
		saynn("Когда ты наконец отстраняешься, Ферри буквально валится с ног. Она начинает громко кашлять, выплевывая столько твоих соков, сколько может, вперемешку со своей слюной.")

		saynn("[say=ferri]Гхк.. б-блядь.. гхк..[/say]")

		saynn("Ты берешь корзинный намордник и заменяешь им кольцо-кляп. Ее клыки цокают о металл, но она не пытается тебя укусить... она слишком занята попытками восстановить дыхание.")

		saynn("[say=pc]"+str(ch1("You did well. I'm proud of you.", "Look at you. Drenched in my juices like the worthless bitch you are.", "Pathetic. Absolutely pathetic."))+"[/say]")

		saynn("Ее хвост обернулся вокруг тела, грудь часто вздымается.")

		saynn("[say=ferri]Угх.. с-сучка..[/say]")

		saynn("Ее голос звучит очень слабо и хрипло.")

		saynn("[say=pc]"+str(ch1("Good girl. Rest now.", "That's what you get for being a brat.", "You're lucky I didn't go longer."))+"[/say]")

		saynn("Ты выходишь из камеры, чтобы посмотреть, что думает Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "pp_start"):
		putOff("ferri", "basketmuzzle")
		putOn("ferri", "ringgag")
		if(straponUsed):
			recWearStrapon()

	if(_action == "pp_cum"):
		if(straponUsed):
			getCharacter("ferri").cummedInMouthBy("pc", FluidSource.Strapon)
		else:
			getCharacter("ferri").cummedInMouthBy("pc", FluidSource.Penis)
		GM.pc.orgasmFrom("ferri")

	if(_action == "pp_pullout"):
		putOff("ferri", "ringgag")
		putOn("ferri", "basketmuzzle")
		recRemoveStrapons()

	if(_action == "vag_cum"):
		getCharacter("ferri").cummedInMouthBy("pc", FluidSource.Vagina)
		GM.pc.orgasmFrom("ferri")

	if(_action == "vag_pullout"):
		putOff("ferri", "ringgag")
		putOn("ferri", "basketmuzzle")

	setState(_action)

func saveData():
	var data = .saveData()

	data["straponUsed"] = straponUsed
	data["vagVariant"] = vagVariant

	return data

func loadData(data):
	.loadData(data)

	straponUsed = SAVE.loadVar(data, "straponUsed", false)
	vagVariant = SAVE.loadVar(data, "vagVariant", false)
