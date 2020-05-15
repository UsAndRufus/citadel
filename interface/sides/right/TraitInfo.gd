extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(trait: Trait):
	$Name.text = trait.trait_name
	$Description.text = trait.description
