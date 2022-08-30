extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var settings_var
signal speed_changed
var internal_speed
onready var slider = $HSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	settings_var = get_node("/root/SettingsVars")
	internal_speed = settings_var.draw_coef
	slider.value = settings_var.draw_coef


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	settings_var.draw_coef = internal_speed
	emit_signal("speed_changed")
	hide()


func _on_HSlider_value_changed(value):
	internal_speed = value
