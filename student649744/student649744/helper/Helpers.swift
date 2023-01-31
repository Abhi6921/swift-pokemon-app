//
//  Helpers.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import Foundation

extension Bundle {
    
    // fetches live data from pokeapi and decodes the json
    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping(T) -> (), failure: @escaping(Error) -> ()) {
        
        // return null if invalid url
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                if let error = error {
                    failure(error)
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                
                completion(serverData)
            } catch {
                failure(error)
            }
            
        }
        .resume()
    }
    
   
    
}

