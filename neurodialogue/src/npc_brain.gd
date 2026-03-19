extends Node
class_name NPCBrain

# State variable: -10 (Hostile) to 10 (Friendly)
var affinity: int = 0 

# This is the "Public API" of your brain. 
# The UI Controller calls this to change the state.
func update_affinity(amount: int) -> String:
	affinity = clampi(affinity + amount, -10, 10) 
	return get_mood_text()

# This is the "Logic Gate" that decides the string output
func get_mood_text() -> String:
	if affinity >= 5:
		return "Friend: 'It's a beautiful day to see you again!'"
	elif affinity <= -5:
		return "Enemy: 'Why are you still standing here? Leave.'"
	else:
		return "Stranger: 'Greetings. Can I help you with something?'"
