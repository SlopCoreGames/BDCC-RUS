extends Reference
class_name SexGoalBase

var id = "error"

func getVisibleName():
	return "Ошибка"

func isPossible(_sexEngine, _domInfo, _subInfo, _data):
	return true

func isCompleted(_sexEngine, _domInfo, _subInfo, _data):
	return false

func generateData(_sexEngine, _domInfo, _subInfo):
	return []

func progressGoal(_sexEngine, _domInfo, _subInfo, _data, _args = []):
	pass

func getSubGoals(_sexEngine, _domInfo, _subInfo, _data):
	return {}

func canLeadToSubsPregnancy(_sexEngine, _domInfo, _subInfo, _data):
	return false

func domWantsToCum():
	return false

func getGoalDefaultWeight():
	return 1.0

func doFastSex(_sexEngine, _domInfo, _subInfo, _data):
	pass

func sendSexEvent(_sexEngine, type, _sourceInfo, _targetInfo, data = {}):
	var newSexEvent:SexEvent = SexEvent.new()
	newSexEvent.type = type
	newSexEvent.sourceCharID = _sourceInfo.charID
	newSexEvent.targetCharID = _targetInfo.charID
	newSexEvent.data = data
	newSexEvent.isSexEngine = true
	newSexEvent.sexEngine = _sexEngine
	
	_sourceInfo.getChar().sendSexEvent(newSexEvent)
	if(_sourceInfo.getChar() != _targetInfo.getChar()):
		_targetInfo.getChar().sendSexEvent(newSexEvent)

func canBegFor() -> bool:
	return false

func getBegName() -> String:
	return getVisibleName()

const BegCategoryDefault = ["Beg"]
const BegCategoryChoking = ["Beg", "Choking"]
const BegCategoryExotic = ["Beg", "Exotic"]
const BegCategorySex = ["Beg", "Sex"]
func getBegCategory() -> Array:
	return BegCategoryDefault

func getBegDesc() -> String:
	return "Попроси домина к сделать это с тобой!"

func getBegMessage(_sexEngine, _domInfo, _subInfo) -> String:
	return "{sub.You} {sub.youVerb('beg')} {dom.you} to '"+getVisibleName()+"'."

func getBegDialogue(_sexEngine, _domInfo, _subInfo) -> String:
	return "Ну пожалуйста?"

func getBegAgreeDialogue() -> String:
	return RNG.pick([
		"Конечно.",
		"Звучит неплохо.",
		"Ладно, давай.",
		"Хм. Окей, погнали.",
		"Конечно, посмотрим, что из этого выйдет.",
		"Почему бы и нет, давай.",
		"Ладно, я тебя услышала.",
	])

func getBegDenyDialogue() -> String:
	return RNG.pick([
		"Не-а. Не хочу.",
		"Не хочу этого делать.",
		"Нет, я на это не подпишусь.",
		"Нет. Просто нет.",
	])

func getBegDomFetishes() -> Dictionary:
	return {}
