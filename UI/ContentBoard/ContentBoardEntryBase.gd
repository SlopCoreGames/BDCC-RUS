extends Reference
class_name ContentBoardEntryBase

var id:String = ""

func getName() -> String:
	return "Наполни меня"

func getDesc(_isFull:bool) -> String:
	return "Напишите описание здесь!"

func getCompletedDesc() -> String:
	return ""

func getKinks() -> Array:
	return []

func getStartConditions() -> Array:
	return [
		[ContentBoardCondition.Incomplete, "Сделай чертовское мяу"],
		[ContentBoardCondition.InProgress, "Мяу-мяу"],
		[ContentBoardCondition.Complete, "Мяу-мяу!!"],
	]

func getProgressText() -> String:
	return "Сделай что-нибудь, хрен знает что"

func getStatus() -> int:
	return ContentBoardStatus.Unknown

func isStarted() -> bool:
	return ContentBoardStatus.doesCountAsStarted(getStatus())

func isCompleted() -> bool:
	return ContentBoardStatus.doesCountAsCompleted(getStatus())

func getFlag(_flagID:String, _default = null):
	if(!GM.main):
		return _default
	return GM.main.getFlag(_flagID, _default)

func completeIf(_flagID:String) -> int:
	if(getFlag(_flagID, false)):
		return ContentBoardCondition.Complete
	return ContentBoardCondition.Incomplete

func completeIfBool(_b:bool) -> int:
	if(_b):
		return ContentBoardCondition.Complete
	return ContentBoardCondition.Incomplete
	
