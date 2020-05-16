extends VBoxContainer

export (PackedScene) var SecretInfoScene

var player_character

func _on_pc_secrets_about_changed():
	show_secrets(player_character)

func show_secrets(character: Character):
	player_character = character
	
	remove_children()
	
	for secret in player_character.secrets_about:
		var d = { "about": player_character, 
				  "description": secret.description % player_character.character_name }
		show_details(d)

func show_details(detail: Dictionary):
	var info = SecretInfoScene.instance()
	info.init(detail)
	$Secrets.add_child(info)

func remove_children():
	for child in $Secrets.get_children():
		child.queue_free()
