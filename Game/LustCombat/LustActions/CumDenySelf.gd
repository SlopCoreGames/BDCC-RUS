extends LustAction

func _init():
	id = "CumDenySelf"
	isOrgasmAction = true
	
func shouldShow(_lustState: LustCombatState, _args):
	return true

func canDo(_lustState: LustCombatState, _args):
	var pc: Player = _lustState.getCharacter()
	if(pc.getStamina() <= 0):
		return [false, "У тебя уже не хватит воли, чтобы остановиться сейчас..."]
	return .canDo(_lustState, _args)

func getVisibleName(_lustState: LustCombatState, _args):
	return "Отказ себе"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Идя наперекор собственному желанию, вы тратите 20 единиц выносливости, чтобы подавить оргазм."

func doAction(_lustState: LustCombatState, _args):
	#_lustState.getCharacter().addLust(1)
	#_lustState.startActivity(LustActivity.StrokingCock)
	var pc: Player = _lustState.getCharacter()
	pc.addStamina(-20)
	pc.addLust( -int(float(pc.getLust()) / 2) )

	if(_lustState.isInBattle()):
		pc.addEffect(StatusEffect.DeniedDesperate, [2])

	var text = ""
	if(RNG.chance(50)):
		text += "Вы чувствуете, что находитесь на самом пике. Вам нужно лишь еще капельку стимуляции, чтобы получить это сладкое облегчение... но вместо этого вы замираете и позволяете возбуждению утихнуть. Вы лишаете себя долгожданного оргазма, и от этого нетерпеливо извиваетесь в отчаянии!"
		text += "\n\n"
	else:
		text += "Разрядка уже так близко, нужно лишь еще совсем чуть-чуть... Но нет, собрав всю свою волю в кулак, вы идете против своих желаний и подавляете оргазм. Вы замираете, ожидая, пока волна удовольствия спадет. Вы пропустили этот раз, и теперь от этого желания получить следующий становится просто невыносимым!"
		text += "\n\n"

	return {
		text = text,
		came = true,
		anim = "RemoveAllRestraints",
	}

func getLustTopics():
	return {
		InterestTopic.FeminineBody : 0.2,
		InterestTopic.MasculineBody : 0.2,
		InterestTopic.AndroBody : 0.2,
	}

func getPriority():
	return 0

func getExperience(_lustState: LustCombatState, _args):
	if(_lustState.isInPublic()):
		return [[Skill.Exhibitionism, 2]]
	return []
