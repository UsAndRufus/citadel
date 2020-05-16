extends Node

# Immutable representation of a Trait - there is only one of each
class_name Trait

export(String) var trait_id
export(String) var trait_name
export(String) var description

var func_name: String
var comparator: int
var stat: String

enum Comparator {GT, LT, GTE, LTE, EQ, NE}

func _init(_trait_id: String, _trait_name: String, _description: String,
		  _func_name: String, _comparator: int, _stat: String):
	trait_id = _trait_id
	trait_name = _trait_name
	description = _description
	
	func_name = _func_name
	comparator = _comparator
	stat = _stat
	
func trust_of(character: Character, other: Character) -> int:
	return call(func_name, other.stats[stat], character.stats[stat]) as int
	
func super_loves(stat1: int, stat2: int) -> int:
	if compare(stat1, stat2):
		return 50
	else:
		return 0

func loves(stat1: int, stat2: int) -> int:
	if compare(stat1, stat2):
		return 10
	else:
		return 0

func hates(stat1: int, stat2: int) -> int:
	if compare(stat1, stat2):
		return -10
	else:
		return 0

func compare(stat1: int, stat2: int) -> bool:
	match comparator:
		Comparator.GT:
			return stat1 > stat2
		Comparator.LT:
			return stat1 < stat2
		Comparator.GTE:
			return stat1 >= stat2
		Comparator.LTE:
			return stat1 <= stat2
		Comparator.EQ:
			return stat1 == stat2
		Comparator.NE:
			return stat1 != stat2
		_:
			return false

func _to_string():
	var cmp = ""
	match comparator:
		Comparator.GT:
			cmp = ">"
		Comparator.LT:
			cmp = "<"
		Comparator.GTE:
			cmp = ">="
		Comparator.LTE:
			cmp = "<="
		Comparator.EQ:
			cmp = "=="
		Comparator.NE:
			cmp = "!="
		_:
			cmp = "MISSING_COMPARATOR"
	
	return "%s{%s(%s,%s}" % [trait_id, func_name, cmp, stat]
