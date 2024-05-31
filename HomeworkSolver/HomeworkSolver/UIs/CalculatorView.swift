//
//  CalculatorView.swift
//  HomeworkSolver
//
//  Created by WJR on 5/30/24.
//

import SwiftUI

struct CalculatorView: View {
  @Binding var result: String
  @State var expression: String = ""
  @State var processing: Bool = false
  @State var showCameraEntry: Bool = false
  let buttons = [
    ["AC", "DEL", "ENTER"],
    ["7", "8", "9", "camera"],
    ["4", "5", "6", "*"],
    ["1", "2", "3", "-"],
    ["^", "0", "x", "+"]
  ]
  
  var body: some View {
    VStack {
      Spacer()
      if processing {
        ProgressView()
      } else {
        Text("f(x)=" + expression)
          .font(.system(size: 66))
          .lineLimit(1)
          .minimumScaleFactor(0.4)
          .foregroundColor(.orange)
          .fontWeight(.bold)
      }
      
      HStack {
        VStack {
          ForEach(0 ..< buttons.count, id: \.self) { row in
            HStack {
              ForEach(buttons[row], id: \.self) { buttonTitle in
                CalculatorButton(
                  title: buttonTitle,
                  style: CalculatorButtonStyle(size: CGSize(width: buttonTitle == "ENTER" ? 150 : 70, height: 70)),
                  isSpecial: (buttonTitle == "camera" ? true : false),
                  action: {inputFormatting(row: row, title: buttonTitle)}
                )
              }
            }
          }
        }
        .padding()
      }
    }
    .sheet(isPresented: $showCameraEntry) {
      CameraView(expression: $expression, appear: $showCameraEntry, processing: $processing)
    }
  }
}

extension CalculatorView {
  func inputFormatting(row: Int, title: String) {
    if processing == false {
      if row != 0 {
        if title != "camera" {
          expression += title
        } else {
          showCameraEntry = true
        }
      } else {
        if title == "AC" {
          expression = ""
        } else if title == "DEL" {
          expression.removeLast()
        } else {
          processing = true
          print("start processing")
          DispatchQueue.global(qos: .userInitiated).async {
            sendComputeRequest(expression: expression) { response in
              DispatchQueue.main.async {
                if let response = response {
                  result = response
                  print("Response: \(response)")
                } else {
                  print("Failed to get response")
                }
                processing = false
              }
            }
          }
        }
      }
    }
  }
}
