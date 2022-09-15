extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var settings_var
signal speed_changed
signal language_changed
signal sound_state_changed
var internal_speed
var internal_language
var disableSound = false
onready var slider = $HBoxContainer3/HSlider
onready var dropdown = $HBoxContainer/OptionButton
onready var langLabel = $HBoxContainer/LanguageLabel
onready var speedLabel = $HBoxContainer3/TextSpeedLabel
onready var disableSoundLabel = $HBoxContainer2/DisableSoundLabel
onready var acceptButton = $AcceptButton

# Called when the node enters the scene tree for the first time.
func _ready():
	settings_var = get_node("/root/SettingsVars")
	internal_speed = settings_var.draw_coef
	slider.value = settings_var.draw_coef
	dropdown.add_item("English")
	dropdown.add_item("Русский")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func updateLang(language):
	if language == "English":
		langLabel.text = "Language"
		speedLabel.text = "Text draw speed"
		acceptButton.text = "Accept"
		disableSoundLabel.text = "Disable sound"
	else:
		langLabel.text = "Язык"
		speedLabel.text = "Скорость прорисовки текста"
		acceptButton.text = "Принять"
		disableSoundLabel.text = "Отключить звук"

func _on_Button_pressed():
	if settings_var.draw_coef != internal_speed:
		settings_var.draw_coef = internal_speed
		emit_signal("speed_changed")
	if settings_var.language != internal_language:
		settings_var.language = internal_language
		updateLang(internal_language)
		emit_signal("language_changed")
	if settings_var.disableSound != disableSound:
		settings_var.disableSound = disableSound
		emit_signal("sound_state_changed")
	hide()


func _on_HSlider_value_changed(value):
	internal_speed = value


func _on_OptionButton_item_selected(index):
	internal_language = dropdown.get_item_text(index)
	pass # Replace with function body.


func _on_DisableSoundCheckBox_toggled(button_pressed):
	print(button_pressed)
	disableSound = button_pressed
	pass # Replace with function body.
