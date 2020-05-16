extends Node

export(Array) var characters = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	generate_characters()
	
	for child in characters:
		print("\n")
		child.print()
		for other in characters:
			var text = "%s's opinion of %s: %s" % [child.character_name, other.character_name, child.trust_of(other)]
			print(text)

func generate_characters():
	characters = $CharacterGenerator.generate(4)
	for c in characters:
		add_child(c)
	
	$Window/UI.set_player(characters[0])
	$Window/UI.observe_characters(characters)

func _unhandled_input(event):
	if event.is_action("select"):
		for c in characters:
			c.deselect()
