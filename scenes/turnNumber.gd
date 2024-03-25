extends Label
var turn = 1
signal newTrick

# Called when the node enters the scene tree for the first time.
func _ready():
	global.newTurn.connect(newTurn)
	set_text(str(turn))

# newTurn function, call in another script with get_node()/signals
func newTurn():
	turn += 1
	#decision structure calling newTrick if turns exceed card limit (4)
	if (turn == 5): 
		#call newTrick and reset turn to 1
		global.emit_signal("newTrick")
		turn = 1
	#update display
	set_text(str(turn))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
