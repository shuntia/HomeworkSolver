//
//  File.swift
//  HomeworkSolver
//
//  Created by WJR on 5/30/24.
//

import Foundation
import SwiftUI

func sendImageRequest(image: UIImage, completion: @escaping (String) -> Void) {
  // URL for the POST request
  guard let url = URL(string: "http://34.29.161.184:5000/recognize") else {
    print("Invalid URL")
    completion("")
    return
  }
  
  // Create a URLRequest object
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  
  // Generate boundary string
  let boundary = UUID().uuidString
  request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
  
  // Create the data to send in the request
  var body = Data()
  
  // Convert UIImage to JPEG data
  guard let imageData = image.jpegData(compressionQuality: 1.0) else {
    print("Failed to convert UIImage to JPEG data")
    completion("")
    return
  }
  
  // Append image data
  body.append("--\(boundary)\r\n".data(using: .utf8)!)
  body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
  body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
  body.append(imageData)
  body.append("\r\n".data(using: .utf8)!)
  
  body.append("--\(boundary)--\r\n".data(using: .utf8)!)
  
  request.httpBody = body
  
  // Create a URLSession data task
  URLSession.shared.dataTask(with: request) { data, response, error in
    guard error == nil, let data = data else {
      print("Error: \(error?.localizedDescription ?? "No data")")
      completion("")
      return
    }
    
    let responseString = String(data: data, encoding: .utf8)
     
    let cleanResponse = responseString?.trimmingCharacters(in: .whitespacesAndNewlines)
    let unwrappedResponse = cleanResponse?.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
     
    completion(unwrappedResponse ?? "")
  }.resume()
}
