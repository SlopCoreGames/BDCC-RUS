extends SubGameWorld

func _on_ScriptedRoom_onEnter(room: GameRoom):
	#room.clearScreen()
	
	room.say("Мяу")
	room.addButton("Мяукать", "Поболтать с мяу", "wut")
	
	#room.runScene("TestScene")


func _on_ScriptedRoom_onReact(room: GameRoom, key):
	if(key == "wut"):
		room.say("yap")
		room.addButton("Мяукать больше", "Поболтать с мяу", "wut")
		room.addButton("Назад", "Поболтать с мяу", "wut2")
		room.addButton("начать сцену", "Поболтать с мяу", "wut3")
		room.addButton("начать драку", "Драться", "wut4")
		if(GM.pc.getPain() > 0):
			room.addButton("похлебать чайку", "Лечит", "wut5")
		else:
			room.addDisabledButton("похлебать чайку", "Ты и так здоров")
	if(key == "wut2"):
		#GM.pc.breasts.size = BodypartBreasts.BreastsSize.A
		#GM.pc.updateAppearance()
		GM.main.reRun()
	if(key == "wut3"):
		room.runScene("TestScene")
	if(key == "wut4"):
		room.runScene("FightScene", ["testchar"])
	if(key == "wut5"):
		room.say("Ты отхлебнул чаю и почувствовал себя лучше")
		GM.pc.addPain(-10)
		room.addButton("Продолжить", "Поболтать с мяу", "wut")
