@echo off

set NODEEX=""
set OXYAK="%~dp0\src\oxyak.js"
set OXYAKARGS=

for %%i in (
	"C:\Program Files\nodejs\node.exe"
	"C:\Program Files (x86)\nodejs\node.exe" 
	"C:\nodejs\node.exe"
	"D:\Program Files\nodejs\node.exe"
	"D:\Program Files (x86)\nodejs\node.exe" 
	"D:\nodejs\node.exe"
	"E:\Program Files\nodejs\node.exe"
	"E:\Program Files (x86)\nodejs\node.exe" 
	"E:\nodejs\node.exe"
) do (
  	IF EXIST %%i (
  		set NODEEX=%%i
	)
)

echo Using node binary from %NODEEX%
IF %NODEEX%=="" (
	echo "Need nodejs binary in the path; open this script and edit the NODEEX variable"
	goto failure
)

echo Lisk Army Knife is %OXYAK%
echo running %NODEEX% %OXYAK% %*
%NODEEX% %OXYAK% %*

goto end

:failure
echo "Failed to run, check node path"

:end
