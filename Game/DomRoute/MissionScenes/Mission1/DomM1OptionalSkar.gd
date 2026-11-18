extends SceneBase

func _init():
	sceneID = "DomM1OptionalSkar"

func _run():
	if(state == ""):
		addCharacter("skar")
		playAnimation(StageScene.Solo, "stand", {pc="skar"})
		saynn("Ты высовываешься из-за угла и видишь дверь, которая, скорее всего, ведет в какой-то большой кабинет! Эта выглядит иначе, чем остальные... гораздо роскошнее и защищеннее. Вероятно, это кабинет капитана. Если войти туда прямо сейчас, тебя наверняка вышвырнут в открытый космос.")

		saynn("Дверь всё равно кажется запертой... к тому же её охраняет какой-то злобный тип. Он тебя пока не заметил.")

		saynn("Наверное, лучше к нему не приближаться... если только ты не хочешь с ним подраться.")

		saynn("(( Повторное приближение к нему запустит необязательную сложную стычку. ))")

		addButton("Уйти", "Сделать шаг назад", "endgoback")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "endgoback"):
		endScene()
		GM.pc.setLocation("cd_last_intersection")
		return

	setState(_action)
