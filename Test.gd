extends Node2D

var characters = []


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_characters(3)
	
	for child in characters:
		child.print()
		for other in characters:
			var text = "%s's opinion of %s: %s" % [child.name, other.name, child.opinion_of(other)]
			$Info.add_text(text)
			$Info.newline()
		$Info.newline()

func generate_characters(amount: int):
	for i in range(0,amount):
		var rank = randi() % Character.Rank.size()
		var character = Character.new(str(i), rank, Trait.generate_traits())
		characters.append(character)
		add_child(character)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
