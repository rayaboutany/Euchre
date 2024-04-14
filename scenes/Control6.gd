extends Control
signal hidewords
signal hideyes
signal hideno


# Called when the node enters the scene tree for the first time.
func _ready():
	global.hideno.connect(wehiding)
	global.hideyes.connect(wehiding)
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func wehiding():
	self.visible = false



func _on_buttoncard_6_pressed():
	self.visible =false
	pass # Replace with function body.


func _on_buttoncard_1_pressed():
	pass # Replace with function body.
