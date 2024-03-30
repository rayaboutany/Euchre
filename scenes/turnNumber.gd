extends Label
#variables
var turn = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str(turn))

# newTurn function, call in another script with get_node()/signals
func newTurn():
	turn += 1
	#make decision structure:
	#if turn == 5: call newTrick and reset turn to 1
	#update display
	set_text(str(turn))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
