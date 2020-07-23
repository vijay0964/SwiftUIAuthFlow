//
//  SocialButtons.swift
//  AuthenticationFlow
//
//  Created by Augray on 21/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import AuthenticationServices

struct SocialButtons: View {
    @Binding var isSignIn: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 20.0) {
                AppleLoginView(isSignIn: isSignIn)
                    .modifier(SocialButtonModifier())
                FacebookLoginView(isSignIn: isSignIn)
                    .modifier(SocialButtonModifier())
                GoogleLoginView(isSignIn: isSignIn)
                    .modifier(SocialButtonModifier())
            }
        }
    }
}

struct SocialButtons_Previews: PreviewProvider {
    static var previews: some View {
        SocialButtons(isSignIn: .constant(true))
    }
}

struct FacebookLoginView: UIViewRepresentable {
    var isSignIn = false
    
    var title: String {
        return isSignIn ? LoginManager.isFacebookLoginAvailable() ? Strings.ContinueFacebook : Strings.SignInFacebook : Strings.SignUpFacebook
    }
    
    func makeCoordinator() -> FacebookLoginView.Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<FacebookLoginView>) -> UIView {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.facebookLogo?.withTintColor(.white), for: UIControl.State.normal)
        button.setTitle(title, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.buttonFont
        button.addTarget(context.coordinator, action: #selector(Coordinator.attemptFacebookLogin), for: UIControl.Event.touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)

        return button
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<FacebookLoginView>) {
        
    }
    
    class Coordinator: NSObject {
        @objc func attemptFacebookLogin() {
            LoginManager.loginFacebook { (success) in
                if success {
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: HomeView())
                }
            }
        }
    }
}

struct GoogleLoginView: UIViewRepresentable {
    
    var isSignIn = false
    
    var title: String {
        return isSignIn ? LoginManager.isGoogleLoginAvailable() ? Strings.ContinueGoogle : Strings.SignInGoogle : Strings.SignUpGoogle
    }
    
    func makeCoordinator() -> GoogleLoginView.Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<GoogleLoginView>) -> UIView {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.googleLogo?.withTintColor(.white), for: UIControl.State.normal)
        button.setTitle(title, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.buttonFont
        button.addTarget(context.coordinator, action: #selector(Coordinator.attemptLoginGoogle), for: UIControl.Event.touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)

        return button
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GoogleLoginView>) {
        
    }
    
    class Coordinator: NSObject, GIDSignInDelegate {
        @objc func attemptLoginGoogle() {
            GIDSignIn.sharedInstance()?.delegate = self
            if LoginManager.isGoogleLoginAvailable() {
                GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            } else {
                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
                GIDSignIn.sharedInstance()?.signIn()
            }
        }

        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            guard error == nil else {
                print("Google SignIn Error: \(String(describing: error))")
                return
            }
            
            print("Google User Name: \(String(describing: user.profile.name)), Email: \(String(describing: user.profile.email))")
            
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: HomeView())
        }
        
        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            print("Google SignIn Disconnected!")
        }
    }
}

struct AppleLoginView: UIViewRepresentable {
    var isSignIn = false
    
    func makeCoordinator() -> AppleLoginView.Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<AppleLoginView>) -> UIView {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.appleLogo?.withTintColor(.white), for: UIControl.State.normal)
        button.setTitle(isSignIn ? Strings.SignInApple : Strings.SignUpApple, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.buttonFont
        button.addTarget(context.coordinator, action: #selector(Coordinator.attemptLoginApple), for: UIControl.Event.touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)

        setButtonTitle(button)
        
        return button
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AppleLoginView>) {
        
    }
    
    func setButtonTitle(_ button: UIButton) {
        LoginManager.isAppleLoginAvailable { (available) in
            let title = self.isSignIn ? available ? Strings.ContinueApple : Strings.SignInApple : Strings.SignUpApple
            DispatchQueue.main.async {
                button.setTitle(title, for: UIControl.State.normal)
            }
        }
    }
    
    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        
        @objc func attemptLoginApple() {
            let apr = ASAuthorizationAppleIDProvider().createRequest()
            apr.requestedScopes = [.fullName, .email]
            
            let ac = ASAuthorizationController(authorizationRequests: [apr])
            ac.delegate = self
            ac.presentationContextProvider = self
            ac.performRequests()
        }
        
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return (UIApplication.shared.windows.last?.rootViewController?.view.window!)!
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                print("Apple Signin Credential Not Found...!")
                return
            }
            
            print("Apple SignIn Name: \(String(describing: credential.fullName)), Email: \(String(describing: credential.email))")
            
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: HomeView())
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("Apple Authorization Failed: \(error.localizedDescription)")
        }
    }
}
