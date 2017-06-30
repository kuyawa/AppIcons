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
        guard let selectedItem = tabView.selectedTabViewItem else { return }
        let index = tabView.indexOfTabViewItem(selectedItem)
        switch index {
        case 0:
            // MAC
            DispatchQueue.main.async { self.image016A.image = self.image.resize(  16,  16); self.image016A.image?.saveToDownloads("appicon_mac_016pts_1X.png") }
            DispatchQueue.main.async { self.image016B.image = self.image.resize(  32,  32); self.image016B.image?.saveToDownloads("appicon_mac_016pts_2X.png") }
            DispatchQueue.main.async { self.image032A.image = self.image.resize(  32,  32); self.image032A.image?.saveToDownloads("appicon_mac_032pts_1X.png") }
            DispatchQueue.main.async { self.image032B.image = self.image.resize(  64,  64); self.image032B.image?.saveToDownloads("appicon_mac_032pts_2X.png") }
            DispatchQueue.main.async { self.image128A.image = self.image.resize( 128, 128); self.image128A.image?.saveToDownloads("appicon_mac_128pts_1X.png") }
            DispatchQueue.main.async { self.image128B.image = self.image.resize( 256, 256); self.image128B.image?.saveToDownloads("appicon_mac_128pts_2X.png") }
            DispatchQueue.main.async { self.image256A.image = self.image.resize( 256, 256); self.image256A.image?.saveToDownloads("appicon_mac_256pts_1X.png") }
            DispatchQueue.main.async { self.image256B.image = self.image.resize( 512, 512); self.image256B.image?.saveToDownloads("appicon_mac_256pts_2X.png") }
            DispatchQueue.main.async { self.image512A.image = self.image.resize( 512, 512); self.image512A.image?.saveToDownloads("appicon_mac_512pts_1X.png") }
            DispatchQueue.main.async { self.image512B.image = self.image.resize(1024,1024); self.image512B.image?.saveToDownloads("appicon_mac_512pts_2X.png") }
        case 1:
            // iOS
            DispatchQueue.main.async { self.imageI01A.image = self.image.resize(  40,  40); self.image016A.image?.saveToDownloads("appicon_iphone_020pts_2X.png") }
            DispatchQueue.main.async { self.imageI01B.image = self.image.resize(  60,  60); self.image016B.image?.saveToDownloads("appicon_iphone_020pts_3X.png") }
            DispatchQueue.main.async { self.imageI02A.image = self.image.resize(  58,  58); self.image032A.image?.saveToDownloads("appicon_iphone_029pts_2X.png") }
            DispatchQueue.main.async { self.imageI02B.image = self.image.resize(  87,  87); self.image032B.image?.saveToDownloads("appicon_iphone_029pts_3X.png") }
            DispatchQueue.main.async { self.imageI03A.image = self.image.resize(  80,  80); self.image128A.image?.saveToDownloads("appicon_iphone_040pts_2X.png") }
            DispatchQueue.main.async { self.imageI03B.image = self.image.resize( 120, 120); self.image128B.image?.saveToDownloads("appicon_iphone_040pts_3X.png") }
            DispatchQueue.main.async { self.imageI04A.image = self.image.resize( 120, 120); self.image256A.image?.saveToDownloads("appicon_iphone_060pts_2X.png") }
            DispatchQueue.main.async { self.imageI04B.image = self.image.resize( 180, 180); self.image256B.image?.saveToDownloads("appicon_iphone_060pts_3X.png") }
            DispatchQueue.main.async { self.imageI05A.image = self.image.resize(  20,  20); self.image512A.image?.saveToDownloads("appicon_ipad_020pts_1X.png") }
            DispatchQueue.main.async { self.imageI05B.image = self.image.resize(  40,  40); self.image512B.image?.saveToDownloads("appicon_ipad_020pts_2X.png") }
            DispatchQueue.main.async { self.imageI06A.image = self.image.resize(  29,  29); self.image512A.image?.saveToDownloads("appicon_ipad_029pts_1X.png") }
            DispatchQueue.main.async { self.imageI06B.image = self.image.resize(  58,  58); self.image512B.image?.saveToDownloads("appicon_ipad_029pts_2X.png") }
            DispatchQueue.main.async { self.imageI07A.image = self.image.resize(  40,  40); self.image512A.image?.saveToDownloads("appicon_ipad_040pts_1X.png") }
            DispatchQueue.main.async { self.imageI07B.image = self.image.resize(  80,  80); self.image512B.image?.saveToDownloads("appicon_ipad_040pts_2X.png") }
            DispatchQueue.main.async { self.imageI08A.image = self.image.resize(  76,  76); self.image512A.image?.saveToDownloads("appicon_ipad_076pts_1X.png") }
            DispatchQueue.main.async { self.imageI08B.image = self.image.resize( 152, 152); self.image512B.image?.saveToDownloads("appicon_ipad_076pts_2X.png") }
            DispatchQueue.main.async { self.imageI09A.image = self.image.resize(  84,  84); self.image512A.image?.saveToDownloads("appicon_ipad_083pts_1X.png") }
            DispatchQueue.main.async { self.imageI09B.image = self.image.resize( 167, 167); self.image512B.image?.saveToDownloads("appicon_ipad_083pts_2X.png") }
        default:
            break
        }
        
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

// End
