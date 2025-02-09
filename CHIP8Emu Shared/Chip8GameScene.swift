//
//  Chip8GameScene.swift
//  CHIP8Emu
//
//  Created by heibalvin on 07/02/2025.
//

import SpriteKit

class Chip8GameScene: SKScene {
    var MEM = C8MEM()
    var PPU = C8PPU()
    
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
        
        addChild(PPU.node)
        
        PPU.drawPixel(col: 1, row: 1, value: true)
        PPU.drawByte(col: 5, row: 1, byte: 0xF0)
        PPU.drawSprite(col: 10, row: 1, bytes: [ 0xF0, 0x10, 0xF0, 0x80, 0xF0 ])
        
        PPU.xorSprite(col: 5, row: 10, bytes: [ 0xF0, 0x10, 0xF0, 0x80, 0xF0 ])
        PPU.xorSprite(col: 10, row: 10, bytes: [ 0xF0, 0x90, 0x90, 0x90, 0xF0  ])
        PPU.xorSprite(col: 15, row: 10, bytes: [ 0xF0, 0x10, 0xF0, 0x80, 0xF0 ])
        PPU.xorSprite(col: 15, row: 10, bytes: [ 0xF0, 0x90, 0x90, 0x90, 0xF0 ])
        PPU.dump()
    }
}
