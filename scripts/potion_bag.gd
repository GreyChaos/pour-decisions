extends Node2D

var amountsleft = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bag_clicked() -> void:
	if GameManager.day_active:
		if amountsleft == 0:
			return
		amountsleft -= 1
		$AnimatedSprite2D.frame = 2 - amountsleft
		$"..".refill_potions()
		$"Bag Used".play()

func fill_bag():
	amountsleft = 2
	$AnimatedSprite2D.frame = 2 - amountsleft
