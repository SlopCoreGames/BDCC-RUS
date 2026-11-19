extends TFEffect

var howMuch:int = 1

func _init():
	id = "BreastSizeChange"

func initArgs(_args:Array):
	if(_args.size() > 0):
		howMuch = _args[0]

func applyEffect(_data:Dictionary) -> Dictionary:
	var origSize = _data["size"] if _data.has("size") else BreastsSize.FLAT
	
	if(_data.has("size")):
		_data["size"] += howMuch
	else:
		_data["size"] = BreastsSize.FLAT + howMuch
	
	return {
		origSize = origSize,
		size = _data["size"],
		success = true,
	}
	
func onReplace(_otherEffect):
	howMuch += _otherEffect.howMuch

func generateTransformText(_result:Dictionary):
	var origSize:int = _result["origSize"]
	var size:int = _result["size"]
	var breastsCovered:bool = (getChar().getFirstItemThatCoversBodypart(BodypartSlot.Breasts) != null)
	
	#addText("Increased breast size from "+str(origSize)+" up to "+str(size)+". {npc.YourHis} breasts are now {npc.breasts}.")
	addText(describeBreastTransformation(origSize, size, breastsCovered))
	addText(describeNewSize(origSize, size, breastsCovered))

func generateShortTransformText(_result:Dictionary):
	var origSize:int = _result["origSize"]
	var size:int = _result["size"]
	var breastsCovered:bool = (getChar().getFirstItemThatCoversBodypart(BodypartSlot.Breasts) != null)
	
	addText(describeBreastTransformation(origSize, size, breastsCovered))

func describeNewSize(origSize:int, size:int, _breastsCovered:bool = false) -> String:
	var nowOrStill := "now"
	if(size <= origSize || ((origSize in [BreastsSize.FLAT, BreastsSize.FOREVER_FLAT]) && (size in [BreastsSize.FLAT, BreastsSize.FOREVER_FLAT]))):
		nowOrStill = "still"
	
	if(size <= BreastsSize.FLAT):
		return RNG.pick([
			"Грудь {npc.YourHis} — "+nowOrStill+" совершенно плоская, гладкая и {npc.masc}. Отсутствие изгибов придает {npc.youHim} подтянутый, обтекаемый вид, подчеркивая {npc.yourHis} остальные черты. {npc.YouHe} {npc.youHeVerb('feel')} ощущение свободы, не обремененной весом.",
		])
	if(size <= BreastsSize.A):
		return RNG.pick([
			"{npc.YourHis} грудь — "+nowOrStill+" скромно округлая и упругая, высоко сидящая на {npc.yourHis} груди. Мягкий изгиб добавляет нотку женственности, привлекая внимание к {npc.yourHis} ключицам и плечам, что усиливает {npc.yourHis} общую привлекательность.",
		])
	if(size <= BreastsSize.B):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " довольно заметная и мягкая, с прелестной формой, которая слегка подпрыгивает при {npc.yourHis} движениях. Мягкие изгибы создают более выразительный силуэт, заставляя {npc.youHim} чувствовать себя одновременно сексуальной и уверенной.",
		])
	if(size <= BreastsSize.C):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " пышная и полная, тяжелая и манящая, представляющая собой захватывающее зрелище. Мягкие изгибы так и просят прикосновений, и {npc.youHim} может чувствовать тепло, исходящее от {npc.yourHis} груди, что лишь усиливает {npc.yourHis} чувственность.",
		])
	if(size <= BreastsSize.D):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " пышные и тяжелые, с манящей полнотой, которая мягко натягивает кожу на {npc.yourHis} груди. Глубокое, соблазнительное декольте подчеркнуто {npc.yourHis} более выраженными сосками, чувствительными к малейшему прикосновению.",
		])
	if(size <= BreastsSize.DD):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " впечатляюще переполненные мягкостью и очарованием. Они бесспорно приковывают взгляд своими пышными формами, требующими внимания. Вес и полнота создают соблазнительное колыхание, от которого каждое движение кажется опьяняющим.",
		])
	if(size <= BreastsSize.DDD):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " поразительно полные и округлые, гордо возвышающиеся на {npc.yourHis} груди. Драматичный силуэт одновременно манит и ошеломляет, а их тяжесть пьянит, а чувствительные соски так и просят ласки.",
		])
	if(size <= BreastsSize.G):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " ошеломляюще огромные и пленительные, тяжелые и полные, с глубокой ложбинкой декольте, одновременно манящей и провокационной. Сами их размеры приковывают все взгляды к {npc.youHim}, и {npc.youHim} может кожей чувствовать мощь {npc.yourHis} изгибов.",
		])
	if(size <= BreastsSize.H):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " сногсшибательно пышные и властные, покачивающиеся при каждом движении. Захватывающие дух изгибы и выступающие соски так и молят о внимании, дразня своей чувствительностью.",
		])
	if(size <= BreastsSize.I):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " поразительно полные, истинное чудо мягкости и соблазна. Тяжелые и округлые, они создают эффектный образ, который невозможно игнорировать, а чувствительные соски так и просят прикосновений.",
		])
	if(size <= BreastsSize.J):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " сногсшибательно огромные и неоспоримо сексуальные, переполненные мягкостью и образующие глубокую, манящую ложбинку. Сами их размер и вес заставляют {npc.youHim} чувствовать себя невероятно мощной, излучающей уверенность.",
		])
	if(size <= BreastsSize.K):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " захватывающе пышные, тяжелые и наполненные, с потрясающим силуэтом, который пленяет каждого, кто смотрит на {npc.youHim}. Эта тяжесть опьяняет, а чувствительные соски {npc.yourHis} жаждут внимания.",
		])
	if(size <= BreastsSize.L):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " необычайно большие, чудо изгибов и мягкости. Они создают эффектный образ, одновременно манящий и ошеломляющий, заставляя {npc.youHim} чувствовать себя невероятно сексуальной и уверенной.",
		])
	if(size <= BreastsSize.M):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " великолепные, истинное торжество пышности. Тяжелые и округлые, они образуют глубокую ложбинку, одновременно манящую и провокационную, приковывая все взгляды к {npc.youHim}.",
		])
	if(size <= BreastsSize.N):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " поразительно полные, захватывающее дух воплощение мягкости и соблазна. Они создают эффектный силуэт, который пленяет каждого, кто смотрит на {npc.youHim}, излучая уверенность и силу.",
		])
	if(size == BreastsSize.O || true):
		return RNG.pick([
			"{npc.YourHis} грудь — " + nowOrStill + " невероятно, истинное чудо размера и чувственности. Они тяжелые и полные, создающие потрясающий образ, который невозможно игнорировать, заставляя {npc.youHim} чувствовать себя мощной и манящей.",
		])
	
	return ""

func describeBreastTransformation(origSize:int, size:int, breastsCovered:bool = false) -> String:
	if(origSize == size):
		return RNG.pick([
			"В груди {npc.yourHis} пробегает легкое теплое покалывание, нежная пульсация, разливающаяся по {npc.yourHis} грудной клетке. Когда это ощущение накрывает ее, {npc.youHe} {npc.youHeVerb('expect')} кажется, что должно что-то произойти, но, похоже, ничего не меняется. Привычная тяжесть остается прежней.",
			"Мягкое тепло окутывает {npc.yourHis} грудь, и {npc.youHe} {npc.youHeVerb('sense')} ощущает сдвиг энергии, но размер остается неизменным. Покалывание не проходит, дразня {npc.youHim} возможностью перемен, однако {npc.yourHis} грудь сохраняет свою привычную форму. {npc.YouHe} {npc.youAreHeIs} остается с чувством облегчения и странного неудовлетворения, когда момент проходит.",
			"Нежное тепло разливается по груди {npc.yourHis}, и на мгновение {npc.youHe} {npc.youHeVerb('think')} кажется, что вот-вот что-то случится. Но когда ощущение угасает, {npc.youHe} {npc.youHeVerb('realize')} {npc.yourHis} грудь остается точно такой же, как и прежде. Тот же размер и тот же объем.",
			"Мягкое покалывание пробегает по груди {npc.yourHis}, и {npc.youHe} {npc.youHeVerb('brace')} на мгновение. Но когда тепло утихает, {npc.youHe} {npc.youHeVerb('realize')} оказывается, что {npc.yourHis} грудь осталась прежней, без изменений в размере и весе.",
		])
	var diff:int = size - origSize
	if(diff == 1):
		return RNG.pick([
			"Теплое ощущение начинает разливаться по груди {npc.yourHis} — мягкая пульсация, намекающая на перемены. {npc.youHe} {npc.youHeVerb('feel')} нарастает легкое давление, и по мере того как тепло усиливается, {npc.youHe} {npc.youHeVerb('realize')} {npc.yourHis} грудь начинает слегка набухать. Теперь {npc.yourHis} грудь кажется немного тяжелее на вид и на ощупь.",
			"{npc.YouHe} {npc.youHeVerb('sense')} мягкое тепло окутывает {npc.yourHis} грудь, и начинает ощущаться легкое покалывание. По мере нарастания этого чувства, {npc.youHe} {npc.youHeVerb('feel')} {npc.yourHis} грудь слегка увеличивается — изменение едва уловимое, но неоспоримое. Прибавка в весе ощущается," + ("из-за чего одежда {npc.yourHis} становится немного теснее" if breastsCovered else "") + ".",
			"Мягкое тепло разливается по {npc.yourHis} груди, и {npc.youHe} {npc.youHeVerb('feel')} легкое натяжение, когда она начинает набухать. Трансформация происходит постепенно, но вскоре {npc.youHe} {npc.youHeVerb('realize')} она становится достаточно тяжелой, чтобы это ощущалось.",
			"{npc.YouHe} {npc.youHeVerb('feel')} теплая пульсация проходит сквозь {npc.yourHis} грудь, и по мере ее усиления, {npc.yourHis} грудь начинает увеличиваться. Изменения едва заметны, но ощутимы; прибавка в весе создает новое чувство, которое приковывает {npc.yourHis} внимание.",
			"Мягкое покалывание окутывает {npc.yourHis} грудь, и {npc.youHe} {npc.youHeVerb('brace')} предчувствие перемен. По мере распространения тепла, {npc.youHe} {npc.youHeVerb('feel')} она слегка набухает, становясь всё тяжелее. {npc.yourHis} грудь теперь выглядит более полной и манящей, чем прежде.",
		])
	if(diff > 1):
		return RNG.pick([
			"Мощный прилив тепла поглощает {npc.yourHis} грудь, и {npc.youHe} {npc.youHeVerb('gasp')}, когда она начинает значительно увеличиваться. Ощущение интенсивное, глубокая пульсация, которая тянет {npc.yourHis} " + ("clothing" if breastsCovered else "голую грудь") + " по мере того как {npc.yourHis} грудь стремительно растет. Вес тяжело оседает на {npc.yourHis} груди, создавая новый сексуальный силуэт.",
			"{npc.YouHe} {npc.youHeVerb('feel')} ощущает, как по {npc.yourHis} груди разливается всепоглощающее тепло, и изменения происходят мгновенно и поразительно. Она раздувается с такой силой, что у {npc.youHim} перехватывает дыхание, а вес становится ощутимым по мере роста.",
			"Волна жара накрывает тело {npc.yourHis}, и {npc.yourHis} грудь раздувается мощным импульсом. Это опьяняющее чувство: она заметно увеличивается, смещая баланс {npc.yourHis}.",
			"{npc.YouHe} {npc.youHeVerb('sense')} чувствует сильное покалывание, пока {npc.yourHis} грудь расширяется, и трансформация разворачивается стремительно. Она становится тяжелой и полной, тянущей {npc.yourHis} " + ("clothing" if breastsCovered else "голую грудь") + " и меняющей осанку {npc.yourHis}. Изменения значительны, и {npc.youHim} приходится привыкать к {npc.yourHis} новому, куда большему размеру.",
			"Глубокое тепло разливается по груди {npc.yourHis}, и {npc.youHe} {npc.youHeVerb('feel')} {npc.yourHis} грудь раздувается до впечатляющих размеров. Трансформация ошеломляет, тяжесть ложится на {npc.yourHis} тело, оставляя после себя совершенно очевидные перемены.",
		])
	if(diff == -1):
		return RNG.pick([
			"Прохлада разливается по {npc.yourHis} груди, и {npc.youHe} {npc.youHeVerb('feel')} ощущается легкое натяжение, когда она начинает понемногу уменьшаться. Тепло, окутавшее {npc.youHim} мгновения назад, медленно угасает, оставляя после себя едва уловимую легкость. {npc.YouHe} {npc.youHeVerb('notice')} {npc.yourHis} грудь становится меньше, приобретая более подтянутую форму.",
			"{npc.YouHe} {npc.youHeVerb('sense')} мягкий холодок окутывает {npc.yourHis} грудь, и по мере того как ощущение усиливается, {npc.yourHis} грудь начинает слегка уменьшаться. Перемена едва заметна, но {npc.youHe} чувствует, как тяжесть спадает, а {npc.yourHis} грудь становится чуть меньше.",
			"Легкое покалывание пробегает по {npc.yourHis} груди, и {npc.youHe} {npc.youHeVerb('brace')} предвестник перемен. Когда тепло рассеивается, {npc.youHe} {npc.youHeVerb('realize')} становится ясно, что она слегка уменьшилась — тяжесть стала заметно меньше.",
			"{npc.YouHe} {npc.youHeVerb('feel')} мягкая пульсация в {npc.yourHis} груди, и по мере ее усиления {npc.yourHis} грудь начинает уменьшаться, постепенно теряя свою тяжесть и объем.",
			"Легкое покалывание пробегает по {npc.yourHis} груди, и {npc.youHe} {npc.youHeVerb('sense')} происходит смена формы: они становятся чуть меньше. Привычная тяжесть уменьшается, оставляя {npc.youHim} с более изящным силуэтом."
		])
	if(diff < -1):
		return RNG.pick([
			"Резкая прохлада разливается по {npc.yourHis} груди, и {npc.youHe} {npc.youHeVerb('gasp')} происходит заметное уменьшение в объеме. Ощущение бьет с неожиданности — внезапная легкость заставляет {npc.youHim} почувствовать неустойчивость. Когда вес исчезает, {npc.youHe} {npc.youAreHeIs} остается с поразительно иным силуэтом, при этом {npc.yourHis} грудь теряет значительную часть своего объема.",
			"{npc.YouHe} {npc.youHeVerb('feel')} волна холода окутывает {npc.yourHis} грудь, и {npc.yourHis} грудь начинает стремительно уменьшаться. Трансформация происходит быстро, и {npc.youHe} не может не заметить, насколько легче она выглядит и ощущается теперь.",
			"Глубокий холод пронзает {npc.yourHis} грудь, и {npc.youHe} {npc.youHeVerb('sense')} происходит значительное уменьшение размера. Тяжесть, которая когда-то тянула {npc.yourHis} " + ("clothing" if breastsCovered else "голую грудь") + " исчезла, заставляя {npc.youHim} чувствовать себя почти невесомой.",
			"{npc.YouHe} {npc.youHeVerb('sense')} ощущает сильное покалывание, когда {npc.yourHis} грудь стремительно уменьшается, от чего {npc.youHim} буквально захватывает дух. Объем {npc.yourHis} груди заметно спадает, полностью меняя ее внешний вид.",
			"Внезапный холод разливается по груди {npc.yourHis}, и {npc.youHe} {npc.youHeVerb('feel')} {npc.yourHis} грудь постепенно становится всё меньше и меньше, уменьшаясь до размеров, которые кажутся почти чужими.",
		])
	return "что-то пошло не так"

func breastSizeToString(size:int) -> String:
	if(size <= BreastsSize.FLAT):
		return "flat"
	if(size <= BreastsSize.A):
		return "small"
	if(size <= BreastsSize.C):
		return "medium"
	if(size <= BreastsSize.G):
		return "big"
	return "huge"

func describeBreastTransformationOld(origSize:int, size:int) -> String:
	var initial_size:String = breastSizeToString(origSize)
	var target_size:String = breastSizeToString(size)

	if initial_size == target_size:
		if(origSize == size):
			return RNG.pick([
				"В {npc.yourHis} груди ощущается легкое покалывание, но ее размер, кажется, не изменился.",
				"По груди {npc.yourHis} разливается слабое тепло, но заметных изменений не происходит."
			])
		if(size > origSize):
			return RNG.pick([
				"В {npc.yourHis} груди ощущается легкое покалывание, когда она становится чуть полнее и тяжелее.",
				"Мягкое тепло разливается по груди {npc.yourHis}, пока ее формы едва заметно наливаются."
			])
		else:
			return RNG.pick([
				"В {npc.yourHis} груди ощущается легкое покалывание, когда она становится чуть меньше и легче.",
				"Слабое чувство легкости охватывает {npc.yourHis}, когда ее грудь слегка уменьшается в размере."
			])

	var transformation_desc = ""

	if initial_size == "flat" and target_size == "small":
		transformation_desc = RNG.pick([
			"Начинается легкое покалывание, когда плоская грудь {npc.yourHis} начинает наливаться, превращаясь в аккуратную и скромную.",
			"От груди {npc.yourHis} исходит мягкое тепло, заставляя ее слегка округлиться, приобретая скромные формы."
		])
	elif initial_size == "flat" and target_size == "medium":
		transformation_desc = RNG.pick([
			"Плоская грудь {npc.YourHis} быстро растет, расцветая приятными округлыми формами.",
			"Прилив энергии проходит сквозь грудь {npc.yourHis}, раздувая её в приятную, округлую форму."
		])
	elif initial_size == "flat" and target_size == "big":
		transformation_desc = RNG.pick([
			"Плоская грудь {npc.YourHis} резко подается вперед, стремительно превращаясь в огромную, пышную грудь.",
			"Интенсивный жар пронзает грудь {npc.yourHis}, заставляя её стремительно раздуваться в тяжелые, полные формы."
		])
	elif initial_size == "flat" and target_size == "huge":
		transformation_desc = RNG.pick([
			"Разливается сильный жар, пока плоская грудь {npc.yourHis} трансформируется, массивно раздуваясь в непомерно огромную грудь.",
			"Глубокий импульс энергии поглощает грудь {npc.yourHis}, раздувая её до внушительных, колоссальных размеров."
		])
	elif initial_size == "small" and target_size == "medium":
		transformation_desc = RNG.pick([
			"Маленькая грудь {npc.YourHis} становится еще пышнее, обретая приятную округлость и объем.",
			"Легкое покалывание заставляет скромную грудь {npc.yourHis} раздуться, становясь более полной и округлой."
		])
	elif initial_size == "small" and target_size == "big":
		transformation_desc = RNG.pick([
			"Скромная грудь {npc.YourHis} стремительно растет, принимая внушительные, пышные формы.",
			"Волна жара проходит сквозь грудь {npc.yourHis}, раздувая её в крупные и тяжелые формы."
		])
	elif initial_size == "small" and target_size == "huge":
		transformation_desc = RNG.pick([
			"Глубокий импульс энергии раздувает скромную {npc.yourHis} грудь до массивных, подавляющих размеров.",
			"Прилив тепла охватывает {npc.yourHis} грудь, раздувая её до почти невозможного, огромного размера."
		])
	elif initial_size == "medium" and target_size == "big":
		transformation_desc = RNG.pick([
			"Округлые {npc.YourHis} груди выпячиваются вперед, становясь всё больше и тяжелее.",
			"Покалывающее ощущение наполняет {npc.yourHis} грудь, когда она разрастается, становясь более полной и тяжелой."
		])
	elif initial_size == "medium" and target_size == "huge":
		transformation_desc = RNG.pick([
			"Приятно округлые {npc.YourHis} груди резко увеличиваются, превращаясь в массивные, внушающие трепет формы.",
			"Мощный жар проносится сквозь {npc.yourHis} грудь, раздувая её до ошеломляющих размеров."
		])
	elif initial_size == "big" and target_size == "huge":
		transformation_desc = RNG.pick([
			"И без того крупные {npc.YourHis} груди раздуваются еще сильнее, становясь почти непомерными.",
			"Тяжелое тепло охватывает {npc.yourHis} грудь, раздувая её до массивных, приковывающих взгляд размеров."
		])

	# Reduction transformations
	elif initial_size == "small" and target_size == "flat":
		transformation_desc = RNG.pick([
			"Крошечные {npc.YourHis} груди медленно уменьшаются, оставляя после себя идеально плоскую грудь.",
			"Прохладное ощущение разливается по {npc.yourHis} груди, пока она полностью не становится плоской."
		])
	elif initial_size == "medium" and target_size == "small":
		transformation_desc = RNG.pick([
			"Приятно округлая грудь {npc.YourHis} уменьшается, становясь миниатюрной и скромной.",
			"Легкое покалывание заставляет пышную грудь {npc.yourHis} уменьшиться, приобретая более скромную форму."
		])
	elif initial_size == "medium" and target_size == "flat":
		transformation_desc = RNG.pick([
			"Округлая грудь {npc.YourHis} полностью исчезает, оставляя после себя плоскую грудь.",
			"Волна прохлады охватывает грудь {npc.yourHis}, превращая её в идеально плоскую форму."
		])
	elif initial_size == "big" and target_size == "medium":
		transformation_desc = RNG.pick([
			"Большая грудь {npc.YourHis} слегка уменьшается, становясь приятно округлой.",
			"Легкая невесомость разливается по груди {npc.yourHis}, пока та уменьшается до более удобного размера."
		])
	elif initial_size == "big" and target_size == "small":
		transformation_desc = RNG.pick([
			"Пышная грудь {npc.YourHis} резко уменьшается, становясь скромной и миниатюрной.",
			"Заметное ощущение прохлады пробегает по груди {npc.yourHis}, значительно уменьшая её в объеме."
		])
	elif initial_size == "big" and target_size == "flat":
		transformation_desc = RNG.pick([
			"Большая грудь {npc.YourHis} полностью исчезает, оставляя после себя плоскую грудь.",
			"Интенсивный холод разливается по груди {npc.yourHis}, полностью стирая её пышность."
		])
	elif initial_size == "huge" and target_size == "big":
		transformation_desc = RNG.pick([
			"{npc.YourHis} массивная грудь уменьшается в размере, но всё еще остается большой и пышной.",
			"Тяжелое тепло слегка угасает, оставляя {npc.yourHis} грудь большой, но уже не такой подавляющей."
		])
	elif initial_size == "huge" and target_size == "medium":
		transformation_desc = RNG.pick([
			"{npc.YourHis} огромная грудь значительно уменьшается, но сохраняет приятную округлость.",
			"Охлаждающая волна проходит сквозь {npc.yourHis} грудь, уменьшая её до более умедобного, но всё еще полного размера."
		])
	elif initial_size == "huge" and target_size == "small":
		transformation_desc = RNG.pick([
			"{npc.YourHis} массивные груди резко сдуваются, превращаясь в скромную и миниатюрную форму.",
			"Заметное ощущение прохлады заставляет {npc.yourHis} грудь уменьшиться до скромных размеров."
		])
	elif initial_size == "huge" and target_size == "flat":
		transformation_desc = RNG.pick([
			"{npc.YourHis} массивные груди исчезают полностью, оставляя плоскую грудь.",
			"Сильный холод разливается по {npc.yourHis} груди, превращая её в плоскую поверхность."
		])

	# Default case for unexpected input
	if transformation_desc == "":
		transformation_desc = RNG.pick([
			"{npc.YourHis} грудь покалывает, но, кажется, её размер никак не изменился.",
			"Слабая энергия проходит сквозь {npc.yourHis} грудь, но заметных изменений не происходит."
		])

	return transformation_desc

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["howMuch"] = howMuch
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	howMuch = SAVE.loadVar(_data, "howMuch", 1)
