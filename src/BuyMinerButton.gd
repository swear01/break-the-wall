extends "res://src/AutoClickableButton.gd"  # 根據你的路徑調整

@export var miner_manager: Node

func _ready():
    super._ready()  # 記得呼叫父類別的 _ready
    text = "雇用礦工（%dG）金" % miner_manager.miner_cost
    pressed.connect(_on_pressed)

func _on_pressed():
    miner_manager.buy_miner(1)
