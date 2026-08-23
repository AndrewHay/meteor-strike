extends Control
class_name UI

func game_over():
	$GameLostScreen.visible = true
	$GameVictoryScreen.visible = false
