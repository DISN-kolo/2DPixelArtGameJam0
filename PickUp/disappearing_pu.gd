extends Node2D;

var pickup_id : int = 0;

func _ready() -> void:
	$DisappearingSprite.texture = load(Pickups.pickupSprites[pickup_id]);
	$DisappearingAP.play("disappearance");
