extends Bodypart
class_name BodypartEars

func _init():
	limbSlot = LimbTypes.Ears

func getSlot():
	return BodypartSlot.Ears

func hasCustomSkinPattern():
	return true

func getTransformAwayMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} {npc.youHeVerb('feel')} ощущает странное давление: {npc.yourHis} уши сжимаются и прижимаются к {npc.yourHis} голове, превращаясь в едва заметные пупырышки."

func getTransformMorphMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} {npc.youHeVerb('feel')} чувствует покалывание по бокам {npc.yourHis} головы, и вдруг {npc.yourHis} уши начинают менять форму. Они вытягиваются и трансформируются, принимая новый, иной вид. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
