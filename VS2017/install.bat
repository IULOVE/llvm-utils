@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

SET "EXIST_ON_ERROR=%~1"

FOR /f "delims=" %%A IN (
'"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -property installationPath'
) DO SET "VS_PATH=%%A"

SET VCT_PATH=%VS_PATH%\Common7\IDE\VC\VCTargets\Platforms
IF NOT EXIST "%VCT_PATH%" (
	ECHO Visual C++ 2017 or 2019 NOT Installed.
	IF "%EXIST_ON_ERROR%" == "" PAUSE
	ENDLOCAL
	EXIT /B
)

ECHO VCTargetsPath: %VCT_PATH%

PUSHD %~dp0

XCOPY /Q /Y "LLVM" "%VCT_PATH%\..\LLVM\"
XCOPY /Q /Y "LLVM v141" "%VCT_PATH%\x64\PlatformToolsets\LLVM v141\"
XCOPY /Q /Y "LLVM v141_xp" "%VCT_PATH%\x64\PlatformToolsets\LLVM v141_xp\"
XCOPY /Q /Y "LLVM v141" "%VCT_PATH%\Win32\PlatformToolsets\LLVM v141\"
XCOPY /Q /Y "LLVM v141_xp" "%VCT_PATH%\Win32\PlatformToolsets\LLVM v141_xp\"
XCOPY /Q /Y "LLVM v141" "%VCT_PATH%\ARM64\PlatformToolsets\LLVM v141\"

POPD
ENDLOCAL
IF "%EXIST_ON_ERROR%" == "" PAUSE
