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
    var weightObj: WeightObjectif? = nil
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
    
    func fetchWeight() async {
            guard let token,
                  let url = URL(string: "http://localhost:8080/weight-objectif") else {
                print("Mauvais URL ou token")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                // Vérifier la réponse HTTP
                if let httpResponse = response as? HTTPURLResponse {
                    print("📡 Status code:", httpResponse.statusCode)
                    
                    guard httpResponse.statusCode == 200 else {
                        print("Erreur HTTP:", httpResponse.statusCode)
                        return
                    }
                }
                
                // Décoder les données
                let decodedWeight = try JSONDecoder().decode(WeightObjectif.self, from: data)
                
          
                await MainActor.run {
                    self.weightObj = decodedWeight
                    
                }
                
            } catch {
                print("Erreur lors du fetch:", error)
                if let decodingError = error as? DecodingError {
                    print("Détails décodage:", decodingError)
                }
            }
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
                        self.weightObj = newWeight
                     
                    }
                } catch {
                    print("Erreur décodage update:", error)
                }
            }
        }.resume()
    }
    
    func deleteWeightObj(obj : WeightObjectif){
        print("dans la fonction")
        guard let token = token
        else {
            print("mauvais token")
            
            return }
        
        guard let url = URL(string: "http://localhost:8080/weight-objectif/\(obj.id)")
        else {
            print("mauvais url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("erreur:", error)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("status:", httpResponse.statusCode)
                }

                if let data = data {
                    print("réponse:", String(data: data, encoding: .utf8) ?? "vide")
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
