extends Bodypart
class_name BodypartBody

func _init():
	limbSlot = LimbTypes.Body

func getSlot():
	return BodypartSlot.Body

func getCompatibleSpecies():
	return [Species.Any]

func getTransformMorphMessage(_context:Dictionary) -> String:
	return "{npc.YouHe} {npc.youHeVerb('feel')} теплая волна окатила тело {npc.yourHis}, и внезапно сама его структура начала меняться. Мышцы перекатывались и смещались, и силуэт {npc.yourHis} стремительно трансформировался. Но даже в новой форме всё еще угадывались черты прежнего телосложения {npc.yourHis}. {npc.YouHe} теперь {npc.youHaveHeHas} "+getAVulgarName()+"."
