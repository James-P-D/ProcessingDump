// Conway's Game of Life
// Tested against Processing v3.5.3

/***********************************************************
 * Constants
 ***********************************************************/
static final int WINDOW_WIDTH = 1200;
static final int WINDOW_HEIGHT = 800;
static final int CELL_WIDTH = 40;
static final int CELL_HEIGHT = 40;
final color WHITE_COLOR = color(255, 255, 255);
final color BLACK_COLOR = color(0, 0, 0);

/***********************************************************
 * Global Variables (yuck!)
 ***********************************************************/
// 2D array for cells
boolean cells[][];

// Running flag. When turned off, we won't run the simulation
boolean running;
  
/***********************************************************
 * Setup. Set size, background, initialise global variables
 * etc.
 ***********************************************************/
void setup() 
{
  // If you change this, update WINDOW_WIDTH and WINDOW_HEIGHT
  // (No, we can't use non-literals for setting the size() in
  // Proccessing for some reason :(
  size(1200, 800);
  
  // Set framerate to eight frames per second
  frameRate(8);
  
  // Turn off stroke, so blocks do not have borders
  noStroke();
  
  // Set the background to white
  background(WHITE_COLOR);
    
  // Create the 2D array of cells
  cells = new boolean[WINDOW_WIDTH / CELL_WIDTH][WINDOW_HEIGHT / CELL_HEIGHT];
  
  // Clear all the cells
  clearAllCells();
  
  // Draw the initial board
  drawAllCells();
  
  // Finally, turn flag off
  running = false;
}

/***********************************************************
 * Main draw() method
 ***********************************************************/
void draw() 
{
  // Only update screen if running flag is on
  if(running)
  {
    // Create new board
    boolean newCells[][] = new boolean[WINDOW_WIDTH / CELL_WIDTH][WINDOW_HEIGHT / CELL_HEIGHT];
    
    for(int column = 0; column < WINDOW_WIDTH / CELL_WIDTH; column++)
    {
      for(int row = 0; row < WINDOW_HEIGHT / CELL_HEIGHT; row++)
      {
        // Create a counter for keeping track of neighbouring cells
        int liveNeighbours = 0;
            
        for(int neighbourColumn = column - 1; neighbourColumn <= column + 1; neighbourColumn++)
        {
          for(int neighbourRow = row - 1; neighbourRow <= row + 1; neighbourRow++)
          {
            // Only check the 8 cells around the current cell, ignore the current one
            if(!((neighbourColumn == column) && (neighbourRow == row)))
            {
              int wrappedNeighbourColumn = neighbourColumn;
              int wrappedNeighbourRow = neighbourRow;
            
              // Check for wrapping for neighbouring cells
              if (wrappedNeighbourColumn < 0)
              {
                wrappedNeighbourColumn = (WINDOW_WIDTH / CELL_WIDTH) - 1;
              }
              else if(wrappedNeighbourColumn >= (WINDOW_WIDTH / CELL_WIDTH))
              {
                wrappedNeighbourColumn = 0;
              }
              
              // Check for wrapping for neighbouring cells
              if (wrappedNeighbourRow < 0)
              {
                wrappedNeighbourRow = (WINDOW_HEIGHT / CELL_HEIGHT) - 1;
              }
              else if(wrappedNeighbourRow >= (WINDOW_HEIGHT / CELL_HEIGHT))
              {
                wrappedNeighbourRow = 0;
              }
              
              // Increment counter if we have found a neighbour cell that is set
              if(cells[wrappedNeighbourColumn][wrappedNeighbourRow])
              {
                liveNeighbours++;
              }
            }
            
            newCells[column][row] = cells[column][row];
            if(cells[column][row])
            {
              
              if(liveNeighbours < 2)
              {
                // Rule 1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
                newCells[column][row] = false; // NOT NEEDED! ALREADY FALSE
              }
              else if((liveNeighbours == 2) || (liveNeighbours == 3))
              {
                // Rule 2. Any live cell with two or three live neighbours lives on to the next generation.
                newCells[column][row] = true;
              }
              else if(liveNeighbours > 3)
              {
                // Rule 3. Any live cell with more than three live neighbours dies, as if by overpopulation.
                newCells[column][row] = false; // NOT NEEDED! ALREADY FALSE
              }
            }
            else
            {
              if(liveNeighbours == 3)
              {
                // Rule 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
                newCells[column][row] = true;
              }
            }
          }
        }
      }
    }
    
    for(int column = 0; column < WINDOW_WIDTH / CELL_WIDTH; column++)
    {
      for(int row = 0; row < WINDOW_HEIGHT / CELL_HEIGHT; row++)
      {
        // Update the cells that have changed
        if(cells[column][row] != newCells[column][row])
        {          
          drawCell(column, row, newCells[column][row]);
        }
      }
    }
    
    // Replace the board with our updated array of cells
    cells = newCells;    
  }
} 

/***********************************************************
 * clearAllCells() 
 ***********************************************************/
void clearAllCells()
{
  for(int column = 0; column < WINDOW_WIDTH / CELL_WIDTH; column++)
  {    
    for(int row = 0; row < WINDOW_HEIGHT / CELL_HEIGHT; row++)
    {
      cells[column][row] = false;
    }
  }
}

/***********************************************************
 * drawAllCells() 
 ***********************************************************/
void drawAllCells()
{
  for(int column = 0; column < WINDOW_WIDTH / CELL_WIDTH; column++)
  {
    for(int row = 0; row < WINDOW_HEIGHT / CELL_HEIGHT; row++)
    {
      drawCell(column, row, cells[column][row]);
    }
  }
 }

/***********************************************************
 * drawCell() 
 ***********************************************************/
void drawCell(int column, int row, boolean filled)
{
  if(filled)
  {
    fill(BLACK_COLOR);
  }
  else
  {
    fill(WHITE_COLOR);
  }
  
  rect(column * CELL_WIDTH,
       row * CELL_HEIGHT,
       CELL_WIDTH,
       CELL_HEIGHT);
}

/***********************************************************
 * mousePressed() 
 ***********************************************************/
void mousePressed() 
{
  // Only accept mouse presses if running flag is not set
  if(!running)
  {
    int column = mouseX / CELL_WIDTH;
    int row = mouseY / CELL_HEIGHT;
  
    cells[column][row] = !cells[column][row];
    drawCell(column, row, cells[column][row]);
  }
}

/***********************************************************
 * keyPressed() 
 ***********************************************************/
void keyPressed()
{
  // If <SPACE> key pressed, toggle the running flag
  if (key == 32) {
    running = !running;
  }
  else if (key == ESC)
  {
    if (!running)
    {
      // If <ESC> is pressed and we are not running, clear the board
      clearAllCells();
      drawAllCells();
    }
    
    // Clear the current key-press, or ESC will quit!
    key = 0;
  }
}
