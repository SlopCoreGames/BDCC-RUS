extends SceneBase

var enemyID: String = ""
var enemyCharacter: BaseCharacter

var whatPlayerDid: String = ""
var whatEnemyDid: String = ""
var whatHappened: String = ""
var battleState = ""
var battleEndedHow = ""
var savedAIAttackID = ""
var battleName = ""
var currentAttackerID = ""
var currentReceiverID = ""
var enemyAIStrategy: AIStrategyBase
var restraintIdsForcedByPC = []
var enemySurrendered = false
var lastPlayerAttackData = null
var restraintsPickedCategory = ""

func _init():
	sceneID = "FightScene"
	showFightUI = true

func _initScene(_args = []):
	enemyID = _args[0]
	enemyCharacter = GlobalRegistry.getCharacter(enemyID)
	addCharacter(enemyID)
	
	if(_args.size() > 1):
		battleName = _args[1]
		
	enemyAIStrategy = enemyCharacter.getAiStrategy(battleName)
	enemyAIStrategy.battleName = battleName
	enemyAIStrategy.onBattleStart(GM.pc)
	
	enemyCharacter.onFightStart(getContexForEnemy())
	GM.pc.onFightStart(getContexForPC())
	if(GM.pc.getLustCombatState() != null):
		GM.pc.getLustCombatState().setEnemyID(enemyID)

func _run():
	if(state == ""):
		saynn(enemyCharacter.getFightIntro(battleName))
		#setState("fighting")
	elif(state == "fighting"):
		#say("И вот бой продолжается")
		pass
		
	if(state == "lost" || state == "win"):		
		saynn("Бой окончен")
	
	if(state == "physattacks"):
		saynn("Выберите тип атаки")
		
		addAttackButtons(Attack.Category.Physical)
		
		addButton("Назад", "Вернуться к бою", "return")
	
	if(state == "lustattacks"):
		saynn("Выберите, как именно вы хотите дразнить противника")
		
		var enemyLustInterests = enemyCharacter.getLustInterests()
		if(!enemyLustInterests.hasAnyInterests()):
			sayn("У вас есть предчувствие, что дразнилки не подействуют на "+enemyCharacter.getName())
		else:
			var whatPlayerKnows = enemyLustInterests.getPlayerKnowledge()
			
			sayn("Что вам известно о "+enemyCharacter.getName()+" Любит/не любит:")
			if(whatPlayerKnows.size() > 0):
				for topicID in whatPlayerKnows:
					var topic = GlobalRegistry.getLustTopic(topicID)
					sayn("- "+enemyCharacter.getName() + " [color="+Interest.getColorString(whatPlayerKnows[topicID])+"]" + Interest.getVisibleName(whatPlayerKnows[topicID])+"[/color] вид "+str(topic.getVisibleName(topicID)))
			else:
				sayn("- Пока ничего")
		
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		addLustActionsButtons(lustCombatState, lustCombatState.getActionsSorted())
		
		setPlayerAsAttacker()
		sayn("")
		for activity in lustCombatState.getAllText():
			sayn(activity)
		#addAttackButtons(Attack.Category.Lust)
		
		addButton("Назад", "Вернуться к бою", "return")
	
	if(state == "specialattacks"):
		saynn("Выберите тип атаки")
		
		addAttackButtons(Attack.Category.Special)
		
		addButton("Назад", "Вернуться к бою", "return")
	
	if(state == "inventory"):
		saynn("Выберите предмет для использования")
	
		var playerInventory = GM.pc.getInventory()
		var usableItems = playerInventory.getAllCombatUsableItems()
		
		for item in usableItems:
			var intoxic = item.addsIntoxicationToPC()
			
			if(intoxic <= 0 || GM.pc.canIntoxicateMore(intoxic)):
				addButton(item.getVisibleName(), item.getCombatDescription(), "useitem", [item])
			else:
				addDisabledButton(item.getVisibleName(), "[color=red]Слишком пьян, чтобы использовать это[/color]\n"+item.getCombatDescription())
	
		addButton("Назад", "Вернуться к бою", "return")
	
	if(state == "bdsm_attacks"):
		saynn("Выберите тип фиксации, которую хотите навязать врагу")
		
		if(!GM.pc.isBlindfolded() || GM.pc.canHandleBlindness()):
			for item in enemyCharacter.getInventory().getEquppedRestraints():
				var restraintData: RestraintData = item.getRestraintData()
				
				if(!restraintData.hasSmartLock()):
					sayn(item.getVisibleName()+", уровень фиксации: "+restraintData.getVisibleLevel(false))
					#sayn("- Прочность: "+restraintData.getVisibleDurability())
					saynn("- Тугость: "+restraintData.getVisibleTightness()+" ("+restraintData.getTightnessPercentString()+")")
				else:
					sayn(item.getVisibleName()+", С УМНЫМ ЗАМКОМ")
					var smartLock:SmartLockBase = restraintData.getSmartLock()
					saynn("- "+smartLock.getName())

		else:
			saynn("Нельзя оценить фиксацию врага, пока вы ослеплены")
		
		var isInCategory = (restraintsPickedCategory != "")
		if(isInCategory):
			var pickedItemToGroup:ItemBase = GlobalRegistry.getItemRef(restraintsPickedCategory)
			if(pickedItemToGroup != null):
				saynn("Что "+str(pickedItemToGroup.getVisibleName())+" хочешь использовать?")
			
		var usableItems
		var countsByUniqueRestraint = {}
		if(enemyCharacter.isDynamicCharacter()):
			usableItems = GM.pc.getInventory().getAllCombatUsableRestraints()
		else:
			usableItems = GM.pc.getInventory().getAllCombatUsableRestraintsForStaticNpc()
		var countsByItemID:Dictionary = {}
		var hasAtLeastOneUsableByItemID:Dictionary = {}
		if(isInCategory):
			var newUsable = []
			for item in usableItems:
				if(item.id == restraintsPickedCategory):
					var foundGroup = false
					for otherGroupedItem in countsByUniqueRestraint:
						if(item.canGroupRestraintWithOtherInFightScene(otherGroupedItem)):
							countsByUniqueRestraint[otherGroupedItem] += 1
							foundGroup = true
							break
					if(!foundGroup):
						countsByUniqueRestraint[item] = 1
						newUsable.append(item)
			usableItems = newUsable
		else:
			for item in usableItems:
				var itemSlot:String = item.getClothingSlotSafe()
				var theCanEquipResult:Array = canEquipRestraintOntoEnemySlotOrReason(itemSlot)
				if(theCanEquipResult[0]):
					hasAtLeastOneUsableByItemID[item.id] = true
				if(!countsByItemID.has(item.id)):
					countsByItemID[item.id] = 1
					countsByUniqueRestraint[item] = 1
				else:
					countsByItemID[item.id] += 1
		
			for categoryID in countsByItemID:
				if(countsByItemID[categoryID] <= 1):
					continue
				var itemRef:ItemBase = GlobalRegistry.getItemRef(categoryID)
				if(itemRef == null):
					continue
				
				if(hasAtLeastOneUsableByItemID.has(categoryID)):
					addButton(str(countsByItemID[categoryID])+"x"+itemRef.getVisibleName(), itemRef.getCombatDescription(), "openrestraintscategory", [categoryID])
				else:
					addDisabledButton(str(countsByItemID[categoryID])+"x"+itemRef.getVisibleName(), "Нельзя применить этот предмет на врага")
				
		for item in usableItems:
			if(!isInCategory && countsByItemID.has(item.id) && countsByItemID[item.id] > 1):
				continue
			
			var itemSlot:String = item.getClothingSlotSafe()
			var theCanEquipResult:Array = canEquipRestraintOntoEnemySlotOrReason(itemSlot)
			
			if(!theCanEquipResult[0]):
				addDisabledButton(item.getVisibleName(), theCanEquipResult[1])
			else:
				var restraintData:RestraintData = item.getRestraintData()
				if(restraintData == null):
					continue
				var pcAccuracy = GM.pc.getRestraintForcingSuccessChanceMod()
					
				var chanceToForce = pcAccuracy
				if(enemyCharacter.getStamina() > 0):
					 chanceToForce *= restraintData.getFinalChanceToForceARestraint(enemyCharacter)

				var buttonName = item.getVisibleName()
				if(isInCategory):
					buttonName = "Уровень "+str(restraintData.getLevel())
				var buttonDesc = "Уровень скованности: "+str(restraintData.getLevel()) + "\n" + "Шанс успеха:"+ str(Util.roundF(chanceToForce*100.0, 1))+"%" + "\n\n" + item.getCombatDescription()
				var theAmount:int = countsByUniqueRestraint[item] if countsByUniqueRestraint.has(item) else 1
				if(theAmount > 0):
					buttonDesc = "Кол-во: " + str(theAmount) + "\n" + buttonDesc
				addButton((str(theAmount)+"x" if theAmount > 1 else "")+buttonName, buttonDesc, "forcerestraint", [item])
			
		addButton("Назад", "Вернуться к бою", "closerestraintsmenu")
	
	if(state == "playerMustDodge"):
		if(whatPlayerDid != ""):
			saynn(whatPlayerDid)
			
		if(whatHappened != ""):
			saynn(whatHappened)
	
	if(state == "" || state == "fighting" || state == "lost" || state == "win"):	
		if(whatPlayerDid != ""):
			saynn(whatPlayerDid)
			
		if(whatEnemyDid != ""):
			saynn(whatEnemyDid)
			
		if(whatHappened != ""):
			saynn(whatHappened)
			
	if(state == "fighting"):
		saynn(enemyCharacter.getFightState(battleName))
		
		saynn(GM.pc.getFightState(battleName))
		
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		for activity in lustCombatState.getAllText():
			sayn(activity)
			
	if(state == "playerMustDodge"):
		playGetUpAnimsIfNeedTo()
		var attack: Attack = GlobalRegistry.getAttack(savedAIAttackID)
		
		setEnemyAsAttacker()
		if(GM.pc.isBlindfolded() && !GM.pc.canHandleBlindness() && !attack.canSeeAnticipationTextWhenBlind()):
			saynn(GM.ui.processString(attack.canBlindAnticipationText(enemyCharacter, GM.pc)))
		else:
			saynn(GM.ui.processString(attack.getAnticipationText(enemyCharacter, GM.pc)))
		addButton("Ничего не делать", "Вы никак не парируете атаку", "dodge_donothing")
		addButtonWithChecks("Уклонение", "Вы полностью уклоняетесь от физической атаки, затрачивая при этом 30 единиц выносливости", "dodge_dodge", [], [ButtonChecks.HasStamina, ButtonChecks.NotCollapsed])
		addButtonWithChecks("Блок", "Вы получаете "+str(GM.pc.getBlockArmor())+" дополнительной физической брони против атаки, затрачивая 15 единиц выносливости", "dodge_block", [], [ButtonChecks.HasStamina])
		addButtonWithChecks("Рассеянность", "Вы пытаетесь отвлечься от боя, получая "+str(GM.pc.getDefocusArmor())+" брони похоти и тратя 15 выносливости", "dodge_defocus", [], [ButtonChecks.HasStamina])
		if(GM.pc.hasPerk(Perk.CombatDoubleDown)):
			if(lastPlayerAttackData != null):
				var pcAttack:Attack = GlobalRegistry.getAttack(lastPlayerAttackData["attackID"])
				
				if(pcAttack.canUse(GM.pc, enemyCharacter, lastPlayerAttackData)):
					addButtonWithChecks("Удвоить ставку", "Потратить 10 выносливости, чтобы повторить ту же атаку еще раз, прежде чем враг нанесет удар", "dodge_doubledown", [], [ButtonChecks.HasStamina])
				else:
					addDisabledButton("Удвоить ставку", "Эту атаку нельзя удвоить")
			else:
				addDisabledButton("Удвоить ставку", "Удвоить ставку можно только для базовой физической атаки")
				
	if(state == "" || state == "fighting"):
		playGetUpAnimsIfNeedTo()

		addButtonWithChecks("Физическая атака", "Показать список доступных физических атак", "physattacks", [], [ButtonChecks.NotStunned])
		addButtonWithChecks("Похотливая атака", "Показать список развратных действий, которые вы можете совершить", "lustattacks", [], [ButtonChecks.NotStunned])
		
		if(pcHasAnyAttacksOfCategory(Attack.Category.Special)):
			addButtonWithChecks("Спецприём", "Показать список ваших особых приёмов", "specialattacks", [], [ButtonChecks.NotStunned])
		else:
			addDisabledButton("Спецприём", "Вы не знаете никаких особых приёмов")
		
		#addButton("Осмотреть", "Присмотреться поближе", "inspect")
		if(GM.pc.getInventory().hasRemovableRestraints()):
			addButtonWithChecks("Сопротивление", "Пытаться вырваться из пут", "struggle", [], [ButtonChecks.NotStunned])
		else:
			addDisabledButton("Сопротивление", "На вас нет никаких пут, из которых можно было бы вырваться")
		addButton("Подождать", "Ничего не делать", "wait")
		
		#if(GM.pc.getInventory().getAllCombatUsableItems().size() > 0):
		#	addButton("Инвентарь", "Использовать предмет из инвентаря", "inventory")
		#else:
		#	addDisabledButton("Инвентарь", "У вас нет ничего, что можно использовать в бою")
		addButton("Инвентарь", "Посмотреть инвентарь", "openinventory")
		
		if(GM.pc.hasEffect(StatusEffect.Collapsed)):
			if(GM.pc.canStandUpCombat()):
				addButtonWithChecks("Встать", "тратит весь ход", "getup", [], [ButtonChecks.NotStunned])
			else:
				addDisabledButton("Встать", "Ты не можешь встать сейчас")
		else:
			addDisabledButton("Встать", "Ты уже стоишь")
		
		if(GM.pc.hasPerk(Perk.BDSMRigger)):
			addButtonWithChecks("Бондаж", "Выбери тип связывания, который хочешь навязать врагу", "bdsm_attacks", [], [ButtonChecks.NotHandsBlocked, ButtonChecks.NotArmsRestrained])
		
		if(!GM.pc.hasEffect(StatusEffect.Collapsed)):
			addButton("Сменить стойку", "Сменить боевую стойку на следующую. Это лишь визуальное изменение", "switchStance")
		
		
		addButtonAt(14, "Подчиниться", "Сдаться", "submit")
		
	if(state == "lost" || state == "win"):
		if(enemyCharacter.isDynamicCharacter() && restraintIdsForcedByPC.size() > 0 && state == "win"):
			addButton("Восстановить путы", "битва окончена", "endbattle", [true])
			addButton("Сохранить путы", "битва окончена", "endbattle", [false])
		else:
			addButton("Продолжить", "битва окончена", "endbattle", [true])
		
	if(state == "lustCombatAboutToCum"):
		saynn(whatPlayerDid)
		
		saynn("Ты сейчас кончишь...")
		
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		addLustActionsButtons(lustCombatState, lustCombatState.getOrgasmActionsSorted())
		
	if(state == "lustCombatAfterCame"):
		saynn(whatPlayerDid)
		
		addButton("Продолжить", "Ты еще не всё", "")
		addButton("Стой", "На сегодня хватит...", "endthescene")

func _react(_action: String, _args):
	if(_action == "struggle"):
		runScene("StrugglingScene", [true], "struggle_scene")
		return
		
	if(_action == "openinventory"):
		runScene("InventoryScene", [true], "inventory_scene")
		return
		
	if(_action == "physattacks" || _action == "lustattacks" || _action == "specialattacks" || _action == "selfhumattacks" || _action == "humattacks" || _action == "inventory"):
		setState(_action)
		return
		
	if(_action == "return"):
		setState("fighting")
		return
	
	if(_action == "doattack"):
		setState("fighting")
		beforeTurnChecks()
		
		var attackData = _args[0]
		whatPlayerDid += doPlayerAttack(attackData)
		whatEnemyDid += aiTurn()

		afterTurnChecks()
		return
		
	if(_action == "useitem"): # UNUSED
		setState("fighting")
		beforeTurnChecks()
		
		setPlayerAsAttacker()
		var item = _args[0]
		whatPlayerDid += GM.ui.processString(item.useInCombatWithBuffs(GM.pc, enemyCharacter))
		whatEnemyDid += aiTurn()

		afterTurnChecks()
		return
		
	if(_action == "openrestraintscategory"):
		restraintsPickedCategory = _args[0]
		return
	
	if(_action == "closerestraintsmenu"):
		if(restraintsPickedCategory != ""):
			restraintsPickedCategory = ""
		else:
			setState("fighting")
		return
		
	if(_action == "forcerestraint"):
		restraintsPickedCategory = ""
		setState("fighting")
		beforeTurnChecks()
		
		setPlayerAsAttacker()
		
		var accuracy = GM.pc.getRestraintForcingSuccessChanceMod()
		if(!RNG.chance(accuracy * 100.0)):
			whatPlayerDid += "Вы попытались накинуть путы на врага, но промахнулись!"
		else:
			var item:ItemBase = _args[0]
			var restraintData:RestraintData = item.getRestraintData()
			var theAttackToPlay:String = restraintData.getForceOnCombatAnim()
			var finalSuccessChance = restraintData.getFinalChanceToForceARestraint(enemyCharacter)
			
			if(!RNG.chance(finalSuccessChance * 100.0) && enemyCharacter.getStamina() > 0):
				enemyCharacter.addStamina(-10)
				whatPlayerDid += GM.ui.processString("Вы пытаетесь сковать {receiver.name}, но {receiver.he} уклоняется от вашей попытки!")
			
				if(!theAttackToPlay.empty()):
					playAttackAnim({attackerAnimation=theAttackToPlay, dodged=true}, true)
			else:
				if(!theAttackToPlay.empty()):
					playAttackAnim({attackerAnimation=theAttackToPlay}, true)
				GM.pc.addSkillExperience(Skill.BDSM, restraintData.getLevel() * 3)
				whatPlayerDid += GM.ui.processString(item.getForcedOnMessage(false))
				
				restraintIdsForcedByPC.append(item.getUniqueID())
				GM.pc.getInventory().removeItem(item)
				enemyCharacter.getInventory().forceEquipByRemoveOther(item, GM.pc)
				enemyCharacter.getBuffsHolder().calculateBuffs()
				#enemyCharacter.updateNonBattleEffects()
				
				var restraintsAmount = enemyCharacter.getInventory().getEquppedRestraints().size()
				if(enemyCharacter.shouldReactToRestraint(restraintData.getRestraintType(), restraintsAmount, true)):
					var reaction = enemyCharacter.reactRestraint(restraintData.getRestraintType(), restraintsAmount, true)
					if(reaction != null && reaction != ""):
						whatPlayerDid += "\n" + "[say="+str(enemyID)+"]"+str(reaction)+"[/say]"
		
		whatEnemyDid += aiTurn()

		afterTurnChecks()
		return
	
	if(_action == "getup"):
		beforeTurnChecks()
		
		whatPlayerDid += doPlayerAttack({"attackID": "trygetupattack"})
		playGetUpAnimsIfNeedTo()
		
		whatEnemyDid += aiTurn()
		afterTurnChecks()
		return

	if(_action == "wait"):
		beforeTurnChecks()
		
		whatPlayerDid = "Вы решаете дождаться подходящего момента для атаки"
		
		whatEnemyDid += aiTurn()
		
		afterTurnChecks()
		return
		
	if(_action == "dodge_donothing" || _action == "dodge_dodge" || _action == "dodge_block" || _action == "dodge_defocus" || _action == "dodge_doubledown"):
		setState("fighting")
		whatHappened = ""
		if(_action == "dodge_donothing"):
			whatPlayerDid = "Вы решаете принять удар на себя"
		if(_action == "dodge_dodge"):
			whatPlayerDid = "Вы сосредотачиваетесь на следующей атаке врага и пытаетесь уклониться"
			GM.pc.setFightingStateDodging()
			GM.pc.addStamina(-30)
		if(_action == "dodge_block"):
			whatPlayerDid = "Вы пытаетесь заблокировать следующую атаку"
			GM.pc.setFightingStateBlocking()
			GM.pc.addStamina(-15)
		if(_action == "dodge_defocus"):
			whatPlayerDid = "Вы пытаетесь отвлечься"
			GM.pc.setFightingStateDefocusing()
			GM.pc.addStamina(-15)
		if(_action == "dodge_doubledown"):
			whatPlayerDid = doPlayerAttack(lastPlayerAttackData)
			GM.pc.addStamina(-10)
		
			var won = checkEnd()
			if(won == "lost"):
				setState("lost")
				onPCLose()
				return
			if(won == "win"):
				setState("win")
				onPCWin()
				return
		
		var attack: Attack = GlobalRegistry.getAttack(savedAIAttackID)
		if(attack == null):
			assert(false, "Bad attack: "+savedAIAttackID)
			
		setEnemyAsAttacker()
		
		var result = attack.doAttack(enemyCharacter, GM.pc)
		result["text"] = GM.ui.processString(result["text"])
		
		#playAnimation(StageScene.Duo, result["receiverAnimation"], {npc=enemyID, npcAction=result["attackerAnimation"]})
		playAttackAnim(result, false)
		
		whatEnemyDid += result["text"]
		savedAIAttackID = ""
		
		GM.pc.setFightingStateNormal()
		
		afterTurnChecks()
		return
	
	if(_action == "submit"):
		setState("lost")
		whatHappened = "Вы добровольно сдаетесь и подчиняетесь своему врагу\n"
		battleState = "lost"
		playAnimation(StageScene.Solo, "kneel")
		onPCSubmit()
		return
	
	if(_action == "endbattle"):
		if(restraintIdsForcedByPC.size() > 0 && _args.size() > 0 && _args[0]):
			#var recoverChance = GM.pc.getBuffsHolder().getCustom(BuffAttribute.RestraintRecovery) * 100.0
			
			for itemUniqueID in restraintIdsForcedByPC:
				var item:ItemBase = enemyCharacter.getInventory().getItemByUniqueID(itemUniqueID)
				
				if(item == null):
					continue
				
				if(true):#if(RNG.chance(recoverChance)):
					enemyCharacter.getInventory().removeItem(item)
					enemyCharacter.getInventory().removeEquippedItem(item)
					var restraintData:RestraintData = item.getRestraintData()
					if(restraintData != null):
						restraintData.onStruggleRemoval()
					
					GM.pc.getInventory().addItem(item)
					addMessage("Вы восстановились "+item.getAStackName())
				else:
					addMessage("Ты проиграл "+item.getAStackName())
			if(!enemyCharacter.isDynamicCharacter()):
				enemyCharacter.resetEquipment()
		
		enemyCharacter.onFightEnd(getContexForEnemy())
		GM.pc.onFightEnd(getContexForPC())
		
		if(battleState == "win"):
			enemyCharacter.addFightExperienceAuto("pc", false)
		else:
			enemyCharacter.addFightExperienceAuto("pc", true)
		
		if(battleEndedHow == ""):
			battleEndedHow = "pain"
		if(battleState == "win"):
			var loot = enemyCharacter.getLoot(battleName)
			
			if(GM.pc.hasKeyholderLocksFrom(enemyID) && !GM.pc.isSlaveTo(enemyID)):
				if(!loot.has("items")):
					loot["items"] = []
				var theKey = GlobalRegistry.createItem("KeyholderKeyUnlock")
				theKey.npcID = enemyID
				loot["items"].append(theKey)
			
			if((loot.has("credits") && loot["credits"] > 0) || (loot.has("items") && loot["items"].size() > 0)):
				runScene("LootingScene", [loot], "lootingscene")
			else:
				endScene([battleState, battleEndedHow])
		else:
			endScene([battleState, battleEndedHow])
		return
	
	if(_action == "doLustAction"):
		setState("fighting")
		var actionData = _args[0]
		if(!(actionData["id"] in GlobalRegistry.getOrgasmLustActions())):
			beforeTurnChecks()
		setPlayerAsAttacker()
		
		var lustCombatState:LustCombatState = GM.pc.getLustCombatState()
		
		var didAnyDamage:bool = false
		var result = lustCombatState.doAction(actionData)
		whatPlayerDid = GM.ui.processString(result["text"]).trim_suffix("\n\n")
		if("lust" in result):
			GM.pc.addLust(result["lust"])
			if(GM.pc.getLustLevel() >= 1.0 && ("cantCum" in result) && result["cantCum"]):
				GM.pc.addLust(-1)
		if("pain" in result):
			GM.pc.addPain(result["pain"])
		
		if("lustInterests" in result):
			var actionLustInterests = result["lustInterests"]
			var isTease = false
			if("isTease" in result):
				isTease = true
			
			var maxUnlocks = 1
			if(GM.pc.hasPerk(Perk.SexBetterTease)):
				maxUnlocks = 2
			
			var lustInterests: LustInterests = enemyCharacter.getLustInterests()
			var teaseData = lustInterests.reactLustAction(GM.pc, actionLustInterests, maxUnlocks)
			#var damageMult = teaseData["value"]
			var positiveDamage = teaseData["positiveValue"]
			var negativeDamage = teaseData["negativeValue"]
			var learned = teaseData["learned"]
			#var alreadyKnownTopics = teaseData["alreadyKnownTopics"]
			
			var pcDamageMult = GM.pc.getDamageMultiplier(DamageType.Lust) + 1.0
			var damageBalanceMod = negativeDamage/pcDamageMult + positiveDamage*pcDamageMult
			if(damageBalanceMod > 0.0):
				damageBalanceMod = pow(damageBalanceMod, 0.7)
			if(damageBalanceMod < 0.0):
				damageBalanceMod = -pow(abs(damageBalanceMod), 0.7)
			var theDamage = damageBalanceMod*10.0*RNG.randf_range(0.9, 1.1)
			
			var extraText = ""
			if(isTease && enemyCharacter.getLustLevel() < 0.6 && theDamage > 0.0):
				theDamage *= 1.5
			if(isTease && enemyCharacter.getLustLevel() >= 0.6):
				theDamage *= 1.0
				extraText = "[b]Дразнить врага становится сложнее, когда он и так весь горит от желания![/b] "
			if(theDamage > 0.0):
				didAnyDamage = true
			
			var damage = enemyCharacter.receiveDamage(DamageType.Lust, int(round(theDamage)))
			
			whatPlayerDid += "\n\n"
			whatPlayerDid += enemyCharacter.lustDamageReaction(damage, GM.pc)
			whatPlayerDid += "\n"
			whatPlayerDid += extraText + enemyCharacter.getName()+" получено [color="+DamageType.getColorString(DamageType.Lust)+"]"+str(damage)+" "+DamageType.getBattleName(DamageType.Lust)+"[/color]"
			
			if(learned.size() > 0):
				var npcReaction = enemyCharacter.interestVerbalReaction(learned[0][0])
				if(npcReaction != null && npcReaction != ""):
					whatPlayerDid += "\n\n"+"[say="+enemyCharacter.getID()+"]" +str(npcReaction)+"[/say]"
				
				whatPlayerDid += "\n[i]Вы узнали больше о том, что "+enemyCharacter.getName()+" likes[/i]"
		
		#processTime(30)
		
		#if("came" in result):
		#	setState("lustCombatAfterCame")
		#	afterTurnChecks()
		#	return
		
		if(result.has("anim")):
			var theAnim:String = result["anim"]
			if(!theAnim.empty()):
				playAttackAnim({attackerAnimation=theAnim, missed=!didAnyDamage}, true)
		
		if("lostBattle" in result):
			GM.pc.addLust(GM.pc.lustThreshold())
			afterTurnChecks()
			return
			
		if(GM.pc.getLustLevel() >= 1.0):
			setState("lustCombatAboutToCum")
			#afterTurnChecks()
			return
			
		whatEnemyDid += aiTurn()
			
		afterTurnChecks()
		return
	
	if(_action == "switchStance"):
		GM.pc.switchToNextCombatStance()
		return
	
	setState(_action)

func addLustActionsButtons(lustCombatState:LustCombatState, theActions):
	for actionData in theActions:
		var lustAction:LustAction = GlobalRegistry.getLustAction(actionData["id"])
		
		if(!lustAction.shouldShow(lustCombatState, actionData)):
			continue
		var canDo = lustAction.canDo(lustCombatState, actionData)
		var reasonWhyCant = "Сейчас тебе это делать нельзя"
		if(canDo is Array):
			if(canDo.size() > 1):
				reasonWhyCant = canDo[1]
			canDo = canDo[0]
		
		if(canDo):
			addButton(lustAction.getVisibleName(lustCombatState, actionData), lustAction.getVisibleDescription(lustCombatState, actionData), "doLustAction", [actionData])
		else:
			addDisabledButton(lustAction.getVisibleName(lustCombatState, actionData), reasonWhyCant)
	

func doPlayerAttack(attackData):
	lastPlayerAttackData = attackData
	var attackID = attackData["attackID"]
	
	var attack: Attack = GlobalRegistry.getAttack(attackID)
	if(attack == null):
		assert(false, "Bad attack: "+attackID)
	
	setPlayerAsAttacker()
	
	var result = attack.doAttack(GM.pc, enemyCharacter, attackData)
	result["text"] = GM.ui.processString(result["text"])
	
	#playAnimation(StageScene.Duo, result["attackerAnimation"], {npc=enemyID, npcAction=result["receiverAnimation"]})
	playAttackAnim(result, true)
	
	var expData = attack.getExperience()
	for expAdd in expData:
		GM.pc.addSkillExperience(expAdd[0], expAdd[1])
	
	return result["text"]
	
func aiTurn():
	if(enemyCharacter.getPain() >= enemyCharacter.painThreshold() || enemyCharacter.getLust() >= enemyCharacter.lustThreshold()):
		return ""
	
	setEnemyAsAttacker()
	var enemyText = "It's "+enemyCharacter.getName()+"ход \n"
	if(enemyAIStrategy != null):
		var strategyText = enemyAIStrategy.turnPassed(GM.pc)
		if(strategyText != null && strategyText != ""):
			enemyText += GM.ui.processString(strategyText) + "\n\n"
	
	var actionData = enemyAIStrategy.getNextActionFinal(GM.pc)
	var actionType = actionData["action"]
	
	if(actionType == "struggle"):
		var item:ItemBase = actionData["item"]
		var restraintData = item.getRestraintData()
		
		var minigameResult:MinigameResult
		
		if(restraintData.shouldDoStruggleMinigame(enemyCharacter)):
			minigameResult = enemyCharacter.getRestraintStrugglingMinigameResult()
		else:
			minigameResult = MinigameResult.new()
			minigameResult.score = 1.0
		
		var animToPlay = restraintData.getResistAnimation()
		if(animToPlay != null && animToPlay != ""):
			playAnimation(StageScene.Combat, "", {npc=enemyID, npcAction=animToPlay})
		
		var damage = 0.0
		var addLust = 0
		var addPain = 0
		var addStamina = 0
		
		var struggleData = restraintData.doStruggle(enemyCharacter, minigameResult)
		
		if(struggleData.has("damage")):
			damage = struggleData["damage"]
		if(struggleData.has("lust") && struggleData["lust"] > 0):
			addLust = struggleData["lust"]
		if(struggleData.has("pain") && struggleData["pain"] > 0):
			addPain = struggleData["pain"]
		if(struggleData.has("stamina") && struggleData["stamina"] != 0):
			addStamina = struggleData["stamina"]
		
		var struggleText = GM.ui.processString(struggleData["text"], {"user": enemyID})
		enemyText += struggleText + "\n\n"
		
		if(damage > 0.0):
			restraintData.takeDamage(damage)
			enemyText += ("{attacker.name} made "+str(Util.roundF(damage*100.0, 1))+"% oпрогресс \n")
		elif(damage < 0.0):
			restraintData.takeDamage(damage)
			enemyText += ("{attacker.name} lost "+str(Util.roundF(abs(damage)*100.0, 1))+"% oпрогресс \n")
		else:
			enemyText += ("{attacker.name} не добился никакого прогресса!\n")
		
		if(addLust != 0):
			addLust = enemyCharacter.receiveDamage(DamageType.Lust, addLust)
			enemyText += ("{attacker.name} received "+str(addLust)+" lust\n")
		if(addPain != 0):
			addPain = enemyCharacter.receiveDamage(DamageType.Physical, addPain)
			enemyText += ("{attacker.name} received "+str(addPain)+" pain\n")
		if(addStamina != 0):
			enemyCharacter.addStamina(-addStamina)
			
			if(addStamina < 0):
				enemyText += ("{attacker.name} gained "+str(-addStamina)+" stamina\n")
			else:
				enemyText += ("{attacker.name} used "+str(addStamina)+" stamina\n")
		
		if(restraintData.shouldBeRemoved()):
			enemyText += "[b]"+restraintData.getRemoveMessage()+"[/b]\n"
			restraintData.onStruggleRemoval()
			enemyCharacter.getInventory().removeEquippedItem(item)
			
			var recoverChance = GM.pc.getBuffsHolder().getCustom(BuffAttribute.RestraintRecovery) * 100.0
			if(!restraintData.alwaysBreaksWhenStruggledOutOf() && RNG.chance(recoverChance)):
				GM.pc.getInventory().addItem(item)
				addMessage("Вы восстановились "+item.getAStackName())
			#elif(recoverChance > 0):
			#	addMessage("You lost "+item.getAStackName())
			
		var restraintsAmount = enemyCharacter.getInventory().getEquppedRestraints().size()
		if(enemyCharacter.shouldReactToRestraint(restraintData.getRestraintType(), restraintsAmount, false)):
			var reaction = enemyCharacter.reactRestraint(restraintData.getRestraintType(), restraintsAmount, false)
			if(reaction != null && reaction != ""):
				enemyText += "[say="+str(enemyID)+"]"+str(reaction)+"[/say]"

		enemyText = enemyText.rstrip("\n")
		
	elif(actionType == "attack"):
	
		var attackID: String = actionData["attackID"]
		var attack: Attack = GlobalRegistry.getAttack(attackID)

		if(attack == null):
			Log.printerr("Bad attack "+str(attackID))
			attackID = "blunderAttack"
			attack = GlobalRegistry.getAttack(attackID)
			
		if(!attack.canBeDodgedByPlayer(enemyCharacter, GM.pc)):	
			
			var result = attack.doAttack(enemyCharacter, GM.pc)
			result["text"] = GM.ui.processString(result["text"])
				
			#playAnimation(StageScene.Duo, result["receiverAnimation"], {npc=enemyID, npcAction=result["attackerAnimation"]})
			playAttackAnim(result, false)
			
			enemyText += result["text"]
		else:
			savedAIAttackID = attackID
			setState("playerMustDodge")
	elif(actionType == "wait"):
		enemyText += "{attacker.name} решил подождать"
	elif(actionType == "stunned"):
		enemyText += "{attacker.name} ничего не мог сделать, потому что {attacker.he} был оглушен"
	elif(actionType == "surrender"):
		if(actionData.has("reason")):
			enemyText += "{attacker.name} сдался. Причина: "+str(actionData["reason"])
		else:
			enemyText += "{attacker.name} surrendered"
		enemySurrendered = true
	else:
		enemyText += "{attacker.name} не мог решить, что делать"
	
	return enemyText

func getContexForPC():
	return {
		"whoID": "pc",
		"enemyID": enemyID,
	}
	
func getContexForEnemy():
	return {
		"whoID": enemyID,
		"enemyID": "pc",
	}

func beforeTurnChecks(pcWasStruggling = false):
	whatPlayerDid = ""
	whatEnemyDid = ""
	whatHappened = ""
	lastPlayerAttackData = null
	
	GM.pc.processBattleTurnContex(getContexForPC())
	enemyCharacter.processBattleTurnContex(getContexForEnemy())
	
	if(true):
		var turnData = GM.pc.processStruggleTurn(pcWasStruggling)
		var addLust = turnData["lust"]
		var addPain = turnData["pain"]
		var addStamina = turnData["stamina"]
		var additionalStruggleText = turnData["text"]
		
		if(addLust != 0):
			addLust = GM.pc.receiveDamage(DamageType.Lust, addLust)
			addMessage("Вы получили "+str(addLust)+" lust")
		if(addPain != 0):
			addPain = GM.pc.receiveDamage(DamageType.Physical, addPain)
			addMessage("Вы получили "+str(addPain)+" pain")
		if(addStamina != 0):
			GM.pc.addStamina(-addStamina)
			if(addStamina < 0):
				addMessage("Вы получили "+str(-addStamina)+" stamina")
			else:
				addMessage("Вы использовали "+str(addStamina)+" stamina")
		
		if(additionalStruggleText != null && additionalStruggleText != ""):
			whatHappened += "[i]"+GM.ui.processString(additionalStruggleText, {"user":"pc"})+"[/i]\n"
	
	if(true):
		var turnData = enemyCharacter.processStruggleTurn(true)
		var addLust = turnData["lust"]
		var addPain = turnData["pain"]
		var addStamina = turnData["stamina"]
		var additionalStruggleText = turnData["text"]
		
		if(addLust != 0):
			addLust = enemyCharacter.receiveDamage(DamageType.Lust, addLust)
			addMessage("Враг получил "+str(addLust)+" lust")
		if(addPain != 0):
			addPain = enemyCharacter.receiveDamage(DamageType.Physical, addPain)
			addMessage("Враг получил "+str(addPain)+" pain")
		if(addStamina != 0):
			enemyCharacter.addStamina(-addStamina)
			if(addStamina < 0):
				addMessage("Враг приобрел "+str(-addStamina)+" stamina")
			else:
				addMessage("Враг использовал "+str(addStamina)+" stamina")
		
		if(additionalStruggleText != null && additionalStruggleText != ""):
			whatHappened += "[i]"+GM.ui.processString(additionalStruggleText, {"user": enemyID})+"[/i]\n"
	
	whatHappened = whatHappened.rstrip("\n")
	if(state == ""):
		setState("fighting")

func afterTurnChecks():
	#GM.pc.processBattleTurn()
	#enemyCharacter.processBattleTurn()
	#enemyCharacter.updateNonBattleEffects()
	#GM.pc.updateNonBattleEffects()
	
	var won = checkEnd()
	if(won == "lost"):
		setState("lost")
		onPCLose()
	if(won == "win"):
		setState("win")
		onPCWin()

func onPCWin():
	SexToyManager.sendTrigger(SexToyTrigger.OnFightWin)
	playDefeatAnim()

func onPCLose():
	SexToyManager.sendTrigger(SexToyTrigger.OnFightDefeat)
	playDefeatAnim()

func onPCSubmit():
	pass

func checkEnd():
	if(enemySurrendered):
		if(whatHappened != ""):
			whatHappened += "\n"
		whatHappened += "Враг сдался, вы победили в бою\n"
		battleState = "win"
		battleEndedHow = "surrendered"
		return "win"
	if(enemyCharacter.getPain() >= enemyCharacter.painThreshold()):
		if(whatHappened != ""):
			whatHappened += "\n"
		whatHappened += "Враг слишком измучен болью, чтобы продолжать\n"
		battleState = "win"
		battleEndedHow = "pain"
		return "win"
	if(enemyCharacter.getLust() >= enemyCharacter.lustThreshold()):
		if(whatHappened != ""):
			whatHappened += "\n"
		whatHappened += "Враг слишком возбужден, чтобы продолжать\n"
		battleState = "win"
		battleEndedHow = "lust"
		return "win"
	if(GM.pc.getPain() >= GM.pc.painThreshold()):
		if(whatHappened != ""):
			whatHappened += "\n"
		whatHappened += "Вы поддаетесь боли\n"
		battleState = "lost"
		battleEndedHow = "pain"
		#playAnimation(StageScene.Solo, "defeat")
		return "lost"
	if(GM.pc.getLust() >= GM.pc.lustThreshold()):
		if(whatHappened != ""):
			whatHappened += "\n"
		whatHappened += "Вы слишком возбуждены, чтобы продолжать\n"
		battleState = "lost"
		battleEndedHow = "lust"
		#playAnimation(StageScene.Solo, "defeat")
		return "lost"
	
	return ""

func pcHasAnyAttacksOfCategory(category):
	var playerAttacks = GM.pc.getAttacks(battleName)
	for attackID in playerAttacks:
		if(attackID is Dictionary):
			attackID = attackID["attackID"]
		var attack: Attack = GlobalRegistry.getAttack(attackID)
		if(attack == null):
			assert(false, "Bad attack: "+attackID)
		if(attack.category == category):
			return true
	return false
	

func addAttackButtons(category):
	var playerAttacks = GM.pc.getAttacks(battleName)
	for attackDataOrString in playerAttacks:
		var attackID
		var attackData : Dictionary
		
		if(attackDataOrString is String):
			attackData = {"attackID" : attackDataOrString}
			attackID = attackDataOrString
		else:
			attackData = attackDataOrString
			attackID = attackDataOrString["attackID"]
		
		var attack: Attack = GlobalRegistry.getAttack(attackID)
		if(attack == null):
			assert(false, "Bad attack: "+attackID)
		if(attack.category != category):
			continue
			
		var desc = attack.getRequirementsColorText(GM.pc, enemyCharacter)
		desc += attack.getVisibleDesc(attackData)
			
		if(attack.canUse(GM.pc, enemyCharacter, attackData)):
			addButton(attack.getVisibleName(attackData),  desc, "doattack", [attackData])
		else:
			addDisabledButton(attack.getVisibleName(attackData),  desc)

func setPlayerAsAttacker():
	currentAttackerID = "pc"
	currentReceiverID = enemyID

func setEnemyAsAttacker():
	currentAttackerID = enemyID
	currentReceiverID = "pc"

func resolveCustomCharacterName(_charID):
	if(_charID == "attacker" && currentAttackerID != ""):
		return currentAttackerID
	if(_charID in ["receiver", "reciever"] && currentReceiverID != ""):
		return currentReceiverID
	
	return null

func _react_scene_end(_tag, _result):
	if(_tag == "struggle_scene"):
		if(_result is Array && _result.size() > 0 && _result[0] == false):
			return
		
		setState("fighting")
		beforeTurnChecks(true)
		
		whatEnemyDid += aiTurn()

		afterTurnChecks()
	
	if(_tag == "inventory_scene"):
		if(_result is Array && _result.size() > 0 && _result[0] == false):
			return
		
		setState("fighting")
		beforeTurnChecks(true)
		
		whatEnemyDid += aiTurn()

		afterTurnChecks()
		
	if(_tag == "lootingscene"):
		endScene([battleState, battleEndedHow])
	
func supportsBattleTurns():
	return true

func saveData():
	var data = .saveData()
	
	data["enemyID"] = enemyID
	data["whatPlayerDid"] = whatPlayerDid
	data["whatEnemyDid"] = whatEnemyDid
	data["whatHappened"] = whatHappened
	data["battleState"] = battleState
	data["battleEndedHow"] = battleEndedHow
	data["savedAIAttackID"] = savedAIAttackID
	data["battleName"] = battleName
	data["currentAttackerID"] = currentAttackerID
	data["currentReceiverID"] = currentReceiverID
	data["restraintIdsForcedByPC"] = restraintIdsForcedByPC
	data["enemySurrendered"] = enemySurrendered
	data["lastPlayerAttackData"] = lastPlayerAttackData
	data["restraintsPickedCategory"] = restraintsPickedCategory
	
	if(enemyAIStrategy != null):
		data["enemyStrategyData"] = enemyAIStrategy.saveData()
	
	return data
	
func loadData(data):
	.loadData(data)
	
	enemyID = SAVE.loadVar(data, "enemyID", "")
	whatPlayerDid = SAVE.loadVar(data, "whatPlayerDid", "")
	whatEnemyDid = SAVE.loadVar(data, "whatEnemyDid", "")
	whatHappened = SAVE.loadVar(data, "whatHappened", "")
	battleState = SAVE.loadVar(data, "battleState", "")
	battleEndedHow = SAVE.loadVar(data, "battleEndedHow", "")
	savedAIAttackID = SAVE.loadVar(data, "savedAIAttackID", "")
	enemyCharacter = GlobalRegistry.getCharacter(enemyID)
	battleName = SAVE.loadVar(data, "battleName", "")
	currentAttackerID = SAVE.loadVar(data, "currentAttackerID", "")
	currentReceiverID = SAVE.loadVar(data, "currentReceiverID", "")
	restraintIdsForcedByPC = SAVE.loadVar(data, "restraintIdsForcedByPC", [])
	enemySurrendered = SAVE.loadVar(data, "enemySurrendered", false)
	lastPlayerAttackData = SAVE.loadVar(data, "lastPlayerAttackData", null)
	restraintsPickedCategory = SAVE.loadVar(data, "restraintsPickedCategory", "")
	
	enemyAIStrategy = enemyCharacter.getAiStrategy(battleName)
	enemyAIStrategy.battleName = battleName
	enemyAIStrategy.setCharacterID(enemyID)
	enemyAIStrategy.loadData(SAVE.loadVar(data, "enemyStrategyData", {}))

func getDebugActions():
	return [
		{
			"id": "instantWin",
			"name": "Мгновенная победа",
			"args": [
			],
		},
		{
			"id": "healEnemy",
			"name": "Исцелить врага",
			"args": [
			],
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "instantWin"):
		enemyCharacter.addLust(enemyCharacter.lustThreshold())
		GM.main.pickOption("wait", [])
	if(_id == "healEnemy"):
		enemyCharacter.addPain(-enemyCharacter.painThreshold())
		enemyCharacter.addLust(-enemyCharacter.lustThreshold())

func supportsShowingPawns() -> bool:
	return true

func canEquipRestraintOntoEnemySlotOrReason(itemSlot:String) -> Array:
	if(!enemyCharacter.invCanEquipSlot(itemSlot)):
		return [false, "Не удается нацепить это средство сдерживания"]
	elif(enemyCharacter.getInventory().hasSlotEquipped(itemSlot) && enemyCharacter.getInventory().getEquippedItem(itemSlot).isRestraint()):
		return [false, "На них уже надето такое средство сдерживания"]
	return [true, ""]

func getNPCStatus(_npc:BaseCharacter) -> int:
	var _result:int = 0
	if(_npc.hasEffect(StatusEffect.Collapsed)):
		_result |= CombatAnimPlayer.ST_KNOCKEDDOWN
	if(_npc.isDefocusing()):
		_result |= CombatAnimPlayer.ST_DEFOCUSING
	if(_npc.isBlocking()):
		_result |= CombatAnimPlayer.ST_BLOCKING
	if(_npc.isDodging()):
		_result |= CombatAnimPlayer.ST_DODGING
	return _result

func playAttackAnim(_attackResult:Dictionary, _pcAttacks:bool, _pcStatus:int = 0, _npcStatus:int = 0):
	var theAttackAr = _attackResult.get("attackerAnimation", "")
	var _attackID:String = theAttackAr if (theAttackAr is String) else theAttackAr[0]
	var _customWep:String = theAttackAr[1] if ((theAttackAr is Array) && (theAttackAr.size() > 1)) else ""
	var _didMiss:bool = _attackResult.get("missed", false)
	var _didDodge:bool = _attackResult.get("dodged", false)
	var _attackerID:int = 0 if _pcAttacks else 1
	
	_pcStatus |= getNPCStatus(GM.pc)
	_npcStatus |= getNPCStatus(enemyCharacter)
	if(_didMiss):
		if(_pcAttacks):
			_pcStatus |= CombatAnimPlayer.ST_MISSED
		else:
			_npcStatus |= CombatAnimPlayer.ST_MISSED
	if(_didDodge):
		if(_pcAttacks):
			_npcStatus |= CombatAnimPlayer.ST_DODGING
		else:
			_pcStatus |= CombatAnimPlayer.ST_DODGING
	
	var _payload:Array = [
		_attackID, _attackerID, _pcStatus if _pcAttacks else _npcStatus, _pcStatus if !_pcAttacks else _npcStatus, _customWep,
	]
	playAnimation(StageScene.Combat, "", {npc=enemyID, pc="pc", attack=_payload})
	
func playGetUpAnimsIfNeedTo():
	var _pcStatus:int = getNPCStatus(GM.pc)
	var _npcStatus:int = getNPCStatus(enemyCharacter)
	
	playAnimation(StageScene.Combat, "", {npc=enemyID, pc="pc", pcStance=GM.pc.getCombatStance(), npcStance=enemyCharacter.getCombatStance() if enemyCharacter else 0, statusUpdate=[_pcStatus, _npcStatus]})

func playDefeatAnim():
	if(state == "lost"):
		playAnimation(StageScene.Combat, ("defeat" if !GM.pc.hasEffect(StatusEffect.Collapsed) else "knockedDownDefeat"), {npc=enemyID, pc="pc"})
	if(state == "win"):
		playAnimation(StageScene.Combat, "", {npc=enemyID, pc="pc", npcAction=("defeat" if !enemyCharacter.hasEffect(StatusEffect.Collapsed) else "knockedDownDefeat")})
	
