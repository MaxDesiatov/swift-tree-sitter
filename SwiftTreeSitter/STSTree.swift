//
//  STSTree.swift
//  SwiftTreeSitter
//
//  Created by Viktor Strate Kløvedal on 23/05/2020.
//  Copyright © 2020 viktorstrate. All rights reserved.
//

import SwiftTreeSitter.CTreeSitter

/// A tree that represents the syntactic structure of a source code file.
class STSTree {
    
    internal let treePointer: OpaquePointer
    
    var rootNode: STSNode {
        get {
            STSNode(from: ts_tree_root_node(treePointer))
        }
    }
    
    var language: STSLanguage {
        get {
            let languagePointer = ts_tree_language(treePointer)
            return STSLanguage(pointer: languagePointer)
        }
    }
    
    init(pointer: OpaquePointer) {
        self.treePointer = pointer
    }
    
    deinit {
        print("tree deleted")
        ts_tree_delete(treePointer)
    }
    
    func walk() -> STSTreeCursor {
        return STSTreeCursor(tree: self, node: self.rootNode)
    }
    
}
