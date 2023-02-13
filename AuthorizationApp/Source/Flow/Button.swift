import Foundation
import UIKit

extension UIButton {
    
    func setupButton(
        color: UIColor,
        title: String) {
            backgroundColor = color
            layer.cornerRadius = 5
            layer.borderWidth = 2
            layer.borderColor = UIColor.black.cgColor
            setTitle(title, for: .normal)
            translatesAutoresizingMaskIntoConstraints = false
        }
}
