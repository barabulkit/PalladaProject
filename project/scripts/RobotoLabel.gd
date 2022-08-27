extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Mouse_entered():
	set("custom_colors/font_color", Color(1,1,0))
	
func _on_Mouse_exited():
	set("custom_colors/font_color", Color(1,1,1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
