//
//  HomeViewController.swift
//  GitHubRequestAPIAPP
//
//  Created by 山口誠士 on 2022/02/10.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var backGroundView: UIView!{
        didSet{
            backGroundView.backgroundColor = .black
        }
    }
    
    @IBOutlet private weak var searchButton: UIButton!{
        didSet{
            searchButton.titleLabel?.textColor = .white
            searchButton.backgroundColor = .darkGray
            searchButton.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet  private weak var iconLabel: UILabel!{
        didSet{
            iconLabel.text = "GitHub"
            iconLabel.textColor = .white
            iconLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet private weak var textField: UITextField!{
        didSet{
            textField.placeholder = "リポジトリ検索"
            textField.delegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pushSearchButton(_ sender: Any) {
    }
    
}

extension SearchViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
