# Integer Resolution Handler

This addon is a complete runtime script for handling integer resolutions for pixel-perfect 2D games.

## Usage

1. Enable the plugin. Close Project Settings.
2. Navigate Project Settings to the `display/window` category.
3. In the new section "Integer Resolution Handler", set Base Width and Base Height to your game's native pixel resolution.

The IntegerResolutionHandler also works with all of the existing `stretch` settings, so fiddle there if you don't like how it behaves. Notably, setting `stretch/aspect` to "Keep" will enforce strict screen resolutions, while "Expand" will allow the viewable area to nearly double between scale steps.

