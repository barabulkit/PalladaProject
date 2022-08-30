extends Node

var mainStoryLabel
var settingsPopup
var robotoLabel = preload("res://scenes/RobotoLabel.tscn")
var buttons : Array
var data
var currentPassage = 0
var container
var linkLabels : Array
var currentLabel

onready var settingsMenu = $Popup

var text_draw_speed
var settings_var

# Called when the node enters the scene tree for the first time.
func _ready():
	load_story()

	mainStoryLabel = get_node("ScrollContainer2/MainStoryText")
	
	container = get_node("ScrollContainer/VBoxContainer")
	process_links()
	
	settings_var = get_node("/root/SettingsVars")
	set_mainstory_text()

func load_story():
	var data_file = File.new()
	if data_file.open("res://data/PalladaProject.json", File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	data = data_parse.result

func set_mainstory_text():
	mainStoryLabel.text = data.passages[currentPassage].text.split("[")[0]
	mainStoryLabel.percent_visible = 0
	text_draw_speed = settings_var.draw_coef / mainStoryLabel.text.length()

func process_links():
	var passage = data.passages[currentPassage]
	linkLabels = []
	if "links" in passage:
		var links = data.passages[currentPassage].links
		for link in links:
			var textLabel = robotoLabel.instance()
			textLabel.anchor_left = 0
			textLabel.anchor_right = 1
			textLabel.connect("mouse_entered", textLabel, "_on_Mouse_entered")
			textLabel.connect("mouse_exited", textLabel, "_on_Mouse_exited")
			var linkPassage = find_by_pid(link.pid)
			textLabel.connect("gui_input", self, "_on_Gui", [linkPassage])
			textLabel.text = linkPassage.name
			textLabel.percent_visible = 0
			container.add_child(textLabel)
			linkLabels.append(textLabel)
		currentLabel = 0
		
		

func find_by_pid(pid):
	var passages = data.passages
	for passage in passages:
		if(passage.pid == pid):
			return passage
	
	
func _on_Gui(event, linkPassage):
	if linkLabels[linkLabels.size() - 1].percent_visible != 1:
		return
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		currentPassage = int(linkPassage.pid) - 1
		set_mainstory_text()
		for child in container.get_children():
			container.remove_child(child)
			child.queue_free()
		process_links()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_draw_speed(delta)


func process_draw_speed(delta):
	if mainStoryLabel.percent_visible != 1:
		mainStoryLabel.percent_visible += text_draw_speed * delta
	if mainStoryLabel.percent_visible == 1:
		text_draw_speed = settings_var.draw_coef / linkLabels[currentLabel].text.length()
	if mainStoryLabel.percent_visible == 1 and linkLabels[currentLabel].percent_visible != 1:
		linkLabels[currentLabel].percent_visible += text_draw_speed * delta
	if linkLabels[currentLabel].percent_visible == 1 and currentLabel != linkLabels.size() - 1:
		currentLabel += 1
		text_draw_speed = settings_var.draw_coef / linkLabels[currentLabel].text.length()


func _on_PalladaProject_gui_input(event):
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		process_percent_visible()
		
func process_percent_visible():
	if mainStoryLabel.percent_visible != 1:
		mainStoryLabel.percent_visible = 1
	else: 
		linkLabels[currentLabel].percent_visible = 1
	
func _on_SettingsButton_pressed():
	settingsMenu.popup_centered()

func _on_Popup_speed_changed():
	var length
	if mainStoryLabel.percent_visible != 1:
		 length =mainStoryLabel.text.length()
	else: length = linkLabels[currentLabel].text.length()
	text_draw_speed = settings_var.draw_coef / length
