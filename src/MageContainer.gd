extends Node2D

@onready var mage_scene: PackedScene = preload("res://scenes/mageVisual.tscn")
@export var max_visible_mages := 2000  # 最多顯示 ln(總礦工數)
@export var spawn_area_width := 960.0  # 左右最大顯示範圍（±480）

func _ready():
    pass

func update_displayed_mages(target_count: int):
    for ith in range(target_count):
        var mage := mage_scene.instantiate() as Node2D
        add_child(mage)

        # 初始化位置範圍（限定 ±spawn_area_width/2）
        mage.position.x = -spawn_area_width / 2.0
        mage.position.y = 0 

        # 確保移動不會超出容器範圍
        mage.set("move_limit", spawn_area_width / 2.0)
        
func clean_mages():
    for child in get_children():
        if child is Node2D:
            child.visible = false
