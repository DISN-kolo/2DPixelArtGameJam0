extends Node2D;

@export var pickup_id : Pickups.PickupableID;

func _ready() -> void:
	if (pickup_id in PlayerMetrics.has_items):
		queue_free();
	$PUSprite.texture = load(Pickups.pickupSprites[pickup_id]);
