extends Node2D
class_name Bottle

@onready var area_2d: Area2D = $Area2D
@export var color = Color.WHITE
var dragging = false
var starting_posistion
var potion = null
@export var amount = 4
@export var potion_type: GameManager.PotionType = GameManager.PotionType.EMPTY


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.frame = 5 - (amount + 1)
	self.modulate = color
	starting_posistion = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if potion_type != GameManager.PotionType.EMPTY:
		if amount == 0:
			$GPUParticles2D.emitting = false
			$PouringSound.stop()
		elif GameManager.held_item == self and GameManager.pouring:
			$GPUParticles2D.emitting = true
			if not $PouringSound.playing:
				$PouringSound.play()
		else:
			$GPUParticles2D.emitting = false
			$PouringSound.stop()
		pass



func _mouse_entered(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			GameManager.held_item = self
			dragging = event.pressed

func pour_potion():
	amount -= 1
	$AnimatedSprite2D.frame = 5 - (amount + 1)
	
func fill_potion():
	if potion_type == GameManager.PotionType.EMPTY:
		$"Fill Sound".play()
	amount += 1
	if amount > 4:
		amount = 4
	$AnimatedSprite2D.frame = 5 - (amount + 1)

func _input(event):
	if dragging and event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
		
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			GameManager.held_item = null
			dragging = false
			set_rotation(0)
			# Give to customer
			if area_2d.get_overlapping_areas():
				if potion == GameManager.current_customer.potion_wanted:
					$"../../HappySad".text = "Good job!"
					GameManager.current_customer.play_sound(true)
					GameManager.happy_customers_today += 1
					GameManager.money += GameManager.current_customer.potion_wanted.sell_price
					GameManager.total_money_today += GameManager.current_customer.potion_wanted.sell_price
					$"../../Money".text = "$" + str(GameManager.money)
				else:
					$"../../HappySad".text = "BAD!"
					GameManager.current_customer.play_sound(false)
					GameManager.upset_customers_today += 1
				GameManager.current_customer.new_customer()
				pour_potion()
				if amount == 0:
					potion_type = GameManager.PotionType.EMPTY
					color = Color.WHITE
					self.modulate = Color.WHITE
			global_position = starting_posistion
			
