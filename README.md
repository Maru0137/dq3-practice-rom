# DQ3 Practice ROM
This is a modification of SFC Dragon Quest III for practicing the speedrun.

## How to patch
### 1. Prepare ROM
Place the rom as `rom/DragonQuest3.smc`.

### 2. Apply the patch by cmake
```sh
cmake -B build
cmake --build build
```

After build, you can get patched rom from `build/src/DragonQuest3.smc`.
