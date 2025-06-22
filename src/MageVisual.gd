extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var shader_material := sprite.material as ShaderMaterial

# --- 行走參數 ---
@export var move_limit := 480.0  # 可移動的最大距離（相對父節點 x = 0）
@export var move_speed := 24.0   # 每秒移動速度（px）// dist/lifespawn 

var _is_dead := false

func apply_theme_color(bg: Color, hl: Color) -> void:
    shader_material.set_shader_parameter("highlight_color", hl)

func _ready():
    position.x = -move_limit

func _process(delta):
    var step = move_speed * delta 
    position.x += step
    if position.x > move_limit:
        _die()

func _die():
    _is_dead = true
    set_process(false)
    call_deferred("queue_free")
