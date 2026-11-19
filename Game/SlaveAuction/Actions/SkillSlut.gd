extends AuctionAction

func _init():
	id = "SkillSlut"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Навык шлюхи"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave’s extensive training as a Slut.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Эта особа не понаслышке знает о плотских утехах. {slave.He} {slave.isAre} отлично натренированная шлюшка, готовая исполнить любые твои желания!",
		"Благодаря правильному обучению, {slave.he} в совершенстве овладела искусством наслаждения. Настоящая шлюха во всех смыслах этого слова.",
		"Эти бедра? Эти губы? Их натренировали, чтобы они приносили удовольствие. И поверь мне, {slave.he} точно знает, как доставить наслаждение другим.",
		"Эта рабыня была доведена до совершенства. Каждый стон, каждое прикосновение тщательно отточены. Эта шлюшка будет превосходно служить тебе во всех интимных делах.",
		"Ищешь рабыню, обученную дарить удовольствие? Перед тобой идеальный кандидат. {slave.He} точно знает, как удовлетворить любого.",
		"Ищешь хорошую шлюху? Чтобы создать шлюху такого калибра, потребовалось самое лучшее обучение. {slave.He} {slave.isAre} настоящий эксперт во всех искусствах соблазнения.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"SkillSlut": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I like a well-trained whore.',
		'Seems like a good investment.',
		'With skills like that, this one will earn back the investment quickly.',
		'Perfectly trained to please? Yes please.',
		'Training sluts is so annoying. So this is worth it.',
		'Sounds like a perfect addition to my collection of fucktoys.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I don\'t need a whore.',
		'I\'m not looking for sluts.',
		'You\'re selling a whore? Ugh.',
		'I don\'t like total whores.',
		'I\'d rather not.',
		'I can buy whores off of streets for dirt-cheap.',
	])
	
