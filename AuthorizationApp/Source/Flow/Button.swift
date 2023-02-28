import Foundation
import UIKit

extension UIButton {
    
    func setupButton(
        color: UIColor,
        borderColor: UIColor,
        title: String) {
            backgroundColor = color
            layer.cornerRadius = 3
            layer.borderWidth = 1.0
            layer.borderColor = borderColor.cgColor
            setTitle(title, for: .normal)
            translatesAutoresizingMaskIntoConstraints = false
        }
}
