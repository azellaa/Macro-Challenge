//
//  NewPage.swift
//  Macrowww
//
//  Created by Priskilla Adriani on 25/09/23.
//

import SpriteKit
import GameplayKit

class NewPage: SKScene, SKPhysicsContactDelegate {
    
    var progressBar = ProgressBar()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        
        progressBar.getSceneFrame(sceneFrame: frame)
        progressBar.buildProgressBar()
        progressBar.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(progressBar)
        
        var count = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if count >= 100 { timer.invalidate() }
            
            self.progressBar.updateProgressBar(CGFloat(count))
            
            count += 1
        }
    }
}
