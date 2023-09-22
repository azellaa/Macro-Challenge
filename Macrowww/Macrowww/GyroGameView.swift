//
//  GyroGameView.swift
//  Macrowww
//
//  Created by Azella Mutyara on 21/09/23.
//

import SwiftUI
import CoreMotion

import SwiftUI
import CoreMotion

struct GyroGameView: View {
    @State private var position = CGPoint(x: 200, y: 200)
    @State private var velocity = CGVector(dx: 0, dy: 0)
    private let friction: CGFloat = 0.98
    private let acceleration: CGFloat = 0.4

    let motionManager = CMMotionManager()

    init() {
        motionManager.startDeviceMotionUpdates()
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0 // 60 Hz updates
        motionManager.startGyroUpdates()
    }

    var body: some View {
        Circle()
            .frame(width: 50, height: 50)
            .foregroundColor(.blue)
            .position(position)
            .onAppear {
                // Update the ball's position based on gyro data
                Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
                    if let gyroData = motionManager.gyroData {
                        let rotationRate = gyroData.rotationRate

                        // Create a copy of position and velocity
                        var newPosition = self.position
                        var newVelocity = self.velocity

                        // Update the new velocity based on gyroscope data
                        newVelocity.dx += CGFloat(rotationRate.y) * self.acceleration
                        newVelocity.dy += CGFloat(rotationRate.x) * self.acceleration

                        // Apply friction to gradually slow down the ball
                        newVelocity.dx *= self.friction
                        newVelocity.dy *= self.friction

                        // Update the new position based on the new velocity
                        newPosition.x += newVelocity.dx
                        newPosition.y += newVelocity.dy

                        // Limit the ball's position within the screen bounds
                        newPosition.x = max(25, min(newPosition.x, UIScreen.main.bounds.width - 25))
                        newPosition.y = max(25, min(newPosition.y, UIScreen.main.bounds.height - 25))

                        // Update the @State properties with the new values
                        self.position = newPosition
                        self.velocity = newVelocity
                    }
                }
            }
    }
}


struct GyroGameView_Previews: PreviewProvider {
    static var previews: some View {
        GyroGameView()
    }
}
