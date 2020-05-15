extends Node2D
class_name Character

signal selected(character)
signal deselected(character)

export(String) var character_name

enum Rank {CIVILIAN = 0, PRIVATE = 1, CORPORAL = 2, CAPTAIN = 3, MAJOR = 4}
enum Alignment {EVIL = 0, GOOD = 1}
var stats = {}

var traits = []

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = clamp(randi() % 1920, 580+100, 1240)
	position.y = clamp(randi() % 1080, 100, 880)

func init(_name: String, _rank: int, _alignment: int, _traits: Array):
	character_name = _name
	stats["rank"] = _rank
	stats["alignment"] = _alignment
	traits = _traits

func rank_name() -> String:
	match stats["rank"]:
		Rank.MAJOR:
			return "Major"
		Rank.CAPTAIN:
			return "Captain"
		Rank.CORPORAL:
			return "Corporal"
		Rank.PRIVATE:
			return "Private"
		_, Rank.CIVILIAN:
			return "Civilian"

func alignment_name() -> String:
	match stats["alignment"]:
		1:
			return "Evil"
		_: 
			return "Good"

func print():
	print("Name: %s" % character_name)
	print("Rank: %s" % stats["rank"])
	for t in traits:
		print(t.trait_id)

func trust_of(other: Character) -> int:
	var trust = 0
	for t in traits:
		trust += t.trust_of(self, other)
	
	return trust

func trait_trust_scores(other: Character) -> Dictionary:
	var trait_trust_scores = {}
	for t in traits:
		trait_trust_scores[t.trait_name] = t.trust_of(self, other)
	
	return trait_trust_scores

func deselect():
	emit_signal("deselected", self)
	$Outline.visible = false

func _on_Character_input_event(_viewport, event, _shape_idx):
	if event.is_action("select"):
		emit_signal("selected", self)
		$Outline.visible = true
