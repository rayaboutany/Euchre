extends "res://scenes/turnlabel.gd"
signal cardPlayed

#
# Called when the node enters the scene tree for the first time.
func _ready():
	global.cardPlayed.connect(cardEmitted)
	global.nextPlayer.connect(newTurn)
	global.setPlayer.connect(setTurn)
	#nextPlayer.connect(newTurn)
	set_text("It's player "+ str(turn) + "'s turn")

# newTurn function, call in another script with get_node()/signals
func newTurn():
	turn += 1
	if turn > 4:
		turn = 1
	set_text("It's player "+ str(turn) + "'s turn")
	print("new turn " + str(turn))

func setTurn(player):
	turn = player
	set_text("It's player "+ str(turn) + "'s turn")
	print("set turn " + str(turn))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buttoncard_1_pressed():
	visible = true
	#turn = 1
	set_text("It's player "+ str(turn) + "'s turn")
	 # Replace with function body.

#func _on_buttoncard_2_pressed():
#	visible = true
#	var turn = 2
#	set_text("It's player "+ str(turn) + "'s turn")  # Replace with function body.

func cardEmitted(card):
	print("turn: "+str(turn) )
	if turn == 1:
		global.tablePlayCard.emit(card)
		turn = 2
		set_text("It's player "+ str(turn) + "'s turn")
		print("new turn " + str(turn))
	
