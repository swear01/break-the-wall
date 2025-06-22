extends Node2D

@onready var wall := $GameArea/Wall
@onready var gold_area := $GameArea/GoldTrigger
@onready var miner_manager = $MinerMananger
@onready var miner_container = $GameArea/MinerContainer
@onready var mage_manager = $MageMananger
@onready var mage_container = $GameArea/MageContainer
@onready var grid_overlay = $GameArea/GridOverlay
@export var ascension_data: AscensionData
@export var ascend_text = Label
@export var layer_text: Label
@export var gold_text: Label
@export var miner_text: Label
@export var pickaxe_text: Label
@export var hint_text: Label

signal ascend_changed(new_ascend: int)

var win_layer := 50
var has_won := false
var current_layer := 0
var gold :float = 0.0
var pickaxe_resource :float = 0.0 
var color_set_names = ["black", "red", "peach", "orange", "yellow", "cyan", "green", "blue", "purple", "white"]
var ascension_level : int = 0
var block_width: int = 2


func _ready():
    wall.wall_broken.connect(_on_wall_broken)
    gold_area.gold_generated.connect(_on_gold_triggered)
    wall.dps_updated.connect(_on_dps_updated)
    ColorThemeSystem.update_theme_by_layer(current_layer)
    update_ui()
    
func _process(_delta: float):
    var show_count = miner_manager.get_displayed_miner_count()
    miner_container.update_displayed_miners(show_count)
    update_ui()
    if not has_won and current_layer >= win_layer:
        has_won = true
        get_tree().change_scene_to_file("res://scenes/Victory.tscn")

func _on_wall_broken():
    current_layer += 1
    wall.set_wall_layer(current_layer)
    ColorThemeSystem.update_theme_by_layer(current_layer)

func _on_gold_triggered():
    var gain = block_width* current_layer
    gold += gain

func _on_dps_updated(dps: float):
    var gain = sqrt(dps)
    pickaxe_resource += gain * get_process_delta_time()

func try_spend_gold(amount: int) -> bool:
    if gold >= amount:
        gold -= amount
        return true
    return false

func try_ascend():
    var ascension_require_level = ascension_data.ascend_level_list[ascension_level]
    if current_layer >= ascension_require_level:
        ascend()

func ascend():
    ascension_level += 1
    # 重置遊戲狀態
    miner_manager.clean_miners()
    mage_manager.clean_mages()
    wall.reset_wall()
    gold = 0
    pickaxe_resource = 0
    current_layer = 0
    
    # 改變遊戲係數
    var new_block_width = ascension_data.block_width_list[ascension_level]
    block_width = new_block_width
    grid_overlay.set_column_count(block_width)
    var auto_click_interval = 1.0/ascension_data.auto_click_speed_list[ascension_level]
    AutoClickController.auto_click_interval = auto_click_interval
    
    emit_signal("ascend_changed", ascension_level)
    

func update_ui():
    ascend_text.text = "飛昇次數：%d" % ascension_level
    layer_text.text = "目前層數：%d" % current_layer
    gold_text.text = "目前黃金：%d" % int(gold)
    miner_text.text = "礦工數量：%d" % miner_manager.get_alive_miner_count()
    pickaxe_text.text = "持有稿元：%d" % int(pickaxe_resource)
    hint_text.text = ascension_data.ascendsion_text[ascension_level]
