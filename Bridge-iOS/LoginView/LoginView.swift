//
//  ContentView.swift
//  Crosp
//
//  Created by Joshua Koshy on 12/27/23.
//  Copyright © 2024 Joshua Koshy. All rights reserved.
//

import SwiftUI
import Firebase
import AuthenticationServices
import SafariServices

struct LoginView: View {

    // this enum is to track each field on the login page
    enum LoginDetails {
        case name
        case username
        case password
    }
    
    enum FocusedField {
        case email, password, birthday, username
    }
    
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var focusedField: LoginDetails?
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
        VStack() {
            if !userAuthManager.isUserSignedIn {
                HStack {
                    // This spacer is intentionally left blank to balance the layout
                    Spacer().frame(width: UIScreen.main.bounds.width-76
                    ) // Adjust this width to match the Help button's width
                    
                    Button(action: {
                        print("Helped Pressed")
                    }, label: {
                        Text("Help")
                            .font(Font.custom("Inter-Medium", size: 16.0))
                        
                    })
                    
                    .foregroundStyle(.inverseWhite)
                    
                    Spacer()
                }.overlay(
                    Text("Bridge at SU")
                        .font(Font.custom("Inter-Black", size: 22.0))
                        .foregroundStyle(colorScheme == .light ? .pink : .white)
                    
                        .frame(maxWidth: .infinity, alignment: .center), alignment: .center
                )
                .padding(.top, 5.0)
                
                /*
                 DatePicker(selection: $viewModel.birthDate, in: ...Date.now, displayedComponents: .date) {
                 Text("Birthday")
                 }
                 */
                
                if viewModel.loginMode {
                    if viewModel.showPasswordField {
                        Text("What's Your Password?")
                            .transition(.blurReplace)
                            .font(Font.custom("Inter-Bold", size: 18.0))
                            .padding(15.0)
                            .padding(.top, 10)
                    } else {
                        Text("What's Your Email Address?")
                            .transition(.blurReplace)
                            .font(Font.custom("Inter-Bold", size: 18.0))
                            .padding(15.0)
                            .padding(.top, 10)
                    }
                } else {
                    if viewModel.showPasswordField {
                        Text("Now Create a Password")
                            .transition(.blurReplace)
                            .font(Font.custom("Inter-Bold", size: 18.0))
                            .padding(15.0)
                            .padding(.top, 10)
                    } else {
                        Text("Hey, Let's Make an Account!")
                            .transition(.blurReplace)
                            .font(Font.custom("Inter-Bold", size: 18.0))
                            .padding(15.0)
                            .padding(.top, 10)
                    }
                }
                
                CustomTextFieldView(text: $viewModel.username, placeholder: "Email", showPasswordField: $viewModel.showPasswordField, viewModel: viewModel, secure: false, toolbarButtonText: "Next")
                    .frame(width: UIScreen.main.bounds.width - 40, height: 45) // Adjust width as needed
                    .disabled(viewModel.showPasswordField)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.inverseWhite, lineWidth: 1)
                            .padding(.horizontal)
                    ).padding(.top, 5.0)
                
                if viewModel.showPasswordField {
                    CustomTextFieldView(text: $viewModel.password, placeholder: "Password", showPasswordField: $viewModel.showPasswordField, viewModel: viewModel, secure: true, toolbarButtonText: viewModel.loginMode ? "Sign-In" : "Sign-Up")
                    
                        .transition(.opacity) // Use opacity transition
                        .frame(width: UIScreen.main.bounds.width - 40, height: 45) // Adjust width as needed
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.inverseWhite, lineWidth: 1)
                                .padding(.horizontal)
                        ).padding(.top, 20.0).onAppear(perform: {
                            viewModel.password = ""
                        })
                    
                }
                
                HStack {
                    if viewModel.showPasswordField {
                        Button(action: {
                            withAnimation {
                                viewModel.showPasswordField = false
                            }
                        }, label: {
                            Text("Wrong Email?")
                                .font(Font.custom("Inter-Bold", size: 16.0))
                                .foregroundStyle(.inverseWhite)
                                .padding(.top, 20.0)
                                .transition(.blurReplace)
                        })
                        
                        Spacer().frame(width: 10.0)
                    }
                    
                    Button(action: {
                        print("New User Pressed!")
                        withAnimation {
                            viewModel.loginMode.toggle()
                        }
                        withAnimation {
                            viewModel.showPasswordField = false
                        }
                    }, label: {
                        Text(viewModel.loginMode ? "New User?" : "Existing User?")
                            .font(Font.custom("Inter-Bold", size: 16.0))
                            .foregroundStyle(.inverseWhite)
                            .padding(.top, 20.0)
                            .transition(.blurReplace)
                    })
                }
                
                if viewModel.authFailed {
                    if !viewModel.ageOkay {
                        Text("Age is Invalid")
                        Button("Reset View State") {
                            viewModel.resetViewState()
                        }
                        .font(Font.custom("Inter-Medium", size: 16.0))
                    } else {
                        Text("Your Credentials were Invalid.\nPlease Try Again.")
                            .font(Font.custom("Inter-Medium", size: 16.0))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.red)
                            .padding(.top)
                    }
                    
                }
                if !viewModel.isSigningIn {
                    VStack {
                        /*
                         HStack {
                         Button("Log In") {
                         viewModel.login()
                         }.padding()
                         Button("Sign Up") {
                         viewModel.isSigningIn = true;
                         viewModel.createUser()
                         }.padding()
                         }
                         */
                        Spacer()
                        Text("By continuing, you agree to our Privacy Policy and Terms of Service.")
                            .font(Font.custom("Inter-Bold", size: 11.0))
                            .multilineTextAlignment(.center)
                            .font(.caption)
                            .padding()
                        
                    }
                } else if (viewModel.isSigningIn) {
                    ProgressView(value: 1)
                        .progressViewStyle(.circular)
                } else {
                    EmptyView()
                }
            } else { // if user not signed in
                
                MainView()
                    .transition(.opacity)
                
            }
            
        }
        .animation(.default, value: userAuthManager.isUserSignedIn)
        .animation(.default, value: viewModel.loginMode)
        .animation(.default, value: viewModel.showPasswordField)
        .padding()
        .onSubmit {
            switch focusedField {
            case .name:
                focusedField = .username
            case .username:
                focusedField = .password
            case .password:
                viewModel.isSigningIn = true;
                viewModel.login()
            case nil:
                print("Creating Account")
            }
        }
    }
    }
}


#Preview {
    LoginView()
}
