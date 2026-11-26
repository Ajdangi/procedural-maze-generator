# maze5 version 1.0.0

First complete release of the Procedural Terminal Maze Generator.

## Downloads

| File | For |
|------|-----|
| `maze5-windows-x64.zip` | Windows 10/11 (64-bit): `maze5.exe`, readme, sample mazes |
| `maze5-linux-x64.tar.gz` | Linux (64-bit): `maze5`, readme, sample mazes |
| `SHA256SUMS.txt` | Checksums to verify the downloads |

macOS and other systems: build from source (`cd src && make`).

## Quick start

Windows (PowerShell, in the folder with the files):
```
.\maze5.exe 99 astar anim
```
Linux:
```
chmod +x maze5 && ./maze5 99 astar anim
```
Run `maze5 help` for all commands: solve, race, evolve, braid, bench, save, load.
For race mode, maximise the terminal window first (about 135 columns).

## What is in this version

- Random maze generation (recursive backtracker) with reproducible seeds
- BFS, DFS, Dijkstra and A* with live colour animation
- Race mode: four algorithms side by side
- Adversarial maze generator (hill climbing) and difficulty rating
- Mazes with loops (braiding) and a timed benchmark
- Save and load mazes with validation
- Regression tests (`tests/run_tests.sh`), full report with proofs in `docs/Final_Report.pdf`

## Verify your download

```
sha256sum -c --ignore-missing SHA256SUMS.txt
```
On Windows PowerShell: `Get-FileHash .\maze5-windows-x64.zip` and compare with `SHA256SUMS.txt`.

## Known limits

- The executables are not code-signed. Windows may show "protected your PC": choose More info, then Run anyway.
- Maze size is fixed at 31 x 15 in the provided executables; rebuild with `-DW` and `-DH` for other sizes.
- The Windows executable is cross-compiled; the Linux executable is fully tested.
