//
//  ViewController.swift
//  AppIcons
//
//  Created by Laptop on 6/29/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Cocoa
import CoreGraphics

class ViewController: NSViewController {

    var action = 0
    var image  = NSImage()
    
    @IBOutlet weak var labelType: NSTextField!
    @IBOutlet weak var imageMain: NSImageView!
    
    // MAC
    @IBOutlet weak var image016A: IconImageView!
    @IBOutlet weak var image016B: IconImageView!
    @IBOutlet weak var image032A: IconImageView!
    @IBOutlet weak var image032B: IconImageView!
    @IBOutlet weak var image128A: IconImageView!
    @IBOutlet weak var image128B: IconImageView!
    @IBOutlet weak var image256A: IconImageView!
    @IBOutlet weak var image256B: IconImageView!
    @IBOutlet weak var image512A: IconImageView!
    @IBOutlet weak var image512B: IconImageView!
    
    var imageViewsMac: [IconImageView] {
        return [
            image016A,
            image016B,
            image032A,
            image032B,
            image128A,
            image128B,
            image256A,
            image256B,
            image512A,
            image512B
        ]
    }
    

    // IOS
    @IBOutlet weak var imageI01A: IconImageView!
    @IBOutlet weak var imageI01B: IconImageView!
    @IBOutlet weak var imageI02A: IconImageView!
    @IBOutlet weak var imageI02B: IconImageView!
    @IBOutlet weak var imageI03A: IconImageView!
    @IBOutlet weak var imageI03B: IconImageView!
    @IBOutlet weak var imageI04A: IconImageView!
    @IBOutlet weak var imageI04B: IconImageView!
    @IBOutlet weak var imageI05A: IconImageView!
    @IBOutlet weak var imageI05B: IconImageView!
    @IBOutlet weak var imageI06A: IconImageView!
    @IBOutlet weak var imageI06B: IconImageView!
    @IBOutlet weak var imageI07A: IconImageView!
    @IBOutlet weak var imageI07B: IconImageView!
    @IBOutlet weak var imageI08A: IconImageView!
    @IBOutlet weak var imageI08B: IconImageView!
    @IBOutlet weak var imageI09A: IconImageView!
    @IBOutlet weak var imageI09B: IconImageView!
    
    var imageViewsiOS: [IconImageView] {
        return [
            imageI01A,
            imageI01B,
            imageI02A,
            imageI02B,
            imageI03A,
            imageI03B,
            imageI04A,
            imageI04B,
            imageI05A,
            imageI05B,
            imageI06A,
            imageI06B,
            imageI07A,
            imageI07B,
            imageI08A,
            imageI08B,
            imageI09A,
            imageI09B
        ]
    }
    
    
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
        let imageViews: [IconImageView]
        
        switch index {
        case 0:
            // MAC
            imageViews = imageViewsMac
        case 1:
            // iOS
            imageViews = imageViewsiOS
        default:
            return
        }
        
        for imageView in imageViews {
            let iconSize = imageView.iconSize
            let iconScale = imageView.iconScale
            assert(iconSize > 0.0, "iconSize cannot be equal to 0.0")
            guard let icon = image.resize(iconSize * CGFloat(iconScale), iconSize * CGFloat(iconScale)) else { continue }
            imageView.image = icon
            DispatchQueue.global().async {
                icon.saveToDownloads(Utilities.fileName(for: Decimal(floatLiteral: Double(iconSize)), scale: iconScale))
            }
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
    
    func resize(_ width: CGFloat, _ height: CGFloat) -> NSImage? {
        let imageWidth  = Int(width)
        let imageHeight = Int(height)
        let newRect = NSMakeRect(0.0, 0.0, width, height)
        guard let ctx = CGContext(data: nil, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: 8 * 3 * imageWidth, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else { return nil }
        guard let cgImage = self.cgImage(forProposedRect: nil, context: NSGraphicsContext.current(), hints: nil) else { return nil }
        ctx.draw(cgImage, in: newRect)
        guard let img = ctx.makeImage() else { return nil }
        return NSImage(cgImage: img, size: newRect.size)
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
