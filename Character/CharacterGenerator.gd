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
	
	characters.append(generate_player_character())
	
	for i in range(1, amount):
		var rank = randi() % 5
		var alignment = randi() % 2
		
		var traits = [$TraitParser.random_trait(),$TraitParser.random_trait()]
		if alignment == 1:
			traits.append($TraitParser.get_trait("loves_other_evil"))
		traits.append($TraitParser.get_trait("hates_other_alignment"))
		
		var character = CharacterScene.instance()
		character.init(i, names[i], rank, alignment, traits)
		characters.append(character)
		
	return characters

func generate_player_character() -> Character:
#	var traits = [$TraitParser.random_trait(),$TraitParser.random_trait()]
	var traits = []
	traits.append($TraitParser.get_trait("hates_other_alignment"))
	var rank = 1
	var alignment = 0
	
	var character = CharacterScene.instance()
	character.init(0, names[0], rank, alignment, traits)
	return character

func generate_secrets(characters: Array):
	characters[1].stats["alignment"] = 1
	
	var secret = Secret.new([characters[1]], "alignment", "%s is evil", [characters[0]])

	characters[1].secrets_about.append(secret)
	characters[0].known_secrets.append(secret)

	print("secret: ", secret.description % characters[1].character_name)
	for c in characters:
		print("%s knows secret: %s" % [c.character_name, str(secret.is_known_by(c))])
	print("\n")

	var pc_secret = Secret.new([characters[0]], "alignment", "%s is good", [characters[1]])
	characters[0].secrets_about.append(pc_secret)
	characters[1].known_secrets.append(pc_secret)

	print("secret: ", pc_secret.description % characters[0].character_name)
	for c in characters:
		print("%s knows secret: %s" % [c.character_name, str(pc_secret.is_known_by(c))])
	
	var secret_3 = Secret.new([characters[1]], "alignment", "%s is something", [])
	characters[1].secrets_about.append(secret_3)
