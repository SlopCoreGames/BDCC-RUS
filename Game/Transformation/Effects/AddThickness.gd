extends TFEffect

var howMuch:int = 10

func _init():
	id = "AddThickness"

func initArgs(_args:Array):
	if(_args.size() > 0):
		howMuch = _args[0]

func applyEffect(_data:Dictionary) -> Dictionary:
	var oldThickness:int = _data["thickness"] if _data.has("thickness") else 50
	if(_data.has("thickness")):
		if(_data["thickness"] < 150 || howMuch < 0):
			_data["thickness"] += howMuch
			
			if(_data["thickness"] > 150):
				_data["thickness"] = 150
			if(_data["thickness"] < 0):
				_data["thickness"] = 0
	return {
		success = true,
		oldThickness = oldThickness,
		newThickness = _data["thickness"] if _data.has("thickness") else 50,
	}
	
func onReplace(_otherEffect):
	howMuch += _otherEffect.howMuch

func generateTransformText(_result:Dictionary):
	var oldThickness:int = _result["oldThickness"]
	var newThickness:int = _result["newThickness"]
	
	if(newThickness > oldThickness):
		var text:String = ""
		text += RNG.pick([
			"{npc.YourHis} бедра начинают расширяться.",
			"{npc.YourHis} бедра начинают заметно расширяться.",
		])
		if(newThickness < 40):
			text += RNG.pick([
				" Но лишь самую малость.",
				" Но в целом фигура всё еще остается довольно стройной.",
				" Эта стройная задница скоро может перестать быть такой уж стройной.",
				" {npc.YourHis} задница становится всё более дряйловой с каждым новым фунтом.",
				" Мышцы больше не так заметны.",
				" Перемены едва уловимы... но они определенно есть.",
				" {npc.YourHis} тело всё еще сохраняет свою изящность.",
			])
		else:
			text += RNG.pick([
				" {npc.yourHis} задница становится всё более полной и округлой.",
				" Похоже, {npc.youHe} немного прибавила в весе.",
				" Изгибы {npc.YourHis} становятся всё более выразительными.",
				" {npc.YouHe} становится всё более {npc.youAreHeIs} пышной и сочной.",
				" Бёдра {npc.YourHis} начинают аппетитно округляться.",
				" Тело {npc.YourHis} обретает всё более женственные, пышные формы.",
				" Попа {npc.YourHis} становится восхитительно круглой.",
			])
			
		if(newThickness >= 150):
			text += " Пышность {npc.YourHis} достигла своего пика! {npc.YourHis} бёдра раздались до предела, создавая неоспоримо эффектный силуэт."
		addText(text)
	elif(newThickness < oldThickness):
		var text:String = ""
		text += RNG.pick([
			"Бёдра {npc.YourHis} начинают понемногу терять объём.",
		])
		text += RNG.pick([
			" {npc.YouHe} чувствует, как тело становится чуть менее полным.",
			" Изгибы {npc.YourHis} становятся менее выраженными.",
			" {npc.YouHe} {npc.youHeVerb('notice')} что {npc.yourHis} бедра стали не такими широкими, как раньше.",
			" Изменения едва заметны, но {npc.youHe} {npc.youHeVerb('feel')} выглядит немного стройнее.",
			" Тело {npc.YourHis} постепенно принимает более обтекаемую форму.",
			" {npc.YouHe} {npc.youHeVerb('feel')} легче, словно часть веса спала с плеч.",
			" {npc.YourHis} силуэт стал менее извилистым, чем мгновение назад.",
			" {npc.YouHe} чувствует перемены: форма {npc.yourHis} становится всё более хрупкой."
		])
		if(newThickness <= 0):
			text += " {npc.YourHis} толщина достигла минимально возможной отметки! {npc.YourHis} тело теперь невероятно стройное и изящное."
		addText(text)

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["howMuch"] = howMuch
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	howMuch = SAVE.loadVar(_data, "howMuch", 10)
