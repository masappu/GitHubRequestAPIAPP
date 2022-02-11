//
//  SearchPresenter.swift
//  GitHubRequestAPIAPP
//
//  Created by 山口誠士 on 2022/02/10.
//

import Foundation

protocol SearchPresenterInput{
    
    //viewDidLoadを通知する
    func loadView()
    
    //「検索ボタン」タップを通知する
    func pushSearchButton(text:String)
    
}

protocol SearchPresenterOutput{
    
    //backGroundViewの設定を指示する
    func setBackGroundViewInfo()
    
    //searchButtonの設定を指示する
    func setSearchButtonInfo()
    
    
    //iconLabelの設定を指示する
    func setIconLabelInfo()
    
    //textFieldの設定を指示する
    func setTextFieldInfo()
    
    //RepositoryListsViewControllerへの画面遷移を指示する
    func transitionToRepositoryListsVC(text:String)
    
    //アラート表示を指示する
    func showErrorTextIsEmpty(title: String,message: String)
    
}

final class SearchPresenter:SearchPresenterInput{
    private var view:SearchPresenterOutput
    
    init(view:SearchPresenterOutput){
        self.view = view
    }
    
    func loadView() {
  
        self.view.setBackGroundViewInfo()
        self.view.setSearchButtonInfo()
        self.view.setIconLabelInfo()
        self.view.setTextFieldInfo()
    
    }
    
    func pushSearchButton(text: String) {
    
        if !text.isEmpty{
            self.view.transitionToRepositoryListsVC(text: text)
        }else{
            let title = "検索ワードが空です。"
            let message = "検索ワードを入力してください。"
            self.view.showErrorTextIsEmpty(title: title, message: message)
        }
        
    }
}
