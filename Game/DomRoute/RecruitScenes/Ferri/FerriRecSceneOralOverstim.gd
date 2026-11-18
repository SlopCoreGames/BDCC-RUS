extends RecruitSceneBase

var straponUsed = false
var vagVariant = false

func _init():
	sceneID = "FerriRecSceneOralOverstim"

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
		saynn("Ты просишь у своей команды кольцо-кляп... и что-нибудь особенное для этого случая. Кейт дает тебе и то, и другое: и средство для фиксации, и какой-то... афродизиак. Судя по всему, она просто смешала всё подряд. Что может пойти не так?")

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

		saynn("Её глаза расширяются, когда ты достаешь маленький флакон с розовой, слегка светящейся жидкостью. Ты вливаешь её в рот Ферри, заставляя её закашляться. Но из-за кляпа и того, как ты держишь её за рога, она не может выплюнуть всё содержимое.")

		saynn("[say=pc]"+str(ch1("Just enjoy it, cutie.", "Enjoy it, little slut.", "Enjoy it, whore."))+"[/say]")

		saynn("Ты хватаешь её за поводок и резко тянешь на себя, заставляя её упасть на колени. Затем ты на секунду отстегиваешь её наручники, чтобы схватить её за руки и завести их высоко над головой.")

		saynn("[say=ferri]Мммнх..[/say]")

		if (straponUsed):
			saynn("Ты быстро закрепляешь страпон-портупею на талии, и его наконечник зависает прямо перед её пастью. Удачи с попытками укусить теперь.")

			addButton("Продолжить", "Смотреть, что будет дальше", "pp_fuck")
		elif (!vagVariant):
			saynn("Твой член уже наготове, твердый и пульсирующий прямо перед её пастью. Удачи ей теперь, если захочет укусить.")

			addButton("Продолжить", "Смотреть, что будет дальше", "pp_fuck")
		else:
			saynn("Твоя киска уже выставлена напоказ, прямо перед её пастью. Удачи ей теперь, если захочет укусить.")

			addButton("Продолжить", "Смотреть, что будет дальше", "vag_fuck")
	if(state == "pp_fuck"):
		playAnimation(StageScene.SexOralForced, "suck", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("И вот ты просовываешь свой "+str("cock" if !straponUsed else "rubber shaft")+" сквозь удобное кольцо, втискивая себя в рот Ферри... заходя всё глубже, мимо зубов, прямиком к самому горлу.")

		saynn("[say=ferri]Ггк-![/say]")

		saynn("У неё тут же наворачиваются слезы. Она давится, а её хвост с силой бьет по полу.")

		saynn("[say=pc]"+str(ch1("Breathe through your nose.", "Shut up and take it.", "There we go. Good little hole."))+"[/say]")

		saynn("Ты начинаешь медленно, позволяя стенкам её горла судорожно сжиматься вокруг "+str("you" if !straponUsed else "the toy")+". Затем ты берешь покрепче и вгоняешь его до самого основания! Её нос прижимается к твоему паху.")

		saynn("[say=ferri]Мррррнгх..![/say]")

		saynn("[say=pc]"+str(ch1("That's it. Take all of it.", "Such a good little cock sleeve.", "Your throat was made for this."))+"[/say]")

		saynn("Ты начинаешь трахать ей лицо. Жестко и грубо. Каждый толчок впечатывает кляп-кольцо в её зубы. Слюна мгновенно течет изо рта, смешиваясь со слезами. Из-за поднятых в наручниках рук она вынуждена оставаться на месте. Она ничего не может сделать, не может даже укусить.")

		saynn("Что бы это ни было за лекарство, оно явно работает. От него её глотка становится чертовски приятной для тебя. Каждый миллиметр её губ, языка, горла... всё это обволакивает твой "+str("member" if !straponUsed else "rubber cock")+" так плотно.")

		saynn("Ты чувствуешь, как она начинает дрожать, а её влажные звуки сквозь кляп становятся всё громче.")

		saynn("[say=pc]"+str(ch1("There it is. Feel good?", "You're clenching around me. Dirty bitch.", "You like it. The bratty little slut likes it."))+"[/say]")

		saynn("Внезапно бедра Ферри начинают дергаться. Её хвост снова хлопает по полу. Секунду спустя между её бедер раздается влажный, хлюпающий звук. Она кончает... мощно.")

		saynn("[say=ferri]ХНННН-!..[/say]")

		saynn("Всё её тело выгибается дугой, глаза закатываются, а из её киски на пол брызжет смазка. И ты не останавливаешься. Ты продолжаешь вколачивать свой член ей в глотку на протяжении всего процесса.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_cum")
	if(state == "pp_cum"):
		playAnimation(StageScene.SexOralForced, "suckfast", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты ускоряешься, всё быстрее и быстрее вгоняя свой "+str("cock" if !straponUsed else "strapon")+" в это горло!")

		saynn("Ферри едва успевает перевести дух, как накрывает следующий оргазм... а затем и третий, накладывающийся на второй. Её тело продолжает содрогаться в конвульсиях, хвост бешено мечет, а приглушенные звуки превращаются в влажные, отчаянные скулящие стоны вокруг твоего члена.")

		saynn("[say=ferri]Хффф.. хфф.. МММ-! ММПФ-![/say]")

		saynn("К этому моменту её глаза уже постоянно закачены, а из её киски под ней постоянно растекается лужица соков.")

		if (!straponUsed):
			saynn("И вот ты чувствуешь, как внутри тебя нарастает оргазм.")

			saynn("[say=pc]"+str(ch1("You're gonna swallow every drop.", "Get ready, slut", "Take it like the worthless whore you are."))+"[/say]")

			saynn("Ты входишь в неё до самого основания, твой член пульсирует. Густые струи {pc.cum} бьют прямо ей в глотку. Она всё сильнее давится... но вынуждена глотать, у неё нет выбора. Кольцо-кляп держит её рот широко открытым, пока ты наполняешь её своим семенем; из-за наркотика она кончает уже в четвертый раз, её киска пульсирует в пустоте, тоже извергаясь в никуда...")

			saynn("[say=ferri]Глоть.. глоть.. нннгх..[/say]")

			saynn("Ты следишь за тем, чтобы эта дрянь выкачала из твоих яиц всё до последней капли, оставаясь внутри как можно дольше. Впрочем, кажется, она вот-вот отключится... так что пора завязывать.")

		else:
			saynn("Тебе хочется закончить на высокой ноте...")

			saynn("[say=pc]"+str(ch1("Get ready.", "Get ready, slut", "Take it like the worthless whore you are."))+"[/say]")

			saynn("И ты вонзаешь резиновую игрушку до самого основания, по-настоящему испытывая глотку этой девчонки. Она всё сильнее давится... но вынуждена терпеть, у неё нет выбора. Кольцо-кляп держит её рот широко открытым, пока ты растягиваешь её; из-за наркотика она кончает уже в четвертый раз, её киска пульсирует в пустоте, тоже извергаясь в никуда...")

			saynn("[say=ferri]Глоть.. глоть.. нннгх..[/say]")

			saynn("Ты стараешься оставаться внутри как можно дольше. Впрочем, кажется, она вот-вот отключится... так что пора завязывать.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pp_pullout")
	if(state == "pp_pullout"):
		playAnimation(StageScene.GivingBirth, "idle", {pc="ferri", bodyState={naked=true, hard=true}})
		saynn("Когда ты наконец выходишь, Ферри валится с ног. Её тело содрогается от мелких послевкусиев оргазма, а хвост безжизненно лежит.")

		saynn("Ты берешь корзинчатую насадку и заменяешь ею кольцо-кляп. Ее клыки с щелчком ударяются о металл.")

		saynn("[say=ferri]Гхк.. ух..[/say]")

		saynn("Её голос слабый и охрипший.")

		saynn("[say=pc]"+str(ch1("Good girl. Rest now.", "That's what you get for being a brat.", "You're lucky I didn't go longer."))+"[/say]")

		saynn("Ты выходишь из камеры, чтобы посмотреть, что думает Кейт.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "vag_fuck"):
		playAnimation(StageScene.SexOralForced, "lick", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("И вот ты вжимаешь свою киску прямо в лицо Ферри, прижимая влажные складки к ее приоткрытым губам. Ее рот насильно разведен, язык высунут — у нее нет другого выбора, кроме как лизать тебя.")

		saynn("[say=ferri]Гхх..[/say]")

		saynn("Ты начинаешь медленно, водя щелью по ее лицу и позволяя ее языку поработать.")

		saynn("[say=ferri]Мррхх..[/say]")

		saynn("[say=pc]"+str(ch1("That's it. Lick all of it.", "Such a good little cunt licker.", "Your tongue was made for this."))+"[/say]")

		saynn("Вскоре ты начинаешь просто втираться в ее лицо, жестко и грубо. Каждый толчок бедрами приносит тебе безмерное удовольствие, заставляя стонать. Ее слюна и твои соки смешиваются воедино. Поднятые в наручниках руки заставляют ее оставаться на месте. Она ничего не может сделать, даже укусить.")

		saynn("Что бы это ни был за наркотик, он явно действует. От него скакать ей на лице становится куда приятнее. Каждый взмах ее языка, каждый отчаянный глоток ее приоткрытых губ посылает по твоему телу волны жара.")

		saynn("Ты чувствуешь, как она начинает дрожать, а её влажные звуки сквозь кляп становятся всё громче.")

		saynn("[say=pc]"+str(ch1("There it is. Feel good?", "You're getting off this, dirty bitch.", "You like it. The bratty little slut likes it."))+"[/say]")

		saynn("Внезапно бедра Ферри начинают дергаться. Её хвост снова хлопает по полу. Секунду спустя между её бедер раздается влажный, хлюпающий звук. Она кончает... мощно.")

		saynn("[say=ferri]ХНННН-!..[/say]")

		saynn("Все ее тело выгибается дугой, глаза закатываются, а из киски на пол брызжет смазка. И ты не останавливаешься. Ты продолжаешь втираться в ее лицо до самого конца.")

		addButton("Продолжить", "Смотреть, что будет дальше", "vag_cum")
	if(state == "vag_cum"):
		playAnimation(StageScene.SexOralForced, "lickfast", {pc="pc", npc="ferri", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("Ты ускоряешься, всё сильнее и яростнее втирая свою киску в её рот!")

		saynn("Ферри едва успевает перевести дух, как накрывает следующий оргазм... а следом и третий, накладывающийся на второй. Её тело продолжает содрогаться, хвост дёргается, а приглушённые звуки превращаются в мокрые, отчаянные визги прямо у твоих складок.")

		saynn("[say=ferri]Хффф.. хфф.. МММ-! ММПФ-![/say]")

		saynn("К этому моменту её глаза уже постоянно закачены, а из её киски под ней постоянно растекается лужица соков.")

		saynn("И вот ты чувствуешь, что твой собственный пик уже близко...")

		saynn("[say=pc]"+str(ch1("You're gonna swallow every drop.", "Get ready, slut.", "Take it like the worthless whore you are."))+"[/say]")

		saynn("Как только ты переваливаешь за вершину, ты вжимаешь её лицо между своих ног, прижимая её приоткрытые губы к своим пульсирующим губам... Твои мышцы сжимаются... и тут тебя заливает! Густые струи соков бьют прямо сквозь кольцо кляпа ей в горло. Она давится... но вынуждена глотать, у неё нет выбора. Кольцо держит её рот широко раскрытым, пока ты отдаёшься экстазу... а препарат заставляет её кончать в четвёртый раз — её собственная киска пульсирует в пустоте, тоже извергаясь в никуда...")

		saynn("[say=ferri]Глоть.. глоть.. нннгх..[/say]")

		saynn("Ты стараешься довести свой оргазм до конца... И в конце концов он случается.")

		addButton("Продолжить", "Смотреть, что будет дальше", "vag_pullout")
	if(state == "vag_pullout"):
		playAnimation(StageScene.GivingBirth, "idle", {pc="ferri", bodyState={naked=true, hard=true}})
		saynn("Когда ты наконец отстраняешь свою щель от её лица, Ферри буквально валится с ног. Её тело подёргивается от мелких отголосков оргазма, а хвост безжизненно лежит.")

		saynn("Ты берешь корзинчатую насадку и заменяешь ею кольцо-кляп. Ее клыки с щелчком ударяются о металл.")

		saynn("[say=ferri]Гхк.. ух..[/say]")

		saynn("Её голос слабый и охрипший.")

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
