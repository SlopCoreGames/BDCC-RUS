extends Node

var _failures:Array = []

func _ready() -> void:
	call_deferred("_run_all")

func _fail(msg:String) -> void:
	_failures.append(msg)
	printerr("VERIFY_FAIL: " + msg)

func _scan_dir(dir_path:String, gd_list:Array, tscn_list:Array) -> void:
	var dir := Directory.new()
	if(dir.open(dir_path) != OK):
		_fail("Cannot open directory: " + dir_path)
		return
	var _beg_err:int = dir.list_dir_begin(true, true)
	var name_entry:String = dir.get_next()
	while(name_entry != ""):
		var full_path:String = dir_path.plus_file(name_entry)
		if(dir.current_is_dir()):
			if(!(name_entry in [".git", ".import", "ru_tools", "build", "AssetsSource", "addons"])):
				_scan_dir(full_path, gd_list, tscn_list)
		else:
			if(name_entry.ends_with(".gd")):
				gd_list.append(full_path)
			elif(name_entry.ends_with(".tscn")):
				tscn_list.append(full_path)
		name_entry = dir.get_next()
	dir.list_dir_end()

func _run_all() -> void:
	print("=== BDCC VERIFY START ===")

	# 1. GlobalRegistry initialization check
	if(!GlobalRegistry.isInitialized):
		GlobalRegistry.registerEverything()
		yield(GlobalRegistry, "loadingFinished")

	var scenes_count:int = GlobalRegistry.scenes.size()
	var items_count:int = GlobalRegistry.getItemRefs().size()
	var chars_count:int = GlobalRegistry.getCharacterClasses().size()
	var attacks_count:int = GlobalRegistry.getAttacks().size()
	var species_count:int = GlobalRegistry.getAllSpecies().size()
	print("GlobalRegistry: scenes=%d items=%d chars=%d attacks=%d species=%d" % [scenes_count, items_count, chars_count, attacks_count, species_count])

	if(scenes_count <= 100):
		_fail("Too few registered scenes: %d" % scenes_count)
	if(items_count <= 50):
		_fail("Too few registered items: %d" % items_count)
	if(chars_count <= 10):
		_fail("Too few registered characters: %d" % chars_count)
	if(attacks_count <= 10):
		_fail("Too few registered attacks: %d" % attacks_count)
	if(species_count <= 5):
		_fail("Too few registered species: %d" % species_count)

	# 2. Load & compile ALL .gd and .tscn files under res://
	var gd_list:Array = []
	var tscn_list:Array = []
	_scan_dir("res://", gd_list, tscn_list)
	gd_list.sort()
	tscn_list.sort()

	var gd_ok:int = 0
	for p in gd_list:
		var res = ResourceLoader.load(p)
		if(res == null || !(res is GDScript)):
			_fail("Failed loading GDScript: " + p)
		else:
			gd_ok += 1

	var tscn_ok:int = 0
	for p in tscn_list:
		var res = ResourceLoader.load(p)
		if(res == null || !(res is PackedScene)):
			_fail("Failed loading PackedScene: " + p)
		else:
			tscn_ok += 1

	print("Loaded scripts: %d/%d | scenes: %d/%d" % [gd_ok, gd_list.size(), tscn_ok, tscn_list.size()])

	# 3. Verify Cyrillic DynamicFont resources
	var font_paths:Array = [
		"res://Fonts/Resources/Normal20.tres",
		"res://Fonts/Resources/Bold20.tres",
		"res://Fonts/Resources/Italics20.tres",
		"res://Fonts/Resources/BoldItalics20.tres",
		"res://UI/FontResources/GlobalDefaultFont.tres",
		"res://Fonts/BodyWritingsFont.tres",
		"res://Fonts/BodyWritingsFontThin.tres",
	]
	for fp in font_paths:
		var fres = ResourceLoader.load(fp)
		if(fres == null || !(fres is DynamicFont)):
			_fail("Font failed to load as DynamicFont: " + fp)
		else:
			var sz:Vector2 = fres.get_string_size("Привет, мир! Ёё")
			if(sz.x <= 0.0):
				_fail("Font Cyrillic width <= 0: " + fp)
			else:
				print("Font OK (%s): width=%.1f" % [fp, sz.x])

	# 4. Instantiate key UI scenes
	var ui_scenes:Array = [
		"res://UI/LaunchScreen/LaunchScreen.tscn",
		"res://UI/MainMenu/MainMenu.tscn",
		"res://Game/UI/GameUI.tscn",
	]
	for sp in ui_scenes:
		var packed = ResourceLoader.load(sp)
		if(packed == null || !(packed is PackedScene)):
			_fail("Failed loading UI scene: " + sp)
			continue
		var inst = packed.instance()
		if(inst == null):
			_fail("Failed instancing UI scene: " + sp)
		else:
			inst.free()
			print("Instanced OK: " + sp)

	# 5. Test GameParser with Russian text
	var parser := GameParser.new()
	var parsed:String = parser.executeString("Привет, мир! {pick('да', 'нет')}")
	if(parsed != "Привет, мир! да" && parsed != "Привет, мир! нет"):
		_fail("GameParser unexpected output: " + parsed)
	else:
		print("GameParser OK: " + parsed)

	if(_failures.empty()):
		print("VERIFY_PASS")
		get_tree().quit(0)
	else:
		print("VERIFY_FAILED count=%d" % _failures.size())
		get_tree().quit(1)
