extends NpcBreakTaskBase

var speciesID:String = ""

func _init():
	id = "HaveSexWithSpecies"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
	}

func getSlutlockWeight() -> float:
	return 1.0

func isPossibleFor(_npc, _isSlaveLevelup):
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = 1
	
	var allSpecies = GlobalRegistry.getAllSpecies()
	var possible = []
	for otherspeciesID in allSpecies:
		var weight = GM.main.getEncounterSettings().getSpeciesWeight(otherspeciesID)
		if(weight != null && weight > 0.0):
			possible.append([otherspeciesID, weight])
	
	var randomSpecies = RNG.pickWeightedPairs(possible)
	if(randomSpecies == null):
		randomSpecies = Species.Canine
	speciesID = randomSpecies

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() in [SexEvent.HolePenetrated, SexEvent.RubbedVaginas]):
		if(_event.getTargetChar() == _npc):
			if(speciesID in _event.getSourceChar().getSpecies()):
				advanceTask()
				return true
		elif(_event.getSourceChar() == _npc):
			if(speciesID in _event.getTargetChar().getSpecies()):
				advanceTask()
				return true
	return false

func getTaskString():
	var species = GlobalRegistry.getSpecies(speciesID)
	var speciesName:String = "Unknown"
	if(species != null):
		speciesName = species.getVisibleName()
	return "Переспать с "+str(speciesName)+" species"

func getTaskHint(_isSlaveLevelup):
	return "Найти представителя нужного вида"

func getNpcOwnerDialogueLines() -> Array:
	var species = GlobalRegistry.getSpecies(speciesID)
	var speciesName:String = "Unknown"
	if(species != null):
		speciesName = species.getVisibleName()
	
	return [
		"Найди себе "+speciesName+" чтобы трахнуть тебя. Мне плевать, как именно.",
		"Я хочу, чтобы твоим следующим партнером стал(а) "+speciesName+". Сделай это.",
		"Иди и дай просраться "+speciesName+". Ты им понравишься.",
		"Я хочу, чтобы тебя использовал(а) "+speciesName+". И не спрашивай почему.",
	]

func saveData():
	var data = .saveData()
	data["speciesID"] = speciesID
	
	return data

func loadData(data):
	.loadData(data)
	
	speciesID = SAVE.loadVar(data, "speciesID", Species.Human)
