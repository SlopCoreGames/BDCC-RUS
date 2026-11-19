extends "res://Scenes/SceneBase.gd"

var rishaRemovedGag = false
var rishaPayed = false
var hadTallymarks = false

func _init():
	sceneID = "StocksRishaBlowjob"

func _reactInit():
	if(RNG.chance(50)):
		rishaPayed = true
	
func _run():
	if(state == ""):
		addCharacter("risha")
		playAnimation(StageScene.StocksSexOral, "tease", {npc="risha"})
		# (if can see)
		if(!GM.pc.isBlindfolded()):
			saynn("К тебе подходит охранница, знакомая морда. Та самая рысь, что помогала тебя оформлять.")

		# (if can’t see)
		else:
			saynn("Кто-то подходит к тебе. Слышны тяжелые шаги. Ты не сразу понимаешь, кто это, но, услышав голос, мгновенно узнаешь её. Это та самая рысь, что помогала тебя оформлять.")

		saynn("[say=risha]Ну что, как успехи?[/say]")

		saynn("Ты пытаешься пожать плечами, но понимаешь, что это невозможно. Охранница хватает тебя за подбородок и заставляет смотреть ей в пах. Без сомнения, под всей этой броней у неё припрятан колючий кошачий член.")

		#ACEPREGEXPAC - Risha face fucking you in the stocks has a few line variants
		#The If/Else statements are getting repetitive but atleast Im learning. I also have the suspicion that doing them everytime is not exactly *the best* way to code this, but hey, this early if it's working, it's working.
		#also with how horny Risha usually is, I imagine Preg-Risha is even hornier. I know there are "themes" to a pregnancy. Horny, Tired, Affectionate, Sick, and so on. Maybe if I added more scenes I could play into that?? Maybe its better if it was a guide rather than a strict rule, so I can whatever.

		if(getCharacter("risha").isVisiblyPregnant()):
			saynn("[say=risha]Слушай сюда. Эта беременность так меня, блядь, возбуждает. Сосёшь мне прямо здесь и сейчас, а я тебя даже награжу.[/say]")
		else:
			saynn("[say=risha]Слушай сюда. Я так, блядь, возбуждена. Сосёшь мне прямо здесь и сейчас, а я тебя даже награжу.[/say]")

		# (if can’t oral)
		if(GM.pc.isOralBlocked()):
			saynn("[say=risha]Я даже сниму с тебя кляп бесплатно.[/say]")

		addButton("Покачать головой", "Ты не хочешь получать плату за секс", "shake_head")
		addButton("Кивнуть", "Получить кредиты за небольшую услугу? Вполне честно", "nod")

	if(state == "shake_head"):
		saynn("Ты вырываешься из её хватки и качаешь головой. Она хмыкает и взъерошивает твои волосы.")

		saynn("[say=risha]Ладно. В следующий раз я могу быть не такой доброй.[/say]")

		addButton("Продолжить", "Всё в порядке", "endthescene")

	if(state == "nod"):
		playAnimation(StageScene.StocksSexOral, "sex", {npc="risha", npcBodyState={exposedCrotch=true,hard=true}})
		
		saynn("Ты слегка киваешь. Риша посмеивается и стягивает набедренную часть своей тяжелой брони. Затем она спускает трусики, обнажая свой толстый член. Его размер около {risha.penisSizeStr}, он кошачьего типа — без узла, просто с маленькими шипами на длинном кончике.")

		# (if can’t oral)
		if(rishaRemovedGag):
			saynn("Как и обещала, она освобождает твой рот.")

		saynn("[say=risha]Шипы мягкие, не переживай~. Я не разнесу тебе горло. Если только ты сам этого не захочешь.[/say]")

		saynn("Что ж, это облегчение. Ты почти не можешь шевелить руками или головой, так что вся инициатива в её руках. Она устраивается перед тобой и направляет член к твоим губам. Ты приоткрываешь рот и высовываешь язык. Затем ты слизываешь смазку с её красного ствола, проводя языком по всей его длине. Шипы и вправду ощущаются мягкими, а от таких ласк Риша издает глубокий стон. Она больше не может выносить эти прелюдии и втискивает свой член между твоих губ, а затем заталкивает его глубже, заставляя тебя широко раскрыть рот.")

		saynn("[say=risha]О да, черт возьми! Люблю пожестче, сучка. Оставь свои нежности для нежных девок.[/say]")
		
		if(getCharacter("risha").isVisiblyPregnant()):
			saynn("Ей приходится обхватить свой беременный живот, чтобы запустить руку тебе за затылок и начать глубокий минет, вгоняя свой гигантский член так глубоко, что он упирается в заднюю стенку горла. Кажется, она уже вовсю течет; ты чувствуешь вкус её предэякулята на языке, пока она использует тебя как обычную секс-игрушку.")
		else:
			saynn("Она обхватывает твою пасть руками сверху и снизу и начинает жестко ебать тебе лицо, вгоняя свой гигантский член так глубоко, что он упирается в заднюю стенку рта, а затем проваливается в глотку. Кажется, она уже течет: ты чувствуешь вкус её предэякулята на языке, пока она использует тебя как обычную секс-игрушку.")

		saynn("[say=risha]Ты что, тренировалась? У тебя талант к сосанию хуев.[/say]")

		if(getCharacter("risha").isVisiblyPregnant()):
			saynn("Она вгоняет член еще глубже, прижимая низ живота к твоему лбу; каждый её толчок перекрывает тебе дыхание, а твоя глотка заметно раздувается. Её яйца хлопают по твоему подбородку, пока она трахает твой рот всё быстрее и быстрее; ты обслюнявливаешь её шипы языком и чувствуешь, как пульсирует ствол, когда она выстреливает предэякулятом тебе прямо в горло. Быть вынужденной глубоко заглатывать её кошачий член не совсем приятно, но в то же время... в этом есть что-то эдакое... Ты сжимаешь мышцы горла вокруг её члена и наблюдаешь, как она корчится и стонет, продолжая растягивать и ебать твой рот.")
		else:
			saynn("Она вгоняет член еще глубже, перекрывая тебе дыхание каждым толчком, отчего твоя глотка заметно раздувается. Её яйца хлопают по твоему подбородку, пока она трахает твой рот всё быстрее и быстрее; ты обслюнявливаешь её шипы языком и чувствуешь, как пульсирует ствол, когда она выстреливает предэякулятом тебе прямо в горло. Быть вынужденной глубоко заглатывать её кошачий член не совсем приятно, но в то же время... в этом есть что-то эдакое... Ты сжимаешь мышцы горла вокруг её члена и наблюдаешь, как она корчится и стонет, продолжая растягивать и ебать твой рот.")

		saynn("[say=risha]Бля, я уже почти... Только не вздумай шевелиться, когда я кончу![/say]")

		saynn("И скоро ты поймешь почему. По мере того как она приближается к пику, её шипы становятся тверже, начиная мягко скрести по твоему горлу. Риша переходит на медленные, но мощные толчки, каждый раз засаживая свой член глубоко внутри. Тебе едва хватает воздуха, а она дышит тяжело, и её член пульсирует у тебя в глотке. После нескольких глубоких толчков она вбивается в тебя в последний раз, стоная и кряхтя, пока её член извергается липкой горячей спермой. Твердые шипы удерживают вас обоих, словно узел, но так Риша может в любой момент решить уничтожить твое горло, если захочет. Она силой удерживает твои губы сомкнутыми вокруг своего ствола, пока вливает в тебя очередную порцию своей нагрузки. В конце концов шипы немного смягчаются, она вытаскивает член и последними волнами кончает тебе прямо в лицо.")

		saynn("Она вытирает ствол о твое лицо и убирает его. Затем она берет черный маркер и [b]рисует черточку на твоей щеке[/b].")

		# (if didn’t have any)
		if(!hadTallymarks):
			saynn("[say=risha]Значит, я первая, да? Это просто чтобы не сбиться со счета~.[/say]")

		# (else)
		else:
			saynn("[say=risha]Ты это заслужила~.[/say]")

		saynn("Затем она берет свой планшет и находит твое дело. Она что-то напевает под нос.")

		# (if decided to pay)
		if(rishaPayed):
			saynn("[say=risha]Хорошая сучка. Один рабочий кредит тебе~.[/say]")

			saynn("Она осторожно похлопывает тебя по голове и оставляет одну, все еще зажатую в колодках.")

		# (if not decided to pay)
		else:
			saynn("[say=risha]Знаешь, мне кажется, ты не заслужила эту выплату. Просто потому, что шлюхам иногда нужно страдать~[/say]")

			saynn("Ты в ярости. Но она быстро уходит, не давая тебе сказать лишнего. Ты всё ещё беспомощен, но теперь к этому чувству добавилось ощущение, что тебя просто использовали.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action in ["nod"]):
		processTime(RNG.randi_range(30, 60)*60)

	if(_action == "nod"):
		if(GM.pc.hasTallymarks()):
			hadTallymarks = true
		
		if(rishaPayed):
			GM.pc.addCredits(1)
			addMessage("Вы получили 1 кредит")
		
		if(GM.pc.isOralBlocked()):
			rishaRemovedGag = true
			GM.pc.freeMouthDeleteAll()
			
		if(RNG.chance(40)):
			var zone = BodyWritingsZone.getRandomZone()
			GM.pc.addBodywriting(zone, BodyWritings.getRandomWritingIDForZone(zone))
			addMessage("Риша также оставила памятный след на твоей "+BodyWritingsZone.getZoneVisibleName(zone)+"..")
			
		GM.pc.addTallymarkFace()
		GM.pc.cummedInMouthBy("risha")
		GM.pc.cummedOnBy("risha")
		GM.pc.addSkillExperience(Skill.SexSlave, 20, "risha_stocksblow")
		GM.pc.gotThroatFuckedBy("risha")

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()
	
	data["rishaRemovedGag"] = rishaRemovedGag
	data["rishaPayed"] = rishaPayed
	data["hadTallymarks"] = hadTallymarks
	
	return data
	
func loadData(data):
	.loadData(data)
	
	rishaRemovedGag = SAVE.loadVar(data, "rishaRemovedGag", false)
	rishaPayed = SAVE.loadVar(data, "rishaPayed", false)
	hadTallymarks = SAVE.loadVar(data, "hadTallymarks", false)
