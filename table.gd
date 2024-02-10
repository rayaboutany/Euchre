extends Node2D
var load_card = preload("res://scenes/card.tscn")
var deck = []
var playerHand = []
var suits = ["HEARTS","DIAMONDS","CLUBS","SPADES"]

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

func deal(hand):
	var cardsDrawn = 0
	var index = 0
	while(cardsDrawn < 5):
		while(deck[index] == null):
			index += 1
		hand[index] = deck[index]
		deck[index] = null
		cardsDrawn += 1
		
func showHand(hand):
	for i in hand.size():
		print(hand[i].suit + str(hand[i].value))
		get_tree().root.add_child(hand[i])
		hand[i].position = Vector2(415+120*i,600)

# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize_deck()
	_initialize_hand(playerHand)
	print("suffling...")
	shuffle()
	deal(playerHand)
	print("player's hand")
	showHand(playerHand)
	
	var Global = get_node("/root/global")
	Global.cardSelected.connect(_onCardSelected)
	Global.cardPlayed.connect(_onCardPlayed)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _onCardSelected(card):
	# Handle the selected card
	print("Card selected:", card)

func _onCardPlayed(card):
	# Handle the played card
	print("Card played:", card)
