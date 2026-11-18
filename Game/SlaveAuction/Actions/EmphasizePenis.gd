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
		
		sayPresenter("Take a look at this. {slave.He} might not be packing much down here, but I guarantee you, {slave.heShe}'ll make up for it in obedience. Look at how hard {slave.heShe} already is!")
	
		saynn("{presenter.YouHe} {presenter.youHeVerb('tease')} маленький член между {presenter.yourHis} пальцами, приподнимая его так, словно выставляя на показ, чтобы торговцы могли рассмотреть и всю длину, и размер яичек.")
		
		sayPresenter("Imagine this little cock begging for attention while {slave.heShe} serves your every whim..")
	if(_slaveTraits.has("PenisAverage") && _slaveTraits["PenisAverage"] > 0.0):
		saynn("{presenter.You} {presenter.youVerb('step')} вперед, протягивая {presenter.yourHis} руку, чтобы схватить {slave.name}'s {slave.penis}, который гордо стоит в напряжении. Рабыня тихо ахает, когда {presenter.yourHis} пальцы обхватывают {slave.himHer}, а участники торгов с интересом подаются вперед.")
		
		sayPresenter("Take a look at this. {slave.HeShe} {slave.isAre} already hard, just from being up here. Imagine what {slave.heShe}'ll do when you give {slave.himHer} a real command.")
	
		saynn("{presenter.YouHe} медленно {presenter.youHeVerb('stroke')} длину, позволяя торговцам рассмотреть каждый дюйм. С игривой ухмылкой {presenter.youHe} {presenter.youHeVerb('cup')} и яички тоже, представляя их во всем великолепии.")
	
		sayPresenter("This cock is going to give you everything you want, every time.")
	if(_slaveTraits.has("PenisLong") && _slaveTraits["PenisLong"] > 0.0):
		saynn("Драматичным жестом {presenter.you} {presenter.youVerb('approach', 'approaches')} рабыню, протягивая {presenter.yourHis} руку, чтобы схватить этот {slave.penis} и сделать несколько медленных движений. Когда его тяжесть наполняет {presenter.yourHis} руку, глаза торговцев расширяются от восхищения.")
	
		sayPresenter("Now this.. is something special. Just look at the size of this cock!")
		
		saynn("{presenter.You} {presenter.youVerb('continue')} проводит {presenter.yourHis} пальцами по стволу, следя за тем, чтобы каждый дюйм был на виду. При этом вторая рука обхватывает внушительные шары, выставляя их на обозрение торгующимся.")
		
		sayPresenter("Who’s going to be the lucky one to claim this amazing juicy dick?")

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
			"{slave.name} stands perfectly still as {presenter.yourHis} hand wraps around {slave.hisHer} cock, {slave.hisHer} head bowed in silent submission. {slave.HeShe} accepts the touch without resistance, ready to be shown off.",
			"{slave.name} doesn’t flinch, adjusting {slave.hisHer} posture slightly to make it easier for {presenter.you} to present {slave.himHer}. Every movement is full of submission.",
			"{slave.name} holds {slave.hisHer} position without protest, standing tall as {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} cock for the bidders.",
			"{slave.name} keeps {slave.hisHer} eyes downcast, silently allowing {presenter.you} to show off {slave.hisHer} cock, every movement precise and compliant.",
			"{slave.name} stands firm, shifting only when necessary to give {presenter.you} complete control over the display, perfectly obedient in every way.",
			"{slave.name} remains completely still, giving {presenter.you} full access to highlight {slave.hisHer} cock to the bidders. {slave.HeShe} offers no resistance, accepting {slave.hisHer} role.",
		])
	if(_reactionType == AuctionSlaveReaction.Confused):
		return RNG.pick([
			"{slave.name} blinks rapidly, a look of confusion crossing {slave.hisHer} face as {presenter.you} {presenter.youVerb('tease')} {slave.hisHer} cock. {slave.HeShe} makes no effort to resist, but a hint of sadness lingers in {slave.hisHer} expression.",
			"A soft, almost apologetic sigh escapes {slave.himHer} as {presenter.you} {presenter.youVerb('wrap')} {presenter.your} hand around {slave.hisHer} cock, the confusion mixing with a quiet resignation.",
			"{slave.name}'s gaze flickers nervously, uncertain of the situation, but {slave.heShe} makes no effort to stop {presenter.you} as {presenter.youHe} {presenter.youHeVerb('display')} {slave.hisHer} cock for all to see.",
			"A faint, sorrowful expression tugs at {slave.hisHer} features, but {slave.name} allows {presenter.you} to handle {slave.hisHer} cock, the look of confusion growing in {slave.hisHer} eyes.",
			"{slave.name} looks down sadly as {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} cock for display, the sadness mixing with a deep confusion as the bidders inspect {slave.himHer}.",
			"A soft breath escapes {slave.name}, confusion and sadness in {slave.hisHer} eyes, but no protest comes as {presenter.you} {presenter.youVerb('highlight')} {slave.hisHer} cock for the bidders.",
		])
	if(_reactionType == AuctionSlaveReaction.Shy):
		return RNG.pick([
			"{slave.name}'s face flushes deeply as {presenter.you} {presenter.youVerb('touch', 'touches')} {slave.hisHer} cock, a quiet gasp escaping {slave.hisHer} lips. {slave.HeShe} squirms slightly but doesn’t resist the display.",
			"{slave.name} bites {slave.hisHer} lip, blushing furiously as {presenter.you} {presenter.youVerb('present')} {slave.hisHer} cock to the crowd, the shyness making {slave.himHer} tremble slightly.",
			"A deep blush spreads across {slave.name}'s cheeks as {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} cock, the embarrassment clear in {slave.hisHer} body language.",
			"{slave.name} avoids eye contact, {slave.hisHer} cheeks burning red as {presenter.you} {presenter.youVerb('emphasize')} {slave.hisHer} cock, the slave trembling slightly from the attention.",
			"{slave.name}'s breathing quickens, {slave.hisHer} face hot with embarrassment as {presenter.you} {presenter.youVerb('display')} {slave.hisHer} cock for the bidders, shyly trying to remain still.",
			"A soft whimper escapes {slave.name} as {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} cock, the intense blush spreading over {slave.hisHer} body as {slave.heShe} struggles to stay composed.",
		])
	if(_reactionType == AuctionSlaveReaction.MindBroken):
		return RNG.pick([
			"{slave.name} remains utterly still, staring blankly ahead as {presenter.you} {presenter.youVerb('grip')} {slave.hisHer} cock. No reaction comes from {slave.himHer}, just an empty gaze.",
			"The cock twitches in response to {presenter.yourHis} touch, but {slave.name}'s face remains lifeless, completely unreactive to the display.",
			"{slave.name} stands motionless, {slave.hisHer} eyes glazed over as {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} cock, showing no signs of awareness or care.",
			"Even as {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} cock, {slave.name} remains distant, the physical response automatic but without any conscious reaction.",
			"The cock stiffens in {presenter.yourHis} hand, but {slave.name} remains eerily unresponsive, {slave.hisHer} mind clearly somewhere else.",
			"{slave.name}'s body reacts to the touch, but there’s no recognition in {slave.hisHer} eyes, the slave completely lost to {slave.hisHer} mind.",
		])
	if(_reactionType == AuctionSlaveReaction.Desperate):
		return RNG.pick([
			"{slave.name}'s breathing becomes erratic, {slave.hisHer} eyes darting around in desperation as {presenter.you} {presenter.youVerb('grip')} {slave.hisHer} cock. Confusion and panic flash across {slave.hisHer} face.",
			"{slave.name} gasps sharply as {presenter.you} {presenter.youVerb('touch', 'touches')} {slave.hisHer} cock, the look of confusion intensifying as {slave.heShe} shifts uncomfortably in {slave.hisHer} restraints.",
			"A desperate whimper escapes {slave.name} as {presenter.you} {presenter.youVerb('handle')} {slave.hisHer} cock, the slave clearly overwhelmed and unsure of what’s happening.",
			"{slave.name} trembles as {presenter.you} {presenter.youVerb('hold')} {slave.hisHer} cock, a pleading look in {slave.hisHer} eyes as {slave.heShe} struggles to understand the situation.",
			"The confusion in {slave.name}'s expression deepens as {presenter.you} {presenter.youVerb('highlight')} {slave.hisHer} cock for the bidders, desperation creeping into {slave.hisHer} voice.",
			"With wide, panicked eyes, {slave.name} watches {presenter.you}, the cock twitching in {slave.hisHer} confusion as the situation spirals out of {slave.hisHer} control.",
		])
	if(_reactionType == AuctionSlaveReaction.Angry):
		return RNG.pick([
			"{slave.name} growls softly, glaring at you even as {presenter.you} {presenter.youVerb('grip')} {slave.hisHer} cock. The cock twitches in defiance, but {slave.hisHer} eyes remain full of anger.",
			"{slave.name} clenches {slave.hisHer} jaw, the cock hardening under {presenter.yourHis} touch, but the anger burning brightly in {slave.hisHer} eyes betrays the reaction.",
			"A furious glare shoots toward {presenter.you} as {slave.name}'s cock stiffens, {slave.hisHer} body betraying the anger seething inside.",
			"{slave.name} snarls under {slave.hisHer} breath, the cock twitching despite the fury in {slave.hisHer} gaze as {presenter.you} {presenter.youVerb('show')} {slave.himHer} off.",
			"{slave.name}'s defiance doesn’t falter, but the cock remains rigid in {presenter.your} grip, a subtle betrayal of {slave.hisHer} brave facade.",
			"{slave.HeShe} scowls, chest heaving with anger, but the cock stiffens visibly, the physical reaction defying {slave.hisHer} mental resistance.",
		])
		
	return "{slave.name} blushes deeply."
