extends Node2D

export(Array) var characters = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	print("$TraitParser.traits count: %s" % $TraitParser.traits.size())
	generate_characters(3)
	
	for child in characters:
		child.print()
		for other in characters:
			var text = "%s's opinion of %s: %s" % [child.character_name, other.character_name, child.opinion_of(other)]
			print(text)
			$Info.add_text(text)
			$Info.newline()
		$Info.newline()

func generate_characters(amount: int):
	for i in range(amount):
		var rank = randi() % Character.Rank.size()
		var character = Character.new(str(i), rank, [$TraitParser.random_trait(),$TraitParser.random_trait()])
		characters.append(character)
#		add_child(character)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
