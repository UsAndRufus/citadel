extends Control

var about
var description

func init(details: Dictionary):
	about = details["about"]
	description = details["description"]
	$Description.text = description
