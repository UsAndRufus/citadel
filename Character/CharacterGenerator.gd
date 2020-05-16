extends Node

export (PackedScene) var CharacterScene

var names = ["Throfuri", "Vangream", "Erinmon", "Losirlun", "Kaladin", "Dalinar", "Erik", "Habitrude", "Freja", "Votreni", "Tuddana", "Granger", "Tudor", "Killian", "Safyra", "Galila", "Yllnesia", "Elma", "Osmund", "Shallan", "Conall", "Vesryn"]

func _ready():
	print("%s names" % names.size())
	print("$TraitParser.traits count: %s" % $TraitParser.traits.size())

func generate(amount: int) -> Array:
	var characters = []
	characters = generate_characters(amount)
	generate_secrets(characters)
	return characters

func generate_characters(amount: int) -> Array:
	var characters = []
	names.shuffle()
	
	for i in range(amount):
		var rank = randi() % 5
		var alignment = randi() % 2
		
		var traits = [$TraitParser.random_trait(),$TraitParser.random_trait()]
		if alignment == 1:
			traits.append($TraitParser.get_trait("loves_other_evil"))
		traits.append($TraitParser.get_trait("hates_other_alignment"))
		
		var character = CharacterScene.instance()
		character.init(names[i], rank, alignment, traits)
		characters.append(character)
		
	return characters

func generate_secrets(characters: Array):
	var secret = Secret.new([characters[0]], "Alice likes cheese", [characters[1]])
	
	print("secret: ", secret.description)
	for c in characters:
		print("%s knows secret: %s" % [c.character_name, str(secret.is_known_by(c))])
