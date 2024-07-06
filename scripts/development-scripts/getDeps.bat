@echo off

setlocal

set BASEDIR=%~dp0

pushd %BASEDIR%
set DEV_SCRIPT_DIR=%CD%
popd

pushd %DEV_SCRIPT_DIR%\..
set SCRIPT_DIR=%CD%
popd

pushd %SCRIPT_DIR%\..
set SUBPROJECT_DIR=%CD%
popd

pushd %SUBPROJECT_DIR%\..
set PROJECT_DIR=%CD%
popd

pushd %SUBPROJECT_DIR%\build
set BUILD_DIR=%CD%
popd





cd %SUBPROJECT_DIR%

echo on

rd /S /Q runtime 

call %PROJECT_DIR%\gradlew getdeps --warning-mode all



cd %SUBPROJECT_DIR%\runtime\main
set scheme=https
set host=pluto.rsmaxwell.co.uk
set directory=archiva
set repository=releases
set group=com.rsmaxwell.mqtt.rpc.example
set artifact=mqtt-rpc-example-response
set version=0.0.1.27
set filename=mqtt-rpc-example-response

set baseURL=%scheme%://%host%/%directory%
curl -s %baseURL%/repository/%repository%/%group:.=/%/%artifact%/%version%/%filename%-%version%.jar -o %filename%-%version%.jar
