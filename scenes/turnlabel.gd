extends Label
var turn = 1
#
# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str(turn))

# newTurn function, call in another script with get_node()/signals
func newTurn():
	turn += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buttoncard_1_pressed():
	var turn = 2
	set_text(str(turn))
	 # Replace with function body.

func _on_buttoncard_2_pressed():
	pass # Replace with function body.
