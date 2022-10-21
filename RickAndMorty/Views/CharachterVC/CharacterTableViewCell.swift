//
//  CharechterCell.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 13.10.2022.
//

import UIKit
import SnapKit

class CharacterTableViewCell: UITableViewCell {
    
    static let identifier = "CharacterCell"
    
    var character: Character? {
        didSet {
            guard let characterItem = character else { return }
    
                characterImageView.image = UIImage(named: characterItem.name)
                nameLabel.text = characterItem.name
                statusLabel.text = characterItem.status
            
                if characterItem.gender == "Male" {
                    genderImageView.image = UIImage(named: "Male")
                } else {
                    genderImageView.image = UIImage(named: "Female")
                }
            }
    }
    
// MARK: Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let containterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
// MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(characterImageView)
        containterView.addSubview(nameLabel)
        containterView.addSubview(statusLabel)
        contentView.addSubview(containterView)
        contentView.addSubview(genderImageView)
        
        
        characterImageView.snp.makeConstraints { maker in
            maker.centerY.equalTo(contentView.snp.centerY)
            maker.leading.equalTo(contentView).offset(10)
            maker.width.equalTo(70)
            maker.height.equalTo(70)
        }
        
        containterView.snp.makeConstraints { maker in
            maker.centerY.equalTo(contentView.snp.centerY)
            maker.leading.equalTo(characterImageView.snp.trailing).offset(10)
            maker.trailing.equalTo(contentView.snp.trailing).offset(-10)
            maker.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(containterView.snp.top)
            maker.leading.equalTo(containterView.snp.leading)
            maker.trailing.equalTo(containterView.snp.trailing)
        }
        
        statusLabel.snp.makeConstraints { maker in
            maker.top.equalTo(nameLabel.snp.bottom)
            maker.leading.equalTo(containterView.snp.leading)
            maker.top.equalTo(nameLabel.snp.bottom)
        }
        
        genderImageView.snp.makeConstraints { maker in
            maker.width.equalTo(30)
            maker.height.equalTo(30)
            maker.trailing.equalTo(contentView.snp.trailing).offset(-15)
            maker.centerY.equalTo(contentView.snp.centerY)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 5, y: 5, width: 100, height: 50)
    }
    
    func bindViewWith(viewModel: SingleCharViewModel) {
        let char = viewModel.char
        
        self.nameLabel.text = char.name
        self.statusLabel.text = char.status
        
        if char.gender == "Male" {
            self.genderImageView.image = UIImage(named: "Male")
        } else {
            self.genderImageView.image = UIImage(named: "Female")
        }

        ImageClient.shared.setImage(from: char.image, placeholderImage: nil) { [weak self] image in
            self?.characterImageView.image = image
        }
        
    }

}
