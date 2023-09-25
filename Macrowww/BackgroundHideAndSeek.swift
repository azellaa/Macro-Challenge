//
//  BackgroundHideAndSeek.swift
//  Macrowww
//
//  Created by Priskilla Adriani on 25/09/23.
//

import SpriteKit

class BackgroundHideAndSeek: SKSpriteNode {
    private var background = PassThroughBackgroundNode()
    private var background1 = PassThroughBackgroundNode()
    private var background2 = PassThroughBackgroundNode()
    private var background3 = PassThroughBackgroundNode()
    private var background4 = PassThroughBackgroundNode()
    private var bush = PassThroughBackgroundNode()
    private var bush1 = PassThroughBackgroundNode()
    private var bush2 = PassThroughBackgroundNode()
    private var rocks = PassThroughBackgroundNode()
    private var wood = PassThroughBackgroundNode()
    
    private var sceneFrame = CGRect()
    
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
    }
    
    func addBackground() {
        background = .init(imageNamed: "Background 1")
        background.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        background.setScale(1)
        background.zPosition = 5
        background.isUserInteractionEnabled = false
        
        background1 = .init(imageNamed: "Background 2")
        background1.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        background1.setScale(1)
        background1.zPosition = 4
        background1.isUserInteractionEnabled = false
        
        background2 = .init(imageNamed: "Background 3")
        background2.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.25)
        background2.setScale(1)
        background2.zPosition = 2
        background2.isUserInteractionEnabled = false
        
        background3 = .init(imageNamed: "Background 4")
        background3.position = CGPoint(x: sceneFrame.width * 0.622, y: sceneFrame.height * 0.29)
        background3.setScale(1)
        background3.zPosition = 1
        background3.isUserInteractionEnabled = false
        
        background4 = .init(imageNamed: "Background 5")
        background4.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        background4.setScale(1)
        background4.zPosition = 0
        background4.isUserInteractionEnabled = false
        
        bush = .init(imageNamed: "Bush 1")
        bush.position = CGPoint(x: sceneFrame.width * 0.1, y: sceneFrame.height * 0.12)
        bush.setScale(1)
        bush.zPosition = 7
        bush.isUserInteractionEnabled = false
        
        bush1 = .init(imageNamed: "Bush 2")
        bush1.position = CGPoint(x: sceneFrame.width * 0.83, y: sceneFrame.height * 0.11)
        bush1.setScale(1)
        bush1.zPosition = 6
        bush1.isUserInteractionEnabled = false
        
        bush2 = .init(imageNamed: "Bush 3")
        bush2.position = CGPoint(x: sceneFrame.width * 0.41, y: sceneFrame.height * 0.23)
        bush2.setScale(1)
        bush2.zPosition = 4
        bush2.isUserInteractionEnabled = false
        
        wood = .init(imageNamed: "Wood Log")
        wood.position = CGPoint(x: sceneFrame.width * 0.64, y: sceneFrame.height * 0.17)
        wood.setScale(1)
        wood.zPosition = 5
        wood.isUserInteractionEnabled = false
        
        rocks = .init(imageNamed: "Rocks")
        rocks.position = CGPoint(x: sceneFrame.width * 0.27 , y: sceneFrame.height * 0.18)
        rocks.setScale(1)
        rocks.zPosition = 6
        rocks.isUserInteractionEnabled = false
        
        addChild(background)
        addChild(background1)
        addChild(background2)
        addChild(background3)
        addChild(background4)
        addChild(bush)
        addChild(bush1)
        addChild(bush2)
        addChild(wood)
        addChild(rocks)
    }
    override func contains(_ p: CGPoint) -> Bool {
        return false
    }
    
}
