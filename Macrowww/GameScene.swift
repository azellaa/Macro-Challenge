//  GameScene.swift
//  ConnectNumbers
//
//  Created by Jessica Rachel on 21/09/23.


import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let joystickBase = SKSpriteNode(imageNamed: "Joystick_Circle")
    let joystickKnob = SKSpriteNode(imageNamed: "Joystick_Spider")
    let objectNode = SKSpriteNode(imageNamed: "Spider")
    
    var isJoystickActive = false
    var initialObjectPosition: CGPoint?
    var hasCollidedThisFrame = false
    
    var drawingPath = CGMutablePath()
    var drawingNode: SKShapeNode?
    var nextDotNumber = 1
    
    let customColor = UIColor(red: 0xA4 / 255.0, green: 0x78 / 255.0, blue: 0x69 / 255.0, alpha: 1.0)
    
    let dotPositions: [CGPoint] = [
        CGPoint(x: 570 - 577, y: 308 - 417),
        CGPoint(x: 649 - 577, y: 347 - 417),
        CGPoint(x: 676 - 577, y: 414 - 417),
        CGPoint(x: 656 - 577, y: 465 - 417),
        CGPoint(x: 577 - 577, y: 508 - 417),
        CGPoint(x: 508 - 577, y: 476 - 417),
        CGPoint(x: 476 - 577, y: 417 - 417),
        CGPoint(x: 485 - 577, y: 352 - 417),
        CGPoint(x: 411 - 577, y: 313 - 417),
        CGPoint(x: 398 - 577, y: 417 - 417),
        CGPoint(x: 449 - 577, y: 524 - 417),
        CGPoint(x: 580 - 577, y: 587 - 417),
        CGPoint(x: 724 - 577, y: 504 - 417),
        CGPoint(x: 760 - 577, y: 408 - 417),
        CGPoint(x: 704 - 577, y: 301 - 417),
        CGPoint(x: 565 - 577, y: 226 - 417),
        CGPoint(x: 566 - 577, y: 152 - 417),
        CGPoint(x: 753 - 577, y: 255 - 417),
        CGPoint(x: 833 - 577, y: 410 - 417),
        CGPoint(x: 780 - 577, y: 538 - 417),
        CGPoint(x: 581 - 577, y: 664 - 417),
        CGPoint(x: 398 - 577, y: 572 - 417),
        CGPoint(x: 323 - 577, y: 417 - 417),
        CGPoint(x: 345 - 577, y: 271 - 417),
        CGPoint(x: 281 - 577, y: 233 - 417),
        CGPoint(x: 248 - 577, y: 422 - 417),
        CGPoint(x: 350 - 577, y: 616 - 417),
        CGPoint(x: 586 - 577, y: 734 - 417),
        CGPoint(x: 841 - 577, y: 578 - 417),
        CGPoint(x: 905 - 577, y: 406 - 417),
        CGPoint(x: 801 - 577, y: 210 - 417),
        CGPoint(x: 560 - 577, y: 86 - 417)
    ]

    
    override func didMove(to view: SKView) {
        self.size = view.bounds.size
        self.scaleMode = .aspectFill

        // Create a background image with the size of the scene
        let backgroundImage = SKSpriteNode(imageNamed: "LeavesBackground")
        backgroundImage.size = self.size // Set the image size to match the scene size
        backgroundImage.position = CGPoint(x: 0, y: 0)
        backgroundImage.zPosition = -2 // Set it behind other nodes
        addChild(backgroundImage)
        
//        let SpiderWebImage = SKSpriteNode(imageNamed: "SpiderWeb")
//        backgroundImage.size = self.size // Set the image size to match the scene size
//        backgroundImage.position = CGPoint(x: 0, y: 0)
//        backgroundImage.zPosition = -1 // Set it behind other nodes
//        addChild(SpiderWebImage)
        
        self.size = view.bounds.size
        self.scaleMode = .aspectFill
        
        joystickBase.position = CGPoint(x: 400, y: -260)
        joystickKnob.position = CGPoint(x: 400, y: -260)
        
//        let baseSize = CGSize(width: 100, height: 100)
//        let knobSize = CGSize(width: 50, height: 50)
//
//        joystickBase.size = baseSize
//        joystickKnob.size = knobSize
        
        joystickBase.zPosition = 0
        joystickKnob.zPosition = 1
        
        let objectSize = CGSize(width: size.width/25, height: size.height/25)
        objectNode.size = objectSize
        objectNode.zPosition = 2
        
        // Store the initial position of the object node
        objectNode.position = CGPoint(x: -7, y: -10)
        initialObjectPosition = objectNode.position
        
        drawingPath.move(to: objectNode.position)
        
        drawingNode = SKShapeNode(path: drawingPath)
        drawingNode?.strokeColor = UIColor.systemPink
        drawingNode?.lineWidth = 10.0
        drawingNode?.zPosition = 2
        
        addChild(joystickBase)
        addChild(joystickKnob)
        addChild(objectNode)
        addChild(drawingNode!)
        
        for (index, position) in dotPositions.enumerated() {
            let dot = SKShapeNode(circleOfRadius: 15)
            dot.position = position
            dot.fillColor = SKColor(cgColor: customColor.cgColor)
            dot.name = "dot"  // Add a unique name to each dot
            
            let label = SKLabelNode(text: "\(index + 1)")
            label.name = "label"  // Add a name to the label for future reference
            label.position = CGPoint(x: 0, y: -10)
            label.fontName = "AvenirNext-Bold"
            label.fontSize = 18
            label.fontColor = .white
            
            dot.addChild(label)
            addChild(dot)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if joystickKnob.contains(location) {
                isJoystickActive = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isJoystickActive else { return }
        
        for touch in touches {
            let location = touch.location(in: self)
            let baseCenter = joystickBase.position
            let dx = location.x - baseCenter.x
            let dy = location.y - baseCenter.y
            let angle = atan2(dy, dx)
            let maxDistance = joystickBase.size.width / 2
            let actualDistance = min(sqrt(dx * dx + dy * dy), maxDistance)
            let newPosition = CGPoint(x: baseCenter.x + actualDistance * cos(angle), y: baseCenter.y + actualDistance * sin(angle))
            
            joystickKnob.position = newPosition
            let moveSpeed: CGFloat = 5.0
            objectNode.position.x += cos(angle) * moveSpeed
            objectNode.position.y += sin(angle) * moveSpeed
            
            drawingPath.addLine(to: objectNode.position)
            
            if let drawingNode = drawingNode {
                drawingNode.path = drawingPath
            } else {
                let newDrawingNode = SKShapeNode(path: drawingPath)
                newDrawingNode.strokeColor = SKColor.white
                newDrawingNode.lineWidth = 10.0
                newDrawingNode.zPosition = 2
                addChild(newDrawingNode)
                drawingNode = newDrawingNode
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isJoystickActive = false
        joystickKnob.position = joystickBase.position
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func resetLine() {
        drawingPath = CGMutablePath()
        drawingPath.move(to: objectNode.position)

        // Remove the drawing node from the scene
        if let drawingNode = drawingNode {
            drawingNode.removeFromParent()
            self.drawingNode = nil // Set the drawingNode to nil to indicate it's removed
        }

        // Create a new drawing node with system pink stroke color
        let newDrawingNode = SKShapeNode(path: drawingPath)
        newDrawingNode.strokeColor = UIColor.systemPink
        newDrawingNode.lineWidth = 10.0
        newDrawingNode.zPosition = 2
        addChild(newDrawingNode)
        drawingNode = newDrawingNode

        nextDotNumber = 1 // Reset the dot order
    }

    
    func resetGame() {
        // Reset the object node to its initial position
        if let initialPosition = initialObjectPosition {
            objectNode.position = initialPosition
        }
        
        // Reset the drawing path and dot order
        resetLine()
        
        nextDotNumber = 1
        
        // Reset dot colors to red
        for node in children where node is SKShapeNode && node.name == "dot" {
            if let dot = node as? SKShapeNode {
                dot.fillColor = SKColor(cgColor: customColor.cgColor)
             
            }
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        for dot in children where dot is SKShapeNode && dot.name == "dot" {
            if let shapeDot = dot as? SKShapeNode {
                if shapeDot.fillColor != .blue {
                    if objectNode.frame.intersects(shapeDot.frame) {
                        if let labelNode = dot.childNode(withName: "label") as? SKLabelNode {
                            if let labelText = labelNode.text, let dotNumber = Int(labelText) {
                                if dotNumber == nextDotNumber {
                                    print("Collided with dot number: \(dotNumber)")
                                    // Change dot's color
                                    shapeDot.fillColor = .blue
                                    nextDotNumber += 1
                                } else {
                                    // Handle incorrect order collision
                                    print("Collided with dot number: \(dotNumber) out of order")
                                    resetGame()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
