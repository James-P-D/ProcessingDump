# GameOfLife
Implementation of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) in [Processing](https://processing.org/)

![Screenshot](https://github.com/James-P-D/GameOfLife/blob/master/screenshot.gif)

## Instructions

After loading, use the mouse to set some cells, or click again to clear them.

When you're ready, press <kbd>SPACE</kbd> to start the simulation, or <kbd>SPACE</kbd> again to pause it. When paused, you can toggle more cells using the mouse, or press <kbd>ESC</kbd> to clear all cells.

## Rules

1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overpopulation.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.