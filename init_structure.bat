@echo off
echo ==============================================
echo Initialisation structure LEAVE MANAGEMENT APEX
echo ==============================================
echo.

REM Creation des dossiers
if not exist "apex" mkdir "apex"

if not exist "database" mkdir "database"
if not exist "database\tables" mkdir "database\tables"
if not exist "database\packages" mkdir "database\packages"
if not exist "database\views" mkdir "database\views"
if not exist "database\migrations" mkdir "database\migrations"

if not exist "tests" mkdir "tests"
if not exist "deployment" mkdir "deployment"

echo Dossiers crees.
echo.

REM Creation des fichiers .gitkeep
if not exist "apex.gitkeep" type nul > "apex.gitkeep"

if not exist "database\tables.gitkeep" type nul > "database\tables.gitkeep"
if not exist "database\packages.gitkeep" type nul > "database\packages.gitkeep"
if not exist "database\views.gitkeep" type nul > "database\views.gitkeep"
if not exist "database\migrations.gitkeep" type nul > "database\migrations.gitkeep"

if not exist "tests.gitkeep" type nul > "tests.gitkeep"
if not exist "deployment.gitkeep" type nul > "deployment.gitkeep"

echo Fichiers .gitkeep crees.
echo.

echo ==============================================
echo Structure du projet
echo ==============================================
tree /F
echo.

echo ==============================================
echo Git Status
echo ==============================================
git status
echo.

echo ==============================================
echo INITIALISATION TERMINEE
echo ==============================================
pause
