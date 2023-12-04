extends Node2D

		
func _physics_process(delta):
	if Game.playerHP == 2:
		$"life 1".hide()
	elif Game.playerHP == 1:
		$"life 1".hide()
		$"life 2".hide()
	if Game.playerHP == 0:
		get_tree().reload_current_scene()
