extends Control


@onready var brain = $NPCBrain 
@onready var display_label = $VBoxContainer/MoodLabel

func _ready():
	# Set the initial text when the game starts
	display_label.text = "A stranger approaches..."

# This function is called when you click the "Gift" button
func _on_gift_pressed() -> void:
	#  Tell the brain the player was nice (+2 affinity)
	# The brain returns a string (the NPC's response)
	var response = brain.update_affinity(2)
	
	#  Update the Label on screen with that response
	display_label.text = response

# This function is called when you click the "Insult" button
func _on_insult_pressed() -> void:
	#  Tell the brain the player was mean (-2 affinity)
	var response = brain.update_affinity(-2)
	
	#  Update the Label on screen
	display_label.text = response
	
