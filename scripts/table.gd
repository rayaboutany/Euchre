extends Node2D
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

#instantiates all of the card scenes and adds them to the deck array
func _initialize_deck():
	var deckBuildIndex = 0
	deck.resize(24)
	for i in 4:
		for j in 6:
			var card = load_card.instantiate()
			card.suit = suits[i]
			card.value = j+9
			card.id = deckBuildIndex
			card.setTexture()
			deck[deckBuildIndex] = card
			print(deck[deckBuildIndex].suit + str(deck[deckBuildIndex].value))
			deckBuildIndex += 1

func _initialize_hand(hand):
	hand.resize(5)

func shuffle():
	print("suffling...")
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
		
func get_trump_card():
	for nextcard in deck:
		if nextcard!= null:
			print(nextcard)
			return nextcard
	return null

	
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

func calculateTrick():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	global.cardPlayed.connect(_onCardPlayed)
	_initialize_deck()
	tricks.resize(5)
	currentTrick.resize(4)
	shuffle()
	createHands()
	
#runs every frame, has to be here i think
func _process(delta):
	pass

#maybe can delete this signal with how things currently work
func _onCardSelected(card):
	print("Card selected:", card.suit, card.value)

func _onCardPlayed(card):
	print("Card played:", card.suit, card.value)
	for i in playerHand:
		if playerHand[i] == card:
			currentTrick.append(card)
			playerHand[i] = null
