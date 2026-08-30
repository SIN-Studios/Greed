extends Node

var playing_sfx: Array[AudioStreamPlayer] = []


func play_sfx(stream: AudioStream, force_unique: bool = false) -> void:
	if not stream: return
	

	if force_unique:
		for player in playing_sfx:
			if is_instance_valid(player) and player.stream.resource_path == stream.resource_path:
				return
	
	var player = AudioStreamPlayer.new()
	player.stream = stream
	add_child(player)
	player.play()
	
	playing_sfx.append(player)
	
	await player.finished
	if is_instance_valid(player):
		playing_sfx.erase(player)
		player.queue_free()



func stop_sfx(stream: AudioStream) -> void:
	if not stream: return
	for i in range(playing_sfx.size() - 1, -1, -1):
		var player = playing_sfx[i]
		if is_instance_valid(player) and player.stream.resource_path == stream.resource_path:
			player.stop()
			player.queue_free()
			playing_sfx.remove_at(i)

func stop_all_sfx() -> void:
	for player in playing_sfx:
		if is_instance_valid(player):
			player.stop()
			player.queue_free()
	playing_sfx.clear()
