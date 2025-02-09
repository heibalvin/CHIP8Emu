//
//  Chip8GameScene.swift
//  CHIP8Emu
//
//  Created by heibalvin on 07/02/2025.
//

import SpriteKit

class Chip8GameScene: SKScene {
    var MEM = C8MEM()
    
    class func newGameScene() -> Chip8GameScene {
        let scene = Chip8GameScene(size: CGSize(width: 64 * 10, height: 32 * 10))
        scene.scaleMode = .aspectFit
        scene.name = "scene"
        scene.backgroundColor = .darkGray
        scene.anchorPoint = .zero
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        MEM.load(bundle: "IBM Logo")
        MEM.dump()
    }
}
