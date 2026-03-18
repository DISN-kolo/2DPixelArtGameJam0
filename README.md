# 2DPixelArtGameJam0
https://itch.io/jam/2d-pixel-art-game-jam

# TODO
- Saves :)
	- Completed rooms, accessible rooms, inaccessible barriers in rooms...
- Character animations
- Tile art, background art
- Intro act (big goal!)
- Frame buffer improvement: only count the last position on non-edge blocks. Use areas to indicate bad places of last-pos saving.

# Some specs
- Jump height allows for jumping just over 3 tiles
- N-times jump based upon whatever you specify. By default grows by 2 when you pick up the boots
- Levels from base level, connectable by exit nodes and spawn nodes (please do match the ids in the names) (quite intuitive, really)
- Primitive killzone + respawn implementation. Uses a "frame buffer" that is prety wacky but works.
- Camera border setting by two handles from the base level
- Multilayer tilesets to support one-way and normal collisions at once.
- Fixed a weird bug with an accidental wallslide when you fall through with crouching while against the wall. This is maybe not a very good fix. This bug seems to be engine-side.
- camera inertia and lookahea. but it's commented out.

# misc notes
- maybe the exit area node thing would work with exporting a collision shape instead of a shape

# TODOs that'd be too out of scope for this, but fun to think about
- Levels need to be positioned somehow. Level graph is required.
Maybe it's gonna be useful to make it as a scene that's only accissble from the editor, in order to position levels n stuff.
Furthermore, this sounds like a plan for a tool creation!
