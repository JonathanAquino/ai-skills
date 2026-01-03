---
name: glb-to-stl
description: Convert .glb files (from Meta 3D SAM) to .stl for 3D printing in Bambu Studio.
---

To convert a `.glb` file (output from Meta 3D SAM) to `.stl` (for import into Bambu Studio for 3D printing), run:

```bash
assimp export <input_file>.glb <output_file>.stl
```

Example:

```bash
assimp export model.glb model.stl
```
