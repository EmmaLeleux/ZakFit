//
//  LoginViewModel.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import Foundation
import Observation
import KeychainAccess

@Observable
class LoginViewModel {
    private let keychain = Keychain(service: "com.ZakFit.app")
    var token: String? {
        didSet {
                    if let token = token {
                        try? keychain.set(token, key: "authToken")
                    } else {
                        try? keychain.remove("authToken")
                    }
                }
    }
    
    var currentUser: User? {
            didSet {
                if let encoded = try? JSONEncoder().encode(currentUser) {
                    try? keychain.set(encoded, key: "currentUser")
                } else {
                    try? keychain.remove("currentUser")
                }
            }
        }
    
    var errorMessage: String? = nil
    var isAuthenticated: Bool {
            return token != nil && currentUser != nil
        }
    
    
    init() {
           
            token = try? keychain.get("authToken") ?? nil
            
            if let data = try? keychain.getData("currentUser"),
               let user = try? JSONDecoder().decode(User.self, from: data) {
                currentUser = user
            }
        }
    
    
    func login(email: String, password: String) {
        guard let url = URL(string: "http://localhost:8080/user/login") else {
            print("Mauvais URL")
            return
        }
        
        //créer le json  à envoyer
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //pas besoin d'authentification dans cette route
        
        do {
            //envoie le json
print(body)
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Erreur encodage body: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
//                    let jsonString = String(data: data, encoding: .utf8)
//                                    print(jsonString ?? "No JSON")
                    //decode la réponse de la route
                    let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.token = decoded.token
                        
                        self.currentUser = decoded.user
                        self.errorMessage = nil
                        
                        //sauvegarde le token
                        UserDefaults.standard.set(decoded.token, forKey: "authToken")
                        NotificationCenter.default.post(name: .didLogin, object: nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "identifiant ou mot de passe incorrect"
                    }
                }
            } else if let error {
                DispatchQueue.main.async {
                    self.errorMessage = "Erreur réseau: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func logout() {
            token = nil
            currentUser = nil
        }
    
    func createUser(lastname: String, firstname: String, email: String, password: String) async throws {
        guard let url = URL(string: "http://localhost:8080/user") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = Registration(
            lastname: lastname,
            firstname: firstname,
            email: email,
            password: password
        )

        if payload.email == "" || payload.lastname == "" || payload.firstname == "" || payload.password == "" {
            self.errorMessage = "Veuillez remplir tous les champs"
            return
        }else {
            if email.contains("@") == false || email.contains(".") == false {
                self.errorMessage = "Veuillez entrer un email valide"
                return
            }
        }
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(payload)

        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8) ?? "No data")

        login(email: email, password: password)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}


extension Notification.Name {
    static let didLogin = Notification.Name("didLogin")
}
