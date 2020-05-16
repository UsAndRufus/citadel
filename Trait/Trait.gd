extends Node

# Immutable representation of a Trait - there is only one of each
class_name Trait

const hidden_stats = ["alignment", "spy"]

export(String) var trait_id
export(String) var trait_name
export(String) var description

var func_name: String
var comparator: int
var stat: String
var hidden: bool

enum Comparator {GT, LT, GTE, LTE, EQ, NE, TRUE, FALSE}

func _init(_trait_id: String, _trait_name: String, _description: String,
		  _func_name: String, _comparator: int, _stat: String, _hidden: bool):
	trait_id = _trait_id
	trait_name = _trait_name
	description = _description
	
	func_name = _func_name
	comparator = _comparator
	stat = _stat
	hidden = _hidden

func trust_of(character: Character, other: Character) -> int:
	if knows_stat(character, other):
		return call(func_name, other.stats[stat], character.stats[stat]) as int
	else:
		return 0

func knows_stat(character: Character, other: Character) -> bool:
	# IE if stat is public/visible
	if !hidden_stat():
		return true
	else:
		for secret in character.known_secrets:
			if secret.about(other, stat):
				return true
	
	return false

func hidden_stat():
	return hidden_stats.has(stat)

func super_loves(stat1, stat2) -> int:
	if compare(stat1, stat2):
		return 50
	else:
		return 0

func loves(stat1, stat2) -> int:
	if compare(stat1, stat2):
		return 10
	else:
		return 0

func hates(stat1, stat2) -> int:
	if compare(stat1, stat2):
		return -10
	else:
		return 0

func compare(stat1, stat2) -> bool:
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
		Comparator.TRUE:
			return stat1
		Comparator.FALSE:
			return !stat1
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
		Comparator.TRUE:
			cmp = "is true"
		Comparator.FALSE:
			cmp = "is false"
		_:
			cmp = "MISSING_COMPARATOR"
	
	return "%s{%s(%s,%s}" % [trait_id, func_name, cmp, stat]
