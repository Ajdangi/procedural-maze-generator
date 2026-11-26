@echo off
echo ===== 1. Compare all four algorithms (seed 99) =====
bin\maze5-windows-x64.exe 99
echo.
echo ===== 2. Live animation: A* (seed 99) =====
bin\maze5-windows-x64.exe 99 astar anim 20
echo.
echo ===== 3. Race: all four side by side (maximise this window first) =====
bin\maze5-windows-x64.exe race 99 30
echo.
echo ===== 4. A saved maze that is hard for A* =====
bin\maze5-windows-x64.exe load mazes\hard_for_astar_seed99.txt
echo.
echo ===== 5. Mazes with loops: A* gains more =====
bin\maze5-windows-x64.exe braid 25 100
pause
