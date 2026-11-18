extends RecruitSceneBase

func _init():
	sceneID = "FerriRecScenePetplayDeny"

func _reactInit():
	putOn("ferri", "inmatewristcuffs")
	putOn("ferri", "basketmuzzle")

func _run():
	if(state == ""):
		addCharacter("ferri", ["naked"])
		aimCameraAndSetLocName("hideout_breakroom")
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcBodyState={naked=true}})
		saynn("Вы просите свою команду принести особые оковы... И их приносят!")

		saynn("Затем вы заходите в камеру и видите Ферри. Она всё ещё голая, в наручниках, с намордником и на привязи у трубы. Хорошо.")

		saynn("Её взгляд впивается в вас.")

		saynn("[say=ferri]Наконец-то... Долго же ты возился. Развяжи меня![/say]")

		saynn("Вы просто поднимаете те самые аксессуары для «щенят». Это похоже на набор черных кожаных накладок, которые надеваются на локти и колени.")

		saynn("[say=ferri]Нет! Мяу... Я не буду это носить![/say]")

		saynn("[say=pc]"+str(ch1("You don't have a choice. You will wear this.", "You will, slut.", "You'll wear what I tell you to wear, bitch."))+"[/say]")

		saynn("Ферри сильнее скалит клыки под намордником. Они стучат о металлическую сетку.")

		saynn("[say=ferri]Заставь меня, вредина![/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_flops")
	if(state == "ferri_flops"):
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcAction="defeat", npcBodyState={naked=true, leashedBy="pc"}})
		saynn("Вы хватаете её за поводок и тянете к центру камеры. Она пытается вырваться, но вы дергаете ещё сильнее, заставляя её повалиться на пол.")

		saynn("[say=ferri]Ррр-р... АЙ![/say]")

		saynn("Она неуклюже валится на пол, её хвост с силой хлопает по полу. Похоже, лапы будет проще зафиксировать, поэтому ты начинаешь с них.")

		saynn("Ферри извивается и брыкается, её хвост так и хлещет тебя по руке. Ты игнорируешь это, натягивая кожаные ремни на её колени так, чтобы задние лапки были прижаты к её заднице.")

		saynn("[say=ferri]Я тебя укушу, так сильно укушу![/say]")

		saynn("Не с этой намордником, как она думает.")

		saynn("Следуют руки. Ты снимаешь её наручники и быстро связываешь их, пока она не успела слишком сильно исцарапать тебя. Идеально.")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_all_fours")
	if(state == "ferri_all_fours"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc="pc", npc="ferri", npcAction="walk", npcBodyState={naked=true, hard=true, leashedBy="pc"}})
		saynn("Закончив, ты тащишь Ферри к центру камеры, подальше от стены. Новые путы заставляют её ползти на локтях и коленях, при этом её задница высоко задрана, а хвост волочится сзади.")

		saynn("[say=ferri]Это унизительно... мяу...[/say]")

		saynn("[say=pc]"+str(ch1("That's the point. It will get better.", "Good. You look cute when you're humiliated.", "Humiliating? You look like a breeding bitch on display."))+"[/say]")

		saynn("Ты обходишь её сзади. Её хвост нервно подергивается. Ты наклоняешься и проводишь пальцем по внешней стороне её милой голубой киски. Она вздрагивает.")

		saynn("[say=ferri]Эй... Не трогай там...[/say]")

		saynn("[say=pc]"+str(ch1("I'll touch wherever I want. You're my puppy now.", "Too bad. Your wet cunt says otherwise.", "Shut up. This is happening."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "pc_touches_ferri")
	if(state == "pc_touches_ferri"):
		playAnimation(StageScene.PuppySexStart, "start", {pc="pc", npc="ferri", npcBodyState={naked=true, hard=true, leashedBy="pc"}})
		saynn("Ты медленно потираешь её внешние складки. Кажется, Ферри уже немного промокла от стресса... или, может, от этих щенячьих пут. Её бёдра дёргаются.")

		saynn("[say=ferri]Мяу...[/say]")

		saynn("Твой палец находит её клитор... маленький и твердый. Ты нежно поглаживаешь его из стороны в сторону.")

		saynn("[say=ferri]Хххнн..[/say]")

		saynn("[say=pc]"+str(ch1("Feel good? Tell me.", "That's right. Let me hear you.", "You're already dripping. Fucking slut."))+"[/say]")

		saynn("Ты кружишь большим пальцем вокруг её клитора, а двумя другими пальцами проникаешь между складок и раздвигаешь их. Она кажется влажной и горячей, а стенки её любовного туннеля уже пытаются сжиматься вокруг пустоты.")

		saynn("[say=ferri]Нн..[/say]")

		saynn("Её хвост полностью убирается в сторону, кажется, её сопротивление немного ослабевает.")

		saynn("Ты вставляешь один палец внутрь и начинаешь им шевелить.")

		saynn("[say=ferri]Щёлк..[/say]")

		saynn("Вскоре ты добавляешь второй палец. Она ахает под намордником. Ты сгибаешь пальцы вниз, надавливая на переднюю стенку, пытаясь нащупать её точку удовольствия.")

		saynn("[say=ferri]Мяу.. Мнгх..[/say]")

		saynn("Пока она так совершенно беспомощна... ты задаешь ритм... скользя пальцами туда-сюда, при этом большим пальцем потирая её клитор при каждом толчке. Её дыхание быстро становится тяжелее.")

		saynn("Её бедра начинают двигаться сами собой, подаваясь назад, навстречу твоей руке; подбородок опускается, а уши прижимаются к голове.")

		saynn("[say=pc]"+str(ch1("There she goes. Getting into it.", "Look at you. Grinding on my fingers like a bitch in heat.", "Pathetic. You're already humping the air."))+"[/say]")

		saynn("[say=ferri]Тссс... мяу...[/say]")

		saynn("Но она не останавливается. Её киска становится всё мокрее... при каждом толчке слышны мягкие, влажные звуки.")

		saynn("Ты чувствуешь, как её стенки начинают трепетать. Она уже близко.")

		saynn("[say=pc]"+str(ch1("Not yet. You don't get to cum.", "Stop. You're not allowed to cum.", "No. Hold it, whore."))+"[/say]")

		saynn("Ты полностью вынимаешь пальцы.")

		saynn("[say=ferri]Что?.. почему..[/say]")

		saynn("Она изо всех сил пытается оглянуться на тебя, а её соки капают на пол.")

		saynn("[say=pc]"+str(ch1("Because I said so. Beg first.", "Because you don't deserve it yet. Not until you ask nicely.", "Because I decide when you come. Not you."))+"[/say]")

		saynn("[say=ferri]Это глупо! Дай мне кончить![/say]")

		saynn("[say=pc]"+str(ch1("Not with that attitude. Try again.", "No. Try begging like a good puppy.", "Stupid brat. You don't give orders here."))+"[/say]")

		saynn("Она рычит, её хвост нервно хлещет из стороны в сторону.")

		saynn("[say=ferri]Засранка![/say]")

		saynn("[say=pc]"+str(ch1("Hate me all you want. You're still not cumming.", "Good. Hate me. It won't help.", "Cry about it, slut. I will just deny you harder."))+"[/say]")

		saynn("Ты ждёшь. Она сверлит тебя взглядом, но затем её глаза опускаются.")

		saynn("[say=ferri]Ну пожалуйста?..[/say]")

		saynn("[say=pc]"+str(ch1("Please what? Use your words.", "Please what, puppy? Say it clearly.", "Please what? You want to cum like a dumb animal?"))+"[/say]")

		saynn("[say=ferri]Пожалуйста.. дай мне кончить.. мяу..[/say]")

		saynn("Ее голос стал тише, хвост один раз вильнул.")

		saynn("Ты наклоняешься и снова трешь ее клитор. Медленно ты вводишь пальцы обратно внутрь. Она уже такая мокрая.. ее мех промок насквозь. Ты ускоряешься и начинаешь жестко и быстро трахать ее пальцами.")

		saynn("[say=ferri]Мммх.. ах.. да.. ахх..[/say]")

		saynn("Ее бедра дергаются, тело извивается, хвост уходит в сторону и ложится на пол. Ее дыхание снова становится прерывистым, а стоны наполняют комнату.")

		saynn("[say=ferri]Пожалуйста.. мяу.. пожалуйста, не останавливайся.. я сделаю всё что угодно..[/say]")

		saynn("[say=pc]"+str(ch1("I'll stop whenever I want.", "Maybe I'll let you. Maybe I won't.", "Beg better and maybe."))+"[/say]")

		saynn("[say=ferri]Я буду твоей послушной собачкой.. я никогда не буду сопротивляться.. пожалуйста..[/say]")

		saynn("Ты чувствуешь это.. ее оргазм на подходе. Все ее тело напрягается, рот широко открывается, изо рта течет слюна, а глаза закатываются. Ее киска снова начинает очень туго сжиматься вокруг твоих пальцев.")

		saynn("И именно в этот момент.. ты снова вынимаешь пальцы. Бедная дракатка тут же это понимает, ее тело начинает метаться в путах.")

		saynn("[say=ferri]Ненавижу тебя! Ты такой злюка! А-а-ах..[/say]")

		saynn("Она валится на бок, её хвост всё ещё дёргается, а киска судорожно сжимается в пустоте, всё ещё сочась соками. Её возбуждение начинает угасать... медленно и мучительно..")

		saynn("[say=ferri]Ха-а.. Мяу.. Пошёл ты нахер..[/say]")

		saynn("[say=pc]"+str(ch1("Watching you break is better than making you cum.", "You don't deserve to cum, slut. Not tonight.", "Because your desperation is funnier than your orgasm."))+"[/say]")

		saynn("На глазах наворачиваются одинокие слёзы. Её тело дрожит.")

		saynn("[say=ferri]Мяу.. пожалуйста.. мне нужно..[/say]")

		saynn("[say=pc]"+str(ch1("You need to learn to obey my every word. That's what you need. Understand?", "You need to learn your place. Below me. Always. You're a slut.", "You need to accept that you're a worthless, dripping mess. Learn your place, bitch."))+"[/say]")

		saynn("Она лишь тяжело дышит и сдаётся, её возбуждение к этому моменту уже давно прошло.")

		saynn("[say=ferri]Злюка.. ну какой же ты злюка..[/say]")

		saynn("Ты снимаешь с неё атрибутику для петплея и снова надеваешь наручники.")

		saynn("Судя по всему, ей это совсем не понравилось.")

		saynn("Но пора узнать, что думает Кейт. Ты пристегиваешь Ферри поводком к трубе и выходишь из камеры.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endstuffmeow")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "ferri_all_fours"):
		putOff("ferri", "inmatewristcuffs")

	if(_action == "endstuffmeow"):
		putOn("ferri", "inmatewristcuffs")
		endScene()
		return

	setState(_action)
