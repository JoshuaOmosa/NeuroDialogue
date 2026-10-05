extends Node
class_name NPCBrain

## Tracks how the NPC feels about the player and announces changes.
## The brain knows nothing about the UI: it only emits signals, so the label,
## animations, audio or quest logic can all listen without touching this file.

enum Mood { ENEMY, STRANGER, FRIEND }

signal affinity_changed(affinity: int)
signal mood_changed(mood: Mood, line: String)

const MIN_AFFINITY := -10
const MAX_AFFINITY := 10
const FRIEND_AT := 5
const ENEMY_AT := -5

const LINES := {
	Mood.ENEMY: "Enemy: 'Why are you still standing here? Leave.'",
	Mood.STRANGER: "Stranger: 'Greetings. Can I help you with something?'",
	Mood.FRIEND: "Friend: 'It's a beautiful day to see you again!'",
}

var affinity: int = 0
var mood: Mood = Mood.STRANGER


## Mood is a pure function of affinity, so it can never drift out of sync.
static func mood_for(value: int) -> Mood:
	if value >= FRIEND_AT:
		return Mood.FRIEND
	if value <= ENEMY_AT:
		return Mood.ENEMY
	return Mood.STRANGER


func line() -> String:
	return LINES[mood]


func update_affinity(amount: int) -> void:
	_set_affinity(clampi(affinity + amount, MIN_AFFINITY, MAX_AFFINITY))


func reset() -> void:
	_set_affinity(0)


func _set_affinity(value: int) -> void:
	affinity = value
	affinity_changed.emit(affinity)
	var new_mood := mood_for(affinity)
	if new_mood != mood:
		mood = new_mood
		mood_changed.emit(mood, line())
