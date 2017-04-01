/*
 
 1. -dg --delete-git
 2. -r --rename XXX
 
 */

import Foundation
import CommandLineKit
import Rainbow
import PathKit

let cli = CommandLineKit.CommandLine()

let deleteGitOption = BoolOption(
    shortFlag: "d",
    longFlag: "delete-git",
    helpMessage: "Delete .git directory")


let renameOption = StringOption(
    shortFlag: "r",
    longFlag: "reanme",
    helpMessage: "Rename all file name and content you want")

let helpOption = BoolOption(
    shortFlag: "h",
    longFlag: "help",
    helpMessage: "Prints a help message.")

cli.addOptions(deleteGitOption, renameOption, helpOption)

cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s
    default:
        str = s
    }
    
    return cli.defaultFormat(s: str, type: type)
}

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if helpOption.value {
    cli.printUsage()
    exit(EX_OK)
}

let isDelete = deleteGitOption.value
let newName = renameOption.value


let wheatFlowerKit = WheatFlowerKit()
let currentPath = Path.current.string

print(currentPath.blue)

if isDelete {
    print("delete /.git....".yellow)
    wheatFlowerKit.deleteGit(path: currentPath)
    print("delete /.git success".green)
    exit(EX_OK)
}

if let newName = newName {
    
    /* 
     TODO: 
        1. 修改当前目录下全部文件及文件夹名称
        2. 替换当前目录下全部文件的内容
        3. 修改当前目录的上级文件夹名称
     */
    print("rename all file....".yellow)
    wheatFlowerKit.oldName = Path.current.lastComponent
    wheatFlowerKit.newName = newName
    wheatFlowerKit.recursionRename(path: currentPath)
    print("rename all file success".green)
    exit(EX_OK)
}
















