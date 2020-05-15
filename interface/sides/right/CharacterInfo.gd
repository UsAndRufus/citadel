extends Control

var player_character: Character

export var green: Color = Color(0.254902, 0.807843, 0.054902)
export var red: Color = Color(0.807843, 0.054902, 0.054902)

export (PackedScene) var TraitInfoScene

func _on_character_selected(character: Character):
	update_character_info(character)
	self.visible = true

func _on_character_deselected(_character: Character):
	for child in $Container/TraitsContainer.get_children():
		child.queue_free()
	self.visible = false

func update_character_info(character: Character):
	$Container/TrustScoreContainer/Name.text = character.character_name
	$Container/TrustScoreContainer/Rank.text = "Rank: %s" % character.rank_name()
	update_trust_score(character)
	update_traits_summary(character)
	update_detailed_traits(character)

func update_trust_score(character: Character):
	var trust_score_total = character.trust_of(player_character)
	var trust_score_string = ("+%s" % trust_score_total) if (trust_score_total > 0) else str(trust_score_total)
	$Container/TrustScoreContainer/Trust/Score/Number.text = trust_score_string
	if trust_score_total > 0:
		$Container/TrustScoreContainer/Trust/Score/Number.add_color_override("font_color", green)
	elif trust_score_total < 0:
		$Container/TrustScoreContainer/Trust/Score/Number.add_color_override("font_color", red)
	else:
		$Container/TrustScoreContainer/Trust/Score/Number.set("custom_colors/font_color", null)

func update_traits_summary(character: Character):
	var traits_text = ""
	var trait_trust_scores = character.trait_trust_scores(player_character)
	for name in trait_trust_scores:
		if trait_trust_scores[name] != 0:
			traits_text += " - %s (%s)\n" % [name, str(trait_trust_scores[name])]
	
	$Container/TrustScoreContainer/Trust/Traits.text = traits_text

func update_detailed_traits(character: Character):
	for child in $Container/TraitsContainer.get_children():
		child.queue_free()
	
	for trait in character.traits:
		var info = TraitInfoScene.instance()
		info.init(trait)
		$Container/TraitsContainer.add_child(info)
		$Container/TraitsContainer.add_spacer(false)
