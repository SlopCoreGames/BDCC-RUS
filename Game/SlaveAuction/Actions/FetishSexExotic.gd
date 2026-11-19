extends AuctionAction

func _init():
	id = "FetishSexExotic"

func getButtonDesc() -> String:
	return "Расскажите участникам аукциона об экзотических фетишах рабыни, таких как футплей и римминг.\n\n[b]Возможно[/b] раскроет по одной черте характера каждого участника."

func getActionType():
	return AuctionActionType.Fetish

func onAct(_char:BaseCharacter, _auction, _slaveTraits:Dictionary):
	sayPresenter(RNG.pick([
		"Для обладателей утонченного вкуса эта секс-игрушка предлагает нечто гораздо большее, чем просто обыденный секс.",
		"Эта штучка — настоящий бриллиант для тех из вас, кто жаждет чего-то... слегка нетрадиционного... в своей постели.",
		"{slave.He} обожает всё необычное. Поверьте, с тем, что {slave.he} творит в постели, скучно вам точно не будет.",
		"Экзотические фетиши, запредельные удовольствия — эта рабыня удовлетворит желания, о которых вы даже не подозревали.",
		"От футплея до римминга — {slave.he} готова исследовать каждый уголок ваших фантазий.",
		"У этой девчонки вкус к... экспериментам. Если вам нужна секс-игрушка с уникальными кинками, то это она.",
	]))
	
	_auction.unlockRandomTraitOfTypeEachBidderWithChance(AuctionTraitType.Personality, mightChance())

func getTraits() -> Dictionary:
	return {
		"FetishSexExotic": 1.0,
	}
