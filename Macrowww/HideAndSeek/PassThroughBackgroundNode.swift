//
//  PassThroughBackgroundNode.swift
//  Macrowww
//
//  Created by Gregorius Yuristama Nugraha on 9/26/23.
//

import Foundation
import SpriteKit
class PassThroughBackgroundNode: SKSpriteNode {
    override func contains(_ p: CGPoint) -> Bool {
        // Always return false to make this node non-blocking for touches
        return false
    }
    
    
}
