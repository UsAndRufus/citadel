extends Node2D
class_name Character

export(String) var character_name

enum Rank {CIVILIAN = 0, PRIVATE = 1, CORPORAL = 2, CAPTAIN = 3, MAJOR = 4}
var stats = {}

var traits = []

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 50 * (randi() % 10)
	position.y = 50 * (randi() % 10)

func init(_name: String, _rank: int, _traits: Array):
	character_name = _name
	stats["rank"] = _rank
	traits = _traits

func print():
	print("Name: %s" % character_name)
	print("Rank: %s" % stats["rank"])
	for t in traits:
		print(t.trait_id)

func opinion_of(other: Character) -> int:
	var opinion = 0
	for t in traits:
		opinion += t.opinion_of(self, other)
	
	return opinion

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
