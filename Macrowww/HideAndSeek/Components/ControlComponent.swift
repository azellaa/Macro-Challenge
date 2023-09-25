//
//  ControlComponent.swift
//  Macrowww
//
//  Created by Gregorius Yuristama Nugraha on 9/26/23.
//

import Foundation
import GameplayKit

class ControlComponent: GKComponent {
    
    var visualComponent: VisualComponent? {
        return entity?.component(ofType: VisualComponent.self)
    }
    
    var spawnComponent: SpawnComponent? {
        return entity?.component(ofType: SpawnComponent.self)
    }
    public func tapped(type: HideAndSeekCharacterList, node: SKSpriteNode){
        let spawnCompletionAction = SKAction.run { [weak self] in
            self?.spawnComponent?.spawnNextEntity()
        }
        
        switch type {
        case .rabbit:
            node.texture = SKTexture(imageNamed: "Rabbit_Tap")
            let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -node.size.height), duration: 1.0)
            slideDownAction.timingMode = .easeIn

            let sequence = SKAction.sequence([
                slideDownAction,
                spawnCompletionAction
            ])
            
            node.run(sequence)
        case .fox:
            node.texture = SKTexture(imageNamed: "Fox_Tap")
            let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -node.size.height), duration: 1.0)
            slideDownAction.timingMode = .easeIn

            let sequence = SKAction.sequence([
                slideDownAction,
                spawnCompletionAction
            ])
            
            node.run(sequence)
        }
        
        //TODO: Update Score, Update Timer 10 Menit
    }
}
