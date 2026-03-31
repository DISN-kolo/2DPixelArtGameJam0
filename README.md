# bad game ideas gj
https://itch.io/jam/bad-ideas-game-jam-2026

# Features
- "Greyboxing" tilemaps with terrains for easy creation of level layouts.
- Two types of collision surfaces: one-ways for drop-down platforms and the regular "all-round" collisions.
- Pre-made level template for quick design: place the tiles, the spawn nodes, the killzones, the exit nodes, and the level will be integrated into your level list.
	- Don't forget to set the camera boundaries with two appropriate nodes and the camera zoom level!
	- For the sake of the minimap, add the 'docker' nodes which will 'dock' the levels on the minimap (decoupled from exits for level iteration convenience, but should generally be in the same place, right on the border of the camera boundary).
- Automatic save system, which saves the inventory and the last spawned location.
- Pre-made item pickup template with a pick-up animation. Don't forget to set the appropriate texture path and the name in the Pickups singleton!
- Auto-generating minimap! It takes the camera boundaries to set the rectangle size, and the scale is adjusted via the Settings singleton.
	- The minimap is generated once on start! The level tree, based on the aforementioned 'docker' nodes, is run through for that.
	- Then, it's just rendered from the resulting coordinates every time a render is asked for. It's centered on the room the player is in!
	- Of course, the non-visited rooms stay hidden
- Debug mode for checking some current values of variables, states, and even optionally playing in debug levels.

# TODO
- proper esc menu
- Frame buffer improvement: only count the last position on non-edge blocks. Use areas to indicate bad places of last-pos saving.
- maybe instead not spawn the items at all (see 'queuefreed' in specs below)

# Some specs
- Jump speed allows for jumping horizontally over 9-ish tiles
- Jump height allows for jumping vertically just over 3 tiles
- N-times jump based upon whatever you specify. By default grows by 2 when you pick up the boots
- Levels from base level, connectable by exit nodes and spawn nodes (please do match the ids in the names) (quite intuitive, really)
- Primitive killzone + respawn implementation. Uses a "frame buffer" that is prety wacky but works.
- Camera border setting by two handles from the base level
- Multilayer tilesets to support one-way and normal collisions at once.
- Fixed a weird bug with an accidental wallslide when you fall through with crouching while against the wall (disabled 'block on wall'). This bug seems to be engine-side.
- camera inertia and lookahead. but it's commented out for the moment cause it's a bit nauseating
- (one slot) save load system, primitive main menu
- if item is already in inventory it gets queuefreed after spawning.

# misc notes
- maybe the exit area node thing would work with exporting a collision shape instead of a shape

# TODOs that'd be too out of scope for this, but fun to think about
- Levels need to be positioned somehow. Level graph is required.
Maybe it's gonna be useful to make it as a scene that's only accissble from the editor, in order to position levels n stuff.
Furthermore, this sounds like a plan for a tool creation!
