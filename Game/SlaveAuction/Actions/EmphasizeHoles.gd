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
			
			sayPresenter("Взгляните, господа! Эта рабыня идет в комплекте с двумя туго сжатыми свертками для вашего удовольствия. Вы не найдете ничего более узкого — она создана, чтобы обхватывать и сжимать каждый дюйм, который вы в нее вставите.")
			
			saynn("{presenter.YouHe} {presenter.youHeVerb('run')} дразняще водит пальцами вокруг {slave.hisHer} отверстий, подчеркивая, насколько они тугие и нетронутые.")
			
			sayPresenter("Оба отверстия идеально узкие и полностью готовы к любым вашим желаниям.")
		elif(vagTight || anusTight):
			saynn("Уверенной рукой {presenter.you} {presenter.youVerb('take')} хватает {slave.name} за бедра, притягивая {slave.himHer} назад и широко разводя {slave.hisHer} ягодицы, открывая участникам аукциона идеальный вид на киску и анус.")
			
			sayPresenter("Давайте хорошенько разглядим, что тут у нас на торги. {slave.He} {slave.isAre} готовы с обеих сторон, жаждут и ждут, чем именно вы решите их наполнить.")
			
			saynn("{presenter.YouHe} {presenter.youHeVerb('make')} чтобы все участники аукциона могли разглядеть всё до мельчайших подробностей, проводя {presenter.yourHis} пальцами возле {slave.hisHer} отверстий.")
			
			sayPresenter("Два идеальных отверстия, универсальных и готовых к любым видам ласк.")
		else:
			saynn("{presenter.You} уверенно {presenter.youVerb('step')} позади рабыни, крепко сжимая {slave.hisHer} бедра и широко разводя {slave.hisHer} ягодицы, чтобы продемонстрировать торгующимся изрядно растянутые, зияющие дырки и {slave.hisHer} киски, и ануса.")
			
			sayPresenter("А вот перед нами рабыня, которую явно уже не раз использовали! Посмотрите, насколько эти дырки расслаблены — они готовы принять всё, что вы в них засунете.")
		
			saynn("{presenter.YouHe} {presenter.youHeVerb('trace')} края обоих зияющих отверстий, показывая, насколько они открыты и манящи.")

			sayPresenter("Там полно места, чтобы заполниться, выбирайте — спереди или сзади. Всё уже готово к продолжению!")
	else:
		if(anusTight):
			saynn("{presenter.You} {presenter.youVerb('step')} заходит со спины рабыни, кладет обе руки на {slave.hisHer} бедра и разводит {slave.hisHer} ягодицы, выставляя перед участниками аукциона тугое, сморщенное анус.")
			
			sayPresenter("А здесь у нас идеально узкое отверстие, готовое для тех, кто любит небольшое сопротивление. Только посмотрите, как плотно сжата эта маленькая задняя дверца {slave.hisHer}.")
			
			saynn("{presenter.YouHe} слегка разводит {presenter.youHeVerb('press', 'presses')} по краям, позволяя участникам аукциона отчетливо рассмотреть, насколько всё там туго.")
			
			sayPresenter("Идеально узкое, готово обхватить каждый дюйм вашего достоинства.")
		else:
			saynn("Уверенным хватом {presenter.you} отводит {presenter.youVerb('pull')} бедра рабыни назад и {presenter.youVerb('spread')} широко разводит {slave.hisHer}, демонстрируя всем участникам аукциона её расслабленный, привыкший к использованию анус.")
			
			sayPresenter("Ну, а вот эта девчонка уже повидала виды! Посмотрите, насколько широко раскрыто это отверстие — о тесноте здесь можно не беспокоиться.")
			
			saynn("{presenter.YouHe} растягивает {presenter.youHeVerb('trace')} по краям, чтобы участники аукциона могли увидеть, как много там места.")
			
			sayPresenter("Там полно места для любых извращений. Эта штучка готова принять всё, что у вас есть!")
	
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
