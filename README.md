# Project

Project capability for the particular context

## How to use it?

Example of use:

```shell
sh "Project/open.sh" code "$PROJECT_PATH"
```

This example will open project at `$PROJECT_PATH` using the Visual Studio Code program. If pre-open script is available, it will be executed, Pre-open script is expected to be at: `Recipes/project_pre_open.sh`

## Features supported

- Project open script (with program and project root directory parameters provided)
- Project open recipes (pre-open script).
