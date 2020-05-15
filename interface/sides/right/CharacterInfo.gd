extends Control

var player_character: Character

export var green: Color = Color(0.254902, 0.807843, 0.054902)
export var red: Color = Color(0.807843, 0.054902, 0.054902)

export (PackedScene) var TraitInfoScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_character_clicked(character: Character):
	update_character_info(character)

func update_character_info(character: Character):
	$Container/OpinionContainer/Name.text = character.character_name
	$Container/OpinionContainer/Rank.text = "Rank: %s" % character.stats["rank"]
	update_opinion(character)
	update_traits_summary(character)
	update_detailed_traits(character)

func update_opinion(character: Character):
	var opinion_total = character.opinion_of(player_character)
	var opinion_string = ("+%s" % opinion_total) if (opinion_total > 0) else str(opinion_total)
	$Container/OpinionContainer/Opinion/Score/Number.text = opinion_string
	if opinion_total > 0:
		$Container/OpinionContainer/Opinion/Score/Number.add_color_override("font_color", green)
	elif opinion_total < 0:
		$Container/OpinionContainer/Opinion/Score/Number.add_color_override("font_color", red)
	else:
		$Container/OpinionContainer/Opinion/Score/Number.set("custom_colors/font_color", null)

func update_traits_summary(character: Character):
	var traits_text = ""
	var trait_opinions = character.trait_opinions(player_character)
	for name in trait_opinions:
		if trait_opinions[name] != 0:
			traits_text += " - %s (%s)\n" % [name, str(trait_opinions[name])]
	
	$Container/OpinionContainer/Opinion/Traits.text = traits_text

func update_detailed_traits(character: Character):
	for child in $Container/TraitsContainer.get_children():
		child.queue_free()
	
	for trait in character.traits:
		var info = TraitInfoScene.instance()
		info.init(trait)
		$Container/TraitsContainer.add_child(info)
		$Container/TraitsContainer.add_spacer(false)
