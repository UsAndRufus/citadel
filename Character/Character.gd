extends Node2D
class_name Character

signal selected(character)
signal deselected(character)

export(String) var character_name

enum Rank {CIVILIAN = 0, PRIVATE = 1, CORPORAL = 2, CAPTAIN = 3, MAJOR = 4}
var stats = {}

var traits = []

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = clamp(randi() % 1920, 580+100, 1240)
	position.y = clamp(randi() % 1080, 100, 880)

func init(_name: String, _rank: int, _traits: Array):
	character_name = _name
	stats["rank"] = _rank
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

func print():
	print("Name: %s" % character_name)
	print("Rank: %s" % stats["rank"])
	for t in traits:
		print(t.trait_id)

func opinion_of(other: Character) -> int:
	var opinion = 0
	for t in traits:
		opinion += t.opinion_of(self, other)
	
	return opinion

func trait_opinions(other: Character) -> Dictionary:
	var trait_opinions = {}
	for t in traits:
		trait_opinions[t.trait_name] = t.opinion_of(self, other)
	
	return trait_opinions

func deselect():
	emit_signal("deselected", self)
	$Outline.visible = false

func _on_Character_input_event(_viewport, event, _shape_idx):
	if event.is_action("select"):
		emit_signal("selected", self)
		$Outline.visible = true
