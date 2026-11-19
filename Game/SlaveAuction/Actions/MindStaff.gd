extends AuctionAction

func _init():
	id = "MindStaff"

func getActionType():
	return AuctionActionType.Mind

func getName() -> String:
	return "Бывший персонал"

func getButtonDesc() -> String:
	return "Explain how this slave was previously one of the staff members.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	var whoName:String = "staff"
	if(_char.isGuard()):
		whoName = "guard"
	if(_char.isNurse()):
		whoName = "nurse"
	if(_char.isEngineer()):
		whoName = "engineer"
	
	sayPresenter(RNG.pick([
		"Эта милашка когда-то была частью персонала тюрьмы АльфаКорп. Доверенная, "+whoName+" которая знает все тонкости этого места. А теперь ты можешь оставить {slave.him} себе в качестве игрушки!",
		"Задумывались ли вы, каково это — сломить того, кто раньше сам держал ключи? Что ж, вот ваш шанс. Эта рабыня раньше была "+whoName+" в тюрьме АльфаКорп!",
		"{slave.He} когда-то раздавала приказы, но теперь {slave.he} только подчиняется. Это бывшая"+whoName+" тюрьмы АльфаКорп! Смена ролей, не находите?",
		"Из "+whoName+" в тюрьме АльфаКорп — в рабыню. От надзора за дисциплиной до её личного познания на собственной шкуре: эта девчонка прошла через невероятную трансформацию!",
		"Когда-то гордая сотрудница тюрьмы АльфаКорп, "+whoName+"теперь она готова служить совсем по-другому. Можете в это поверить? Смена власти неоспорима!",
		"Это бывшая —"+whoName+" заключенная тюрьмы АльфаКорп! Вы можете владеть той, кто когда-то мнила, будто всё держит под контролем. Она думала, что её невозможно приручить. Но теперь всё изменилось!",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"MindStaff": 1.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I’ll pay extra!',
		'That’s unique.',
		'Oh, the irony.',
		'That’s an irresistible twist.',
		'Owning someone with that background is.. satisfying.',
		'I love even just the idea.',
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'I don\'t need problems with AlphaCorp.',
		'No thanks, that is too much.',
		'I think this can quickly become a problem.',
		'AlphaCorp slave? Ehh.',
		'I\'d rather not.',
	])
	
