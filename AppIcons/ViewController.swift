//
//  ViewController.swift
//  AppIcons
//
//  Created by Laptop on 6/29/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var action = 0
    var image  = NSImage()
    
    @IBOutlet weak var labelType: NSTextField!
    @IBOutlet weak var imageMain: NSImageView!
    
    // MAC
    @IBOutlet weak var image016A: NSImageView!
    @IBOutlet weak var image016B: NSImageView!
    @IBOutlet weak var image032A: NSImageView!
    @IBOutlet weak var image032B: NSImageView!
    @IBOutlet weak var image128A: NSImageView!
    @IBOutlet weak var image128B: NSImageView!
    @IBOutlet weak var image256A: NSImageView!
    @IBOutlet weak var image256B: NSImageView!
    @IBOutlet weak var image512A: NSImageView!
    @IBOutlet weak var image512B: NSImageView!

    // IOS
    @IBOutlet weak var imageI01A: NSImageView!
    @IBOutlet weak var imageI01B: NSImageView!
    @IBOutlet weak var imageI02A: NSImageView!
    @IBOutlet weak var imageI02B: NSImageView!
    @IBOutlet weak var imageI03A: NSImageView!
    @IBOutlet weak var imageI03B: NSImageView!
    @IBOutlet weak var imageI04A: NSImageView!
    @IBOutlet weak var imageI04B: NSImageView!
    @IBOutlet weak var imageI05A: NSImageView!
    @IBOutlet weak var imageI05B: NSImageView!
    @IBOutlet weak var imageI06A: NSImageView!
    @IBOutlet weak var imageI06B: NSImageView!
    @IBOutlet weak var imageI07A: NSImageView!
    @IBOutlet weak var imageI07B: NSImageView!
    @IBOutlet weak var imageI08A: NSImageView!
    @IBOutlet weak var imageI08B: NSImageView!
    @IBOutlet weak var imageI09A: NSImageView!
    @IBOutlet weak var imageI09B: NSImageView!
    
    @IBOutlet weak var buttonFolder: NSButton!
    @IBOutlet weak var buttonExport: NSButton!
    @IBOutlet weak var tabView: NSTabView!
    
    @IBAction func onIconType(_ sender: Any) {
        action = (sender as! NSSegmentedControl).selectedSegment
        switch action {
        case 0: tabView.selectTabViewItem(at: 0); labelType.stringValue = "for macOS"
        case 1: tabView.selectTabViewItem(at: 1); labelType.stringValue = "for iOS"
        default: break
        }
    }
    
    @IBAction func onSelected(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseFiles = true
        dialog.canChooseDirectories = false
        let choice = dialog.runModal()
        
        if choice.rawValue == NSFileHandlingPanelOKButton {
            if let url = dialog.url {
                showMainImage(url)
                generateImages()
            }
        }
    }
    
    @IBAction func openFolder(_ sender: Any) {
        let folder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        NSWorkspace.shared.open(folder)
    }

    @IBAction func onExport(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseFiles = false
        dialog.canChooseDirectories = true
        let choice = dialog.runModal()
        
        if choice.rawValue == NSFileHandlingPanelOKButton {
            if let folder = dialog.url {
                if action == 1 {
                    saveIosIconset(folder)
                } else {
                    saveMacIconset(folder)
                }
            }
        }
    }

    
    func showMainImage(_ url: URL) {
        self.image = NSImage(byReferencingFile: url.path)!
        DispatchQueue.main.async { self.imageMain.image = self.image }
    }
    
    func generateImages() {
        var folder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        folder.appendPathComponent("AppIcon.appiconset", isDirectory: true)
        var isFolder: ObjCBool = true
        if !FileManager.default.fileExists(atPath: folder.path, isDirectory: &isFolder) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
        }
        
        // First generate all icons
        DispatchQueue.main.async {
            // macOS
            self.image016A.image = self.image.resize(  16,  16);
            self.image016B.image = self.image.resize(  32,  32);
            self.image032A.image = self.image.resize(  32,  32);
            self.image032B.image = self.image.resize(  64,  64);
            self.image128A.image = self.image.resize( 128, 128);
            self.image128B.image = self.image.resize( 256, 256);
            self.image256A.image = self.image.resize( 256, 256);
            self.image256B.image = self.image.resize( 512, 512);
            self.image512A.image = self.image.resize( 512, 512);
            self.image512B.image = self.image.resize(1024,1024);
            // iOS
            self.imageI01A.image = self.image.resize(  40,  40);
            self.imageI01B.image = self.image.resize(  60,  60);
            self.imageI02A.image = self.image.resize(  58,  58);
            self.imageI02B.image = self.image.resize(  87,  87);
            self.imageI03A.image = self.image.resize(  80,  80);
            self.imageI03B.image = self.image.resize( 120, 120);
            self.imageI04A.image = self.image.resize( 120, 120);
            self.imageI04B.image = self.image.resize( 180, 180);
            self.imageI05A.image = self.image.resize(  20,  20);
            self.imageI05B.image = self.image.resize(  40,  40);
            self.imageI06A.image = self.image.resize(  29,  29);
            self.imageI06B.image = self.image.resize(  58,  58);
            self.imageI07A.image = self.image.resize(  40,  40);
            self.imageI07B.image = self.image.resize(  80,  80);
            self.imageI08A.image = self.image.resize(  76,  76);
            self.imageI08B.image = self.image.resize( 152, 152);
            //self.imageI09A.image = self.image.resize(  84,  84);
            self.imageI09B.image = self.image.resize( 167, 167);
        }
        
        // Then save only selected OS
        if action == 1 {
            saveIosIconset(folder)
        } else {
            saveMacIconset(folder)
        }
        
        buttonFolder.isHidden = false
        buttonExport.isHidden = false
    }
    
    func saveIosIconset(_ url: URL) {
        let path = url.absoluteString
        let json = url.appendingPathComponent("Contents.json")

        DispatchQueue.main.async {
            // Generate Contents.json
            if let source = Bundle.main.url(forResource: "Contents_ios", withExtension: "json") {
                try? FileManager.default.removeItem(at: json)           // Remove
                try? FileManager.default.copyItem(at: source, to: json) // Create
            }
            // Save ios icons
            self.imageI01A.image?.save(path + "iphone020pts2x.png")
            self.imageI01B.image?.save(path + "iphone020pts3x.png")
            self.imageI02A.image?.save(path + "iphone029pts2x.png")
            self.imageI02B.image?.save(path + "iphone029pts3x.png")
            self.imageI03A.image?.save(path + "iphone040pts2x.png")
            self.imageI03B.image?.save(path + "iphone040pts3x.png")
            self.imageI04A.image?.save(path + "iphone060pts2x.png")
            self.imageI04B.image?.save(path + "iphone060pts3x.png")
            self.imageI05A.image?.save(path + "ipad020pts1x.png")
            self.imageI05B.image?.save(path + "ipad020pts2x.png")
            self.imageI06A.image?.save(path + "ipad029pts1x.png")
            self.imageI06B.image?.save(path + "ipad029pts2x.png")
            self.imageI07A.image?.save(path + "ipad040pts1x.png")
            self.imageI07B.image?.save(path + "ipad040pts2x.png")
            self.imageI08A.image?.save(path + "ipad076pts1x.png")
            self.imageI08B.image?.save(path + "ipad076pts2x.png")
            //self.imageI09A.image?.save(path + "ipad083pts1x.png")
            self.imageI09B.image?.save(path + "ipad083pts2x.png")
        }

    }
    
    func saveMacIconset(_ url: URL) {
        let path = url.absoluteString
        let json = url.appendingPathComponent("Contents.json")

        DispatchQueue.main.async {
            // Generate Contents.json
            if let source = Bundle.main.url(forResource: "Contents_mac", withExtension: "json") {
                try? FileManager.default.removeItem(at: json)           // Remove
                try? FileManager.default.copyItem(at: source, to: json) // Create
            }
            // Save mac icons
            self.image016A.image?.save(path + "mac016pts1x.png")
            self.image016B.image?.save(path + "mac016pts2x.png")
            self.image032A.image?.save(path + "mac032pts1x.png")
            self.image032B.image?.save(path + "mac032pts2x.png")
            self.image128A.image?.save(path + "mac128pts1x.png")
            self.image128B.image?.save(path + "mac128pts2x.png")
            self.image256A.image?.save(path + "mac256pts1x.png")
            self.image256B.image?.save(path + "mac256pts2x.png")
            self.image512A.image?.save(path + "mac512pts1x.png")
            self.image512B.image?.save(path + "mac512pts2x.png")
        }
    }
    
}


// NSIMAGE EXTENSIONS

extension NSImage {
    var pngData: Data? {
        guard
            let tiffRepresentation = tiffRepresentation,
            let bitmapImage = NSBitmapImageRep(data: tiffRepresentation)
            else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
    
    func resize(_ width: CGFloat, _ height: CGFloat) -> NSImage {
        let img = NSImage(size: CGSize(width: width, height: height))
        img.lockFocus()
        let ctx = NSGraphicsContext.current
        ctx?.imageInterpolation = .high
        let oldRect = NSMakeRect(0, 0, size.width, size.height)
        let newRect = NSMakeRect(0, 0, width, height)
        self.draw(in: newRect, from: oldRect, operation: .copy, fraction: 1)
        img.unlockFocus()
        
        return img
    }

    @discardableResult
    func save(_ path: String) -> Bool {
        guard let url = URL(string: path) else { return false }
        
        do {
            try pngData?.write(to: url, options: .atomic)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

// End
