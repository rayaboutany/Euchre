extends Node2D
#variables and signals
#preload card scene
var load_card = preload("res://scenes/card2.tscn")

#other
signal work
var rng = RandomNumberGenerator.new()

#arrays
var deck = []
var playerHand = []
var suits = ["HEARTS","DIAMONDS","CLUBS","SPADES"]
var bot1Hand = []
var bot2Hand = []
var bot3Hand = []
var currentTrick = []
var tricks = []

#ints
var trickCount = 1
var teamTricks = 0
var oppTricks = 0
var teamScore = 0
var oppScore = 0
var dealer = int(rng.randf_range(1,4))
var startingPlayer

#boolean
var trumpPicked = false

#question: Attackers (Trump Selector) & Defenders Logic for Scoring?
#question 2: Scoring for going alone? (Maybe Future)
#Scoring notes:
#Attackers: 3-4 tricks = 1pt, 5 tricks = 2pts
#Defenders: 3-4 tricks = 2pts, 5 tricks = 4pts
#Attacking Alone: 3-4 tricks = 2pts, 5 tricks = 4pts
#Defending Alone: 3-4 tricks = 4pts, 5 tricks = 5pts
#Needs: 
#calculateTrick function to update trick scores
#roundScore function updating score vars and display to UI
#future: win function call in roundScore when a score reaches/exceeds 10

func _resetArrays():
	deck = []
	playerHand = []
	bot1Hand = []
	bot2Hand = []
	bot3Hand = []
	currentTrick = []
	tricks = []
#instantiates all of the card scenes and adds them to the deck array
func _initialize_deck():
	chooseDealer()
	var deckBuildIndex = 0
	deck.resize(24)
	for i in 24:
		deck[i] = null
	for i in 4:
		for j in 6:
			var card = load_card.instantiate()
			card.add_to_group("cards")
			card.suit = suits[i]
			card.value = j+9
			card.id = deckBuildIndex
			card.setFaceTexture()
			deck[deckBuildIndex] = card
			#print(deck[deckBuildIndex].suit + str(deck[deckBuildIndex].value))
			deckBuildIndex += 1

#resizes hand for the table scene
func _initialize_hand(hand):
	hand.resize(5)
	for i in hand.size():
		hand[i] = null

#shuffles the deck array
func shuffle():
	print("shuffling...")
	var shuffleDeck = []
	var nextCardIndex
	shuffleDeck.resize(24)
	for i in 24:
		nextCardIndex = int(rng.randf_range(1,24))
		while(deck[nextCardIndex] == null):
			nextCardIndex += 1
			if (nextCardIndex >= 24):
				nextCardIndex = 0
		shuffleDeck[i] = deck[nextCardIndex]
		deck[nextCardIndex] = null
	for i in 24:
		deck[i] = shuffleDeck[i]
		#print(deck[i].suit + str(deck[i].value))

#retrieves the trump card		
func get_trump_card():
	for nextcard in deck:
		if nextcard!= null:
			#print(nextcard)
			return nextcard
	return null

#tracking the dealer for the current hand
func chooseDealer():
	dealer += 1
	if (dealer > 4):
		dealer = 1
	print("dealer: "+ str(dealer))
	match (dealer):
		1:
			$dealerLabel.rotation = 0
			$dealerLabel.position = Vector2(690,690)
		2:
			$dealerLabel.rotation = PI/2
			$dealerLabel.position = Vector2(247,375)
		3:
			$dealerLabel.rotation = 0
			$dealerLabel.position = Vector2(670,14)
		4:
			$dealerLabel.rotation = 3*PI/2
			$dealerLabel.position = Vector2(1009,294)

#pulls a card off of the top of the deck, adds the card to the specified hand array, and sets the same card in the deck to null
func deal(hand):
	var cardsDrawn = 0
	var deckIndex = 0
	var playerName
	while(cardsDrawn < 5):
		while(deck[deckIndex] == null):
			deckIndex += 1
		hand[cardsDrawn] = deck[deckIndex]
		deck[deckIndex] = null
		match (hand):
			playerHand:
				playerName = "player"
			bot1Hand:
				playerName = "bot1"
			bot2Hand:
				playerName = "bot2"
			bot3Hand:
				playerName = "bot3"
		hand[cardsDrawn].player = playerName
		#print(hand[cardsDrawn].player)
		cardsDrawn += 1
	print(str(hand))

#prints out hand information and if it's the player's hand, displays the cards in the scene
func showHand(hand):
	for i in hand.size():
		#print(hand[i].suit + str(hand[i].value))
		match (hand):
			playerHand:
				get_tree().root.add_child(hand[i])
				hand[i].position = Vector2(415+120*i,600)
				hand[i].setFaceTexture()
				get_tree().root.add_child(hand[i])
				hand[i].position = Vector2(415+120*i,600)
			bot1Hand:
				hand[i].setBackTexture()
				get_tree().root.add_child(hand[i])
				hand[i].scale = Vector2(.2,.2)
				hand[i].rotation = PI/2
				hand[i].position = Vector2(380,270+36*i)
			bot2Hand:
				hand[i].setBackTexture()
				get_tree().root.add_child(hand[i])
				hand[i].scale = Vector2(.2,.2)
				hand[i].rotation = PI
				hand[i].position = Vector2(574+36*i,150)
			bot3Hand:
				hand[i].setBackTexture()
				get_tree().root.add_child(hand[i])
				hand[i].scale = Vector2(.2,.2)
				hand[i].rotation = 3*PI/2
				hand[i].position = Vector2(910,270+36*i)

#calling hand and deal functions to setup player hands				
#there's gotta be a better way to do this right
func createHands():
	_initialize_hand(playerHand)
	_initialize_hand(bot1Hand)
	_initialize_hand(bot2Hand)
	_initialize_hand(bot3Hand)
	deal(playerHand)
	deal(bot1Hand)
	deal(bot2Hand)
	deal(bot3Hand)
	showHand(playerHand)
	showHand(bot1Hand)
	showHand(bot2Hand)
	showHand(bot3Hand)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("[NEW HAND]")
	global.tablePlayCard.connect(_onCardPlayed)
	global.goNow.connect(startPlaying)
	_initialize_deck()
	tricks.resize(5)
	#print(tricks)
	for i in tricks.size():
		tricks[i] = null
	currentTrick.resize(4)
	for i in currentTrick.size():
		currentTrick[i] = null
	shuffle()
	createHands()
	startingPlayer = dealer+1
	if startingPlayer > 4: startingPlayer = 1
	print("sP " + str(startingPlayer))
	global.setPlayer.emit(startingPlayer)
	if (trumpPicked):
		await get_tree().create_timer(1.0).timeout
		startPlaying()
		
func startPlaying():
	match (startingPlayer):
			2:
				playBotCard("bot1")
			3:
				playBotCard("bot2")
			4:
				playBotCard("bot3")

#assessing card values and returning the greater card
#10 billion fucking if statements - improve later if there's time
func compareCards(card1, card2):
	print(str(card1) + " " + str(card2))
	var trump = $TextureRect2/Label.trumpsuit
	var leftTrump
	#print("comparing " + str(card1.suit) + str(card1.value) + " and " + str(card2.suit) + str(card2.value))
	#determine suit for left bauer
	match (trump):
		"HEARTS":
			leftTrump = "DIAMONDS"
		"DIAMONDS":
			leftTrump = "HEARTS"
		"CLUBS":
			leftTrump = "SPADES"
		"SPADES":
			leftTrump = "CLUBS"
	#automatically return if right bauer
	if (card1.suit == trump && card1.value == 11):
		#print("chose " + str(card1.suit) + str(card1.value))
		return card1
	if (card2.suit == trump && card2.value == 11):
		#print("chose " + str(card2.suit) + str(card2.value))
		return card2
	#if it's still going then there's no right bauer, auto return for left bauer
	if (card1.suit == leftTrump && card1.value == 11):
		#print("chose " + str(card1.suit) + str(card1.value))
		return card1
	if (card2.suit == leftTrump && card2.value == 11):
		#print("chose " + str(card2.suit) + str(card2.value))
		return card2
	#return if one card is trump and the other isn't
	if (card1.suit == trump && card2.suit != trump):
		#print("chose " + str(card1.suit) + str(card1.value))
		return card1
	else: if (card2.suit == trump && card1.suit != trump):
		#print("chose " + str(card2.suit) + str(card2.value))
		return card2
	#if neither are bauer or neither/both are trump pick the higher value card
	else:
		if card1.value > card2.value:
		#	print("chose " + str(card1.suit) + str(card1.value))
			return card1
		else: if card2.value > card1.value:
		#	print("chose " + str(card2.suit) + str(card2.value))
			return card2
	#if all else fails then their value is equal, return card1
	#print("chose " + str(card1.suit) + str(card1.value))
	return card1

#sorting the given card array
func sortCardArray(cardArray):
	#print("trump: " + $TextureRect2/Label.trumpsuit)
	var min_index
	var buffer
	for i in cardArray.size():
		min_index = i
		for j in range (i+1, cardArray.size()):
			#print(cardArray.size())
			#print(cardArray)
			if compareCards(cardArray[j], cardArray[min_index]).id != cardArray[j].id:
				min_index = j
		buffer = cardArray[i]
		cardArray[i] = cardArray[min_index]
		cardArray[min_index] = buffer
	#for i in cardArray.size():
	#	print(str(cardArray[i].suit) + str(cardArray[i].value))

#runs every frame
func _process(delta):
	pass

#maybe can delete this signal with how things currently work
func _onCardSelected(card):
	pass
	#print("Card selected:", card.suit, card.value)

#output response for cards played providing debug info
#updates trick score vbox container
func _onCardPlayed(card):
	print("Card played:", card.suit, card.value)
	#print(str($Control5/Label3.turn))
	#if $Control5/Label3.turn == 1:
		#$Control5/Label3.cardEmitted(card)
	#print("Card played:", card.id)
	for i in 5:
		if playerHand[i] != null:
			if playerHand[i].id == card.id:
				#playerHand[i].position -= Vector2(0,100)
				var anim = playerHand[i].get_node("AnimationPlayer")
				anim.play("card_playing")
				for j in 4:
					#print(str(j))
					if currentTrick[j] == null:
						currentTrick[j] = playerHand[i]
						break
				playerHand[i] = null
	#print("Current Trick: "+str(currentTrick))
	checkEndOfTrick()
	if (!checkForWin()):
		await get_tree().create_timer(1.0).timeout
	#	print("nP oCP -> bot1")
		#global.nextPlayer.emit()
		global.setPlayer.emit(2)
	#	print("telling bot1 to play")
		playBotCard("bot1")
	
#if all cards are played, begins card evaluation
func checkEndOfTrick():
	if currentTrick[3] != null:
		await get_tree().create_timer(1.0).timeout
		sortCardArray(currentTrick)
		match (currentTrick[3].player):
			"player", "bot2":
				teamTricks += 1
			"bot1", "bot3":
				oppTricks += 1
		trickCount += 1
		print("Trick Count: " + str(trickCount))
		for i in 4:
			currentTrick[i].visible = false
			#print(str(currentTrick[i]) + " freed")
			#currentTrick[i].queue_free()
			currentTrick[i] = null
		$trickScoreContainer/teamContainer/teamTricks.text = (str(teamTricks) + " Tricks")
		$trickScoreContainer/oppContainer/oppTricks.text = (str(oppTricks) + " Tricks")
		#checkForWin()
		

#here is where calc functions will be called
func checkForWin():
	if trickCount == 6:
		#team round score
		match teamTricks:
			3:
				teamScore += 1
			4:
				teamScore += 1
			5:
				teamScore += 2
		#resetting teamTricks for next round
		teamTricks = 0
		#opp round score
		match oppTricks:
			3:
				oppScore += 1
			4:
				oppScore += 1
			5:
				oppScore += 2
		#resetting oppScore for next round
		oppTricks = 0
		#updating trick score table display
		$trickScoreContainer/teamContainer/teamTricks.text = (str(teamTricks) + " Tricks")
		$trickScoreContainer/oppContainer/oppTricks.text = (str(oppTricks) + " Tricks")
		$trickScoreContainer/teamContainer/teamScore.text = (str(teamScore) + " Points")
		$trickScoreContainer/oppContainer/oppScore.text = (str(oppScore) + " Points")
		#testing
		#-------
		print("Team Score: " + str(teamScore))
		print("Opp Score: " + str(oppScore))
		#teamScore = 10
		#oppScore = 10
		#-------
		#determining if a team has won
		if teamScore >= 10:
			#switching scene to win screen
			global.goto_scene("res://scenes/win.tscn")
		if oppScore >= 10:
			#switching scene to lose screen
			global.goto_scene("res://scenes/lose.tscn")
		#resetting trickCount
		trickCount = 1
	#	print("cFW win")
		get_tree().call_group("cards", "queue_free")
		_ready()
		return true
	else:
	#	print ("cFW no win") 
		return false

#playing cards for bots
func playBotCard(player):
	#print (player + " playing")
	var hand
	var nextPlayer
	var nextTurn
	match (player):
		"bot1":
			hand = bot1Hand
			nextPlayer = "bot2"
			nextTurn = 3
		"bot2":
			hand = bot2Hand
			nextPlayer = "bot3"
			nextTurn = 4
		"bot3":
			hand = bot3Hand
			nextPlayer = "player"
			nextTurn = 1
	for i in 5:
		if hand[i] != null:
			var anim = hand[i].get_node("AnimationPlayer")
			anim.play("card_playing")
			hand[i].setFaceTexture()
			hand[i].z_index = 1
			for j in 4:
				#print(str(j))
				if currentTrick[j] == null:
					currentTrick[j] = hand[i]
					break
			hand[i] = null
			break
	#print(currentTrick)
	await checkEndOfTrick()
	#maybe do this with a signal instead
	#print(player + " checking for win")
	if (!checkForWin()):
	#	print(player + " no win")
		await get_tree().create_timer(1.0).timeout
	#	print("nP pBC " + player + " -> " + nextPlayer)
		#global.nextPlayer.emit() #<- FUCKS NEW HAND TURN NUMBER !! (maybe?! idfk man)
		global.setPlayer.emit(nextTurn)
		if (nextPlayer != "player"):
	#		print("telling " + nextPlayer + " to play")
			playBotCard(nextPlayer)
	#else: print(player + " win")
	

