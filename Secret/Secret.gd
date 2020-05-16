extends Node
class_name Secret

var subjects = []
var stat: String
var desc: String
var known_by = []

func _init(_subjects: Array, _stat: String, _description: String, _known_by: Array):
	if _subjects.empty():
		print("Error - secret must be about someone")
	subjects = _subjects
	stat = _stat
	desc = _description
	known_by = _known_by

func description() -> Array:
	var description = []
	for c in subjects:
		description.append([c, desc % c.character_name])
	return description

func about(character: Character, _stat: String) -> bool:
	return subjects.has(character) && stat == _stat

func is_known_by(character: Character) -> bool:
	return subjects.has(character) || known_by.has(character)

func add_known_by(character: Character):
	known_by.append(character)
