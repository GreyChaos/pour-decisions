extends Node2D

var filledAmount = 0
var color = Color.WHITE
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var contents: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	GameManager.pouring = true
	if GameManager.held_item != null:
		if GameManager.held_item.potion_type == GameManager.PotionType.EMPTY:
			return
		GameManager.held_item.set_rotation(115)


func _on_area_2d_mouse_exited() -> void:
	GameManager.pouring = false
	
func empty_into_potion(potion: Bottle):
	if contents.is_empty():
		return
	if GameManager.identify_potion(contents) != null:
		potion.potion = GameManager.identify_potion(contents)
	else:
		potion.potion = null
	filledAmount = 0
	animated_sprite_2d.frame = filledAmount
	color = Color.WHITE
	self.modulate = color
	contents.clear()

func change_color(new_color: Color):
	if color == Color.WHITE:
		color = new_color
	else:
		color = color.lerp(new_color, .3)
	self.modulate = color
		
func add_contents(content: GameManager.PotionType):
	if contents.has(content):
		contents[content] += 1
	else:
		contents[content] = 1
		
func changeSprite(amount: int):
	filledAmount += amount
	if filledAmount > 4:
		filledAmount = 4
	animated_sprite_2d.frame = filledAmount
