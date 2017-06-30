//
//  AppIcons - Utilities
//  Created by Tomasz Pieczykolan on 30/06/2017.
//

import Foundation

enum Utilities {
    
    static func fileName(for size: Decimal, scale: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.decimalSeparator = "."
        let sizeString = formatter.string(from: size as NSNumber) ?? "nil"
        return "icon-\(sizeString)@\(scale)x.png"
    }
}
