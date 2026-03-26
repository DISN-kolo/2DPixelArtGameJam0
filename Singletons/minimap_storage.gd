extends Node;

##Minimap's level blocks' positions. Key = id of level. Maybe, should all be relative to level0?
var level_pos_s: Dictionary[int, Vector2] = {};
##Minimap's docker blocks' positions, RELATIVE. Key = id of level, and then id of docker.
var docker_pos_s: Dictionary[int, Array] = {};
##Docker info: [0] = connects to which level id?, [1] = corresponds to what docker id?
##Key = id of level, and then id of docker.
var dockers_info: Dictionary[int, Array] = {};
##Top-left corners of levels.
var tl_s: Dictionary[int, Vector2] = {};
