extends Node

export(Dictionary) var traits

const PATH = "res://Trait/traits.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	traits = parse_traits_from_json(PATH)
	
	print("Traits: ", traits)
	
func random_trait():
	return traits.values()[randi() % traits.size()]
	
func get_trait(id: String) -> Trait:
	return traits[id]
	
func parse_traits_from_json(path: String) -> Array:
	var dictionary = get_dictionary_from_file(path)
	
	var _traits = {}
	
	for _trait in dictionary["traits"]:
		var t = Trait.new(
			_trait["trait_id"],
			_trait["trait_name"],
			_trait["description"],
			_trait["func_name"],
			parse_comparator(_trait["comparator"]),
			_trait["stat"])
		_traits[_trait["trait_id"]] = t
	
	return _traits

func parse_comparator(comparator: String) -> int:
	match comparator:
		"gt":
			return Trait.Comparator.GT
		"lt":
			return Trait.Comparator.LT
		"gte":
			return Trait.Comparator.GTE
		"lte":
			return Trait.Comparator.LTE
		"eq":
			return Trait.Comparator.EQ
		"ne":
			return Trait.Comparator.NE
		_:
			return -1

func get_dictionary_from_file(path: String):
	var parsed = JSON.parse(get_file_content(path))
	
	if parsed.error == OK:
		var data = parsed.result
		return data as Dictionary
	else:
		print("Error: ", parsed.error)
		print("Error Line: ", parsed.error_line)
		print("Error String: ", parsed.error_string)
		return null

func get_file_content(path: String) -> String:
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
