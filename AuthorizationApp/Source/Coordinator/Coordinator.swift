
import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var root: UIViewController { get }
    
    func start()
    
}
