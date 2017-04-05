//
//  WheatFlowerKit.swift
//  WheatFlower
//
//  Created by 张润良 on 2017/3/26.
//
//

import Foundation
import Rainbow

public class WheatFlowerKit {
    
    let manager = FileManager.default
    
    var oldName: String!
    var newName: String!
    
    public init() {}
    
    public func deleteGit(path: String) {
        let gitPath = path + "/.git"
        
        do {
            try manager.removeItem(atPath: gitPath)
        } catch {
            print(error.localizedDescription.red)
            exit(EX_OK)
        }
    }
    
    public func recursionRename(path: String) {
        
        let toPath = path.replacingOccurrences(of: oldName, with: newName)
        
        rename(atPath: path, toPath: toPath)
    
        let contentsOfPath = getContentsOfPath(at: toPath)
        
        for content in contentsOfPath {
            let childPath = toPath + "/" + content
            recursionRename(path: childPath)
        }
    }
    
    public func recursionReplace(path: String) {
        
//        replace(atPath: path)
//        
//        let contentsOfPath = getContentsOfPath(at: toPath)
//        
//        for content in contentsOfPath {
//            let childPath = toPath + "/" + content
//            recursionRename(path: childPath)
//        }
    }
    
    public func replaceAll(path: String) {
        
        isDir(path: path)
        
        let contentsOfPath = getContentsOfPath(at: path)
        
        for content in contentsOfPath {
            let childPath = path + "/" + content
            replaceAll(path: childPath)
        }
    }
    
    public func resursionGetContests(path: String, closure: () -> Void) {
        let toPath = path.replacingOccurrences(of: oldName, with: newName)
        
        closure()
        
        let contentsOfPath = getContentsOfPath(at: toPath)
        
        for content in contentsOfPath {
            let childPath = toPath + "/" + content
            recursionRename(path: childPath)
        }
    }
    
    
    private func getContentsOfPath(at path: String) -> [String] {
        do {
            return try manager.contentsOfDirectory(atPath: path)
        } catch {
            return []
        }
    }
    
    private func rename(atPath: String, toPath: String) {
        do {
            try FileManager.default.moveItem(atPath: atPath, toPath: toPath)
        } catch {
            print(error.localizedDescription.red)
            exit(EX_OK)
        }
    }
    
    private func replace(atPath: String) {
        
            
        let data = manager.contents(atPath: atPath)
        let readString = String(data: data!, encoding: String.Encoding.utf8)
        print(readString ?? "文件为空")
        
    }
    
    private func isDir(path: String) {
        var isDir: ObjCBool = false
        let r = manager.fileExists(atPath: path, isDirectory: &isDir)
        print("\(path) isDir: \(isDir)")
        print("\(path) r: \(r)")
    }
    
}
