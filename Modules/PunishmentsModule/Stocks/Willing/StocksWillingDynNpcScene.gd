extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""

func _init():
	sceneID = "StocksWillingDynNpcScene"

func _initScene(_args = []):
	npcID = _args[0]
	var npc = GlobalRegistry.getCharacter(npcID)
	
	if(npc.getFlag(CharacterFlag.Introduced)):
		sawBefore = true
	else:
		npc.setFlag(CharacterFlag.Introduced, true)
	
	var personality:Personality = npc.getPersonality()
	if(personality.getStat(PersonalityStat.Mean) > 0.3 || personality.getStat(PersonalityStat.Subby) < -0.6):
		npcVariation = "mean"
	if(personality.getStat(PersonalityStat.Mean) < -0.3):
		npcVariation = "kind"
	if(personality.getStat(PersonalityStat.Subby) > 0.6 || personality.getStat(PersonalityStat.Coward) > 0.8):
		npcVariation = "subby"
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.StocksSexOral, "tease", {npc=npcID})

	if(state == ""):
		saynn(RNG.pick([
			"{npc.name} подходит к колодкам. {npc.He} явно заинтересована в твоих... подношениях.",
			"{npc.name} приближается к тебе. {npc.His} во все глаза разглядывает тебя.",
		]))

		if(npcVariation == "mean"):
			if(!sawBefore):
				saynn(RNG.pick([
					"[say=npc]Твою мать, еще одна сучка в колодках! Будешь послушной?[/say]",
					"[say=npc]Вижу сучку, которую пора наказать. Ну что, верно?[/say]",
					"[say=npc]Гляньте-ка, шлюху поймали. Пожалуй, я тебя проучу.[/say]",
				]))
			else:
				saynn(RNG.pick([
					"[say=npc]Помню эту шлюшью задницу. Будешь послушной?[/say]",
					"[say=npc]Таких сучек, как ты, нужно наказывать еще чаще. А?[/say]",
					"[say=npc]Смотрите-ка, шлюху снова поймали. Пожалуй, я тебя проучу.[/say]",
				]))
		elif(npcVariation == "kind"):
			if(!sawBefore):
				saynn(RNG.pick([
					"[say=npc]Привет. Не против, если я тебя... использую?[/say]",
					"[say=npc]Похоже, ты натворила дел. Можно мне с тобой кое-что сделать?[/say]",
					"[say=npc]Эй, что-то меня развезло... Можно?[/say]",
				]))
			else:
				saynn(RNG.pick([
					"[say=npc]О, я тебя знаю. Не против, если я тебя... использую?[/say]",
					"[say=npc]Я тебя помню. Можно мне с тобой кое-что сделать?[/say]",
					"[say=npc]Привет, дружище. Что-то меня возбуждает... Можно?[/say]",
				]))
		elif(npcVariation == "subby"):
			if(!sawBefore):
				saynn(RNG.pick([
					"[say=npc]О, привет... Можно мне..?[/say]",
					"[say=npc]Знаю, что не стоит спрашивать... Но можно?..[/say]",
					"[say=npc]Похоже, тебя нужно наказать... Может, мне это сделать?..[/say]",
				]))
			else:
				saynn(RNG.pick([
					"[say=npc]О, это ты... Можно мне, может быть..?[/say]",
					"[say=npc]Мне хочется немного поиграть с тобой... Можно?..[/say]",
					"[say=npc]Может, мне немного поиграть с тобой?..[/say]",
				]))
		else:
			if(!sawBefore):
				saynn(RNG.pick([
					"[say=npc]Может, развлечь тебя?[/say]",
					"[say=npc]Выглядишь довольно беззащитной. Хочешь, я немного тебя оттрахаю?[/say]",
					"[say=npc]Похоже, ты натворила дел. Интересно, стоит ли мне тебя трахнуть?[/say]",
				]))
			else:
				saynn(RNG.pick([
					"[say=npc]О, я помню эту задницу. Я бы оттрахал её снова.[/say]",
					"[say=npc]Привет. Знакомое личико. И задница. Интересно, стоит ли мне с тобой поиграть?[/say]",
					"[say=npc]Может, развлечь тебя?[/say]",
				]))

		addButton("Кивнуть", "Пусть делают, что хотят", "startsexsubby")
		addButton("Покачать головой", "Может, они тебя пощадят", "shake_head")

	if(state == "shake_head_success"):
		saynn(RNG.pick([
			"Ты качаешь головой настолько сильно, насколько позволяют колодки. Человек колеблется, но в итоге решает уйти, вместо того чтобы принуждать тебя.",
		]))
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

	if(state == "shake_head_fail"):
		saynn("Ты качаешь головой настолько, насколько позволяют колодки.")
		
		saynn(RNG.pick([
			"[say=npc]Ну, жаль. А я так возбужден.[/say]",
			"[say=npc]Твое «нет» прозвучало слишком фальшиво. Не обращай на меня внимания.[/say]",
			"[say=npc]Нет? А если я всё равно это сделаю?[/say]",
			"[say=npc]«Нет» меня не интересует, сучка.[/say]",
			"[say=npc]Всё равно ты не сможешь меня остановить.[/say]",
		]))
		
		addButton("Получи по полной", "Ну, что тут поделаешь...", "startsexsubby")

	if(state == "after_sex"):
		saynn("После этого {npc.he} просто оставляет тебя в покое, пока ты всё ещё торчишь в колодах.")

		# (scene ends)
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "startsexsubby"):
		getCharacter(npcID).prepareForSexAsDom()
		GlobalRegistry.getCharacter(npcID).addPain(-50)
		runScene("GenericSexScene", [npcID, "pc", SexType.StocksSex], "subbysex")

	if(_action == "shake_head"):
		if(npcVariation in ["subby", "kind"]):
			setState("shake_head_success")
			return
		
		if(npcVariation == "mean" && RNG.chance(50)):
			setState("shake_head_fail")
		elif(RNG.chance(25)):
			setState("shake_head_fail")
		else:
			setState("shake_head_success")
		return

	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex", "domsex"]):
		setState("after_sex")
	
			
func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["sawBefore"] = sawBefore
	data["npcVariation"] = npcVariation
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
