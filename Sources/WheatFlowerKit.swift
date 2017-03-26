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
    
    public init() {}
    
    public func removeGit(path: String) {
        let gitPath = path + "/.git"
        
        do {
            try FileManager.default.removeItem(atPath: gitPath)
        } catch {
            print(error.localizedDescription.red)
        }
    }
    
    public func rename(atPath: String, toPath: String) {
        do {
            try FileManager.default.moveItem(atPath: atPath, toPath: toPath)
        } catch {
            print(error.localizedDescription.red)
            exit(EX_OK)
        }
    }
    
//    public func recursionRename(path: String, toname: String) {
//        
//        
//        let toPath = path.replacingOccurrences(of: origin, with: destination)
//        rename(atPath: path, toPath: toPath)
//        
//        let contentsOfPath = getContentsOfPath(atPath: toPath)
//        
//        for content in contentsOfPath {
//            let childPath = toPath + "/" + content
//            print(childPath)
//            
//            recursionRename(path: childPath)
//        }
//    }
}
