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
        print(path.red)
        print(toPath.green)
        if path != toPath {
            rename(atPath: path, toPath: toPath)
        }
    
        let contentsOfPath = getContentsOfPath(at: toPath)
        
        for content in contentsOfPath {
            let childPath = toPath + "/" + content
            print(childPath)
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
    
    
}
