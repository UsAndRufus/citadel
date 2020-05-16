extends Control

var about
var text

func init(description: Array):
	about = description[0]
	text = description[1]
	$Description.text = text
