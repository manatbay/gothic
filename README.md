Forked from [nsf/gothic](https://github.com/nsf/gothic).

See the [nsf/gothic README](https://github.com/nsf/gothic/blob/master/README) for usage.

For 64-bit Windows
------------------

This is an attempt to document how I got gothic running on a Windows 64-bit machine:

1. Install [ActiveTCL Windows 64-bit](http://www.activestate.com/activetcl/downloads).
I assume ActiveTCL is installed in the default location, namely: C:\Tcl.
If this is not the case, you will need to update the Tcl references in [interpreter.go](https://github.com/Horkonaut/gothic/blob/master/interpreter.go).

2. Download the [latest rubenvb MinGW-w64 gcc-release version](http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/rubenvb/).
Install it wherever you like. Add the install directory to your path.

3. Download the [latest pexports](http://sourceforge.net/projects/mingw/files/MinGW/Extension/pexports/).
Install it wherever you like. 
Add the install directory to your path.

3. Open a command prompt in C:\Tcl\bin.

4. Type

	```
	pexports tcl86.dll > tcl86.def
	```
	
	```	
	dlltool -D tcl86.dll -d tcl86.def -l libtcl86.a
	```
	
	```	
	pexports tk86.dll > tk86.def
	```
	
	```	
	dlltool -D tk86.dll -d tk86.def -l libtk86.a
	```
	
5. Clone [this repo](https://github.com/Horkonaut/gothic).

6. Cross your fingers! 
Everything should just work!

For 32-bit Windows
------------------
	
1. Do everything like the 64-bit version, but use 32-bit tools.
Not tested. 
