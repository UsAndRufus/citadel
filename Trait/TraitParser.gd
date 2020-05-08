extends Node

export(Array) var traits


# Called when the node enters the scene tree for the first time.
func _ready():
	parse_traits_from_json("")
	pass # Replace with function body.
	
func parse_traits_from_json(path: String) -> Array:
	return []

func parse_comparator(comparator: String) -> int:
	match comparator:
		"gt":
			return Trait.GT
		"lt":
			return Trait.LT
		"gte":
			return Trait.GTE
		"lte":
			return Trait.LTE
		"eq":
			return Trait.EQ
		_:
			return -1
