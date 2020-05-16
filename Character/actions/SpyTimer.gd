extends Timer

export (float) var chance

var actor
var subject

func start_action(_actor, _subject):
	actor = _actor
	subject = _subject
	start()

func _on_SpyTimer_timeout():
	print("Spy action on %s finished!" % subject.character_name)
	
	give_secret()

func give_secret():
	if randf() < chance:
		print("action success")
		var available = available_secrets()
		if available.size() > 0:
			var secret = available[randi() % available.size()]
			actor.add_known_secret(secret)
			print("secret granted")
		else:
			print("no secret to grant")
	else:
		print("action failed")

func available_secrets() -> Array:
	var available = []
	for secret in subject.secrets_about:
		if !actor.known_secrets.has(secret):
			available.append(secret)
	
	return available
