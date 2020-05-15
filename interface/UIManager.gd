extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_player(character: Character):
	$RightSide/Background/VBoxContainer/CharacterInfo.player_character = character
	$LeftSide/Background/VBoxContainer/PlayerCharacterInfo.set_player_character(character)
	
func observe_characters(characters):
	for character in characters:
		character.connect("selected", $RightSide/Background/VBoxContainer/CharacterInfo, "_on_character_selected")
		character.connect("deselected", $RightSide/Background/VBoxContainer/CharacterInfo, "_on_character_deselected")
