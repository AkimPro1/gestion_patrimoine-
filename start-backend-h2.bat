@echo off
title PATRIS - Backend (H2)
cd /d "%~dp0"

echo ===================================================
echo   DEMARRAGE DU BACKEND PATRIS (BASE H2)
echo ===================================================

REM Détection du JDK local
if exist "%~dp0jdk-21\jdk-21.0.6+7" goto use_local_jdk
echo [INFO] JDK local non trouve. Utilisation du Java installe sur le systeme.
if exist "%~dp0maven\maven-3.9.14\bin" set "PATH=%~dp0maven\maven-3.9.14\bin;%PATH%"
goto after_jdk

:use_local_jdk
echo [INFO] Utilisation du JDK local trouve dans le projet.
set "JAVA_HOME=%~dp0jdk-21\jdk-21.0.6+7"
set "PATH=%~dp0jdk-21\jdk-21.0.6+7\bin;%~dp0maven\maven-3.9.14\bin;%PATH%"

:after_jdk

echo.
echo [1] Demarrer en mode H2 Fichier (Sauvegarde les donnees dans le dossier ./data/) [Recommande]
echo [2] Demarrer en mode H2 Memoire (Donnees temporaires, effacees a chaque redemarrage)
echo.
set /p choix="Votre choix (1 ou 2) [Defaut: 1] : "

if "%choix%"=="2" goto mode_memoire
goto mode_fichier

:mode_memoire
echo [INFO] Lancement en mode H2 en memoire...
call mvn.cmd spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments=--spring.flyway.enabled=false
goto end_script

:mode_fichier
echo [INFO] Lancement en mode H2 fichier (persistant)...
call mvn.cmd spring-boot:run -Dspring-boot.run.arguments=--spring.flyway.enabled=false

:end_script

pause
