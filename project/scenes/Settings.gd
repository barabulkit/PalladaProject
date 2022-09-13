extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var settings_var
signal speed_changed
signal language_changed
var internal_speed
var internal_language
onready var slider = $HSlider
onready var dropdown = $OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	settings_var = get_node("/root/SettingsVars")
	internal_speed = settings_var.draw_coef
	slider.value = settings_var.draw_coef
	dropdown.add_item("Русский")
	dropdown.add_item("English")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	settings_var.draw_coef = internal_speed
	settings_var.language = internal_language
	emit_signal("speed_changed")
	emit_signal("language_changed")
	hide()


func _on_HSlider_value_changed(value):
	internal_speed = value


func _on_OptionButton_item_selected(index):
	internal_language = dropdown.get_item_text(index)
	pass # Replace with function body.
