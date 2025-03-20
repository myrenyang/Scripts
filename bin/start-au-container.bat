:: Example run: start-au-container https://8101.composer-eks.composer-eks.syd.aws.ongbst.net/
:: Example run: start-au-container -useCurrent

:: A easier IntelliJ command is: cmd /C start /min cmd /K "cd C:\Users\MyrenY\IdeaProjects\mfe-wealth-au-container && yarn start"

@echo off

:: Initialize optional parameters
SET envUrl=

:: Check for optional parameters
setlocal EnableDelayedExpansion
IF NOT "%~1"=="" (
    set "url=%~1"
    IF /I "!url:~0,4!"=="http" (
        SET envUrl=!url!
    ) ELSE IF /I "!url!"=="-useCurrent" (
        FOR /F "tokens=* usebackq delims=" %%a IN (`findstr /i /c:"composer-eks.syd.aws.ongbst.net" src\setupProxy.js`) DO (
            FOR /F "tokens=2 delims=''" %%b IN ("%%a") DO (
                SET "fullUrl=%%b"
                IF "!fullUrl:~0,4!"=="http" (
                    IF "!fullUrl:composer-eks.syd.aws.ongbst.net/!" NEQ "!fullUrl!" (
                        SET "envUrl=!fullUrl:composer/=!"
                    )
                )
            )
        )
        echo Read src/setupProxy.js and got the environment url: !envUrl!
    ) ELSE (
        echo Invalid parameter "!url!". Must start with "http" or be "-useCurrent"
        exit /b 1
    )
)
endlocal & SET "envUrl=%envUrl%"

cd C:\Users\MyrenY\IdeaProjects\mfe-wealth-au-container

echo Current target in proxy.js:
findstr /i /c:"const target" proxy.js

IF NOT "%envUrl%"=="" (
    powershell -Command "$content = Get-Content proxy.js; $content -replace 'const target = ''[^'']+''', 'const target = ''%envUrl%''' | Set-Content proxy.js"
    echo Modified target in the proxy.js:
    findstr /i /c:"const target" proxy.js
)

yarn start
