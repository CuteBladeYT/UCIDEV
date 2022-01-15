extends Button

var spath = "user://settings.uci"
var global = null
var setting = null

var dir = Directory.new()
var file = File.new()

func settings():
	if Input.is_action_pressed("shift"):
		settingsSave()
		return
	if Input.is_action_pressed("ctrl"):
		settingsApply()
		return
	
	var files = self.get_parent().get_parent().get_node("files")
	files.current_tab = (files.get_child_count() - 1)


func floatBool(val):
	if String(val) == "0":
		return false
	if String(val) == "1":
		return true
	
	if String(val) == "false" or "False":
		return "0"
	if String(val) == "true" or "True":
		return "1"

func settingsApply():
	if not file.file_exists(spath):
		dir.copy("res://settings.uci", "user://settings.uci")
	file.open(spath, File.READ)
	var sttgs = file.get_as_text()
	setting.text = sttgs
	var sLines = setting.get_line_count()
	
	for lsc in sLines -1:
		var line = setting.get_line(lsc)
		var prop = String(line).strip_escapes().split(" ")[0]
		var val = String(line).strip_escapes().split(" ")[-1]
		var jbool
		if String(prop) == "caretBlink":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.caret_blink = bool(jbool)
		if String(prop) == "caretBlock":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.caret_block_mode = bool(jbool)
		if String(prop) == "caretBlinkSpeed":
			for member in get_tree().get_nodes_in_group("idecode"):
				member.caret_blink_speed = float(val)
		if String(prop) == "minimap":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.minimap_draw = bool(jbool)
		if String(prop) == "minimapWidth":
			for member in get_tree().get_nodes_in_group("idecode"):
				member.minimap_width = float(val)
		if String(prop) == "lineNum":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.show_line_numbers = bool(jbool)
		if String(prop) == "drawTabs":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.draw_tabs = bool(jbool)
		if String(prop) == "drawSpaces":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.draw_spaces = bool(jbool)
		if String(prop) == "brpointGutter":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.breakpoint_gutter = bool(jbool)
		if String(prop) == "foldGutter":
			jbool = floatBool(val)
			for member in get_tree().get_nodes_in_group("idecode"):
				member.fold_gutter = bool(jbool)

func settingsSave():
	file.open(spath, File.WRITE)
	file.store_line(String(setting.text))
	
	file.open("user://.dot", File.WRITE)
	file.store_line("")


func theme(val):
	if String(val) == "1":
		return "Default"
	if String(val) == "2":
		return "UCI 1"

