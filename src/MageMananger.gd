extends Node

@export var miner_mananger: Node
@export var mage_container: Node
var mage_death_schedule := {}   # key: int 秒數（unix time），value: int 死亡數量
var mage_alive_total: int = 0
var mage_lifespawn: float = 20.0
var summon_period: float = 2.0
var cumu_time: float = 0.0

func _process(delta):
    cumu_time += delta
    if cumu_time > summon_period:
        update_mages()
        var mage_count = get_alive_mage_count()
        var summon_count = int(mage_count * cumu_time)
        miner_mananger.buy_miner(summon_count)
        cumu_time = 0.0
        
func spawn_mage():
    var now = Time.get_unix_time_from_system()
    var death_time = int(now + mage_lifespawn)
    mage_death_schedule[death_time] = mage_death_schedule.get(death_time, 0) + 1
    mage_alive_total += 1
    mage_container.update_displayed_mages(1)

func update_mages():
    var now = int(Time.get_unix_time_from_system())
    if mage_death_schedule.has(now):
        mage_alive_total -= mage_death_schedule[now]
        mage_death_schedule.erase(now)

func clean_mages():
    mage_death_schedule = {}
    mage_alive_total = 0
    mage_container.clean_mages()

func get_alive_mage_count() -> int:
    return mage_alive_total
