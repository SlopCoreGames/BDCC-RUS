extends AuctionAction

func _init():
	id = "PersSubby"

func getActionType():
	return AuctionActionType.Personality

func getName() -> String:
	return "Сабби/Доминант"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave's submissiveness.\n\n[b]Might[/b] reveal 1 fetish preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	if(_slaveTraits.has("PersSubby") && _slaveTraits["PersSubby"] > 0.0):
		sayPresenter(RNG.pick([
			"Вы удивитесь, насколько послушно {slave.he} исполняет команды. Идеальная подчиненная, всегда готовая повиноваться.",
			"{slave.He} расцветает под контролем. Нет ничего, что {slave.heShe} любила бы больше, чем когда её ставят на {slave.hisHer} место. Идеальная подчиненная.",
			"Эта особа буквально создана для подчинения. Дайте {slave.himHer} приказ, и вы увидите, как быстро {slave.heShe} подчинится.",
			"{slave.He} жаждет структуры и дисциплины. Держите {slave.himHer} в узде, и {slave.heShe} станет вашей идеальной служанкой.",
			"{slave.HeShe} живет ради того, чтобы ею управляли. Чем больше власти вы забираете, тем счастливее становится {slave.heShe}.",
			"В сердце {slave.his} нет ничего, кроме покорности. Дайте {slave.himHer} приказ и наблюдайте, как {slave.himHer} склоняется перед вами.",
		]))
	if(_slaveTraits.has("PersDominant") && _slaveTraits["PersDominant"] > 0.0):
		sayPresenter(RNG.pick([
			"{slave.He} не из тех, кому привыкли отдавать приказы. {slave.heShe} жаждет контроля и власти. Но, возможно, это именно то, что вам нужно.",
			"Для тех, кто ищет лидера среди рабов: {slave.he} — {slave.isAre} та самая, кто будет доминировать над остальными.",
			"{slave.HeShe} точно знает, чего {slave.heShe} хочет, и не боится брать это сама. А вы знали, что доминантные рабы — невероятная редкость?",
			"Эта особа не так-то просто прогнется. {slave.he} обожает командовать, и ты почувствуешь эту силу. Под силу не каждому... но ломать доминантных рабов — это чертовски весело.",
			"В жилах {slave.hisHer} течет власть. Дай {slave.himHer} шанс, и {slave.heShe} устроит тебе проверку. Покажи {slave.him}, кто здесь настоящий босс!",
			"{slave.name} может и рабыня, но в глубине души именно {slave.heShe} жаждет контроля над другими. И это идеальный повод, чтобы поиздеваться над {slave.him}.",
		]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Fetish, mightChance())

func getTraits() -> Dictionary:
	return {
		"PersSubby": 1.0,
		"PersDominant": 1.0,
	}
