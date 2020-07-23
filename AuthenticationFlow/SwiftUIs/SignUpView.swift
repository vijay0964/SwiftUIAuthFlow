//
//  SignUpView.swift
//  AuthenticationFlow
//
//  Created by Augray on 21/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isPresented: Bool
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    
    var body: some View {
        ZStack {
            AppBackgroungView()
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        Text(Strings.SignUp)
                            .frame(maxWidth:CGFloat(300))
                            .foregroundColor(.white)
                            .font(Font.signTitle)
                        TextField(Strings.EnterName, text: $name, onEditingChanged: { (edit) in
                            
                        }) {
                            
                        }.modifier(SignInTextFieldModifier())
                        TextField(Strings.EnterEmail, text: $email, onEditingChanged: { (edit) in
                            
                        }) {
                            
                        }.modifier(SignInTextFieldModifier())
                        SecureField(Strings.EnterPassword, text: $password) {
                            
                        }.modifier(SignInTextFieldModifier())
                        SecureField(Strings.EnterCPassword, text: $confirmpassword) {
                            
                        }.modifier(SignInTextFieldModifier())
                        Button(action: {
                            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: HomeView())
                        }) {
                            Text(Strings.SignUp).modifier(SocialButtonTextModifier())
                        }
                        .modifier(SignInButtonModifier())
                        Text(Strings.or).modifier(SocialButtonTextModifier())
                        SocialButtons(isSignIn: .constant(false))
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isPresented: .constant(false))
    }
}
