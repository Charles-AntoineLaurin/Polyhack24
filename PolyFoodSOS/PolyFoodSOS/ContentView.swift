//
//  ContentView.swift
//  PolyFoodSOS
//
//  Created by Richard Tham on 2024-02-03.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToSecondView = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("PolyFoodSOS").font(Font.system(size: 25)).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigateToSecondView = true
                    }
                }
                
            }
            .navigationDestination(isPresented: $navigateToSecondView) {
                LoginOptionView()
            }
            .padding()
        }
    }
}


struct LoginOptionView: View {
    @State private var navigateToSignIn = false
    @State private var navigateToSignUp = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to PolyFoodSOS").padding()
                HStack {
                    Button(action: {
                        navigateToSignIn = true
                    }, label: {
                        Text("Sign In")
                    }).buttonStyle(.borderedProminent)
                    Button(action: {
                        navigateToSignUp = true
                    }, label: {
                        Text("Sign Up")
                    }).buttonStyle(.borderedProminent)
                }
            }.navigationBarBackButtonHidden()
                .navigationDestination(isPresented: $navigateToSignIn) {
                    SignInView()
                }.navigationDestination(isPresented: $navigateToSignUp) {
                    SignUpView()
                }
            
            
        }
    }
}
struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack {
            TextField("Email", text: $email).padding()
            SecureField("Password", text: $password).padding()
            
            Button("Sign In", action: {})
        }.padding()
    }
}

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    var body: some View {
        VStack {
            TextField("Email", text: $email).padding()
            SecureField("Password", text: $password).padding()
            SecureField("Confirm your password", text: $confirmedPassword).padding()
            Button("Sign In", action: {
                SpoonacularService.shared.autoComplete(input: "appl")
            })
        }.padding()
    }
}

#Preview {
    ContentView()
}
