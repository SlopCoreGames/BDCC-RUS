extends TFEffect

var howMuch:float = 1

func _init():
	id = "PenisLengthChange"

func initArgs(_args:Array):
	if(_args.size() > 0):
		howMuch = _args[0]

func applyEffect(_data:Dictionary) -> Dictionary:
	var origLen = _data["lengthCM"] if _data.has("lengthCM") else 5.0
	
	if(_data.has("lengthCM")):
		_data["lengthCM"] += howMuch
		if(_data["lengthCM"] < 4.0):
			_data["lengthCM"] = 4.0
	else:
		_data["lengthCM"] = max(howMuch, 4.0)
	
	return {
		origLen = origLen,
		newLen = _data["lengthCM"],
		success = true,
	}
	
func onReplace(_otherEffect):
	howMuch += _otherEffect.howMuch

func generateTransformText(_result:Dictionary):
	var oldLen:float = _result["origLen"]
	var newLen:float = _result["newLen"]
	
	var text:String = ""
	if(newLen > oldLen):
		text += RNG.pick([
			"{npc.YourHis} {penis} становится длиннее!",
		])
		text += RNG.pick([
			" Ствол удлиняется, становясь одновременно длиннее и толще.",
			" {npc.YouHe} чувствует, как тяжесть смещается по мере того, как он становится длиннее.",
			" По мере того как он продолжает удлиняться, по нему пробегает покалывающее ощущение.",
			" Кожа плавно натягивается по мере роста, становясь всё более выраженной.",
			" {npc.YouHe} может видеть, как он удлиняется прямо на глазах у {npc.yourHis}.",
		])
		text += " {npc.YourHis} {npc.penis} теперь составляет "+Util.cmToString(newLen)+" long."
		if(newLen >= 25):
			text += RNG.pick([
				" Он просто охеренно огромный!",
				" Твою мать!",
				" Наверное, хватит, а?!",
				" Вот это настоящий ломатель девственности!",
				" Как вообще можно с такой хреновиной ходить?",
			])
		elif(newLen >= 15):
			text += RNG.pick([
				" Очень солидный член.",
				" Неплохо.",
				" Довольно крупный член.",
				" Класс.",
				" Приличный размер.",
			])
		
		addText(text)
	elif(newLen < oldLen):
		text += RNG.pick([
			"{npc.YourHis} {penis} уменьшается!",
			"{npc.YourHis} {penis} уменьшается! О нет.",
		])
		text += RNG.pick([
			" Ствол втягивается, теряя и в длину, и в обхвате.",
			" {npc.YouHe} чувствует, как он становится легче, уменьшаясь в размерах.",
			" По нему пробегает покалывающее ощущение, пока он продолжает сжиматься.",
			" Кожа натягивается вокруг него, и он становится всё менее выраженным.",
			" {npc.YouHe} видит, как он уменьшается на глазах у {npc.yourHis}.",
		])
		text += " {npc.YourHis} {npc.penis} теперь всего лишь " + Util.cmToString(newLen) + " long."
		if(newLen <= 5):
			text += RNG.pick([
				" Он такой крошечный!",
				" Как он мог стать таким маленьким?",
				" Это даже мило!",
				" Его практически не осталось!",
				" Как его вообще можно заметить?",
				" Теперь он как маленькая пуговка!",
				" Его почти не видно!",
				" Такое ощущение, что он совсем исчез!",
				" Это определенно не то, что было раньше!",
				" Он такой крошечный, прямо как игрушечный!",
			])
		elif(newLen <= 10):
			text += RNG.pick([
				" Довольно маленький размер.",
				" Работать особо не с чем.",
				" Маловато будет.",
				" Прямо прелесть, честное слово.",
				" Скромный размер.",
				" Теперь он определенно стал компактнее.",
				" Разница ощутима; он выглядит куда менее внушительно.",
				" Он уменьшается, становясь более изящным.",
				" Это весьма значительное уменьшение в размерах.",
				" Теперь с ним гораздо проще управляться.",
			])
		addText(text)
	else:
		text += RNG.pick([
			"{npc.YouHe} {npc.youHeVerb('feel')} в {npc.yourHis} {penis} покалывает, но, кажется, в остальном ничего не изменилось.",
		])
		addText(text)
#
#func generateShortTransformText(_result:Dictionary):
#	var origSize:int = _result["origSize"]
#	var size:int = _result["size"]
#	var breastsCovered:bool = (getChar().getFirstItemThatCoversBodypart(BodypartSlot.Breasts) != null)
#
#	addText(describeBreastTransformation(origSize, size, breastsCovered))

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["howMuch"] = howMuch
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	howMuch = SAVE.loadVar(_data, "howMuch", 1)
