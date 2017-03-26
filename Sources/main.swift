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
        str = s.lightBlue
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
let rename = renameOption.value


let wheatFlowerKit = WheatFlowerKit()
let currentPath = Path.current.string

if isDelete {
    print("删除.git目录....".yellow)
    wheatFlowerKit.removeGit(path: currentPath)
    exit(EX_OK)
}

if let rename = rename {
    print("renaming to \(rename)...".yellow)
    exit(EX_OK)
}
















