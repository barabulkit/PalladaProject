extends Popup

onready var textEdit = $TextEdit
onready var consoleText = $ScrollContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if(event is InputEventKey):
		if(event.scancode == KEY_ESCAPE):
			hide()

func _on_TextEdit_gui_input(event):
	if(event is InputEventKey):
		if(event.scancode == KEY_ENTER):
			process_cheat(textEdit.text)
			textEdit.text = ""

func process_cheat(cheatStr):
	var splited = cheatStr.split(" ")
	var strForMatch = ""
	if splited.size() == 0:
		strForMatch = cheatStr
	else:
		strForMatch = splited[0]
	print(strForMatch)
	match splited[0]:
		"/add":
			get_parent().conditions.append(splited[1])
		"/list\n":
			var triggers = get_parent().conditions
			var index = 1
			for trigger in triggers:
				consoleText.text = consoleText.text + "\n" + index + ". " + trigger
				index += 1
		"/goto":
			print("goto")
			var passage = splited[1].replace("\n", "")
			get_parent().currentPassage = int(passage)
			get_parent().set_mainstory_text()
			get_parent().clear_links()
			get_parent().process_links()
			hide()
		#"/remove":
		#	pass


func _on_Button_pressed():
	process_cheat(textEdit.text)
	textEdit.text = ""
