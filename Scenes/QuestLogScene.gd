extends "res://Scenes/SceneBase.gd"

class MyQuestSorter:
	static func sort_descending(a, b):
		if a.getPriority() > b.getPriority():
			return true
		return false

func _init():
	sceneID = "QuestLogScene"

func _run():
	if(state == ""):
		var quests = GM.QS.getAllQuests()
		
		var mainQuests = []
		var sideQuests = []
		var completedQuests = []
		
		for questID in quests:
			var quest:QuestBase = quests[questID]
			if(!quest.isVisible()):
				continue
			
			if(quest.isCompleted()):
				completedQuests.append(quest)
				continue
			
			if(quest.isMainQuest()):
				mainQuests.append(quest)
			else:
				sideQuests.append(quest)
		
		mainQuests.sort_custom(MyQuestSorter, "sort_descending")
		sideQuests.sort_custom(MyQuestSorter, "sort_descending")
		completedQuests.sort_custom(MyQuestSorter, "sort_descending")
		
		var showedNpcOwnerThing:bool = false
		for ownerID in GM.main.RS.special:
			var theSpecialRelationship = GM.main.RS.special[ownerID]
			if(theSpecialRelationship && theSpecialRelationship.id == "SoftSlavery" && theSpecialRelationship.npcOwner):
				var theNpcOwner:NpcOwnerBase = theSpecialRelationship.npcOwner
				if(theNpcOwner.hasGivenPCTasks()):
					if(!showedNpcOwnerThing):
						saynn("[i]Задания владельца:[/i]")
						showedNpcOwnerThing = true
					
					var theOwner = getCharacter(ownerID)
					if(!theOwner):
						continue
					sayn("[b]"+theOwner.getName()+" задания:[/b]")
					var theTaskLines := theNpcOwner.getQuestProgressArray()
					for textLine in theTaskLines:
						sayn("* "+textLine)
					sayn("")
		
		saynn("[i]Основные задания:[/i]")
		
		if(mainQuests.size() == 0):
			saynn("Ничего")
		
		for quest in mainQuests:
			sayn("[b]"+quest.getVisibleName()+"[/b]")
			var progress = quest.getProgress()
			progress.invert()
			for line in progress:
				sayn("* "+line)
			sayn("")
			
		saynn("[i]Побочные задания:[/i]")
		
		if(sideQuests.size() == 0):
			saynn("Ничего")
		
		for quest in sideQuests:
			sayn("[b]"+quest.getVisibleName()+"[/b]")
			var progress = quest.getProgress()
			progress.invert()
			for line in progress:
				sayn("* "+line)
			sayn("")
			
		saynn("[i]Выполненные задания:[/i]")
		
		if(completedQuests.size() == 0):
			saynn("Ничего")
		
		for quest in completedQuests:
			sayn("[b]"+quest.getVisibleName()+"[/b] (Выполнено)")
			var progress = quest.getProgress()
			progress.invert()
			for line in progress:
				sayn("* "+line)
			sayn("")
		
		addButton("Закрыть", "Закрыть журнал квестов", "endthescene")
		if(getFlag("ElizaModule.s0hap")):
			addButton("Награды за голову", "Попытайся вспомнить, какие награды еще можно забрать", "bounties")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "bounties"):
		runScene("NurseryBountyBoardScene", [true])
		return

func _react_scene_end(_tag, _result):
	setState("")

func supportsShowingPawns() -> bool:
	return true
