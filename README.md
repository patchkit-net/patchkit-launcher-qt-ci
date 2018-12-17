# patchkit-launcher-qt-ci
CI scripts and configurations for building patchkit-launcher-qt

## Linux

### Requirements

- Docker

### Building

1. Prepare container from Dockerfile (only once)
2. Execute `build.sh` inside container
3. Output will be stored inside container, at `/patchkit-launcher-qt_bin`

## OSX Requirements

### Requirements

- Git
- Command Line Tools (or XCode)
- XQuartz\*
- `homebrew install pkg-config`\*

\* - those requirements are listed because they were present on machine used for creating this guide. Please try to use scripts without them, and if there will be no errors, just remove them from this list.

### Building

1. `configure.sh <where environment should be configured> <number of processes used for compiling>` (only once)
2. `build.sh <where environment was configured> <build target version>`
3. Output will be stored at environment path, inside `patchkit-launcher-qt_bin`.

## Windows

### Requirements

- MSVC 14.0
- Git

### Building

### Before anything
`clone_repositories.bat <where environment should be configured>`

#### 32-bit

1. `configure_x86.bat <where environment should be configured> <path to MSVC 14.0>` (only once)
2. `build_x86.bat <where environment was configured> <path to MSVC 14.0> <build target version>`
3. Output will be stored at environment path, inside `patchkit-launcher-qt_x86_bin`.

#### 64-bit

1. `configure_x64.bat <where environment should be configured> <path to MSVC 14.0>` (only once)
2. `build_x64.bat <where environment was configured> <path to MSVC 14.0> <build target version>`
3. Output will be stored at environment path, inside `patchkit-launcher-qt_x64_bin`.