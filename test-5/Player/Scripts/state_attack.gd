class_name State_Attack extends State

var attacking : bool = false

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"


## What happens when the player enters this State?
func Enter() -> void :
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect( EndAttack )
	attacking = true
	pass 


## What happens when the players exits this State?
func Exit() -> void:
	if animation_player.animation_finished.is_connected( EndAttack ):
		animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	pass


## What happens during the process of this State?
func Process( _delta : float ) -> State :
	player.velocity = Vector2.ZERO
	
	if attacking == false :
		if player.direction == Vector2.ZERO :
			return idle
	else : 
		return walk
	return null 


## What happens during the physics process of this State?
func Physics( _delta : float ) -> State :
	return null



## What happens with input events in this State?
func HandleInput( _event : InputEvent ) -> State :
	return null


func EndAttack( _newAnimName : String ) -> void:
	attacking = false
