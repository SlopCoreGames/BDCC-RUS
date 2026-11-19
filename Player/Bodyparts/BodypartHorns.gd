extends Bodypart
class_name BodypartHorns

func _init():
	limbSlot = LimbTypes.Horns
	pickedRColor = Color.white
	pickedRColor = Color.lightgray
	pickedRColor = Color.darkgray

func getSlot():
	return BodypartSlot.Horns

func getCompatibleSpecies():
	return [Species.Any]
	
func getTraits():
	return {
		PartTrait.HornsGraspable: true,
	}

func hasCustomSkinPattern():
	return true

func generateRandomColors(_dynamicCharacter):
	var theHue = RNG.randf_range(0.0, 0.1)
	if(_dynamicCharacter != null):
		theHue = _dynamicCharacter.pickedSkinRColor.h
	
	pickedRColor = Color.from_hsv(theHue, RNG.randf_rangeX2(0.0, 0.3), RNG.randf_rangeX2(0.0, 0.5))
	pickedGColor = pickedRColor
	pickedGColor.v += RNG.randf_range(0.1, 0.2)
	if(_dynamicCharacter != null && (Species.Demon in _dynamicCharacter.getSpecies())):
		pickedBColor = ColorUtils.generateRandomVibrantColor()
	else:
		pickedBColor = pickedGColor
		pickedBColor.v += RNG.randf_range(-0.1, 0.2)
		pickedBColor.s += RNG.randf_range(-0.2, 0.2)
	
func getTransformAwayMessage(_context:Dictionary) -> String:
	var isSingular:bool = hasTrait(PartTrait.HornsSingle)
	return "{npc.YouHe} {npc.youAreHeIs} внезапно захлестнула острая, жгучая боль, исходящая от лба {npc.yourHis}, когда {npc.yourHis} рог"+("s" if !isSingular else "")+" начинает растворяться в коже {npc.yourHis}. Ощущение мучительное, словно огонь, бегущий по венам {npc.yourHis}, и {npc.youHe} чувствует, как рог"+("s" if !isSingular else "")+" сокращается мучительно медленно. Каждый потерянный дюйм сопровождается пульсирующей волной боли. Наконец, с последним всплеском боли, рог {npc.yourHis}"+("s" if !isSingular else "")+" исчезает полностью, оставляя {npc.youHim} лишь с гладким лбом."

func getTransformGrowMessage(_context:Dictionary) -> String:
	var isSingular:bool = hasTrait(PartTrait.HornsSingle)
	return "{npc.YouHe} {npc.youHeVerb('feel')} внезапно почувствовал(а) давление в области лба {npc.yourHis}, и с резкой вспышкой боли, "+("два величественных рога начинают" if !isSingular else "новый величественный рог начинает")+" пробиваться сквозь кожу {npc.yourHis}. "+("Они изгибаются" if !isSingular else "Он изгибается")+" вверх с яростной элегантностью; ощущения — смесь боли и дискомфорта, а {npc.yourHis} то и дело издает различные стоны и сопение в ходе этого долгого процесса. Только когда "+("всё заканчивается," if !isSingular else "всё заканчивается,")+" рост прекращается, {npc.youHe} наконец может выдохнуть."

func getTransformMorphMessage(_context:Dictionary) -> String:
	var oldTraits:Dictionary = _context["oldTraits"] if _context.has("oldTraits") else {}
	var wasSingle:bool = (oldTraits.has(PartTrait.HornsSingle) && oldTraits[PartTrait.HornsSingle])
	return "{npc.YourHis} horn"+("начинают менять свою форму. Они изгибаются и закручиваются" if !wasSingle else " начинает менять свою форму. Оно изгибается и закручивается")+", принимая новую, иную форму. Теперь {npc.YouHe} {npc.youHaveHeHas} "+getAVulgarName()+"."
