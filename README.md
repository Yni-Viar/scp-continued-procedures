# SCP: Continued Procedures

## Requirements to build

The project uses Godot 4.6 as a base.

### Building regular version

1. Project->Export
2. Choose your platform (e.g. Windows/Linux/Android)
3. Navigate to Resource tab and type in "Filter to exclude files/folders": `*.glb, *.gltf, Assets/*.bin`

### Building lite version (for Web)
**In Lite version, some components are missing:**
There are no Entrance Sub-zone, SCP-178 (may be reinstated in later update), *SCP: Unity* SCP-173 model, SCP-266 (spawnable), SCP-938 (spawnable), SCP-914
1. Project->Export
2. Choose your platform (e.g. Web)
3. Navigate to Resource tab and type in "Filter to exclude files/folders": `*.glb, *.gltf, Assets/*.bin, */Optional/*`
4. Navigate to Features tab and type in "Custom (comma separated)": `Lite`

## About

Do your daily job at Site-[REDACTED].

Click/Tap - move/pick items (if you tap on character, they will go with you).

If Chaos Insurgency will raid your Site, call MTF using the button (in other times, the button won't work)

Included SCPs:

- SCP-023
- SCP-067
- SCP-162
- SCP-173 (only one variation in Lite version)
- SCP-178 (partially absent in Lite version)
- SCP-266 (do not spawn by default in Lite version since 5.8) (Lag issue)
- SCP-347
- SCP-446
- SCP-458
- SCP-522
- SCP-650
- SCP-686
- SCP-812
- SCP-914 (absent in Lite version)
- SCP-938 (do not spawn by default in Lite version)
- SCP-939

## Why this name?
- It is a recursive acronym - **S**CP: **C**ontinued **P**rocedures

### Notice about Android version
**The game will be incompatible with Google Android since 2026-2027, unless Google provides method for disabling verification for developers!** (*Xiaomi, Android forks and VR devices are probably not affected*)
Tutorial to install apps without Google verification coming soon

## License:
The game is based on SCP Foundation community.

[SCP Foundation community content are licensed under CC-BY-SA 3.0](https://scp-wiki.wikidot.com/licensing-guide)

The game is made in 2025 by Yni Viar.

This project is dual-licensed.

If you are using code for non-SCP usage, feel free to use under [MIT License](/LICENSE.MIT)

If you are using code for SCP Foundation usage or the project, which includes CC-BY-SA assets, use them under [GNU GPL 3 License](/LICENSE.GPL), as it is required by SCP Foundation / CC-BY-SA content usage.

## Contributing

You can:
- Report a bug.
- Suggest a new SCP object (before you suggest, see [suggestion rules](./SUGGESTING-IDEAS.md))
- Suggest an own model for replacement of existing one. (e.g own SCP-023 model instead of bad quality 3-rd party one, or own SCP-178-1 model).
- Suggest an own audio (SFX, music) for addition/replacement into the game