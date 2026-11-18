extends RecruitSceneBase

func _init():
	sceneID = "FerriRecScenePetplayOverstim"

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
		saynn("Всё готово. Нацепив на неё всё снаряжение, ты снова тянешь за поводок, заставляя Ферри подняться и ходить за тобой по камере. Она тяжело дышит, а её взгляд так и мечет молнии.")

		saynn("А ведь выглядит она довольно мило. Попка покачивается, грудь низко свисает и подпрыгивает при каждом шаге.")

		saynn("[say=ferri]Хафф! Зачем ты это делаешь?[/say]")

		saynn("[say=pc]"+str(ch1("I want you to be a good puppy.", "I want you to obey. Like a slutty puppy.", "I want to turn you into a drooling mindless pet."))+"[/say]")

		saynn("Она рычит... но её хвостик при этом слегка виляет.")

		saynn("[say=ferri]Никогда.[/say]")

		saynn("Ты приседаешь перед ней на корточки.")

		saynn("[say=pc]"+str(ch1("Sit. Can you do that for me?", "Sit, bitch.", "Sit. Now."))+"[/say]")

		saynn("Она сверлит тебя взглядом, её голубые глаза буквально горят.")

		saynn("[say=ferri]Нет.[/say]")

		saynn("Ты протягиваешь руку и тыкаешь её в носик, просовывая палец сквозь металлические прутья намордника.")

		saynn("Она моргает, и на секунду у неё даже глаза к переносице съезжаются.")

		saynn("[say=pc]"+str(ch1("I'm not afraid of you, brat. Just sit, it's not that hard.", "I'm not afraid of you, silly. Just sit, it's not that hard.", "You're such a dumb pup. Just sit, it's not that hard."))+"[/say]")

		saynn("Её зад опускается... совсем чуть-чуть.")

		saynn("Ты протягиваешь руку, чтобы почесать её за левым ушком и под подбородком. От этого она вздрагивает.")

		saynn("[say=ferri]Прекрати... мяу...[/say]")

		saynn("[say=pc]"+str(ch1("Good puppy. Keep going.", "C'mon, keep going.", "Show me some obedience, c'mon. I know that you're nothing but a subby pup."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "ferri_sits")
	if(state == "ferri_sits"):
		playAnimation(StageScene.PuppyDuo, "stand", {pc="pc", npc="ferri", npcAction="paw", npcBodyState={naked=true, hard=true, leashedBy="pc"}})
		saynn("Ферри садится поплотнее... а затем отрывает передние лапки от пола.")

		saynn("[say=ferri]...вот так... мяу...[/say]")

		saynn("[say=pc]"+str(ch1("Now give me your paw.", "Now give me your paw. Now.", "Now give me your paw, pup."))+"[/say]")

		saynn("Она фыркает и колеблется. Тогда ты ласкаешь её по голове, отчего её веки начинают полуприкрываться. В груди у неё зарождается мурлыканье.")

		saynn("[say=ferri]Мммм...[/say]")

		saynn("Она поднимает лапку!")

		saynn("[say=pc]"+str(ch1("Good girl.", "What a good little slut.", "Most of the time you're a worthless stupid whore. But you know some tricks it seems."))+"[/say]")

		saynn("Ты берешь её лапку и слегка трясешь ею.")

		saynn("[say=ferri]Мяу... это так унизительно...[/say]")

		saynn("[say=pc]"+str(ch1("You look adorable, though.", "You look like such an adorable slutty pet though.", "You look like an adorable slutty pet. Why do you even pretend to be a person."))+"[/say]")

		saynn("Она качает головой, всё ещё немного сопротивляясь.")

		saynn("Ты протягиваешь руку и хватаешь её за рога, заставляя её вздрогнуть всем телом.")

		saynn("[say=ferri]Иии.. ммм..[/say]")

		saynn("Когда ты начинаешь их поглаживать, её губы приоткрываются, и из горла начинает вырываться тихий звук.")

		saynn("[say=ferri]Ах...[/say]")

		saynn("Её тело извивается, пока твоя ладонь скользит по ребристым рогам. Всё больше и больше милых звуков срывается с её губ, а глаза то и дело закатываются.")

		saynn("[say=ferri]Ннхх.. вредина..[/say]")

		saynn("Это видно невооружённым глазом. Её голубые соски напряжены и торчат, а узкая щелочка киски сочится соком прямо на пол. Её хвост начинает вилять чуть активнее.")

		saynn("[say=ferri]Хфф.. ах..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "more_pats")
	if(state == "more_pats"):
		playAnimation(StageScene.PuppySexStart, "pat", {pc="pc", npc="ferri", npcBodyState={naked=true, hard=true, leashedBy="pc"}})
		saynn("Ты позволяешь Ферри снова встать на четвереньки.")

		saynn("[say=pc]"+str(ch1("Look at you. You're melting, cutie.", "Look at you. You're melting, little slut.", "Look at you. You're melting. Pathetic really."))+"[/say]")

		saynn("[say=ferri]Нн.. тсс..[/say]")

		saynn("Ты веришь, что она не укусит тебя, и снимаешь с неё намордник.")

		saynn("И Ферри... просто замирает, глядя на тебя снизу вверх.")

		saynn("[say=pc]"+str(ch1("Aww. You don't wanna bite me anymore.", "I see that you don't wanna bite me anymore. Cute.", "Already gave up trying to bite me. I expected that."))+"[/say]")

		saynn("Ты кладешь обе руки ей на голову и запускаешь пальцы в её густую шерсть, чеша её везде, где только можно! У Ферри перехватывает дыхание.")

		saynn("[say=ferri]Хафф.. ффф.. ххф..[/say]")

		saynn("Ты чешешь её и за ушами... а затем снова переходишь на поглаживание рогов... Ты находишь то самое место, от которого её бёдра начинают подергиваться, а хвост — заметно вилять... Тук-тук-тук по бетону.")

		saynn("[say=ferri]Стооооп.. мяу..[/say]")

		saynn("Её тело явно не хочет, чтобы ты останавливался. Ты осыпаешь эту щеночку почесушками по голове, так что её ушки прижимаются к черепу. Затем ты наклоняешься вперед и проводишь длинными движениями по её животу и спине, заставляя её выгнуться.")

		saynn("[say=ferri]Няаа-ах..[/say]")

		saynn("Она извивается и дрожит, высунув язык и тяжело дыша.")

		saynn("[say=pc]"+str(ch1("You're a cute little puppy.", "You're a slutty little pup.", "Dumb little pup."))+"[/say]")

		saynn("[say=ferri]Гав.. хфф.. аах..[/say]")

		saynn("О да, её киска — словно маленький фонтанчик, капающий без остановки. Но ты не уделяешь этой зоне внимания, а лишь продолжаешь чесать её и гладить.")

		saynn("Когда ты останавливаешься и протягиваешь ей руку... она тут же начинает тереться о неё носом, а из её горла вырывается мурлыканье. Ты наклоняешься к самому её уху и шепчешь.")

		saynn("[say=pc]"+str(ch1("Puppy, puppy, puppy.", "Puppy, puppy, puppy.", "Puppy, puppy, puppy. Nothing but a stupid puppy."))+"[/say]")

		saynn("[say=ferri]Гав.. гав.. ммх..[/say]")

		saynn("Ты гладишь её по голове ещё сильнее и чешешь ей пузико!")

		saynn("После такого количества похвалы и стимуляции... её мозг буквально коротит: рот приоткрыт, с языка на пол капает слюна. Взгляд расфокусирован, зрачки расширены на весь глаз. Единственные звуки, которые она издаёт — это мягкое, ритмичное сопение и щенячий лай. Её хвост виляет так неистово, что он мог бы легко разнести мебель, окажись она рядом.")

		saynn("В этой щеночке не осталось ни капли борьбы. Никакого сопротивления.")

		saynn("Ты оставляешь её в этом состоянии ещё на некоторое время, продолжая осыпать её ласковыми словами, которые не дают ни одной здравой мысли пробиться в её сознание.")

		saynn("[say=pc]"+str(ch1("Yes. You're my puppy. My good little puppy.", "That's right. You're a puppy. My puppy.", "Worthless little thing. You know your place, right? Yes, you do."))+"[/say]")

		saynn("Но пора закругляться.")

		addButton("Продолжить", "Смотреть, что будет дальше", "put_things_back")
	if(state == "put_things_back"):
		playAnimation(StageScene.Beg, "pat", {pc="ferri", npc="pc", bodyState={naked=true, hard=true}})
		saynn("Ты снимаешь с Ферри атрибуты щенка и надеваешь на неё старое снаряжение... намордник и кандалы.")

		saynn("Она всё ещё выглядит совершенно отлетевшей.")

		saynn("[say=ferri]Гав..[/say]")

		saynn("Вы гладите её ещё сильнее!")

		saynn("А затем... вы оставляете её в покое. Пора узнать, что об этом думает Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "ferri_all_fours"):
		putOff("ferri", "inmatewristcuffs")

	if(_action == "more_pats"):
		putOff("ferri", "basketmuzzle")

	if(_action == "put_things_back"):
		putOn("ferri", "inmatewristcuffs")
		putOn("ferri", "basketmuzzle")

	setState(_action)
