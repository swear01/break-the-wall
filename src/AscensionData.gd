# AscensionData.gd
extends Resource
class_name AscensionData

@export var block_width_list: Array[int] = [2, 5, 8, 14, 18]
@export var auto_click_speed_list: Array[float] = [0.001, 5.0, 10.0, 20.0,30.0]  # 可擴充
@export var ascend_level_list: Array[int] = [23,30,36,43,50]
#@export var ascend_level_list: Array[int] = [3,5,7,9,50] # For Test
@export var ascendsion_text: Array[String] = [
    "歡迎來到To The Abyss",
    "自動點擊已開放，請長按",
    "炸彈已開放",
    "加油快結束了",
    "終點就在前方"
]
@export var enable_auto_click_at: int = 1
@export var enable_bomb_at: int = 2
