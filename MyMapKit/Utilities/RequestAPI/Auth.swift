//
//  Auth.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 24/12/2020.
//

import Foundation
import UIKit

enum AuthResult {
  case success
  case failure
}

class Auth {
  static let defaultsKey = "TIL-API-KEY"
  let defaults = UserDefaults.standard

  var token: String? {
    get {
      return defaults.string(forKey: Auth.defaultsKey)
    }
    set {
      defaults.set(newValue, forKey: Auth.defaultsKey)
    }
  }
  
  func logout() {
    self.token = nil
    DispatchQueue.main.async {
      guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let rootController = UIStoryboard(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginNavigation")
      applicationDelegate.window?.rootViewController = rootController
    }
  }

  func login(username: String, password: String, completion: @escaping (AuthResult) -> Void) {
    let path = "http://\(ip)/api/users/login"
    guard let url = URL(string: path) else {
      fatalError()
    }
    guard let loginString = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() else {
      fatalError()
    }

    var loginRequest = URLRequest(url: url)
    loginRequest.addValue("Basic \(loginString)", forHTTPHeaderField: "Authorization")
    loginRequest.httpMethod = "POST"

    let dataTask = URLSession.shared.dataTask(with: loginRequest) { data, response, _ in

      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
        let jsonData = data else {
          completion(.failure)
          return
        }

        do {
          let token = try JSONDecoder()
            .decode(Token.self, from: jsonData)
          self.token = token.token
          completion(.success)
        } catch {
          completion(.failure)
        }
    }
    dataTask.resume()
  }
}
