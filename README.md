# A working system for building platformers, made during 'Bad Ideas Game Jam 2026'
[Jam link](https://itch.io/jam/bad-ideas-game-jam-2026)

# Features
- "Greyboxing" tilemaps with terrains for easy creation of level layouts.
- Two types of collision surfaces: one-ways for drop-down platforms and the regular "all-round" collisions.
- Pre-made level template for quick design: place the tiles, the spawn nodes, the (optional) killzones, the exit nodes. Specify the level id and save the level scene with an appropriate name, and the level will be integrated into your level list.
	- Don't forget to set the camera boundaries with two delegated nodes and the camera zoom level!
	- For the correct functionality of the minimap, add the 'docker' nodes which will 'dock' the levels on the minimap (decoupled from exits for level iteration convenience, but should generally be in the same place, right on the border of the camera boundary for the best look).
- Automatic save system, which saves the inventory and the last spawned location.
- Automatic respawns based on the last stable ground position

![Respawns](Presentation/respawn_montage.webp)
<p align=center><i>Respawning the player<br><br><br></i></p>

- Pre-made item pickup template with a pick-up animation. Don't forget to set the appropriate texture path and the name in the Pickups singleton!
- Auto-generating minimap! It takes the camera boundaries to set the rectangle size, and the scale is adjusted via the Settings singleton.
	- The minimap is generated once on start! The level tree, based on the aforementioned 'docker' nodes, is run through for that.
	- Then, it's just rendered from the resulting coordinates every time a render is asked for. It's centered on the room the player is in!
	- Of course, the non-visited rooms stay hidden

![Map](Presentation/map_montage.webp)
<p align=center><i>The minimap (press 'M' to open!)<br><br><br></i></p>

- Debug mode for checking some current values of variables, states, and even optionally playing in debug levels.
- Esc menu: To quit or not to quit?

# TODO
- force enable minimap via debug
- options menu?
- Frame buffer improvement: only count the last position on non-edge blocks. Use areas to indicate bad places of last-pos saving.
- maybe instead not spawn the items at all (see 'queuefreed' in specs below)

# Misc
- Jump speed allows for jumping horizontally over 9-ish tiles
- Jump height allows for jumping vertically just over 3 tiles
- N-times jump based upon whatever you specify. By default grows by 1 when you pick up the boots.
- Fixed a weird bug with an accidental wallslide when you fall through with crouching while against the wall (disabled 'block on wall'). This bug seems to be engine-side.
