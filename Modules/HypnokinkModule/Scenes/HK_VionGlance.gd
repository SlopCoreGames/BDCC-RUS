extends SceneBase

func _init():
	sceneID = "VionGlance"

func _run():
	if(state == ""):
		addCharacter("vion")
		playAnimation(StageScene.Duo, "stand", {npc="vion", npcAction="walk", flipNPC= true, further=true})
		saynn("Краем глаза ты замечаешь какой-то блеск. Оглядевшись в поисках источника, ты натыкаешься на заключенного в сиреневой робе; на нем были старые очки, в которых, должно быть, отразился свет потолочных ламп. Кто вообще сейчас носит очки? Он о чем-то увлеченно болтает с другим заключенным.")

		saynn("[say=vion]...и если захочешь освежить память, не стесняйся заглянуть. Я всё равно провожу в камере столько времени, сколько возможно, так что компания мне будет только в радость.[/say]")
		
		saynn("Как и обещал, закончив свои дела, он поспешно направляется в сторону жилых блоков.")

		saynn("[say=pc]Интересно, о чем это они терли?[/say]")
		
		saynn("Ну, разузнать можно и позже. Судя по всему, этого дракона можно найти в сиреневом блоке.")
		
		addButton("Уйти", "Спешить некуда", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		setFlag("HypnokinkModule.DidVionGlance", true)
		endScene()
		return

	setState(_action)
