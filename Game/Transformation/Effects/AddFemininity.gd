extends TFEffect

var howMuch:int = 10

func _init():
	id = "AddFemininity"

func initArgs(_args:Array):
	if(_args.size() > 0):
		howMuch = _args[0]

func applyEffect(_data:Dictionary) -> Dictionary:
	var oldFemininity:int = _data["femininity"] if _data.has("femininity") else 50
	if(_data.has("femininity")):
		_data["femininity"] += howMuch
		
		if(_data["femininity"] > 100):
			_data["femininity"] = 100
		if(_data["femininity"] < 0):
			_data["femininity"] = 0
	return {
		success = true,
		oldFemininity = oldFemininity,
		newFemininity = _data["femininity"] if _data.has("femininity") else 50,
	}
	
func onReplace(_otherEffect):
	howMuch += _otherEffect.howMuch

func generateTransformText(_result:Dictionary):
	var oldFemininity:int = _result["oldFemininity"]
	var newFemininity:int = _result["newFemininity"]
	
	if(newFemininity > oldFemininity):
		var text:String = ""
		if(oldFemininity < 100):
			text += RNG.pick([
				"Тело {npc.YourHis} становится более женственным.",
			])
			text += RNG.pick([
				" Кожа {npc.YourHis} начинает смягчаться, становясь более гладкой и нежной.",
				" Бедра {npc.YourHis} слегка расширяются, создавая более сексуальные изгибы.",
				" Даже голос {npc.yourHis} теперь звучит мягче.",
				" Голос {npc.YourHis} звучит мягче, более мелодично.",
				" Мускулы {npc.YourHis} смягчаются, приобретая более изящную форму.",
				" Бедра {npc.YourHis} начинают смягчаться и округляться, теряя любую мускулистость.",
				" {npc.YouHe} {npc.youHeVerb('feel')} ощущается глубокий внутренний сдвиг в тазу {npc.yourHis}, когда он подстраивается под более женственную структуру.",
				" Линия челюсти {npc.YourHis} смягчается, а {npc.yourHis} скулы приподнимаются, создавая более нежное и женственное лицо.",
				" Брови {npc.YourHis} разглаживаются, а {npc.yourHis} губы слегка пухнут, становясь более полными и сексуальными.",
				" От кожи {npc.yourHis} начинает исходить новый, едва уловимый аромат — сладкий и цветочный.",
			])
			text += " {npc.YouHe} {npc.youAreHeIs} now "+str(Util.roundF(newFemininity, 0))+"% feminine."
				
			if(newFemininity >= 100):
				text += " Женственность {npc.YourHis} достигла своего пика!"
		else:
			text += RNG.pick([
				"Тело {npc.YourHis} всё ещё пытается стать более женственным, но женственность {npc.yourHis} уже достигла своего предела!",
			])
			text += RNG.pick([
				" И всё же, кожа {npc.yourHis} становится ещё немного мягче.",
				" И всё же, голос {npc.yourHis} теперь начинает звучать чуть нежнее.",
				" И всё же, мышцы {npc.yourHis} размягчаются, приобретая более изящные очертания.",
			])
		addText(text)
	elif(newFemininity < oldFemininity):
		var text:String = ""
		if(oldFemininity > 0):
			text += RNG.pick([
				"Тело {npc.YourHis} становится более мужественным.",
			])
			text += RNG.pick([
				" Кожа {npc.YourHis} начинает грубеть, становясь более шершавой на ощупь.",
				" Плечи {npc.YourHis} расширяются, создавая более мощный силуэт.",
				" Даже голос {npc.yourHis} теперь звучит глубже.",
				" Голос {npc.YourHis} звучит глубже и резонирующе.",
				" Мышцы {npc.YourHis} становятся тверже, обретая рельеф и силу.",
				" Бедра {npc.YourHis} начинают твердеть, теряя всякую мягкость.",
				" {npc.YouHe} {npc.youHeVerb('feel')} ощущает глубокий внутренний сдвиг в {npc.yourHis} тазу, когда тот подстраивается под более мужественную структуру.",
				" Линия челюсти {npc.YourHis} становится острее, а {npc.yourHis} надбровные дуги — выразительнее, придавая лицу более суровый и мужественный вид.",
				" Брови {npc.YourHis} слегка хмурятся, а {npc.yourHis} губы становятся тоньше и четче очерченными.",
				" От кожи {npc.yourHis} начинает исходить новый, едва уловимый мускусный и землистый аромат.",
			])
			text += " {npc.YouHe} {npc.youAreHeIs} now " + str(Util.roundF(100.0 - newFemininity, 0)) + "% мужественный."

			if(newFemininity <= 0):
				text += " Мужественность {npc.YourHis} достигла своего пика!"
		else:
			text += RNG.pick([
				"Тело {npc.YourHis} пытается стать еще мужественнее, но {npc.yourHis} мужественность уже достигла своего пика!",
			])
			text += RNG.pick([
				" Но всё же кожа {npc.yourHis} становится чуть грубее.",
				" Но всё же голос {npc.yourHis} начинает звучать немного ниже.",
				" Но всё же мышцы {npc.yourHis} становятся чуть рельефнее.",
			])
		addText(text)

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["howMuch"] = howMuch
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	howMuch = SAVE.loadVar(_data, "howMuch", 10)
