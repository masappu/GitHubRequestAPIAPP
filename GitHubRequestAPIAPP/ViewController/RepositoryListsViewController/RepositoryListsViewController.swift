//
//  RepositoryListsViewController.swift
//  GitHubRequestAPIAPP
//
//  Created by 山口誠士 on 2022/02/10.
//

import UIKit

class RepositoryListsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var searchText:String!
    private var presenter:RepositoryListsPresenterInput?
    private var activityIndicatorView = UIActivityIndicatorView()
    
    func inject(presenter:RepositoryListsPresenterInput){
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = RepositoryListsPresenter(view: self)
        inject(presenter: presenter)
        self.presenter?.loadView(SearchText: self.searchText)
    }
    
    @objc func pushLinkCopyButton(_ sender:UIButton){
        let cell = sender.superview?.superview?.superview as! UITableViewCell
        let indexPath = self.tableView.indexPath(for: cell)
        self.presenter?.pushLinkCopyButton(indexPath: indexPath!)
    }
    
}

extension RepositoryListsViewController:RepositoryListsPresenterOutput{
    func setTableViewInfo() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "repositoryCell")
    }
    
    func setActivityIndicatorViewInfo() {
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .lightGray
        activityIndicatorView.hidesWhenStopped = true
        
        view.addSubview(activityIndicatorView)
    }
    
    func activityIndicatorViewStartAnimating() {
        self.activityIndicatorView.startAnimating()
    }
    
    func activityIndicatorViewStopAnimating() {
        self.activityIndicatorView.stopAnimating()
    }
    
    func showErrorAndTransitionToToBackView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertOfCompletedTextCopy(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func putTextToPasteboard(text: String) {
        UIPasteboard.general.string = text
    }
}

extension RepositoryListsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.repositorise.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell") as! RepositoryCell
        let data = self.presenter?.repositorise[indexPath.row]
        cell.configure(repository: data!)
        cell.copyUrlButton.addTarget(self, action: #selector(pushLinkCopyButton(_:)), for: .touchUpInside)
        return cell
    }
}
