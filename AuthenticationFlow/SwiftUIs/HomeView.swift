//
//  HomeView.swift
//  AuthenticationFlow
//
//  Created by Augray on 21/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            AppBackgroungView()
            Button(action: {
                LoginManager.logout()
                UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
            }) {
                Text("Logout").modifier(SocialButtonTextModifier())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
