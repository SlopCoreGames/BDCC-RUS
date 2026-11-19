extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "PortalPantiesShowerLewdScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.SexStanding, RNG.pick(["sex", "fast"]), {onlySub=true, npc="pc", npcBodyState={naked=true}})
		
		saynn("Ты даже в душе не снимаешь портальные трусики — надеюсь, они от этого не порвутся.")

		# (if pussy)
		if(GM.pc.hasVagina()):
			saynn("Но не об этом тебе стоит беспокоиться. Настоящая проблема возникает, когда ты внезапно чувствуешь, как кто-то начинает ласкать твою киску пальцами. Неизвестные пальцы широко раздвигают твои складки и начинают долбить прямо в точку G, вырывая из тебя стоны.")

			saynn(RNG.pick([
				"[say=pc]H-hey..[/say]",
				"[say=pc]Not n-now..[/say]",
			]))

			saynn("Ты так беззащитна, что даже не можешь прикрыть киску, вынужденная терпеть это непрекращающееся наслаждение. Ты наклоняешься вперед, вцепившись в холодную стену, пока струи душа стекают по твоей спине, а из груди вырываются всё новые стоны.")

		# (if no pussy)
		else:
			saynn("Но не об этом тебе стоит беспокоиться. Настоящая проблема возникает, когда ты внезапно чувствуешь, как кто-то начинает ковырять в твоем анусе. Неизвестные пальцы широко раздвигают твое кольцо и начинают долбить в твою эрогенную зону, заставляя тебя стонать.")
			
			saynn(RNG.pick([
				"[say=pc]H-hey..[/say]",
				"[say=pc]Not n-now..[/say]",
			]))

			saynn("Ты так беззащитна, что даже не можешь прикрыть задницу, вынужденная терпеть это непрекращающееся наслаждение. Ты наклоняешься вперед, вцепившись в холодную стену, пока струи душа стекают по твоей спине, а из груди вырываются всё новые стоны.")

		addButton("Кончить", "Больше не получается оттолкнуть это", "cum")

	if(state == "cum"):
		playAnimation(StageScene.SexStanding, RNG.pick(["inside", "fast"]), {onlySub=true, npc="pc", npcBodyState={naked=true}})
		
		# (if pussy)
		if(GM.pc.hasVagina()):
			saynn("Стимуляции просто слишком много: пальцы продолжают трахать твою щель до тех пор, пока она не начинает пульсировать и подергиваться вокруг них, заливая их твоей смазкой.")

		# (if no pussy)
		else:
			saynn("Стимуляции просто слишком много: пальцы продолжают трахать твой анус до тех пор, пока он не начинает пульсировать и подергиваться вокруг них.")

		# (if has cock)
		if(GM.pc.hasPenis()):
			saynn("Где бы там ни был твой член, ты надеешься, что он не привлек лишнего внимания, потому что от оргазма ты кончила и, скорее всего, вокруг стало довольно грязно.")

		saynn("Пальцы доводят тебя до самого пика оргазма, а затем просто оставляют в покое, давая перевести дух и спокойно закончить мыться.")

		# (scene ends)
		addButton("Продолжить", "Даже душ не гарантирует безопасности", "endthescene")


func _react(_action: String, _args):
	if(_action in ["cum"]):
		var pickedInmate = NpcFinder.grabNpcIDFromPoolOrGenerate(CharacterPool.Inmates, [[NpcCon.HasPenis], [NpcCon.NoChastity]], InmateGenerator.new(), {NpcGen.HasPenis: true, NpcGen.NoChastity: true})
		if(pickedInmate == "" || pickedInmate == null):
			pickedInmate = "inmateMaleCanine"

		GM.pc.orgasmFrom(pickedInmate)
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

