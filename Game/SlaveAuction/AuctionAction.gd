extends Reference
class_name AuctionAction

var id:String = "error"
var savedTexts:Array = []

func getName() -> String:
	return getNameFromTraits()

func getButtonName() -> String:
	return getName()

func getButtonDesc() -> String:
	return "ЗАПОЛНИ МЕНЯ"

func getActionType():
	return AuctionActionType.Fetish

func saynn(theText:String):
	savedTexts.append(theText)

func sayPresenter(theText:String):
	saynn("[say=presenter]"+theText+"[/say]")

func saySlave(theText:String):
	saynn("[say=slave]"+theText+"[/say]")

func getBaseAIScore(_char:BaseCharacter, _auction, _slaveTraits:Dictionary) -> float:
	return 0.1

func getAIScore(_char:BaseCharacter, _auction, _slaveTraits:Dictionary) -> float:
	var result:float = getBaseAIScore(_char, _auction, _slaveTraits)
	
	var theActionTraits := getTraits()
	for traitID in theActionTraits:
		var theTraitAm:float = theActionTraits[traitID]
		
		if(!_slaveTraits.has(traitID) || _slaveTraits[traitID] <= 0.0):
			continue
		var theSlaveTraitAm:float = _slaveTraits[traitID]
		
		for bidder in _auction.bidders:
			if(bidder.likes.has(traitID)):
				result += theTraitAm * theSlaveTraitAm * 1.0
			if(bidder.dislikes.has(traitID)):
				result -= theTraitAm * theSlaveTraitAm * 0.5
	
	result += getPassiveDesireGain()
	return max(result, 0.1)

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	return {
		text = "ЗАПОЛНИ МЕНЯЯЯЯЯЯ",
		slaveReaction = getSlaveReaction(_char, _auction.getSlaveReactionType()),
		traits = getTraits(),
		desire = getPassiveDesireGain(),
	}

func might() -> bool:
	return RNG.chance(mightChance())

func mightChance() -> float:
	return 50.0

func onActFinal(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	savedTexts.clear()
	var theResult = onAct(_char, _auction, _slaveTraits)
	if(theResult == null):
		theResult = {}
	
	if(savedTexts.size() > 0):
		theResult["text"] = Util.join(savedTexts, "\n\n")
	savedTexts.clear()
	return theResult

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		"Интересно...",
		"Вот это другое дело.",
		"Очень соблазнительно.",
		"Мне нравится.",
		"За это стоит побороться.",
		"Да, отлично.",
		"Идеально.",
		"Именно то, что я ищу.",
	])

func getNegativeReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		"Не для меня.",
		"Пас.",
		"Никакого интереса.",
		"Не в моем вкусе.",
		"Это не совсем то, что я ищу.",
		"Эх...",
	])

func getSlaveReaction(_char:BaseCharacter, _reactionType) -> String:
	if(_reactionType == AuctionSlaveReaction.Obedient):
		return RNG.pick([
			"{slave.name} послушно опускает взгляд {slave.his}, не выказывая ни малейшего сопротивления.",
			"{slave.name} остается неподвижной, не выказывая ни малейшего признака дискомфорта и лишь принимая внимание как должное.",
			"Взгляд {slave.name} на мгновение опускается к полу, словно она принимает {slave.his} место.",
			"{slave.name} слегка склоняет {slave.his} голову в знак почтения, но его слова почти не вызывают никакой реакции.",
			"{slave.name} стоит непоколебимо, не выказывая никаких внешних реакций, словно {slave.he} знает: именно для этого {slave.he} и обучали.",
			"{slave.name} сохраняет невозмутимую осанку, с тихим смирением принимая свою роль {slave.his} на аукционе.",
		])
	if(_reactionType == AuctionSlaveReaction.Confused):
		return RNG.pick([
			"На лице {slave.name} промелькнуло замешательство, но {slave.he} хранит молчание, не зная, что ответить.",
			"Губы {slave.name} слегка дрожат, {slave.his} глаза беспорядочно мечутся, пока {slave.he} осознает... всё.",
			"{slave.name} нервно сглатывает, и в выражении лица {slave.his} читается легкая печаль.",
			"{slave.name} прикусывает губу {slave.his}, пытаясь сохранять самообладание, несмотря на бурю противоречивых эмоций.",
			"Глаза {slave.name} слегка увлажняются — очевидно, что всеобщее внимание влияет на хрупкое душевное состояние {slave.his}.",
			"{slave.name} опускает взгляд, и печаль проступает на {slave.his} лице, когда {slave.he} слышит эти слова.",
		])
	if(_reactionType == AuctionSlaveReaction.Shy):
		return RNG.pick([
			"Щеки {slave.name} заливаются густым румянцем, пока {slave.he} неловко ерзает под пристальными взглядами.",
			"{slave.name} опускает голову, пытаясь скрыть смущённый румянец, заливающий {slave.his} лицо.",
			"{slave.name} слегка ерзает, а {slave.his} краснеет всё сильнее с каждым произнесенным словом.",
			"С губ {slave.name} срывается тихий вздох, а {slave.his} глаза нервно мечутся по комнате.",
			"{slave.name} прикусывает {slave.his} нижнюю губу, {slave.his} щеки горят от всеобщего внимания.",
			"{slave.name} слегка вздрагивает, явно чувствуя себя не в своей тарелке, но никак не протестует против этих слов.",
		])
	if(_reactionType == AuctionSlaveReaction.MindBroken):
		return RNG.pick([
			"{slave.name} никак не реагирует, {slave.his} взгляд пустой и лишенный всякого узнавания.",
			"{slave.name} уставилась перед собой, не проявляя ни понимания, ни эмоций.",
			"Тело {slave.name} остается обмякшим, она словно не слышит ни слов, ни внимания к себе.",
			"{slave.name} стоит неподвижно, {slave.his} лицо бесстрастно, будто {slave.he} даже не слышит произносимых слов.",
			"{slave.name} медленно моргает, {slave.his} отсутствующий взгляд не выражает никакого понимания.",
			"{slave.name} остается совершенно пассивной, словно кукла, не имеющая собственной {slave.his} воли.",
		])
	if(_reactionType == AuctionSlaveReaction.Desperate):
		return RNG.pick([
			"Глаза {slave.name} расширяются от паники, {slave.his} дыхание учащается, когда внимание переключается на {slave.him}.",
			"{slave.He} пытается вырваться из {slave.his} оков, в {slave.his} глазах мелькает страх, когда смысл слов доходит до сознания.",
			"Лицо {slave.name} искажается от отчаяния, {slave.he} кажется, что она вот-вот начнет умолять о побеге.",
			"{slave.name} слегка качает {slave.his} головой, словно пытаясь отрицать описание, в {slave.his} глазах читается явное замешательство.",
			"{slave.name} уставилась на толпу с явным замешательством, отчаянно ища хоть какую-то помощь.",
			"{slave.name} тревожно ерзает, переводя взгляд с одного участника торгов на другого, и безмолвно умоляет о помощи.",
		])
	if(_reactionType == AuctionSlaveReaction.Angry):
		return RNG.pick([
			"Челюсти {slave.name} сжимаются всё сильнее с каждой новой ставкой, а во взгляде {slave.his} разгорается ярость.",
			"{slave.name} свирепо смотрит на толпу; в её глазах кипит ненависть, и она словно бросает вызов аукционистам, готовая в любой момент броситься на них в драку.",
			"{slave.name} рычит сквозь стиснутые {slave.his} зубы, и растущие ставки лишь сильнее разжигают {slave.his} ярость.",
			"{slave.name} сплевывает на землю, и агрессивная борьба за ставки бесит {slave.him} еще сильнее.",
			"Глаза {slave.name} горят вызовом по мере того, как растут ставки; она явно не собирается смиренно принимать {slave.his} судьбу.",
			"{slave.name} дергается в {slave.his} оковах, и с каждой новой ставкой {slave.him} все решительнее пытается сопротивляться.",
		])
		
	return "{slave.name} густо краснеет."

func getTraits() -> Dictionary:
	return {
	}

func getPassiveDesireGain() -> float:
	return 0.2

func canUse(_char:BaseCharacter, _slaveTraits:Dictionary) -> Array:
	return [true]

func canOnlyUseOnce() -> bool:
	return true

func requiresAtLeastOneTraitForSlave() -> bool:
	return true

func isEmphasizeAction() -> bool:
	return false

func getNameFromTraits() -> String:
	var theTraits:Dictionary = getTraits()
	
	if(theTraits.empty()):
		return "ERROR??"
	
	var traitID:String = theTraits.keys()[0]
	var theTraitObj = GlobalRegistry.getAuctionTrait(traitID)
	return theTraitObj.getName(traitID)
