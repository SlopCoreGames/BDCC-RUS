extends RecruitSceneBase

var condomType = ""
var condomUsed = false
var condomBroke = false
var straponUsed = false

func _init():
	sceneID = "ElizaRecSceneSexBreathplay"

func _reactInit():
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.Body)
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearTop)
	getCharacter("eliza").getInventory().clearSlot(InventorySlot.UnderwearBottom)
	putOn("eliza", "LatexStraitjacket")
	putOn("eliza", "oldcollar")

func _run():
	if(state == ""):
		condomType = extra("condom", "no")
		condomUsed = (condomType != "no")
		straponUsed = (extra("strapon", "") != "")
		addCharacter("eliza", ["naked"])
		aimCameraAndSetLocName("hideout_breakroom")
		playAnimation(StageScene.Duo, "stand", {npc="eliza"})
		saynn("Ты входишь в холодную камеру. Элиза всё ещё прикована цепями к трубе над головой. На ней всё та же смирительная рубашка из её психиатрической лечебницы. Грудь обнажена, её собственные связанные руки приподнимают её. На талии застегнут металлический пояс целомудрия... пояс, ключ от которого всё ещё у тебя.")

		saynn("Она сверлит тебя взглядом.")

		saynn("[say=pc]"+str(ch1("...", "Hey there, slut.", "Getting used to it, I see."))+"[/say]")

		saynn("Элиза ничего не отвечает, лишь сверлит тебя глазами. Ты подходишь к ней, сжимая в руке маленький ключик.")

		saynn("Ты вставляешь его в замок пояса целомудрия и поворачиваешь. Раздается щелчок, вся конструкция отпирается и с тяжелым лязгом падает на пол, обнажая тугую, аппетитную киску Элизы.")

		saynn("Её дыхание сбивается, веки слегка подергиваются. Кажется, она знает, что будет дальше. Она дергается на цепях... но те не дают ей ни малейшей свободы, оставляя её совершенно беспомощной перед тобой.")

		saynn("[say=eliza]Что бы это ни было... просто покончи с этим...[/say]")

		saynn("[say=pc]"+str(ch1("...", "With pleasure.", "You don't get a say in this, slave."))+"[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "straight_to_sex")
	if(state == "straight_to_sex"):
		playAnimation(StageScene.SexChoke, "sex", {npc="eliza", bodyState={exposedCrotch=true,hard=true}})
		if (!straponUsed):
			saynn("В следующее мгновение Элиза уже на полу, прижатая спиной к холодному камню. Ты задрал одну из её ног высоко вверх, полностью раскрывая её перед собой. Твой {pc.penis} твердый и наготове... и ты не ждешь... ты входишь в её киску без смазки, на сухую.")

		else:
			saynn("В следующее мгновение Элиза уже на полу, прижатая спиной к холодному камню. Ты задрал одну из её ног высоко вверх, полностью раскрывая её перед собой. Твой заранее смазанный страпон уже закреплен на талии... и ты не ждешь... ты входишь в её киску.")

		saynn("[say=eliza]Ннх... чертов зверь...[/say]")

		if (!straponUsed):
			saynn("Она довольно узкая, её внутренние стенки тут же пытаются сопротивляться, сжимаясь вокруг тебя. Они сдавливают и обхватывают твой член, словно пытаясь вытолкнуть его наружу. Но у них не получается.")

		else:
			saynn("Она довольно узкая... ты не чувствуешь этого напрямую, но трение очень сильное: её внутренние стенки тут же пытаются сопротивляться, сжимаясь вокруг резиновой игрушки. Они сдавливают и обхватывают твой член, словно пытаясь вытолкнуть его наружу. Но у них не получается.")

		saynn("Ты начинаешь трахать её. Медленными, глубокими толчками... не сводя глаз. Твоя свободная рука ныряет к её шее, пальцы обхватывают горло. Ты сжимаешь его — ровно настолько, чтобы она почувствовала себя твоей собственностью.")

		saynn("[say=pc]"+str(ch1("...", "Take it, you fucking bitch.", "You like that, don't you? Fucking slut."))+"[/say]")

		saynn("[say=eliza]Кхх-х.. хх..[/say]")

		saynn("Её глаза расширяются, дыхание становится прерывистым. Ты чувствуешь, как под твоей ладонью бешено колотится её пульс. Ты трахаешь её сильнее, и кончик"+str(" your cock" if !straponUsed else " the rubber shaft")+" проникает глубоко, достигая самого входа в её матку.")

		saynn("Тело Элизы начинает дрожать. Из её горла вырываются тихие, сдавленные звуки, её киска становится всё влажнее, а стенки пульсируют вокруг тебя.")

		addButton("Продолжить", "Смотреть, что будет дальше", "sex_faster")
	if(state == "sex_faster"):
		playAnimation(StageScene.SexChoke, "fast", {npc="eliza", bodyState={exposedCrotch=true,hard=true}})
		saynn("Ты ускоряешься, вколачиваясь в её узкую щель. Звук твоих бедер, шлепающих по её влажной плоти, наполняет маленькую камеру.")

		saynn("[say=eliza]Б-блядь.. ты.. хх..[/say]")

		saynn("Ты усиливаешь хватку на её горле... пока она не перестает издавать звуки. Её рот открыт... но из него вырывается лишь беззвучный стон. Её щеки стремительно краснеют.")

		saynn("[say=eliza]..[/say]")

		saynn("Внезапно её тело выгибается над полом, она корчится и дрожит. Её киска с силой сжимается вокруг тебя.. пульсируя волнами. Она пытается откинуть голову назад.. но ты крепко держишь её только для себя.")

		saynn("Даже когда она занята оргазмом, ты продолжаешь вколачивать свой член в её крошечную щелочку, наслаждаясь её теснотой. Однако её взгляд становится всё слабее и слабее — кислород стремительно заканчивается.")

		if (!straponUsed):
			addButton("Кончить внутрь", "Оплодотвори эту кошечку", "cum_inside")
		else:
			addButton("Продолжить", "Смотреть, что будет дальше", "cum_inside")
	if(state == "cum_inside"):
		playAnimation(StageScene.SexChoke, "inside", {npc="eliza", pcCum=!straponUsed, cum=!straponUsed, bodyState={exposedCrotch=true,hard=true}})
		if (!straponUsed):
			saynn("Когда Элиза станет достаточно слабой.. именно тогда ты наконец вонзаешь свой член до самого конца, зарываясь им по самую основу! Мгновение спустя.. ты кончаешь.")

			saynn("Твой {pc.penis} начинает пульсировать внутри неё, закачивая горячее семя глубоко внутрь, наполняя её матку до краев. Стенки её киски всё так же сильно сжимаются, доя твои яйца и вытягивая из тебя каждую последнюю каплю {pc.cum}.")

			saynn("[say=pc]"+str(ch1("...", "Take my cum, you whore.", "This is all that you're good for."))+"[/say]")

			saynn("Ты замираешь там, глубоко внутри.. пока не закончишь. Затем ты разжимаешь пальцы на её горле.")

		else:
			saynn("Когда Элиза станет достаточно слабой.. именно тогда ты вгоняешь страпон до самого конца, зарывая его по самую основу!")

			saynn("Бедная кошечка корчится изо всех сил, прижатая обоими: твоей рукой и твоим резиновым членом. Стенки её киски всё так же сильно сжимаются, пытаясь подоить твою игрушку.")

			saynn("[say=pc]"+str(ch1("...", "Such a fucking whore.", "This is all that you're good for."))+"[/say]")

			saynn("Ты замираешь там, глубоко внутри.. пока она не кончит. Затем ты разжимаешь пальцы на её горле.")

		saynn("[say=eliza]Кхх-хх..[/say]")

		saynn("Элиза судорожно вдыхает... один глубокий вдох... а затем её начинает сотрясать сильный кашель, всё тело дрожит. Ну и зрелище.")

		addButton("Вытащить", "Хватит душить её", "do_pull_out")
	if(state == "do_pull_out"):
		playAnimation(StageScene.SexChoke, "tease", {npc="eliza", bodyState={exposedCrotch=true,hard=true}})
		if (!straponUsed):
			saynn("Ты выходишь... позволяя её щелочке залиться твоим {pc.cum}.")

		else:
			saynn("Ты вынимаешь игрушку... заставляя её влажную щелочку на мгновение широко раскрыться.")

		saynn("[say=eliza]Кхх.. хгхх.. ф-фхх..[/say]")

		saynn("Кошечка всё ещё очень... занята. Но это не мешает тебе поднять пояс верности и снова надеть его на неё. Ты защелкиваешь замок."+str(", trapping all the seed inside" if !straponUsed else "")+".")

		saynn("Ты смотришь на неё — она всё ещё кашляет на полу. Жалкое зрелище.")

		saynn("Пора уходить.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "straight_to_sex"):
		if(straponUsed):
			recWearStrapon()
		putOff("eliza", "LatexStraitjacket")
		putOn("eliza", "LatexStraitjacketNoBelt")

	if(_action == "cum_inside"):
		if(straponUsed):
			getCharacter("eliza").cummedInVaginaBy("pc", FluidSource.Strapon)
		else:
			getCharacter("eliza").cummedInVaginaBy("pc", FluidSource.Penis)
		GM.pc.orgasmFrom("eliza")

	if(_action == "endthescene"):
		recRemoveStrapons()
		putOff("eliza", "LatexStraitjacketNoBelt")
		putOn("eliza", "LatexStraitjacket")
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()

	data["condomType"] = condomType
	data["condomUsed"] = condomUsed
	data["condomBroke"] = condomBroke
	data["straponUsed"] = straponUsed

	return data

func loadData(data):
	.loadData(data)

	condomType = SAVE.loadVar(data, "condomType", "")
	condomUsed = SAVE.loadVar(data, "condomUsed", false)
	condomBroke = SAVE.loadVar(data, "condomBroke", false)
	straponUsed = SAVE.loadVar(data, "straponUsed", false)
