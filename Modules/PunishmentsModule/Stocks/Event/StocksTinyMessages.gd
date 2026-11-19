extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "StocksTinyMessages"

func _reactInit():
	setState(RNG.pick(["1", "2", "3", "4"]))
	
func _run():
	if(state == "1"):
		saynn("Мимо проходит охранник. На мгновение его взгляд определенно зацепился за тебя, но он быстро продолжает свой патруль.")
	if(state == "2"):
		saynn("Охранник останавливается и, потирая подбородок, пристально смотрит на тебя. Из-за пут ты не можешь даже пошевелиться.")
	if(state == "3"):
		saynn("Мимо проходит сотрудник в желтой униформе. За ним семенят несколько заключенных с ящиками — похоже, они направляются в столовую.")
	if(state == "4"):
		saynn("Мимо проходит сиреневоволосая девчонка и самодовольно ухмыляется тебе.")
		
	addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

