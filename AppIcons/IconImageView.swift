//
//  AppIcons - IconImageView
//  Created by Tomasz Pieczykolan on 30/06/2017.
//

import AppKit

/// IconImageView is a subclass of NSImageView that allows you to set desired icon size and scale. Those values can later be read in order to generate icon.
class IconImageView: NSImageView {
    
    /// Desired size of the icon in points
    @IBInspectable var iconSize: CGFloat = 0.0
    
    /// Desired retina scale of the icon
    @IBInspectable var iconScale: Int = 1
}
