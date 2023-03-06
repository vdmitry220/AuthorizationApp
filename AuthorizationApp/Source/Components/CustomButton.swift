import Foundation
import UIKit

class CustomButton: UIButton {
    
    private var title: String
    private var color: UIColor
    private var borderColor: UIColor
    
    private var radius: CGFloat = 8.0
    private var borderWidth: CGFloat = 1.0
        
    init(
        title: String,
        color: UIColor,
        borderColor: UIColor) {
            
        self.title = title
        self.color = color
        self.borderColor = borderColor
            
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setTitle(title, for: .normal)
        backgroundColor = color
        layer.borderWidth = borderWidth
        layer.cornerRadius = radius
        
    }
}

// MARK: - ImageView

extension CustomButton {
    
    func setIcon(image: UIImage) {
        self.setImage(image, for: .normal)
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .trailing
    }
}

// MARK: - Animations

extension CustomButton {
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}
