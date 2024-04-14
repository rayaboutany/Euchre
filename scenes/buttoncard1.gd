extends Button
signal hidewords

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	global.emit_signal("hidewords")
	

# this should be how to get the trump card while(deck[index] == null):
	#index += 1


