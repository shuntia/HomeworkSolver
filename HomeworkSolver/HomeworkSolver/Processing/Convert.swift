//
//  Convert.swift
//  HomeworkSolver
//
//  Created by WJR on 5/30/24.
//

import Foundation

func convertStringToArray(jsonString: String) -> [String]? {
  let cleanString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
  
  guard let data = cleanString.data(using: .utf8) else {
    print("Failed to convert string to data")
    return nil
  }
  
  do {
    let resultArray = try JSONDecoder().decode([String].self, from: data)
    return resultArray
  } catch {
    print("Failed to decode JSON string: \(error)")
    return nil
  }
}

func removeLeftOfEqualSign(from string: String) -> String {
  if let range = string.range(of: "=") {
    let rightOfEqualSign = string[range.upperBound...]
    return String(rightOfEqualSign)
  } else {
    return string
  }
}
