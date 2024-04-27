//
//  UsersData.swift
//  LogIn
//
//  Created by Raspberry on 2024/4/26.
//

import Foundation

func saveUserData(_ email: String, _ password: String) {
    let defaults = UserDefaults.standard
    defaults.set(email, forKey: "email")
    defaults.set(password, forKey: "password")
}

func loadUserData() -> (email: String, password: String) {
    let defaults = UserDefaults.standard
    let email = defaults.string(forKey: "email") ?? ""
    let password = defaults.string(forKey: "password") ?? ""
    return (email, password)
}

func deleteUserData() {
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: "email")
    defaults.removeObject(forKey: "password")
}

func postUserData(_ email: String, _ password: String) {
    guard let url = URL(string: "http://120.26.205.81:9000") else { return } // http://120.26.205.81:9000 /application/x-www-form-urlencoded
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    //设置请求头
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    //设置请求体
    let parameters: [String: Any] = ["user_name": email, "user_password": password]
    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
        } else if let data = data {
            let str = String(data: data, encoding: .utf8)
            print("Received data:\n\(str ?? "")")
        }
    }
    
    task.resume()
}
