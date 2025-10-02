# SCP: Containing Procedures

## Long-term plan
### Undetermined
- [ ] SCP-001 (by shaggydredlocks) event
- [ ] SCP-003
- [ ] SCP-104
- [ ] SCP-323
- [ ] SCP-432 (with dimension)
- [ ] SCP-647
- [ ] SCP-813
- [ ] SCP-864 (probably, latest Nalka version, with dimension)
- [ ] SCP-939 (3d model borrowed from SCP: Unity, blocked until 2026-07-01 because of popular SCP restriction)
- [ ] SCP-2028 (blocked until 2026-01-01 because of 4-digit-SCP restriction)
- [ ] SCP-2471 (3d model borrowed from AmbientCG, blocked until 2026-01-01 because of 4-digit-SCP restriction)
- [ ] Multiplayer (Research or Survival mode)
- [ ] Add generator task (hello Unstable Dimensions)
- [ ] Add female models for D-Class, Scientists and Guards (since 4.0, there is a female Site Director)
### v6.0.0 plan
- [ ] SCP-178 (3d model is ready)
- [ ] Survival mode
- [ ] Hunger and thirst system for survival mode (implement this for ~~109 and ~~458) (in progress, began in 5.0)
### v5.1.0 plan
- [ ] SCP-458 (probably will be implemented in 5.1)
- [ ] SCP-686 (3d model borrowed from pop_pop_icard, probably will be implemented in 5.1)

## v5.0.0 (Expansion update part 2, release may be soon, if I finish the story) 
- [x] Enable SCP-023 in Safe mode (through it will just walk around).
- [x] Camera Rework: Enable hotkeys for moving - looks like, that camera rotation is not so easy.
- [x] Camera Rework: Add Third-person view + toggle API and remove scroll zoom
- [x] Keybind settings (FINALLY DONE!!!)
- [x] You cannot enter WC now (because of possible *strange situations*)
- [x] Removed old lighting hack from non-lightmap era.
- [ ] Move Casual mode as story, rename Story mode button as Play.
- [ ] Story mode: lore (in progress)
- [ ] Story mode: Pre-configured round mechanic
- [ ] Story mode: Custom "escape" scenario - finish task.
- [ ] Expose Gate A, B and C + Surface Zone for Gate B and C (Gate C need to be re-made from scratch) (in progress, SZ will be borrowed from pop_pop_icard).
- [x] Add "real" weapon to Mobile Task Force, Agents and Chaos Insurgency
- [ ] Add ragdolls
- [ ] Add debug console (in progress)
- [x] Rework item usage to a safe method caller
- [x] Add hunger and thirst HP layers to humans
- [x] Removed time scale after finish game
- [x] Fixed situation, where NPCs following player, that went to SCP-162, were playing "walk" animation, while stay.
- [x] Improve finish game screen/gameover - make it full-screen + graphics
- [x] Add props to Class-D room
- [x] Add Settings to Main Menu
- [x] Apply Glow and ReflectionProbe for all platforms (previously, Web and Android platforms had this setting disabled)
- [x] SCP-938: VFX
- [x] SCP-938: Puppet Logic
- [ ] SCP-938: Task (fix bug, when task appears in impossible condition)
- [x] SCP-938: Containment Sublevel + Lantern item
- [x] Moved to POT translation file instead of CSV, making translation to other languages easier.
- [x] Added special interact support for NPC ~~(you can see this new system with SCP-023 - click on it to repair it's eyes).~~ Also removed `automatic` flag.
- [x] Moved Inventory to Puppet from Game UI - separated inventories are good for future multiplayer
- [x] SCP-109 and 983 Containment Chamber (Instead of regular Testroom)
- [x] Upgrade to Godot 4.5, and thus remove Windows 7/8.0 support (see https://yniviar.neocities[.]org/blog_september-2025-news, remove [])

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