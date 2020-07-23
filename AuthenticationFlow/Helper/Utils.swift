//
//  Utils.swift
//  AuthenticationFlow
//
//  Created by Augray on 20/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct SignInTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(10)
            .font(Font.signField)
            .background(Color.gray.opacity(0.5))
            .foregroundColor(Color.white)
            .cornerRadius(10)
    }
}

struct SignTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(20)
            .foregroundColor(.white)
            .font(Font.buttonFont)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1))
            .background(Color.black.opacity(0.5))
    }
}

struct SignInButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.frame(maxWidth: 300)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1))
            .background(Color.black.opacity(0.5))
    }
}

struct SocialButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(10)
            .foregroundColor(.white)
            .font(Font.buttonFont)
    }
}

struct SocialButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(height: 50)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1))
            .background(Color(red: 0.5, green: 0.5, blue: 0.5).opacity(0.6))
    }
}

struct AppBackgroungView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .orange, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
        }
    }
}
