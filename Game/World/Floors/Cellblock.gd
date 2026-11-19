extends SubGameWorld


func _on_CBStairs1_onEnter(room):
	room.addButton("Вверх", "Подняться в главный зал", "goup")

func _on_CBStairs1_onReact(_room, key):
	if(key == "goup"):
		GM.pc.setLocation("main_stairs1")
		GM.main.reRun()


func _on_CBStairs2_onEnter(room):
	room.addButton("Вверх", "Подняться в главный зал", "goup")


func _on_CBStairs2_onReact(_room, key):
	if(key == "goup"):
		GM.pc.setLocation("main_stairs2")
		GM.main.reRun()


func _on_CellblockRoom11_onEnter(_room):
	pass


func _on_CellblockRoom11_onReact(_room, key):
	if(key == "stash"):
		_room.runScene("PlayerStashScene")
		
	if(key == "rest"):
		_room.runScene("RestingInCellScene")
		#GM.pc.addStamina(100)
		#GM.main.addMessage("You had a good rest")
		#GM.main.reRun()
		
	if(key == "over"):
		GM.main.overridePC()
		GM.pc.updateAppearance()
		GM.pc.updateNonBattleEffects()
		GM.main.reRun()
		
	if(key == "clearover"):
		GM.main.clearOverridePC()
		GM.pc.updateAppearance()
		GM.pc.updateNonBattleEffects()
		GM.main.reRun()
		
	if(key == "flashback"):
		_room.runScene("PCOverrideExample")

func _on_CellblockRoom11_onPreEnter(room):
	if(GM.pc.getLocation() == GM.pc.getCellLocation()):
		room.roomDescription = "Твоя камера — ничего особенного. Автоматическая дверь, которой можно управлять дистанционно, и бронированное окно, сквозь которое всё видно. Стены сделаны из какого-то металла: если ударить по ним ложкой, останется лишь заметная царапина. По крайней мере, здесь светло."
		room.roomDescription += "\n\n"
		room.roomDescription += "В углу стоит жесткая кровать и табурет — вот и всё, что тебе положено. Здесь можно отдохнуть или спрятать что-нибудь, чтобы не потерять вещи во время личного досмотра."
		
		room.roomName = "Моя камера"
		
		room.addButton("Заначка", "В своей камере можно что-нибудь спрятать", "stash")
		
		if(!GM.main.playerHasCompanions()):
			room.addButton("Отдохнуть", "Прилечь на кровать", "rest")
		# Debug testing, free to remove
		#room.addButton("Перезапись", "Перезаписать ПК", "over")
		#room.addButton("Очистить", "Очистить ПК", "clearover")
		#room.addButton("Тестовое воспоминание", "Тест", "flashback")
	else:
		room.roomDescription = "Это не твоя камера"
		room.roomName = "Камера"
