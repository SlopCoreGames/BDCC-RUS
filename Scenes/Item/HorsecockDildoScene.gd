extends SceneBase

var hadContents = false
var isPussy = false
var uniqueItemID = ""

func _init():
	sceneID = "HorsecockDildoScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]

func _run():
	if(state == ""):
		playAnimation(StageScene.HorsecockDildoSex, "tease", {bodyState={naked=true}})
		saynn("В твоих руках увесистая секс-игрушка — то самое, что красуется между ног у каждого альфа-самца. Ты осторожно ставишь её на пол и прижимаешь присоску, чтобы она намертво зафиксировалась. Размер впечатляет. От того, как она слегка покачивается, у тебя уже начинает всё внутри сладко ныть...")

		saynn("В какую дырочку хочешь его засунуть?")

		addButtonWithChecks("В киску", "Насаживаться на него киской", "ride_pussy", [], [ButtonChecks.HasReachableVagina])
		addButtonWithChecks("В анус", "Насаживаться на него попой", "ride_anus", [], [ButtonChecks.HasReachableAnus])
		addButton("Отмена", "Вы передумали", "endthescene")
	#if(state == "Ignore"):
	#	addButton("pussy", "asd", "ride_pussy")
	#	addButton("anus", "asd", "ride_anus")
	if(state == "begin_riding"):
		playAnimation(StageScene.HorsecockDildoSex, "inside", {bodyState={naked=true}})
		saynn("Ты наклоняешься к игрушке и несколько раз плюешь на её плоский наконечник, а затем размазываешь слюну руками. Даже от одной этой подготовки тебя начинает потряхивать от возбуждения. Но хватит прелюдий...")

		saynn("Пора пробовать. Ты устраиваешься над гигантским резиновым лошадиным членом и начинаешь медленно опускаться на него, направляя расширяющийся кончик своей "+str("{pc.pussyStretch} pussy" if isPussy else "{pc.analStretch} tailhole")+". Из-за невероятной толщины сразу понятно: твоему телу понадобится небольшое... убеждение, чтобы впустить эту махину внутрь.")

		saynn("Первые попытки не слишком удачны, твоя "+str("щель киски" if isPussy else "анальное кольцо")+" изо всех сил пытается растянуться, чтобы принять его. Но ты не сдаешься, постепенно увеличивая давление с помощью своей "+str("crotch" if isPussy else "butt")+". Оно еще не внутри, но ты отчетливо чувствуешь, как сильно оно тебя растягивает, и мысли, рождающиеся в голове, невероятно возбуждают...")

		addButton("Продолжить", "Смотреть, что будет дальше", "begin_penetration")
	if(state == "begin_penetration"):
		playAnimation(StageScene.HorsecockDildoSex, "sex", {bodyState={naked=true}})
		saynn("После нескольких попыток твои движения становятся всё смелее; расширенная головка растягивает твою жаждущую дырочку, пока ты наконец не чувствуешь, как она скользит внутрь, зарываясь в твою "+str("slit" if isPussy else "ass")+".")

		saynn("Оно мгновенно надавливает на твою точку удовольствия, вызывая волну мощных ощущений. Но ты не останавливаешься — ты начинаешь прыгать на этом резиновом дилдо, заставляя его проникать всё глубже в твою "+str("pussy" if isPussy else "butt")+" каждый раз.")

		if (GM.pc.hasPenis()):
			saynn("Твой {pc.penis} так сильно затвердел от прилива крови к паху, что с кончика вовсю течет предэякулят.")

		if (!isPussy && GM.pc.hasReachableVagina()):
			saynn("Твоя заброшенная киска капает возбуждением на тяжелые на вид яички игрушки. Толщины достаточно, чтобы давить на твою точку G через мягкие стенки задницы.")

		saynn("Внутри оно кажется таким огромным; с твоих губ срываются невольные стоны, пока ты используешь этот резиновый венозный ствол, чтобы растянуть себя. Каждый раз, когда ты опускаешься на него, на твоем животе проступает милый бугорок — очертание члена.")

		saynn("Кульминация близка; ты сосредотачиваешься на своем теле и ощущениях, позволяя страстным звукам вырываться из твоих уст.")

		addButton("Кончай!", "Скачи на нем, пока не достигнешь пика", "do_cum")
	if(state == "do_cum"):
		playAnimation(StageScene.HorsecockDildoSex, "fast", {pcCum=true, bodyState={naked=true, hard=true}})
		saynn("Ты начинаешь ебашить на этом лошачьем члене, то вздымая таз вверх, то с силой опускаясь на толстый ствол, заглатывая расширенный кончик так глубоко, насколько позволяет тело, и даже глубже.")

		if (!isPussy && GM.pc.hasPenis()):
			saynn("Эта игрушка просто охеренная: она так нещадно долбит в простату, что твоя {pc.penis} течет по всему полу. Ты чувствуешь, что финиш уже совсем близко, и это ощущение нарастает всё быстрее, чем яростнее ты скачешь на этом члене.")

		else:
			saynn("Эта игрушка просто охеренная: она с легкостью нажимает на все твои эрогенные кнопки. Ты чувствуешь, что финиш уже совсем близко, и это ощущение нарастает всё быстрее, чем яростнее ты скачешь на этом члене.")

		if (GM.pc.hasPenis()):
			saynn("Все твое тело напрягается; ты насаживаешься на этот ствол так глубоко, как только можешь, и выгибаешь спину, страстно стоная, пока твой член выпускает слабую струю {pc.cum} за струей. Этот мокрый оргазм настолько сильный, что у тебя закатываются глаза.")

		elif (GM.pc.hasReachableVagina()):
			saynn("Все твое тело напрягается; ты насаживаешься на этот ствол так глубоко, как только можешь, и выгибаешь спину, страстно стоная, пока твоя киска заливает игрушку сквиртом. Оргазм настолько мощный, что у тебя закатываются глаза.")

		else:
			saynn("Все твое тело напрягается; ты насаживаешься на этот ствол так глубоко, как только можешь, и выгибаешь спину, страстно стоная. Оргазм настолько мощный, что у тебя закатываются глаза.")

		saynn("Твоя "+str("pussy" if isPussy else "tailhole")+" начинает пульсировать вокруг толстого резинового члена, а растянутая дырка отчаянно пытается выдоить его, пока тебя не перестает трясти и колотить крупной дрожью.")

		if (hadContents):
			saynn("Твои внутренние стенки так сильно сжимают толстый лошачий член, что он внезапно начинает пульсировать внутри тебя, прежде чем [b] извергнуть всё своё содержимое прямо в твою "+str("pussy" if isPussy else "ass")+"[/b].")

		addButton("Продолжить", "Смотреть, что будет дальше", "afterglow")
	if(state == "afterglow"):
		playAnimation(StageScene.HorsecockDildoSex, "inside", {bodyState={naked=true}})
		saynn("Блаженство. Океан удовольствия. Твой разум едва справляется с этим безумием ощущений. Игрушка почти полностью внутри тебя, если не считать яиц, достойных настоящего жеребца. Даже когда ты перестаешь насаживаться на неё и просто пытаешься отдохнуть, из тебя всё равно вырываются случайные стоны. Послевкусие настолько сильное, что ты пускаешь слюни, пытаясь отдышаться.")

		saynn("В конце концов похоть утихает, сменяясь гиперчувствительностью. Твоя "+str("slit" if isPussy else "tailhole")+" отчаянно пытается сомкнуться, вызывая дискомфорт. На сегодня веселья достаточно. Ты медленно поднимаешь тело, пока расширенный кончик не издает сочный шлепающий звук, оставляя твою разверстую дырку сиять от влаги."+str("Ты несколько раз сжимаешься, пока задница не сомкнется." if !isPussy else "Ты ждешь немного, пока киска не закроется.")+"")

		addButton("Продолжить", "Приятно", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "ride_pussy"):
		isPussy = true
		setState("begin_riding")
		GM.pc.addLust(50)
		return

	if(_action == "ride_anus"):
		isPussy = false
		setState("begin_riding")
		GM.pc.addLust(50)
		return

	if(_action == "begin_penetration"):
		processTime(60*5)
		GM.pc.addLust(50)
		if(isPussy):
			GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina, 50)
		else:
			GM.pc.gotOrificeStretchedWith(BodypartSlot.Anus, 50)

	if(_action == "do_cum"):
		processTime(5*60)
		if(isPussy):
			GM.pc.gotOrificeStretchedWith(BodypartSlot.Vagina, 50)
		else:
			GM.pc.gotOrificeStretchedWith(BodypartSlot.Anus, 50)
		var item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item.getFluids() != null && !item.getFluids().isEmpty()):
			hadContents = true
			if(isPussy):
				item.getFluids().transferTo(GM.pc.getBodypart(BodypartSlot.Vagina), 1.0)
			else:
				item.getFluids().transferTo(GM.pc.getBodypart(BodypartSlot.Anus), 1.0)
		GM.pc.orgasmFrom("pc")

	if(_action == "afterglow"):
		processTime(6*60)

	setState(_action)

func saveData():
	var data = .saveData()

	data["hadContents"] = hadContents
	data["isPussy"] = isPussy
	data["uniqueItemID"] = uniqueItemID

	return data

func loadData(data):
	.loadData(data)

	hadContents = SAVE.loadVar(data, "hadContents", false)
	isPussy = SAVE.loadVar(data, "isPussy", false)
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
