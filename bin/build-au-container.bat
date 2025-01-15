:: Example run: build-au-container

@echo off

cd C:\Users\MyrenY\IdeaProjects\mfe-wealth-au-container

echo + git checkout master
git checkout master
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to checkout master branch
    exit /b 1
)

echo + git restore proxy.js yarn.lock
git restore proxy.js yarn.lock
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to restore proxy.js and yarn.lock
    exit /b 1
)

echo + git pull
git pull
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to pull latest
    exit /b 1
)

:: Use call command to ensure that control returns to this script after the yarn command completes.
echo + yarn upgrade mfe-wealth-au-common mfe-framework
call yarn upgrade mfe-wealth-au-common mfe-framework
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to upgrade library mfe-wealth-au-common and mfe-framework
    exit /b 1
)

echo + yarn build
call yarn build
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to build
    exit /b 1
)

echo Skip yarn test

echo Build completed successfully.
