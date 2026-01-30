extends Node2D

var potion_wanted
@onready var label: Label = $Label
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	potion_wanted = GameManager.all_recipes[0]
	label.text = potion_wanted.symptoms[randi_range(0, potion_wanted.symptoms.size() - 1)]
	GameManager.current_customer = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func new_customer():
	sprite_2d.frame = randi_range(0, sprite_2d.sprite_frames.get_frame_count(sprite_2d.animation) - 1)
	potion_wanted = GameManager.all_recipes[randi_range(0, GameManager.all_recipes.size() - 1)]
	label.text = potion_wanted.symptoms[randi_range(0, potion_wanted.symptoms.size() - 1)]

func play_sound(Happy: bool):
	if Happy:
		$"Happy Sound".play()
	else:
		$"Upset Sound".play()
