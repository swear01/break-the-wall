extends "res://src/AutoClickableButton.gd"  # 替換成你的實際路徑

@export var mage_cost := 5
@export var mage_manager: Node
@export var main: Node2D

func _ready():
    super._ready()
    text = "雇用海濤法師（%dG）稿元" % mage_cost
    pressed.connect(_on_pressed)

func _on_pressed():
    if main.pickaxe_resource >= mage_cost:
        main.pickaxe_resource -= mage_cost
        mage_manager.spawn_mage()
    else:
        print("稿元不足！")
