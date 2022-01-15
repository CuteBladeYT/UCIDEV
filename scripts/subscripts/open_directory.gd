extends Button


func openDir():
	var file = File.new()
	
	var projectDir = null
	
	if file.file_exists("user://project.uci"):
		file.open("user://project.uci", File.READ)
		projectDir = file.get_as_text()
	
	if projectDir:
		$popup.current_path = projectDir
		$popup.current_dir = projectDir
	
	$popup.popup()
	$popup.popup_centered()
