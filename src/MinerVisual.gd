extends Node2D

@onready var sprite: Sprite2D = $Sprite
@onready var shader_material := sprite.material as ShaderMaterial

# --- 行走參數 ---
@export var move_limit := 480.0  # 可移動的最大距離（相對父節點 x = 0）
@export var move_range := Vector2(50.0, 140.0)  # 單次移動距離範圍
@export var move_speed := 48.0   # 每秒移動速度（px）
@export var move_interval := Vector2(1.0, 3.0) # 每次移動的等待時間範圍

var _start_x := 0.0
var _target_x := 0.0
var _moving := false
var _is_dead := false

func apply_theme_color(bg: Color, hl: Color) -> void:
    shader_material.set_shader_parameter("highlight_color", hl)

func _ready():
    _start_x = randf_range(-move_limit, move_limit)
    _pick_new_target()

func _process(delta):
    if _moving:
        var dx = _target_x - position.x
        var step = move_speed * delta * sign(dx)
        if abs(dx) < abs(step):
            position.x = _target_x
            _moving = false
            call_deferred("_wait_and_move")
        else:
            position.x += step

func _pick_new_target():
    var target_range = randf_range(move_range.x, move_range.y)
    var dir = sign(randf() - 0.5)  # -1 或 +1
    var proposed = position.x + dir * target_range

    # Clamp 不超過最大界線
    proposed = clamp(proposed, -move_limit, move_limit)

    _target_x = proposed
    _moving = true

    # 左右翻臉
    sprite.flip_h = _target_x > position.x

func _die():
    _is_dead = true
    set_process(false)
    call_deferred("queue_free")

func _wait_and_move():
    var wait_time = randf_range(move_interval.x, move_interval.y)
    await get_tree().create_timer(wait_time).timeout
    if _is_dead or !is_inside_tree():
        return
    _pick_new_target()
