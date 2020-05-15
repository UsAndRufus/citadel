extends Control

export(bool) var ShowTrustScore
export(bool) var ShowAlignment

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
	update_alignment(character)
	update_trust(character)
	update_detailed_traits(character)

func update_alignment(character: Character):
	var Alignment = $Container/TrustScoreContainer/Alignment
	
	if !ShowAlignment:
		Alignment.visible = false
		return
	
	Alignment.text = "Alignment: %s" % character.alignment_name()
	
	if character.stats["alignment"] == 1:
		Alignment.add_color_override("font_color", red)
	else:
		Alignment.add_color_override("font_color", green)
	
	Alignment.visible = true
	

func update_trust(character: Character):
	var Trust = $Container/TrustScoreContainer/Trust
	
	if !ShowTrustScore:
		Trust.visible = false
		return
		
	update_trust_score(character)
	update_traits_summary(character)
	
	Trust.visible = true

func update_trust_score(character: Character):
	var Score = $Container/TrustScoreContainer/Trust/Score/Number

	var trust_score_total = character.trust_of(player_character)
	Score.text = signed_score(trust_score_total)
	if trust_score_total > 0:
		Score.add_color_override("font_color", green)
	elif trust_score_total < 0:
		Score.add_color_override("font_color", red)
	else:
		Score.set("custom_colors/font_color", null)

func update_traits_summary(character: Character):
	var traits_text = ""
	var trait_trust_scores = character.trait_trust_scores(player_character)
	for name in trait_trust_scores:
		var score = trait_trust_scores[name]
		if  score != 0:
			traits_text += " - %s (%s)\n" % [name, signed_score(score)]
	
	$Container/TrustScoreContainer/Trust/Traits.text = traits_text

func update_detailed_traits(character: Character):
	var TraitsContainer = $Container/TraitsContainer
	for child in TraitsContainer.get_children():
		child.queue_free()
	
	for trait in character.traits:
		var info = TraitInfoScene.instance()
		info.init(trait)
		TraitsContainer.add_child(info)
		TraitsContainer.add_spacer(false)
		
func signed_score(score: int) -> String:
	return ("+%s" % score) if (score > 0) else str(score)
