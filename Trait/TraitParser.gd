extends Node

var traits: Dictionary
var lists: Dictionary

const PATH = "res://Trait/traits.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_file(PATH)
	
	print("Traits: ", traits)
	
func random_trait_from_list(list_name: String):
	var list = lists[list_name]
	var trait_id = list[randi() % list.size()]
	
	return traits[trait_id]
	
func get_trait(id: String) -> Trait:
	return traits[id]
	
func parse_file(path: String):
	var dictionary = get_dictionary_from_file(path)
	
	traits = parse_traits(dictionary)
	lists = parse_lists(dictionary)
	
func parse_traits(dictionary: Dictionary) -> Dictionary:
	var _traits = {}
	
	for _trait in dictionary["traits"]:
		var t = Trait.new(
			_trait["trait_id"],
			_trait["trait_name"],
			_trait["description"],
			_trait["func_name"],
			parse_comparator(_trait["comparator"]),
			_trait["stat"],
			_trait["hidden"])
		_traits[_trait["trait_id"]] = t
	
	return _traits

func parse_lists(dictionary: Dictionary) -> Dictionary:
	return dictionary["lists"]

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
		"true":
			return Trait.Comparator.TRUE
		"false":
			return Trait.Comparator.FALSE
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
