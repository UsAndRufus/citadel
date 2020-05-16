extends VBoxContainer

export (PackedScene) var SecretInfoScene

func show_secrets(player_character: Character):
	for secret in player_character.secrets_about:
		var d = { "about": player_character, 
				  "description": secret.description % player_character.character_name }
		show_details(d)

func show_details(detail: Dictionary):
	var info = SecretInfoScene.instance()
	info.init(detail)
	$Secrets.add_child(info)
