# SCP: Continued Procedures

## Requirements to build

The project uses Godot 4.5.2-rc1 as a base.
Earlier Godot version (such as 4.4) are not supported anymore since v5.9

### Building regular version

1. Project->Export
2. Choose your platform (e.g. Windows/Linux/Android)
3. Navigate to Resource tab and type in "Filter to exclude files/folders": `*.glb, *.gltf, Assets/*.bin`

### Building lite version (for Web)
**In Lite version, some components are missing:**
There are no Entrance Sub-zone, SCP-178 (may be reinstated in later update), *SCP: Unity* SCP-173 model, SCP-266 (spawnable), SCP-347 (spawnable), SCP-791, SCP-938 (spawnable), SCP-914 (may be reinstated in later update)
1. Project->Export
2. Choose your platform (e.g. Web)
3. Navigate to Resource tab and type in "Filter to exclude files/folders": `*.glb, *.gltf, Assets/*.bin, */Optional/*`
4. Navigate to Features tab and type in "Custom (comma separated)": `Lite`

## About

Do your daily job at Site-[REDACTED].

Click/Tap - move/pick items (if you tap on character, they will go with you).

If Chaos Insurgency will raid your Site, call MTF using the button (in other times, the button won't work)

Included SCPs:

| SCP# | Full | Lite/Web version |
|------|------|------------------|
|SCP-023|✅, since 3.0.0|✅, since 5.7.0|
|SCP-067|✅, since 5.2.0|✅, since 5.7.0|
|SCP-162|✅, since 1.0.0|✅, since 5.8.0|
|SCP-173|✅, since 1.0.0|Partial, since 5.7.0|
|SCP-178|✅, since 5.2.0|❌, 3d help wanted|
|SCP-249|✅, since 6.0.0|✅, since 6.0.0|
|SCP-266|✅, since 1.0.0|❌, 5.7.x only, removed in 5.8.0 due to lag|
|SCP-347|✅, since 1.0.0|❌, 5.7.x-5.8.x only, removed in 6.0.0 due to lag|
|SCP-446|✅, since 5.3.0|✅, since 5.7.0|
|SCP-458|✅, since 5.1.0|✅, since 5.7.0|
|SCP-522|✅, since 5.8.0|✅, since 5.8.0|
|SCP-649|⛄, since 5.5.0|⛄, since 5.7.0|
|SCP-650|✅, since 1.0.0|✅, since 5.7.0|
|SCP-686|✅, since 1.0.0|✅, since 5.7.0|
|SCP-791|✅, since 6.0.0|❌|
|SCP-812|✅, since 1.0.0|✅, since 5.7.0|
|SCP-914|✅, since 2.0.0|❌, 5.7.x only, removed in 5.8.0 due to lag, probably will return in future|
|SCP-938|✅, since 5.0.0|❌|
|SCP-939|✅, since 5.5.0|✅, since 5.8.0|

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