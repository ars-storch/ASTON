//
//  CharachtersViewController.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 13.10.2022.
//

import UIKit
import SnapKit

class CharachtersViewController: UIViewController {
    
    private var tableView: UITableView!
    private let viewModel: CharacterListViewModel
    
    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        layout()
        viewModel.fetchCharacters()
        bindViewModelEvent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Characters on this view: \(viewModel.characters.count)")
    }
    
    @objc func logOut() {
        let standardUD = UserDefaults.standard
        standardUD.set(false, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        present(loginVC, animated: true)
    }
    
    func layout() {
        view.backgroundColor = .white
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
    }

    private func bindViewModelEvent() {
        viewModel.onFetchCharactersSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onFetchCharactersFailure = { error in
            print(error.localizedDescription)
        }
    }
}

extension CharachtersViewController: UITableViewDelegate {
    
}

extension CharachtersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        let char = viewModel.characters[indexPath.row]
        cell.bindViewWith(viewModel: SingleCharDefaultViewModel(char: char))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel: EpisodeListViewModel = EpisodeListDefaultViewModel(networkService: DefaultNetworkService())
        viewModel.episodesURLS = self.viewModel.characters[indexPath.row].episodes

        let episodesVC = EpisodesViewController(viewModel: viewModel)
        episodesVC.title = "Episodes"
        show(episodesVC, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
