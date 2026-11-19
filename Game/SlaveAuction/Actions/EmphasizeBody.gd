extends AuctionAction

func _init():
	id = "EmphasizeBody"

func getActionType():
	return AuctionActionType.Emphasize

func getName() -> String:
	return "Тело"

func getButtonDesc() -> String:
	return "Подчеркнуть изгибы тела и женственность/мужественность рабыни.\n\nНе раскрывает конкретных предпочтений; оказывает негативный эффект на участников аукциона, у которых нет сильного влечения к представленным чертам."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	var isMasc:bool = (_slaveTraits.has("Masculine") && _slaveTraits["Masculine"] > 0.0)
	var isAndr:bool = (_slaveTraits.has("Androgynous") && _slaveTraits["Androgynous"] > 0.0)
	var isFemi:bool = (_slaveTraits.has("Feminine") && _slaveTraits["Feminine"] > 0.0)
	var isSlim:bool = (_slaveTraits.has("BodySlim") && _slaveTraits["BodySlim"] > 0.0)
	var isAver:bool = (_slaveTraits.has("BodyAverage") && _slaveTraits["BodyAverage"] > 0.0)
	var isThic:bool = (_slaveTraits.has("BodyThick") && _slaveTraits["BodyThick"] > 0.0)
	
	if(isFemi):
		if(isSlim):
			saynn("{presenter.You} {presenter.youVerb('step')} ближе к {slave.name}, проводя {presenter.yourHis} руками по {slave.hisHer} нежной, стройной фигуре. Крепко сжав, {presenter.youHe} {presenter.youHeVerb('pull')} {slave.himHer} вперед, чтобы дать участникам торгов получше рассмотреть представленную перед ними женскую красоту.")
			
			sayPresenter("Посмотрите на эту стройную красавицу... грациозную, утонченную и воплощение женственности. Тело, созданное для элегантности и послушания.")
		if(isAver):
			saynn("С уверенной улыбкой, {presenter.you} {presenter.youVerb('approach', 'approaches')} рабыню, прежде чем скользнуть {presenter.yourHis} руками по мягким изгибам {slave.hisHer} пропорционального тела. {slave.thick} очертания {slave.hisHer} бедер и талии источают невероятно манящее женское очарование.")
			
			sayPresenter("Насладитесь этими идеальными пропорциями — сбалансированными, девичьими и готовыми служить вам любым способом, как пожелаете.")
		if(isThic):
			saynn("{presenter.You} {presenter.youVerb('approach', 'approaches')} {slave.name}, прежде чем положить {presenter.yourHis} руки на полные, округлые бедра рабыни, проводя ими по пышной фигуре перед толпой. {slave.HeShe} излучает мощную женственность, а мягкие, сочные изгибы так и манят взгляды.")
			
			sayPresenter("Этому телу просто невозможно сопротивляться... пышное и неоспоримо женственное. В нем есть вся та мягкость, о которой можно только мечтать.")
	if(isAndr):
		if(isSlim):
			saynn("{presenter.You} {presenter.youVerb('step')} к {slave.name}, {presenter.yourHis} руками очерчивая тонкие, андрогинные линии {slave.hisHer} тела. {presenter.YouHe} {presenter.youHeVerb('let')} игра света от проектора на этом подтянутом теле... подчеркивающая все изгибы.")
			
			sayPresenter("Это нечто поистине уникальное — стройное тело, балансирующее на грани между женским и мужским, что придется по вкусу тем, кто ценит обе стороны.")
		if(isAver):
			saynn("Стоя вплотную к {slave.name}, {presenter.you} {presenter.youVerb('let')} твои руки скользят по {slave.hisHer} нейтральному, сбалансированному телосложению. {slave.HisHer} тело не слишком женственное и не слишком мужественное, с пропорциями, представляющими собой гармоничную середину... так что {presenter.youHe} {presenter.youHeVerb('make')} не забудь подчеркнуть это.")
			
			sayPresenter("Идеальное тело... не слишком мягкое, но и не слишком жесткое. Оно адаптируется к любой роли, готовое служить так, как вы сочтете нужным.")
		if(isThic):
			saynn("{presenter.You} {presenter.youVerb('place')} {presenter.yourHis} крепко прижимает руки к {slave.name} плотному, крепкому телу, акцентируя внимание на массивном, но равномерно развитом телосложении. Ни особо мужском, ни особо женском...")
			
			sayPresenter("Взгляните на это крепкое, плотное телосложение. Сбалансированное во всем... идеально подходящее для любой задачи или роли, которую вы задумали.")
	if(isMasc):
		if(isSlim):
			saynn("{presenter.You} {presenter.youVerb('approach', 'approaches')} {slave.name}, проводя {presenter.yourHis} руками по тугим, твердым линиям {slave.hisHer} подтянутого тела. Мужественные черты едва уловимы, но отчетливы: под стройным телосложением скрывается сила.")
			
			sayPresenter("Посмотрите на эту стройную фигуру... от которой так и веет первобытной силой. Это тело создано для службы и выносливости.")
		if(isAver):
			saynn("{presenter.You} {presenter.youVerb('step')} подходит к {slave.name}, позволяя {presenter.yourHis} рукам скользить по {slave.hisHer} твердой, рельефной груди и плечам. Пропорции сильные и мужественные, с достаточным количеством мышц, обещающим мощь, но без избыточной массивности.")
			
			sayPresenter("Сильное, сбалансированное и мужественное. Эта особа будет служить с мощью и грацией — идеал для тех, кто ценит твердую руку.")
		if(isThic):
			saynn("{presenter.You} {presenter.youVerb('place')} {presenter.yourHis} кладет руки на широкие, мощные плечи {slave.name}, ведя ими вниз по {slave.hisHer} крепкому, мускулистому телу. Каждый дюйм {slave.himHer} источает силу и доминирование — поистине внушительная фигура.")
			
			sayPresenter("А вот и тело, созданное для власти и контроля... Крепкое, мужественное и готовое к работе любым возможным способом.")
			

func getTraits() -> Dictionary:
	return {
		"Masculine": 2.0,
		"Androgynous": 2.0,
		"Feminine": 2.0,
		"BodySlim": 2.0,
		"BodyAverage": 2.0,
		"BodyThick": 2.0,
	}

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("Masculine") && _slaveTraits["Masculine"] > 0.0):
		return RNG.pick([
			'Крепкая, мне такое нравится.',
			'Очень мощная.',
			'Впечатляющее телосложение.',
			'Perfection.',
			'Вот это другое дело.',
			'Вот это да, тело что надо.',
		])
	if(_slaveTraits.has("Androgynous") && _slaveTraits["Androgynous"] > 0.0):
		return RNG.pick([
			'Perfection.',
			'Captivating.',
			'Определенно интересно.',
		])
	if(_slaveTraits.has("Feminine") && _slaveTraits["Feminine"] > 0.0):
		return RNG.pick([
			'Красивая и грациозная.',
			'В самый раз, такая девчачья!',
			'Та самая мягкость, которую я люблю.',
			'Gorgeous.',
			'Настоящая красавица.',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)
	
func getPassiveDesireGain() -> float:
	return -1.0

func isEmphasizeAction() -> bool:
	return true

func getSlaveReaction(_char:BaseCharacter, _reactionType) -> String:
	if(_reactionType == AuctionSlaveReaction.Obedient):
		return RNG.pick([
			"{slave.name} замер(ла) как вкопанный(ая), пока руки {presenter.yourHis} скользят по телу {slave.hisHer}, а {slave.hisHer} голова покорно склонена в безмолвном подчинении. {slave.HeShe} принимает это внимание без малейшего сопротивления, готовый(ая) предстать перед публикой.",
			"{slave.name} даже не вздрагивает, лишь слегка поправляет {slave.hisHer} осанку, чтобы {presenter.you} было проще демонстрировать {slave.himHer} толпе. Каждое движение выверено и исполнено с покорностью.",
			"{slave.name} без протеста принимает позу {slave.hisHer}, выпрямившись во весь рост, пока {presenter.you} {presenter.youVerb('emphasize')} каждый дюйм {slave.hisHer} тела на виду у участников аукциона.",
			"{slave.name} держит {slave.hisHer} глаза опущенными, молча позволяя {presenter.you} демонстрировать {slave.hisHer} тело; каждое движение выверено и покорно.",
			"{slave.name} стоит неподвижно, шевелясь лишь тогда, когда это необходимо, чтобы отдать {presenter.you} полный контроль над демонстрацией, проявляя абсолютную покорность во всем.",
			"{slave.name} замирает, не шевелясь, и позволяет {presenter.you} беспрепятственно демонстрировать {slave.hisHer} тело участникам аукциона. {slave.HeShe} не оказывает никакого сопротивления, смиренно принимая свою {slave.hisHer} роль на торгах.",
		])
	if(_reactionType == AuctionSlaveReaction.Confused):
		return RNG.pick([
			"{slave.name} бросает на {presenter.you} мягкий, растерянный взгляд, не понимая, что происходит, но не оказывая никакого сопротивления, пока {presenter.you} выставляет {slave.hisHer} тело напоказ перед толпой.",
			"Глаза {slave.name} вспыхивают печалью, но {slave.heShe} замирает, позволяя {presenter.you} подчеркнуть {slave.hisHer} формы, несмотря на явное замешательство во {slave.hisHer} взгляде.",
			"С губ {slave.name} срывается тихий вздох, когда {presenter.you} {presenter.youVerb('trace')} {slave.hisHer} принимают форму; в {slave.hisHer} читается замешательство, но {slave.heShe} не сопротивляется {presenter.your} прикосновениям.",
			"{slave.name} прикусывает {slave.hisHer} губу, в глазах отражается печаль, пока {presenter.you} {presenter.youVerb('show')} по {slave.hisHer} телу. В воздухе висит замешательство, но {slave.heShe} остается пассивной под контролем {presenter.your}.",
			"{slave.name} стоит с печальным выражением лица, явно не понимая, что происходит, но покорно принимает позу, пока {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} выставляется напоказ перед участниками аукциона.",
			"{slave.name} уставилась в пол, и печать грусти легла на {slave.hisHer} лицо, но {slave.heShe} не сопротивляется, когда {presenter.you} {presenter.youVerb('run')} {presenter.your} отдает {slave.hisHer} свое тело.",
		])
	if(_reactionType == AuctionSlaveReaction.Shy):
		return RNG.pick([
			"{slave.name} густо краснеет, и ярко-алый румянец заливает {slave.hisHer} щеки, пока {presenter.you} {presenter.youVerb('run')} {presenter.your} выставляет напоказ {slave.hisHer} тело. {slave.HeShe} слегка ерзает, явно сгорая от смущения.",
			"{slave.name} извивается, {slave.hisHer} лицо пылает, пока {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} тело перед толпой. {slave.HeShe} не может скрыть робкого дискомфорта, охватившего {slave.himHer}.",
			"С губ {slave.name} срывается тихий вздох, {slave.hisHer} щеки горят от стыда, когда {presenter.you} {presenter.youVerb('trace')} {slave.hisHer} тело, делая {slave.himHer} центром всеобщего внимания.",
			"{slave.name} отводит взгляд, лицо горит от робкого смущения, пока {presenter.you} {presenter.youVerb('run')} {presenter.your} выставляет напоказ {slave.hisHer} тело, явно ошеломленная таким вниманием.",
			"Тело {slave.name} слегка дрожит, когда {presenter.you} {presenter.youVerb('highlight')} {slave.hisHer} тело; густой румянец ползет вверх по {slave.hisHer} шее — слишком стыдно, чтобы встретиться взглядом с участниками торгов.",
			"{slave.name} отворачивает лицо {slave.hisHer}, щеки {slave.hisHer} пылают красным, пока {presenter.you} {presenter.youVerb('display')} {slave.hisHer} тело на потеху толпе, смущенная и взволнованная под прицелом взглядов.",
		])
	if(_reactionType == AuctionSlaveReaction.MindBroken):
		return RNG.pick([
			"{slave.name} замер(ла), глядя в пустоту тусклым, расфокусированным взглядом, пока {presenter.you} {presenter.youVerb('touch', 'touches')} {slave.hisHer} тело. Никакой реакции, {slave.heShe}, кажется, даже не замечает, что происходит.",
			"{slave.name} замерла, {slave.hisHer} взгляд {presenter.you} пустой, пока {presenter.youVerb('emphasize')} {slave.hisHer} обретают форму. {slave.HeShe} полностью оторвана от реальности и не реагирует на {presenter.your} прикосновения.",
			"Тело {slave.name} обмякло, а разум {slave.hisHer} настолько помутился, что ей уже плевать на то, что её выставляют напоказ. {slave.HeShe} не оказывает никакого сопротивления и даже не осознает, что происходит вокруг {slave.himHer}.",
			"{slave.name} отсутшенно смотрит вдаль, совершенно не замечая прикосновений {presenter.your}. {slave.HeShe} никак не реагирует на то, как {presenter.you} {presenter.youVerb('highlight')} {slave.hisHer} тело, сломленное до неузнаваемости.",
			"{slave.name} не двигается, взгляд пустой, пока {presenter.you} {presenter.youVerb('present')} {slave.hisHer} тело. {slave.HeShe} стоит как безжизненная кукла, не замечая всеобщего внимания.",
			"{slave.name} замерла, и ни одна эмоция не отражается на {slave.hisHer} лице, пока {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} тело. Для {slave.himHer} аукциона будто и вовсе не существует.",
		])
	if(_reactionType == AuctionSlaveReaction.Desperate):
		return RNG.pick([
			"{slave.name} ерзает на месте, в {slave.hisHer} широко раскрытых глазах читаются замешательство и паника, пока {presenter.you} {presenter.youVerb('display')} {slave.hisHer} тело перед участниками торгов. {slave.HeShe} дергает за {slave.hisHer}, но всё без толку.",
			"Дыхание {slave.name} учащается, в {slave.hisHer} глазах читается отчаяние, пока {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer}. {slave.HeShe} лихорадочно оглядывается по сторонам, явно не понимая, что происходит.",
			"{slave.name} в замешательстве смотрит на {presenter.you}, тяжело дыша, пока {presenter.youHe} {presenter.youHeVerb('show')} {slave.hisHer} тело. В глазах {slave.hisHer} мелькает отчаяние — она не знает, чего ожидать.",
			"{slave.name} беспокойно ерзает, дергая за {slave.hisHer} цепи, пока {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} тело. {slave.HeShe} кажется потерянной и отчаявшейся, сбитой с толку этим вниманием.",
			"{slave.name} дрожит, когда {presenter.you} {presenter.youVerb('run')} {presenter.your} отдает {slave.hisHer} тело; страх и замешательство смешиваются с отчаянием во {slave.hisHer} взгляде.",
			"{slave.name} уставилась на толпу, {slave.hisHer} грудь часто вздымается и опускается, пока {presenter.you} {presenter.youVerb('display')} {slave.hisHer} тело; она явно подавлена смятением и паникой.",
		])
	if(_reactionType == AuctionSlaveReaction.Angry):
		return RNG.pick([
			"{slave.name} яростно смотрит на {presenter.you}, в {slave.hisHer} глазах горит гнев, пока {presenter.youHe} {presenter.youHeVerb('run')} {presenter.yourHis} отдает {slave.hisHer} тело. {slave.HeShe} рвется в {slave.hisHer} оковах, явно ненавидя каждую секунду происходящего.",
			"{slave.name} скалит {slave.hisHer} зубы, издавая рычание, пока {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} тело. {slave.HeShe} борется с цепями, и от {slave.himHer} буквально исходит ярость.",
			"{slave.name} презрительно смотрит на покупателей, пытаясь вырваться из {presenter.your} рук, пока {presenter.youHe} {presenter.youHeVerb('present')} {slave.hisHer} тело. Каждое движение пропитано непокорством и яростью.",
			"{slave.name} яростно дергается в оковах, а глаза горят гневом, пока {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} тело. {slave.HeShe} отказывается быть пассивной, сопротивляясь каждому прикосновению.",
			"{slave.name} рычит, и в {slave.hisHer} взгляде горит ненависть, пока {presenter.you} {presenter.youVerb('display')} {slave.hisHer} тело. {slave.HeShe} явно не сломлена и полна решимости сопротивляться даже сейчас.",
			"{slave.name} плюет на пол, в {slave.hisHer} глазах читается ярость, пока {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} тело. {slave.HeShe} тянет за цепи, отказываясь подчиняться.",
		])
		
	return "{slave.name} густо краснеет."
