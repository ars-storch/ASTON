//
//  EpisodeTableViewCell.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    static let identifier = "EpisodeTableViewCell"
    
    var episode: Episode? {
        didSet {
            guard let episodeItem = episode else { return }
            episodeLabel.text = episodeItem.name
        }
    }
    
    var characters: [Character]? {
        didSet {
            guard let charItems = characters else { return }
            var charactersString: [String] = [""]
            for charItem in charItems {
                charactersString.append(charItem.name)
            }
            charactersLabel.text =  charactersString.joined(separator: ", ")
        }
    }
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let charactersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containterView.addSubview(episodeLabel)
//        containterView.addSubview(charactersLabel)
        contentView.addSubview(containterView)
        
        containterView.snp.makeConstraints { maker in
            maker.top.equalTo(contentView.snp.top)
            maker.leading.equalTo(contentView.snp.leading).offset(10)
            maker.trailing.equalTo(contentView.snp.trailing).offset(-20)
            maker.bottom.equalTo(contentView.snp.bottom)
            maker.height.equalTo(40)
        }
        
        episodeLabel.snp.makeConstraints { maker in
            maker.top.equalTo(containterView.snp.top)
            maker.centerY.equalTo(containterView.snp.centerY)
            maker.leading.equalTo(containterView.snp.leading)
            maker.trailing.equalTo(containterView.snp.trailing)
//            maker.bottom.equalTo(charactersLabel.snp.top)
        }
        
//        charactersLabel.snp.makeConstraints { maker in
//            maker.leading.equalTo(containterView.snp.leading)
//            maker.trailing.equalTo(containterView.snp.trailing)
//            maker.top.equalTo(episodeLabel.snp.bottom)
//            maker.bottom.equalTo(containterView.snp.bottom)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        episodeLabel.frame = CGRect(x: 5, y: 5, width: 100, height: 50)
    }
    
    func bindViewWith(viewModel: SingleEpisodeViewModel) {
        let episode = viewModel.episode
        self.episodeLabel.text = episode.name
    }
}
