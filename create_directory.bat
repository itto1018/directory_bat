@echo off
setlocal

@REM Set path
@REM Rewite yourself(ex: set "PATH=%userprofile%\OneDrive\Desktop\")
set "PATH=%userprofile%\OneDrive\Desktop\"

@REM input_dirname
:input_dirname
set /p DIRNAME="input a parent directory name："

@REM Varidate: empty
if "%DIRNAME%"=="" (
    echo ERROR: Input must not be empty
    goto input_dirname
)

@REM Varidate: same name directory
set "TARGET_DIR=%PATH%%DIRNAME%"
if exist "%TARGET_DIR%" (
    echo ERROR: Same name directory exists
    goto input_dirname
)


@REM input_year
:input_year
set /p YEAR="input a year(ex:2024)："
@REM Varidate: empty
if "%YEAR%"=="" (
    echo ERROR: Input must not be empty
    goto input_year
)
@REM Varidate: int(4)
set "isValid=1"
for /l %%i in (0,1,3) do (
    set "char=!userInput:~%%i,1!"
    if not "!char!"=="" (
        for %%j in (0 1 2 3 4 5 6 7 8 9) do (
            if "!char!"=="%%j" (
                set "isValid=1"
                goto continue
            )
        )
        set "isValid=0"
        goto continue
    )
)
:continue
if "%isValid%"=="0" (
    echo Error: Input must be a 4-digit number.
    goto input_year
)

@REM YEAR_NEXT
set /a YEAR_NEXT=YEAR + 1

@REM Is_Continue
set /p CONFIRM="Continue this process？ (y/n)："
if /i "%CONFIRM%" NEQ "y" (
    echo Process canceled.
    exit /b
)

@REM create a period directory
mkdir "%TARGET_DIR%"
cd "%TARGET_DIR%"

@REM create monthly directories
for /L %%i in (1,1,12) do (
    mkdir "%YEAR%-%%i"
)

for /L %%i in (1,1,12) do (
    mkdir "%YEAR_NEXT%-%%i"
)

echo Created a Directories