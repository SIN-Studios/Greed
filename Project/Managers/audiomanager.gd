extends Node

var playing_sfx: Array[AudioStreamPlayer] = []

# Added a 'force_unique' parameter to block duplicate sounds
func play_sfx(stream: AudioStream, force_unique: bool = false) -> void:
	if not stream: return
	
	# If unique is requested, see if this sound file path is already active
	if force_unique:
		for player in playing_sfx:
			if is_instance_valid(player) and player.stream.resource_path == stream.resource_path:
				return # Stop right here! A copy is already playing, so ignore this request.
	
	var player = AudioStreamPlayer.new()
	player.stream = stream
	add_child(player)
	player.play()
	
	playing_sfx.append(player)
	
	await player.finished
	if is_instance_valid(player):
		playing_sfx.erase(player)
		player.queue_free()


# Stops a specific sound effect if it is currently playing
# Stops a specific sound effect by checking its file path
func stop_sfx(stream: AudioStream) -> void:
	if not stream: return
	
	# Loop backwards to safely remove elements while iterating
	for i in range(playing_sfx.size() - 1, -1, -1):
		var player = playing_sfx[i]
		if is_instance_valid(player) and player.stream.resource_path == stream.resource_path:
			player.stop()
			player.queue_free()
			playing_sfx.remove_at(i)


# Stops ALL currently playing sound effects at once
func stop_all_sfx() -> void:
	for player in playing_sfx:
		if is_instance_valid(player):
			player.stop()
			player.queue_free()
	playing_sfx.clear()
