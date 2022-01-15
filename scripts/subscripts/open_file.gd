extends Button

var projectDir = null


func openFile():
	if not projectDir:
		projectDir = "user://"
	
	var file = File.new()
	var pd = null
	
	if file.file_exists("user://project.uci"):
		file.open("user://project.uci", File.READ)
		pd = file.get_as_text()
	
	$popup.popup()
	$popup.popup_centered()
	if pd:
		$popup.current_dir = pd
		$popup.current_path = pd
	else:
		$popup.current_dir = projectDir
		$popup.current_path = projectDir
