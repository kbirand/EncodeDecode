//
//  ViewController.swift
//  Enc
//
//  Created by Koray Birand on 23.10.2018.
//  Copyright © 2018 Koray Birand. All rights reserved.
//

import Cocoa
import CryptoSwift




class ViewController: NSViewController {
    
    @IBOutlet weak var stringToEn: NSTextField!
    @IBOutlet weak var keyEn: NSTextField!
    @IBOutlet weak var outputEn: NSTextField!
    
    //Descrypt Outlet
    @IBOutlet weak var stringToDes: NSTextField!
    @IBOutlet weak var keyDes: NSTextField!
    @IBOutlet weak var outputDes: NSTextField!

    
    @IBAction func encyptPressed(_ sender: Any) {
        let input = stringToEn.stringValue
        let key = keyEn.stringValue
        let iv = "gqLOHUioQ0QjhuvI"
        let en = try! input.aesEncrypt(key: key, iv: iv)
        outputEn.stringValue = en
        
        
    }
    @IBAction func descyptPressed(_ sender: Any) {
        let input = stringToDes.stringValue
        let key = keyDes.stringValue
        let iv = "gqLOHUioQ0QjhuvI"
        let des = try! input.aesDecrypt(key: key, iv: iv)
        outputDes.stringValue = des
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension String{
    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](data))
        
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
        
    }
}
