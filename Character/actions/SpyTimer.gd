extends Timer

var subject: Character

func start_action(_subject):
	subject = _subject
	start()

func _on_SpyTimer_timeout():
	subject.print()
	
	print("Spy action on %s finished!" % subject.character_name)
