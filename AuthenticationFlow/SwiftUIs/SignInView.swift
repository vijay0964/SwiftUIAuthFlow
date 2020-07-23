//
//  SignInView.swift
//  AuthenticationFlow
//
//  Created by Augray on 20/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @Binding var isPresented: Bool
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            AppBackgroungView()
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        Text(Strings.SignIn)
                            .frame(maxWidth:CGFloat(300))
                            .foregroundColor(.white)
                            .font(Font.signTitle)
                        TextField(Strings.EnterUserName, text: $username, onEditingChanged: { (edit) in
                            
                        }) {
                            
                        }.modifier(SignInTextFieldModifier())
                        SecureField(Strings.EnterPassword, text: $password) {
                            
                        }.modifier(SignInTextFieldModifier())
                        Button(action: {
                            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: HomeView())
                        }) {
                            Text(Strings.SignIn).modifier(SocialButtonTextModifier())
                        }
                        .modifier(SignInButtonModifier())
                        Text(Strings.or).modifier(SocialButtonTextModifier())
                        SocialButtons(isSignIn: .constant(true))
                    }.padding()
                }
                Button(action: {
                    self.isPresented.toggle()
                }) {
                    Image.closeImage
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isPresented: .constant(true))
    }
}
