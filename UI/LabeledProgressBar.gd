extends PanelContainer

export(Gradient) var colorGradient
export var propertyName = "Property"
var currentValue = null
var currentBarValue = 0.0

onready var left_label = $MarginContainer/HBoxContainer/Label
onready var right_label = $MarginContainer/HBoxContainer/Label2

const BAR_FONT_SIZES := [20, 16, 14, 12]

func _ready():
	$ProgressBar.value = 0
	left_label.text = propertyName
	connect("resized", self, "_fit_labels")
	call_deferred("_fit_labels")

func _fit_labels():
	if(!is_inside_tree() || rect_size.x < 30.0):
		return
	var avail_w:float = rect_size.x - 14.0
	var chosen:DynamicFont = BetterButton._get_font_for_size(BAR_FONT_SIZES[-1])
	for sz in BAR_FONT_SIZES:
		var f:DynamicFont = BetterButton._get_font_for_size(sz)
		var lw:float = f.get_string_size(left_label.text).x
		var rw:float = f.get_string_size(right_label.text).x
		if(lw + rw <= avail_w):
			chosen = f
			break
	left_label.add_font_override("font", chosen)
	right_label.add_font_override("font", chosen)

func setTextLeft(leftText):
	left_label.text = leftText
	call_deferred("_fit_labels")

func setText(rightText):
	right_label.text = rightText
	call_deferred("_fit_labels")

func setProgressBarValue(value):
	if(currentValue == value):
		return

	currentValue = value
	$Tween.interpolate_method(self, "updateBarValue", currentBarValue, currentValue, 1.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()

func updateBarValue(value):
	$ProgressBar.value = value
	$ProgressBar.get("custom_styles/fg").set_bg_color(colorGradient.interpolate(value))
	currentBarValue = value

func setProgressBarValueInt(value, maxvalue):
	var fvalue = float(value)
	var fmaxvalue = float(maxvalue)

	if(fmaxvalue == 0.0):
		return

	var ffvalue = fvalue/fmaxvalue
	setProgressBarValue(ffvalue)

func resetToZero():
	currentBarValue = 0.0
	$ProgressBar.value = 0.0
