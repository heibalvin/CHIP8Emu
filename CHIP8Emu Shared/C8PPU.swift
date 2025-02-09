//
//  C8GPU.swift
//  CHIP8Emu
//
//  Created by heibalvin on 08/02/2025.
//

import SpriteKit

class C8PPU {
    let cols = 64
    let rows = 32
    var pixels: [Bool]
    var tilesize = 10
    var node: SKNode
    
    func dump() {
        print("PPU: \(cols) x \(rows)")
        var str = ""
        for row in 0...rows-1 {
            for col in 0...cols-1 {
                str += getPixel(col: col, row: row) == true ? "■" : "-"
            }
            str += "\n"
        }
        print(str)
    }
    
    init() {
        pixels = Array(repeating: false, count: cols * rows)
        node = SKNode()
        node.name = "PPU"
    }
    
    func coord2index(col: Int, row: Int) -> Int {
        return row * cols + col
    }
    
    func coord2pos(col: Int, row: Int) -> CGPoint {
        return CGPoint(x: col * tilesize + tilesize / 2, y: (rows - row - 1) * tilesize + tilesize / 2)
    }
    
    func getPixel(col: Int, row: Int) -> Bool {
        return pixels[ coord2index(col: col, row: row) ]
    }
    
    func drawPixel(col: Int, row: Int, value: Bool) {
        if (value == true) {
            let pixel = SKShapeNode(rectOf: CGSize(width: tilesize, height: tilesize))
            pixel.name = "pixel"
            pixel.fillColor = .white
            pixel.position = coord2pos(col: col, row: row)
            node.addChild(pixel)
        } else {
            let pixel = node.atPoint(coord2pos(col: col, row: row))
            if pixel.name == "pixel" {
                pixel.removeFromParent()
            }
        }
        pixels[ coord2index(col: col, row: row) ] = value
    }
    
    func drawByte(col: Int, row: Int, byte: UInt8) {
        for n in 0...7 {
            // 7 - n instead of n since bit are read from right to left.
            let value = byte.bit(7 - n)
            drawPixel(col: col + n, row: row, value: value)
        }
    }
    
    func drawSprite(col: Int, row: Int, bytes: [UInt8]) {
        for (id, byte) in bytes.enumerated() {
            drawByte(col: col, row: row + id, byte: byte)
        }
    }
    
    func xorPixel(col: Int, row: Int, value: Bool) {
        let pixel = getPixel(col: col, row: row)
        if (pixel == true) && (value == true) {
            // 1 XOR 1 = 0
            drawPixel(col: col, row: row, value: false)
            return
        } else if (pixel == false) && (value == false) {
            // 0 XOR 0 = 0 => do nothing pixel is already off
            return
        } else if (pixel == true) && (value == false) {
            // 1 XOR 0 = 1 => do nothing pixel is already on
            return
        }
        // 0 XOR 1
        drawPixel(col: col, row: row, value: true)
    }
    
    func xorByte(col: Int, row: Int, byte: UInt8) {
        for n in 0...7 {
            // 7 - n instead of n since bit are read from right to left.
            let value = byte.bit(7 - n)
            xorPixel(col: col + n, row: row, value: value)
        }
    }
    
    func xorSprite(col: Int, row: Int, bytes: [UInt8]) {
        for (id, byte) in bytes.enumerated() {
            xorByte(col: col, row: row + id, byte: byte)
        }
    }
}
