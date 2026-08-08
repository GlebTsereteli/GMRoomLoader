# API Overview

## Overview

This section outlines the core GMRoomLoader APIs, organized into four main parts:
* :RoomLoader: is the central interface of the library, responsible for room :Data: handling, :Loading: and :Screenshotting:, :State: management, :Asset Type: and :Layer Name: filtering.
* :Payload: is returned from :RoomLoader.Load(): and is used to manage layer depths, retrieve loaded element IDs and clean up loaded contents.
* :Debug View: provides a quick way to test room loading through a :Debug Overlay: View.
* [Configuration](/pages/api/config) covers configuration macros for customizing various library behaviors.

## Syntax

All functionality in :RoomLoader: and :Payload: is exposed through public `PascalCase` methods. No public variables are available.

Most :State: and :Payload: methods chain together via the [Fluent Interface](https://en.wikipedia.org/wiki/Fluent_interface) pattern.

:::code-group
```js [Examples]
// Initialize a room's data
RoomLoader.DataInit(rmExample);

// Load a room and store the returned Payload
payload = RoomLoader.Load(rmExample, x, y);

// Load a room centered and rotated by chaining State methods
payload = RoomLoader.MiddleCenter().Angle(90).Load(rmExample, x, y);

// Retrieve a loaded element ID through the Payload
tilemap = payload.GetTilemap("Tiles");
```
:::

Private methods and variables use the `__` prefix and should only be accessed if you know exactly what you're doing.