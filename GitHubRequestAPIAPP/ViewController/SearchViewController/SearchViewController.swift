//
//  HomeViewController.swift
//  GitHubRequestAPIAPP
//
//  Created by 山口誠士 on 2022/02/10.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var backGroundView: UIView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet  private weak var iconLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    private var presenter:SearchPresenterInput?
    
    func inject(presenter:SearchPresenterInput){
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = SearchPresenter(view: self)
        inject(presenter: presenter)
        self.presenter?.loadView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushSearchButton(_ sender: Any) {
        self.presenter?.pushSearchButton(text: textField.text!)
    }
    
}

extension SearchViewController:SearchPresenterOutput{
    
    func setBackGroundViewInfo() {
        backGroundView.backgroundColor = .black
    }
    
    func setSearchButtonInfo() {
        searchButton.titleLabel?.textColor = .white
        searchButton.backgroundColor = .darkGray
        searchButton.layer.cornerRadius = 5
    }
    
    func setIconLabelInfo() {
        iconLabel.text = "GitHub"
        iconLabel.textColor = .white
        iconLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setTextFieldInfo() {
        textField.placeholder = "リポジトリ検索"
        textField.delegate = self
    }
    
    func transitionToRepositoryListsVC(text: String) {
        let RepositoryListsVC = self.storyboard?.instantiateViewController(withIdentifier: "repositoryListsVC") as! RepositoryListsViewController
        RepositoryListsVC.searchText = text
        self.navigationController?.pushViewController(RepositoryListsVC, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel,handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
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
