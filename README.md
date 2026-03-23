# bad game ideas gj
https://itch.io/jam/bad-ideas-game-jam-2026

# TODO
- inaccessible barriers in rooms... like, the level layouts you have in tldraw n stuff
- Character animations ?
- better blockout textures ?
- Tile art, background art
- Intro act (big goal!)
- Frame buffer improvement: only count the last position on non-edge blocks. Use areas to indicate bad places of last-pos saving.
- leave the blockout esthetics? idfk
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
