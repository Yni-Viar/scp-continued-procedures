# SCP: Containing Procedures

## Long-term plan (new versions will have different codebase, this plan will contain only 5.x.x changes)

### 5.x.x plan
- [ ] Add generator task (hello Unstable Dimensions) (maybe scrap this?)
- [ ] SCP-178 (3d model is ready)
- [ ] SCP-458 (probably will be implemented in 5.1)
- [ ] Clutter system - finish Christmas decorations. (probably for 5.1)

## v5.1.0
- [ ] SCP-686 (3d model borrowed from pop_pop_icard, probably will be implemented in 5.1)

## v5.0.0 (Expansion update part 2, 2025.10.21)
### New SCP - SCP-938 with Containment Sublevel
- Lantern item
### New features
- Added clutter system + Halloween (and partly Christmas) decorations
- Expose Gate A
- Add ragdolls to humans (except SCP-347 and Site Director)
- Surface Zone for Gate B and C (SZ and elevators are borrowed from pop_pop_icard).
- Expose Gate B
- CB-styled doors (for elevators)
- Remake Gate C room
- Camera Rework: Enable hotkeys for moving - looks like, that camera rotation is not so easy.
- Camera Rework: Add Third-person view + toggle API and remove scroll zoom
- Keybind settings (FINALLY DONE!!!)
- Add "real" weapon to Mobile Task Force, Agents and Chaos Insurgency
- Rework item usage to a safe method caller
- Add hunger and thirst HP layers to humans (currently unused)
- Add props to Class-D room
- Add Settings to Main Menu
- Apply Glow and ReflectionProbe for all platforms (previously, Web and Android platforms had this setting disabled)
- Moved to POT translation file instead of CSV, making translation to other languages easier.
- Added special interact support for NPC ~~(you can see this new system with SCP-023 - click on it to repair it's eyes).~~ Also removed `automatic` flag.
- Moved Inventory to Puppet from Game UI - separated inventories are good for future multiplayer
- SCP-109 and 983 Containment Chamber (Instead of regular Testroom)
- Upgrade to Godot 4.5, and thus remove Windows 7/8.0 support (see https://yniviar.neocities.org/blog_september-2025-news)
### General fixes and small enhancements
- Added fake loading screen.
- Inventory button is now hidden, if there is no touchscreen (click Tab buttton to open your inventory)
- Add debug console
- Better organize Main Menu
- Add more Scientists spawns in Research Zone
- Enable SCP-023 in Safe mode (through it will just walk around).
- You cannot enter WC now (because of possible *strange situations*)
- Removed old lighting hack from non-lightmap era.
- Removed time scale after finish game
- Fixed situation, where NPCs following player, that went to SCP-162, were playing "walk" animation, while stay.

## v4.3.0 **(⚠️ Last version, that natively supports Windows 7-8.0!!!)**

- Added WC rooms for Maintenance and Research zones.
- Returned fully-functional SCP-109 - it can be used as healing item, due to new API. ~~Use the cube in SCP-914 to make it with 33% chance.~~
- Changed texture to Research Zone ceiling (except 914 room).

## v4.2.0 (2025.08.20)
- Improve Maintenance Zone graphics.

## v4.1.0 (2025.08.19)
- Add omnidot plush to Yni Viar's room
- Remove omnidot plush from items and replace with Knitted sphere
- Reduce amount of Scientist to match personnel offices amount.
- Add new SCP Cage prop (my model, that was reused from SCP: Site Online) - spawns on Gates A and B.
- Added more light to SCP-914 room - because SCP-914 was too dark.

## v4.0.0 (Expansion update part 1, 2025.08.18)
- Elevator support
- New sublevel (Entrance subzone) with researcher's offices and exit to new Research Zone room
- Added scriptable researcher's offices + add Yni office (with returned Internal Eternal easter egg)
- Added Site Director Octobergine Avo + office.
- Changed protagonist's spawn point.
- Moved SCP-347 task to Maintenance Zone Gate B.
- Main Menu UI refresh
- Fixed annoying bug on Android, when if you rotate screen, player began to move. (FINALLY!!!)
- Added new human class - Agent. (currently looks like SCP: Unity guard)
- Fixed navigation mesh connection between rooms
- Added second SCP-173 variation - the model will be randomly selected at the round start (between original and SCP:Unity model)
- Added new Main Menu theme.
- Improved Research Zone graphics.

## v3.1.0 (2025.08.02)

- Removed SCP:SL pre-14.0 rooms entirely because of licensing issues.
- Added a tint to Credits screen

## v3.0.0 (2025.08.01)

- Reworked existing Maintenance zone (room3_pit will be temporarily removed)
- Added modified SCP: SL pre-14.0 rooms as an easter egg for Maintenance Zone. (removed in 3.1.0 because of licensing issues)
- Reduced human classes and SCP-347 size to fit into a new Maintenance Zone
- Really added an ability to disable music
- SCP-023 containment chamber in Maintenance Zone (both regular and SL version (latter was removed in 3.1.0 because of licensing issues))
- SCP-023 NPC + task.
- Added disarmer for SCP-914 craft (unusable, need to refine cube on Very Fine).

## v2.0.2 (2025.07.23)

- Updated Credits list.

## v2.0.1 (2025.07.22)

- Increase optimization on Android by reducing visible area
- Scientists at SCP-650 containment chamber now have IK disabled (previously they looked strange)
- You cannot pick-to-follow MTFs, Chaos Insurgency, hostile SCPs and scientists at SCP-650 chamber
- Labels at checkpoints are supporting translations!
- Made color of SCP-812 waterfall more realistic
- Tried to fix bug, where Chaos Insurgency event was not called if there was SCP-347 MTF task.
- Disabled Glow and Reflection probe on all of Android

## v2.0.0 (2025.07.21)

- SCP-914 and new tasks.
- Various items
- Maintenance zone re-introduction (previously being hidden in 1.0.0 files)
- Checkpoints between zones.
- Items and NPC are now picked by ShapeCast
- Removed Internal Eternal easter egg - since Internal Eternal Demo 1 already includes this toy.
- ~~Added ability to disable music~~ Was not working until 3.0.0, because only button toggle was implemented.

## v1.0.0 (2025.06.09)
- Android support
- SCP-162
- SCP-173
- SCP-266
- SCP-347
- SCP-650
- SCP-812
- Foundation tasks and gameover
- Chaos Insurgency event, MTF call + exit