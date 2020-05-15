extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_character_clicked(character: Character):
	update_character_info(character)


func update_character_info(character: Character):
	character.print()
