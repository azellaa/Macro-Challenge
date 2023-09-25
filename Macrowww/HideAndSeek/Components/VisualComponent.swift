//
//  VisualComponent.swift
//  Macrowww
//
//  Created by Gregorius Yuristama Nugraha on 9/25/23.
//

import GameplayKit

enum HideAndSeekCharacterList: String{
    case rabbit = "rabbit"
    case fox = "fox"
}

class VisualComponent: GKComponent {
    var componentNode: SKSpriteNode
    init (type: HideAndSeekCharacterList){
        
        var node = SKSpriteNode()
        switch type {
        case .rabbit:
            node = .init(imageNamed: "Rabbit_Hide")
            node.name = "rabbit"
        case .fox:
            node = .init(imageNamed: "Fox_Seek")
            node.name = "fox"
        }
        componentNode = node
        
        super.init()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
    }
    
}
