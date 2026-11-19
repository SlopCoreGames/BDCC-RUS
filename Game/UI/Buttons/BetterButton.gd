extends Button
class_name BetterButton

export var myButtonText:String = ""
export var myTooltipName:String = ""
export var myTooltipDesc:String = ""

export var shouldScaleToUIButtonSize:bool = true
export var shouldShowShortcut:bool = true
export var allowDoubleTabSetting:bool = false
export var instantTooltip:bool = false

export var myShortcutKey:String = ""
export var myShortcutCtrl:bool = false

onready var key_label = $"%KeyLabel"
onready var margin_container = $"%MarginContainer"
onready var button_label = $"%ButtonLabel"

var showingDescription:bool = false
var _updating_text:bool = false

const BASE_DEFAULT_FONT = preload("res://UI/FontResources/GlobalDefaultFont.tres")
const SINGLE_LINE_SIZES := [20, 18, 16, 15, 14]
const WRAP_LINE_SIZES := [16, 15, 14, 13, 12, 11, 10, 9]
const EXPAND_FALLBACK_SIZES := [12, 11, 10, 9]

signal pressedActually

static func _get_font_for_size(_sz:int) -> DynamicFont:
	var cache:Dictionary
	if(OPTIONS.has_meta("_better_button_fonts")):
		cache = OPTIONS.get_meta("_better_button_fonts")
	else:
		cache = {}
		OPTIONS.set_meta("_better_button_fonts", cache)
	if(!cache.has(_sz)):
		var f:DynamicFont = BASE_DEFAULT_FONT.duplicate()
		f.size = _sz
		cache[_sz] = f
	return cache[_sz]

func _ready():
	if(shouldShowShortcut && OPTIONS.shouldShowShortcuts()):
		key_label.visible = true
	else:
		key_label.visible = false

	if(!text.empty() && text != " " && myButtonText.empty()):
		myButtonText = text
	text = " "

	if(!hint_tooltip.empty() && myTooltipDesc.empty()):
		myTooltipDesc = hint_tooltip
	hint_tooltip = ""

	if(!myShortcutKey.empty()):
		setShortcutPhysicalScancode(OS.find_scancode_from_string(myShortcutKey), myShortcutCtrl)
	checkDisabled()
	updateButtonSize()

	connect("resized", self, "_on_resized")
	OPTIONS.connect("onLayoutChange", self, "updateButtonSize")
	call_deferred("updateButtonText")

func _on_resized():
	if(!_updating_text):
		updateButtonText()

func _get_base_min_height() -> float:
	var h:float = 32.0
	if(shouldScaleToUIButtonSize):
		var minButtonSize:float = OPTIONS.getUiButtonSize()
		if(minButtonSize > 0):
			h = 20.0 + minButtonSize * 16.0
		else:
			h = 32.0
	if(OPTIONS.isTouchFriendlyUI()):
		h = max(h, 68.0)
	return h

func updateButtonSize():
	rect_min_size = Vector2(0.0, _get_base_min_height())
	call_deferred("updateButtonText")

func setButtonText(_text:String):
	myButtonText = _text
	updateButtonText()

func _measure_wrapped(font:Font, txt:String, max_w:float) -> Dictionary:
	if(max_w <= 4.0):
		return {"lines": 99, "overflow_word": true}
	var total_lines:int = 0
	var overflow_word:bool = false
	var paragraphs:PoolStringArray = txt.split("\n", true)
	var space_w:float = font.get_string_size(" ").x
	for p in paragraphs:
		if(p.empty()):
			total_lines += 1
			continue
		var words:PoolStringArray = p.split(" ", false)
		if(words.empty()):
			total_lines += 1
			continue
		var line_w:float = 0.0
		var lines_in_p:int = 1
		for w_idx in words.size():
			var word:String = words[w_idx]
			var ww:float = font.get_string_size(word).x
			if(ww > max_w):
				overflow_word = true
			if(line_w <= 0.0):
				line_w = ww
			elif(line_w + space_w + ww <= max_w):
				line_w += space_w + ww
			else:
				lines_in_p += 1
				line_w = ww
		total_lines += lines_in_p
	return {"lines": max(1, total_lines), "overflow_word": overflow_word}

func _apply_label_style(font:DynamicFont, wrapped:bool, target_min_y:float):
	button_label.autowrap = wrapped
	button_label.add_font_override("font", font)
	button_label.text = myButtonText
	if(abs(rect_min_size.y - target_min_y) > 0.5):
		rect_min_size.y = target_min_y

func updateButtonText():
	if(!is_inside_tree()):
		return
	_updating_text = true
	text = " "

	var base_h:float = _get_base_min_height()
	if(myButtonText.empty()):
		button_label.text = ""
		if(abs(rect_min_size.y - base_h) > 0.5):
			rect_min_size.y = base_h
		_updating_text = false
		return

	var show_key:bool = key_label.visible && !key_label.text.empty()
	var key_pad:int = 6
	if(show_key):
		var key_font:Font = key_label.get_font("font")
		var key_w:float = key_font.get_string_size(key_label.text).x if key_font != null else 10.0
		key_pad = int(ceil(key_w)) + 9
		key_label.margin_right = float(key_pad - 2)
	var right_pad:int = 6

	margin_container.set("custom_constants/margin_left", key_pad)
	margin_container.set("custom_constants/margin_right", right_pad)
	margin_container.set("custom_constants/margin_top", 1)
	margin_container.set("custom_constants/margin_bottom", 1)

	var usable_w:float = rect_size.x - float(key_pad + right_pad) - 2.0
	if(usable_w < 20.0):
		_apply_label_style(_get_font_for_size(14), true, base_h)
		_updating_text = false
		return

	var avail_h:float = max(base_h, rect_size.y) - 2.0
	for sz in SINGLE_LINE_SIZES:
		var f:DynamicFont = _get_font_for_size(sz)
		if(f.get_string_size(myButtonText).x <= usable_w && f.get_height() <= avail_h + 1.0):
			_apply_label_style(f, false, base_h)
			_updating_text = false
			return

	for sz in WRAP_LINE_SIZES:
		var f:DynamicFont = _get_font_for_size(sz)
		var res:Dictionary = _measure_wrapped(f, myButtonText, usable_w)
		var line_step:float = max(1.0, f.get_height() - 2.0)
		var total_h:float = f.get_height() + float(max(0, int(res["lines"]) - 1)) * line_step
		if(!res["overflow_word"] && total_h <= avail_h + 1.0):
			_apply_label_style(f, true, base_h)
			_updating_text = false
			return

	for sz in EXPAND_FALLBACK_SIZES:
		var f:DynamicFont = _get_font_for_size(sz)
		var res:Dictionary = _measure_wrapped(f, myButtonText, usable_w)
		var line_step:float = max(1.0, f.get_height() - 2.0)
		var total_h:float = f.get_height() + float(max(0, int(res["lines"]) - 1)) * line_step
		if(!res["overflow_word"] || sz == EXPAND_FALLBACK_SIZES[-1]):
			_apply_label_style(f, true, max(base_h, ceil(total_h) + 6.0))
			_updating_text = false
			return
	_updating_text = false

func setShortcutPhysicalScancode(code:int, reqControl:bool = false):
	var newShortcut = ShortCut.new()
	var inputKey = InputEventKey.new()
	inputKey.physical_scancode = code
	inputKey.control = reqControl
	newShortcut.shortcut = inputKey
	shortcut = newShortcut

	key_label.text = ("ctrl+" if reqControl else "")+OS.get_scancode_string(code)
	call_deferred("updateButtonText")

func _on_BetterButton_mouse_entered():
	showTooltip()

func _on_BetterButton_mouse_exited():
	hideTooltip()

func showTooltip():
	if(myTooltipName.empty() && myTooltipDesc.empty()):
		return
	GlobalTooltip.showTooltip(self, myTooltipName if !myTooltipName.empty() else myButtonText, myTooltipDesc, false, !instantTooltip)

func hideTooltip():
	GlobalTooltip.hideTooltip(self)

func setTooltipText(_name:String, _desc:String):
	myTooltipName = _name
	myTooltipDesc = _desc
	GlobalTooltip.setTooltipText(self, myTooltipName if !myTooltipName.empty() else myButtonText, myTooltipDesc)

func _on_BetterButton_pressed():
	if(OS.has_touchscreen_ui_hint() && OPTIONS.shouldRequireDoubleTapOnMobile() && allowDoubleTabSetting):
		if(!showingDescription):
			showingDescription = true
			emit_signal("mouse_entered")
		else:
			showingDescription = false
			emit_signal("pressedActually")
	else:
		emit_signal("pressedActually")

func setIsDisabled(_dis:bool):
	if(_dis == disabled):
		return
	disabled = _dis
	checkDisabled()

func checkDisabled():
	if(disabled):
		button_label["custom_colors/font_color"] = Color(0.44, 0.44, 0.44)
		key_label.self_modulate = Color(1, 1, 1, 0.22)
	else:
		button_label["custom_colors/font_color"] = Color.white
		key_label.self_modulate = Color(1, 1, 1, 0.38)
