# Troubleshooting

Solutions to problems that come up often. Most of them trace back to how loaded room contents interact with the host room they're loaded into.

## Nothing Shows Up

:::danger PROBLEM
You load a room, but some or all of the loaded elements are not visible.
:::

By default, GMRoomLoader creates layers at the exact depths assigned in the Room Editor.

If your host room has existing layers, loaded layers can end up behind them and get covered, landing behind a background or some other fully covering layer.

This is by far the most common issue people run into when first setting up the library, and we have a few ways to solve it.

---

### Sort Layers Manually

Set up your host room and loaded room layers so depths coexist properly. Some go above, others below.

This works, but it's the most tedious option. When working at scale, you'll have to cross-reference depths across many layers spread between multiple rooms, and constantly keep them in sync.

### Shift Depths

Layer depths are adjustable and you're never stuck with the depths from the loaded room.

Use the :Payload: methods for [depth shifting](/pages/api/payload/depth) to move all loaded layers in front of or behind a target layer or depth.

### Merge Layers

Set the :ROOMLOADER_MERGE_LAYERS: config macro to `true` to merge loaded layers into existing host room layers with matching names instead of creating new ones.

Loaded elements then inherit the depth of the host layer they merge into, so you control placement through your existing layers.

::: tip NOTE
Merged (reused) layers will not be tracked by :Payload: and won't be destroyed on :Cleanup:.
:::

## Everything Turns Black

:::danger PROBLEM
You load a room and part or all of the screen gets covered by a solid black rectangle.
:::

That's a background layer with a solid fill color. GameMaker rooms have one by default, and loading recreates its fill in your host room, where depth can leave it covering everything.

It's usually a default leftover or an editing backdrop, so you typically don't want to load it in.

---

### Remove Background

The simplest, most common fix is to delete the background layer or hide it in the room you're loading.

### Keep Background

If you have a special case where the background is needed in the loaded room while editing (and you don't want to bother hiding it), keep it there and skip it at load time instead.

Use :Asset Type Filtering: and skip all backgrounds by leaving :ROOMLOADER_FLAG_BACKGROUNDS: out of your load flags:

:::code-group
```js [Pick Flags]
// List the asset types you want, leaving out backgrounds
RoomLoader
.Flags(ROOMLOADER_FLAG_INSTANCES | ROOMLOADER_FLAG_TILEMAPS) // [!code highlight]
.Load(rmLevel, x, y);
```
```js [Remove From All]
// Start from everything and strip out backgrounds
payload = RoomLoader
.Flags(ROOMLOADER_FLAG_ALL & ~ROOMLOADER_FLAG_BACKGROUNDS) // [!code highlight]
.Load(rmLevel, x, y);
```
:::

Or exclude specific background layers by name using Blacklisting from :Layer Name Filtering:, leaving other backgrounds intact:

```js
// Blacklist the "Background" layer to ignore it
payload = RoomLoader.LayerBlacklistAdd("Background").Load(rmLevel, x, y); // [!code highlight]

// Blacklist doesn't reset automatically after loading
RoomLoader.LayerBlacklistReset();
```

## Tilemaps Don't Collide

:::danger PROBLEM
You load a room with a tile layer and your collision checks miss it.
:::

A new tilemap gets created on load, and your code is still checking a different tilemap ID.

There are two ways to handle collision with loaded tilemaps, depending on whether you keep them separate or merge them into an existing tilemap.

---

### Separate Tilemaps

If :ROOMLOADER_MERGE_LAYERS: and :ROOMLOADER_MERGE_TILEMAPS: are set to `false`, a new tilemap is created for every Tile layer in the loaded room.

To collide with this newly created tilemap, you need to grab its ID and store it in some variable. If you're currently colliding with, say, a variable holding a tilemap ID, you'll need to change that to a dynamic setup using an array.

::: code-group
```js [Example]
// In some script, initialize a global array of collision tilemaps
global.collisionTilemaps = [];

// On Room Start (or somewhere else, if relevant), fetch your baseline collision tilemap ID
global.collisionTilemaps = [layer_tilemap_get_id("CollisionTilemap")];

// Use the tilemaps array in your collision code (rough example)
if (place_meeting(x + speedX, y, global.collisionTilemaps)) {
    // ...
}

// When loading a room, grab the collision tilemap ID and push it to the global collision tilemaps array
payload = RoomLoader.Load(rmExample, x, y);
collisionTilemap = payload.GetTilemap("CollisionTilemap"); // [!code highlight]
array_push(global.collisionTilemaps, collisionTilemap);

// When unloading a room, remove the collision tilemap from the global collision tilemaps array
var _index = array_get_index(global.collisionTilemaps, collisionTilemap);
array_delete(global.collisionTilemaps, _index, 1);
payload.Cleanup();
```
:::

### One Merged Tilemap

Alternatively, you can make use of :ROOMLOADER_MERGE_LAYERS: and :ROOMLOADER_MERGE_TILEMAPS: to merge loaded tilemaps into existing ones.

That way you don't need to juggle multiple tilemap IDs and can keep using a single tilemap for collision, auto-tiling or any other needs where having a single tilemap is preferable.

## Variable Definitions Crash

:::danger PROBLEM
You try loading a room with instances that have custom values in their Variable Definitions and the game crashes with an error similar to this:
```
Variable struct.image_number(30, -2147483648) not set before reading it.
at gml_RoomCC_rmStartingCave2_1_PreCreate (line 2) - self.startingIndex=image_number - 1;
```
:::

Your Variable Definitions reference [built-in instance variables](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/Instance_Variables.htm) like `x`, `y` or `image_number`.

GMRoomLoader bakes modified Variable Definitions into a pre-Create struct that's passed to the instance when it's created. That happens **before the instance exists**, so none of its built-in variables are available at that point.

::: tip NOTE
This only affects Variable Definitions you've modified in the room editor. Unmodified defaults aren't loaded by GMRoomLoader and initialize normally, so built-in variables are safe to use there.
:::

---

### Resolve In Create

Keep the variable at a safe default like `undefined` and resolve it in the Create event.

### Use Creation Code

Move the logic to Instance Creation Code. Keep in mind that it runs *after* the Create event.

This is only really needed if you want per-instance overrides in the room editor. Otherwise the Create event solution above is most likely enough.

## Recursive Loading Crash

:::danger PROBLEM
You load a room and get a crash saying `PerformEvent recursion depth failure...` error, with a huge stack trace repeating your load call over and over.
:::

The object doing the loading is placed inside the room it loads.

Loading the room creates a copy of that object, which runs its own load call, which creates another copy, and so on until GameMaker gives up.

:::tip NESTING IS FINE
This doesn't mean loaded rooms can never contain objects that load other rooms.

That's perfectly fine as long as they load different rooms and the chain eventually terminates instead of looping back on itself.
:::

---

### Move The Loader

To avoid this entirely, don't place objects that load rooms into any loaded rooms.

Keep your controller in the host room, or make it persistent and create it elsewhere. Make sure it loads rooms that only contain level content.

### Filter The Loader

If the object needs to stay in the room for any reason, exclude it at load time by putting it on its own layer and blacklisting that layer via :Layer Name Filtering::

```js
RoomLoader.LayerBlacklistAdd("Control").Load(rmLevel, x, y); // [!code highlight]

// Blacklist doesn't reset automatically after loading
RoomLoader.LayerBlacklistReset();
```

## Still Stuck?

If none of the above covers what you're running into, check the [FAQ](/pages/help/faq) for anything your question might touch on, then head to [Contact & Support](/pages/help/contactSupport) to ask directly or report a bug.