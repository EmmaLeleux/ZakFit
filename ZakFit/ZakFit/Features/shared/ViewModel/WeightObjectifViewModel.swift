//
//  WeightObjectifViewModel.swift
//  ZakFit
//
//  Created by Emma on 30/11/2025.
//

import Foundation
import Observation

@Observable
class WeightObjectifViewModel{
    var weight: WeightObjectif? = nil

    
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
    
    func fetchWeight(){
        guard let token,
              let url = URL(string: "http://localhost:8080/weight-objectif") else {
            print("mauvais url get scenarios")
            return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do{
                    let decodedWeight = try JSONDecoder().decode(WeightObjectif.self, from: data)
                    DispatchQueue.main.async {
                        self.weight = decodedWeight
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
    
    
    func createWeightObj(with fields: [String: Any]){
        print("dans la fonction")
        guard let token = token
        else {
            print("mauvais token")
            
            return }
        
        guard let url = URL(string: "http://localhost:8080/weight-objectif")
        else {
            print("mauvais URL")
            
            return }
        
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
                    let newWeight = try JSONDecoder().decode(WeightObjectif.self, from: data)
                    DispatchQueue.main.async {
                        self.weight = newWeight
                        print(self.weight)
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
