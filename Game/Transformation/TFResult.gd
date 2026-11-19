extends Reference
class_name TFResult

var effects:Dictionary = {}
var tfresult:Dictionary = {}

func setData(newtfresult:Dictionary, newEffects:Dictionary):
	tfresult = newtfresult
	effects = newEffects

func isSuccessful(effectID:String) -> bool:
	if(!effects.has(effectID)):
		return false
	if(!effects[effectID].has("success") || !effects[effectID]["success"]):
		return false
	return true

func getField(keyID:String, default = null):
	if(!tfresult.has(keyID)):
		return default
	return tfresult[keyID]

func getEffectField(effectID:String, keyID:String, default = null):
	if(!effects.has(effectID)):
		return default
	if(!effects[effectID].has(keyID)):
		return default
	return effects[effectID][keyID]

func getTFText(effectID:String) -> String:
	if(!effects.has(effectID)):
		return ""
	if(!effects[effectID].has("effect")):
		return ""
	return effects[effectID]["effect"].generateTransformTextFinal(effects[effectID])

func getAllTFTexts(connectorStr:String = "\n\n", addMiddleParts:bool = true) -> String:
	var results:Array = []
	for effectID in effects:
		if(getEffectField(effectID, "noOutput", false)):
			continue
		var theTFText:String = getTFText(effectID)
		if(theTFText == ""):
			continue
		results.append(theTFText)
	
	if(!addMiddleParts):
		return Util.join(results, connectorStr)
	var actualResults:Array = []
	var resLen:int = results.size()
	for resultText in results:
		var isLast:bool = (resLen == 1)
		
		actualResults.append(resultText)
		if(!isLast):
			actualResults.append(RNG.pick([
				"Но это еще не всё...",
				"Происходит что-то еще..",
				"Как раз тогда, когда {npc.youHe} {npc.youHeVerb('think')} кажется, что всё закончилось..",
				"Погоди.. Еще?",
				"Оно не останавливается..",
				"И на этом всё не заканчивается..",
				"Это даже не {npc.yourHis} финальная форма..",
				"Что-то еще пробуждается..",
				"Впереди еще больше сюрпризов..",
				"Это всё? Нет.",
				"В то же самое время происходит что-то еще..",
			]))
		resLen -=1
	
	return Util.join(actualResults, connectorStr)

func getAllTFTextsArray() -> Array:
	var results:Array = []
	for effectID in effects:
		results.append(getTFText(effectID))
	return results
