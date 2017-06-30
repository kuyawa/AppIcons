//
//  ViewController.swift
//  AppIcons
//
//  Created by Laptop on 6/29/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var image  = NSImage()
    var images = [String: NSImage]()
    
    @IBOutlet weak var imageMain: NSImageView!
    
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
    
    @IBOutlet weak var buttonFolder: NSButton!
    
    @IBAction func onSelected(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseFiles = true
        dialog.canChooseDirectories = false
        let choice = dialog.runModal()
        
        if choice == NSFileHandlingPanelOKButton {
            if let url = dialog.url {
                showMainImage(url)
                generateImages()
            }
        }
    }
    
    @IBAction func openFolder(_ sender: Any) {
        let folder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        NSWorkspace.shared().open(folder)
    }
    
    func showMainImage(_ url: URL) {
        image = NSImage(byReferencingFile: url.path)!
        imageMain.image = image
    }
    
    func generateImages() {
        // Resize them all
        images["016A"] = image.resize(  16,  16) // appicon_016pts_1X.png
        images["016B"] = image.resize(  32,  32) // appicon_016pts_2X.png
        images["032A"] = image.resize(  32,  32) // appicon_032pts_1X.png
        images["032B"] = image.resize(  64,  64) // appicon_032pts_2X.png
        images["128A"] = image.resize( 128, 128) // appicon_128pts_1X.png
        images["128B"] = image.resize( 256, 256) // appicon_128pts_2X.png
        images["256A"] = image.resize( 256, 256) // appicon_256pts_1X.png
        images["256B"] = image.resize( 512, 512) // appicon_256pts_2X.png
        images["512A"] = image.resize( 512, 512) // appicon_512pts_1X.png
        images["512B"] = image.resize(1024,1024) // appicon_512pts_2X.png
        // Save them all
        DispatchQueue.main.async { self.image016A.image = self.images["016A"]; self.images["016A"]?.saveToDownloads("appicon_016pts_1X.png") }
        DispatchQueue.main.async { self.image016B.image = self.images["016B"]; self.images["016B"]?.saveToDownloads("appicon_016pts_2X.png") }
        DispatchQueue.main.async { self.image032A.image = self.images["032A"]; self.images["032A"]?.saveToDownloads("appicon_032pts_1X.png") }
        DispatchQueue.main.async { self.image032B.image = self.images["032B"]; self.images["032B"]?.saveToDownloads("appicon_032pts_2X.png") }
        DispatchQueue.main.async { self.image128A.image = self.images["128A"]; self.images["128A"]?.saveToDownloads("appicon_128pts_1X.png") }
        DispatchQueue.main.async { self.image128B.image = self.images["128B"]; self.images["128B"]?.saveToDownloads("appicon_128pts_2X.png") }
        DispatchQueue.main.async { self.image256A.image = self.images["256A"]; self.images["256A"]?.saveToDownloads("appicon_256pts_1X.png") }
        DispatchQueue.main.async { self.image256B.image = self.images["256B"]; self.images["256B"]?.saveToDownloads("appicon_256pts_2X.png") }
        DispatchQueue.main.async { self.image512A.image = self.images["512A"]; self.images["512A"]?.saveToDownloads("appicon_512pts_1X.png") }
        DispatchQueue.main.async { self.image512B.image = self.images["512B"]; self.images["512B"]?.saveToDownloads("appicon_512pts_2X.png") }
        
        buttonFolder.isHidden = false
    }
}


// NSIMAGE EXTENSIONS

extension NSImage {
    var pngData: Data? {
        guard
            let tiffRepresentation = tiffRepresentation,
            let bitmapImage = NSBitmapImageRep(data: tiffRepresentation)
            else { return nil }
        return bitmapImage.representation(using: .PNG, properties: [:])
    }
    
    func resize(_ width: CGFloat, _ height: CGFloat) -> NSImage {
        let img = NSImage(size: CGSize(width: width, height: height))
        img.lockFocus()
        let ctx = NSGraphicsContext.current()
        ctx?.imageInterpolation = .high
        let oldRect = NSMakeRect(0, 0, size.width, size.height)
        let newRect = NSMakeRect(0, 0, width, height)
        self.draw(in: newRect, from: oldRect, operation: .copy, fraction: 1)
        img.unlockFocus()
        
        return img
    }
    
    @discardableResult
    func saveToDownloads(_ name: String) -> Bool {
        let folder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let url = folder.appendingPathComponent(name)

        do {
            try pngData?.write(to: url, options: .atomic)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
