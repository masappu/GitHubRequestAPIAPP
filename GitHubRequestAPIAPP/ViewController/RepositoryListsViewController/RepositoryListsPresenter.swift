//
//  RepositoryListsPresenter.swift
//  GitHubRequestAPIAPP
//
//  Created by 山口誠士 on 2022/02/10.
//

import Foundation

protocol RepositoryListsPresenterInput{
    
    //画面表示用のデータ(リポジトリ検索結果)を共有
    var repositorise:[Repository] {get}
    
    //viewDidLoadのタイミングを通知する
    func loadView(SearchText:String)
    
    //pushLinkCopyButtonのタップを通知する
    func pushLinkCopyButton(indexPath:IndexPath)
    
}

protocol RepositoryListsPresenterOutput{
    
    //tableViewの設定を指示する
    func setTableViewInfo()
    
    //activityIndicatorViewの設定を指示する
    func setActivityIndicatorViewInfo()
    
    //activityIndicatorViewのstartAnimating()を指示する
    func activityIndicatorViewStartAnimating()
    
    //activityIndicatorViewのstopAnimating()を指示する
    func activityIndicatorViewStopAnimating()
    
    //Erroralert表示・全画面への遷移を指示する
    func showErrorAndTransitionToToBackView(title:String, message:String)
    
    //クリップボードへのコピーが完了alertの表示を指示
    func showAlertOfCompletedTextCopy(title:String)
    
    //tableViewのreloadを指示する。
    func reloadData()
    
    //UIPasteboardの起動を指示する
    func putTextToPasteboard(text:String)
}



final class RepositoryListsPresenter:RepositoryListsPresenterInput{
    private var view:RepositoryListsPresenterOutput
    var repositorise: [Repository] = []
    
    init(view:RepositoryListsPresenterOutput){
        self.view = view
    }
    
    func loadView(SearchText text: String) {
        self.view.setTableViewInfo()
        self.view.setActivityIndicatorViewInfo()
        
        self.view.activityIndicatorViewStartAnimating()
        GitHubAPIMode.fetchRepositoryData(paramerter: text) { result in
            switch result {
            case .success(let repositories):
                self.repositorise = repositories
                DispatchQueue.main.async {
                    self.view.activityIndicatorViewStopAnimating()
                    self.view.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.activityIndicatorViewStopAnimating()
                    switch error {
                    case .illgalWord:
                        self.view.showErrorAndTransitionToToBackView(title: "不正な文字列です。", message: "検索ワードを確認してください。")
                    case .netWorkError:
                        self.view.showErrorAndTransitionToToBackView(title: "ネットワークに接続できません。", message: "ネットワーク接続を確認してください。")
                    case .parseError:
                        self.view.showErrorAndTransitionToToBackView(title: "予期せぬエラーが発生しました。", message: "")
                    case .noData:
                        self.view.showErrorAndTransitionToToBackView(title: "検索結果がありません。", message: "検索ワードを確認してください。")
                    }
                }
            }
        }
    }
    
    func pushLinkCopyButton(indexPath: IndexPath) {
        let text = self.repositorise[indexPath.row].html_url
        self.view.putTextToPasteboard(text: text)
        self.view.showAlertOfCompletedTextCopy(title: "クリップボードにコピーしました。")
    }
}
