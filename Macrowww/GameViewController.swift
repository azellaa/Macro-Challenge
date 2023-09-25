//
//  GameViewController.swift
//  Macrowww
//
//  Created by Azella Mutyara on 21/09/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = HideAndSeekScene()
        scene.size = view.bounds.size
        scene.scaleMode = .aspectFill
        
        let skView = view as! SKView
        skView.ignoresSiblingOrder = false
        skView.presentScene(scene)
//        skView.showsPhysics = true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
