//
//  RepositoryCell.swift
//  GitHubRequestAPIAPP
//
//  Created by 山口誠士 on 2022/02/10.
//

import UIKit
import SDWebImage

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var iconImage: UIImageView!{
        didSet{
            iconImage.layer.cornerRadius = 5
            iconImage.contentMode = .scaleAspectFill
            iconImage.clipsToBounds = true
        }
    }
    
    @IBOutlet private weak var starIconImage: UIImageView!{
        didSet{
            starIconImage.image = UIImage(systemName: "star.fill")
        }
    }
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!{
        didSet{
            repositoryNameLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet var copyUrlButton: UIButton!
    
    func configure(repository: Repository) {
        
        ownerNameLabel.text = repository.owner.login
        repositoryNameLabel.text = repository.name
        languageLabel.text = "● \(repository.language ?? "---")"
        starCountLabel.text = "\(repository.stargazers_count)"
        repositoryDescriptionLabel.text = repository.description ?? ""
        
        if let url = URL(string: repository.owner.avatar_url){
            iconImage.sd_setImage(with: url, completed: nil)
        }else{
            iconImage.image = UIImage(named: "noImage")
        }
        
    }
}
