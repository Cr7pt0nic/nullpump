import os, strutils

proc pumpexe(sizeInMB: float, path: string) =
    let desiredSizeInBytes = int(sizeInMB * 1048576)
    var file = open(path, fmAppend)
    defer: file.close()

    let currentSize = file.getFileSize()

    for _ in currentSize..<desiredSizeInBytes:
        file.write('\0')

    file.setFilePos(file.getFileSize()) 
    while file.getFilePos() < desiredSizeInBytes:
        file.write('\0')

proc displayHelp() =
    var banner = """
 _   _       _ _______                       
| \ | |     | | | ___ \                      
|  \| |_   _| | | |_/ /   _ _ __ ___  _ __ 
| . ` | | | | | |  __/ | | | '_ ` _ \| '_ \  
| |\  | |_| | | | |  | |_| | | | | | | |_) | 
\_| \_/\__,_|_|_\_|   \__,_|_| |_| |_| .__/ 
                                     | |                                             
                                     |_|                                                   
    """
    echo banner
    echo "Usage: nullpump.exe --pump=<filename> --size=<size in MB>"

proc parseArguments(args: seq[string]): (string, float) =
    var filePath = ""
    var sizeInMB: float = 0.0
    for arg in args:
        if arg.startsWith("--pump="):
            filePath = arg["--pump=".len ..< arg.len()]
        elif arg.startsWith("--size="):
            try:
                sizeInMB = parseFloat(arg["--size=".len ..< arg.len()])
            except ValueError:
                displayHelp()
                quit(1)
    return (filePath, sizeInMB)


proc main() =
    let args = commandLineParams()

    if args.len() < 2:
        displayHelp()
        return

    #let path = args[0]
    let (path, sizeInMB) = parseArguments(args)
    
    if path == "" or sizeInMB <= 0:
        displayHelp()
        return
    if not fileExists(path):
        echo "Error: ", path, " does not exist"
        return
    
    pumpexe(sizeInMB, path)
    echo "Operation completed"

main()
