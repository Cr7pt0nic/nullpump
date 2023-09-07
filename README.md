# nullpump
A normal filepumper in Nim that allocates a certain amount of null bytes to a file in bytes allowing to artificially inflate the size of whatever file you choose.

## How to compile:

First install nim (You should know this).

Compile for linux:
```sh
nim c main.nim
```

Compile for windows:
```
nim c -d:mingw -d:release --app:console main.nim
```

## Usage:
Note: The size is determined in MB
```
./main --pump=example.exe --size=300
```
```psh
main.exe --pump=example.exe --size=300
```
