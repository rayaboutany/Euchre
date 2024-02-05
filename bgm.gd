extends AudioStreamPlayer

func initialize_signals():
	global.musicPressed.connect(_check_button_pressed)
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_signals()
	print("hello world")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _check_button_pressed(toggled_on):
	if (toggled_on):
		play()
	else:
		stop()
