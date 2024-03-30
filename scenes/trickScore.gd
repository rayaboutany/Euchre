extends VBoxContainer
#variables and signals
var trickCount = 1
var teamTricks = 0
var oppTricks = 0
var teamScore = 0
var oppScore = 0
signal cardplayed
#question: In the future, should we make the win func global?
#remember: need to reset variables when tricks(turn) & rounds(trickCount) reset

# Called when the node enters the scene tree for the first time.
func _ready():
	# $ referencing child label objects of trickScoreContainer. Neat!
	$teamTricks.text = str(teamTricks)
	$oppTricks.text = str(oppTricks)
	$teamScore.text = str(teamScore)
	$oppScore.text = str(oppScore)

# newTrick function, call in another script with signals
func newTrick():
	trickCount += 1
	#make decision structure:
	#if trickCount == 6 (5 is last card for each player):
	#call function for round calc
	#else
	#call function for trick calc
	
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
	#call newTurn to reset trick vars and increment turn (can we do this yet?)
	pass #remove when theres code
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
