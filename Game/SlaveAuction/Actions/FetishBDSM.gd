extends AuctionAction

func _init():
	id = "FetishBDSM"

func getButtonDesc() -> String:
	return "Tell the bidders about the slave's love of being bound in ropes and cuffs.\n\n[b]Might[/b] reveal 1 personality preference of each bidder."

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"{slave.HeShe} жаждет ощущения скованности. Верёвки, наручники, цепи — что угодно. Свяжи {slave.him} и наблюдай, как {slave.him} извивается, это так весело!",
		"Если вам нужна рабыня, которая расцветает в подчинении, то вы ее нашли. Связывание {slave.him} для {slave.him} так же естественно, как дыхание. Чем сильнее ограничения, тем лучше.",
		"Звон кандалов, натяжение веревок... эта рабыня обожает это чувство напряжения и беспомощности, когда она полностью в твоей власти!",
		"Привяжи {slave.him}, сковывай {slave.him} наручниками, и ты увидишь истинное блаженство. Чем неподвижнее будет {slave.he}, тем глубже станет её послушание.",
		"{slave.HeShe} не просто терпит путы — {slave.heShe} в них нуждается. Оковы для {slave.him} — это не просто способ контроля, это путь к полному самоотречению.",
		"Будь то шелковые веревки или тяжелые цепи — чем туже, тем лучше. Оковы пробуждают истинную натуру {slave.his}.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getPositiveReaction(_char:BaseCharacter, _slaveTraits:Dictionary) -> String:
	return RNG.pick([
		'A slave who knows {slave.his} place in cuffs? Nice.',
		'I can already imagine {slave.him} tied up in my playroom.',
		'Perfect, I’ve been looking for someone who craves restraint like that. Consider me interested!',
		'I love slaves who can take the bindings!',
		'I could use a restraint slut.',
		'Restraints and slaves go together like cats and tuna.',
	])

func getTraits() -> Dictionary:
	return {
		"FetishBDSM": 1.0,
	}
