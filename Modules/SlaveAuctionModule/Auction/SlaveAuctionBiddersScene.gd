extends SceneBase

func _init():
	sceneID = "SlaveAuctionBiddersScene"

func _run():
	if(state == ""):
		saynn("У следующих участников аукциона будут такие предпочтения:")

		saynn(""+str(getModule("SlaveAuctionModule").getBidderInfo())+"")

		addButton("Закрыть", "Достаточно подглядывать", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)
