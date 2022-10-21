//
//  InfoViewController.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 13.10.2022.
//

import UIKit
import SnapKit

class EpisodesViewController: UIViewController {
    
    private var tableView: UITableView!
    private let viewModel: EpisodeListViewModel
    
    init(viewModel: EpisodeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        layOut()
        viewModel.fetchEpisodes()
        bindViewModelEvent()
    }
    
    @objc func logOut() {
        let standardUD = UserDefaults.standard
        standardUD.set(false, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        present(loginVC, animated: true)
    }
    
    
    func layOut() {
        view.backgroundColor = .white
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewModelEvent() {
        viewModel.onFetchSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onFetchFailure = { error in
            print(error)
        }
    }
}

extension EpisodesViewController: UITableViewDelegate {
    
}

extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.episodesWithOurCharacter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as! EpisodeTableViewCell
        let episode = viewModel.episodesWithOurCharacter[indexPath.row]
        cell.bindViewWith(viewModel: SingleEpisodeDefaultViewModel(episode: episode))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
