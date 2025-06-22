extends Node

@export var wall: Node2D
@onready var main = $"../"
var miner_death_schedule := {}   # key: int 秒數（unix time），value: int 死亡數量
var miner_alive_total: int = 0
var miner_lifespawn: float = 5.0
var miner_damage: float = 1.5
@export var miner_cost := 5

func _process(delta):
    update_miners()
    var miner_count = get_alive_miner_count()  # 你已有的函式
    var damage = miner_count * delta * miner_damage
    wall.apply_damage(damage)
    
func buy_miner(amount: int):
    if main.try_spend_gold(miner_cost * amount):
        spawn_miner(amount)  # 或 add_miner()
    else:
        print("黃金不足！")

func spawn_miner(amount: int):
    var now = Time.get_unix_time_from_system()
    var death_time = int(now + miner_lifespawn)
    miner_death_schedule[death_time] = miner_death_schedule.get(death_time, 0) + amount
    miner_alive_total += amount

# 每 frame 執行，移除已死亡礦工
func update_miners():
    var now = int(Time.get_unix_time_from_system())
    if miner_death_schedule.has(now):
        miner_alive_total -= miner_death_schedule[now]
        miner_death_schedule.erase(now)

func clean_miners():
    miner_death_schedule = {}
    miner_alive_total = 0

# 回傳當前應該要顯示幾名礦工（ln）
func get_displayed_miner_count() -> int:
    return ceili(log(miner_alive_total + 1)/log(1.6))  # +1 避免 log(0)

# 回傳目前活著的總礦工數
func get_alive_miner_count() -> int:
    return miner_alive_total
