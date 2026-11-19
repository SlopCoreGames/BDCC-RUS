extends "res://Scenes/SceneBase.gd"

var npcID = ""

func _init():
	sceneID = "KidnapDynamicNpcScene"

func _initScene(_args = []):
	npcID = _args[0]
	#var npc = GlobalRegistry.getCharacter(npcID)
	
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

		var npc:BaseCharacter = GlobalRegistry.getCharacter(npcID)
		saynn("Вы сильно подорвали дух {npc.name}. Но это лишь первый шаг. Теперь вам нужно похитить {npc.him} и затащить в свою камеру, где вы сможете окончательно сломить {npc.him} и сделать {npc.him} своей рабыней.")
		
		saynn("Вы уверены, что хотите похитить {npc.name}?")
		
		if(npc.getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving)):
			if(getModule("NpcSlaveryModule").hasFreeSpaceToEnslave()):
				
				if(npc.hasEnslaveQuest()):
					addButton("Сделай это", "Сделать это", "do_kidnap")
				else:
					saynn("Каким рабом ты хочешь видеть {npc.him}?")
					
					for slaveTypeID in GlobalRegistry.getSlaveTypes():
						var theSlaveType:SlaveTypeBase = GlobalRegistry.getSlaveType(slaveTypeID)
						if(!theSlaveType.canEnslaveAs()):
							continue
						if(!theSlaveType.canTeach(getCharacter(npcID))):
							addDisabledButton(theSlaveType.getVisibleName(), "[color=red]Несовместимо с этой рабыней[/color]\n"+theSlaveType.getVisibleDesc())
							continue
						addButton(theSlaveType.getVisibleName(), theSlaveType.getVisibleDesc(), "do_kidnap", [slaveTypeID])
					
			else:
				addDisabledButton("Сделай это", "В вашей камере недостаточно места, чтобы пристроить их")
		else:
			addDisabledButton("Сделай это", "На них нет ошейника! Нельзя похищать людей, если их нельзя посадить на поводок")
		addButton("CANCEL", "Вы передумали", "endthescene")
		
	if(state == "do_kidnap"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcAction="hurt", npcBodyState={leashedBy="pc"}})
		
		saynn("{npc.name} сопротивляется, но вам почти удается защелкнуть поводок на ошейнике {npc.his}!")
		
		var npc = GlobalRegistry.getCharacter(npcID)
		var personality:Personality = npc.getPersonality()
		if(personality.getStat(PersonalityStat.Mean) > 0.4):
			saynn("[say=npc]"+RNG.pick([
				"Эй, какого хуя ты творишь?! Я тебе рожу в лепёшку разнесу, отпусти меня!",
				"Что это за хуйня? Я с тобой никуда не пойду, ни за что, отъебись!",
				"Эй, ты какого хуя делаешь? Я тебе ебало разобью, если думаешь, что я просто так за тобой пойду. Отпусти меня, кусок дерьма!",
				"Что это за хуйня? Я с тобой никуда не пойду, ни в коем случае. Просто отвали, дебил!",
				"О, просто фантастика. Думаешь, если наденешь поводок, я стану твоей марионеткой? Пошёл нахуй, я тебе не игрушка.",
				"Руки убрал! Ты вообще, блядь, кто такой? То, что ты меня на поводок посадил, не сделает из меня свою шавочку!",
				"Хорошая попытка с поводком, но я тебе не пленница. Ты ещё пожалеешь об этом, мудак.",
				"Ты реально думаешь, что если наденешь на меня поводок, я стану послушной? Ты бредишь. Отпусти, а то всё закончится очень хреново.",
				"Ты правда думал, что я подчинюсь только из-за поводка? Посчитай ещё раз. Отпусти меня, пока я не заставила тебя пожалеть об этом.",
				"Этот поводок нихера не изменит. Давай проясним раз и навсегда: я не слушаю приказы идиотов. Сними его с меня, тупица!",
			])+"[/say]")
		elif(personality.getStat(PersonalityStat.Subby) < -0.4):
			saynn("[say=npc]"+RNG.pick([
				"Ну надо же, что тут у нас? Решил поиграть в доминанта, а? Удачи, неудачник.",
				"Ой, как мило, ты думаешь, что поводок сделает меня покорной? Оставь свои любительские замашки для тех, кому не плевать.",
				"Это твоя попытка доминировать? Извини, но чтобы впечатлить меня, одного этого мало.",
				"Хорошая попытка, новичок. Поводок не делает тебя альфой. Тебе понадобится нечто большее, чем просто реквизит, чтобы совладать с такой, как я.",
				"Надеть поводок на доминанта? Это новый уровень тупости. Отпусти меня, пока я не потеряла терпение от твоего бреда.",
				"Впечатляющая попытка, но поводок ничего не изменит. Тебе еще многому предстоит научиться в искусстве доминирования. А теперь — отпусти меня.",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Эм, что происходит? Почему ты надеваешь на меня поводок? Я же ничего плохого не сделала. Пожалуйста, объясни...",
				"Я... я не думаю, что заслужила это. Зачем мне поводок? Может, мы сможем это обсудить?",
				"Ой, эм, я этого не ожидала. Зачем поводок? Я чем-то тебя рассердила? Пожалуйста, давай просто поговорим.",
				"Погоди, это обязательно? Я пойду за тобой, но поводок — это как-то слишком радикально. Можно сначала обсудить?",
				"Пожалуйста, мы же даже не знакомы. Отпусти меня, обещаю, я не буду доставлять хлопот!",
				"Я не понимаю... Зачем ты меня забираешь? Я сделаю всё, что захочешь, только не причиняй мне боли.",
				"Я не хочу проблем. Пожалуйста, отпусти меня. Обещаю, я никому не скажу!",
				"Кто ты такой и зачем это делаешь? Не верится, что это происходит наяву. Отпусти меня, я тебе не вещь!",
				"Что происходит? Куда ты меня тащишь? Мы же даже не знакомы! Отпусти меня, пожалуйста!",
			])+"[/say]")
		
		saynn("Пора возвращать {npc.him} в вашу камеру...")
		
		addButton("Притащить в камеру", "Пристроить раба", "bring_cell")
	
	if(state == "bring_cell"):
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={chains=[["normal", "neck", "scene", "floor"]]} })
		
		saynn("Несмотря на сопротивление {npc.his}, вы притаскиваете {npc.name} в свою камеру и приковываете {npc.him} цепью к полу.")
		
		var npc = GlobalRegistry.getCharacter(npcID)
		var personality:Personality = npc.getPersonality()
		if(personality.getStat(PersonalityStat.Mean) > 0.4):
			saynn("[say=npc]"+RNG.pick([
				"Что это, черт возьми, такое?",
				"Ты что, блядь, издеваешься?",
				"Серьезно? Это какой-то пиздец.",
				"Да ты, должно быть, ебёшься!",
				"Это что, какая-то больная шутка?",
				"Просто пиздец какой-то.",
				"Надеюсь, это всего лишь гребаный кошмар.",
				"Это ебануться можно, слов нет.",
			])+"[/say]")
		elif(personality.getStat(PersonalityStat.Subby) < -0.4):
			saynn("[say=npc]"+RNG.pick([
				"Серьезно? Для тебя это плохо кончится.",
				"Ты это сейчас серьезно?",
				"Что это, черт возьми, такое?",
				"Да ты, должно быть, издеваешься.",
				"Это что, какая-то ебанутая шутка?",
				"Это, по-твоему, весело?",
				"У меня нет времени на твое дерьмо.",
				"Невероятно.",
				"Ты совсем ебнулся, что ли?",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Эм... где я?",
				"Эй, что тут происходит?",
				"А... почему я здесь?",
				"Эй... зачем ты меня сюда притащил?",
				"Эй, отпусти меня!",
				"Эм... ты кто такой?",
				"Эй, это вообще не дело.",
				"А... это как-то неправильно.",
			])+"[/say]")
		
		saynn("Теперь {npc.he} принадлежит тебе! Главное — следи, чтобы {npc.he} не сбежала.")
		
		addButton("Продолжить", "Отличная работа", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "do_kidnap"):
		GM.pc.getReputation().addRep(RepStat.Alpha, 0.2)
		GM.pc.getReputation().handleSpecialEvent("enslavesomeone")
		if(_args.size() > 0):
			getModule("NpcSlaveryModule").doEnslaveCharacter(npcID, _args[0])
		else:
			getModule("NpcSlaveryModule").doEnslaveCharacter(npcID)


	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
