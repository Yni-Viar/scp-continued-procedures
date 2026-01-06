# SCP: Containment Procedures (Reborn)

## Requirements to build

**It is strongly recommended to use [custom build of Godot engine 4.5.1](https://github.com/Yni-Viar/godot/releases/tag/4.5.1-stable-patch), because of various security issues**, but it is possible to build with regular Godot 4.5.1.

### Building regular version

1. Project->Export
2. Choose your platform (e.g. Windows/Linux/Android)
3. Navigate to Resource tab and type in "Filter to exclude files/folders": `*.glb, *.gltf, Assets/*.bin`

### Building lite version (for Web)

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
- SCP-173
- SCP-178
- SCP-266
- SCP-347
- SCP-446
- SCP-458
- SCP-650
- SCP-686
- SCP-812
- SCP-914
- SCP-938
- SCP-939

## Why this name?
- It is a recursive acronym - **S**CP: **C**ontainment **P**rocedures

### Notice about Android version
**The game will be incompatible with Google Android since 2026-2027, unless Google provides method for disabling verification for developers!** (*Xiaomi, Android forks and VR devices are probably not affected*)
Tutorial to install apps without Google verification coming soon

## License:
The game is based on SCP Foundation community.

[SCP Foundation community content are licensed under CC-BY-SA 3.0](https://scp-wiki.wikidot.com/licensing-guide)

The game is made in 2025 by Yni Viar.

This project is dual-licensed.

If you are using code for non-SCP usage, feel free to use under [MIT License](/LICENSE.MIT)

If you are using code for SCP Foundation usage or the project includes CC-BY-SA assets, use them under [GNU GPL 3 License](/LICENSE.GPL), as it is required by SCP Foundation / CC-BY-SA content usage.

## Contributing

You can:
- Report a bug.
- Suggest a new SCP object (before you suggest, see [suggestion rules](./SUGGESTING-IDEAS.md))
- Suggest an own model for replacement of existing one. (e.g own SCP-023 model instead of bad quality 3-rd party one).
- Suggest an own audio (SFX, music) for addition/replacement into the game