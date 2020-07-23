//
//  ContentView.swift
//  AuthenticationFlow
//
//  Created by Augray on 20/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var signInPresented = false
    @State var singUpPresented = false
    
    var body: some View {
        ZStack {
            AppBackgroungView()
            VStack {
                Text(Strings.AuthenticationFlow)
                    .padding(40)
                    .foregroundColor(.white)
                    .font(Font.appTitleFont)
                HStack {
                    Spacer()
                    Button(action: {
                        self.signInPresented = true
                    }) {
                        Text(Strings.SignIn).modifier(SignTextModifier())
                    }.sheet(isPresented: $signInPresented) { SignInView(isPresented: self.$signInPresented) }
                    Spacer()
                    Button(action: {
                        self.singUpPresented = true
                    }) {
                        Text(Strings.SignUp).modifier(SignTextModifier())
                    }.sheet(isPresented: $singUpPresented) { SignUpView(isPresented: self.$singUpPresented) }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
