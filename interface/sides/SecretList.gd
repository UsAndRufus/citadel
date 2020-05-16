extends Control

export (PackedScene) var SecretInfoScene

var player_character
var subject

func _on_pc_secrets_known_changed():
	if subject == null:
		show_secrets_about(player_character.known_secrets)
	else:
		_on_character_selected(subject)

func show_secrets_about(secrets: Array):
	for secret in secrets:
		for d in secret.details_about():
			show_details(d)

func show_details(detail: Dictionary):
	var info = SecretInfoScene.instance()
	info.init(detail)
	$Secrets.add_child(info)

func _on_character_selected(character: Character):
	subject = character
	
	subject.connect("secrets_known_changed", self, "_on_character_updated")
	subject.connect("secrets_about_changed", self, "_on_character_updated")
	
	update_secrets()
	
	self.visible = true

func _on_character_deselected(_character: Character):
	if subject != null:
		subject.disconnect("secrets_known_changed", self, "_on_character_updated")
		subject.disconnect("secrets_about_changed", self, "_on_character_updated")
	
	for child in $Secrets.get_children():
		child.queue_free()
	self.visible = false
	subject = null

func _on_character_updated():
	update_secrets()

func update_secrets():
	var known_secrets = []
	for s in subject.secrets_about:
		if s.is_known_by(player_character):
			known_secrets.append(s)

	show_secrets_about(known_secrets)
