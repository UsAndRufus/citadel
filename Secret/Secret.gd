extends Node
class_name Secret

var subjects = []
var description: String
var trait: Trait
var known_by = []

func _init(_subjects: Array, _description: String, _trait: Trait, _known_by: Array):
	if _subjects.empty():
		print("Error - secret must be about someone")
	subjects = _subjects
	description = _description
	trait = _trait
	known_by = _known_by

func is_known_by(character: Character) -> bool:
	return subjects.has(character) || known_by.has(character)

func add_known_by(character: Character):
	known_by.append(character)
