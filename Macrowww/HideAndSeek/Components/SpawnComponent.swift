//
//  TransformComponent.swift
//  Macrowww
//
//  Created by Gregorius Yuristama Nugraha on 9/26/23.
//

import Foundation
import GameplayKit

class SpawnComponent: GKComponent {
    public var isSpawning = false
    private var rabbitPos = [NodeElement]()
    private var foxPos = [NodeElement]()
    
    var size: CGSize
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var visualComponent: VisualComponent? {
        return entity?.component(ofType: VisualComponent.self)
    }
    
    init(size: CGSize) {
        self.size = size
        super.init()
        self.addRabbitPosition()
        self.addFoxPosition()
//        self.spawnEntity()
    }
    
    func spawnNextEntity() {
        isSpawning = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.spawnEntity()
        }
    }
    
    public func spawnEntity() {
        if isSpawning {
            return // If an entity is currently spawning, exit early
        }
        
        let randomValue = Int.random(in: 1...6) // 5:1 ratio
        isSpawning = true // Mark that an entity is spawning
        
        let spawnCompletionAction = SKAction.run { [self] in
            self.spawnNextEntity()
        }
        
        if randomValue <= 5 {
            guard let randomRabbit = rabbitPos.randomElement() else { return }
            if let spriteNode = self.visualComponent?.componentNode {
                spriteNode.texture = SKTexture(imageNamed: randomRabbit.textureName)
                spriteNode.name = randomRabbit.name
                spriteNode.position = randomRabbit.position
                spriteNode.setScale(randomRabbit.scale)
                spriteNode.zPosition = randomRabbit.zIndex
                // Rest of your spriteNode updates
                print(spriteNode.position)
                // Define a slide-up action
                let slideUpAction = SKAction.move(by: CGVector(dx: 0, dy: spriteNode.size.height), duration: 1.0)
                slideUpAction.timingMode = .easeIn
                
                // Define a slide-down action
                let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -spriteNode.size.height), duration: 1.0)
                slideDownAction.timingMode = .easeIn
                
                // Define a sequence of actions
                let sequence = SKAction.sequence([
                    slideUpAction,
                    SKAction.wait(forDuration: 5.0),
                    slideDownAction,
//                    SKAction.removeFromParent(),
                    spawnCompletionAction
                ])
                self.visualComponent?.componentNode.run(sequence)
            }
            
            
        } else {
            // Spawn a fox
            guard let randomFox = foxPos.randomElement() else { return }
            // Use the visualComponent to access the componentNode
            if let spriteNode = self.visualComponent?.componentNode {
                spriteNode.texture = SKTexture(imageNamed: randomFox.textureName)
                spriteNode.name = randomFox.name
                spriteNode.position = randomFox.position
                spriteNode.setScale(randomFox.scale)
                spriteNode.zPosition = randomFox.zIndex
                // Rest of your spriteNode updates
                let slideUpAction = SKAction.move(by: CGVector(dx: 0, dy: spriteNode.size.height), duration: 1.0)
                slideUpAction.timingMode = .easeIn
                
                let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -spriteNode.size.height), duration: 1.0)
                slideDownAction.timingMode = .easeIn
                
                // Define a sequence of actions
                let sequence = SKAction.sequence([
                    slideUpAction,
                    SKAction.wait(forDuration: 5.0),
                    slideDownAction,
//                    SKAction.removeFromParent(),
                    spawnCompletionAction
                ])
                self.visualComponent?.componentNode.run(sequence)
                
            }
        }
        
    }
    
}

extension SpawnComponent{
    
    func addRabbitPosition() {
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.1 , y: -size.height * 0.1), scale: 1, zIndex: 6))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.28 , y: size.height * 0.06), scale: 0.6, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.42 , y: size.height * 0.11), scale: 0.7, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.65 , y: size.height * 0.04), scale: 0.8, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.92 , y: -size.height * 0.04), scale: 1, zIndex: 5))
    }
    
    func addFoxPosition() {
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.1 , y: -size.height * 0.13), scale: 1, zIndex: 6))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.28 , y: size.height * 0.06), scale: 0.6, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.42 , y: size.height * 0.11), scale: 0.7, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.65 , y: size.height * 0.03), scale: 0.8, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.92 , y: -size.height * 0.06), scale: 1, zIndex: 5))
    }
}
