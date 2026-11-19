extends AuctionAction

func _init():
	id = "EmphasizeHoles"

func getActionType():
	return AuctionActionType.Emphasize

func getName() -> String:
	return "Дырки"

func getButtonDesc() -> String:
	return "Spread the slave's butt and really show off their holes.\n\nDoesn't reveal any preferences, has a negative effects on bidders who don't strongly prefer any of the presented traits."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	var hasVag:bool = _char.hasVagina()
	var vagTight:bool = (_slaveTraits.has("VaginaTight") && _slaveTraits["VaginaTight"] > 0.0)
	#var vagLoose:bool = (_slaveTraits.has("VaginaLoose") && _slaveTraits["VaginaLoose"] > 0.0)
	var anusTight:bool = (_slaveTraits.has("AnusTight") && _slaveTraits["AnusTight"] > 0.0)
	#var anusLoose:bool = (_slaveTraits.has("AnusLoose") && _slaveTraits["AnusLoose"] > 0.0)
	
	if(hasVag):
		if(vagTight && anusTight):
			saynn("{presenter.You} {presenter.youVerb('step')} стоит позади {slave.name}, хватая {slave.hisHer} за бедра и слегка оттягивая {slave.himHer} назад, чтобы продемонстрировать {slave.hisHer} идеально подтянутое тело. Медленно, {presenter.youHe} {presenter.youHeVerb('spread')} {slave.hisHer} разводит ягодицы в стороны, открывая торгующимся как {slave.hisHer} тугую, манящую киску, так и сжатый анус.")
			
			sayPresenter("Take a look, folks! This slave comes with two tightly wrapped packages for your pleasure. You won’t find anything as snug as this, built to grip and squeeze every inch you give.")
			
			saynn("{presenter.YouHe} {presenter.youHeVerb('run')} дразняще водит пальцами вокруг {slave.hisHer} отверстий, подчеркивая, насколько они тугие и нетронутые.")
			
			sayPresenter("Both holes, perfectly tight, perfectly ready for whatever you choose.")
		elif(vagTight || anusTight):
			saynn("Уверенной рукой {presenter.you} {presenter.youVerb('take')} хватает {slave.name} за бедра, притягивая {slave.himHer} назад и широко разводя {slave.hisHer} ягодицы, открывая участникам аукциона идеальный вид на киску и анус.")
			
			sayPresenter("Let’s get a good look at what’s on offer. {slave.He} {slave.isAre} ready from both ends, eager and waiting for whatever you decide to fill.")
			
			saynn("{presenter.YouHe} {presenter.youHeVerb('make')} чтобы все участники аукциона могли разглядеть всё до мельчайших подробностей, проводя {presenter.yourHis} пальцами возле {slave.hisHer} отверстий.")
			
			sayPresenter("Two perfect holes, versatile and ready for all kinds of play.")
		else:
			saynn("{presenter.You} уверенно {presenter.youVerb('step')} позади рабыни, крепко сжимая {slave.hisHer} бедра и широко разводя {slave.hisHer} ягодицы, чтобы продемонстрировать торгующимся изрядно растянутые, зияющие дырки и {slave.hisHer} киски, и ануса.")
			
			sayPresenter("Here we have a slave who’s clearly seen some use! Look at how loose these holes are, ready to take whatever you throw at them.")
		
			saynn("{presenter.YouHe} {presenter.youHeVerb('trace')} края обоих зияющих отверстий, показывая, насколько они открыты и манящи.")

			sayPresenter("Plenty of space to fill, whether you choose the front or the back. It’s all ready for more!")
	else:
		if(anusTight):
			saynn("{presenter.You} {presenter.youVerb('step')} заходит со спины рабыни, кладет обе руки на {slave.hisHer} бедра и разводит {slave.hisHer} ягодицы, выставляя перед участниками аукциона тугое, сморщенное анус.")
			
			sayPresenter("Here we have a perfectly tight hole, ready for anyone who enjoys a little resistance. Just look at how clenched {slave.hisHer} little back door is.")
			
			saynn("{presenter.YouHe} слегка разводит {presenter.youHeVerb('press', 'presses')} по краям, позволяя участникам аукциона отчетливо рассмотреть, насколько всё там туго.")
			
			sayPresenter("Perfectly tight, ready to grip every inch you give.")
		else:
			saynn("Уверенным хватом {presenter.you} отводит {presenter.youVerb('pull')} бедра рабыни назад и {presenter.youVerb('spread')} широко разводит {slave.hisHer}, демонстрируя всем участникам аукциона её расслабленный, привыкший к использованию анус.")
			
			sayPresenter("Now, this one here’s seen some use! Just look at how open this hole is, no need to worry about tightness here.")
			
			saynn("{presenter.YouHe} растягивает {presenter.youHeVerb('trace')} по краям, чтобы участники аукциона могли увидеть, как много там места.")
			
			sayPresenter("Plenty of space for any kind of play. This one’s ready to take whatever you’ve got!")
	
func getTraits() -> Dictionary:
	return {
		"VaginaTight": 2.0,
		"VaginaLoose": 2.0,
		"AnusTight": 2.0,
		"AnusLoose": 2.0,
	}

func getPassiveDesireGain() -> float:
	return -1.0

func isEmphasizeAction() -> bool:
	return true

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("AnusTight") && _slaveTraits["AnusTight"] > 0.0 && _slaveTraits.has("VaginaTight") && _slaveTraits["VaginaTight"] > 0.0):
		return RNG.pick([
			'A tight one, huh? That’s what I like to hear.',
			'Perfect, I’ve been wanting something fresh like that.',
			'Tight? That’s enough to get my interest.',
			'Sounds like the ideal ass for me.',
			'Oh yeah, I will enjoy stretching {slave.her} out.',
			'The things I can do to such a hole..',
		])
	else:
		return RNG.pick([
			'Now that’s what I like to see.',
			'Perfect!',
			'Well-used and no complaints - that’s exactly what I need.',
			'Loose, huh? That’s perfect for my plans.',
			'This one’s going to get a lot of use!',
		])
	
	#return .getPositiveReaction(_char, _slaveTraits)
