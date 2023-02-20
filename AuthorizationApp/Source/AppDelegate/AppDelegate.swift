import UIKit
import Swinject
import SwinjectAutoregistration

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var assembler: Assembler!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureDependencies()
        configureFlow()
        
        return true
    }
}

extension AppDelegate {
    func configureDependencies() {
        let serviceAssembler = Assembler([ServiceAssembly()])
        let modulesAssembler = Assembler(
            [
                AuthAssembly(),
                HomeAssembly()
            ],
            parent: serviceAssembler)
        
        assembler = Assembler(
            [FlowAssembly()],
            parent: modulesAssembler)
    }
    
    func configureFlow() {
        let window = UIWindow()
        let coordinator = assembler.resolver ~> AppCoordinator.self
        coordinator.start()
        
        self.window = window
        self.window?.rootViewController = coordinator.root
        self.window?.makeKeyAndVisible()
    }
}

