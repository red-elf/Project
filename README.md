# Project

Brings Project capability for the particular context.

## How to use it?

Example of use:

```shell
sh "Project/open.sh" code "$PROJECT_PATH"
```

This example will open project at `$PROJECT_PATH` using the Visual Studio Code program. If pre-open script is available, it will be executed, Pre-open script is expected to be at: `Recipes/Project/project_pre_open.sh`

### Example of integration

The [HelixTrack project](https://github.com/Helix-Track/Core) incorporates the Project [Software-Toolkit](https://github.com/red-elf/Software-Toolkit) module. See the [open](https://github.com/Helix-Track/Core/blob/main/open) script for the reference and follow the implementation.

## Features supported

- Project open script (with program and project root directory parameters provided)
- Project open recipes (pre-open script).

## Dependency

Script depends on [Software-Toolkit's](https://github.com/red-elf/Software-Toolkit) get_progam.sh [script](https://github.com/red-elf/Software-Toolkit/blob/main/Utils/Sys/Programs/get_program.sh) and it expects to have it present in the hierarchy.
