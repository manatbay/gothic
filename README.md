#### *This fork is primarily concerned with Windows 64-bit use cases with Tcl/Tk 8.6*

*Forked from [Horkonaut/gothic](https://github.com/Horkonaut/gothic) which was forked from [nsf/gothic](https://github.com/nsf/gothic).*

----------

# Tcl/Tk Go Bindings

## Version Notice

Recently Tcl/Tk 8.6 were released. I use them as a default, if you still have
Tcl/Tk 8.5 use `go get -tags tcl85 github.com/nsf/gothic`.

## Description

In its current state the bindings are a bit Tk-oriented. You can't create an
interpreter instance without Tk. In future it's likely it will be changed.

The API is very simple. In the package you have one type and one function:
```
type Interpreter struct
func NewInterpreter (init interface{}) *Interpreter
```
In order to launch an interpreter you have to call the "NewInterpreter"
function, it will make a new instance of a tcl/tk interpreter in a separate
goroutine, execute "init", block in Tk's main loop and then the function
returns a pointer to the new instance of an "Interpreter".

"init" could be a string with tcl commands that are executed before Tk's main
loop, or a function with this signature: `func (*Interpreter)`. This function
gets executed the same way as the string, that is - before Tk's main loop.

Here are the methods of the "Interpreter":

```
func (*Interpreter) ErrorFilter(filt func(error) error)
func (*Interpreter) Eval(args ...interface{}) error
func (*Interpreter) EvalAs(out interface{}, args ...interface{}) error
func (*Interpreter) Set(name string, val interface{}) error
func (*Interpreter) UploadImage(name string, img image.Image) error
func (*Interpreter) RegisterCommand(name string, cbfunc interface{}) error
func (*Interpreter) UnregisterCommand(name string) error
func (*Interpreter) RegisterCommands(name string, val interface{}) error
func (*Interpreter) UnregisterCommands(name string) error
```

As it was stated before, the "Interpreter" is being executed in a separate
goroutine and each method is completely thread-safe. Also every method is
synchronous. It will queue commands for execution and wait for their
completion.

That's it. See "examples" directory it has the use cases for most of the API.

## Installation

### For 64-bit Windows
------------------

Using Gothic on a Windows 64-bit machine:

1. If not already present, install [Go](https://golang.org/dl/). I tested with `go1.4.2.linux-amd64.tar.gz`

2. If not already present, install [Git](https://msysgit.github.io/). I tested with `Git-1.9.5-preview20150319.exe`

3. Install [ActiveTCL Windows 64-bit](http://www.activestate.com/activetcl/downloads) to `C:\Tcl` in **adminstrative** mode (otherwise DLLs and libs will not be accessible to your compiled programs!)
This was tested with `ActiveTcl8.6.3.1.298624-win32-x86_64-threaded.exe`. If install dir is different from `C:\Tcl`, update [interpreter.go](https://github.com/Horkonaut/gothic/blob/master/interpreter.go) and change the following instructions as necessary.

4. Download `mingw-w64-install.exe` from [the MinGW-w64 site](http://sourceforge.net/projects/mingw-w64/) and install to the directory of your choice (e.g., `C:\mingw-w64`). Add the bin directory to your path. I tested with the following install options:
 * Version: 4.9.2
 * Architecture: x86_64
 * Threads: posix
 * Exception: seh
 * Build Revision: 2

5. Download the [latest pexports](http://sourceforge.net/projects/mingw/files/MinGW/Extension/pexports/) and extract pexports.exe to the directory of your choice. Add this directory to your path. I tested with `pexports-0.46-mingw32-bin.tar.xz`

6. It may be best to reboot at this point, to ensure the installs are correctly in the path

7. Run the following build commands:
	```cmd
	set PATH=C:\mingw-w64\mingw64\bin;C:\git\bin;%PATH%
	set GOPATH=%HOMEDRIVE%%HOMEPATH%\Desktop\GoTcl
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
	bash clean.bash
	bash all.bash
	```

8. Test the examples (e.g., `colors.exe`).

### For 32-bit Windows (UNTESTED)
------------------
1. As the 64-bit version, but using 32-bit tools instead.
