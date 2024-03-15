extends Button
var turn = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	hide()
	var labelchange2
	labelchange2 = get_node("Label2/Label3")
	get_parent().newturn()
	turn.text= "2"
	

