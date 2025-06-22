extends Node2D

@onready var miner_scene: PackedScene = preload("res://scenes/MinerVisual.tscn")
@export var max_visible_miners := 200  # 最多顯示 ln(總礦工數)
@export var spawn_area_width := 960.0  # 左右最大顯示範圍（±480）
var miners: Array[Node]

func _ready():
    pass

func update_displayed_miners(target_count: int):
    target_count = min(target_count, max_visible_miners)
    miners = get_tree().get_nodes_in_group("miners")

    # 刪除多餘礦工
    while miners.size() > target_count:
        #print(miners)
        var oldest = miners[0]
        oldest._die()
        miners.remove_at(0)
        #miners = get_tree().get_nodes_in_group("miners")

    # 增加不足礦工
    while miners.size() < target_count:
        var miner := miner_scene.instantiate() as Node2D
        add_child(miner)
        miner.add_to_group("miners")

        # 初始化位置範圍（限定 ±spawn_area_width/2）
        miner.position.x = randf_range(-spawn_area_width / 2.0, spawn_area_width / 2.0)
        miner.position.y = 0 

        # 確保移動不會超出容器範圍
        miner.set("move_limit", spawn_area_width / 2.0)
        miners = get_tree().get_nodes_in_group("miners")
