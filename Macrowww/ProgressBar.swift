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
    
    private let progressTexture = SKTexture(imageNamed: "4Bar")
    private let progressContainerTexture = SKTexture(imageNamed: "EmptyBar")
    
    private var sceneFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
        maxProgressBarWidth = sceneFrame.width * 0.51
    }
    
    func buildProgressBar() {
        progressBarContainer = SKSpriteNode(texture: progressContainerTexture, size: progressContainerTexture.size())
        progressBarContainer.zPosition = 10
        
        progressBar = SKSpriteNode(texture: progressTexture, size: progressTexture.size())
        progressBar.size.width = CGFloat(maxProgressBarWidth)
        progressBar.size.height = CGFloat(progressBarContainer.size.height * 0.45)
        progressBar.zPosition = 15
        progressBar.position.x = -maxProgressBarWidth / 2.36
        progressBar.position.y = progressBarContainer.position.y + 1
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        addChild(progressBarContainer)
        addChild(progressBar)
    }
    
    func updateProgressBar(_ progress: CGFloat) {
        print(progress)
        switch progress {
        case 0...25 :
            progressBar.texture = SKTexture(imageNamed: "1Bar")
        case 26...50 :
            progressBar.texture = SKTexture(imageNamed: "2Bar")
        case 51...75 :
            progressBar.texture = SKTexture(imageNamed: "3Bar")
        default :
            progressBar.texture = SKTexture(imageNamed: "4Bar")
        }
        progressBar.run(SKAction.resize(toWidth: CGFloat(progress / maxProgress) * maxProgressBarWidth, duration: 0.2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
