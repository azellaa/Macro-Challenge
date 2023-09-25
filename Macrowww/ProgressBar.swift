//
//  ProgressBar.swift
//  Macrowww
//
//  Created by Priskilla Adriani on 25/09/23.
//

import SpriteKit

class ProgressBar: SKNode {
    
    private var maxProgress = CGFloat(100)
    private var maxProgressBarWidth = CGFloat(0)
    
    private var progressBar = SKSpriteNode()
    private var progressBarContainer = SKSpriteNode()
    
    private let progressTexture = SKTexture(imageNamed: "4")
    private let progressContainerTexture = SKTexture(imageNamed: "blackPB")
    
    private var sceneFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
        maxProgressBarWidth = sceneFrame.width * 0.58
    }
    
    func buildProgressBar() {
        progressBarContainer = SKSpriteNode(texture: progressContainerTexture, size: progressContainerTexture.size())
        progressBarContainer.size.width = sceneFrame.width * 0.6
        progressBarContainer.size.height = sceneFrame.height * 0.08
        
        progressBar = SKSpriteNode(texture: progressTexture, size: progressTexture.size())
        progressBar.size.width = 0
        progressBar.size.height = sceneFrame.height * 0.05
        progressBar.position.x = -maxProgressBarWidth / 2
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        addChild(progressBarContainer)
        addChild(progressBar)
    }
    
    func updateProgressBar(_ progress: CGFloat) {
        print(progress)
        switch progress {
        case 0...25 :
            progressBar.texture = SKTexture(imageNamed: "1")
        case 26...50 :
            progressBar.texture = SKTexture(imageNamed: "2")
        case 51...75 :
            progressBar.texture = SKTexture(imageNamed: "3")
        default :
            progressBar.texture = SKTexture(imageNamed: "4")
        }
        progressBar.run(SKAction.resize(toWidth: CGFloat(progress / maxProgress) * maxProgressBarWidth, duration: 0.2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
