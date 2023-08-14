import Foundation
import Swinject
import SwinjectAutoregistration
import AVKit

class HomeCoordinator {
    
    private let resolver: Resolver
    let navigationController = UINavigationController()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - Start

extension HomeCoordinator: Coordinator {
    
    var root: UIViewController {
        self.navigationController
    }
    
    func start() {
        let homeViewController = resolver ~> HomeViewController.self
        let profileViewController = resolver ~> ProfileViewController.self
        self.navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func navigate(_ route: Route) {
        switch route {
        case .fullScreen(let player):
            showFullScreen(player)
        default:
            break
        }
    }
}

// MARK: - Navigation

extension HomeCoordinator {
    
    func showFullScreen(_ player: AVPlayer) {
        player.pause()
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        navigationController.present(playerViewController, animated: true) {
            DispatchQueue.main.async {
                player.play()
            }
        }
    }
}
