extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#switches scene to tutorial screen when how to play button is pressed
func _on_pressed():
	global.goto_scene("res://scenes/tutorial.tscn")
