extends Control

var projectDir = null
var canInput = true

var files = [null, null, null, null, null, null, null, null, null, "user://settings.uci", "user://theme.tres"]
#            0     1     2     3     4     5     6     7     8     Settings 9             Theme 10

func _ready():
	var file = File.new()
	var dir = Directory.new()
	if file.file_exists("user://project.uci"):
		$actions/closeDir.disabled = false
	else:
		$actions/closeDir.disabled = true
	if not file.file_exists(files[10]):
		dir.copy("res://styles/theme.tres", "user://theme.tres")
	if not file.file_exists(files[9]):
		dir.copy("res://settings.uci", files[9])
	
	$actions/settings.global = self
	
	$actions/settings.setting = $files/settings/code
	
	$files.theme = load(files[10])
	
	file.open(files[9], File.READ)
	$files/settings/code.text = file.get_as_text()


func _process(delta):
	var file = File.new()
	var dir = Directory.new()
	var current_tab = $files.current_tab + 1
	
	if canInput == true:
		if Input.is_action_pressed("ctrl"):
			if Input.is_action_pressed("shift"):
				if Input.is_action_just_pressed("save"):
					canInput = false
					$actions/save/popup.popup()
					$actions/save/popup.popup_centered()
					if not files[current_tab - 1]:
						$actions/save/popup.current_path = "user://"
					else:
						$actions/save/popup.current_path = files[current_tab - 1]	
			if Input.is_action_just_pressed("open"):
				$actions/openFile.openFile()
			if Input.is_action_just_pressed("d"):
				$actions/openDir.openDir()
			if Input.is_action_just_pressed("save"):
				canInput = false
				if files[current_tab - 1]:
					if file.file_exists(String(files[current_tab - 1])):
						file.open(String(files[current_tab - 1]), File.WRITE)
						file.store_line(get_node("files").get_node(String(current_tab)).get_node("code").text)
					else:
						$actions/save/popup.current_path = "user://"
						$actions/save/popup.popup()
						$actions/save/popup.popup_centered()
				else:
					$actions/save/popup.current_path = "user://"
					$actions/save/popup.popup()
					$actions/save/popup.popup_centered()
		
		if Input.is_action_pressed("alt"):
			if Input.is_action_just_pressed("1"):
				$files.current_tab = 0
			if Input.is_action_just_pressed("2"):
				$files.current_tab = 1
			if Input.is_action_just_pressed("3"):
				$files.current_tab = 2
			if Input.is_action_just_pressed("4"):
				$files.current_tab = 3
			if Input.is_action_just_pressed("5"):
				$files.current_tab = 4
			if Input.is_action_just_pressed("6"):
				$files.current_tab = 5
			if Input.is_action_just_pressed("7"):
				$files.current_tab = 6
			if Input.is_action_just_pressed("8"):
				$files.current_tab = 7
			if Input.is_action_just_pressed("9"):
				$files.current_tab = 8
		
	if Input.is_action_just_pressed("ui_cancel"):
		canInput = true
		$actions/openDir/popup.hide()
		$actions/openFile/popup.hide()
		$actions/save/popup.hide()

func confPopup(title, text):
	$confPopup.window_title = title
	$confPopup.dialog_text = text
	$confPopup.popup()
	$confPopup.popup_centered()


func changeProjectDir(dir):
	canInput = true
	projectDir = $actions/openDir/popup.current_path
	
	var direc = Directory.new()
	var file = File.new()
	if not direc.dir_exists(projectDir):
		confPopup("Error", "Directory not exists")
		return
	
	$actions/openFile.projectDir = $actions/openDir/popup.current_path
	
	if file.file_exists("user://project.uci"):
		direc.remove("user://project.uci")
	file.open("user://project.uci", File.WRITE)
	file.store_line(projectDir)
	
	$actions/closeDir.disabled = false
	


func openFile(path):
	canInput = true
	var current_tab = $files.current_tab + 1
	
	var dir = Directory.new()
	var file = File.new()
	if not file.file_exists(path):
		confPopup("Can't open File", "File not exists")
		return
	
	var pathsplit
	var filecode
	
	file.open(path, File.READ)
	filecode = file.get_as_text()
	
	get_node("files").get_node(String(current_tab)).get_node("code").text = filecode
	
	files[current_tab - 1] = String(path)

func closeDir():
	canInput = true
	var file = File.new()
	var dir = Directory.new()
	
	if file.file_exists("user://project.uci"):
		dir.remove("user://project.uci")
		if not file.file_exists("user://project.uci"):
			confPopup("Close Directory", "Closed succesfully")
			$actions/closeDir.disabled = true
		else:
			confPopup("Close Directory", "Failed closing directory")
	else:
		confPopup("Close Directory", "No directory opened")


func save():
	var file = File.new()
	var dir = Directory.new()
	
	var current_tab = $files.current_tab + 1
	
	if Input.is_action_pressed("shift"):
		canInput = false
		if not files[current_tab - 1]:
			$actions/save/popup.current_path = "user://"
		else:
			$actions/save/popup.current_path = files[current_tab - 1]
		$actions/save/popup.popup()
		$actions/save/popup.popup_centered()
	
	if Input.is_action_pressed("ctrl"):
		if files[current_tab - 1]:
			dir.remove(files[current_tab - 1])
			return
	
	if files[current_tab - 1]:
		if file.file_exists(String(files[current_tab - 1])):
			file.open(String(files[current_tab - 1]), File.WRITE)
			file.store_line(get_node("files").get_node(String(current_tab)).get_node("code").text)
		else:
			canInput = false
			$actions/save/popup.current_path = "user://"
			$actions/save/popup.popup()
			$actions/save/popup.popup_centered()
	else:
		canInput = false
		$actions/save/popup.current_path = "user://"
		$actions/save/popup.popup()
		$actions/save/popup.popup_centered()


func saveNew(path):
	canInput = true
	var current_tab = $files.current_tab + 1
	
	var file = File.new()
	var dir = Directory.new()
	
	file.open(path, File.WRITE)
	file.store_line(get_node("files").get_node(String(current_tab)).get_node("code").text)



func updateSettings():
	$actions/settings.setting = $files/settings/code


func tabChanged(tab):
	canInput = true
