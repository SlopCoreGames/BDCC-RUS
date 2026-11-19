extends Object
class_name NpcRank

const Spacer = "Spacer"
const SpaceCadet = "SpaceCadet"

const Inspector = "Inspector"
const ChiefInspector = "ChiefInspector"
const Sergeant = "Sergeant"

const PettyOfficer = "PettyOfficer"
const ChiefPettyOfficer = "ChiefPettyOfficer"

const Lieutenant = "Lieutenant"
const Executor = "Executor"

static func getVisibleName(rankID):
	if(rankID == SpaceCadet):
		return "Космический кадет"
	if(rankID == ChiefInspector):
		return "Главный инспектор"
	if(rankID == PettyOfficer):
		return "Младший офицер"
	if(rankID == ChiefPettyOfficer):
		return "Старший главный старшина"

	return str(rankID)
