extends Control

export (PackedScene) var SecretInfoScene

func show_secrets(secrets: Array):
	for secret in secrets:
		for d in secret.description():
			var info = SecretInfoScene.instance()
			info.init(d)
			$Secrets.add_child(info)
