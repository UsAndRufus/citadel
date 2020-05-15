extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func observe_characters(characters):
	for character in characters:
		character.connect("clicked", $RightSide/Background/VBoxContainer/CharacterInfo, "_on_character_clicked")
