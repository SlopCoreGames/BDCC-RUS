extends SlaveEventBase

func _init():
	id = "RemovedOneRestraint"
	eventWeight = 1.0

func canHappen(_npcSlavery:NpcSlave):
	if(!_npcSlavery.getChar().getInventory().hasRemovableRestraints()):
		return false
	return true

func shouldHappenChance(_npcSlavery:NpcSlave):
#	var personalityMult = 1.0 + _npcSlavery.personalityScore({
#		PersonalityStat.Subby: -0.8,
#		PersonalityStat.Brat: 0.5,
#		PersonalityStat.Impatient: 0.2,
#		})
	var fetishMult = 1.0 + _npcSlavery.fetishScore({
		Fetish.Bondage: -0.9,
	})
	
	return 100.0 * _npcSlavery.getResistScore() * fetishMult + 10.0 * _npcSlavery.getBratScore() + sqrt(_npcSlavery.getNeediness()) * 2.0

func runEvent(_npcSlavery:NpcSlave):
	# Brats are more likely to try to resist but less likely to actually succeed (because they like restraints)
	# Ones who like bondage are less likely to succeed too
	var removeChanceMult = 1.0 + _npcSlavery.personalityScore({PersonalityStat.Brat:-0.5}) + _npcSlavery.fetishScore({Fetish.Bondage: -0.5})
	var howManyRemoved = removeRandomRestraints(_npcSlavery.getChar(), 100.0*clamp(removeChanceMult, 0.1, 5.0))
	
	var theText = ""
	if(howManyRemoved == 0):
		theText = "Вы замечаете, что на {npc.his} оковах {npc.name} есть следы повреждений. {npc.He} явно пыталась вырваться из них!\n\nСудя по всему, не очень успешно. И все же, это заслуживает небольшого наказания."
		_npcSlavery.deservesPunishment(1)
	elif(howManyRemoved == 1):
		theText = "Вы замечаете, что у {npc.name} отсутствует одна из {npc.his} оков! Похоже, {npc.he} удалось выскользнуть из нее, пока вы не видели."
		_npcSlavery.deservesPunishment(2)
	else:
		theText = "Вы замечаете, что у {npc.name} отсутствует часть {npc.his} оков! Похоже, {npc.he} удалось вырваться из них, пока вы не видели."
		_npcSlavery.deservesPunishment(2)
		# Add tiredness here too?
	
	if(_npcSlavery.getNeediness() > 40.0):
		theText += "\n\n[say=npc]"+RNG.pick([
			"Я просто хочу кончить... Пожалуйста...",
			"Не останавливай меня, мне это нужно. Ты вечно лишаешь меня разрядки...",
			"Я просто... такая похотливая... всё время...",
			"Тебе нравится смотреть, как я мучаюсь от вечного вожделения, правда?"
		])+"[/say]"
		
		theText += "\n\nПохоже, именно эта ненасытность заставляет {npc.him} так отчаянно пытаться избавиться от оков."
	
	return {
		text = theText,
	}

func onEventSkipped(_npcSlavery:NpcSlave):
	removeRandomRestraints(_npcSlavery.getChar(), 50.0)

func removeRandomRestraints(character:BaseCharacter, removedRestraintsChance = 100.0):
	var restraints = character.getInventory().getEquppedRestraints()
	var howManyRemoved = 0
	if(restraints.size() > 0):
		for restraint in restraints:
			if(restraint.isImportant() || restraint.isPersistent()):
				continue
			
			var chanceModifier = 1.0
			var restraintData:RestraintData = restraint.getRestraintData()
			if(restraintData != null):
				chanceModifier /= restraintData.getLevel()
			
			if(RNG.chance(removedRestraintsChance * chanceModifier)):
				character.getInventory().removeEquippedItem(restraint)
				howManyRemoved += 1
	
	return howManyRemoved

func getAnimInfo(_npcSlavery:NpcSlave):
	var possibleAnims = ["struggle"]
	
	if(_npcSlavery.getChar().isGagged() || _npcSlavery.getChar().isMuzzled()):
		possibleAnims.append("struggle_gag")
	if(_npcSlavery.getChar().hasBoundLegs()):
		possibleAnims.append("struggle_legs")
	
	return [StageScene.Duo, "stand", {npc=_npcSlavery.getChar().getID(), npcAction=RNG.pick(possibleAnims)}]
