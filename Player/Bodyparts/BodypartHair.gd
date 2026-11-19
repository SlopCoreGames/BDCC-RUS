extends Bodypart
class_name BodypartHair

var maleWeight = 1.0
var femaleWeight = 1.0

func _init():
	limbSlot = LimbTypes.Hair
	pickedRColor = Color.white
	pickedGColor = Color.lightgray
	pickedBColor = Color.darkgray

func getSlot():
	return BodypartSlot.Hair

func getCompatibleSpecies():
	return [Species.AnyNPC]

func npcGenerationWeight(_dynamicCharacter):
	if(_dynamicCharacter.getGender() == Gender.Male):
		return maleWeight
	if(_dynamicCharacter.getGender() in [Gender.Female, Gender.Androgynous]):
		return femaleWeight
	return 1.0

func hasCustomSkinPattern():
	return true

func generateRandomColors(_dynamicCharacter):
	var randomColors
	
	if(RNG.chance(20) && _dynamicCharacter != null):
		randomColors = ColorUtils.generate3ColorsFromMainColor(RNG.pick([_dynamicCharacter.pickedSkinGColor.inverted(), _dynamicCharacter.pickedSkinGColor, _dynamicCharacter.pickedSkinBColor]))
	elif(RNG.chance(30)):
		randomColors = ColorUtils.generateUnrealisticHairColors()
	else:
		randomColors = ColorUtils.generateRealisticHairColors()
		
	pickedRColor = randomColors[0]
	pickedGColor = randomColors[1]
	pickedBColor = randomColors[2]
	
func getTransformAwayMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание в {npc.yourHis} коже головы, когда {npc.yourHis} волосы начинают двигаться и меняться. Внезапно все волоски начинают втягиваться в {npc.yourHis} кожу головы, оставляя {npc.youHim} с гладкой, лысой головой."

func getTransformGrowMessage(_context:Dictionary) -> String:
	var isPonytailHair:bool = hasTrait(PartTrait.HairPonytail)
	var isShortHair:bool = hasTrait(PartTrait.HairShort)
	var isLongHair:bool = hasTrait(PartTrait.HairLong)
	var isOvereyeHair:bool = hasTrait(PartTrait.HairOvereye)
	
	if(isPonytailHair):
		return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание на макушке {npc.yourHis} головы, и вдруг волосы начинают стремительно расти. Пряди собираются вместе, стягиваясь в гладкий хвост, который покачивается при каждом движении. Хвост густой и блестящий, он словно излучает энергию, игриво подпрыгивая за {npc.yourHis} головой."
	if(isShortHair):
		return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание на макушке {npc.yourHis} головы, и вдруг волосы начинают стремительно расти. Они отрастают короткой стильной стрижкой, плотно облегая {npc.yourHis} голову. Каждый волосок густой и яркий, переливаясь на свету."
	if(isLongHair):
		return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание в макушке {npc.yourHis} головы, и внезапно волосы начинают стремительно расти. Длинные, струящиеся пряди каскадом спадают с {npc.yourHis} головы, густые и блестящие, словно каждый волосок пропитан энергией. Волосы грациозно ниспадают на {npc.yourHis} плечи, создавая чарующую ауру, которая притягивает взгляды при каждом движении."
	if(isOvereyeHair):
		return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание в макушке {npc.yourHis} головы, и внезапно волосы начинают стремительно расти. Пряди удлиняются и эффектно спадают, закрывая {npc.yourHis} глаза. Густые и яркие, они создают атмосферу таинственности, частично скрывая взгляд {npc.yourHis} и вызывая любопытство и интригу у тех, кто смотрит на {npc.youHim}."
	return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает покалывание в макушке {npc.yourHis} головы, и внезапно волосы начинают стремительно расти. Свежие новые пряди каскадом ниспадают с {npc.yourHis} головы, густые и блестящие, словно каждый волосок пропитан энергией."

func getTransformMorphMessage(_context:Dictionary) -> String:
	var oldTraits:Dictionary = _context["oldTraits"] if _context.has("oldTraits") else {}
	var hadPonytail:bool = (oldTraits.has(PartTrait.HairPonytail) && oldTraits[PartTrait.HairPonytail])
	var hadShortHair:bool = (oldTraits.has(PartTrait.HairShort) && oldTraits[PartTrait.HairShort])
	var hadLongHair:bool = (oldTraits.has(PartTrait.HairLong) && oldTraits[PartTrait.HairLong])
	var hadOvereyeHair:bool = (oldTraits.has(PartTrait.HairOvereye) && oldTraits[PartTrait.HairOvereye])
	
	var isPonytailHair:bool = hasTrait(PartTrait.HairPonytail)
	var isShortHair:bool = hasTrait(PartTrait.HairShort)
	var isLongHair:bool = hasTrait(PartTrait.HairLong)
	var isOvereyeHair:bool = hasTrait(PartTrait.HairOvereye)
	
	var gotShorter:bool = false
	var gotLonger:bool = false
	
	if(!hadLongHair && !hadPonytail && (isPonytailHair || isLongHair)):
		gotLonger = true
	if(!hadShortHair && !hadOvereyeHair && (isShortHair || isOvereyeHair)):
		gotShorter = true
	
	if(gotLonger):
		return "{npc.YouHe} {npc.youHeVerb('feel')} теплое ощущение у корней {npc.yourHis} волос, и внезапно пряди начинают удлиняться. Каждый волосок становится длиннее и объемнее, спадая роскошными волнами. Это преображение завораживает: волосы грациозно струятся, обретая совершенно новый облик."
	if(gotShorter):
		return "{npc.YouHe} {npc.youHeVerb('feel')} покалывание на кончиках {npc.yourHis} длинных волос, и в мгновение ока пряди начинают сокращаться. Волосы резко укорачиваются, принимая совсем другой, гораздо более короткий вид. В итоге {npc.youHe} {npc.youAreHeIs} остается с новой стрижкой."
	
	return "{npc.YouHe} {npc.youHeVerb('feel')} легкое изменение в структуре {npc.yourHis} волос, и внезапно пряди начинают перестраиваться. Длина меняется не слишком сильно, но стиль трансформируется во что-то иное. В итоге {npc.youHe} {npc.youAreHeIs} остается с новой стрижкой."
