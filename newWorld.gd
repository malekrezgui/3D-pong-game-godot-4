extends Node3D

@onready var ball = $Ball
@onready var screen_size = get_viewport().size
#@onready var start_label=$StartLabel
@onready var player1 = $Player1
@onready var player2 =$Player2


var game_paused = true

func _physics_process(delta):
	pass

func _ready():
	ClientNetwork.connect("update_player_position", Callable(self, "_on_update_player_position"))
	$Camera3D.make_current()
	var light = DirectionalLight3D.new()
	light.light_color = Color(1, 1, 1) # White light
	add_child(light)
	
func setup():
	for k in ServerData.players.keys():
		if ServerData.players[k].side == 0:
			player1.set_ownership(ServerData.players[k].id)
		if ServerData.players[k].side == 1:
			player2.set_ownership(ServerData.players[k].id)
	
func _on_LeftWall_body_entered(body):
	ball.position =Vector2(100 ,screen_size.y/2)

func _on_RightWall_body_entered(body):
	ball.position =Vector2(screen_size.x - 100 ,screen_size.y/2)
	
func _on_update_player_position(player_id, position):
	print("6>>>  ",position)
	player1.sync_position(player_id, position)
	player2.sync_position(player_id, position)
