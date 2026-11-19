extends FluidBase

func _init():
	id = "CumLube"

func getVisibleName():
	return "Смазка из спермы"

func getCumOverlayColor():
	return Color.lightgray

func canStoreInFluidTank() -> bool:
	return false
