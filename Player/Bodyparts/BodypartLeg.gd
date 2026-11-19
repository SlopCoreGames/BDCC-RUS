extends Bodypart
class_name BodypartLeg

func _init():
	limbSlot = LimbTypes.Legs

func getSlot():
	return BodypartSlot.Legs

func getTransformMorphMessage(_context:Dictionary) -> String:
	var isDigi:bool = hasTrait(PartTrait.LegsDigi)
	var isHoofs:bool = hasTrait(PartTrait.LegsHoofs)
	#var isPlanti:bool = hasTrait(PartTrait.LegsPlanti)
	if(isHoofs):
		return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает мощный прилив силы в {npc.yourHis} ногах, и внезапно они начинают меняться. Трансформация происходит стремительно: {npc.yourHis} ступни перекраиваются в большие, крепкие копыта. Копыта, которые издают звук при каждом {npc.youHe} {npc.youHeVerb('make')} шаге."
	if(isDigi):
		return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает странное чувство в {npc.yourHis} ногах, и внезапно они начинают видоизменяться. Превращение происходит быстро: {npc.yourHis} ноги принимают пальцеходящую форму, и вес переносится на пальцы. Новые ноги выглядят изящными и ловкими, а под кожей перекатываются мышцы, отражая всё более звериную натуру."
	
	return "{npc.YourHis} ноги начинают трансформироваться! Их структура и силуэт резко меняются, а мышцы и кости внутри перестраиваются. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
