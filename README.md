# Procedural Terminal Maze Generator with Dynamic Pathfinding Algorithms in C

A C program that **generates random mazes**, **solves them** with BFS, DFS, Dijkstra and A*, and **shows the search live** in the terminal. It can also **race** the algorithms side by side, **evolve mazes that are hard** for a chosen algorithm, **save and load** mazes, and test the algorithms on **mazes with loops**.

**Team:** Ajay Dangi (BTCS26O1010), Aditya More (BTCS26O1007)
**Mentor:** Mr. Amit Kumar Manjhvar

![Race animation](docs/race_animation.gif)

## Progress

| Milestone | Focus | Status |
|-----------|-------|--------|
| M1 | Grid, stack, recursive backtracker maze generator, seed input | Done |
| M2 | Queue, BFS and DFS solvers, path tracing | Done |
| M3 | Min-heap, Dijkstra, A*, ANSI colour animation, multi-file code | Done |
| M4 | Race mode, adversarial maze generator, timed benchmark | Done |
| M5 | Deployment, save/load, braided mazes, safety checks, complexity proofs, final report, viva materials | Done |

The full write-up is in [`docs/Final_Report.pdf`](docs/Final_Report.pdf).

## Run it (no compiler needed)

Pre-built executables are in `bin/`.

**Windows 10/11:** open **PowerShell** or **Windows Terminal** in this folder (do not double-click the `.exe`, the window would close at once) and run:
```
.\bin\maze5-windows-x64.exe 99 astar anim
```
Or double-click `run_demo.bat` to see five demos.

**Linux (64-bit):**
```
chmod +x bin/maze5-linux-x64
./bin/maze5-linux-x64 99 astar anim
```
Or run `sh run_demo.sh`.

**macOS or any other system:** build from source (below).

For **race mode**, maximise the terminal window first. It needs about 135 columns.

## Build from source

Needs `gcc` and `make`.
```
cd src
make
./maze5 99 astar anim
```
On Windows with MinGW: `gcc -Wall -O2 -o maze5.exe *.c`

Bigger mazes (sizes must be odd): `gcc -O2 -DW=201 -DH=101 -o maze5_big *.c`

## Commands

| Command | What it does |
|---------|--------------|
| `maze5 99` | Table comparing the four algorithms, with a difficulty rating |
| `maze5 99 astar` | Solved maze printed as text |
| `maze5 99 astar anim 20` | Live colour animation of A*, 20 ms per step |
| `maze5 race 99 30` | Race: four mazes side by side |
| `maze5 evolve astar 3000 99 hard.txt` | Evolve a maze that is hard for A* and save it |
| `maze5 braid 25 100` | Compare the algorithms on 100 mazes with 25% of walls opened |
| `maze5 bench 100 200` | Timed benchmark |
| `maze5 save my.txt 42 [braid%]` | Generate a maze and save it |
| `maze5 load my.txt astar anim` | Solve a saved maze (try the files in `mazes/`) |
| `maze5 help` | List the commands |

The same seed always gives the same maze. Colours: dark blue = wall, white = open, light blue = explored, orange = final path, green = start, red = end. In text mode: `.` = path, `,` = explored.

## How it works

- **Generation:** recursive backtracker (stack). Produces a perfect maze: exactly one route between any two cells.
- **BFS** (queue), **DFS** (stack), **Dijkstra** (min-heap, priority = distance), **A\*** (min-heap, priority = distance + Manhattan estimate).
- **Race:** each solver runs once and its exploration order is recorded; the display replays all four in lockstep, one explored cell per step.
- **Adversarial generator:** hill climbing. Open a wall (creates one loop), close a passage on that loop (keeps the maze perfect), keep the change if the target algorithm explores the same or more cells.
- **Save/load:** plain text file with a header and one line per row. Loading checks ten things (header, size, row lengths, characters, border, start/end, route) and only then replaces the current maze.
- **Braiding:** opens a share of the inner walls to create loops.

## Results

Evolving a maze for A* (seed 99): A* went from 93 to 209 cells explored, every open cell. A maze that is hard for one algorithm is not hard for all of them.

![Original maze](docs/maze_original.png) ![Evolved for A*](docs/maze_evolved_for_astar.png)

On mazes with loops A* gains much more. Average over 100 mazes:

| Walls opened | BFS cells | A* cells | A* vs BFS |
|--------------|-----------|----------|-----------|
| 0% (perfect maze) | 146 | 130 | -11% |
| 25% | 213 | 128 | -40% |
| 50% | 247 | 142 | -43% |

![Braiding chart](docs/braid_chart.png)

## Tests

```
sh tests/run_tests.sh bin/maze5-linux-x64
```
Checks reproducibility, the save/load round trip, that all algorithms agree on path length, that damaged files are rejected, and that evolving a maze makes it harder. The code was also run under AddressSanitizer, UndefinedBehaviorSanitizer and Valgrind with no errors (details in the report).

## Project structure

```
src/        maze.h, generator.c, heap.c/.h, solver.c, display.c, race.c,
            evolve.c, bench.c, braid.c, maze_io.c, main.c, Makefile
bin/        pre-built executables (Linux x64, Windows x64)
mazes/      example saved mazes (perfect, evolved, braided)
tests/      regression test script
docs/       report, animations and charts
```
