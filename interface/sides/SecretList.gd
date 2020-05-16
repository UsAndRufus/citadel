extends Control

export (PackedScene) var SecretInfoScene

var player_character

func show_secrets_about(secrets: Array):
	for secret in secrets:
		for d in secret.details_about():
			show_details(d)

func show_details(detail: Dictionary):
	var info = SecretInfoScene.instance()
	info.init(detail)
	$Secrets.add_child(info)


func _on_character_selected(character: Character):
	var known_secrets = []
	for s in character.secrets_about:
		if s.is_known_by(player_character):
			known_secrets.append(s)

	show_secrets_about(known_secrets)
	
	self.visible = true

func _on_character_deselected(_character: Character):
	for child in $Secrets.get_children():
		child.queue_free()
	self.visible = false
