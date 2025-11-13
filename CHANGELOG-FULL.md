# SCP: Containing Procedures

This list contains all features, added in the game, or will be added in upcoming version, that is in development.
For plan, check [features changelog](./CHANGELOG-UPCOMING.md)

## v5.3.2 (2025.11.13)
- Make christmas lights have random color
- Add lightmap to Entrance zone.
- Add seasonal clutter to SCP-266 and Class-D containment chamber and unused testroom (both Halloween and Christmas ones)

## v5.3.1 (2025.11.11)
- Fixed testroom texture.
- Fixed SCP-914 position.
- Added Christmas decoration to SCP-162 chamber.
- Fixed a typo in RagdollManager.

## v5.3.0 - (? update, 2025.11.09)
### New SCP
- SCP-446
### ? changes
- Clutter system - finish Christmas decorations.
- Where did Octobergine Avo go?
- Added falling snow VFX for Christmas season, make rain VFX available on all regular seasons, except Halloween and Christmas.
### Bugfixes and other
- Added footstep sounds to Guard, Agent and Chaos Insurgent.
- Fixed hole in the wall in some Research Zone rooms. 

## v5.2.1 (2025.11.06)
- Fix duplicate item click. (this commit was made on Android editor 🙂)
- Fix crash when removing an invalid status effect (reproducible at 5.2.0 by using SCP-067 too fast).
- Add lore to SCP-067 + new mechanic to the game.

## v5.2.0 (2025.11.05)
### New SCP items
- SCP-067 + task
- SCP-178 (WANTED 3D MODEL FOR SCP-178-1)
### Cutscene system (used by SCP-067)
- Added cutscene and dialogue system
### Bugfixes and other
- Fixed possibility on crash by adding out-of-bound item id.
- Fixed documents falling through floor
- Fixed MTF error spam due to missing animation
- Bugfix: clicking on the item in the Inventory, click ALL the items...
- Implemented removing status effects
- Now you cannot enter Scientists' offices (again)


## v5.1.3 (Hotfix, 2025.11.02)
- Fix first-start crash (a regression from 5.0.0)
- \[Technical\] Update map generator to 9.1.1 to improve performance

## v5.1.2 (2025.10.30)
- Make walk and interact sound louder.
- Fixed SCP-173 not crunching + not playing a sound.

## v5.1.1 (2025.10.29)
- Fix Credits being too wide

## v5.1.0 (2025.10.29)
### New SCP items
- SCP-686 (3d model borrowed from pop_pop_icard, a family-friendly implementation)
- SCP-458
### Status effect system
- Add thirst and hunger indication
- Make Freeze effect in StaticPlayer a StatusEffect
- Status effect system
### Bugfixes and other
- Fix item duplication bug
- \[Technical\] Health system now uses that order: 0 - general health, 1 - cold, 2 - thirst, 3 - hunger meters. SCP-266 was modified to use new system.

## v5.0.2 (2025.10.22)

- Add Halloween props in SCP-162 and SCP-173 CC.
- Add second check on SeasonSwitcher
- Fix SCP-938 CC elevator lightmap brightness.

## v5.0.1 (2025.10.21)

- Fixed serious visibility bug on Surface Zone

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

## v4.3.0 (2025.08.23, **⚠️ Last version, that natively supports Windows 7-8.0!!!**)

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