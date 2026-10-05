extends Control

## Presentation only: forwards button presses to the brain and redraws when
## the brain's signals fire.

const GIFT_AMOUNT := 2
const INSULT_AMOUNT := -2

@onready var brain: NPCBrain = $NPCBrain
@onready var box: VBoxContainer = $VBoxContainer
@onready var display_label: Label = $VBoxContainer/MoodLabel

var affinity_bar: ProgressBar
var reset_button: Button


func _ready() -> void:
	_build_extra_controls()
	brain.affinity_changed.connect(_on_affinity_changed)
	brain.mood_changed.connect(_on_mood_changed)
	display_label.text = "A stranger approaches..."
	_on_affinity_changed(brain.affinity)


## The affinity bar and reset button are created here rather than in
## Main.tscn so the scene file stays simple.
func _build_extra_controls() -> void:
	affinity_bar = ProgressBar.new()
	affinity_bar.min_value = NPCBrain.MIN_AFFINITY
	affinity_bar.max_value = NPCBrain.MAX_AFFINITY
	affinity_bar.step = 1
	affinity_bar.show_percentage = false
	affinity_bar.custom_minimum_size = Vector2(0, 16)
	box.add_child(affinity_bar)
	box.move_child(affinity_bar, display_label.get_index() + 1)

	reset_button = Button.new()
	reset_button.text = "Reset (Esc)"
	reset_button.focus_mode = Control.FOCUS_NONE
	reset_button.pressed.connect(_reset)
	box.add_child(reset_button)


func _on_affinity_changed(value: int) -> void:
	affinity_bar.value = value
	affinity_bar.tooltip_text = "Affinity: %d" % value


func _on_mood_changed(_mood: NPCBrain.Mood, line: String) -> void:
	display_label.text = line


## Every click gets a visible reply, even when the mood band doesn't change.
func _respond(amount: int) -> void:
	brain.update_affinity(amount)
	display_label.text = brain.line()


func _on_gift_pressed() -> void:
	_respond(GIFT_AMOUNT)


func _on_insult_pressed() -> void:
	_respond(INSULT_AMOUNT)


func _reset() -> void:
	brain.reset()
	display_label.text = "A stranger approaches..."


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_reset()
