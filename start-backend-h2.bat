@echo off
title PATRIS - Backend (H2)
cd /d "%~dp0"

echo ===================================================
echo   DEMARRAGE DU BACKEND PATRIS (BASE H2)
echo ===================================================

REM Détection du JDK local
if exist "%~dp0jdk-21\jdk-21.0.6+7" (
    echo [INFO] Utilisation du JDK local trouve dans le projet.
    set "JAVA_HOME=%~dp0jdk-21\jdk-21.0.6+7"
    set "PATH=%~dp0jdk-21\jdk-21.0.6+7\bin;%~dp0maven\maven-3.9.14\bin;%PATH%"
) else (
    echo [INFO] JDK local non trouve. Utilisation du Java installe sur le systeme.
    if exist "%~dp0maven\maven-3.9.14\bin" (
        set "PATH=%~dp0maven\maven-3.9.14\bin;%PATH%"
    )
)

echo.
echo [1] Demarrer en mode H2 Fichier (Sauvegarde les donnees dans le dossier ./data/) [Recommande]
echo [2] Demarrer en mode H2 Memoire (Donnees temporaires, effacees a chaque redemarrage)
echo.
set /p choix="Votre choix (1 ou 2) [Defaut: 1] : "

if "%choix%"=="2" (
    echo [INFO] Lancement en mode H2 en memoire...
    call mvn spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments=--spring.flyway.enabled=false
) else (
    echo [INFO] Lancement en mode H2 fichier (persistant)...
    call mvn spring-boot:run -Dspring-boot.run.arguments=--spring.flyway.enabled=false
)

pause
