extends SceneBase

var queueSize = 3

func _init():
	sceneID = "SlutwallPlayerScene"

func _initScene(_args = []):
	if(_args.size() > 0 && _args[0]):
		setState("trapped")
		if(_args.size() > 1):
			queueSize = _args[1]

func _run():
	if(state == ""):
		saynn("Ты стоишь у стены. Но это не обычная стена. В ней есть... дыры... целый ряд дыр; некоторые достаточно велики, чтобы в них пролез человек, а в другие, скорее всего, можно просунуть только руку или ногу...")

		saynn("Это явно шлюх-стена — место, где заключенные наказывают других заключенных... или вознаграждают их, смотря что тебе больше по душе.")

		saynn("Хочешь добровольно залезть в шлюх-стену? Если сделаешь это, заключенные тебя точно %%will%% используют.")

		addButton("Используй меня!", "Звучит весело", "get_into_wall")
		addButton("Отмена", "Неа. Ты не по части свободного использования", "endthescene")
	if(state == "get_into_wall"):
		playAnimation(StageScene.Slutwall, "idle", {bodyState={naked=true, hard=true}})
		saynn("Тебе становится любопытно... И ты начинаешь расспрашивать заключенных о том, как работает эта стена. И чем больше ты спрашиваешь, тем сильнее они начинают беситься, пока в конце концов просто не хватают тебя и силой не заталкивают в одну из дыр!")

		saynn("Твои запястья и лодыжки приковывают к стене, а промежность оказывается на всеобщем обозрении. Кто-то быстро черкает рядом с тобой: \"Раздражающая шлюха! Свободное использование!\". Очередь из "+str(queueSize)+" заключенных уже начинает выстраиваться за твоей спиной...")

		saynn("Ой...")

		addButton("Продолжить", "Смотреть, что будет дальше", "trapped")
	if(state == "trapped"):
		playAnimation(StageScene.Slutwall, "idle", {bodyState={naked=true, hard=true}})
		saynn("Ты всё еще торчишь в шлюх-стене. Там "+str("is" if queueSize == 1 else "are")+" "+str(queueSize)+"заключенных осталось в очереди.")

		addButton("Продолжить", "Смотри, что будет дальше...", "generate_next")
	if(state == "isFree"):
		playAnimation(StageScene.Solo, "stand")
		saynn("После того как каждый успел попользоваться твоим телом, тебя наконец-то освобождают!")

		saynn("Вау, пожалуй, после всего этого лучше всё-таки избегать взглядов в глаза...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "get_into_wall"):
		queueSize = RNG.randi_range(3,6)

	if(_action == "generate_next"):
		processTime(RNG.randi_range(2, 10)*60)
		if(queueSize <= 0):
			setState("isFree")
			return
		queueSize -= 1
		
		GM.pc.lustStateFullyUndress()
		var npcID = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [], InmateGenerator.new(), {})
		runScene("GenericSexScene", [npcID, "pc", SexType.SlutwallSex, {SexMod.DisableDynamicJoiners:true}], "generic_sex_scene")
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "generic_sex_scene"):
		if(RNG.chance(20)):
			GM.pc.addCredits(1)
			addMessage("Someone decided to put 1 credit into the tip box after using you")

func saveData():
	var data = .saveData()

	data["queueSize"] = queueSize

	return data

func loadData(data):
	.loadData(data)

	queueSize = SAVE.loadVar(data, "queueSize", 3)

func getDevCommentary():
	return "This scene was put together very quickly just so the player would have access to the slutwall. Otherwise the only way to see this stuff is Avy's final arena fight quest.\n\nDunno really how to expand it. This is just another one of those punishment scenes. But I can't come up with anything interesting x3. How does one add a progression system to the slutwall x3. You earn more the more you do it? Kinda eh. Maybe there could be unique scenes randomly happening that start a quest or something, dunno."

func hasDevCommentary():
	return true
