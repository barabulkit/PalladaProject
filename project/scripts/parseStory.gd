extends Node

var mainStoryLabel
var robotoLabel = preload("res://scenes/RobotoLabel.tscn")
var buttons : Array
var data
var currentPassage = 0
var container

# Called when the node enters the scene tree for the first time.
func _ready():
	load_story()
	
	print(data.passages[0].text)
	mainStoryLabel = get_node("MainStoryText")
	mainStoryLabel.text = data.passages[currentPassage].text
	
	container = get_node("ScrollContainer/VBoxContainer")
	process_links()

func load_story():
	var data_file = File.new()
	if data_file.open("res://data/pallada.json", File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	data = data_parse.result

func process_links():
	var passage = data.passages[currentPassage]
	if "links" in passage:
		var links = data.passages[currentPassage].links
		for link in links:
			var textLable = robotoLabel.instance()
			textLable.anchor_left = 0
			textLable.anchor_right = 1
			textLable.connect("mouse_entered", textLable, "_on_Mouse_entered")
			textLable.connect("mouse_exited", textLable, "_on_Mouse_exited")
			var linkPassage = find_by_pid(link.pid)
			textLable.connect("gui_input", self, "_on_Gui", [linkPassage])
			textLable.text = linkPassage.text
			container.add_child(textLable)
		

func find_by_pid(pid):
	var passages = data.passages
	for passage in passages:
		if(passage.pid == pid):
			return passage
	
	
func _on_Gui(event, linkPassage):
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		currentPassage = int(linkPassage.links[0].pid) - 1
		mainStoryLabel.text = data.passages[currentPassage].text
		for child in container.get_children():
			container.remove_child(child)
			child.queue_free()
		process_links()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
