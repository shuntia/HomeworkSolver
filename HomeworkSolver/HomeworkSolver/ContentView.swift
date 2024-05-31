//
//  ContentView.swift
//  HomeworkSolver
//
//  Created by WJR on 5/30/24.
//

import SwiftUI

struct ContentView: View {
  @State var result: String = ""
  var body: some View {
    ZStack {
      Color.offWhite.ignoresSafeArea()
      
      VStack {
        if let solutions = convertStringToArray(jsonString: result) {
          VStack {
            ForEach(solutions, id: \.self) { solution in
              Text(solution)
                .font(.system(size: 20))
                .lineLimit(1)
                .foregroundColor(.blue)
                .fontWeight(.bold)
            }
          }
        } else {
          Text(result)
        }
        CalculatorView(result: $result)
      }
    }
  }
}

#Preview {
  ContentView()
}
