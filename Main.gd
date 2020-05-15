extends Node

export (PackedScene) var CharacterScene

export(Array) var characters = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	print("$TraitParser.traits count: %s" % $TraitParser.traits.size())
	generate_characters(4)
	
	$Window/UI.set_player(characters[0])
	
	$Window/UI.observe_characters(characters)
	
	for child in characters:
		child.print()
		for other in characters:
			var text = "%s's opinion of %s: %s" % [child.character_name, other.character_name, child.trust_of(other)]
			print(text)

func generate_characters(amount: int):
	var names = ["Alice", "Bob", "Fred", "Jemimah"]
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
		add_child(character)
		

func _unhandled_input(event):
	if event.is_action("select"):
		for c in characters:
			c.deselect()
