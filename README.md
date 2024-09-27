# android-in-docker

## Description

Using this repo you can run an android emulator in docker with image displayed on your host X server.
Directories with tools and emulator state and settings are mounted as host directories.

## Usage

Create xauth file to authorize on your host X server:

```bash
xauth list >xauth
```

Run the container:

```bash
docker compose up
```
