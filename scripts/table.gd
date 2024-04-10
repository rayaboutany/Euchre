extends Node2D
#variables and signals
var load_card = preload("res://scenes/card.tscn")
var deck = []
var playerHand = []
var suits = ["HEARTS","DIAMONDS","CLUBS","SPADES"]
signal work
var bot1Hand = []
var bot2Hand = []
var bot3Hand = []
var currentTrick = []
var tricks = []
var teamTricks = 0
var oppTricks = 0
var teamScore = 0
var oppScore = 0
var dealer = 0
signal nextPlayer
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

#instantiates all of the card scenes and adds them to the deck array
func _initialize_deck():
	chooseDealer()
	var deckBuildIndex = 0
	deck.resize(24)
	for i in 4:
		for j in 6:
			var card = load_card.instantiate()
			card.suit = suits[i]
			card.value = j+9
			card.id = deckBuildIndex
			card.setFaceTexture()
			deck[deckBuildIndex] = card
			print(deck[deckBuildIndex].suit + str(deck[deckBuildIndex].value))
			deckBuildIndex += 1

#resizes hand for the table scene
func _initialize_hand(hand):
	hand.resize(5)

#shuffles the deck array
func shuffle():
	print("shuffling...")
	var shuffleDeck = []
	var rng = RandomNumberGenerator.new()
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
		print(deck[i].suit + str(deck[i].value))

#retrieves the trump card		
func get_trump_card():
	for nextcard in deck:
		if nextcard!= null:
			print(nextcard)
			return nextcard
	return null

#tracking the dealer for the current hand
func chooseDealer():
	dealer += 1
	print("dealer: "+ str(dealer))
	if (dealer > 4):
		dealer = 1
	match (dealer):
		1:
			$dealerLabel.rotation = 0
			$dealerLabel.position = Vector2(690,690)
		2:
			$dealerLabel.rotation = 3*PI/2
			$dealerLabel.position = Vector2(250,360)
		3:
			$dealerLabel.rotation = 0
			$dealerLabel.position = Vector2(610,30)
		2:
			$dealerLabel.rotation = PI/2
			$dealerLabel.position = Vector2(1020,310)

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
		print(hand[cardsDrawn].player)
		cardsDrawn += 1

#prints out hand information and if it's the player's hand, displays the cards in the scene
func showHand(hand):
	for i in hand.size():
		print(hand[i].suit + str(hand[i].value))
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
	#global.cardPlayed.connect(_onCardPlayed)
	global.tablePlayCard.connect(_onCardPlayed)
	_initialize_deck()
	tricks.resize(5)
	currentTrick.resize(4)
	shuffle()
	createHands()

#assessing card values and returning the greater card
func compareCards(card1, card2):
	var trump = $TextureRect2.suit
	if (card1.suit == trump && card2.suit != trump):
		return card1
	else: if (card2.suit == trump && card1.suit != trump):
		return card2
	else:
		if card1.value > card2.value:
			return card1
		else: if card2.value > card1.value:
			return card2

#sorting the given card array
func sortCardArray(cardArray):
	var min_index
	var buffer
	for i in cardArray.size():
		min_index = i
		for j in range (i+11, cardArray.size()):
			if compareCards(cardArray[j], cardArray[min_index]).id != cardArray[j].id:
				min_index = j
		buffer = cardArray[i]
		cardArray[i] = cardArray[min_index]
		cardArray[min_index] = buffer
				
#runs every frame, has to be here i think
func _process(delta):
	if currentTrick[3] != null:
		sortCardArray(currentTrick)
		match (currentTrick[0].player):
			"player", "bot2":
				teamTricks += 1
			"bot1", "bot3":
				oppTricks += 1
		for i in 4:
			currentTrick[i].visible = false
			currentTrick[i] = null
		$trickScoreContainer/teamContainer/teamTricks.text = (str(teamTricks) + " Tricks")
		$trickScoreContainer/oppContainer/oppTricks.text = (str(oppTricks) + " Tricks")


#maybe can delete this signal with how things currently work
func _onCardSelected(card):
	print("Card selected:", card.suit, card.value)

#output response for cards played providing debug info
func _onCardPlayed(card):
	print("Card played:", card.suit, card.value)
	print(str($Control5/Label3.turn))
	#if $Control5/Label3.turn == 1:
		#$Control5/Label3.cardEmitted(card)
	print("Card played:", card.id)
	for i in 5:
		if playerHand[i] != null:
			if playerHand[i].id == card.id:
				playerHand[i].position -= Vector2(0,100)
				for j in 4:
					#print(str(j))
					if currentTrick[j] == null:
						currentTrick[j] = playerHand[i]
						break
				#playerHand[i] = null
	print("Current Trick: "+str(currentTrick))
	await get_tree().create_timer(1.0).timeout
	playBotCard("bot1")
	playBotCard("bot2")
	playBotCard("bot3")

#playing cards for bots
func playBotCard(player):
	var hand
	var cardShift
	match (player):
		"bot1":
			hand = bot1Hand
			cardShift = Vector2(20,0)
		"bot2":
			hand = bot2Hand
			cardShift = Vector2(0,20)
		"bot3":
			hand = bot3Hand
			cardShift = Vector2(-20,0)
	for i in 5:
		if hand[i] != null:
			hand[i].position += cardShift
			hand[i].setFaceTexture()
			hand[i].z_index = 1
			for j in 4:
				print(str(j))
				if currentTrick[j] == null:
					currentTrick[j] = hand[i]
					break
			hand[i] = null
			break
	print(currentTrick)
	nextPlayer.emit()
#end of script


func _on_move_timer_timeout():
	
	pass # Replace with function body.
