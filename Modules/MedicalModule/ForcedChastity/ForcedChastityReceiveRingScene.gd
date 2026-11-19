extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "ForcedChastityReceiveRingScene"

func _run():
	
	if(state == ""):
		saynn("Сон был вполне неплохим. Наконец-то исчез этот страх, что ты проснешься где-то в другом месте. Но, открыв глаза, ты понимаешь, что кто-то оставил на твоей подушке несколько вещей.")

		saynn("Ты поднимаешься, чтобы рассмотреть их получше. Одна из вещей кажется... кольцом? Да, похоже на обычное металлическое кольцо на палец. А рядом лежит записка.")

		addButton("Прочитать записку", "Посмотреть, что там написано", "read_note")

	if(state == "read_note"):
		saynn("\"Прими этот подарок как скромный знак моей признательности. Надеюсь, он станет хорошим напоминанием о твоем выборе <3.\n\n— Доктор Куинн\"")

		saynn("Хм. Даже мило. Она также оставила чип с кредитами. Ты берешь кольцо и готовишься к новому дню.")

		# (scene ends)

		addButton("Продолжить", "Хм", "endthescene")
		


func _react(_action: String, _args):
	if(_action == "read_note"):
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("RingOfDevotion"))
		GM.pc.addCredits(10)
		addMessage("You received a ring and 10 credits")

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func getDevCommentary():
	return "If you haven't realized it yet.. the ring is made out of the broken key x3. I hinted at it in Rahi's content, Eliza gave the pieces to Alex and he melted them and created a ring for you ^^. No one mentioned that, maybe I should have been even more obvious.. or not.. dunnyo.. If you realized that before reading this - good job ^^"

func hasDevCommentary():
	return true
