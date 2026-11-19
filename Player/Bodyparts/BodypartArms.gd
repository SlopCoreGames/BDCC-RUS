extends Bodypart
class_name BodypartArms

func _init():
	limbSlot = LimbTypes.Arms

func getSlot():
	return BodypartSlot.Arms

func getTransformMorphMessage(_context:Dictionary) -> String:
	var isBuff:bool = hasTrait(PartTrait.ArmsBuff)
	return "{npc.YourHis} руки начинают трансформироваться! Форма меняется, "+("становясь куда более мускулистой," if isBuff else "а силуэт кардинально преображается")+". {npc.YouHe} now {npc.youHaveHeHas} "+getAVulgarName()+"."
