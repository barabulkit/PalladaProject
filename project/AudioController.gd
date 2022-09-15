extends Node

onready var vyperStream = $Vyper
onready var candyStream = $Candy
onready var goodbyeStream = $Goodbye
onready var headacheStream = $Headache
onready var enoughStream = $Enough

onready var vyperTween = $Vyper/VyperTween
onready var candyTween = $Candy/CandyTween
onready var goodbyeTween = $Goodbye/GoodbyeTween
onready var headacheTween = $Headache/HeadacheTween
onready var enoughTween = $Enough/EnoughTween

var currentAudio setget SetCurrentAudio
var currentStream
var currentTween

# Called when the node enters the scene tree for the first time.
func _ready():
	vyperStream._set_playing(true)
	vyperTween.interpolate_property(vyperStream, "volume_db", vyperStream.volume_db, -10, 3, Tween.TRANS_QUART, Tween.EASE_OUT)
	vyperTween.start()
	currentTween = vyperTween
	currentStream = vyperStream

func SetCurrentAudio(audio):
	if not currentAudio == audio:
		currentAudio = audio
		changeMusic()
	else:
		pass
	
func changeMusic():
	match currentAudio:
		"vyper":
			switchStreams(currentStream, currentTween, vyperStream, vyperTween)
			currentTween = vyperTween
			currentStream = vyperStream
		"candy":
			switchStreams(currentStream, currentTween, candyStream, candyTween)
			currentTween = candyTween
			currentStream = candyStream
		"goodbye":
			switchStreams(currentStream, currentTween, goodbyeStream, goodbyeTween)
			currentTween = goodbyeTween
			currentStream = goodbyeStream
		"headache":
			switchStreams(currentStream, currentTween, headacheStream, headacheTween)
			currentTween = headacheTween
			currentStream = headacheStream
		"enough":
			switchStreams(currentStream, currentTween, enoughStream, enoughTween)
			currentTween = enoughStream
			currentStream = enoughTween

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func switchStreams(oldStream, oldTween, newStream, newTween):
	stopTweens()
	if oldStream:
		oldTween.interpolate_property(oldStream, "volume_db", oldStream.volume_db, -40, 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		oldTween.start()
	if(newTween):
		newTween.interpolate_property(newStream, "volume_db", newStream.volume_db, -10, 3, Tween.TRANS_QUART, Tween.EASE_OUT)
		newTween.start()
	newStream._set_playing(true)

func stopTweens():
	vyperTween.stop_all()
	candyTween.stop_all()
	goodbyeTween.stop_all()
	headacheTween.stop_all()
	enoughTween.stop_all()

func _on_VyperTween_tween_completed(object, key):
	if vyperStream.volume_db == -40:
		vyperStream._set_playing(false)


func _on_CandyTween_tween_completed(object, key):
	if candyStream.volume_db == -40:
		candyStream._set_playing(false)


func _on_GoodbyeTween_tween_completed(object, key):
	if goodbyeStream.volume_db == -40:
		goodbyeStream._set_playing(false)


func _on_HeadacheTween_tween_completed(object, key):
	if headacheStream.volume_db == -40:
		headacheStream._set_playing(false)


func _on_EnoughTween_tween_completed(object, key):
	if enoughStream.volume_db == -40:
		enoughStream._set_playing(false)
