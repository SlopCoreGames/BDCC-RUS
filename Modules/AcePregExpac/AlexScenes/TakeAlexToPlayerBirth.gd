extends "res://Scenes/SceneBase.gd"

#var npcID = ""
#var npc:DynamicCharacter
#var bornString = ""
#var bornChildAmount = 0
#
##ACEPREGEXPAC- When I started this pack, I wanted obviously wanted something to expand the pc pregnancy content as well. And as a result, Alex was chosen to be like the inverse of all the interactions the NPCs will give the player.
##the Birth scene was an obvious one, instead of a pregnant NPC coming to the player, have the a pregnant PC take NPC to help them give birth.
##Alex was chosen for these interactions, mainly because hes the only one that makes sense. Rahi has her preg content in base game, Nova lacks content and has a to-be-written plotline only The Holy Loaf knows, same issue with Risha but she's a bitch on top of that. Avy would probably just make your life harder trying to bring her along. As of writing this, I *still* haven't played Tavi's content, so she's out too. And Eliza has the same missing plotline issue like Nova unless its in Tavi content, so sex only.
##Sucks having to cobble this thing together when I dont know how to program nearly at all
##This is gonna be the most broken scene, I swear
#
##func _initScene(_args = []):
##	npcID = _args[0]
##	npc = GlobalRegistry.getCharacter(npcID)
#
##func resolveCustomCharacterName(_charID):
##	if(_charID == "npc"):
##		return npcID
#
#func _init():
#	sceneID = "TakeAlexToPlayerBirth"
#
#func _run():
#	if(state == ""):
#		addCharacter("alexrynard")
##
##		saynn("Медсестра ахает, когда видит огромный живот того, кто на твоем поводке.")
##
##		saynn("Очевидно, пришло время позволить {npc.name} родить..")
##
##		addButton("Продолжить", "Пора за дело", "before_birth")
###		addButton("Отмена", "Вы передумали", "endthescene")
#
#	if(state == "before_birth"):
#		playAnimation(StageScene.GivingBirth, "birth", {pc="pc", bodyState={naked=true}})
#
##		saynn("Ты стоишь рядом с {npc.nameS}, пока {npc.he} слушает указания медсестры. Затем {npc.he} протягивает тебе {npc.his} руку и нервно улыбается. Ты решаешь сжать её, чтобы помочь {npc.him} успокоиться.")
##
##		saynn("Начинаются схватки: {npc.name} стонет от боли, до боли сжимая твою руку.")
##
##		saynn("Комната наполняется напряжением, когда {npc.name} издает всё более мучительные крики — схватки становятся всё чаще и сильнее.")
##
##		addButton("Продолжить", "Смотреть, что будет дальше", "do_birth")
#	if(state == "do_birth"):
#		playAnimation(StageScene.GivingBirth, "idle", {pc="pc", bodyState={naked=true}})
#		if (bornChildAmount == 1):
#			saynn("{npc.name} родила "+str(bornChildAmount)+" ребенка!")
#
#		else:
#			saynn("{npc.name} родила "+str(bornChildAmount)+" детей!")
#
#		saynn(""+str(bornString)+"")
#
#		addButton("Продолжить", "Смотреть, что будет дальше", "after_birth")
#
#	if(state == "after_birth"):
#		playAnimation(StageScene.SexStart, "start", {pc = "pc", npc="alexrynard", npcBodyState={naked=true}})
##		if (bornChildAmount <= 1):
#			saynn("Мгновения тянутся целую вечность, пока наконец воздух не наполняет крик новорожденного.")
#
#			saynn("Глаза {npc.name} сияют от слез облегчения и радости. Она ждет, пока акушерка бережно очистит ее дитя, а затем начинает баюкать его в своих руках.")
#
#		elif (bornChildAmount == 2):
#			saynn("Мгновения тянутся целую вечность, пока наконец воздух не наполняет крик новорожденного. Ох... Но не одного... Вскоре {npc.name} рожает еще одного ребенка...")
#
#			saynn("Глаза {npc.name} сияют от слез облегчения и радости. Она ждет, пока акушерка бережно очистит ее дитя, а затем начинает баюкать одного из них в своих руках.")
#
#		else:
#			saynn("Мгновения тянутся целую вечность, пока наконец воздух не наполняет крик новорожденного. Ох... Но не одного... Вскоре {npc.name} рожает еще одного ребенка... Но даже после этого живот {npc.his} все еще большой, а значит, есть еще...")
#
#			saynn("Только когда {npc.name} рожает последнего ребенка, глаза {npc.his} начинают сиять от слез облегчения и радости. Она ждет, пока акушерка бережно очистит ее дитя, а затем начинает баюкать одного из них в своих руках.")
#
#		saynn("[say=npc]"+str(RNG.pick(["Oh.. oh my.. so perfect.. Look at the tiny fingers and those little eyes.. So beautiful..", "Hi, mommy loves you more than words can express.. welcome to the world, my precious..", "I can't believe I brought this incredible life into existence.. I can't live without you already..", "I will do everything in my power to give you the life you deserve.."]))+"[/say]")
#
#		saynn("{npc.He} нежно целует младенца {npc.his} в лоб, пока ты стоишь рядом и улыбаешься.")
#
#		saynn("[say=pc]Ты проделала потрясающую работу![/say]")
#
#		saynn("Вы оба какое-то время просто смотрите на новую жизнь...")
#
#		if (bornChildAmount <= 1):
#			saynn("К сожалению, проводить с ребенком можно лишь ограниченное время — строгие тюремные правила запрещают длительное общение заключенных. Что ж, справедливо... Ты машешь на прощание новорожденному и возвращаешься в вестибюль вместе с матерью, быстро снова надевая поводок на {npc.him}.")
#
#		else:
#			saynn("К сожалению, проводить с этими детьми много времени не получится — строгая тюремная политика запрещает заключенным общение с ними. Впрочем, справедливо... Вы машете на прощание новой жизни и возвращаетесь в вестибюль вместе с матерью, и ваша рука быстро снова накидывает поводок на {npc.him}.")

#		saynn("Пора идти..")
#
#		addButton("Продолжить", "Это было нечто", "endthescene")


#func _react(_action: String, _args):
#	if(_action == "endthescene"):
#		endScene()
#		return
#
#	if(_action == "before_birth"):
#		processTime(3*60)
#
#	if(_action == "do_birth"):
#		processTime(35*60)
#		var bornChilds = GM.pc.giveBirth()
#		bornChildAmount = bornChilds.size()
##		bornString = GM.CS.getChildBirthInfoString(bornChilds)
#
#		GM.pc.addSkillExperience(Skill.Fertility, 150) # 
#
#	setState(_action)


#func saveData():
#	var data = .saveData()
#
##	data["npcID"] = npcID
#	data["bornString"] = bornString
#	data["bornChildAmount"] = bornChildAmount
#
#	return data
#
#func loadData(data):
#	.loadData(data)
#
#	npcID = SAVE.loadVar(data, "npcID", "")
#	npc = GlobalRegistry.getCharacter(npcID)
#	bornString = SAVE.loadVar(data, "bornString", "")
#	bornChildAmount = SAVE.loadVar(data, "bornChildAmount", 0)
