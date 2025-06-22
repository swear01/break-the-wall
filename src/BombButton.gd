extends "res://src/AutoClickableButton.gd"

@export var wall: Node2D
@export var main: Node2D  # 包含 gold 資訊

@export var damage_ratio : float = 1.0
@export var cost_ratio: float = 0.002

func _ready():
    super._ready()
    text = "炸彈(%.2f%% 金)" % (cost_ratio * 100.0)
    pressed.connect(_on_pressed)
    main.ascend_changed.connect(_on_ascend_changed)
    visible = false

func _on_ascend_changed(new_ascend: int):
    visible = new_ascend >= 2

func _on_pressed():
    var current_gold = main.gold
    var cost = int(current_gold * cost_ratio)
    if cost < 1:
        return  # 避免過小的傷害
    
    if main.try_spend_gold(cost):
        var damage = cost * damage_ratio
        wall.apply_damage(damage)
