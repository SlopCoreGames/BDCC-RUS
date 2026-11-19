extends AuctionAction

func _init():
	id = "EmphasizePenis"

func getActionType():
	return AuctionActionType.Emphasize

func getName() -> String:
	return "Пенис"

func getButtonDesc() -> String:
	return "Really show off the slave's dick.\n\nDoesn't reveal any preferences, has a negative effects on bidders who don't strongly prefer any of the presented traits."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("PenisSmall") && _slaveTraits["PenisSmall"] > 0.0):
		saynn("{presenter.You} {presenter.youVerb('walk')} подходит к рабыне, и на {presenter.yourHis} губах играет порочная ухмылка, когда {presenter.youHe} {presenter.youHeVerb('reach', 'reaches')} наружу. Участники торгов внимательно наблюдают. {presenter.YouHe} {presenter.youHeVerb('grab')} {slave.name}'s {slave.penis}, и {presenter.youHeVerb('give')} слегка дергает его, вызывая смешки у некоторых аукционистов.")
		
		sayPresenter("Взгляните на это. {slave.He} может и не слишком крупный внизу, но гарантирую, {slave.heShe} возьмет свое послушанием. Посмотрите, насколько {slave.heShe} уже твердый!")
	
		saynn("{presenter.YouHe} {presenter.youHeVerb('tease')} маленький член между {presenter.yourHis} пальцами, приподнимая его так, словно выставляя на показ, чтобы торговцы могли рассмотреть и всю длину, и размер яичек.")
		
		sayPresenter("Только представьте, как этот член будет умолять о внимании, пока {slave.heShe} исполняет любую вашу прихоть...")
	if(_slaveTraits.has("PenisAverage") && _slaveTraits["PenisAverage"] > 0.0):
		saynn("{presenter.You} {presenter.youVerb('step')} вперед, протягивая {presenter.yourHis} руку, чтобы схватить {slave.name}'s {slave.penis}, который гордо стоит в напряжении. Рабыня тихо ахает, когда {presenter.yourHis} пальцы обхватывают {slave.himHer}, а участники торгов с интересом подаются вперед.")
		
		sayPresenter("Взгляните на это. {slave.HeShe} {slave.isAre} уже стоит колом только от того, что находится здесь. Представьте, что сделает {slave.heShe}, когда вы отдадите {slave.himHer} настоящую команду.")
	
		saynn("{presenter.YouHe} медленно {presenter.youHeVerb('stroke')} длину, позволяя торговцам рассмотреть каждый дюйм. С игривой ухмылкой {presenter.youHe} {presenter.youHeVerb('cup')} и яички тоже, представляя их во всем великолепии.")
	
		sayPresenter("Этот член будет давать тебе всё, что ты захочешь, каждый божий раз.")
	if(_slaveTraits.has("PenisLong") && _slaveTraits["PenisLong"] > 0.0):
		saynn("Драматичным жестом {presenter.you} {presenter.youVerb('approach', 'approaches')} рабыню, протягивая {presenter.yourHis} руку, чтобы схватить этот {slave.penis} и сделать несколько медленных движений. Когда его тяжесть наполняет {presenter.yourHis} руку, глаза торговцев расширяются от восхищения.")
	
		sayPresenter("А вот это... нечто особенное. Просто посмотрите на размер этого члена!")
		
		saynn("{presenter.You} {presenter.youVerb('continue')} проводит {presenter.yourHis} пальцами по стволу, следя за тем, чтобы каждый дюйм был на виду. При этом вторая рука обхватывает внушительные шары, выставляя их на обозрение торгующимся.")
		
		sayPresenter("Кому же достанется этот потрясающий сочный член?")

func getTraits() -> Dictionary:
	return {
		"PenisSmall": 2.0,
		"PenisAverage": 2.0,
		"PenisLong": 2.0,
	}

func getPassiveDesireGain() -> float:
	return -1.0

func isEmphasizeAction() -> bool:
	return true

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("PenisSmall") && _slaveTraits["PenisSmall"] > 0.0):
		return RNG.pick([
			'Perfect for humiliating.',
			'That size means total submission.',
			'I love a slave that’s embarrassed by their size. Makes them more obedient.',
			'Tiny cocks are perfect for making a slave focus on other ways to please.',
			'That’ll keep them humble. A small cock means easy control.',
			'There’s a lot of potential with a tiny cock like that - perfect for some extra humiliation.',
		])
	if(_slaveTraits.has("PenisAverage") && _slaveTraits["PenisAverage"] > 0.0):
		return RNG.pick([
			'Now that’s what I like to see.',
			'Perfect!',
			'That is a pretty good cock.',
			'Just what I’ve been looking for.',
			'Perfect cock.',
			'Great cock, all around.',
			'Yes!',
		])
	if(_slaveTraits.has("PenisLong") && _slaveTraits["PenisLong"] > 0.0):
		return RNG.pick([
			'Impressive size.',
			'Wow. Just wow.',
			'Big cocks like that are hard to find!',
			'I’ve been looking for a slave with a cock like that for a while.',
			'A cock like that is worth the investment.',
			'The bigger, the better.',
		])
	
	return .getPositiveReaction(_char, _slaveTraits)

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	if(_slaveTraits.has("PenisSmall") && _slaveTraits["PenisSmall"] > 0.0):
		return RNG.pick([
			'A tiny cock? What am I supposed to do with that?',
			'Too small for my tastes. I need something more impressive.',
			'No thanks, I didn\'t come here for some pathetic little thing.',
			'Useless to me.',
			'Humiliating, sure, but that size is just disappointing.',
			'I was hoping for more..',
		])
	if(_slaveTraits.has("PenisAverage") && _slaveTraits["PenisAverage"] > 0.0):
		return RNG.pick([
			'Nothing special here. If I wanted \'average\', I’d stay home.',
			'I expected more.',
			'Boring.',
			'I was hoping for something a little more... exciting.',
			'Forgettable.',
		])
	if(_slaveTraits.has("PenisLong") && _slaveTraits["PenisLong"] > 0.0):
		return RNG.pick([
			'Too big.',
			'All that size is wasted if they can’t use it right.',
			'I prefer something more modest. That’s just excessive.',
			'Long? Yeah, but that doesn’t mean they know what to do with it.',
			'Too much cock isn’t always a good thing.',
			'Looks impressive, but that’s not what I need in a slave.',
		])
	
	return .getNegativeReaction(_char, _slaveTraits)

func getSlaveReaction(_char:BaseCharacter, _reactionType) -> String:
	if(_reactionType == AuctionSlaveReaction.Obedient):
		return RNG.pick([
			"{slave.name} стоит совершенно неподвижно, пока {presenter.yourHis} рука обхватывает {slave.hisHer} член, а {slave.hisHer} голова склонена в безмолвном подчинении. {slave.HeShe} принимает прикосновение без малейшего сопротивления, готовый к демонстрации.",
			"{slave.name} даже не вздрагивает, лишь слегка поправляет {slave.hisHer} позу, чтобы {presenter.you} было удобнее выставить {slave.himHer} напоказ. Каждое движение пропитано покорностью.",
			"{slave.name} без протеста держит {slave.hisHer} позу, вытянувшись в струнку, пока {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} член выставляется на показ торгующимся.",
			"{slave.name} держит {slave.hisHer} глаза опущенными, молча позволяя {presenter.you} выставлять напоказ {slave.hisHer} член; каждое движение выверено и покорно.",
			"{slave.name} стоит неподвижно, шевелясь лишь тогда, когда это необходимо, чтобы отдать {presenter.you} полный контроль над демонстрацией, проявляя абсолютную покорность во всем.",
			"{slave.name} остается совершенно неподвижной, давая {presenter.you} полный доступ, чтобы продемонстрировать {slave.hisHer} член аукционистам. {slave.HeShe} не сопротивляется, принимая {slave.hisHer} роль.",
		])
	if(_reactionType == AuctionSlaveReaction.Confused):
		return RNG.pick([
			"{slave.name} часто моргает, и на {slave.hisHer} лице отражается замешательство, когда {presenter.you} {presenter.youVerb('tease')} {slave.hisHer} член. {slave.HeShe} не пытается сопротивляться, но в выражении {slave.hisHer} лица сквозит легкая печаль.",
			"Тихий, почти извиняющийся вздох срывается с губ {slave.himHer}, когда {presenter.you} {presenter.youVerb('wrap')} {presenter.your} обхватывает {slave.hisHer} член; замешательство смешивается с тихой покорностью.",
			"Взгляд {slave.name} нервно мечется, не понимая ситуации, но {slave.heShe} не пытается остановить {presenter.you}, пока {presenter.youHe} {presenter.youHeVerb('display')} {slave.hisHer} член на всеобщее обозрение.",
			"Слабая, печальная тень пробегает по лицу {slave.hisHer}, но {slave.name} позволяет {presenter.you} ласкать {slave.hisHer} член, и в {slave.hisHer} глазах нарастает замешательство.",
			"{slave.name} печально смотрит вниз, пока {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} член напоказ; печаль смешивается с глубоким замешательством, пока участники торгов осматривают {slave.himHer}.",
			"Тихий вздох срывается с губ {slave.name}, в глазах {slave.hisHer} читаются замешательство и грусть, но протеста не следует, когда {presenter.you} {presenter.youVerb('highlight')} {slave.hisHer} член для участников торгов.",
		])
	if(_reactionType == AuctionSlaveReaction.Shy):
		return RNG.pick([
			"Лицо {slave.name} заливается густым румянцем, когда {presenter.you} {presenter.youVerb('touch', 'touches')} {slave.hisHer} член, и с {slave.hisHer} губ срывается тихий вздох. {slave.HeShe} слегка ерзает, но не сопротивляется демонстрации.",
			"{slave.name} прикусывает {slave.hisHer} губу, яростно краснея, пока {presenter.you} {presenter.youVerb('present')} {slave.hisHer} член перед толпой; от стыдливости {slave.himHer} слегка дрожит.",
			"Густой румянец разливается по щекам {slave.name}, когда {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} член; смущение отчетливо читается в языке тела {slave.hisHer}.",
			"{slave.name} избегает зрительного контакта, щеки {slave.hisHer} горят красным, пока {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} член; раб слегка дрожит от такого внимания.",
			"{slave.name}'s breathing quickens, {slave.hisHer} face hot with embarrassment as {presenter.you} {presenter.youVerb('display')} {slave.hisHer} cock for the bidders, shyly trying to remain still.",
			"Тихий всхлип срывается с губ {slave.name}, когда {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} член, а по {slave.hisHer} телу разливается густой румянец, пока {slave.heShe} изо всех сил пытается сохранить самообладание.",
		])
	if(_reactionType == AuctionSlaveReaction.MindBroken):
		return RNG.pick([
			"{slave.name} замерла как вкопанная, тупо уставившись перед собой, пока {presenter.you} {presenter.youVerb('grip')} {slave.hisHer} её член. {slave.himHer} никак не реагирует, лишь пустой взгляд.",
			"Член дергается в ответ на прикосновение {presenter.yourHis}, но лицо {slave.name} остается безжизненным, совершенно не реагируя на это зрелище.",
			"{slave.name} стоит неподвижно, взгляд {slave.hisHer} остекленел, пока {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} член выставлен напоказ, но она, кажется, совершенно не осознает происходящего и ей плевать.",
			"Даже когда {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} член {slave.name} возбужден, она остается отрешенной: физическая реакция происходит автоматически, но без какой-либо осознанной отдачи.",
			"Член твердеет в руке {presenter.yourHis}, но {slave.name} остается пугающе безучастным, а разум {slave.hisHer} явно где-то далеко.",
			"Тело {slave.name} реагирует на прикосновение, но в {slave.hisHer} глазах нет ни капли узнавания — раб полностью потерян для {slave.hisHer} сознания.",
		])
	if(_reactionType == AuctionSlaveReaction.Desperate):
		return RNG.pick([
			"Дыхание {slave.name} становится прерывистым, {slave.hisHer} глаза отчаянно мечутся по сторонам, пока {presenter.you} {presenter.youVerb('grip')} {slave.hisHer} член. На {slave.hisHer} лице промелькивают замешательство и паника.",
			"{slave.name} резко вдыхает, когда {presenter.you} {presenter.youVerb('touch', 'touches')} {slave.hisHer} член; замешательство усиливается, когда {slave.heShe} неловко ерзает в {slave.hisHer} оковах.",
			"Отчаянный скулеж срывается с губ {slave.name}, когда {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} член — раб явно ошеломлен и не понимает, что происходит.",
			"{slave.name} дрожит, пока {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} член; в {slave.hisHer} глазах читается мольба, пока {slave.heShe} пытается осознать происходящее.",
			"Замешательство на лице {slave.name} усиливается, когда {presenter.you} {presenter.youVerb('highlight')} {slave.hisHer} член напоказ для покупателей, а в {slave.hisHer} голосе проскальзывает отчаяние.",
			"С широко распахнутыми от паники глазами, {slave.name} наблюдает за {presenter.you}, а его член дергается в {slave.hisHer} замешательстве, пока ситуация окончательно выходит из-под {slave.hisHer} контроля.",
		])
	if(_reactionType == AuctionSlaveReaction.Angry):
		return RNG.pick([
			"{slave.name} тихо рычит, сверля тебя взглядом, даже когда {presenter.you} {presenter.youVerb('grip')} {slave.hisHer} член. Член вызывающе дергается, но глаза {slave.hisHer} все еще полны ярости.",
			"{slave.name} стискивает {slave.hisHer} челюсти, и член твердеет под {presenter.yourHis} прикосновением, но ярость, пылающая в {slave.hisHer} глазах, выдает реакцию.",
			"Яростный взгляд устремляется на {presenter.you}, когда член {slave.name} наливается твердостью, а тело {slave.hisHer} выдает кипящую внутри ярость.",
			"{slave.name} рычит сквозь стиснутые {slave.hisHer} зубы; член дергается, несмотря на ярость в {slave.hisHer} взгляде, пока {presenter.you} {presenter.youVerb('show')} {slave.himHer} отлетает.",
			"{slave.name} не теряет самообладания, но член остается твердым в {presenter.your} хватке, едва заметно выдавая {slave.hisHer} храбрый фасад.",
			"{slave.HeShe} хмурится, тяжело дыша от ярости, но член заметно твердеет — физическая реакция идет вразрез с ментальным сопротивлением {slave.hisHer}.",
		])
		
	return "{slave.name} густо краснеет."
