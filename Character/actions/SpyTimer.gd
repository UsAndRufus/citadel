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
	
	attempt_action()

func attempt_action():
	if randf() < chance:
		print("action success")
		give_secret()
	else:
		print("action failed")
		caught_spying()
	
	actor = null
	subject = null

func give_secret():
	var available = available_secrets()
	if available.size() > 0:
		var secret = available[randi() % available.size()]
		actor.add_known_secret(secret)
		print("secret granted")
	else:
		print("no secret to grant")

func caught_spying():
	var secret = find_existing_spying_secret()
	if secret != null:
		subject.add_known_secret(secret)
	else:
		new_spying_secret()

func new_spying_secret():
	# Add secret about actor that subject knows
	var secret = Secret.new([actor], "spy", 
							"%s was caught spying",
							[subject]) 
	
	actor.add_known_secret(secret)
	actor.add_secret_about(secret)
	actor.stats["spy"] = true
	subject.add_known_secret(secret)

func find_existing_spying_secret():
	for secret in actor.secrets_about:
		if secret.stat == "spy":
			return secret
	return null

func available_secrets() -> Array:
	var available = []
	for secret in subject.secrets_about:
		if !actor.known_secrets.has(secret):
			available.append(secret)
	
	return available
