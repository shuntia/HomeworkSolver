//
//  Button.swift
//  HomeworkSolver
//
//  Created by WJR on 5/30/24.
//

import SwiftUI

struct CalculatorButton<T: ButtonStyle>: View {
  let fontSize: CGFloat = 26
  let title: String
  let style: T
  var isSpecial: Bool = false
  var isDisabled: Bool = false
  var action: () -> Void = {}
  
  @State var distance: CGFloat = 0
  
  var body: some View {
    Button(action: {
      if Config.typingAnimation {
        self.movingBackAndForth()
      }
      
      self.action()
    }, label: {
      self.build()
        .offset(x: 0, y: distance)
        .animation(.easeInOut(duration: 1))
    })
    .buttonStyle(style)
    .disabled(isDisabled)
  }
  
  func build() -> some View {
    return Group {
      if !isSpecial {
        Text(title)
          .font(.system(size: fontSize))
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
      }
      else {
        Image(systemName: title)
          .font(Font.system(size: 26, weight: .semibold))
          .foregroundStyle(.orange)
      }
    }
  }
  
  func movingBackAndForth() {
    self.distance -= 100
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
      self.distance += 100
    }
  }
}

struct Config {
  static private(set) var launchCount: Int {
    get {
      return UserDefaults.standard.integer(forKey: AppKeys.appLaunchCount)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: AppKeys.appLaunchCount)
    }
  }
  
  static func incrementLaunchCounter() {
    launchCount += 1
  }
  
  static var typingVoice: String {
    get {
      return UserDefaults.standard.string(forKey: AppKeys.typingVoice) ?? ""
    }
    set {
      UserDefaults.standard.set(newValue, forKey: AppKeys.typingVoice)
    }
  }
  
  static var typingAnimation: Bool {
    get {
      return UserDefaults.standard.bool(forKey: AppKeys.typingAnimation) // false
    }
    set {
      UserDefaults.standard.set(newValue, forKey: AppKeys.typingAnimation)
    }
  }
  
  static func setDefaultTypingVoice() {
    typingVoice = AppKeys.moCn
  }
  
  static func resetTypingAnimation() {
    typingAnimation = false
  }
}

struct AppKeys {
  static let appLaunchCount = "octoape.app.minicalc"
  static let typingVoice = "octoape.app.typing.voice"
  static let typingAnimation = "octoape.app.typing.animation"
  
  static let moCn = "mo.cn"
  static let rongDe = "rong.de"
  static let ruiCn = "rui.cn"
  static let miCn = "mi.cn"
}

struct CalculatorButtonStyle: ButtonStyle {
  let size: CGSize
  
  struct WrappedButton: View {
    let size: CGSize
    let configuration: ButtonStyle.Configuration
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var body: some View {
      let cover = RoundedRectangle(cornerRadius: size.width / 6)
      let normalColor = configuration.isPressed ? Color.white : Color.offBlack
      let btnFgColor = isEnabled ? normalColor : Color.shadowGray
      
      return configuration.label
        .padding(10)
        .contentShape(cover)
        .frame(width: size.width, height: size.height)
        .foregroundColor(btnFgColor)
        .background(
          self.buildBackgroundGroup(cover)
        )
    }
    
    func buildBackgroundGroup(_ cover: RoundedRectangle) -> some View {
      return Group {
        if configuration.isPressed {
          cover.fill(Color.offWhite)
            .overlay(
              cover.stroke(Color.gray, lineWidth: 4)
                .blur(radius: 4)
                .offset(x: 2, y: 2)
                .mask(cover.fill(LinearGradient.blackToClear))
            )
            .overlay(
              cover.stroke(Color.white, lineWidth: 8)
                .blur(radius: 4)
                .offset(x: -2, y: -2)
                .mask(cover.fill(LinearGradient.clearToBlack))
            )
        }
        else {
          cover
            .fill(Color.offWhite)
            .shadow(color: Color.white07, radius: 4, x: -2, y: -2)
            .shadow(color: Color.black02, radius: 4, x: 2, y: 2)
        }
      }
    }
  }
  
  func makeBody(configuration: Configuration) -> some View {
    WrappedButton(size: size, configuration: configuration)
  }
}

extension Color {
  static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
  static let offBlack = Color(red: 0.25, green: 0.25, blue: 0.25)
  
  static let white07 = Color.white.opacity(0.7)
  static let black02 = Color.black.opacity(0.2)
  
  static let darkGray = Color(red: 0.192, green: 0.212, blue: 0.329)
  static let shadowGray = Color(red: 0.565, green: 0.608, blue: 0.667)
  static let lightGray = Color(red: 0.812, green: 0.851, blue: 0.890)
  
  static let borderGray = Color(red: 0.592, green: 0.651, blue: 0.710)
}

extension UIColor {
  static let offWhite = UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1.0)
}

extension LinearGradient {
  init(_ colors: Color...) {
    self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
  }
  
  static let blackToClear = LinearGradient(Color.black, Color.clear)
  static let clearToBlack = LinearGradient(Color.clear, Color.black)
  
  static let horizontalDark = LinearGradient(
    gradient: Gradient(colors: [.shadowGray, .darkGray]),
    startPoint: .leading,
    endPoint: .trailing)
  
  static let diagonalDarkBorder = LinearGradient(
    gradient: Gradient(colors: [.white, .borderGray]),
    startPoint: UnitPoint(x: -0.1, y: 0.3),
    endPoint: .bottomTrailing)
}
