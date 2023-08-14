import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel!
    private var tableView = UITableView()
    var playerControllerDidDismiss: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        configTableViewContraints()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateData { self.update() }
        self.playerControllerDidDismiss?()
    }
    
    func inject(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - HomeViewController

extension HomeViewController {
    
    func update() {
        tableView.reloadData()
    }
}

// MARK: - UIYableView

extension HomeViewController {
    
    func configTableViewContraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UIYableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videos.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as! HomeTableViewCell
        let model = viewModel.videos.value[indexPath.row]
        cell.update(video: model)
        cell.fullScreen { self.viewModel.playFullScreenVideo($0) }
        playerControllerDidDismiss = cell.playerControllerWasDismissed
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight: CGFloat = 250
        return cellHeight
    }
}



