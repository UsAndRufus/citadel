extends Control

export (PackedScene) var TraitInfoScene

var player_character: Character


func set_player_character(character: Character):
	player_character = character
	display_player_info()
	display_traits()

func display_player_info():
	$Container/Name.text = "%s (you)" % player_character.character_name
	$Container/Rank.text = "Rank: %s" % player_character.rank_name()
	

func display_traits():
	for trait in player_character.traits:
		var info = TraitInfoScene.instance()
		info.init(trait)
		$Container/TraitsContainer.add_child(info)
		$Container/TraitsContainer.add_spacer(false)
