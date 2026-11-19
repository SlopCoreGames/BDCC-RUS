extends AuctionAction

func _init():
	id = "EmphasizeBreasts"

func getActionType():
	return AuctionActionType.Emphasize

func getName() -> String:
	return "Грудь"

func getButtonDesc() -> String:
	return "По-настоящему выставить напоказ грудь рабыни.\n\nНе раскрывает никаких предпочтений; оказывает негативное влияние на участников аукциона, у которых нет сильного предпочтения к представленным чертам."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("BreastsSmall") && _slaveTraits["BreastsSmall"] > 0.0):
		if(!_char.hasNonFlatBreasts()):
			saynn("{presenter.You} нежно {presenter.youVerb('cup')} грудные мышцы раба, слегка приподнимая их и привлекая внимание к мужским соскам. {presenter.YourHis} руки скользят по ним, касаясь их так, что это одновременно обнажает и подчеркивает их красоту.")
			
			sayPresenter("Аккуратные, правда? Для тех, кто ценит мощные, выразительные формы — это идеальный вариант.")
		else:
			saynn("{presenter.You} нежно {presenter.youVerb('cup')} {slave.breasts} раба, слегка приподнимая их и привлекая внимание к их изящному размеру. {presenter.YourHis} руки скользят по ним, касаясь их так, что это одновременно обнажает и подчеркивает их красоту.")
			
			sayPresenter("Миленькие, не так ли? Для тех, кто предпочитает более изящные формы — самое то.")
	if(_slaveTraits.has("BreastsAverage") && _slaveTraits["BreastsAverage"] > 0.0):
		saynn("{presenter.You} {presenter.youVerb('move')} ближе к {slave.name}, обхватывая {slave.hisHer} {slave.breasts} в {presenter.YourHis} руках и слегка приподнимая их, чтобы дать участникам торгов четкий обзор. {presenter.YouHe} {presenter.youHeVerb('run')} большими пальцами по {slave.hisHer} соскам, чтобы подчеркнуть их упругость.")
	
		sayPresenter("Какие же красивые, упругие крошки. Поверьте мне, их невероятно приятно тискать.")
	if(_slaveTraits.has("BreastsHuge") && _slaveTraits["BreastsHuge"] > 0.0):
		saynn("{presenter.You} {presenter.youVerb('approach', 'approaches')} {slave.name}, прежде чем сжать {slave.hisHer} {slave.breasts} обеими руками, слегка приподнимая и сжимая их, чтобы подчеркнуть их пышность. {presenter.YouHe} {presenter.youHeVerb('smile')} на участников торгов, продолжая демонстрировать им эти тяжелые изгибы.")
	
		sayPresenter("Вы только гляньте на этот размер! Налитые, мягкие, их так и хочется сжать. Поверьте, лучше пары вы не найдете.")

func getTraits() -> Dictionary:
	return {
		"BreastsSmall": 2.0,
		"BreastsAverage": 2.0,
		"BreastsHuge": 2.0,
	}

func getPassiveDesireGain() -> float:
	return -1.0

func isEmphasizeAction() -> bool:
	return true

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("BreastsSmall") && _slaveTraits["BreastsSmall"] > 0.0):
		if(!_char.hasNonFlatBreasts()):
			return RNG.pick([
				'Плоская и подтянутая — как раз то, что я люблю.',
				'Упругая, плоская грудь? Да, пожалуй, возьму.',
				'Так изящно.',
				'Такая стройная.',
				'Именно то, что я ищу.',
				'Мускулистая и плоская.',
				'Эта плоская грудь идеально подходит для моих целей.',
			])
		else:
			return RNG.pick([
				'Я предпочитаю маленькую грудь, она куда милее.',
				'Подтянутая и крошечная? Да я в любой день предпочту это огромным сиськам.',
				'Маленькая и упругая. Прямо как я люблю.',
				'Размер не имеет значения, когда они выглядят настолько идеально.',
				'Стройные и прекрасные.',
				'Эти маленькие, упругие груди? Идеал.',
			])
	if(_slaveTraits.has("BreastsAverage") && _slaveTraits["BreastsAverage"] > 0.0):
		return RNG.pick([
			'Вот это то, что доктор прописал.',
			'Perfect!',
			'Это просто идеал.',
			'Хм. Да. В самый раз — не слишком много и не слишком мало.',
			'Идеальная грудь.',
			'А сиськи-то что надо.',
			'Yes!',
		])
	if(_slaveTraits.has("BreastsHuge") && _slaveTraits["BreastsHuge"] > 0.0):
		return RNG.pick([
			'Дай мне, дай мне!',
			'Ох, это моя слабость.',
			'Как раз под мой вкус. Обожаю, когда есть за что пощупать!',
			'Эти огромные красавицы? Да!',
			'Наконец-то хоть что-то внушительного размера.',
			'Чем больше, тем лучше.',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)
