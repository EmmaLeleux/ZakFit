//
//  DietViewModel.swift
//  ZakFit
//
//  Created by Emma on 29/11/2025.
//

import Foundation
import Observation

@Observable
class DietViewModel{
    var diets: [Diet] = []
   

    
    var token: String? {
        didSet {
            if let token {
                saveToken(token)
            } else {
                clearToken()
            }
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogin), name: .didLogin, object: nil)
        self.token = loadToken()
    }

    @objc private func onLogin() {
        
        self.token = loadToken()
    }
    
    func fetchDiets(){
        guard let token,
              let url = URL(string: "http://localhost:8080/diet") else {
            print("mauvais url get scenarios")
            return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do{
                    let decodedDiets = try JSONDecoder().decode([Diet].self, from: data)
                    DispatchQueue.main.async {
                        self.diets = decodedDiets
                    }
                }
                catch {
                    print("Error decoding: \(error)")
                }
            }
            else if let error {
                print("Error: \(error)")
            }
        }
        .resume()
    }
    var diet: Diet? = nil
    func createDiet(with fields: [String: Any]){
        print("je suis dans la fonction")
        guard let token = token
        else {
            print("mauvais token")
            
            return }
        
        guard let url = URL(string: "http://localhost:8080/diet")
        else {
            print("mauvais URL")
            
            return }
        print("on va post")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: fields)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Erreur update:", error)
                return
            }
            if let data = data {
                
                            let jsonString = String(data: data, encoding: .utf8)
                            print(jsonString ?? "No JSON")

                do {
                    let newDiet = try JSONDecoder().decode(Diet.self, from: data)
                    DispatchQueue.main.async {
                        print(newDiet)
                        self.diet = newDiet
                        self.fetchDiets()
                    }
                } catch {
                    print("Erreur décodage update:", error)
                }
            }
        }.resume()
    }
    
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
    }
    
    private func loadToken() -> String? {
        
        UserDefaults.standard.string(forKey: "authToken")
    }
    
    private func clearToken() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
}
