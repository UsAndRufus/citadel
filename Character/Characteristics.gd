extends Node

enum Relational {LOVES_HIGHER_RANK, LOVES_LOWER_RANK, LOVES_SAME_RANK, HATES_SAME_RANK, HATES_LOWER_RANK, HATES_HIGHER_RANK}

var higher_rank = [Relational.LOVES_HIGHER_RANK, Relational.HATES_HIGHER_RANK]
var same_rank = [Relational.LOVES_SAME_RANK, Relational.HATES_SAME_RANK]
var lower_rank = [Relational.LOVES_LOWER_RANK, Relational.HATES_LOWER_RANK]

enum {GT, LT, GTE, LTE, EQ}

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func generate_characteristics():
	return [ higher_rank[randi() % higher_rank.size()], 
			same_rank[randi() % same_rank.size()], 
			lower_rank[randi() % lower_rank.size()] ]

func opinion_from(characteristic: int, character: Character, other: Character) -> int:
	match characteristic:
		Relational.LOVES_HIGHER_RANK:
			return loves(character.rank, LT, other.rank)
		Relational.LOVES_LOWER_RANK:
			return loves(character.rank, GT, other.rank)
		Relational.LOVES_SAME_RANK:
			return loves(character.rank, EQ, other.rank)
		Relational.HATES_HIGHER_RANK:
			return hates(character.rank, LT, other.rank)
		Relational.HATES_LOWER_RANK:
			return hates(character.rank, GT, other.rank)
		Relational.HATES_SAME_RANK:
			return hates(character.rank, EQ, other.rank)
		_:
			return 0
		

func loves(stat1: int, comparator: int, stat2: int) -> int:
	if compare(stat1, comparator, stat2):
		return 10
	else:
		return 0

func hates(stat1: int, comparator: int, stat2: int) -> int:
	if compare(stat1, comparator, stat2):
		return -10
	else:
		return 0

func compare(stat1: int, comparator: int, stat2: int) -> bool:
	match comparator:
		GT:
			return stat1 > stat2
		LT:
			return stat1 < stat2
		GTE:
			return stat1 >= stat2
		LTE:
			return stat1 <= stat2
		EQ:
			return stat1 == stat2
		_:
			return false
