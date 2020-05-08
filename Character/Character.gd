extends Node2D
class_name Character

export(String) var character_name

enum Rank {CIVILIAN = 0, PRIVATE = 1, CORPORAL = 2, CAPTAIN = 3, MAJOR = 4}
export(Rank) var rank

export var characteristics = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func print():
	print("Name: %s" % name)
	print("Rank: %s" % rank)
	for c in characteristics:
		pass
	

func _init(_name, _rank, _characteristics):
	character_name = _name
	rank = _rank
	characteristics = _characteristics

func opinion_of(other: Character) -> int:
	var opinion = 0
	for c in characteristics:
		opinion += Characteristics.opinion_from(c, self, other)
	
	return opinion


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
