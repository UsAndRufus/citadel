extends Node2D
class_name Character

signal secrets_known_changed
signal selected(character)
signal deselected(character)

var character_id: int
export(String) var character_name

enum Actions {SPY}
enum Rank {CIVILIAN = 0, PRIVATE = 1, CORPORAL = 2, CAPTAIN = 3, MAJOR = 4}
enum Alignment {EVIL = 0, GOOD = 1}
var stats = {}

var traits = []
var secrets_about = []
var known_secrets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = clamp(randi() % 1920, 580+100, 1240)
	position.y = clamp(randi() % 1080, 100, 880)

func init(_character_id: int, _name: String, _rank: int, _alignment: int, _traits: Array):
	character_id = _character_id
	character_name = _name
	stats["rank"] = _rank
	stats["alignment"] = _alignment
	traits = _traits

func start_action(action: int, subject):
	match action:
		Actions.SPY:
			$Actions/SpyTimer.start_action(self, subject)
		_:
			print("Unknown action")

func add_known_secret(secret: Secret):
	known_secrets.append(secret)
	secret.add_known_by(self)
	emit_signal("secrets_known_changed")

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
	print("Rank: %s" % rank_name())
	print("Alignment: ", alignment_name())
	for t in traits:
		print(t.trait_id)

func trust_of(other: Character) -> int:
	var trust = 0
	for t in traits:
		trust += t.trust_of(self, other)
	
	return trust

func trait_trust_scores(other: Character, player_character: Character) -> Dictionary:
	var trait_trust_scores = {}
	for t in traits:
		var name
		if t.hidden_stat():
			if t.knows_stat(player_character, other):
				name = "%s (secret)" % t.stat.capitalize()
			else:
				name = "??? (secret)"
		else:
			name = t.trait_name
		trait_trust_scores[name] = t.trust_of(self, other)
	
	return trait_trust_scores

func deselect():
	emit_signal("deselected", self)
	$Outline.visible = false

func _on_Character_input_event(_viewport, event, _shape_idx):
	if event.is_action("select"):
		emit_signal("selected", self)
		$Outline.visible = true
