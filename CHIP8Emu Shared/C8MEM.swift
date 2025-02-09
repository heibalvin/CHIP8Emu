//
//  C8MEM.swift
//  CHIP8Emu
//
//  Created by heibalvin on 07/02/2025.
//

import Foundation

extension UInt8 {
    func hex() -> String {
        String(format: "%02X", self)
    }
    
    func bit(_ pos: Int) -> Bool {
        let mask: UInt8 = 1 << pos
        return ((self & mask) == mask)
    }
}

extension UInt16 {
    func hex() -> String {
        String(format: "%04X", self)
    }
}

class C8MEM {
    var bytes: [UInt8] = Array(repeating: 0x00, count: 4 * 1024)
    
    func dump() {
        print("MEM")
        var addr: UInt16 = 0x0000
        while addr < bytes.count {
            var str = addr.hex() + " : "
            var isBlank = true
            var count = 0
            while count < 16 {
                let byte = bytes[Int(addr)+count]
                if byte != 0x00 {
                    isBlank = false
                }
                str += byte.hex() + " "
                count += 1
            }
            addr += 16
            if !isBlank {
                print(str)
            }
        }
    }
    
    func load(bundle filename: String, ext: String = "ch8") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: ext) else {
            NSLog("ERROR: Cannot find ROM file \(filename).\(ext).")
            return
        }
        
        do {
            let datas = try Data(contentsOf: url)
            var addr = 0x0200
            for data in datas {
                bytes[addr] = data
                addr += 1
            }
        } catch {
            NSLog("ERROR: Cannot open ROM file \(filename).\(ext).")
        }
    }
}
