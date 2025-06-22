extends Area2D

@export var base_hp := 10.0
var current_layer := 0
var hp : float = 10.0
var max_hp : float = 10.0
var dps : float = 0.0
var _damage_this_frame: float = 0.0

signal wall_broken()
signal dps_updated(dps:float)


@onready var fill := $Fill
@onready var background := $Background
@onready var bottom_wall := $BottomWall
@onready var col := $CollisionShape2D
@onready var hp_label := $HpLabel

func _ready():
    set_wall_layer(0)
    AutoClickController.auto_click.connect(_on_auto_click)

func _process(delta):
    update_fill()
    dps = _damage_this_frame / delta
    _damage_this_frame = 0.0

    emit_signal("dps_updated", dps)  # 通知 Main

func _input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.pressed:
        apply_damage(1.0)

func _on_auto_click():
    if _mouse_in_wall_area():
        apply_damage(1.0)

func _mouse_in_wall_area() -> bool:
    var rect_shape = col.shape as RectangleShape2D
    if not rect_shape:
        return false
    var rect_pos = col.global_position - rect_shape.extents
    var rect = Rect2(rect_pos, rect_shape.extents * 2)
    return rect.has_point(get_global_mouse_position())


func apply_damage(damage: float):
    hp -= damage
    _damage_this_frame += damage
    if hp <= 0:
        wall_broken.emit()
        play_break_effect()

func set_wall_layer(layer: int):
    current_layer = layer
    calculate_max_hp(current_layer)
    hp = max_hp
    update_fill()

func calculate_max_hp(layer: int):
    max_hp = base_hp * pow(1.18, layer)

func update_fill():
    var percent = hp / max_hp
    percent = clamp(percent, 0.001, 1.0)
    fill.size.x = background.size.x * percent
    #print(background.size.x, fill.size.x)
    hp_label.text = "HP:" + str(int(hp)) + "/" + str(int(max_hp))

func reset_wall():
    set_wall_layer(0)

func play_break_effect():
    var fx = preload("res://effects/break_particle.tscn").instantiate()
    fx.global_position = global_position
    get_tree().current_scene.add_child(fx)
    fx.emitting = true

    # 等待特效結束後自動清除
    await get_tree().create_timer(fx.lifetime).timeout
    fx.queue_free()

func apply_theme_color(bg: Color, hl: Color) -> void:
    bottom_wall.modulate = hl
    fill.modulate = hl
    background.modulate = bg
    
