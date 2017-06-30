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
        self.image = NSImage(byReferencingFile: url.path)!
        DispatchQueue.main.async { self.imageMain.image = self.image }
    }
    
    func generateImages() {
        // Resize and save
        DispatchQueue.main.async { self.image016A.image = self.image.resize(  16,  16); self.image016A.image?.saveToDownloads("appicon_016pts_1X.png") }
        DispatchQueue.main.async { self.image016B.image = self.image.resize(  32,  32); self.image016B.image?.saveToDownloads("appicon_016pts_2X.png") }
        DispatchQueue.main.async { self.image032A.image = self.image.resize(  32,  32); self.image032A.image?.saveToDownloads("appicon_032pts_1X.png") }
        DispatchQueue.main.async { self.image032B.image = self.image.resize(  64,  64); self.image032B.image?.saveToDownloads("appicon_032pts_2X.png") }
        DispatchQueue.main.async { self.image128A.image = self.image.resize( 128, 128); self.image128A.image?.saveToDownloads("appicon_128pts_1X.png") }
        DispatchQueue.main.async { self.image128B.image = self.image.resize( 256, 256); self.image128B.image?.saveToDownloads("appicon_128pts_2X.png") }
        DispatchQueue.main.async { self.image256A.image = self.image.resize( 256, 256); self.image256A.image?.saveToDownloads("appicon_256pts_1X.png") }
        DispatchQueue.main.async { self.image256B.image = self.image.resize( 512, 512); self.image256B.image?.saveToDownloads("appicon_256pts_2X.png") }
        DispatchQueue.main.async { self.image512A.image = self.image.resize( 512, 512); self.image512A.image?.saveToDownloads("appicon_512pts_1X.png") }
        DispatchQueue.main.async { self.image512B.image = self.image.resize(1024,1024); self.image512B.image?.saveToDownloads("appicon_512pts_2X.png") }
        
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
