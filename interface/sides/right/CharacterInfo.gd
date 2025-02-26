extends Control

export(bool) var ShowTrustScore
export(bool) var ShowAlignment
export(bool) var ShowActions

var player_character: Character

export var green: Color = Color(0.254902, 0.807843, 0.054902)
export var red: Color = Color(0.807843, 0.054902, 0.054902)

export (PackedScene) var TraitInfoScene

var character: Character

func _on_character_selected(_character: Character):
	character = _character
	
	character.connect("secrets_known_changed", self, "_on_character_updated")
	character.connect("secrets_about_changed", self, "_on_character_updated")
	
	update_character_info(character, false)
	self.visible = true

func _on_character_deselected(_character: Character):
	if character != null:
		character.disconnect("secrets_known_changed", self, "_on_character_updated")
		character.disconnect("secrets_about_changed", self, "_on_character_updated")
	
	for child in $TraitsContainer.get_children():
		child.queue_free()
	self.visible = false
	character = null

func _on_character_updated():
	update_character_info(character, false)

func update_character_info(character: Character, is_pc: bool):
	$TrustScoreContainer/Name.text = character.character_name
	$TrustScoreContainer/Rank.text = "Rank: %s" % character.rank_name()
	update_alignment(character)
	update_trust(character)
	show_actions()
	update_detailed_traits(character, is_pc)

func update_alignment(character: Character):
	var Alignment = $TrustScoreContainer/Alignment
	
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
	var TheirTrustOfYou = $TrustScoreContainer/TheirTrustOfYou
	var YourTrustOfThem = $TrustScoreContainer/YourTrustOfThem
	
	if !ShowTrustScore:
		TheirTrustOfYou.visible = false
		YourTrustOfThem.visible = false
		return
		
	update_their_trust_score(character)
	update_your_trust_score(character)
	update_their_traits_summary(character)
	update_your_traits_summary(character)
	
	TheirTrustOfYou.visible = true
	YourTrustOfThem.visible = true

func update_their_trust_score(character: Character):
	var Score = $TrustScoreContainer/TheirTrustOfYou/Score
	var trust_score_total = character.trust_of(player_character)
	
	update_trust_score(trust_score_total, "Their trust of you: ", Score)

func update_your_trust_score(character: Character):
	var Score = $TrustScoreContainer/YourTrustOfThem/Score
	var trust_score_total = player_character.trust_of(character)
	
	update_trust_score(trust_score_total, "Your trust of them: ", Score)

func update_trust_score(trust_score_total: int, title: String, Score):
	var ScoreNumber = Score.get_node("Number")
	ScoreNumber.text = signed_score(trust_score_total)
	if trust_score_total > 0:
		ScoreNumber.add_color_override("font_color", green)
	elif trust_score_total < 0:
		ScoreNumber.add_color_override("font_color", red)
	else:
		ScoreNumber.set("custom_colors/font_color", null)
	
	Score.get_node("Text").text = title

func update_their_traits_summary(character: Character):
	var TraitsText = $TrustScoreContainer/TheirTrustOfYou/Traits
	var trait_trust_scores = character.trait_trust_scores(player_character, player_character)
	
	update_traits_summary(trait_trust_scores, TraitsText)

func update_your_traits_summary(character: Character):
	var TraitsText = $TrustScoreContainer/YourTrustOfThem/Traits
	var trait_trust_scores = player_character.trait_trust_scores(character, player_character)
	
	update_traits_summary(trait_trust_scores, TraitsText)

func update_traits_summary(trait_trust_scores: Dictionary, TraitsText):
	var traits_text = ""
	for name in trait_trust_scores:
		var score = trait_trust_scores[name]
		if  score != 0:
			traits_text += " - %s (%s)\n" % [name, signed_score(score)]
	
	TraitsText.text = traits_text

func show_actions():
	if ShowActions:
		$ActionsHeader.visible = true
		$ActionsContainer.visible = true
	else:
		$ActionsHeader.visible = false
		$ActionsContainer.visible = false

func update_detailed_traits(character: Character, is_pc: bool):
	var TraitsContainer = $TraitsContainer
	for child in TraitsContainer.get_children():
		child.queue_free()
	
	for trait in character.traits:
		if trait.hidden && !is_pc:
			continue
		var info = TraitInfoScene.instance()
		info.init(trait)
		TraitsContainer.add_child(info)
		TraitsContainer.add_spacer(false)
		
func signed_score(score: int) -> String:
	return ("+%s" % score) if (score > 0) else str(score)

func _on_SpyButton_pressed():
	player_character.start_action(Character.Actions.SPY, character)
