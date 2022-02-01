extends Control

var files = [null, null, null, null, null, null, null, null, null]
#            1     2     3     4     5     6     7     8     9

onready var bg = $background/img

var currentDir

var dir = Directory.new()
var file = File.new()

# --------------------------------------------
# Paths
var settingspath = "res://settings.uci"
var projectpath = "res://project.uci"
var pluginspath = "res://plugins/"
# --------------------------------------------


# --------------------------------------------
# Save opened files on close
func _exit_tree():
	file.open(projectpath, File.WRITE)
	file.store_line($project.text)
# --------------------------------------------


# --------------------------------------------
# Run on load
func _ready():
	print(OS.get_screen_size())
	print(OS.window_size)
	settingsLoad()
	sessionRestore()
	loadPlugins()
	get_viewport().set_size_override(true, OS.get_screen_size())
	
	for m in get_tree().get_nodes_in_group("code"):
		m.syntax_highlighting = false
	
	if file.file_exists("res://bg.png"):
		bg.texture = load("res://bg.png")
	if file.file_exists("res://bg.jpg"):
		bg.texture = load("res://bg.jpg")
	
	# def highlighting fix
	for ides in $editor/files.get_child_count():
		var ide = get_node("editor/files").get_child(ides).get_node("code")
		ide.add_color_region('"', '"', $"editor/files/File 1/code".get_color("symbol_color"))
		ide.add_color_region("'", "'", $"editor/files/File 1/code".get_color("symbol_color"))
		ide.add_color_region("'''", "'''", $"editor/files/File 1/code".get_color("symbol_color"))
		ide.add_color_region('"""', '"""', $"editor/files/File 1/code".get_color("symbol_color"))
		ide.add_color_region("//", "", $"editor/files/File 1/code".get_color("font_color_readonly"), true)
		ide.add_color_region("#", "", $"editor/files/File 1/code".get_color("font_color_readonly"), true)
		ide.add_color_region("/*", "*/", $"editor/files/File 1/code".get_color("font_color_readonly"))
		ide.add_keyword_color("var", $"editor/files/File 1/code".get_color("member_variable_color"))
		ide.add_keyword_color("let", $"editor/files/File 1/code".get_color("member_variable_color"))
		ide.add_keyword_color("const", $"editor/files/File 1/code".get_color("member_variable_color"))
		ide.add_keyword_color("func", $"editor/files/File 1/code".get_color("member_variable_color"))
		ide.add_keyword_color("function", $"editor/files/File 1/code".get_color("member_variable_color"))
		ide.add_keyword_color("if", $"editor/files/File 1/code".get_color("member_variable_color"))
		ide.add_keyword_color("else", $"editor/files/File 1/code".get_color("member_variable_color"))
		ide.add_keyword_color("elif", $"editor/files/File 1/code".get_color("member_variable_color"))
# --------------------------------------------


# --------------------------------------------
# Keybinds
func _input(event):
	if Input.is_action_just_pressed("f11"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_pressed("ctrl"):
		if Input.is_action_just_pressed("s"):
			fileSave(true)
		if Input.is_action_just_pressed("o"):
			fileOpen()
		if Input.is_action_just_pressed("d"):
			dirOpen()
			
		if Input.is_action_pressed("shift"):
			if Input.is_action_just_pressed("s"):
				fileSave(false)
	
	if Input.is_action_pressed("alt"):
		if Input.is_action_just_pressed("1"):
			$editor/files.current_tab = 0
		if Input.is_action_just_pressed("2"):
			$editor/files.current_tab = 1
		if Input.is_action_just_pressed("3"):
			$editor/files.current_tab = 2
		if Input.is_action_just_pressed("4"):
			$editor/files.current_tab = 3
		if Input.is_action_just_pressed("5"):
			$editor/files.current_tab = 4
		if Input.is_action_just_pressed("6"):
			$editor/files.current_tab = 5
		if Input.is_action_just_pressed("7"):
			$editor/files.current_tab = 6
		if Input.is_action_just_pressed("8"):
			$editor/files.current_tab = 7
		if Input.is_action_just_pressed("9"):
			$editor/files.current_tab = 8
# --------------------------------------------


# --------------------------------------------
# Settings Load
func settingsLoad():
	file.open(settingspath, File.READ)
	$settings.text = file.get_as_text()
	for lsc in $settings.get_line_count():
		var line = $settings.get_line(lsc)
		var prop = line.strip_escapes().split(" ")[0]
		var val = line.strip_escapes().split(" ")[-1]
		
		if String(val) == "false":
			val = false
		if String(val) == "true":
			val = true
		
		if prop == "lineNum":
			for m in get_tree().get_nodes_in_group("code"):
				m.show_line_numbers = bool(val)
		if prop == "drawTabs":
			for m in get_tree().get_nodes_in_group("code"):
				m.draw_tabs = bool(val)
		if prop == "minimap":
			for m in get_tree().get_nodes_in_group("code"):
				m.minimap_draw = bool(val)
		if prop == "minimapWid":
			for m in get_tree().get_nodes_in_group("code"):
				m.minimap_width = float(val)
		if prop == "caretBlock":
			for m in get_tree().get_nodes_in_group("code"):
				m.caret_block_mode = bool(val)
		if prop == "caretBlink":
			for m in get_tree().get_nodes_in_group("code"):
				m.caret_blink = bool(val)
		if prop == "smoothScroll":
			for m in get_tree().get_nodes_in_group("code"):
				m.smooth_scrolling = bool(val)
		if prop == "uiShrink":
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(OS.get_screen_size()), float(val))
# --------------------------------------------


# --------------------------------------------
# Restore Session
func sessionRestore():
	if not file.file_exists(projectpath):
		return
	file.open(projectpath, File.READ)
	$project.text = file.get_as_text()
	currentDir = $project.get_line(0)
# --------------------------------------------

# --------------------------------------------
# Dir Open
func dirOpen():
	$popups/open_dir.popup()

func changeDir(dir):
	currentDir = dir
	$project.set_line(0, String(dir))
# --------------------------------------------


# --------------------------------------------
# File Open
func fileOpen():
	if currentDir:
		$popups/open_file.current_dir = currentDir
	else:
		$popups/open_file.current_dir = "res://"
	$popups/open_file.popup()


func openFile(path):
	var currt = $editor/files.current_tab
	var thisFile = file.open(path, File.READ)
	var filename = file.get_path_absolute().split("/", false)
	var fname = filename[filename.size() - 1].split(".")[0]
	var fext = filename[filename.size() - 1].split(".")[1]
	if get_node("editor/files").get_child(currt).get_node("code").text.length() == 0:
		get_node("editor/files").get_child(currt).get_node("code").text = file.get_as_text()
		get_node("editor/files").get_child(currt).name = String(fname) + " [" + String(fext) + "]"
		files[currt] = file.get_path_absolute()
		print(files)
		if fext == "txt" or "":
			get_node("editor/files").get_child(currt).get_node("code").syntax_highlighting = false
		else:
			get_node("editor/files").get_child(currt).get_node("code").syntax_highlighting = true
		return
	if get_node("editor/files").get_child(currt + 1):
		if get_node("editor/files").get_child(currt + 1).get_node("code").text.length() == 0:
			get_node("editor/files").get_child(currt + 1).get_node("code").text = file.get_as_text()
			get_node("editor/files").get_child(currt + 1).name = String(fname) + " [" + String(fext) + "]"
			$editor/files.current_tab = currt + 1
			files[currt + 1] = file.get_path_absolute()
			print(files)
			if fext == "txt" or "":
				get_node("editor/files").get_child(currt + 1).get_node("code").syntax_highlighting = false
			else:
				get_node("editor/files").get_child(currt + 1).get_node("code").syntax_highlighting = true
			return
	if get_node("editor/files").get_child(currt - 1):
		if get_node("editor/files").get_child(currt - 1).get_node("code").text.length() == 0:
			get_node("editor/files").get_child(currt - 1).get_node("code").text = file.get_as_text()
			get_node("editor/files").get_child(currt - 1).name = String(fname) + " [" + String(fext) + "]"
			$editor/files.current_tab = currt - 1
			files[currt - 1] = file.get_path_absolute()
			print(files)
			if fext == "txt" or "":
				get_node("editor/files").get_child(currt - 1).get_node("code").syntax_highlighting = false
			else:
				get_node("editor/files").get_child(currt - 1).get_node("code").syntax_highlighting = true
# --------------------------------------------


# --------------------------------------------
# File Save
func fileSave(isDirect:bool):
	var currt = $editor/files.current_tab
	if isDirect == true:
		dir.remove(files[currt])
		file.open(files[currt], File.WRITE)
		file.store_line(get_node("editor/files").get_child(currt).get_node("code").text)
		file.open("res://.dot", File.WRITE)
		file.store_line("CREATED WITH UCIDEV")
	else:
		if currentDir:
			$popups/save_file.current_dir = currentDir
		$popups/save_file.popup_centered()


func saveFile(path):
	dir.remove(path)
	file.open(path, File.WRITE)
	file.store_line(get_node("editor/files").get_child($editor/files.current_tab).get_node("code").text)
	file.open("res://.dot", File.WRITE)
	file.store_line("CREATED WITH UCIDEV")
# --------------------------------------------

# --------------------------------------------
# Plugins
func loadPlugins():
	if not dir.dir_exists(pluginspath):
		return
	dir.open(pluginspath)
	var pList = []
	dir.list_dir_begin()
	while true:
		var pFile = dir.get_next()
		if pFile == "":
			break
		elif not pFile.begins_with("."):
			pList.append(pFile)
	
	dir.list_dir_end()
	
	print(pList)
	
	for plN in pList.size():
		var plugin = Control.new()
		var cPl = pList[plN]
		var scr = Script.new()
		plugin.set_script(load(pluginspath + cPl))
		plugin.name = String(cPl)
		get_node("plugins").add_child(plugin)
# --------------------------------------------
