extends SlaveActivityBase

var petWants = ""
var petLastWant = ""
var petPossibleWants = [
	["shower", 1.0],
	["food", 1.0],
	["play", 1.0],
	["train", 1.0],
	["pee", 0.3],
]
var wantCooldown = 3

var puppyPoints = 0

func getNeedText():
	if(getSlave().getWorkEfficiency() <= 0.1):
		return "Твой питомец [b]устал[/b]. Пора заканчивать прогулку."
	if(petWants == "shower"):
		return "Твой питомец хочет, чтобы его [b]помыли[/b] (душ)"
	if(petWants == "food"):
		return "Твой питомец [b]голоден[/b] (столовая)"
	if(petWants == "play"):
		return "Твой питомец хочет [b]поиграть[/b] (двор)"
	if(petWants == "train"):
		return "Твой питомец хочет, чтобы его [b]дрессировали[/b] (двор)"
	if(petWants == "pee"):
		return "Твоему питомцу нужно [b]пописать[/b] (душ/двор)"
	return "Сейчас питомцу ничего не нужно. Погуляйте, пока не возникнет новая потребность."

func generateNextWant():
	petWants = RNG.pickWeightedPairs(petPossibleWants)
	while(petWants == petLastWant):
		petWants = RNG.pickWeightedPairs(petPossibleWants)

func getRequiredPuppyPoints() -> int:
	var puppySkill = getSlave().getSlaveSkill(SlaveType.Pet)
	return 1 + int(sqrt(puppySkill+1)*1.5)

func generateNextWantIfNeeded(chanceToGenerate = 20):
	if(petWants != ""):
		return
	if(wantCooldown > 0):
		wantCooldown -= 1
		return
	if(RNG.chance(chanceToGenerate)):
		generateNextWant()
		wantCooldown = 5

func satisfyWant(theWant):
	#if(getSlave().getWorkEfficiency() <= 0.1):
	#	petWants = ""
	#	return
	if(theWant == petWants):
		GM.main.addMessage("Хотелки питомца удовлетворены!")
		petLastWant = petWants
		petWants = ""
		puppyPoints += 1
		getSlave().addExperience(10)

func onPat():
	puppyPoints += 1
	getSlave().addExperience(5)

func onEnd():
	if(puppyPoints >= getRequiredPuppyPoints()):
		if(getSlave().levelupSpecialization(SlaveType.Pet)):
			GM.main.addMessage("Ваш питомец достаточно обучился, чтобы повысить ранг навыка.")
		elif(getSlave().getSlaveSkill(SlaveType.Pet) >= 15):
			getSlave().addExperience(50)
			GM.main.addMessage("Ваш питомец получил 50 единиц рабского опыта за отличную прогулку.")

func _init():
	id = "Walkies"
	
func getVisibleName():
	return "На прогулке"

func onStart(_args = []):
	pass

func onNewDay():
	pass

func preventsStatsDecay():
	return false

func preventsNormalInteractions():
	return true

func getActivityText():
	return "Этого не должно быть видно!"

func hoursPassed(_howMuch):
	return

func getCustomInteractAnimInfo():
	return [StageScene.Solo, "stand", {pc="pc"}]

func saveData():
	var data = .saveData()
	
	data["petWants"] = petWants
	data["petLastWant"] = petLastWant
	data["puppyPoints"] = puppyPoints
	
	return data

func loadData(_data):
	.loadData(_data)
	
	petWants = SAVE.loadVar(_data, "petWants", "")
	petLastWant = SAVE.loadVar(_data, "petLastWant", "")
	puppyPoints = SAVE.loadVar(_data, "puppyPoints", 0)
