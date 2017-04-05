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

let replaceOption = StringOption(
    shortFlag: "rp",
    longFlag: "replace",
    helpMessage: "Replace all file content you want")

let renameOption = StringOption(
    shortFlag: "rn",
    longFlag: "reanme",
    helpMessage: "Rename all file name you want")

let helpOption = BoolOption(
    shortFlag: "h",
    longFlag: "help",
    helpMessage: "Prints a help message.")

// TODO: Replace
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



let wheatFlowerKit = WheatFlowerKit()
let currentPath = Path.current.string

if deleteGitOption.value {
    print("delete /.git....".yellow)
    wheatFlowerKit.deleteGit(path: currentPath)
    print("delete /.git success".green)
    exit(EX_OK)
}


if let relpace = replaceOption.value {
    print("replace all file....".yellow)
    wheatFlowerKit.oldName = Path.current.lastComponent
    wheatFlowerKit.newName = relpace
    wheatFlowerKit.replaceAll(path: currentPath)
    print("replace all file success".green)
    exit(EX_OK)
}

if let rename = renameOption.value {
    print("rename all file....".yellow)
    wheatFlowerKit.oldName = Path.current.lastComponent
    wheatFlowerKit.newName = rename
    wheatFlowerKit.recursionRename(path: currentPath)
    print("rename all file success".green)
    exit(EX_OK)
}
















