extends VBoxContainer
var trickCount = 1
var teamTricks = 0
var oppTricks = 0
var teamScore = 0
var oppScore = 0
#accepts signals to be made from the following functions (I think?? IDK)
signal cardplayed
signal newTurn
#question: In the future, should we make the win func global?
#remember: need to reset variables when tricks(turn) & rounds(trickCount) reset

# Called when the node enters the scene tree for the first time.
func _ready():
	#initializing signals (maybe put in a seperate func)
	global.newTrick.connect(newTrick)
	global.calculateTrick.connect(calculateTrick)
	global.calculateRound.connect(calculateRound)
	# $ referencing child label objects of trickScoreContainer. Neat!
	$teamTricks.text = str(teamTricks)
	$oppTricks.text = str(oppTricks)
	$teamScore.text = str(teamScore)
	$oppScore.text = str(oppScore)

# newTrick function, call in another script with signals
func newTrick():
	trickCount += 1
	#trick/round handling decision struture
	if (trickCount == 6): #(5 is last card for each player)
		# reset trickCount and call function for round calc
		trickCount = 1;
		calculateRound()
	else:
		#call function for trick calc
		calculateTrick()
	
func calculateTrick():
	#retrieve player card values
	#determine trick winner
	#add trick to score
	#update display
	$teamTricks.text = str(teamTricks)
	$oppTricks.text = str(oppTricks)
	
func calculateRound():
	#determine round winner
	#add points given num of tricks
	#update display
	$teamScore.text = str(teamScore)
	$oppScore.text = str(oppScore)
	#decision structure: call newTurn (or new func?) to reset trick vars and increment turn (can we do this yet?)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
