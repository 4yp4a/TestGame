extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var speed = 50
@onready var anim = $AnimatedSprite2D
var alive = true
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var player = $"../../player/Player"
	var direction = (player.position - self.position).normalized()
	if alive == true:
		if chase == true:
			print("true")
			velocity.x = direction.x * speed
			anim.play("run")
			if direction.x < 0:
				anim.flip_h = true
			else:
				anim.flip_h = false
		else:
			velocity.x = 0
			anim.play("idle")
	move_and_slide()


func _on_detector_body_entered(body):
	if body.name == "Player":
		print("tru1")
		chase = true

func _on_detector_body_exited(body):
		if body.name == "Player":
			chase = false


func _on_death_body_entered(body):
	if body.name == "Player":
		body.velocity.y -=  400
		death()
		
func _on_hit_body_entered(body):
	if body.name == "Player":
		body.health -= 2
		death()
func death():
	$hit/CollisionShape2D.queue_free()
	$death/CollisionShape2D.queue_free()
	alive = false
	anim.play("dead")
	await anim.animation_finished
	queue_free()


	
