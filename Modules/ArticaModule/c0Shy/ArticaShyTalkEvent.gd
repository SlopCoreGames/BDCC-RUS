extends EventBase

func _init():
	id = "ArticaShyTalkEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "hall_canteen")
	es.addTrigger(self, Trigger.EnteringRoom, "cellblock_lilac_nearcell")

func run(_triggerID, _args):
	if(_args[0] == "cellblock_lilac_nearcell"):
		if(getFlag("ArticaModule.s0happened") && !getFlag("ArticaModule.s1happened")):
			addButtonUnlessLate("Белый пух", "Поискать ту новенькую", "search")
		
		if(getFlag("ArticaModule.s1happened") && !getFlag("ArticaModule.s2happened")):
			if(GM.main.getDays() > getFlag("ArticaModule.s1day", -1)):
				addButtonUnlessLate("Белый пух", "Поискать ту новенькую", "c2scene")
			else:
				addDisabledButton("Белый пух", "Охранник стоит у камеры этого пушистика. Лучше зайти в другой раз")
	else:
		if(getFlag("ArticaModule.s2happened") && !getFlag("ArticaModule.s3happened")):
			addButtonUnlessLate("Белый пух", "Кажется, она здесь", "s3scene")
		if(getFlag("ArticaModule.s3happened") && !getFlag("ArticaModule.s4happened")):
			if(GM.main.getDays() > getFlag("ArticaModule.s3day", -1)):
				addButtonUnlessLate("Артика", "Присоединиться к белому пуху", "s4scene")
			else:
				addDisabledButton("Артика", "Навестить её завтра")
		if(getFlag("ArticaModule.s4happened") && !getFlag("ArticaModule.s5happened")):
			addButtonUnlessLate("Артика", "Присоединиться к белому пуху", "s5scene")
		
		if(getFlag("ArticaModule.s5happened") && !getFlag("ArticaModule.corruptionBegan")):
			if(GM.main.getDays() > getFlag("ArticaModule.s5day", -1)):
				if(getFlag("ArticaModule.s6GrabbedThroat")):
					addButtonUnlessLate("Артика", "Присоединиться к белому пуху", "s7scene")
				else:
					addButtonUnlessLate("Артика", "Присоединиться к белому пуху", "s6scene")
			else:
				addDisabledButton("Артика", "Навестить её завтра")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "search"):
		setFlag("ArticaModule.s1happened", true)
		setFlag("ArticaModule.s1day", GM.main.getDays())
		runScene("articaS1CellblockScene")

	if(_method == "c2scene"):
		setFlag("ArticaModule.s2happened", true)
		runScene("articaS2HungryScene")

	if(_method == "s3scene"):
		setFlag("ArticaModule.s3happened", true)
		setFlag("ArticaModule.s3day", GM.main.getDays())
		runScene("articaS3CanteenScene")

	if(_method == "s4scene"):
		setFlag("ArticaModule.s4happened", true)
		runScene("articaS4CanteenScene")

	if(_method == "s5scene"):
		setFlag("ArticaModule.s5happened", true)
		setFlag("ArticaModule.s5day", GM.main.getDays())
		runScene("articaS5CanteenPawsScene")

	if(_method == "s6scene"):
		runScene("articaS6CanteenTalkScene")

	if(_method == "s7scene"):
		setFlag("ArticaModule.corruptionBegan", true)
		runScene("articaS7FirstShowerScene", [true])
	
	
