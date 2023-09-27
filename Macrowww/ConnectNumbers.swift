//
//  GameScene.swift
//  ConnectNumbers
//
//  Created by Jessica Rachel on 21/09/23.
//

import SpriteKit
import GameplayKit

class ConnectNumbers: SKScene {
    
    let joystickBase = SKSpriteNode(imageNamed: "blackCircle")
    let joystickKnob = SKSpriteNode(imageNamed: "whiteCircle")
    let objectNode = SKSpriteNode(imageNamed: "spiderPng")
    
    var isJoystickActive = false
    var initialObjectPosition: CGPoint?
    var hasCollidedThisFrame = false
    
    var drawingPath = CGMutablePath()
    var drawingNode: SKShapeNode?
    var nextDotNumber = 1
    
    let dotPositions: [CGPoint] = [
        CGPoint(x: 100, y: 100),
        CGPoint(x: 200, y: 200),
        CGPoint(x: 300, y: 300),
        // Add more positions as needed
    ]
    
    override func didMove(to view: SKView) {
        self.size = view.bounds.size
        self.scaleMode = .aspectFill
        
        joystickBase.position = CGPoint(x: 260, y: -150)
        joystickKnob.position = CGPoint(x: 260, y: -150)
        
        let baseSize = CGSize(width: 100, height: 100)
        let knobSize = CGSize(width: 50, height: 50)
        
        joystickBase.size = baseSize
        joystickKnob.size = knobSize
        
        joystickBase.zPosition = 0
        joystickKnob.zPosition = 1
        
        let objectSize = CGSize(width: 50, height: 50)
        objectNode.size = objectSize
        objectNode.zPosition = 2
        
        // Store the initial position of the object node
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
            let dot = SKShapeNode(circleOfRadius: 10)
            dot.position = position
            dot.fillColor = .red
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
                dot.fillColor = .red
             
            }
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        for dot in children where dot is SKShapeNode && dot.name == "dot" {
            if let shapeDot = dot as? SKShapeNode {
                if shapeDot.fillColor != .green {
                    if objectNode.frame.intersects(shapeDot.frame) {
                        if let labelNode = dot.childNode(withName: "label") as? SKLabelNode {
                            if let labelText = labelNode.text, let dotNumber = Int(labelText) {
                                if dotNumber == nextDotNumber {
                                    print("Collided with dot number: \(dotNumber)")
                                    // Change dot's color
                                    shapeDot.fillColor = .green
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
