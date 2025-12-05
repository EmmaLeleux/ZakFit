//
//  ActivityViewModel.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import Foundation
import Observation

@Observable
class ActivityViewModel{
    var activitys : [Activity] = []
    
    
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
    
    
    
    func getActivity() async{
        guard let token else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/physique-activity") else {
            print("mauvais url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedMeals = try decoder.decode([Activity].self, from: data)
            
            await MainActor.run {
                let activite = decodedMeals.sorted{ $0.date.toDate() ?? Date() < $1.date.toDate() ?? Date() }
                self.activitys = activite
                
            }
        } catch {
            print("Error fetching meals: \(error)")
            if let data = try? await URLSession.shared.data(for: request).0,
               let json = String(data: data, encoding: .utf8) {
                print("Raw JSON:", json)
            }
        }
    }
    
    func fetchActivitys(date: Date){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        guard let token,
              let url = URL(string: "http://localhost:8080/physique-activity/date?date=\(dateString)") else {
            print("mauvais url")
            return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do{
                    let decodedActivity = try JSONDecoder().decode([Activity].self, from: data)
                    DispatchQueue.main.async {
                        self.activitys = decodedActivity
                        
                    }
                }
                catch {
                    print("Error decoding: \(error)")
                    if let json = String(data: data, encoding: .utf8) {
                        print("Raw JSON:", json)
                    }
                }
            }
            else if let error {
                print("Error: \(error)")
            }
        }
        .resume()
    }
    
    func createActivity(with fields: CreateActivity) async {
        guard let token = token else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/physique-activity") else {
            print("mauvais URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let mealDate = formatter.string(from: Date())
        request.httpBody = try? encoder.encode(CreateActivity(sport: fields.sport, date: mealDate, cal: fields.cal, duration: fields.duration))
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
        } catch {
            print("Erreur création activité:", error)
        }
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
