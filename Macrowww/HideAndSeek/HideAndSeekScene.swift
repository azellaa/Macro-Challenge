//
//  HideAndSeekScene.swift
//  Macrowww
//
//  Created by Gregorius Yuristama Nugraha on 9/26/23.
//

import Foundation
import SpriteKit
import GameplayKit

class HideAndSeekScene: SKScene, SKPhysicsContactDelegate {
    
    //    private var rabbit = SKSpriteNode()
    //    private var fox = SKSpriteNode()
    
    private var focusBar = ProgressBar()
    private var bg = BackgroundHideAndSeek()
    private let rabbitCountLabel = SKLabelNode(text: "Rabbit Count: 0")
    
    private var rabbitCount = 0
    private var timerValue: Int = 600 // timer 10 menit
    
    public var focusCount = 0 // focus point
    public var isSpawning = false
    
    var entities = [GKEntity]()
    let controlComponents = GKComponentSystem(componentClass: ControlComponent.self)
    let spawnComponents = GKComponentSystem(componentClass: SpawnComponent.self)
    let visualComponents = GKComponentSystem(componentClass: VisualComponent.self)
    var lastUpdate = 0.0
    
    override init() {
        super.init()
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSystemComponents(){
        for entity in entities {
            controlComponents.addComponent(foundIn: entity)
            spawnComponents.addComponent(foundIn: entity)
        }
    }
    func setUpEntities() {
        entities.append(createRabbitEntity())
    }
    
    func createRabbitEntity() -> GKEntity {
        let rabbit = GKEntity()
        
        let visualComponent = VisualComponent(type: .rabbit)
        let controlComponent = ControlComponent()
        let spawnComponent = SpawnComponent(size: self.size)
        rabbit.addComponent(visualComponent)
        rabbit.addComponent(controlComponent)
        rabbit.addComponent(spawnComponent)
        
        self.addChild(visualComponent.componentNode)
        return rabbit
    }
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        
        bg.getSceneFrame(sceneFrame: frame)
        bg.addBackground()
        bg.isUserInteractionEnabled = false
        addChild(bg)
        
        setUpEntities()
        setupSystemComponents()
        
        for case let component as SpawnComponent in spawnComponents.components {
            component.spawnEntity()
        }
        
        //        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        //            if self.timerValue <= 1 {
        //                timer.invalidate()
        //                self.timesUpFunc()
        //            }
        //            self.timerValue -= 1
        //        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            for case let component as ControlComponent in controlComponents.components {
                if let activeNode = component.visualComponent?.componentNode {
                    if activeNode.contains(location) {
                        if activeNode.name == HideAndSeekCharacterList.rabbit.rawValue {
                            component.tapped(type: .rabbit, node: activeNode)
                        } else if activeNode.name == HideAndSeekCharacterList.fox.rawValue {
                            component.tapped(type: .fox, node: activeNode)
                        }
                    }
                }
            }
            
        }
    }
    
    
}
