extends RecruitSceneBase

func _init():
	sceneID = "FerriRecScenePetplaySadism"

func _reactInit():
	putOn("ferri", "inmatewristcuffs")
	putOn("ferri", "basketmuzzle")

func _run():
	if(state == ""):
		addCharacter("ferri", ["naked"])
		aimCameraAndSetLocName("hideout_breakroom")
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcBodyState={naked=true}})
		saynn("Тебе нужна одна вещь, и Кейт предлагает быстро соорудить её импровизированную версию. Вроде бы сойдет.")

		saynn("Затем... ты открываешь дверь камеры и входишь внутрь, сжимая в руке новый шикарный многохвостый кнут. Он сделан из множества сплетенных проволок, скрученных у рукояти, и на каждом конце — маленький узел. Для девятихвостки он довольно велик... почти метр в длину.")

		saynn("Ферри смотрит на тебя снизу вверх; её запястья всё ещё в наручниках, а на мордочке — намордник. Её голубые глаза сужаются.")

		saynn("[say=ferri]Долго же ты копался, злюка. Наконец-то пришел меня выпустить?[/say]")

		saynn("Ты поднимаешь кнут вверх.")

		saynn("[say=pc]"+str(ch1("No. I came to train you.", "No, slut. I came to break you.", "No, you stupid bitch. I came to make you my pet."))+"[/say]")

		saynn("Её хвост с силой хлопает по полу, а клыки цокают о корзину намордника.")

		saynn("[say=ferri]Мяу... мечтай больше. Я тебе не какая-нибудь рабыня, которую можно просто...[/say]")

		saynn("Ты подходишь ближе и хлестаешь кнутом по стене совсем рядом с бедром Ферри. От этого звука она вздрагивает.")

		saynn("[say=pc]"+str(ch1("Kneel. Now.", "On your knees, whore.", "Kneel before I stripe that pretty blue fur red."))+"[/say]")

		saynn("[say=ferri]Ну же, попробуй![/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "grab_leash")
	if(state == "grab_leash"):
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcAction="hurt", npcBodyState={naked=true, leashedBy="pc"}})
		saynn("Ты хватаешь её за поводок и резко дергаешь, отрывая её от стены... и в этот же миг наносишь удар! Ферри взвизгивает, когда кнут опускается на её голую задницу.")

		saynn("[say=ferri]Ик![/say]")

		saynn("Всё её тело напрягается, на ягодицах проступают мелкие складки.")

		saynn("[say=pc]"+str(ch1("I said kneel. Not hard.", "Kneel, bitch. Or the next one's on your tits.", "You're going to learn. One whip strike at a time."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_kneels")
	if(state == "ferri_kneels"):
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcAction="kneel", npcBodyState={naked=true, leashedBy="pc"}})
		saynn("Ферри свирепо смотрит на тебя... но её колени начинают подгибаться. Медленно она опускается на холодный пол перед тобой, всё ещё прижимая скованные руки к спине.")

		saynn("[say=ferri]..ладно.. хорошо.[/say]")

		saynn("[say=pc]"+str(ch1("Good. Now hold still.", "That's better. Stay.", "Look at you. Already learning your place."))+"[/say]")

		saynn("Ты приседаешь и отпираешь наручники, позволяя её рукам упасть вдоль тела, пока металл с лязгом падает на пол.")

		saynn("[say=ferri]Мяу?..[/say]")

		saynn("[say=pc]"+str(ch1("Get on all fours. Like a puppy.", "Get on all fours. You're going to be my slutty pup.", "Get on all fours, you worthless."))+"[/say]")

		saynn("Ферри потирает запястья, её хвост обвивается вокруг бедра.")

		saynn("[say=ferri]А если не захочу?[/say]")

		saynn("Ты отвечаешь очередным ударом. Этот приходится ей по спине. Она взвизгивает и выпячивает грудь вперед.")

		saynn("[say=pc]"+str(ch1("Then I keep hitting you until you do.", "Then you get the whip until you can't stand. Your choice.", "Then you bleed. Simple."))+"[/say]")

		saynn("Уши Ферри прижимаются к голове...")

		addButton("Продолжить", "Смотри, что будет дальше...", "ferri_allfours")
	if(state == "ferri_allfours"):
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcAction="allfours", npcBodyState={naked=true, leashedBy="pc"}})
		saynn("Она упирается ладонями в пол и медленно встает на четвереньки; её грудь теперь свисает вниз, покачиваясь, пока она устраивается поудобнее.")

		saynn("[say=ferri]Мррр... теперь доволен?[/say]")

		saynn("Её тон кажется недостаточно ласковым, поэтому ты снова хлестаешь её по заднице хлыстом; многочисленные узлы впиваются в мех, оставляя множество следов на её мягких щечках.")

		saynn("[say=ferri]Хафф...[/say]")

		saynn("[say=pc]"+str(ch1("I'll be happy when you're a drooling mess. Crawl behind me, pup.", "Crawl behind me, slut.", "I'll be happy when you're nothing but a drooling mess. Crawl."))+"[/say]")

		saynn("Ты тянешь за поводок... и наблюдаешь, как она следует за тобой, шаг за шагом. Ты водишь её медленными кругами по камере, а её хвост волочится позади.")

		saynn("Ты решаешь нанести еще один удар по её заднице, чтобы она по-настоящему зажгло.")

		saynn("[say=ferri]Хфф! Я сделала, как велели... Вреднюга...[/say]")

		saynn("Снова раздается удар хлыста, и задница Ферри заметно краснеет. Она ерзает и выгибает спину, пытаясь сдержать боль.")

		saynn("[say=ferri]Иик... хафф-ф...[/say]")

		saynn("Ты продолжаешь ходить с ней по камере из угла в угол. И именно в этот момент Ферри решает что-то сказать.")

		saynn("[say=ferri]Ты бьешь как кошечка, знаешь ли..[/say]")

		saynn("[say=pc]Кошечка, значит? Мы можем тебе кошечку устроить.[/say]")

		saynn("Вы выходите из камеры, Ферри на поводке. Кейт стоит неподалеку.")

		addButton("Кейт", "Дать Кейт немного поиграть с Ферри", "let_kait")
	if(state == "let_kait"):
		addCharacter("kait")
		playAnimation(StageScene.Spanking, "fast", {pc="kait", npc="ferri", npcBodyState={naked=true, hard=true}})
		aimCameraAndSetLocName("hideout_near_break_room")
		saynn("[say=kait]Оу, какой милый щеночек! Она уже сломалась?[/say]")

		saynn("[say=pc]Еще нет. Она сказала, что я бью как кошечка.[/say]")

		saynn("[say=kait]Ха! Дай-ка я попробую.[/say]")

		saynn("Кейт садится позади Ферри и начинает тискать её пушистую задницу.")

		saynn("[say=ferri]Мяу..[/say]")

		saynn("Внезапно.. три быстрых удара подряд по её ягодицам. Ферри пискнула, её передние лапы слегка разъехались. Хвост убирается в сторону, открывая тебе и Кейт четкий вид на её мокрую голубую киску.")

		saynn("[say=ferri]Ммм.. можешь и посильнее.. мяу..[/say]")

		saynn("[say=kait]Оу, прелесть какая.[/say]")

		saynn("Она забирает у тебя хлыст и использует его, раз за разом стегая драката по заднице; от каждого удара Ферри стонет в корзинном наморднике.")

		saynn("[say=kait]Так лучше?[/say]")

		saynn("[say=ferri]..да.. мяу..[/say]")

		saynn("Пока Кейт лупит Ферри по заднице, ты приседаешь рядом и вместо этого шлепаешь её по сиськам, заставляя их забавно колыхаться.")

		saynn("[say=ferri]Иик.. ня..[/say]")

		saynn("Бедная дракат попала под двойной напор... но, кажется, ей не привыкать. Её щелочка сочит сок прямо на пол, а задница и грудь полностью выставлены на обозрение.")

		saynn("[say=pc]"+str(ch1("Look at you. Begging for it with your whole body.", "You're getting really horny from this, aren't you, slut?", "Dumb puppy. Your cunt is dripping."))+"[/say]")

		saynn("[say=ferri]Не пяльтесь так сильно.. ах.. вредины..[/say]")

		saynn("[say=kait]Буду пялиться столько, сколько захочу~.[/say]")

		saynn("Ты забираешь хлыст обратно у Кейт и наносишь новые удары по всему её телу... на спине остаются изящные красные полосы... прямо как на сиськах и бедрах.")

		saynn("[say=ferri]Я тебя укушу... ня-а-а...[/say]")

		saynn("Её киску тоже настигает мягкий удар: многочисленные узлы плетёного провода покалывают чувствительные места. Ферри откидывает бёдра назад, издавая жалобный скулёж.")

		saynn("[say=ferri]Нхх... м-мяу...[/say]")

		saynn("Она мешком валится на пол.")

		saynn("[say=kait]Ой, кажется, ты сломал бедную собачку.[/say]")

		saynn("[say=ferri]Гав..[/say]")

		saynn("[say=pc]"+str(ch1("I think she enjoyed it.", "That bitch deserved it.", "Good. This animal deserves it."))+"[/say]")

		saynn("Кейт несколько раз похлопывает Ферри по голове... прежде чем ты забираешь её обратно в камеру.")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_back_cuffed")
	if(state == "ferri_back_cuffed"):
		removeCharacter("kait")
		playAnimation(StageScene.Duo, "stand", {npc="ferri", npcBodyState={naked=true}})
		saynn("Ты возвращаешь Ферри в камеру и для безопасности снова надеваешь наручники на её лапки. Её грудь всё ещё часто вздымается, а взгляд кажется немного отсутствующим.")

		saynn("[say=ferri]Вредный... мяу...[/say]")

		saynn("Ты даёшь ей последний шлепок хлыстом по заднице.")

		saynn("[say=ferri]Ииик!..[/say]")

		saynn("[say=pc]"+str(ch1("Good puppy.", "Sweet little slut.", "Worthless stupid whore."))+"[/say]")

		if (success):
			saynn("Она мурлычет.")

		else:
			saynn("Она фыркает.")

		saynn("Ты выходишь наружу.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "ferri_kneels"):
		putOff("ferri", "inmatewristcuffs")

	if(_action == "ferri_back_cuffed"):
		putOn("ferri", "inmatewristcuffs")

	setState(_action)
