extends Node
class_name Secret

var subjects = []
var stat: String
var description: String
var known_by = []

func _init(_subjects: Array, _stat: String, _description: String, _known_by: Array):
	if _subjects.empty():
		print("Error - secret must be about someone")
	subjects = _subjects
	stat = _stat
	description = _description
	known_by = _known_by

func details_about() -> Array:
	var details = []
	for c in subjects:
		details.append({"about": c, "description": (description % c.character_name)})
	
	return details

func about(character, _stat: String) -> bool:
	return subjects.has(character) && stat == _stat

func is_known_by(character) -> bool:
	return subjects.has(character) || known_by.has(character)

func add_known_by(character):
	known_by.append(character)
