extends AuctionAction

func _init():
	id = "Continue"

func getName() -> String:
	return "Продолжить"

func getButtonDesc() -> String:
	return "Смотри, что будет дальше..."

func getActionType():
	return AuctionActionType.Continue

func getTraits() -> Dictionary:
	return {}
