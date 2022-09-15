extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var container = $ScrollContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	container.add_constant_override("vseparation", 5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	hide()
	pass # Replace with function body.


func _on_Label_meta_clicked(meta):
	OS.shell_open(meta)
