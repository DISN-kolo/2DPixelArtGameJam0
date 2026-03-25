extends Node

var debugmode : bool = true;
var startlevelpath : String = "";
var debuglevelpath : String = "";
var cameramovement : bool = false;

var minimap_scale: float = 24.0;

## In a bizarre twist of fate, Y points downwards.
var gravity : float = 40.0;
var terminal_velocity : float = 1500.0;
