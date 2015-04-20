Forked from [Horkonaut/gothic](https://github.com/Horkonaut/gothic) which was forked from [nsf/gothic](https://github.com/nsf/gothic).

See the [nsf/gothic README](https://github.com/nsf/gothic/blob/master/README) for usage.

For 64-bit Windows
------------------

Using Gothic on a Windows 64-bit machine:

1. Install [Go](https://golang.org/dl/). I tested with go1.4.2.linux-amd64.tar.gz

2. Install [Git](https://msysgit.github.io/). I tested with Git-1.9.5-preview20150319.exe

3. Install [ActiveTCL Windows 64-bit](http://www.activestate.com/activetcl/downloads) to C:\Tcl in *adminstrative* mode (otherwise DLLs and libs will not be accessible to your compiled programs!)
This was tested with ActiveTcl8.6.3.1.298624-win32-x86_64-threaded. If install dir is different from C:\Tcl, update [interpreter.go](https://github.com/Horkonaut/gothic/blob/master/interpreter.go) and change the following instructions as necessary.

4. Download mingw-w64-install.exe from [the MinGW-w64 site](http://sourceforge.net/projects/mingw-w64/) and install to the directory of your choice (e.g., C:\mingw-w64). Add the bin directory to your path. I tested with the following install options:
 * Version: 4.9.2
 * Architecture: x86_64
 * Threads: posix
 * Exception: seh
 * Build Revision: 2

5. Download the [latest pexports](http://sourceforge.net/projects/mingw/files/MinGW/Extension/pexports/) and extract pexports.exe to the directory of your choice. Add this directory to your path. I tested with pexports-0.46-mingw32-bin.tar.xz

6. It may be best to reboot at this point, to ensure the installs are correctly in the path

8. Run the following build commands:
	```
	set GOPATH=%HOMEDRIVE%%HOMEPATH%\Desktop\GoTcl
	set PATH=C:\mingw-w64\mingw64\bin;C:\git\bin;%PATH%
	set TCLPATH=C:\Tcl
	set CPLUS_INCLUDE_PATH=%TCLPATH%\include
	set C_INCLUDE_PATH=%TCLPATH%\include
	set LD_LIBRARY_PATH=%TCLPATH%\lib
	set TCL_LIBRARY=%TCLPATH%\lib\tcl8.6
	
	:; Create the libraries (once)
	cd %TCLPATH%\bin
	pexports tcl86.dll > tcl86.def
	dlltool -D tcl86.dll -d tcl86.def -l libtcl86.a
	pexports tk86.dll > tk86.def
	dlltool -D tk86.dll -d tk86.def -l libtk86.a
	
	:; Create the libraries (once)
	mkdir "%GOPATH%"
	cd /d "%GOPATH%"
	go get github.com/MartyMacGyver/gothic
	
	cd /d %GOPATH%\src\github.com\MartyMacGyver\gothic\_examples
	go build *.go
	
	```

For 32-bit Windows (UNTESTED)
------------------
1. As the 64-bit version, but using 32-bit tools instead.
