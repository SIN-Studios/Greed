extends Node
@warning_ignore_start("unused_signal")
#signal player_picks_up_item
signal player_update_calories
signal new_day
#signal player_go_to_sleep
signal shake_requested(intensity: float)
signal shake_stop_requested
#yeah i want the screen to shake 
signal lava
signal plains
signal forest
#these signal the area name loading in

#don't wnat these two
signal player_lay_down
signal player_get_up

signal change_timescale
signal update_inventory_ui
