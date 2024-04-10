extends VBoxContainer
#variables and signals
var trickCount = 1
var teamTricks = 0
var oppTricks = 0
var teamScore = 0
var oppScore = 0
signal cardplayed
#remember: need to reset variables when tricks(turn) & rounds(trickCount) reset
#major point: With how vars are set up we may want to move the calc functions to table.gd and keep this for initial setup

# Called when the node enters the scene tree for the first time.
func _ready():
	# $ referencing child label objects of trickScoreContainer. Neat!
	$teamContainer/teamTricks.text = str(teamTricks) + " Tricks"
	$oppContainer/oppTricks.text = str(oppTricks) + " Tricks"
	$teamContainer/teamScore.text = str(teamScore) + " Points"
	$oppContainer/oppScore.text = str(oppScore) + " Points"

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
	$teamTricks.text = str(teamTricks) + " Tricks"
	$oppTricks.text = str(oppTricks) + " Tricks"
	
func calculateRound():
	#determine round winner
	#add points given num of tricks
	#make decision structure:
	#if teamScore >= 10:
	#win function switching scene to win screen
	#else if oppScore >= 10:
	#lose function switching scene to lose screen?
	#else:
	#call newTurn to reset trick vars and increment turn (can we do this yet?)
	pass #remove when theres code
	
func win():
	#variable resets for replay?
	#switch scene to win screen scene
	#for win scene, add button calling BackButton; alter back button code to reset trickScore vars (or another way thats easy)
	pass #remove when theres code
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
