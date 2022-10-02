//
//  GitHubAPIModel.swift
//  GitHubRequestAPIAPP
//
//  Created by 山口誠士 on 2022/02/10.
//

import Foundation


//エラータイプを定義
enum ErrorType:Error{
    case illgalWord
    case netWorkError
    case parseError
    case noData
}

//取得データを定義
struct Repositories: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let name: String
    let html_url: String
    let language: String?
    let stargazers_count: Int
    let description: String?
    let owner: Owner
}

struct Owner: Codable {
    let avatar_url: String
    let login: String
}

final class GitHubAPIMode{

    static func fetchRepositoryData(paramerter: String, completionHandler: @escaping (Result<[Repository], ErrorType>) -> Void) {
        let urlString = "https://api.github.com/search/repositories?q=\(paramerter)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.illgalWord))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                completionHandler(.failure(.netWorkError))
                return
            }
            
            guard let safeData = data else { return }

            let decoder = JSONDecoder()
            
            do {
                let decodeData = try decoder.decode(Repositories.self, from: safeData)
                if !decodeData.items.isEmpty{
                    completionHandler(.success(decodeData.items))
                }else{
                    completionHandler(.failure(.noData))
                }
                
            } catch {
                completionHandler(.failure(.parseError))
            }
            
        }
        task.resume()
    }
    
}
