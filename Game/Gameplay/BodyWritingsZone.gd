extends Object
class_name BodyWritingsZone

enum { # IF YOU ADD ANY, ADD THEM TO WritingZoneInfoNode CLASS TOO
	Forehead,
	CheekLeft,
	CheekRight,
	Chin,
	
	ArmLeft,
	ArmRight,
	ForearmLeft,
	ForearmRight,
	
	UpperChest,
	Breasts,
	Belly,
	LowerAbdomen,
	Back,
	LowerBack,
	HipLeft,
	HipRight,
	
	ButtcheekLeft,
	ButtcheekRight,	
	ThighLeft,
	ThighRight,
	ShinLeft,
	ShinRight,
}
const zoneVisibleName = {
	Forehead: "forehead",
	CheekLeft: "левая щека",
	CheekRight: "правая щека",
	Chin: "chin",
	
	ArmLeft: "левая рука",
	ArmRight: "правая рука",
	ForearmLeft: "левое предплечье",
	ForearmRight: "правое предплечье",
	
	UpperChest: "верхняя часть груди",
	Breasts: "breasts",
	Belly: "belly",
	LowerAbdomen: "низ живота",
	Back: "back",
	LowerBack: "поясница",
	HipLeft: "левое бедро",
	HipRight: "правое бедро",
	
	ButtcheekLeft: "левая ягодица",
	ButtcheekRight: "правая ягодица",
	ThighLeft: "левое бедро",
	ThighRight: "правое бедро",
	ShinLeft: "левая голень",
	ShinRight: "правая голень",
}
const ALL = [
	Forehead,
	CheekLeft,
	CheekRight,
	Chin,
	
	ArmLeft,
	ArmRight,
	ForearmLeft,
	ForearmRight,
	
	UpperChest,
	Breasts,
	Belly,
	LowerAbdomen,
	Back,
	LowerBack,
	HipLeft,
	HipRight,
	
	ButtcheekLeft,
	ButtcheekRight,	
	ThighLeft,
	ThighRight,
	ShinLeft,
	ShinRight,
]

static func getAll():
	return zoneVisibleName.keys()

static func getRandomZone():
	return RNG.pick(zoneVisibleName.keys())

static func getRandomZoneLowerPart():
	return RNG.pick([
		LowerAbdomen, HipLeft, HipRight, ButtcheekLeft, ButtcheekRight, ThighLeft, ThighRight, ShinLeft, ShinRight
	])

static func getZoneVisibleName(zoneID: int):
	if(!zoneVisibleName.has(zoneID)):
		return "error:BADZONE"+str(zoneID)
	return zoneVisibleName[zoneID]
