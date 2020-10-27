# Integer Resolution Handler

Alternative stretch handler for low resolution (pixel art) games in high resolution windows. Restricts the game resolution to integer steps, keeping pixels square.

## Usage

1. Enable the plugin. Close Project Settings.
2. Navigate Project Settings to the `display/window` category.
3. In the new section "Integer Resolution Handler", set Base Width and Base Height to your game's native pixel resolution.

The IntegerResolutionHandler also works with all of the existing `stretch` settings, so fiddle there if you don't like how it behaves. Notably, setting `stretch/aspect` to "Keep" will enforce strict screen resolutions, while "Expand" will allow the viewable area to extend dramatically in all directions between scale steps.

If you set Base Width and Base Height to a 4:3 aspect ratio and use the "Keep Height" or "Expand" aspect handling modes, your game will extend horizontally to support widescreen aspects as well. Just make sure your game is fully playable at its base resolution and GUI elements properly stretch and move, the same as you would for a non-pixel art game.
