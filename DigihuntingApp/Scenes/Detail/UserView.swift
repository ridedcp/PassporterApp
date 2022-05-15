//
//  UserView.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 15/5/22.
//

import SwiftUI

struct UserView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var alertIsPresented = false
    let width = (UIScreen.main.bounds.size.width / UIScreen.main.scale)
    
    var body: some View {
        VStack {
            Image("passporterImage")
            GroupBox {
                Text(Constants.userBoxTitle).bold()
                TextField(Constants.usernameField, text: $username)
                SecureField(Constants.passwordField, text: $password)
                Button(action: {
                    login(user: username, pass: password)
                }) {
                    Text(Constants.loginButtonTitle)
                        .foregroundColor(.white)
                        .frame(width: width - 48)
                }
                .alert(Constants.alertTitle, isPresented: $alertIsPresented, actions: {
                    Button(Constants.alertButtonTitle, role: .cancel) {
                        print("Login Successfully!")
                    }
                })
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.green)
                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                )
            }
            .padding(.horizontal)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(height: 250)
            Spacer()
        }
    }
    
    func login(user: String, pass: String) {
        if user != "" && pass != "" {
            alertIsPresented = true
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
