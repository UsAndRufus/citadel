extends Control

var player_character: Character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_player(character: Character):
	$RightSide/Background/VBoxContainer/CharacterInfo.player_character = character
	set_player_character(character)
	
func observe_characters(characters):
	for character in characters:
		character.connect("selected", $RightSide/Background/VBoxContainer/CharacterInfo, "_on_character_selected")
		character.connect("deselected", $RightSide/Background/VBoxContainer/CharacterInfo, "_on_character_deselected")

func set_player_character(character: Character):
	player_character = character
	$LeftSide/Background/VBoxContainer/CharacterInfo.update_character_info(character)
