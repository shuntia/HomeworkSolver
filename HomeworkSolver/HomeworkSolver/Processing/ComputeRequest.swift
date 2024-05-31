//
//  GetResult.swift
//  HomeworkSolver
//
//  Created by WJR on 5/30/24.
//

import Foundation

func sendComputeRequest(expression: String, completion: @escaping (String?) -> Void) {
  // URL for the POST request
  guard let url = URL(string: "http://34.29.161.184:5000/solving") else {
    print("Invalid URL")
    completion(nil)
    return
  }
  
  // Create a URLRequest object
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
  
  // Create the data to send in the request
  let postString = "expression=\(expression)"
  print(postString)
  request.httpBody = Data(postString.utf8)
  
  // Create a URLSession data task
  URLSession.shared.dataTask(with: request) { data, response, error in
    guard error == nil, let data = data else {
      print("Error: \(error?.localizedDescription ?? "No data")")
      completion(nil)
      return
    }
    
    let responseString = String(data: data, encoding: .utf8)
    completion(responseString)
  }.resume()
}
